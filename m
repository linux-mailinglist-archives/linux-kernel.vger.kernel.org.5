Return-Path: <linux-kernel+bounces-117312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59F88A9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEE41C2E06A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCC171E40;
	Mon, 25 Mar 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igBchiAJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803E17109A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378654; cv=none; b=i0Y4DmcQeuZw1XyDexhzY+gtpe3CaeCLLh389hbzSKXW5Vq0lj3iLxpDyjdr+IjQp/4RZA4jjeFa3E1ufJqjTlb7FTxAuWvj3QXAIBjlqA83V9sT7aQhSCTAmEaRe9l2o9z3MTlKLC3pVP8ZLHVQT6cJhWSGWA5O1DjMNUJ0xl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378654; c=relaxed/simple;
	bh=ld+G+dRUeA3SkzfHmsCiXh/ZxBicMKWgeZS/KmjXsRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=F9uhyVHbPUENRuYemg7Mr1LbC1IqorMWUURd67L/pN6TweL06aFi04cLjimnC2q7luyVltvFRtyjMbUpe9e6lJZmujjJHHuOa3DLYtVSU1hKZJ8mqqT+6RxXBiqsZLkMoSmPYzPpJX01zyNzmD1MudKb9TXPICFbrSiMOtP1FaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igBchiAJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wvoO9gMxnE/h+72mDdUoxwDkamBxujn5JY0mQMrkk8=;
	b=igBchiAJfOwg7FNMXS/2ICLJooruBhQ66oPghG333qHmo6XDk4ZDCB6dEHbcoN/df0FYtp
	eCVhbd2LVguY3ESe+RRSNkrIRouwx5A+yHNaxQ9h4nA/8APTMoxuC5zCQy3RXACEaD4DKb
	EhbDmLc9YM0mltt1NBS0RTJX+vKzDTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ioNvZiFePKuhU6aVg6cs7g-1; Mon, 25 Mar 2024 10:57:25 -0400
X-MC-Unique: ioNvZiFePKuhU6aVg6cs7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38444185A783;
	Mon, 25 Mar 2024 14:57:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E4133C22;
	Mon, 25 Mar 2024 14:57:20 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/6] mm/mm_init.c: remove the useless dma_reserve
Date: Mon, 25 Mar 2024 22:56:42 +0800
Message-ID: <20240325145646.1044760-3-bhe@redhat.com>
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

Now nobody calls set_dma_reserve() to set value for dma_reserve, remove
set_dma_reserve(), global variable dma_reserve and the codes using it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/mm.h |  1 -
 mm/mm_init.c       | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..ad19350e1538 100644
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


