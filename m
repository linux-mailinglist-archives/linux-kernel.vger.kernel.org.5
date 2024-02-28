Return-Path: <linux-kernel+bounces-85300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E286B3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210931C25CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53215D5A9;
	Wed, 28 Feb 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6a2dbqw"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DC15B98C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135409; cv=none; b=ZcoTEEaihkunkV7elw+XWCq6hX2gHfsqGSLbQdTMCo/06zVjEud1VZ8LQUUH6RtR7Zq42xbWLW7F97PoDhvYDLrxrx1fEMrxWbaA6JVAqZMUdHDJ2TVLiX7uSewuHN/5YJbypwtZ+9QQgc0iKxbv6H/+SCNJRKSQnvqSb1/UPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135409; c=relaxed/simple;
	bh=A0aGELFfeQuryHSNoJxyQ82EHvZ+zG0MT55ob0nOeus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgAxFZUDdCeu/E2VQhw53xWBrcK8hbgMyExt6c2jDx99JHygyGMa1x5aQqAf1Zjejb0QyQHnQk3xnQBmUmhPfr0ppg+Ymk+NphXsXx6MewLTRDnSNdnqRD6aeWi0MIV7TWXnhRLaHPI3/AzQa/vKzrNiyOYUkl1/4R/IjcLwnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6a2dbqw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTVSWQckrG1uhUwf4yE6louRKCzZfuwwkT2CYEv4alg=;
	b=Z6a2dbqwPm+KvT5A7tdVD+WC4yALKy9n7LbrvTyh9XpbDmn84qGxgCAiTe7mTvXHiMOdBg
	oIvs/mWxCVlXRJRwsAT3BJtv2L6nQDdTEoGPbz01rkkgKyPiMGbBUTEakx3wG+RbyUV51o
	xzEIlWuWUWspGgy0Z9yIIAxlL/F6G90=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH mm-unstable v2] mm/zswap: fix zswap_pools_lock usages after changing to percpu_ref
Date: Wed, 28 Feb 2024 15:49:54 +0000
Message-Id: <20240228154954.3028626-1-chengming.zhou@linux.dev>
In-Reply-To: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
References: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now the release of zswap pool is controlled by percpu_ref, its release
callback (__zswap_pool_empty()) will be called when percpu_ref hit 0.
But this release callback may potentially be called from RCU callback
context by percpu_ref_kill(), which maybe from the softirq context.

So we need to use spin_lock/unlock_bh() to avoid potential deadlock.

This problem is introduced by the commit f3da427e82c4 ("mm/zswap: change
zswap_pool kref to percpu_ref"), which is in mm-unstable branch now.
It can be reproduced by testing kernel build in tmpfs with zswap and
CONFIG_LOCKDEP enabled, meanwhile changing the zswap compressor setting
dynamically.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
v2:
 - Change to use spin_lock/unlock_bh(), per Matthew.
---
 mm/zswap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 011e068eb355..da90933c6d20 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -459,7 +459,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref)
 
 	pool = container_of(ref, typeof(*pool), ref);
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_bh(&zswap_pools_lock);
 
 	WARN_ON(pool == zswap_pool_current());
 
@@ -468,7 +468,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref)
 	INIT_WORK(&pool->release_work, __zswap_pool_release);
 	schedule_work(&pool->release_work);
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_bh(&zswap_pools_lock);
 }
 
 static int __must_check zswap_pool_get(struct zswap_pool *pool)
@@ -598,7 +598,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		return -EINVAL;
 	}
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_bh(&zswap_pools_lock);
 
 	pool = zswap_pool_find_get(type, compressor);
 	if (pool) {
@@ -607,7 +607,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		list_del_rcu(&pool->list);
 	}
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_bh(&zswap_pools_lock);
 
 	if (!pool)
 		pool = zswap_pool_create(type, compressor);
@@ -628,7 +628,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	else
 		ret = -EINVAL;
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_bh(&zswap_pools_lock);
 
 	if (!ret) {
 		put_pool = zswap_pool_current();
@@ -643,7 +643,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		put_pool = pool;
 	}
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_bh(&zswap_pools_lock);
 
 	if (!zswap_has_pool && !pool) {
 		/* if initial pool creation failed, and this pool creation also
-- 
2.40.1


