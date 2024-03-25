Return-Path: <linux-kernel+bounces-118192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF088B598
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798F01F3E753
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985A1292FD;
	Mon, 25 Mar 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TudUSqTT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB07128385
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410637; cv=none; b=oepVklFrY9RLZg7hYKU2mMWJlHYq4Dnk7H+QbDVs6VacK1r9SR7NT0i5/+LgdwOsNZ/jWIR9UZSXDqG7/6yEukOIDYdWLaifw7TLLYjyqSty+5eH3MB294Kgv3kWseDfYp3XTsVM7Id+K1FvHp9nE2ssohYD9PnfHUP4FnMpaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410637; c=relaxed/simple;
	bh=HaCYxlLo5Ti9rOUslx2RmaiaM++bpDdpyJNIYANfmM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJb9ST65An1/Fe0Q5nlvcIPQNq4/SIeSpx6V3w40sTGtZuufGMuuuDjCOjKFJThR9A+7SOWnC5eBnHbTKDSHC6Y0Mag/HTwhpny72qSZoilSD4Z/MGS5evWUBbwT+/c+4N8OeZ1RB/23F25xipinCblO/sw/942QMFPkzsAGYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TudUSqTT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso7910231276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410635; x=1712015435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6nu3U2cdQmEtB2lnDGjl91RMjz6aut26G90+PFcykM=;
        b=TudUSqTTCYWiq6Hp4pPry0jpH57iwRaupU7wQ7+OXsX54smOoGhEoRLnVB3gsYmuZZ
         g9Er7znFYlP8kpMuV3LU9BgsLFTQKpeFrn74y4dVnh3HyGy+5Du+LSZkPtEhvv+yuBgu
         zuhZT9rg3iWvSLj7448OFTVjwCHV8BnH85qN8TA/XfXizFbQnjW70HgwW/icFJU4mCZn
         j7fc6pPSCmPT/ZklBm3SHTudfqL7thT+4VqYzeEaX3yDhieXv1DsUUgkaPzGyUYOeG80
         HRtXtDTu80mkp2jLBUhE0PxByQzBEWQKgqn/lwTSr56mJofP3v/qivjqme0zBS9AC/5Q
         Gccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410635; x=1712015435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6nu3U2cdQmEtB2lnDGjl91RMjz6aut26G90+PFcykM=;
        b=TQj0a/Xj6eRWThA7JSfRDIPFHt9zqHJoR+t6n4RmO5k6+0m4thKYnvqJn9yONmLr1P
         9LcKBOUOPB5lhrRI9m9zGDpCuf91aZsulcZRnkerr1BN0voZMHYcg1cDM36WlR2jBr2E
         C3ftUdb84+UE0HzIpIh4idUvoxsUyFcS4RP3rTK81MXJ9qcB0uGaWWwUZGwFQRnrC5fe
         bgYfNPYkXpWZrbvKLufLxW/5eTyaTbVYgO7d83lH2fEAUAIRO2SRKfzaHFioVHc8+fRR
         2kHYyAs9BpfcpRGAaX1tTwgCs2MRqBcqJ4S4zdAixEUzHKM7nmqSFDV0cKSAsWu2eRON
         +WqA==
X-Forwarded-Encrypted: i=1; AJvYcCWigM1u17HI8Z4jbUFMRQv1jwq4dnDSy0dv18XivrZaLaA55Jk3P2+oYKDBx179dyZPjeEhejWhQBfu3wmHddwlhW/9I9PvBw0kamTl
X-Gm-Message-State: AOJu0Yw3V9BD1huodnxgAQ+7/DpnbC/o5OGsPBZcCoQF9fwthDUcu+oV
	B+9hZrFm+GsOqVppuYTUpIvmN3ckiIWP4Osx/WNVg29ftBWfrqCn9IiseCy/NyaR177sX1IERFh
	0u7tkr60BfInG44VGdA==
X-Google-Smtp-Source: AGHT+IHhwuSMeZ8KbkpdVbgoG6k+kjBoalv5THVzyluQgGq+kifTjQF/ACTCwAHFlLZp6s7t/niB6q7ZIp/Hk5oK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:218d:b0:dda:c565:1025 with
 SMTP id dl13-20020a056902218d00b00ddac5651025mr317614ybb.2.1711410635103;
 Mon, 25 Mar 2024 16:50:35 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:17 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-10-yosryahmed@google.com>
Subject: [RFC PATCH 9/9] mm: zswap: use zswap_entry_free() for partially
 initialized entries
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

zswap_entry_free() performs four types of cleanups before freeing a
zswap_entry:
- Deletes the entry from the LRU.
- Frees compressed memory.
- Puts the pool reference.
- Uncharges the compressed memory and puts the objcg.

