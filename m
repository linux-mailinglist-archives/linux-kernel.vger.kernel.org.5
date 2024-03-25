Return-Path: <linux-kernel+bounces-117311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C792488A9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CD11F3BBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CE171079;
	Mon, 25 Mar 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuXen+Ps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589813249F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378647; cv=none; b=nC+D+QSi532VIZ/dSFzTdShcCj9SD3JQmoqqIXHOkit8p609MYbAiTNtqoUjvLHmpxIE3iKBnYIypvz31CKAYRLjegkeMpNadg80uj1ezreno5nJZCUPNQGWg88Z4f7ZtYVhIs1WBHhAkTd2cMst5Fj2SvvCeSXhEhUFNnYZMbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378647; c=relaxed/simple;
	bh=SycBorrp3rfm4WQbIzBTwlk4mG+Hl+TwKyQZyRpVuRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=dmgXfqH2mJtM94mfi4G21rMmFBz4CEOaXLw1Gohvrx7pRISxq4sgvTkl4HCv386boOzQridH00BVBk8gs7TamyUlDDH3Jlhy0CC/vw2soEE2dQWNnE7tdJVZu7zLReVR2PamBMK8eOIv59dTK+PVmNT1UDWPizEWlsFB/tMmb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuXen+Ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c4yPtzG9SnjpO3Ux0abr18tbqf9XDz5JHpLVv3vCHY=;
	b=IuXen+Ps+82pqkmdcS51jd72Eel/JLa2CfMGp2BJw7gqX6Epv3H4u4dAZMhZXG2KehBF7I
	n1VyvI+7RVDuqZ7f7XolRyFpj3Z3TXT6IHaLSmdkY0j9sZUC+cfDXOY5xc3lI9+vctdcY2
	8py+gE9359dVLZukczhX8z6/uvAez2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-_uq44HFeMq6xtpdXzT6_XA-1; Mon, 25 Mar 2024 10:57:20 -0400
X-MC-Unique: _uq44HFeMq6xtpdXzT6_XA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACF061869C65;
	Mon, 25 Mar 2024 14:57:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30A953C20;
	Mon, 25 Mar 2024 14:57:15 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/6] x86: remove unneeded memblock_find_dma_reserve()
Date: Mon, 25 Mar 2024 22:56:41 +0800
Message-ID: <20240325145646.1044760-2-bhe@redhat.com>
In-Reply-To: <20240325145646.1044760-1-bhe@redhat.com>
References: <20240325145646.1044760-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Variable dma_reserve and its usage was introduced in commit 0e0b864e069c
("[PATCH] Account for memmap and optionally the kernel image as holes").
Its original purpose was to accounting for the reserved pages in DMA
zone to make DMA zone's watermarks calculation more accurate on x86.

However, currently there's zone->managed_pages to account for all
available pages for buddy, zone->present_pages to account for all
present physical pages in zone. What is more important, on x86,
calculating and setting the zone->managed_pages is a temporary move,
all zone's managed_pages will be zeroed out and reset to the actual
value according to how many pages are added to buddy allocator in
mem_init(). Before mem_init(), no buddy alloction is requested. And
zone's pcp and watermark setting are all done after mem_init(). So,
no need to worry about the DMA zone's setting accuracy during
free_area_init().

Hence, remove memblock_find_dma_reserve() to stop calculating and
setting dma_reserve.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/pgtable.h |  1 -
 arch/x86/kernel/setup.c        |  2 --
 arch/x86/mm/init.c             | 47 ----------------------------------
 3 files changed, 50 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 315535ffb258..cefc7a84f7a4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1200,7 +1200,6 @@ static inline int pgd_none(pgd_t pgd)
 extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
-extern void memblock_find_dma_reserve(void);
 void __init poking_init(void);
 unsigned long init_memory_mapping(unsigned long start,
 				  unsigned long end, pgprot_t prot);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ef206500ed6f..74873bd04ad1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1106,8 +1106,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	arch_reserve_crashkernel();
 
-	memblock_find_dma_reserve();
-
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..615f0bf4bda6 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -990,53 +990,6 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-/*
- * Calculate the precise size of the DMA zone (first 16 MB of RAM),
- * and pass it to the MM layer - to help it set zone watermarks more
- * accurately.
- *
- * Done on 64-bit systems only for the time being, although 32-bit systems
- * might benefit from this as well.
- */
-void __init memblock_find_dma_reserve(void)
-{
-#ifdef CONFIG_X86_64
-	u64 nr_pages = 0, nr_free_pages = 0;
-	unsigned long start_pfn, end_pfn;
-	phys_addr_t start_addr, end_addr;
-	int i;
-	u64 u;
-
-	/*
-	 * Iterate over all memory ranges (free and reserved ones alike),
-	 * to calculate the total number of pages in the first 16 MB of RAM:
-	 */
-	nr_pages = 0;
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
-		start_pfn = min(start_pfn, MAX_DMA_PFN);
-		end_pfn   = min(end_pfn,   MAX_DMA_PFN);
-
-		nr_pages += end_pfn - start_pfn;
-	}
-
-	/*
-	 * Iterate over free memory ranges to calculate the number of free
-	 * pages in the DMA zone, while not counting potential partial
-	 * pages at the beginning or the end of the range:
-	 */
-	nr_free_pages = 0;
-	for_each_free_mem_range(u, NUMA_NO_NODE, MEMBLOCK_NONE, &start_addr, &end_addr, NULL) {
-		start_pfn = min_t(unsigned long, PFN_UP(start_addr), MAX_DMA_PFN);
-		end_pfn   = min_t(unsigned long, PFN_DOWN(end_addr), MAX_DMA_PFN);
-
-		if (start_pfn < end_pfn)
-			nr_free_pages += end_pfn - start_pfn;
-	}
-
-	set_dma_reserve(nr_pages - nr_free_pages);
-#endif
-}
-
 void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-- 
2.41.0


