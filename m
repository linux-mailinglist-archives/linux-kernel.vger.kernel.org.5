Return-Path: <linux-kernel+bounces-43759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9AE84189C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BA328703C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3315A49B;
	Tue, 30 Jan 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="e2lXP/hr"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28395151CE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578960; cv=none; b=Fncrv29lSG8J/6oenEBpDPQQjhOiJCFtzndRvDsDQz+5QpESCvi7WTQlQlFiPovkwBhDhSfDyY1pZv00StlYEgglx8Cu4cfq+Ew6v2eyDIq+2nVFwa9a7Qqbj8fOMsj2CjfQEJxhxNpc4NjHXXCwLMJROsLff2TBhNUXC+MxYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578960; c=relaxed/simple;
	bh=cnPSFO5BO6ITGOvn3tMGN0G1eY3jniMhH/tSuYdVq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtKUXd/L6X7EMe9fhgZguJlMIq1ZYsf7R/+AKuKUDX1PqbonCW9Z2IQxHUogpJ/Kz3fq0pY48QISAuTKkxJOhTdtkhP0Qhm94yyg05TXHiEJc4be1IYbPyYx/iXXAtnbfXrE2PXCPbixMTTSQFcdRyiWJzvQC5jifLZv0aYnQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=e2lXP/hr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aadddeaf8so7284781cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578958; x=1707183758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHRUZ67yNEKZS9FrhnY4ruPkQ8T6m4mDy3O5Fk7spbc=;
        b=e2lXP/hryEhSICaRjELXgNd5vdKL174JP46OdavL1I2edc+3EpvP9ghIilnq/TRkSx
         5UphqClq1HZoEZd9QBm4+jZYvifV/I/qHXAE10LL8HV/xWRiWrW6cjLk/ufrpP6sbnku
         GBSXHi1kS0aBio6/Hf37QZLjWBEuTDDM8pU+X3X+gO6YbXiWX4j5EZ1UplaMd/8W1I5m
         PUha7pcWNEnumFWDtRt/ejV0X0iSdfHMPGlPW9Wu1mmxCUBmzbTB+AhsxtHiDL0c0UZp
         wx1cyvWQt8KijkpRutTCNjzafYJhhmuO6fUqGlIvg2l0OVklUESnVXuS2fqXr7AyruDu
         6w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578958; x=1707183758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHRUZ67yNEKZS9FrhnY4ruPkQ8T6m4mDy3O5Fk7spbc=;
        b=tqBqwb0oQfsQKxdG09wQnjT/nZ6R/4zXUWoXnIreDjkPKW3YcUOprdm24vX/c+U5sn
         cvShbNfHPA/zNmGic3CjnbpKh6uxOzUXmTP/O3pIH/wnmWxdBIwaetPVh0pSPuzjCXr1
         ry60y6FhyQBoXfNAayjk85NipNCv/J9+ZcET8k1JfhNt7ljJE8TVFMTmIocoI6BT0gAo
         QmhnidMCYHWzbFdnPI+mYiV8FRWTAZUh67b/0KjgUbqP1UL+0URbz7ImX0BgEMXmDHkA
         8FTFssI6WwRuKJWdItcdkR0XPJKbe9NjZhj5xP8DyXlWjtUrar26nZWbe0oMstvBQU0h
         B/rw==
X-Gm-Message-State: AOJu0Yyabqv8DPnC/xu7/GuJTovHr6pBvKxreJ9yLvYN4cBFj8331yxA
	pWOyq3SvnUcYrW3yIgZ2J0DUPoqeuJGZWu6oWptibvTdcmCyn4O+8pYz0LLGyf0=
X-Google-Smtp-Source: AGHT+IFMteiVW0eCHxuGhuCuBCoCg6cS0vgJoS1KnkVEaCB7DQT4/zN8xIaB+z0TYxs1jXneazTs4Q==
X-Received: by 2002:ac8:5bcc:0:b0:42a:9c39:9727 with SMTP id b12-20020ac85bcc000000b0042a9c399727mr5682189qtb.83.1706578958090;
        Mon, 29 Jan 2024 17:42:38 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id bl4-20020a05622a244400b004260b65b4f7sm1369468qtb.97.2024.01.29.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:37 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] mm: zswap: function ordering: shrink_memcg_cb
Date: Mon, 29 Jan 2024 20:36:56 -0500
Message-ID: <20240130014208.565554-21-hannes@cmpxchg.org>
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

shrink_memcg_cb() is called by the shrinker and is based on
zswap_writeback_entry(). Move it in between. Save one fwd decl.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 125 ++++++++++++++++++++++++++---------------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0cb3437d47eb..4aea03285532 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1254,7 +1254,67 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 * shrinker functions
 **********************************/
 static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
