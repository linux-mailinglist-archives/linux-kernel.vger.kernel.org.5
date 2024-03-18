Return-Path: <linux-kernel+bounces-106210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5B87EACD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5035A1C21079
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2024C3D0;
	Mon, 18 Mar 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs/Pv0kB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDD4EB46
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771719; cv=none; b=I7ByZirDYts9eOc5YQjItxbHgEyM8kuYRZ1upXFln3yjbrwXkubn2haILA78jwQXDHeXag+wpELxY7kgE7oJ0TpanMEeC05fUVDILMc6mu/NwPOWiTu1oTmUyvep4rdAOiBhXd6BQhfKMENRt4Rd1pTt5F+7340WV3FVd0vMqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771719; c=relaxed/simple;
	bh=kKbmtkNACK9BSAiwyOBKiGgmCu7fTdKkbu+kww2etOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=INSQG20ky+QkXfrfV1B170Jg0FE+JEltFKPwVnaePTqp2NEYKJy2EIKvRCKJKOvzWLnzzOl8NZC/VUh9WkGxdH53ONnt4nZC7WCBwu6RMSxZHS049zHw/hDZe2ziRKJqSbjONy011Uu/jTMCuDr83ipVhJ/tj7aG/vVcwzFMTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bs/Pv0kB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJOj3+4C3poxnpNPxWTMxrcMSQ1iTdDLFjOZc5Aa/AQ=;
	b=Bs/Pv0kB8n6Qi4Qqwtd4QDk9YOV+oAbHAkBTscKLGgDEoO1qGnOLBmkh8P63EDP3gt5pzv
	5/g8xCN1r9TYMd8wow6TwbOAdfUWZkZoy3c9VmTYdvZmq+GLgjeWpE5o4Li0sRZYbf/fP5
	vv2hkcBfTs14hElGqtQixjZK3SIxgEI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-jIm9PpjXNxK1eCnTJrVipA-1; Mon,
 18 Mar 2024 10:21:53 -0400
X-MC-Unique: jIm9PpjXNxK1eCnTJrVipA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B2A8380009C;
	Mon, 18 Mar 2024 14:21:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F74A492BD1;
	Mon, 18 Mar 2024 14:21:49 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/6] mm/mm_init.c: remove the useless dma_reserve
Date: Mon, 18 Mar 2024 22:21:33 +0800
Message-ID: <20240318142138.783350-2-bhe@redhat.com>
In-Reply-To: <20240318142138.783350-1-bhe@redhat.com>
References: <20240318142138.783350-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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

Hence, remove dma_reserve and its handling in free_area_init_core()
because it's useless and causes confusion.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/init.c |  2 --
 include/linux/mm.h |  1 -
 mm/mm_init.c       | 23 -----------------------
 3 files changed, 26 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..5209549e8192 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1032,8 +1032,6 @@ void __init memblock_find_dma_reserve(void)
 		if (start_pfn < end_pfn)
 			nr_free_pages += end_pfn - start_pfn;
 	}
-
-	set_dma_reserve(nr_pages - nr_free_pages);
 #endif
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c0910bc3e4a..1888b1935103 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3210,7 +3210,6 @@ static inline int early_pfn_to_nid(unsigned long pfn)
 extern int __meminit early_pfn_to_nid(unsigned long pfn);
 #endif
 
-extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..153fb2dc666f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -226,7 +226,6 @@ static unsigned long required_movablecore_percent __initdata;
 
 static unsigned long nr_kernel_pages __initdata;
 static unsigned long nr_all_pages __initdata;
-static unsigned long dma_reserve __initdata;
 
 static bool deferred_struct_pages __meminitdata;
 
@@ -1583,12 +1582,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 					zone_names[j], memmap_pages, freesize);
 		}
 
-		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
-		}
-
 		if (!is_highmem_idx(j))
 			nr_kernel_pages += freesize;
 		/* Charge for highmem memmap if there are enough kernel pages */
@@ -2547,22 +2540,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 	return table;
 }
 
-/**
- * set_dma_reserve - set the specified number of pages reserved in the first zone
- * @new_dma_reserve: The number of pages to mark reserved
- *
- * The per-cpu batchsize and zone watermarks are determined by managed_pages.
- * In the DMA zone, a significant percentage may be consumed by kernel image
- * and other unfreeable allocations which can skew the watermarks badly. This
- * function may optionally be used to account for unfreeable pages in the
- * first zone (e.g., ZONE_DMA). The effect will be lower watermarks and
- * smaller per-cpu batchsize.
- */
-void __init set_dma_reserve(unsigned long new_dma_reserve)
-{
-	dma_reserve = new_dma_reserve;
-}
-
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-- 
2.41.0


