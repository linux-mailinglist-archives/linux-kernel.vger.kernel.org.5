Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3E7E3C59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjKGMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjKGMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:14:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AF4220;
        Tue,  7 Nov 2023 04:11:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C02C433CC;
        Tue,  7 Nov 2023 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359077;
        bh=Aw+WavNJEFyQoSXX2QTBy/2kyLsJIMXF0GP9NDVNU5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/Ai+QlolRlS5dHc+R7gCo1jhZxAgaPgIGabk+vBpeI2zktyBDIoKFvJKkMRNnmdk
         GjugobF+C5GB3wSQUtc7HcU7EyohYjrVE1O2kc1C7L6BcqWGibgUenou6G3Va+L+tv
         Lw0tHgROtQmFgR73usL5muO9+UyUfH8DFlKsx3O1+BI9ab/kbQZuGfRwF9+jsNa86O
         dwm8ZQYJ7qygXjjYG3V8BC2ienEID3HEKMbn11I7YnJpwHFHVA1AJfOoSpgj6fMuSY
         avm71OaMcUMnEZ+OcGl6ATEMeE2lRQbsabambxooGY4Py9/XIfUN3u5J2+SHO3UxkM
         +rQ2Ul0ge3a0A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        horms@kernel.org, pavan.chebbi@broadcom.com,
        ruc_gongyuanjun@163.com, trix@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/18] atl1c: Work around the DMA RX overflow issue
Date:   Tue,  7 Nov 2023 07:10:34 -0500
Message-ID: <20231107121104.3757943-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 7762e532c6a4f..6eb86d75955fe 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -493,15 +493,10 @@ static int atl1c_set_mac_addr(struct net_device *netdev, void *p)
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
@@ -974,7 +969,6 @@ static void atl1c_init_ring_ptrs(struct atl1c_adapter *adapter)
 static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	int i;
 
 	dma_free_coherent(&pdev->dev, adapter->ring_header.size,
 			  adapter->ring_header.desc, adapter->ring_header.dma);
@@ -987,12 +981,6 @@ static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
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
@@ -1764,48 +1752,11 @@ static inline void atl1c_rx_checksum(struct atl1c_adapter *adapter,
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
@@ -1824,13 +1775,27 @@ static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
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

