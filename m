Return-Path: <linux-kernel+bounces-105027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B670087D7CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E911F22508
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF61847;
	Sat, 16 Mar 2024 01:23:26 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0451373
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710552205; cv=none; b=aStNEZfT3WQd6yamfCV/QgKg+TdgzTHNmQPLyok6NwHOiKx0rsw9QSMMze6iyOsXKWkEhtkUEMLn1AeKt2yVjQUoXIamalB9pAkC2pS9tuEi0I2hK1GByaKbI72GAsGozaiBC9/yzWAEI7LeaFemyGG1DEJUib++I4OQinJRfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710552205; c=relaxed/simple;
	bh=yJpIzGjSzx4EnM6a3UH/YzVy+e80nL6JbcRYnjsgSog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOU0egRBNFAFhlm7/nZo+0e6StE/D/mYdrzSW7UOeArk8xIHJgrARYLhqIQ1Y/WgXf1o5c9O0LYgmSLtvfCGPWLtSTnV4uhTiX9vizQFmLNMFCFjZ+X3P7xdIDRIoyEGamLdC+L1uftcOJa07hWgK9PHHNt22fZd6P1ImHh3YCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.31])
	by sina.com (172.16.235.24) with ESMTP
	id 65F4F47F000043A7; Sat, 16 Mar 2024 09:23:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82308945089324
X-SMAIL-UIID: 73979B1DA2B44EBB943993FDE9E76899-20240316-092315-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
Date: Sat, 16 Mar 2024 09:23:02 +0800
Message-Id: <20240316012302.1634-1-hdanton@sina.com>
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
--

