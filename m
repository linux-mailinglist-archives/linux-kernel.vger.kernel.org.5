Return-Path: <linux-kernel+bounces-43758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C0684189B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CFEB2428E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC4159592;
	Tue, 30 Jan 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pItiNqAP"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3566F074
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578959; cv=none; b=uH1aL6qrMIGpW6y/L6CMiKTZ+aV3hYi3ohVTkKmoRtML+HCrUhD7YHgBMsB1qViJj/JOt7BF/z83p0O1bZzHjH+dLiRT76wl+Y43DIi2OtjtUg3GA8zt1lXXZtev9mvhQtRbcpDpx8imuqtL6t7eVOjnT/d/sNSvjOnfpZ9D3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578959; c=relaxed/simple;
	bh=THpur6kVnyXr5u+tiyxAdLgZj7BGAETob5/AxR3iXb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=povsYM4ILWswB3bBm+QcG9S0TYkfnamxjxBSb5YWyU8tHFF7//kOu/wLNaoJ/Cf+hVG4RNY03p9jLRdB4tW7+Bd9qboKghiIkloAkUcv8cF3hLbFH3VHXjsDmAzZP8kOx/oWsH1k0uQe5KCT2JVrUihNlZq3sCg0tPiOYabJ4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pItiNqAP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c4fb9e7e0so11623886d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578957; x=1707183757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nthkOb34nC29m9Z7rdKEYXbNdpH1xuatn2MKs2M9M7s=;
        b=pItiNqAPDkTa03gPDOfnaXjMwOlLItkgSc7zNj4udIULGVH7fUgJV40inMJzQR42Xf
         sDGs6Duey3u0u8S5fnN0Ys0A6hDHRGnByZ6pzp5V7PvYc9MPEYjEuxjDu3kFcZkaSKsk
         LKt/1ttK9T/BioOL/mq/uTQwOf+qac8lYylXuFLR5ae/55vowcxx68u/2SNqqdVcHrAH
         +QoWxsOzOnFnNBkvbujJU1XX9vN4iKHoReSxBKCtvu8j0zikaLGuDbMMV453BfG2OKYo
         A7CqZsevxxzLkycQA4acQUco3KA/mw09SDRLXpZgyG5n6+98ipOXBwkhowDXkcPTUJOS
         qS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578957; x=1707183757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nthkOb34nC29m9Z7rdKEYXbNdpH1xuatn2MKs2M9M7s=;
        b=T09EtHAX46ulRX2X013O0RcmkZN/vEA2TzVX/YzTyIkwR7uUDFAsH+J6lgocCsCMWW
         vyNDaSMFxKMPOqijAaTg3p/g48LWGSlAygB2maEi95IiWI1b8jctnCpqPpePQYQgOtDG
         pPdXHIrQo/cLyeR4SUSoPooGTIUUrMRYBHg1JJ8qgUdBDpLhrf+OlTao8GshIXl33FQB
         +8lyJvrIqivIEJXHUnZRUuV/B9klcvZVjLXv8/uY1WUbeHZUD54IP20jLbaHEng/aa7S
         X1GFXeFxbjKi73AzHdANAFNXgUrW/a2OQxLzx74x4WKdOgzYIAO63l6Dze9yNVEu6qFK
         OnHA==
X-Gm-Message-State: AOJu0YwPWjBhFjxuJAqzArPpBsmzZFjSX8KQa+9Vr8W7GUYAUNheRHC7
	ZDZJUjhxj5gCUQD7+lIzUV7NrTUMJZxhlmnAH/mt28Yxx0e+Un3QrdIGtasBI9WfIqtXVIQAVyz
	o
X-Google-Smtp-Source: AGHT+IGTKeUUuo7KoC1RLq1MuNgQsEnaX6DaZ/35944su1CBVjphvILdr8AWGuYvZXd46VFaBb9AjQ==
X-Received: by 2002:a05:6214:c68:b0:68c:498e:d09f with SMTP id t8-20020a0562140c6800b0068c498ed09fmr4765609qvj.54.1706578956903;
        Mon, 29 Jan 2024 17:42:36 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cc3d0000000b00686ac3226ccsm3935915qvi.114.2024.01.29.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:36 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] mm: zswap: function ordering: writeback
Date: Mon, 29 Jan 2024 20:36:55 -0500
Message-ID: <20240130014208.565554-20-hannes@cmpxchg.org>
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

Shrinking needs writeback. Naturally, move the writeback code above
the shrinking code. Delete the forward decl.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 183 ++++++++++++++++++++++++++---------------------------
 1 file changed, 90 insertions(+), 93 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index acd7dcd1e0f2..0cb3437d47eb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -276,9 +276,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
 
