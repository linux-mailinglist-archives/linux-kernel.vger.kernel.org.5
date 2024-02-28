Return-Path: <linux-kernel+bounces-85251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925A86B2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEDFB27AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E115B993;
	Wed, 28 Feb 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H9isTi+Z"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13741C10
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133530; cv=none; b=bahPYlGlYus9kfgWR7IT5ZD4tcnpbfrZUt0u62AeUkPGQLUtxYgUtqSRyJtkFBy7iDzEvt/DPK20R1lGM8VlHl7uYcM6FpRv6OKiH5B/UwRtzFOtHLW+9Ro9JNxgJ8vsKEwvnmGmqx8CHlv1ZOu55iLdq3Bc3MV+S1uQLqG4hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133530; c=relaxed/simple;
	bh=stUe9QZ/uCOkF302zZNjNXzNH7QMbzuu9f7aaU4HsLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glgaeE/L6pXMFG4Q4uxUgNVsfoSx5QkmU2mnANTupRM5bKkUNhY7hvtex/obP2/Zx5+B8CCHxDrbJNvQQ4iGj41fnTDg7/Bb3slByCiQW8LGQJu+GAYsQhVeH6TFB87/jZnDDenVTa592ej563ltMs/5kgCIFllV9cyo6POXKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H9isTi+Z; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709133526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ/GDqUz6wZpxgKFsr9ka4SjiFzrDvg9/BbQeXQM+7g=;
	b=H9isTi+ZhtCmS+Oppv/gIrbAUAkhjlICKB+k/lnApdMQ3QJJpeqyg2taL+x2pYwXu2nrAu
	8GaheRZYXPFBCrw3hgG2vfHe4PO/QhyZgg6cUtRLuLObphL7HPw75W0F7HGgL4giMnMfMq
	yAoP2fDyrijAgjA0MJuybdimHhVNphI=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH mm-unstable hotfix] mm/zswap: fix zswap_pools_lock usages after changing to percpu_ref
Date: Wed, 28 Feb 2024 15:18:32 +0000
Message-Id: <20240228151832.2431993-1-chengming.zhou@linux.dev>
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
context by percpu_ref_kill(), which maybe in the interrupt context.

So we need to use spin_lock_irqsave() and spin_unlock_irqrestore()
in the release callback: __zswap_pool_empty(). In other task context
places, spin_lock_irq() and spin_unlock_irq() are enough to avoid
potential deadlock.

This problem is introduced by the commit f3da427e82c4 ("mm/zswap: change
zswap_pool kref to percpu_ref"), which is in mm-unstable branch now.
It can be reproduced by testing kernel build in tmpfs with zswap and
CONFIG_LOCKDEP enabled, meanwhile changing the zswap compressor setting
dynamically.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zswap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 011e068eb355..894bd184f78e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -456,10 +456,11 @@ static struct zswap_pool *zswap_pool_current(void);
 static void __zswap_pool_empty(struct percpu_ref *ref)
 {
 	struct zswap_pool *pool;
+	unsigned long flags;
 
 	pool = container_of(ref, typeof(*pool), ref);
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_irqsave(&zswap_pools_lock, flags);
 
 	WARN_ON(pool == zswap_pool_current());
 
@@ -468,7 +469,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref)
 	INIT_WORK(&pool->release_work, __zswap_pool_release);
 	schedule_work(&pool->release_work);
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_irqrestore(&zswap_pools_lock, flags);
 }
 
 static int __must_check zswap_pool_get(struct zswap_pool *pool)
@@ -598,7 +599,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		return -EINVAL;
 	}
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_irq(&zswap_pools_lock);
 
 	pool = zswap_pool_find_get(type, compressor);
 	if (pool) {
@@ -607,7 +608,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		list_del_rcu(&pool->list);
 	}
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_irq(&zswap_pools_lock);
 
 	if (!pool)
 		pool = zswap_pool_create(type, compressor);
@@ -628,7 +629,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	else
 		ret = -EINVAL;
 
-	spin_lock(&zswap_pools_lock);
+	spin_lock_irq(&zswap_pools_lock);
 
 	if (!ret) {
 		put_pool = zswap_pool_current();
@@ -643,7 +644,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 		put_pool = pool;
 	}
 
-	spin_unlock(&zswap_pools_lock);
+	spin_unlock_irq(&zswap_pools_lock);
 
 	if (!zswap_has_pool && !pool) {
 		/* if initial pool creation failed, and this pool creation also
-- 
2.40.1


