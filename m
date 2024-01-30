Return-Path: <linux-kernel+bounces-43747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E884188E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FD31F285C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF4381CC;
	Tue, 30 Jan 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Lwj5HmQz"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CF3770E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578946; cv=none; b=UVtxNSAnBqHTaMp6KU1GNNun0xmZj5KpQaP5H2tnYsAhojm4wA0yxhyMIKfpApNwONe/bdE3qWY3DNIYVFjp0t6puy71g4wgHbYTBY0yWo4pyvMTeDKt4id1PPDJZomz7/ThClgkESCHRIymRSn9t3sBNOW+UHWMXZQNt+Q8kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578946; c=relaxed/simple;
	bh=meDiOpiwOmc5O23emXHPLEn8CVIgwW9U83t0CK4mvi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUwhXmceSLlUgojuS9UMpYyZkFJTC3GmZ+Z4rIJzurlVM28Q01Z7h6Zum6QLCNcdhxHv7UAgNWpLtOFDIanIBZwLJqOscQ/2gwrZEXah4INmPqWSTc7Llg+40R9utQ61yQbvCMmyY1ivrCWsQUM0ogUOeDxPp4q0HPUhC3CWpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Lwj5HmQz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680b1335af6so40905566d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578943; x=1707183743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mALgLaCiaIzpkji8oSjATmvxJWj+cS9YMUqWO4u+ZHc=;
        b=Lwj5HmQzaNZV1GAT993BnYTbUhU3xPr8WSOTpH3j3s4SprsujIy1uT5omNbOtEsNz5
         Gmb6u0AoqasnDz8CGBb60mDBicPeQeZ5mGcroAFhXNe6K6ayjekIDdoRbiP4+G1SFGhP
         jiGSH0oNl0bWtEuL3aXR59hjxSAOegTbqpv1HM91+sDZUMFiv5dN67kYoLdtlePb3kWc
         V+CWO7CJ5Mn7R0iHy36csu+O14L6wFB1D5AbHMlt8o+xVLhPaoiGyPZ6NFQjNlbLnL19
         tk1tptLt/0cp+elRpyTjhMwONJuV1YldB3cJfcDjl/ZdhyVoq0fM8JMpsU6PHVZA3EsY
         Nebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578943; x=1707183743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mALgLaCiaIzpkji8oSjATmvxJWj+cS9YMUqWO4u+ZHc=;
        b=HkV2a0dxKyRGGG5GrT47NlUWOfVAf6JsNsuRdCVueUNO5bBxgNOF47ktC62Wp+PRrJ
         u6wt4HSNo2Iw0l4t+1vAJN66NA6+zCvaUgticaBaNIEdWXhk3851hkLUHWJ/qOcx0LIl
         yFxyZ8TvZcXiPUoaWUOkih4NTokh4kML/orviL05/4dHtrseOJeNDDxanDHC/7wirxsd
         HI36AB9tDoMIpI7TxSUNMs+Ad2mFTgQRGYKqlKD3skFFD0g1ZEy9xhPZAoGYopoYdGdG
         2uxbo2uyULCHrWa720Lfu9RftmVIYpl57Lc7o8ubOg4tLaklyPzaJXq3/0fldDVGTvdN
         V+dw==
X-Gm-Message-State: AOJu0Yz94PsfzjfzRVdUDgMw0VYe7qG1zd2EvildiNUyxJooyZJKla86
	5wpeGUUXMjixtPbtp3PU8TDFMMpdkIYsGEGxsXNWQADC06RrZRCiPrCdYmbcBfo=
X-Google-Smtp-Source: AGHT+IGoErOj2bpl9IZ9knv+7JV64kZmN0sJ9QZ4US8bA45j2Rdf3yjU12SQ8udCU2m6baBLuq016A==
X-Received: by 2002:ad4:5aa5:0:b0:68c:5c8a:dc7b with SMTP id u5-20020ad45aa5000000b0068c5c8adc7bmr396936qvg.13.1706578943526;
        Mon, 29 Jan 2024 17:42:23 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pc2-20020a056214488200b0068c4aefa96bsm1889828qvb.69.2024.01.29.17.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:23 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] mm: zswap: further cleanup zswap_store()
Date: Mon, 29 Jan 2024 20:36:44 -0500
Message-ID: <20240130014208.565554-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove dupentry, reusing entry works just fine.
- Rename pool to shrink_pool, as this one actually is confusing.
- Remove page, use folio_nid() and kmap_local_folio() directly.
- Set entry->swpentry in a common path.
- Move value and src to local scope of use.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f9b9494156ba..cde309c539b3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1542,14 +1542,11 @@ bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
-	struct page *page = &folio->page;
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry, *dupentry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	struct zswap_pool *pool;
-	unsigned long value;
-	u8 *src;
+	struct zswap_pool *shrink_pool;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1567,10 +1564,10 @@ bool zswap_store(struct folio *folio)
 	 * the tree, and it might be written back overriding the new data.
 	 */
 	spin_lock(&tree->lock);
-	dupentry = zswap_rb_search(&tree->rbroot, offset);
-	if (dupentry) {
+	entry = zswap_rb_search(&tree->rbroot, offset);
+	if (entry) {
+		zswap_invalidate_entry(tree, entry);
 		zswap_duplicate_entry++;
-		zswap_invalidate_entry(tree, dupentry);
 	}
 	spin_unlock(&tree->lock);
 	objcg = get_obj_cgroup_from_folio(folio);
@@ -1598,17 +1595,19 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
 		goto reject;
 	}
 
 	if (zswap_same_filled_pages_enabled) {
-		src = kmap_local_page(page);
+		unsigned long value;
+		u8 *src;
+
+		src = kmap_local_folio(folio, 0);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_local(src);
-			entry->swpentry = swp;
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1637,9 +1636,8 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-	entry->swpentry = swp;
-
 insert_entry:
+	entry->swpentry = swp;
 	entry->objcg = objcg;
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
@@ -1684,9 +1682,9 @@ bool zswap_store(struct folio *folio)
 	return false;
 
 shrink:
-	pool = zswap_pool_last_get();
-	if (pool && !queue_work(shrink_wq, &pool->shrink_work))
-		zswap_pool_put(pool);
+	shrink_pool = zswap_pool_last_get();
+	if (shrink_pool && !queue_work(shrink_wq, &shrink_pool->shrink_work))
+		zswap_pool_put(shrink_pool);
 	goto reject;
 }
 
-- 
2.43.0


