Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959A780530B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442142AbjLELfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbjLELey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:34:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25498D51;
        Tue,  5 Dec 2023 03:34:54 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Skz2G66sczWjJk;
        Tue,  5 Dec 2023 19:33:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 19:34:51 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: [PATCH net-next 2/6] page_frag: unify gfp bit for order 3 page allocation
Date:   Tue, 5 Dec 2023 19:34:40 +0800
Message-ID: <20231205113444.63015-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231205113444.63015-1-linyunsheng@huawei.com>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there seems to be three page frag implementions
which all try to allocate order 3 page, if that fails, it
then fail back to allocate order 0 page, and each of them
all allow order 3 page allocation to fail under certain
condition by using specific gfp bits.

The gfp bits for order 3 page allocation are different
between different implementation, __GFP_NOMEMALLOC is
or'd to forbid access to emergency reserves memory for
__page_frag_cache_refill(), but it is not or'd in other
implementions, __GFP_DIRECT_RECLAIM is xor'd to avoid
direct reclaim in skb_page_frag_refill(), but it is not
xor'd in __page_frag_cache_refill().

This patch unifies the gfp bits used between different
implementions by or'ing __GFP_NOMEMALLOC and xor'ing
__GFP_DIRECT_RECLAIM for order 3 page allocation to avoid
possible pressure for mm.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 drivers/vhost/net.c | 2 +-
 mm/page_alloc.c     | 4 ++--
 net/core/sock.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f2ed7167c848..e574e21cc0ca 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -670,7 +670,7 @@ static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
 		/* Avoid direct reclaim but allow kswapd to wake */
 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
+					  __GFP_NORETRY | __GFP_NOMEMALLOC,
 					  SKB_FRAG_PAGE_ORDER);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9a16305cf985..1f0b36dd81b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4693,8 +4693,8 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask |= __GFP_COMP | __GFP_NOWARN | __GFP_NORETRY |
-		    __GFP_NOMEMALLOC;
+	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
 	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa..4efa9cae4b0d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2904,7 +2904,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 		/* Avoid direct reclaim but allow kswapd to wake */
 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
+					  __GFP_NORETRY | __GFP_NOMEMALLOC,
 					  SKB_FRAG_PAGE_ORDER);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
-- 
2.33.0

