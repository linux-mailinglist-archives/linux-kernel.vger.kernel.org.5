Return-Path: <linux-kernel+bounces-105092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B282587D8FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1BF1C21000
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97936FC6;
	Sat, 16 Mar 2024 05:40:14 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5223D71
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710567614; cv=none; b=u35DeBy2a8axMXQcYf+0J6Rqk6/wVB5EwzTHVKAXSf2B+8x6eg35VvbuQvsPmcq6D0DrFJgZVwFj+gbYX8ysZTDRZGGY0BX8ZcZ4q69YNPBaWdcsmuBKmLo/WB9NwVY3qgV+Fz66m8AO59TNx3XHS0qeKME31Xtum5APNE17a9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710567614; c=relaxed/simple;
	bh=LaTiPQBBFWc4R0y5WYyWx7MwoC4+R6NlJJ7qsP2RwrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gajqpWSjS7HMYFi4GrudbQb2XGjmRix/17/RFOXXBsbHfsR7I2s3oG4hA45w2lz/53ajqMRzOBy7ALCyVnX55vT8B0RVphBiGNFqcD1aFX/CI1bEnI4784njvKwREH4bbRtAkgML8CbJT8VnGS1yD3liAtF5vwtInjocGuOc0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.148])
	by sina.com (172.16.235.25) with ESMTP
	id 65F530AD00000CFF; Sat, 16 Mar 2024 13:39:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65919634210204
X-SMAIL-UIID: B12D43E2488E485693F0210D1F3E456F-20240316-133959-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
Date: Sat, 16 Mar 2024 13:39:48 +0800
Message-Id: <20240316053948.1711-1-hdanton@sina.com>
In-Reply-To: <0000000000002a81490613b2affb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/sound/core/timer.c
+++ y/sound/core/timer.c
@@ -409,8 +409,9 @@ static void snd_timer_close_locked(struc
 	struct snd_timer *timer = timeri->timer;
 
 	if (timer) {
-		guard(spinlock)(&timer->lock);
+		spin_lock_irq(&timer->lock);
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
+		spin_unlock_irq(&timer->lock);
 	}
 
 	if (!list_empty(&timeri->open_list)) {
--- x/drivers/virtio/virtio_ring.c
+++ y/drivers/virtio/virtio_ring.c
@@ -316,7 +316,13 @@ static void *vring_alloc_queue(struct vi
 		return dma_alloc_coherent(dma_dev, size,
 					  dma_handle, flag);
 	} else {
-		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
+		void *queue;
+		unsigned long sz = PAGE_ALIGN(size);
+		unsigned int order = 0;
+
+		while ((PAGE_SIZE << order) < sz)
+			order++;
+		queue = (void *) __get_free_pages(flag, order);
 
 		if (queue) {
 			phys_addr_t phys_addr = virt_to_phys(queue);
@@ -334,7 +340,7 @@ static void *vring_alloc_queue(struct vi
 			 * unrepresentable address.
 			 */
 			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
-				free_pages_exact(queue, PAGE_ALIGN(size));
+				free_pages((unsigned long) queue, order);
 				return NULL;
 			}
 		}
@@ -348,8 +354,14 @@ static void vring_free_queue(struct virt
 {
 	if (vring_use_dma_api(vdev))
 		dma_free_coherent(dma_dev, size, queue, dma_handle);
-	else
-		free_pages_exact(queue, PAGE_ALIGN(size));
+	else {
+		unsigned long sz = PAGE_ALIGN(size);
+		unsigned int order = 0;
+
+		while ((PAGE_SIZE << order) < sz)
+			order++;
+		free_pages((unsigned long) queue, order);
+	}
 }
 
 /*
--- x/mm/debug_vm_pgtable.c
+++ y/mm/debug_vm_pgtable.c
@@ -77,6 +77,7 @@ struct pgtable_debug_args {
 	pgprot_t		page_prot_none;
 
 	bool			is_contiguous_page;
+	unsigned int		ctg_order;
 	unsigned long		pud_pfn;
 	unsigned long		pmd_pfn;
 	unsigned long		pte_pfn;
@@ -1033,7 +1034,8 @@ static void __init destroy_args(struct p
 	    has_transparent_pud_hugepage() &&
 	    args->pud_pfn != ULONG_MAX) {
 		if (args->is_contiguous_page) {
-			free_contig_range(args->pud_pfn,
+			if (args->ctg_order == HPAGE_PUD_SHIFT - PAGE_SHIFT)
+				free_contig_range(args->pud_pfn,
 					  (1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)));
 		} else {
 			page = pfn_to_page(args->pud_pfn);
@@ -1049,7 +1051,8 @@ static void __init destroy_args(struct p
 	    has_transparent_hugepage() &&
 	    args->pmd_pfn != ULONG_MAX) {
 		if (args->is_contiguous_page) {
-			free_contig_range(args->pmd_pfn, (1 << HPAGE_PMD_ORDER));
+			if (args->ctg_order == HPAGE_PMD_ORDER)
+				free_contig_range(args->pmd_pfn, (1 << HPAGE_PMD_ORDER));
 		} else {
 			page = pfn_to_page(args->pmd_pfn);
 			__free_pages(page, HPAGE_PMD_ORDER);
@@ -1104,6 +1107,7 @@ debug_vm_pgtable_alloc_huge_page(struct
 					  first_online_node, NULL);
 		if (page) {
 			args->is_contiguous_page = true;
+			args->ctg_order = order;
 			return page;
 		}
 	}
--

