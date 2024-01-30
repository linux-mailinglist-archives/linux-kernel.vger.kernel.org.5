Return-Path: <linux-kernel+bounces-44526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7C842342
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D585B1C23B45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470967A02;
	Tue, 30 Jan 2024 11:38:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEE664A2;
	Tue, 30 Jan 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614683; cv=none; b=ehF/s2V1vUEtEoADb6zrZ6W2jn2Ry/LoMyKwKb+g+kSlq3MRElqv5zIIVtyhMhkZ9hldlN16O0udLrikl2vFM9tiDPnb2O6HvWC/6dT7Fu1A0GJt6XoYgu3itR+uwNiaDAbVx94Xva+4F6jFToLncq2hHV8vpfprCynQJ85UKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614683; c=relaxed/simple;
	bh=zqm6RABGSsvRS43KAGKzzihR7za65HBbv0dnlTU9Ess=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMBwyY16rvSq5OnG4QM9WLcDQ3Qua5FNhYjzUsumr++PecWY2CIrTn+05vjSZ0+pEyhwBjhSqVevL32tUpsV+HQX59JjNr2RcW+FzAfwFMlG/DriFPU2MMMLyMojIiMHtU2XH8ISmeWqGprNTs54UnR/EHMjvT4PSxruFJCgBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TPNQx3VyMz29km6;
	Tue, 30 Jan 2024 19:36:09 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 19FB01A016B;
	Tue, 30 Jan 2024 19:37:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:37:58 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
	<linux-mm@kvack.org>
Subject: [PATCH net-next v4 1/5] mm/page_alloc: modify page_frag_alloc_align() to accept align as an argument
Date: Tue, 30 Jan 2024 19:37:06 +0800
Message-ID: <20240130113710.34511-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240130113710.34511-1-linyunsheng@huawei.com>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

napi_alloc_frag_align() and netdev_alloc_frag_align() accept
align as an argument, and they are thin wrappers around the
__napi_alloc_frag_align() and __netdev_alloc_frag_align() APIs
doing the alignment checking and align mask conversion, in order
to call page_frag_alloc_align() directly. The intention here is
to keep the alignment checking and the alignmask conversion in
in-line wrapper to avoid those kind of operations during execution
time since it can usually be handled during compile time.

We are going to use page_frag_alloc_align() in vhost_net.c, it
need the same kind of alignment checking and alignmask conversion,
so split up page_frag_alloc_align into an inline wrapper doing the
above operation, and add __page_frag_alloc_align() which is passed
with the align mask the original function expected as suggested by
Alexander.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 include/linux/gfp.h | 15 +++++++++++----
 mm/page_alloc.c     |  8 ++++----
 net/core/skbuff.c   |  6 +++---
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..28aea17fa59b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -312,14 +312,21 @@ extern void free_pages(unsigned long addr, unsigned int order);
 
 struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
-extern void *page_frag_alloc_align(struct page_frag_cache *nc,
-				   unsigned int fragsz, gfp_t gfp_mask,
-				   unsigned int align_mask);
+void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
+			      gfp_t gfp_mask, unsigned int align_mask);
+
+static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
+					  unsigned int fragsz, gfp_t gfp_mask,
+					  unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
+}
 
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 			     unsigned int fragsz, gfp_t gfp_mask)
 {
-	return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
 }
 
 extern void page_frag_free(void *addr);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..c0f7e67c4250 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4708,9 +4708,9 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *page_frag_alloc_align(struct page_frag_cache *nc,
-		      unsigned int fragsz, gfp_t gfp_mask,
-		      unsigned int align_mask)
+void *__page_frag_alloc_align(struct page_frag_cache *nc,
+			      unsigned int fragsz, gfp_t gfp_mask,
+			      unsigned int align_mask)
 {
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
@@ -4779,7 +4779,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 
 	return nc->va + offset;
 }
-EXPORT_SYMBOL(page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_alloc_align);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..bc8f3858bc1c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -297,7 +297,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
-	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
 }
 EXPORT_SYMBOL(__napi_alloc_frag_align);
 
@@ -309,13 +309,13 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
-		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
+		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
 	} else {
 		struct napi_alloc_cache *nc;
 
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache);
-		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+		data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
 		local_bh_enable();
 	}
 	return data;
-- 
2.33.0