zswap_entry_free() always expects a fully initialized entry. Allow
zswap_entry_free() to handle partially initialized entries by making it
possible to identify what cleanups are needed as follows:
- Allocate entries with __GFP_ZERO and initialize zswap_entry.lru when
  the entry is allocated. Points are NULL and length is zero upon
  initialization.
- Use zswap_entry.length to identify if there is compressed memory to
  free. This is possible now that zero-filled pages are handled
  separately, so a length of zero means we did not successfully compress
  the page.
- Only initialize entry->objcg after the memory is charged in
  zswap_store().

With this in place, use zswap_entry_free() in the failure path of
zswap_store() to cleanup partially initialized entries. This simplifies
the cleanup code in zswap_store(). While we are at it, rename the
remaining cleanup labels to more meaningful names.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 62 ++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9357328d940af..c50f9df230ca3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -774,12 +774,13 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 **********************************/
 static struct kmem_cache *zswap_entry_cache;
 
-static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
+static struct zswap_entry *zswap_entry_cache_alloc(int nid)
 {
 	struct zswap_entry *entry;
-	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
-	if (!entry)
-		return NULL;
+	entry = kmem_cache_alloc_node(zswap_entry_cache,
+				      GFP_KERNEL | __GFP_ZERO, nid);
+	if (entry)
+		INIT_LIST_HEAD(&entry->lru);
 	return entry;
 }
 
@@ -795,9 +796,12 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 
 static void zswap_entry_free(struct zswap_entry *entry)
 {
-	zswap_lru_del(&zswap_list_lru, entry);
-	zpool_free(zswap_find_zpool(entry), entry->handle);
-	zswap_pool_put(entry->pool);
+	if (!list_empty(&entry->lru))
+		zswap_lru_del(&zswap_list_lru, entry);
+	if (entry->length)
+		zpool_free(zswap_find_zpool(entry), entry->handle);
+	if (entry->pool)
+		zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
@@ -1447,7 +1451,7 @@ bool zswap_store(struct folio *folio)
 		return false;
 
 	if (!zswap_enabled)
-		goto check_old;
+		goto erase_old;
 
 	/* Check cgroup limits */
 	objcg = get_obj_cgroup_from_folio(folio);
@@ -1455,54 +1459,52 @@ bool zswap_store(struct folio *folio)
 		memcg = get_mem_cgroup_from_objcg(objcg);
 		if (shrink_memcg(memcg)) {
 			mem_cgroup_put(memcg);
-			goto reject;
+			goto put_objcg;
 		}
 		mem_cgroup_put(memcg);
 	}
 
 	if (zswap_is_folio_zero_filled(folio)) {
 		if (zswap_store_zero_filled(tree, offset, objcg))
-			goto reject;
+			goto put_objcg;
 		goto stored;
 	}
 
 	if (!zswap_non_zero_filled_pages_enabled)
-		goto reject;
+		goto put_objcg;
 
 	if (!zswap_check_limit())
-		goto reject;
+		goto put_objcg;
 
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
+	entry = zswap_entry_cache_alloc(folio_nid(folio));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
-		goto reject;
+		goto put_objcg;
 	}
 
-	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
-		goto freepage;
+		goto free_entry;
 
 	if (objcg) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
 		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
 			mem_cgroup_put(memcg);
-			goto put_pool;
+			goto free_entry;
 		}
 		mem_cgroup_put(memcg);
 	}
 
 	if (!zswap_compress(folio, entry))
-		goto put_pool;
-
-	entry->swpentry = swp;
-	entry->objcg = objcg;
+		goto free_entry;
 
 	if (zswap_tree_store(tree, offset, entry))
-		goto store_failed;
+		goto free_entry;
 
-	if (objcg)
+	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
+		entry->objcg = objcg;
+	}
 
 	/*
 	 * We finish initializing the entry while it's already in xarray.
@@ -1514,7 +1516,7 @@ bool zswap_store(struct folio *folio)
 	 *    The publishing order matters to prevent writeback from seeing
 	 *    an incoherent entry.
 	 */
-	INIT_LIST_HEAD(&entry->lru);
+	entry->swpentry = swp;
 	zswap_lru_add(&zswap_list_lru, entry);
 
 stored:
@@ -1525,17 +1527,13 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
-store_failed:
-	zpool_free(zswap_find_zpool(entry), entry->handle);
-put_pool:
-	zswap_pool_put(entry->pool);
-freepage:
-	zswap_entry_cache_free(entry);
-reject:
+free_entry:
+	zswap_entry_free(entry);
+put_objcg:
 	obj_cgroup_put(objcg);
 	if (zswap_pool_reached_full)
 		queue_work(shrink_wq, &zswap_shrink_work);
-check_old:
+erase_old:
 	/*
 	 * If the zswap store fails or zswap is disabled, we must invalidate the
 	 * possibly stale entry which was previously stored at this offset.
-- 
2.44.0.396.g6e790dbe36-goog


