Return-Path: <linux-kernel+bounces-134401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EECA89B10B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA69D281543
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D18F3A267;
	Sun,  7 Apr 2024 13:11:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970D3BBEA;
	Sun,  7 Apr 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495473; cv=none; b=dNpHEF3tcufmYZzAuS/5jBwYxVV2+Z3q2EPWWY4BMUfSi90ZJkUEMdxgomrYyKku3yhKGuHOFg5zlKYdN3N22TMpGXMPe9Gd5VR85iREF3/pB8JW6GryFUQfwi4FpjrEGCmLXrhtdFEagg1iC4qpl5o12mDEg1LhLqSWwE1U0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495473; c=relaxed/simple;
	bh=hDg7jA1fPAoBoi0a6T0CNtFlVqTTcsoVa4Nj+L71Yvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpjQV6T8CbeL71vZ8HfyuMUq+mnLwkWnGhFQ56ADJlZEqoUe1S8wgNAvMLvl2o6hfnHRJ/yV/4YhwE8aDW1BG4ePU3UWXtoVFU5GPbCj0XatF5zd5p8Rx1vo1o1aVsFA77zivEDhX3w4+2OGs2F+o/YamkSv2viYZcdgHK/Fs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VCCFf2sgGzXkvV;
	Sun,  7 Apr 2024 21:08:06 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 462851404F7;
	Sun,  7 Apr 2024 21:11:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 21:11:10 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, <linux-mm@kvack.org>
Subject: [PATCH net-next v1 05/12] mm: page_frag: add two inline helper for page_frag API
Date: Sun, 7 Apr 2024 21:08:42 +0800
Message-ID: <20240407130850.19625-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240407130850.19625-1-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Add two inline helpers for page_frag API to avoid calling
accessing the field of 'struct page_frag_cache'.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 10 ++++++++++
 net/core/skbuff.c               |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 9d5d86b2d3ab..fe5faa80b6c3 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -23,6 +23,16 @@ struct page_frag_cache {
 	bool pfmemalloc;
 };
 
+static inline void page_frag_cache_init(struct page_frag_cache *nc)
+{
+	nc->va = NULL;
+}
+
+static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
+{
+	return !!nc->pfmemalloc;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2c10ebd133ac..4ad4db7403ba 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -742,12 +742,12 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (in_hardirq() || irqs_disabled()) {
 		nc = this_cpu_ptr(&netdev_alloc_cache);
 		data = page_frag_alloc_va(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 	} else {
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache.page);
 		data = page_frag_alloc_va(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 		local_bh_enable();
 	}
 
-- 
2.33.0


