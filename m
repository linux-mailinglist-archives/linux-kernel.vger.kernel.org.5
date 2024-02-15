Return-Path: <linux-kernel+bounces-66822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE588561E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719F21F2C557
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C212BEB6;
	Thu, 15 Feb 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFKuhjFB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26B4A08;
	Thu, 15 Feb 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997161; cv=none; b=TiMXa1lG2PU08GU3Y4265wIkVc/65ICyhabTY8AoBnmckvK9FXuhukwGE8b4Pp74dZ1WtF197IVGT/OcCnrFVrHWBmhXfb47YS0InDizF7YkEuazOBeGZaUElCEsf5PKnwKDATL+I7y/LhMJ3Poij7byQhOkEafWz2Tg9TfraFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997161; c=relaxed/simple;
	bh=xHD1jYlDl3OhNy/NvkoRutSUDcPPUt2DKryla2HlDLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeR+TkS283JkEX6EFUWC74c60AIkRi6RXNQaHtxqHCbl20JccO/HMa5ODlmxV8PvG1WYWgwjRTsDt9N9fFEucER/cerrzRlGC721A0tEtokTeFjIH7pbLWg6wRCDeWYu2zgEwmmPIhWqsjpn/qO58Q4JVVNksV5h7ZxOz0LMFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFKuhjFB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707997160; x=1739533160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHD1jYlDl3OhNy/NvkoRutSUDcPPUt2DKryla2HlDLA=;
  b=ZFKuhjFBoe83Ct/j45txcE+dR3Qjx8OQvqhYD9C7e0cTVl7TKyAUNOkz
   xh17gb25n7iyEmexiTZAaa9P8/RuvjmH1sKzFjDloNIiYRigQ5mWf56Yj
   bm061E2DclSb9aeBJQ6gJWKVY0b4oK91pEw8OnlKdF+q32/qQfw6jUugE
   M9D8cbE22QV5HNLnJq89YwGEqlwWsmmFemzso4IdS7OalkfbtiVRsTFZd
   GA6ZxStwTDELybwv9YDRIUkCU8K4biPyBXQYIrmQxQhEwy1ihP4DbgC0Y
   cj5rAQQ0yFYVIAPcYjI5G3vM71T4pDihWW449sE91KYAV/3tNl4WpYprN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2217772"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2217772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="34554740"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 15 Feb 2024 03:39:17 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] page_pool: disable direct recycling based on pool->cpuid on destroy
Date: Thu, 15 Feb 2024 12:39:05 +0100
Message-ID: <20240215113905.96817-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that direct recycling is performed basing on pool->cpuid when set,
memory leaks are possible:

1. A pool is destroyed.
2. Alloc cache is emptied (it's done only once).
3. pool->cpuid is still set.
4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
5. Now alloc cache is not empty, but it won't ever be freed.

In order to avoid that, rewrite pool->cpuid to -1 when unlinking NAPI to
make sure no direct recycling will be possible after emptying the cache.
This involves a bit of overhead as pool->cpuid now must be accessed
via READ_ONCE() to avoid partial reads.
Rename page_pool_unlink_napi() -> page_pool_disable_direct_recycling()
to reflect what it actually does and unexport it.

Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |  5 -----
 net/core/page_pool.c          | 10 +++++++---
 net/core/skbuff.c             |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 3828396ae60c..3590fbe6e3f1 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -210,17 +210,12 @@ struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 struct xdp_mem_info;
 
 #ifdef CONFIG_PAGE_POOL
-void page_pool_unlink_napi(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   struct xdp_mem_info *mem);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
 #else
-static inline void page_pool_unlink_napi(struct page_pool *pool)
-{
-}
-
 static inline void page_pool_destroy(struct page_pool *pool)
 {
 }
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 89c835fcf094..e8b9399d8e32 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -949,8 +949,13 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 	pool->xdp_mem_id = mem->id;
 }
 
-void page_pool_unlink_napi(struct page_pool *pool)
+static void page_pool_disable_direct_recycling(struct page_pool *pool)
 {
+	/* Disable direct recycling based on pool->cpuid.
+	 * Paired with READ_ONCE() in napi_pp_put_page().
+	 */
+	WRITE_ONCE(pool->cpuid, -1);
+
 	if (!pool->p.napi)
 		return;
 
@@ -962,7 +967,6 @@ void page_pool_unlink_napi(struct page_pool *pool)
 
 	WRITE_ONCE(pool->p.napi, NULL);
 }
-EXPORT_SYMBOL(page_pool_unlink_napi);
 
 void page_pool_destroy(struct page_pool *pool)
 {
@@ -972,7 +976,7 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_put(pool))
 		return;
 
-	page_pool_unlink_napi(pool);
+	page_pool_disable_direct_recycling(pool);
 	page_pool_free_frag(pool);
 
 	if (!page_pool_release(pool))
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0d9a489e6ae1..b41856585c24 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1018,7 +1018,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 		unsigned int cpuid = smp_processor_id();
 
 		allow_direct = napi && READ_ONCE(napi->list_owner) == cpuid;
-		allow_direct |= (pp->cpuid == cpuid);
+		allow_direct |= READ_ONCE(pp->cpuid) == cpuid;
 	}
 
 	/* Driver set this to memory recycling info. Reset it on recycle.
-- 
2.43.0


