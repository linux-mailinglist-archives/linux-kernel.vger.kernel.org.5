Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2B7E3B89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjKGMH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjKGMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:07:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD6DD76;
        Tue,  7 Nov 2023 04:07:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168CDC433C8;
        Tue,  7 Nov 2023 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358838;
        bh=vV++kpxNMfl7dNM1BMGuOrKFzCER4Be4wIb69qQKUUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSpp0LluOmpTqj55FOPu5QGhXFk4qzPXBOQ+eYBQtOTN0aRbJGeaNFOoRdcvQGf93
         JlsU4iztmjEreeZfXnKl/r+aivcJHAsNbBRNTXgJ4m/T0eW2OaWgk8ndxDYkV5ymYO
         QYoZJF6I/B9T3nEJuCEksryBqTFPelXBXeNTF/YmdNvJqbPW7TIw/0UeOBph4e1/Au
         iMFT3n2PfUapO9LVJ0Dyx1BewfzQAqtmyGMXmrXceLmdgphq6NJurAeFwdMSUQlf6B
         sun9JdcNknCto9yTni4mAJLUotG7B0YgZEC6WGGuA8Ns9sSq5au9Ltu8DUtoYolqed
         e0nNeseJ1wXzQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        horms@kernel.org, pavan.chebbi@broadcom.com, trix@redhat.com,
        ruc_gongyuanjun@163.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/31] atl1c: Work around the DMA RX overflow issue
Date:   Tue,  7 Nov 2023 07:05:52 -0500
Message-ID: <20231107120704.3756327-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sieng-Piaw Liew <liew.s.piaw@gmail.com>

[ Upstream commit 86565682e9053e5deb128193ea9e88531bbae9cf ]

This is based on alx driver commit 881d0327db37 ("net: alx: Work around
the DMA RX overflow issue").

The alx and atl1c drivers had RX overflow error which was why a custom
allocator was created to avoid certain addresses. The simpler workaround
then created for alx driver, but not for atl1c due to lack of tester.

Instead of using a custom allocator, check the allocated skb address and
use skb_reserve() to move away from problematic 0x...fc0 address.

Tested on AR8131 on Acer 4540.

Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Link: https://lore.kernel.org/r/20230912010711.12036-1-liew.s.piaw@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atl1c/atl1c.h    |  3 -
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 67 +++++--------------
 2 files changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c.h b/drivers/net/ethernet/atheros/atl1c/atl1c.h
index 43d821fe7a542..63ba64dbb7310 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c.h
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c.h
@@ -504,15 +504,12 @@ struct atl1c_rrd_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 	struct napi_struct napi;
-	struct page *rx_page;
-	unsigned int rx_page_offset;
 };
 
 /* board specific private data structure */
 struct atl1c_adapter {
 	struct net_device   *netdev;
 	struct pci_dev      *pdev;
-	unsigned int	    rx_frag_size;
 	struct atl1c_hw        hw;
 	struct atl1c_hw_stats  hw_stats;
 	struct mii_if_info  mii;    /* MII interface info */
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 940c5d1ff9cfc..74b78164cf74a 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -483,15 +483,10 @@ static int atl1c_set_mac_addr(struct net_device *netdev, void *p)
 static void atl1c_set_rxbufsize(struct atl1c_adapter *adapter,
 				struct net_device *dev)
 {
-	unsigned int head_size;
 	int mtu = dev->mtu;
 
 	adapter->rx_buffer_len = mtu > AT_RX_BUF_SIZE ?
 		roundup(mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN, 8) : AT_RX_BUF_SIZE;
-
-	head_size = SKB_DATA_ALIGN(adapter->rx_buffer_len + NET_SKB_PAD + NET_IP_ALIGN) +
-		    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	adapter->rx_frag_size = roundup_pow_of_two(head_size);
 }
 
 static netdev_features_t atl1c_fix_features(struct net_device *netdev,
@@ -964,7 +959,6 @@ static void atl1c_init_ring_ptrs(struct atl1c_adapter *adapter)
 static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	int i;
 
 	dma_free_coherent(&pdev->dev, adapter->ring_header.size,
 			  adapter->ring_header.desc, adapter->ring_header.dma);
@@ -977,12 +971,6 @@ static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 		kfree(adapter->tpd_ring[0].buffer_info);
 		adapter->tpd_ring[0].buffer_info = NULL;
 	}
-	for (i = 0; i < adapter->rx_queue_count; ++i) {
-		if (adapter->rrd_ring[i].rx_page) {
-			put_page(adapter->rrd_ring[i].rx_page);
-			adapter->rrd_ring[i].rx_page = NULL;
-		}
-	}
 }
 
 /**
@@ -1754,48 +1742,11 @@ static inline void atl1c_rx_checksum(struct atl1c_adapter *adapter,
 	skb_checksum_none_assert(skb);
 }
 
-static struct sk_buff *atl1c_alloc_skb(struct atl1c_adapter *adapter,
-				       u32 queue, bool napi_mode)
-{
-	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
-	struct sk_buff *skb;
-	struct page *page;
-
-	if (adapter->rx_frag_size > PAGE_SIZE) {
-		if (likely(napi_mode))
-			return napi_alloc_skb(&rrd_ring->napi,
-					      adapter->rx_buffer_len);
-		else
-			return netdev_alloc_skb_ip_align(adapter->netdev,
-							 adapter->rx_buffer_len);
-	}
-
-	page = rrd_ring->rx_page;
-	if (!page) {
-		page = alloc_page(GFP_ATOMIC);
-		if (unlikely(!page))
-			return NULL;
-		rrd_ring->rx_page = page;
-		rrd_ring->rx_page_offset = 0;
-	}
-
-	skb = build_skb(page_address(page) + rrd_ring->rx_page_offset,
-			adapter->rx_frag_size);
-	if (likely(skb)) {
-		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-		rrd_ring->rx_page_offset += adapter->rx_frag_size;
-		if (rrd_ring->rx_page_offset >= PAGE_SIZE)
-			rrd_ring->rx_page = NULL;
-		else
-			get_page(page);
-	}
-	return skb;
-}
-
 static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 				 bool napi_mode)
 {
 	struct atl1c_rfd_ring *rfd_ring = &adapter->rfd_ring[queue];
+	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
 	struct pci_dev *pdev = adapter->pdev;
 	struct atl1c_buffer *buffer_info, *next_info;
 	struct sk_buff *skb;
@@ -1814,13 +1765,27 @@ static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 	while (next_info->flags & ATL1C_BUFFER_FREE) {
 		rfd_desc = ATL1C_RFD_DESC(rfd_ring, rfd_next_to_use);
 
-		skb = atl1c_alloc_skb(adapter, queue, napi_mode);
+		/* When DMA RX address is set to something like
+		 * 0x....fc0, it will be very likely to cause DMA
+		 * RFD overflow issue.
+		 *
+		 * To work around it, we apply rx skb with 64 bytes
+		 * longer space, and offset the address whenever
+		 * 0x....fc0 is detected.
+		 */
+		if (likely(napi_mode))
+			skb = napi_alloc_skb(&rrd_ring->napi, adapter->rx_buffer_len + 64);
+		else
+			skb = netdev_alloc_skb(adapter->netdev, adapter->rx_buffer_len + 64);
 		if (unlikely(!skb)) {
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev, "alloc rx buffer failed\n");
 			break;
 		}
 
+		if (((unsigned long)skb->data & 0xfff) == 0xfc0)
+			skb_reserve(skb, 64);
+
 		/*
 		 * Make buffer alignment 2 beyond a 16 byte boundary
 		 * this will result in a 16 byte aligned IP header after
-- 
2.42.0

