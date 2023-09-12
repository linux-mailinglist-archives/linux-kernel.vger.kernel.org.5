Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7A79C1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjILBjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjILBi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:38:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFA169C75;
        Mon, 11 Sep 2023 18:16:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-573f8afe1d9so3802975a12.0;
        Mon, 11 Sep 2023 18:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694481396; x=1695086196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZa+8605iI8iTk8htTT2g78DAa5n7BwqlTMzbaFHlJA=;
        b=asbrDSiRuXTtFpA6q5BKJIIJ5O1Fbu3nL0LR75ayYglhC/VWMfH1RqMtcXt0Z2LVXL
         5+5GCpasOeWu05/n7HvAKbo2gqYgn3L9t/UirIanCaIYE6t+1/iX/skAGai02P7esxON
         DSI03qornJMsnBvqgYcymP7D0kNpPnAI4qJQ/s6klq2+cjlxCtuMXQh/1q8GW0w4e+P7
         U8fo8YWe++273bVsTDCTyI/lDXC13+4Dij3ohaicZ/DztwWcmXJjxCMhrtomtfW0/DeR
         QY583QXVOzlNtcFNV8tBzwuAB2SfStVWujL16WstuvJcQFXWn+AqUSj+RN3yBYe3mD8Q
         oyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694481396; x=1695086196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZa+8605iI8iTk8htTT2g78DAa5n7BwqlTMzbaFHlJA=;
        b=JTS7ljDHtZav3792gmswIwiRoWm3ulOQEYce+kUdXTd0lKrCnUujj4fpW2gGGcjVnB
         qnt94NduV+hEIb7BoS99sq/wKJ5I9DwhsTmWCXMlF+ngjk3shULPD7eGzBloUsdPcIS9
         NCwaQfZIft0dMcfPAiktDtUtqzWOBM86Z62uwA4j8SVeako+sx/bXgl9OdgzN+oyc6DW
         ee9jCodY7ETwF5G5l4zyOEBZpI+/eTiC6Y0pxlDR0SA46Umy+mqdYs+GFgqYeK7l5ZLJ
         47qqXVfW9HoVQNdxmxuuprcw4l0OexaBJ8QdiBEhBDIsTBrz+d91PGxl0DkaL4UB6FqB
         xi2A==
X-Gm-Message-State: AOJu0YyPjIMw81HNSLrNcnkM3M3WsU3eh4xzFuPvHftXjpssBHrn/G3j
        AY1KrXSnZy21rl2BFXqMSF/2Oa3JtJg=
X-Google-Smtp-Source: AGHT+IHlRjOnYny+QrGTWy12Sgqhvua3ZOZLt4S0GWSSJfDyWBf5U6tkTMFVukpSfyHrdUfziv0pbA==
X-Received: by 2002:a05:6a21:a103:b0:148:d5d9:aaa9 with SMTP id aq3-20020a056a21a10300b00148d5d9aaa9mr11443941pzc.33.1694480865627;
        Mon, 11 Sep 2023 18:07:45 -0700 (PDT)
Received: from localhost.localdomain ([104.28.194.88])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b0068c90e336ebsm6173237pfn.126.2023.09.11.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 18:07:45 -0700 (PDT)
From:   Sieng-Piaw Liew <liew.s.piaw@gmail.com>
To:     chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, edumazet@google.com, feng.tang@intel.com,
        linux-kernel@vger.kernel.org
Cc:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Subject: [PATCH net-next] atl1c: Work around the DMA RX overflow issue
Date:   Tue, 12 Sep 2023 09:07:11 +0800
Message-Id: <20230912010711.12036-1-liew.s.piaw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on alx driver commit 881d0327db37 ("net: alx: Work around
the DMA RX overflow issue").

The alx and atl1c drivers had RX overflow error which was why a custom
allocator was created to avoid certain addresses. The simpler workaround
then created for alx driver, but not for atl1c due to lack of tester.

Instead of using a custom allocator, check the allocated skb address and
use skb_reserve() to move away from problematic 0x...fc0 address.

Tested on AR8131 on Acer 4540.

Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c.h    |  3 -
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 67 +++++--------------
 2 files changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c.h b/drivers/net/ethernet/atheros/atl1c/atl1c.h
index 43d821fe7a54..63ba64dbb731 100644
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
index 940c5d1ff9cf..74b78164cf74 100644
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
2.34.1