-static int zswap_writeback_entry(struct zswap_entry *entry,
-				 swp_entry_t swpentry);
-
 static bool zswap_is_full(void)
 {
 	return totalram_pages() * zswap_max_pool_percent / 100 <
@@ -1163,6 +1160,96 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
+/*********************************
+* writeback code
+**********************************/
+/*
+ * Attempts to free an entry by adding a folio to the swap cache,
+ * decompressing the entry data into the folio, and issuing a
+ * bio write to write the folio back to the swap device.
+ *
+ * This can be thought of as a "resumed writeback" of the folio
+ * to the swap device.  We are basically resuming the same swap
+ * writeback path that was intercepted with the zswap_store()
+ * in the first place.  After the folio has been decompressed into
+ * the swap cache, the compressed version stored by zswap can be
+ * freed.
+ */
+static int zswap_writeback_entry(struct zswap_entry *entry,
+				 swp_entry_t swpentry)
+{
+	struct zswap_tree *tree;
+	struct folio *folio;
+	struct mempolicy *mpol;
+	bool folio_was_allocated;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_NONE,
+	};
+
+	/* try to allocate swap cache folio */
+	mpol = get_task_policy(current);
+	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
+				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+	if (!folio)
+		return -ENOMEM;
+
+	/*
+	 * Found an existing folio, we raced with swapin or concurrent
+	 * shrinker. We generally writeback cold folios from zswap, and
+	 * swapin means the folio just became hot, so skip this folio.
+	 * For unlikely concurrent shrinker case, it will be unlinked
+	 * and freed when invalidated by the concurrent shrinker anyway.
+	 */
+	if (!folio_was_allocated) {
+		folio_put(folio);
+		return -EEXIST;
+	}
+
+	/*
+	 * folio is locked, and the swapcache is now secured against
+	 * concurrent swapping to and from the slot. Verify that the
+	 * swap entry hasn't been invalidated and recycled behind our
+	 * backs (our zswap_entry reference doesn't prevent that), to
+	 * avoid overwriting a new swap folio with old compressed data.
+	 */
+	tree = swap_zswap_tree(swpentry);
+	spin_lock(&tree->lock);
+	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
+		spin_unlock(&tree->lock);
+		delete_from_swap_cache(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+		return -ENOMEM;
+	}
+
+	/* Safe to deref entry after the entry is verified above. */
+	zswap_entry_get(entry);
+	spin_unlock(&tree->lock);
+
+	zswap_decompress(entry, &folio->page);
+
+	count_vm_event(ZSWPWB);
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWPWB);
+
+	spin_lock(&tree->lock);
+	zswap_invalidate_entry(tree, entry);
+	zswap_entry_put(entry);
+	spin_unlock(&tree->lock);
+
+	/* folio is up to date */
+	folio_mark_uptodate(folio);
+
+	/* move it to the tail of the inactive list after end_writeback */
+	folio_set_reclaim(folio);
+
+	/* start writeback */
+	__swap_writepage(folio, &wbc);
+	folio_put(folio);
+
+	return 0;
+}
+
 /*********************************
 * shrinker functions
 **********************************/
@@ -1419,96 +1506,6 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
-/*********************************
-* writeback code
-**********************************/
-/*
- * Attempts to free an entry by adding a folio to the swap cache,
- * decompressing the entry data into the folio, and issuing a
- * bio write to write the folio back to the swap device.
- *
- * This can be thought of as a "resumed writeback" of the folio
- * to the swap device.  We are basically resuming the same swap
- * writeback path that was intercepted with the zswap_store()
- * in the first place.  After the folio has been decompressed into
- * the swap cache, the compressed version stored by zswap can be
- * freed.
- */
-static int zswap_writeback_entry(struct zswap_entry *entry,
-				 swp_entry_t swpentry)
-{
-	struct zswap_tree *tree;
-	struct folio *folio;
-	struct mempolicy *mpol;
-	bool folio_was_allocated;
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_NONE,
-	};
-
-	/* try to allocate swap cache folio */
-	mpol = get_task_policy(current);
-	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
-	if (!folio)
-		return -ENOMEM;
-
-	/*
-	 * Found an existing folio, we raced with swapin or concurrent
-	 * shrinker. We generally writeback cold folios from zswap, and
-	 * swapin means the folio just became hot, so skip this folio.
-	 * For unlikely concurrent shrinker case, it will be unlinked
-	 * and freed when invalidated by the concurrent shrinker anyway.
-	 */
-	if (!folio_was_allocated) {
-		folio_put(folio);
-		return -EEXIST;
-	}
-
-	/*
-	 * folio is locked, and the swapcache is now secured against
-	 * concurrent swapping to and from the slot. Verify that the
-	 * swap entry hasn't been invalidated and recycled behind our
-	 * backs (our zswap_entry reference doesn't prevent that), to
-	 * avoid overwriting a new swap folio with old compressed data.
-	 */
-	tree = swap_zswap_tree(swpentry);
-	spin_lock(&tree->lock);
-	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
-		spin_unlock(&tree->lock);
-		delete_from_swap_cache(folio);
-		folio_unlock(folio);
-		folio_put(folio);
-		return -ENOMEM;
-	}
-
-	/* Safe to deref entry after the entry is verified above. */
-	zswap_entry_get(entry);
-	spin_unlock(&tree->lock);
-
-	zswap_decompress(entry, &folio->page);
-
-	count_vm_event(ZSWPWB);
-	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPWB);
-
-	spin_lock(&tree->lock);
-	zswap_invalidate_entry(tree, entry);
-	zswap_entry_put(entry);
-	spin_unlock(&tree->lock);
-
-	/* folio is up to date */
-	folio_mark_uptodate(folio);
-
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
-
-	/* start writeback */
-	__swap_writepage(folio, &wbc);
-	folio_put(folio);
-
-	return 0;
-}
-
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
 {
 	unsigned long *page;
-- 
2.43.0