-				       spinlock_t *lock, void *arg);
+				       spinlock_t *lock, void *arg)
+{
+	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	bool *encountered_page_in_swapcache = (bool *)arg;
+	swp_entry_t swpentry;
+	enum lru_status ret = LRU_REMOVED_RETRY;
+	int writeback_result;
+
+	/*
+	 * Rotate the entry to the tail before unlocking the LRU,
+	 * so that in case of an invalidation race concurrent
+	 * reclaimers don't waste their time on it.
+	 *
+	 * If writeback succeeds, or failure is due to the entry
+	 * being invalidated by the swap subsystem, the invalidation
+	 * will unlink and free it.
+	 *
+	 * Temporary failures, where the same entry should be tried
+	 * again immediately, almost never happen for this shrinker.
+	 * We don't do any trylocking; -ENOMEM comes closest,
+	 * but that's extremely rare and doesn't happen spuriously
+	 * either. Don't bother distinguishing this case.
+	 *
+	 * But since they do exist in theory, the entry cannot just
+	 * be unlinked, or we could leak it. Hence, rotate.
+	 */
+	list_move_tail(item, &l->list);
+
+	/*
+	 * Once the lru lock is dropped, the entry might get freed. The
+	 * swpentry is copied to the stack, and entry isn't deref'd again
+	 * until the entry is verified to still be alive in the tree.
+	 */
+	swpentry = entry->swpentry;
+
+	/*
+	 * It's safe to drop the lock here because we return either
+	 * LRU_REMOVED_RETRY or LRU_RETRY.
+	 */
+	spin_unlock(lock);
+
+	writeback_result = zswap_writeback_entry(entry, swpentry);
+
+	if (writeback_result) {
+		zswap_reject_reclaim_fail++;
+		ret = LRU_RETRY;
+
+		/*
+		 * Encountering a page already in swap cache is a sign that we are shrinking
+		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
+		 * shrinker context).
+		 */
+		if (writeback_result == -EEXIST && encountered_page_in_swapcache)
+			*encountered_page_in_swapcache = true;
+	} else {
+		zswap_written_back_pages++;
+	}
+
+	spin_lock(lock);
+	return ret;
+}
 
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
@@ -1354,69 +1414,6 @@ static void zswap_alloc_shrinker(struct zswap_pool *pool)
 	pool->shrinker->seeks = DEFAULT_SEEKS;
 }
 
-static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
-				       spinlock_t *lock, void *arg)
-{
-	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
-	bool *encountered_page_in_swapcache = (bool *)arg;
-	swp_entry_t swpentry;
-	enum lru_status ret = LRU_REMOVED_RETRY;
-	int writeback_result;
-
-	/*
-	 * Rotate the entry to the tail before unlocking the LRU,
-	 * so that in case of an invalidation race concurrent
-	 * reclaimers don't waste their time on it.
-	 *
-	 * If writeback succeeds, or failure is due to the entry
-	 * being invalidated by the swap subsystem, the invalidation
-	 * will unlink and free it.
-	 *
-	 * Temporary failures, where the same entry should be tried
-	 * again immediately, almost never happen for this shrinker.
-	 * We don't do any trylocking; -ENOMEM comes closest,
-	 * but that's extremely rare and doesn't happen spuriously
-	 * either. Don't bother distinguishing this case.
-	 *
-	 * But since they do exist in theory, the entry cannot just
-	 * be unlinked, or we could leak it. Hence, rotate.
-	 */
-	list_move_tail(item, &l->list);
-
-	/*
-	 * Once the lru lock is dropped, the entry might get freed. The
-	 * swpentry is copied to the stack, and entry isn't deref'd again
-	 * until the entry is verified to still be alive in the tree.
-	 */
-	swpentry = entry->swpentry;
-
-	/*
-	 * It's safe to drop the lock here because we return either
-	 * LRU_REMOVED_RETRY or LRU_RETRY.
-	 */
-	spin_unlock(lock);
-
-	writeback_result = zswap_writeback_entry(entry, swpentry);
-
-	if (writeback_result) {
-		zswap_reject_reclaim_fail++;
-		ret = LRU_RETRY;
-
-		/*
-		 * Encountering a page already in swap cache is a sign that we are shrinking
-		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
-		 * shrinker context).
-		 */
-		if (writeback_result == -EEXIST && encountered_page_in_swapcache)
-			*encountered_page_in_swapcache = true;
-	} else {
-		zswap_written_back_pages++;
-	}
-
-	spin_lock(lock);
-	return ret;
-}
-
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
 	struct zswap_pool *pool;
-- 
2.43.0


