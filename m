Return-Path: <linux-kernel+bounces-43750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAC841891
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E81F289B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78B38DFA;
	Tue, 30 Jan 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0e5cKCip"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510738393
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578950; cv=none; b=unjdyYhAkgRuywN/p8AHdh0FrPJ4KZfNBOGGNr7KeR5xbn0M9OHVSVJk903QYmuIxivMv2hJtdqLIuCTQtBx2ipnMgVWe6EfC7Bb6XjQ/QRlZSKQ6MQ6CNy4hSCmj0akj+wcYN4BaXPt938T+Wd1nMy7IfTFR2HCPvwtl8vG1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578950; c=relaxed/simple;
	bh=9xw/W03ukpr/L6i7AIbF53T7wElpUaGJf2hRLuUR5ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzOpBQoc9ArjqXpZeh4BRLC2qL3sCX9ULwGRuLCOERl9nn95VFraiE9N5xHkHuY8SRD0LIeZsbjkDVmfQZfLHejn1DseopksO9zLlm4hiwd8DfT1h+cR1SCOcY3RDUGJCuz/OVLwWRveQfhQMcECZ+FcpCj+ETzNrO7EuY8gQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0e5cKCip; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c444f9272so14319546d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578947; x=1707183747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW+93M2Q9nWxSPgR21ybfgSivHJtX7f76WUEXvkAumg=;
        b=0e5cKCipbmAbU9orMkEXr3CPe36KKB1C+HdJ0pnKiwUkkDGfvKsujIvPdVx4UIRCfp
         xN3glyGGe6wLu9Ww0AzCkrY+ebAEBEGTVcQG177fl/OoqIIJuQ4HB2zPQRrj+WLh/96s
         RQB0QwuNO5fbojE8HAdOousipxB6IZPBTvXeboIRhlFdYb4gsOKVugoiH+fmRwetgfFZ
         O7IFFSvIrlgvrUu6Gi9fTm4RbDNEmvbJb2zsE2r6B5i4Uiu4/SCrND5DZ2105HPfOoFm
         fLrJQOSh5pmr5NI6cvQ3TTSR1YXHMcqNgPd85v+SL8OEGV6PTLCOrb/QqSFX4s0CpVqv
         nsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578947; x=1707183747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW+93M2Q9nWxSPgR21ybfgSivHJtX7f76WUEXvkAumg=;
        b=AM+L5tTCzS4LyYRikW55QS1fjsJVDC3EfSulBfY6IVQZLLe0pfbe/08nh610xr9OTj
         dCycLbZ8aaLra2HbxUG3Zsx6b/sj30snq9b0nWBJQi+21Eu9676TMAOa3jXsbrXwtauV
         sfyrk9H5hSxAWfl0HjPxOt/Qu8ZdlG9xoTmL7KjeoVpcRbLRHLnVN3IOy7MeGshtCteS
         PkR7lTQk88KLvCfOnaNRsaQzaSYE0zHvWWc3tjqoFeVeaFtuQJsfFO0pFCA/NhZbKaPG
         cI6PGAr1uKJA8vf7qbB3uyNcvm5CK6qBMagzrkIXpAW0TxDXFxcYO26fL0J+wYrWMTVU
         1TDQ==
X-Gm-Message-State: AOJu0Yx4r6VCDCYtgd6Q0MUltSWeESH/yLt2uty4icq3pIqg9xXEDtlZ
	TKfP/xQocnTBMJDAB5TJu8FuCagoU5s2Hbi+j+MFC/vJZKl/CRMlDFyjzs1V3II=
X-Google-Smtp-Source: AGHT+IGbQQQZq+kfQrrdhSmxdR44XoO3pzuQK7Yh8fRiEenD92oHac9H3b2LTsWjU2hqhbKGsaWTag==
X-Received: by 2002:a05:6214:cab:b0:686:9441:ac30 with SMTP id s11-20020a0562140cab00b006869441ac30mr8699046qvs.22.1706578947264;
        Mon, 29 Jan 2024 17:42:27 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b006819bb31533sm3993392qvb.99.2024.01.29.17.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:26 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] mm: zswap: function ordering: pool refcounting
