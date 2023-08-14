Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61277B93A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHNNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHNM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:59:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F712E5E;
        Mon, 14 Aug 2023 05:59:52 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPZCR3YBczNnCj;
        Mon, 14 Aug 2023 20:56:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 20:59:50 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        <bpf@vger.kernel.org>
Subject: [PATCH net-next v6 6/6] net: veth: use newly added page pool API for veth with xdp
Date:   Mon, 14 Aug 2023 20:56:43 +0800
Message-ID: <20230814125643.59334-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230814125643.59334-1-linyunsheng@huawei.com>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_pool[_cache]_alloc() API to allocate memory with
least memory utilization and performance penalty.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 953f6d8f8db0..aaef234be0d8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -736,10 +736,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_shinfo(skb)->nr_frags ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		u32 size, len, max_head_size, off;
+		u32 size, len, max_head_size, off, truesize, page_offset;
 		struct sk_buff *nskb;
 		struct page *page;
 		int i, head_off;
+		void *data;
 
 		/* We need a private copy of the skb and data buffers since
 		 * the ebpf program can modify it. We segment the original skb
@@ -752,14 +753,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		if (skb->len > PAGE_SIZE * MAX_SKB_FRAGS + max_head_size)
 			goto drop;
 
+		size = min_t(u32, skb->len, max_head_size);
+		truesize = SKB_HEAD_ALIGN(size) + VETH_XDP_HEADROOM;
+
 		/* Allocate skb head */
-		page = page_pool_dev_alloc_pages(rq->page_pool);
-		if (!page)
+		data = page_pool_dev_cache_alloc(rq->page_pool, &truesize);
+		if (!data)
 			goto drop;
 
-		nskb = napi_build_skb(page_address(page), PAGE_SIZE);
+		nskb = napi_build_skb(data, truesize);
 		if (!nskb) {
-			page_pool_put_full_page(rq->page_pool, page, true);
+			page_pool_cache_free(rq->page_pool, data, true);
 			goto drop;
 		}
 
@@ -767,7 +771,6 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		skb_copy_header(nskb, skb);
 		skb_mark_for_recycle(nskb);
 
-		size = min_t(u32, skb->len, max_head_size);
 		if (skb_copy_bits(skb, 0, nskb->data, size)) {
 			consume_skb(nskb);
 			goto drop;
@@ -782,14 +785,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		len = skb->len - off;
 
 		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
-			page = page_pool_dev_alloc_pages(rq->page_pool);
+			size = min_t(u32, len, PAGE_SIZE);
+			truesize = size;
+
+			page = page_pool_dev_alloc(rq->page_pool, &page_offset,
+						   &truesize);
 			if (!page) {
 				consume_skb(nskb);
 				goto drop;
 			}
 
-			size = min_t(u32, len, PAGE_SIZE);
-			skb_add_rx_frag(nskb, i, page, 0, size, PAGE_SIZE);
+			skb_add_rx_frag(nskb, i, page, page_offset, size, truesize);
 			if (skb_copy_bits(skb, off, page_address(page),
 					  size)) {
 				consume_skb(nskb);
-- 
2.33.0

