Return-Path: <linux-kernel+bounces-122974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2610890092
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311B2293B20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7712E1C9;
	Thu, 28 Mar 2024 13:40:58 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50E12D1E8;
	Thu, 28 Mar 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633257; cv=none; b=bM0IT0JdrfSGxFhzms3SjqJHynHpqg+2qR41UgvtIy41koGjtva35STwgBPaKsTP9R3xy6Sm+NNmQt3V4qKxa4y3VxVGDIRUdRaJst2FvgDQ/QW6QPKdya/bxktGsej/ZRjPbzVQFe6uhRynMxRN9A1XqI/afx9HBUMNoNcKzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633257; c=relaxed/simple;
	bh=XGIOGFAiA4HuxyP7QKZjbc02X2oTT7KGKjHMM4PfX+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0jpPrVUY7YOHOi1QEuPHne+hIizRFCQ5IKXZuzM3fkMyv6AKFf/DAVHXuFaONmvWYf8xOv89XY8y0dLgn8i5NjE5nML4dieztlyH2MUaXb+smhhEt/ekl9duHnPj6Y7Lte6aFTL7bnHO1TPkQt/0jDEPkdN+gTbFXMUMohmOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V54P074DJz1R8gB;
	Thu, 28 Mar 2024 21:38:12 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D62381A0172;
	Thu, 28 Mar 2024 21:40:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:40:53 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, <linux-mm@kvack.org>
Subject: [PATCH RFC 05/10] mm: page_frag: add two inline helper for page_frag API
Date: Thu, 28 Mar 2024 21:38:34 +0800
Message-ID: <20240328133839.13620-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240328133839.13620-1-linyunsheng@huawei.com>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index aa3adaa2c466..e6bc0dec7463 100644
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