Date: Mon, 29 Jan 2024 20:36:47 -0500
Message-ID: <20240130014208.565554-12-hannes@cmpxchg.org>
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

Move pool refcounting functions into the pool section. First the
destroy functions, then the get and put which uses them.

__zswap_pool_empty() has an upward reference to the global
zswap_pools, to sanity check it's not the currently active pool that's
being freed. That gets the forward decl for zswap_pool_cuyrrent().

This puts the get and put function above all callers, so kill the
forward decls as well.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 94 +++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 805d9a35f633..33775f2224b7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -278,8 +278,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
 
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry);
-static int zswap_pool_get(struct zswap_pool *pool);
-static void zswap_pool_put(struct zswap_pool *pool);
 
 static bool zswap_is_full(void)
 {
@@ -472,6 +470,53 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	kfree(pool);
 }
 
+static void __zswap_pool_release(struct work_struct *work)
+{
+	struct zswap_pool *pool = container_of(work, typeof(*pool),
+						release_work);
+
+	synchronize_rcu();
+
+	/* nobody should have been able to get a kref... */
+	WARN_ON(kref_get_unless_zero(&pool->kref));
+
+	/* pool is now off zswap_pools list and has no references. */
+	zswap_pool_destroy(pool);
+}
+
+static struct zswap_pool *zswap_pool_current(void);
+
+static void __zswap_pool_empty(struct kref *kref)
+{
+	struct zswap_pool *pool;
+
+	pool = container_of(kref, typeof(*pool), kref);
+
+	spin_lock(&zswap_pools_lock);
+
+	WARN_ON(pool == zswap_pool_current());
+
+	list_del_rcu(&pool->list);
+
+	INIT_WORK(&pool->release_work, __zswap_pool_release);
+	schedule_work(&pool->release_work);
+
+	spin_unlock(&zswap_pools_lock);
+}
+
+static int __must_check zswap_pool_get(struct zswap_pool *pool)
+{
+	if (!pool)
+		return 0;
+
+	return kref_get_unless_zero(&pool->kref);
+}
+
+static void zswap_pool_put(struct zswap_pool *pool)
+{
+	kref_put(&pool->kref, __zswap_pool_empty);
+}
+
 /* should be called under RCU */
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
@@ -1122,51 +1167,6 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
-static int __must_check zswap_pool_get(struct zswap_pool *pool)
-{
-	if (!pool)
-		return 0;
-
-	return kref_get_unless_zero(&pool->kref);
-}
-
-static void __zswap_pool_release(struct work_struct *work)
-{
-	struct zswap_pool *pool = container_of(work, typeof(*pool),
-						release_work);
-
-	synchronize_rcu();
-
-	/* nobody should have been able to get a kref... */
-	WARN_ON(kref_get_unless_zero(&pool->kref));
-
-	/* pool is now off zswap_pools list and has no references. */
-	zswap_pool_destroy(pool);
-}
-
-static void __zswap_pool_empty(struct kref *kref)
-{
-	struct zswap_pool *pool;
-
-	pool = container_of(kref, typeof(*pool), kref);
-
-	spin_lock(&zswap_pools_lock);
-
-	WARN_ON(pool == zswap_pool_current());
-
-	list_del_rcu(&pool->list);
-
-	INIT_WORK(&pool->release_work, __zswap_pool_release);
-	schedule_work(&pool->release_work);
-
-	spin_unlock(&zswap_pools_lock);
-}
-
-static void zswap_pool_put(struct zswap_pool *pool)
-{
-	kref_put(&pool->kref, __zswap_pool_empty);
-}
-
 /*********************************
 * param callbacks
 **********************************/
-- 
2.43.0


