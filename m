Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC07988C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjIHObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIHObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:31:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E101FE0;
        Fri,  8 Sep 2023 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694183440; x=1725719440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09CLHJYF06z+jqAq0MqKYKVfwDgOLa0ChlMUjxzbJbk=;
  b=qnkFg0ia9pO/KAmAAx17x+Vx52UbDC/5j6KHbY1jrBaUS9nLOBGCBUAj
   nnlosTVfTgHcomqZM50heEDtyUgxlaS1R4zQTTG1jNTJmnXoo66GLY9qb
   +mSHI/dgUdRu+aQTHUVYAen94Q2ZxlWZ9An2PjOZM8KE/HYDeZVKBBBR+
   xZeZjn4QiZ4Thq6myQbEfIfyiAQCa4rJ/BYuRVgu17YdisFK0jZFKOoOH
   bfeGCqvnAGp+TRT76272H4UBdE1BN53aF7iSm9/kGSuaJnH9/TAF7c7ae
   ytrEcPnY4eiApTo2e6QhlZOJj3fYskFtMJ0w+AKXZa5BAnuk3sqA2ZQ8y
   A==;
X-CSE-ConnectionGUID: BfdJWj6dSkej858jQph4IQ==
X-CSE-MsgGUID: 6GlqnmBWTWe90D4pA6ooVw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="170641817"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 07:30:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 07:30:24 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 07:30:17 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [RFC PATCH net-next 4/6] net: ethernet: implement data transaction interface
Date:   Fri, 8 Sep 2023 19:59:17 +0530
Message-ID: <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethernet frame to be sent to MAC-PHY is converted into multiple
transmit data chunks. A transmit data chunk consists of a 4-byte data
header followed by the transmit data chunk payload.

The received ethernet frame from the network is converted into multiple
receive data chunks by the MAC-PHY and a receive data chunk consists of
the receive data chunk payload followed by a 4-byte data footer at the
end.

The MAC-PHY shall support a default data chunk payload size of 64 bytes.
Data chunk payload sizes of 32, 16, or 8 bytes may also be supported. The
data chunk payload is always a multiple of 4 bytes.

The 4-byte data header occurs at the beginning of each transmit data
chunk on MOSI and the 4-byte data footer occurs at the end of each
receive data chunk on MISO. The data header and footer contain the
information needed to determine the validity and location of the transmit
and receive frame data within the data chunk payload. Ethernet frames
shall be aligned to a 32-bit boundary within the data chunk payload.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 425 +++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        |  65 +++++-
 2 files changed, 485 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 65a7317f768d..20138b178185 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -5,6 +5,7 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
 
+#include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/oa_tc6.h>
@@ -193,17 +194,224 @@ int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
 	return ret;
 }
 
+static u16 oa_tc6_prepare_empty_chunk(struct oa_tc6 *tc6, u8 *buf, u8 cp_count)
+{
+	u32 hdr;
+
+	/* Prepare empty chunks used for getting interrupt information or if
+	 * receive data available.
+	 */
+	for (u8 i = 0; i < cp_count; i++) {
+		hdr = FIELD_PREP(DATA_HDR_DNC, 1);
+		hdr |= FIELD_PREP(DATA_HDR_P, oa_tc6_get_parity(hdr));
+		hdr = cpu_to_be32(hdr);
+		*(u32 *)&buf[i * (tc6->cps + TC6_HDR_SIZE)] = hdr;
+		memset(&buf[TC6_HDR_SIZE + (i * (tc6->cps + TC6_HDR_SIZE))], 0,
+		       tc6->cps);
+	}
+
+	return cp_count * (tc6->cps + TC6_HDR_SIZE);
+}
+
+static void oa_tc6_rx_eth_ready(struct oa_tc6 *tc6)
+{
+	struct sk_buff *skb = NULL;
+
+	/* Send the received ethernet packet to network layer */
+	skb = netdev_alloc_skb(tc6->netdev, tc6->rxd_bytes + NET_IP_ALIGN);
+	if (!skb) {
+		tc6->netdev->stats.rx_dropped++;
+		netdev_err(tc6->netdev, "Out of memory for rx'd frame");
+	} else {
+		skb_reserve(skb, NET_IP_ALIGN);
+		memcpy(skb_put(skb, tc6->rxd_bytes), &tc6->eth_rx_buf[0],
+		       tc6->rxd_bytes);
+		skb->protocol = eth_type_trans(skb, tc6->netdev);
+		tc6->netdev->stats.rx_packets++;
+		tc6->netdev->stats.rx_bytes += tc6->rxd_bytes;
+		netif_rx(skb);
+	}
+}
+
+static int oa_tc6_process_exst(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_STS0, &regval, 1);
+	if (ret) {
+		netdev_err(tc6->netdev, "STS0 register read failed.\n");
+		return ret;
+	}
+	if (regval & TXPE)
+		netdev_err(tc6->netdev, "Transmit protocol error\n");
+	if (regval & TXBOE)
+		netdev_err(tc6->netdev, "Transmit buffer overflow\n");
+	if (regval & TXBUE)
+		netdev_err(tc6->netdev, "Transmit buffer underflow\n");
+	if (regval & RXBOE)
+		netdev_err(tc6->netdev, "Receive buffer overflow\n");
+	if (regval & LOFE)
+		netdev_err(tc6->netdev, "Loss of frame\n");
+	if (regval & HDRE)
+		netdev_err(tc6->netdev, "Header error\n");
+	if (regval & TXFCSE)
+		netdev_err(tc6->netdev, "Transmit Frame Check Sequence Error\n");
+	ret = oa_tc6_write_register(tc6, OA_TC6_STS0, &regval, 1);
+	if (ret)
+		netdev_err(tc6->netdev, "STS0 register write failed.\n");
+	return ret;
+}
+
+static int oa_tc6_process_rx_chunks(struct oa_tc6 *tc6, u8 *buf, u16 len)
+{
+	u8 cp_count;
+	u8 *payload;
+	u32 ftr;
+	u16 ebo;
+	u16 sbo;
+
+	/* Calculate the number of chunks received */
+	cp_count = len / (tc6->cps + TC6_FTR_SIZE);
+
+	for (u8 i = 0; i < cp_count; i++) {
+		/* Get the footer and payload */
+		ftr = *(u32 *)&buf[tc6->cps + (i * (tc6->cps + TC6_FTR_SIZE))];
+		ftr = be32_to_cpu(ftr);
+		payload = &buf[(i * (tc6->cps + TC6_FTR_SIZE))];
+		/* Check for footer parity error */
+		if (oa_tc6_get_parity(ftr)) {
+			netdev_err(tc6->netdev, "Footer: Parity error\n");
+			goto err_exit;
+		}
+		/* If EXST set in the footer then read STS0 register to get the
+		 * status information.
+		 */
+		if (FIELD_GET(DATA_FTR_EXST, ftr)) {
+			if (oa_tc6_process_exst(tc6))
+				netdev_err(tc6->netdev, "Failed to process EXST\n");
+			goto err_exit;
+		}
+		if (FIELD_GET(DATA_FTR_HDRB, ftr)) {
+			netdev_err(tc6->netdev, "Footer: Received header bad\n");
+			goto err_exit;
+		}
+		if (!FIELD_GET(DATA_FTR_SYNC, ftr)) {
+			netdev_err(tc6->netdev, "Footer: Configuration unsync\n");
+			goto err_exit;
+		}
+		/* If Frame Drop is set, indicates that the MAC has detected a
+		 * condition for which the SPI host should drop the received
+		 * ethernet frame.
+		 */
+		if (FIELD_GET(DATA_FTR_FD, ftr) && FIELD_GET(DATA_FTR_EV, ftr)) {
+			netdev_warn(tc6->netdev, "Footer: Frame drop\n");
+			if (FIELD_GET(DATA_FTR_SV, ftr)) {
+				goto start_new_frame;
+			} else {
+				if (tc6->rx_eth_started) {
+					tc6->rxd_bytes = 0;
+					tc6->rx_eth_started = false;
+					tc6->netdev->stats.rx_dropped++;
+				}
+				continue;
+			}
+		}
+		/* Check for data valid */
+		if (FIELD_GET(DATA_FTR_DV, ftr)) {
+			/* Check whether both start valid and end valid are in a
+			 * single chunk payload means a single chunk payload may
+			 * contain an entire ethernet frame.
+			 */
+			if (FIELD_GET(DATA_FTR_SV, ftr) &&
+			    FIELD_GET(DATA_FTR_EV, ftr)) {
+				sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
+				ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
+				if (ebo <= sbo) {
+					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
+					       &payload[0], ebo);
+					tc6->rxd_bytes += ebo;
+					oa_tc6_rx_eth_ready(tc6);
+					tc6->rxd_bytes = 0;
+					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
+					       &payload[sbo], tc6->cps - sbo);
+					tc6->rxd_bytes += (tc6->cps - sbo);
+					goto exit;
+				} else {
+					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
+					       &payload[sbo], ebo - sbo);
+					tc6->rxd_bytes += (ebo - sbo);
+					oa_tc6_rx_eth_ready(tc6);
+					tc6->rxd_bytes = 0;
+					goto exit;
+				}
+			}
+start_new_frame:
+			/* Check for start valid to start capturing the incoming
+			 * ethernet frame.
+			 */
+			if (FIELD_GET(DATA_FTR_SV, ftr) && !tc6->rx_eth_started) {
+				tc6->rxd_bytes = 0;
+				tc6->rx_eth_started = true;
+				sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
+				memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
+				       &payload[sbo], tc6->cps - sbo);
+				tc6->rxd_bytes += (tc6->cps - sbo);
+				goto exit;
+			}
+
+			/* Check for end valid and calculate the copy length */
+			if (tc6->rx_eth_started) {
+				if (FIELD_GET(DATA_FTR_EV, ftr))
+					ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
+				else
+					ebo = tc6->cps;
+
+				memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
+				       &payload[0], ebo);
+				tc6->rxd_bytes += ebo;
+				if (FIELD_GET(DATA_FTR_EV, ftr)) {
+					/* If End Valid set then send the
+					 * received ethernet frame to n/w.
+					 */
+					oa_tc6_rx_eth_ready(tc6);
+					tc6->rxd_bytes = 0;
+					tc6->rx_eth_started = false;
+				}
+			}
+		}
+
+exit:
+		tc6->txc = FIELD_GET(DATA_FTR_TXC, ftr);
+		tc6->rca = FIELD_GET(DATA_FTR_RCA, ftr);
+	}
+	return FTR_OK;
+
+err_exit:
+	if (tc6->rx_eth_started) {
+		tc6->rxd_bytes = 0;
+		tc6->rx_eth_started = false;
+		tc6->netdev->stats.rx_dropped++;
+	}
+	return FTR_ERR;
+}
+
 static int oa_tc6_handler(void *data)
 {
 	struct oa_tc6 *tc6 = data;
+	bool txc_wait = false;
+	u16 tx_pos = 0;
 	u32 regval;
+	u16 len;
 	int ret;
 
 	while (likely(!kthread_should_stop())) {
-		wait_event_interruptible(tc6->tc6_wq, tc6->int_flag ||
+		wait_event_interruptible(tc6->tc6_wq, tc6->tx_flag ||
+					 tc6->int_flag || tc6->rca ||
 					 kthread_should_stop());
-		if (tc6->int_flag) {
+		if (tc6->int_flag && !tc6->reset) {
 			tc6->int_flag = false;
+			tc6->reset = true;
 			ret = oa_tc6_perform_ctrl(tc6, OA_TC6_STS0, &regval, 1,
 						  false, false);
 			if (ret) {
@@ -227,10 +435,170 @@ static int oa_tc6_handler(void *data)
 				complete(&tc6->rst_complete);
 			}
 		}
+
+		if (tc6->int_flag || tc6->rca) {
+			/* If rca is updated from the previous footer then
+			 * prepare the empty chunks equal to rca and perform
+			 * SPI transfer to receive the ethernet frame.
+			 */
+			if (tc6->rca) {
+				len = oa_tc6_prepare_empty_chunk(tc6,
+								 tc6->spi_tx_buf,
+								 tc6->rca);
+			} else {
+				/* If there is an interrupt then perform a SPI
+				 * transfer with a empty chunk to get the
+				 * details.
+				 */
+				tc6->int_flag = false;
+				len = oa_tc6_prepare_empty_chunk(tc6,
+								 tc6->spi_tx_buf,
+								 1);
+			}
+			/* Perform SPI transfer */
+			ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
+						  tc6->spi_rx_buf, len);
+			if (ret) {
+				netdev_err(tc6->netdev, "SPI transfer failed\n");
+				continue;
+			}
+			/* Process the received chunks to get the ethernet frame
+			 * or interrupt details.
+			 */
+			if (oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf, len))
+				continue;
+		}
+
+		/* If there is a tx ethernet frame available */
+		if (tc6->tx_flag || txc_wait) {
+			tc6->tx_flag = false;
+			txc_wait = false;
+			len = 0;
+			if (!tc6->txc) {
+				/* If there is no txc available to transport the
+				 * tx ethernet frames then wait for the MAC-PHY
+				 * interrupt to get the txc availability.
+				 */
+				txc_wait = true;
+				continue;
+			} else if (tc6->txc >= tc6->txc_needed) {
+				len = tc6->txc_needed * (tc6->cps + TC6_HDR_SIZE);
+			} else {
+				len = tc6->txc * (tc6->cps + TC6_HDR_SIZE);
+			}
+			memcpy(&tc6->spi_tx_buf[0], &tc6->eth_tx_buf[tx_pos],
+			       len);
+			ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
+						  tc6->spi_rx_buf, len);
+			if (ret) {
+				netdev_err(tc6->netdev, "SPI transfer failed\n");
+				continue;
+			}
+			/* Process the received chunks to get the ethernet frame
+			 * or status.
+			 */
+			if (oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf,
+						     len)) {
+				/* In case of error while processing rx chunks
+				 * discard the incomplete tx ethernet frame and
+				 * resend it.
+				 */
+				tx_pos = 0;
+				tc6->txc_needed = tc6->total_txc_needed;
+			} else {
+				tx_pos += len;
+				tc6->txc_needed = tc6->txc_needed -
+						  (len / (tc6->cps + TC6_HDR_SIZE));
+				/* If the complete ethernet frame is transmitted
+				 * then return the skb and update the details to
+				 * n/w layer.
+				 */
+				if (!tc6->txc_needed) {
+					tc6->netdev->stats.tx_packets++;
+					tc6->netdev->stats.tx_bytes += tc6->tx_skb->len;
+					dev_kfree_skb(tc6->tx_skb);
+					tx_pos = 0;
+					tc6->tx_skb = NULL;
+					if (netif_queue_stopped(tc6->netdev))
+						netif_wake_queue(tc6->netdev);
+				} else if (tc6->txc) {
+					/* If txc is available again and updated
+					 * from the previous footer then perform
+					 * tx again.
+					 */
+					tc6->tx_flag = true;
+				} else {
+					/* If there is no txc then wait for the
+					 * interrupt to indicate txc
+					 * availability.
+					 */
+					txc_wait = true;
+				}
+			}
+		}
 	}
 	return 0;
 }
 
+static void oa_tc6_prepare_tx_chunks(struct oa_tc6 *tc6, u8 *buf,
+				     struct sk_buff *skb)
+{
+	bool frame_started = false;
+	u16 copied_bytes = 0;
+	u16 copy_len;
+	u32 hdr;
+
+	/* Calculate the number tx credit counts needed to transport the tx
+	 * ethernet frame.
+	 */
+	tc6->txc_needed = (skb->len / tc6->cps) + ((skb->len % tc6->cps) ? 1 : 0);
+	tc6->total_txc_needed = tc6->txc_needed;
+
+	for (u8 i = 0; i < tc6->txc_needed; i++) {
+		/* Prepare the header for each chunks to be transmitted */
+		hdr = FIELD_PREP(DATA_HDR_DNC, 1) |
+		      FIELD_PREP(DATA_HDR_DV, 1);
+		if (!frame_started) {
+			hdr |= FIELD_PREP(DATA_HDR_SV, 1) |
+			       FIELD_PREP(DATA_HDR_SWO, 0);
+			frame_started = true;
+		}
+		if ((tc6->cps + copied_bytes) >= skb->len) {
+			copy_len = skb->len - copied_bytes;
+			hdr |= FIELD_PREP(DATA_HDR_EBO, copy_len - 1) |
+			       FIELD_PREP(DATA_HDR_EV, 1);
+		} else {
+			copy_len = tc6->cps;
+		}
+		copied_bytes += copy_len;
+		hdr |= FIELD_PREP(DATA_HDR_P, oa_tc6_get_parity(hdr));
+		hdr = cpu_to_be32(hdr);
+		*(u32 *)&buf[i * (tc6->cps + TC6_HDR_SIZE)] = hdr;
+		/* Copy the ethernet frame in the chunk payload section */
+		memcpy(&buf[TC6_HDR_SIZE + (i * (tc6->cps + TC6_HDR_SIZE))],
+		       &skb->data[copied_bytes - copy_len], copy_len);
+	}
+}
+
+netdev_tx_t oa_tc6_send_eth_pkt(struct oa_tc6 *tc6, struct sk_buff *skb)
+{
+	if (tc6->tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	tc6->tx_skb = skb;
+	/* Prepare tx chunks using the tx ethernet frame */
+	oa_tc6_prepare_tx_chunks(tc6, tc6->eth_tx_buf, skb);
+
+	/* Wake tc6 task to perform tx transfer */
+	tc6->tx_flag = true;
+	wake_up_interruptible(&tc6->tc6_wq);
+
+	return NETDEV_TX_OK;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_send_eth_pkt);
+
 static irqreturn_t macphy_irq(int irq, void *dev_id)
 {
 	struct oa_tc6 *tc6 = dev_id;
@@ -293,6 +661,14 @@ int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr
 	u32 regval;
 	int ret;
 
+	/* Read BUFSTS register to get the current txc and rca. */
+	ret = oa_tc6_read_register(tc6, OA_TC6_BUFSTS, &regval, 1);
+	if (ret)
+		return ret;
+
+	tc6->txc = FIELD_GET(TXC, regval);
+	tc6->rca = FIELD_GET(RCA, regval);
+
 	/* Read and configure the IMASK0 register for unmasking the interrupts */
 	ret = oa_tc6_read_register(tc6, OA_TC6_IMASK0, &regval, 1);
 	if (ret)
@@ -326,7 +702,7 @@ int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr
 }
 EXPORT_SYMBOL_GPL(oa_tc6_configure);
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 {
 	struct oa_tc6 *tc6;
 	int ret;
@@ -334,11 +710,39 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 	if (!spi)
 		return NULL;
 
+	if (!netdev)
+		return NULL;
+
 	tc6 = kzalloc(sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
 		return NULL;
 
 	tc6->spi = spi;
+	tc6->netdev = netdev;
+
+	/* Allocate memory for the tx buffer used for SPI transfer. */
+	tc6->spi_tx_buf = kzalloc(MAX_ETH_LEN + (OA_TC6_MAX_CPS * TC6_HDR_SIZE),
+				  GFP_KERNEL);
+	if (!tc6->spi_tx_buf)
+		goto err_spi_tx_buf_alloc;
+
+	/* Allocate memory for the rx buffer used for SPI transfer. */
+	tc6->spi_rx_buf = kzalloc(MAX_ETH_LEN + (OA_TC6_MAX_CPS * TC6_FTR_SIZE),
+				  GFP_KERNEL);
+	if (!tc6->spi_rx_buf)
+		goto err_spi_rx_buf_alloc;
+
+	/* Allocate memory for the tx ethernet chunks to transfer on SPI. */
+	tc6->eth_tx_buf = kzalloc(MAX_ETH_LEN + (OA_TC6_MAX_CPS * TC6_HDR_SIZE),
+				  GFP_KERNEL);
+	if (!tc6->eth_tx_buf)
+		goto err_eth_tx_buf_alloc;
+
+	/* Allocate memory for the rx ethernet packet. */
+	tc6->eth_rx_buf = kzalloc(MAX_ETH_LEN + (OA_TC6_MAX_CPS * TC6_FTR_SIZE),
+				  GFP_KERNEL);
+	if (!tc6->eth_rx_buf)
+		goto err_eth_rx_buf_alloc;
 
 	/* Used for triggering the OA TC6 task */
 	init_waitqueue_head(&tc6->tc6_wq);
@@ -372,6 +776,14 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 err_macphy_irq:
 	kthread_stop(tc6->tc6_task);
 err_tc6_task:
+	kfree(tc6->eth_rx_buf);
+err_eth_rx_buf_alloc:
+	kfree(tc6->eth_tx_buf);
+err_eth_tx_buf_alloc:
+	kfree(tc6->spi_rx_buf);
+err_spi_rx_buf_alloc:
+	kfree(tc6->spi_tx_buf);
+err_spi_tx_buf_alloc:
 	kfree(tc6);
 	return NULL;
 }
@@ -383,8 +795,13 @@ int oa_tc6_deinit(struct oa_tc6 *tc6)
 
 	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
 	ret = kthread_stop(tc6->tc6_task);
-	if (!ret)
+	if (!ret) {
+		kfree(tc6->eth_rx_buf);
+		kfree(tc6->eth_tx_buf);
+		kfree(tc6->spi_rx_buf);
+		kfree(tc6->spi_tx_buf);
 		kfree(tc6);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_deinit);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index fa29c4e09720..61ac1cdfa7d6 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/spi/spi.h>
+#include <linux/netdevice.h>
 
 /* Control header */
 #define CTRL_HDR_DNC	BIT(31)		/* Data-Not-Control */
@@ -17,10 +18,36 @@
 #define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
 #define CTRL_HDR_P	BIT(0)		/* Parity Bit */
 
+/* Data header */
+#define DATA_HDR_DNC	BIT(31)		/* Data-Not-Control */
+#define DATA_HDR_SEQ	BIT(30)		/* Data Chunk Sequence */
+#define DATA_HDR_NORX	BIT(29)		/* No Receive */
+#define DATA_HDR_DV	BIT(21)		/* Data Valid */
+#define DATA_HDR_SV	BIT(20)		/* Start Valid */
+#define DATA_HDR_SWO	GENMASK(19, 16)	/* Start Word Offset */
+#define DATA_HDR_EV	BIT(14)		/* End Valid */
+#define DATA_HDR_EBO	GENMASK(13, 8)	/* End Byte Offset */
+#define DATA_HDR_P	BIT(0)		/* Header Parity Bit */
+
+/* Data footer */
+#define DATA_FTR_EXST	BIT(31)		/* Extended Status */
+#define DATA_FTR_HDRB	BIT(30)		/* Received Header Bad */
+#define DATA_FTR_SYNC	BIT(29)		/* Configuration Synchronized */
+#define DATA_FTR_RCA	GENMASK(28, 24)	/* Receive Chunks Available */
+#define DATA_FTR_DV	BIT(21)		/* Data Valid */
+#define DATA_FTR_SV	BIT(20)		/* Start Valid */
+#define DATA_FTR_SWO	GENMASK(19, 16)	/* Start Word Offset */
+#define DATA_FTR_FD	BIT(15)		/* Frame Drop */
+#define DATA_FTR_EV	BIT(14)		/* End Valid */
+#define DATA_FTR_EBO	GENMASK(13, 8)	/* End Byte Offset */
+#define DATA_FTR_TXC	GENMASK(5, 1)	/* Transmit Credits */
+#define DATA_FTR_P	BIT(0)		/* Footer Parity Bit */
+
 /* Open Alliance TC6 Standard Control and Status Registers */
 #define OA_TC6_RESET	0x0003		/* Reset Control and Status Register */
 #define OA_TC6_CONFIG0	0x0004		/* Configuration Register #0 */
 #define OA_TC6_STS0	0x0008		/* Status Register #0 */
+#define OA_TC6_BUFSTS	0x000B          /* Buffer Status Register */
 #define OA_TC6_IMASK0	0x000C		/* Interrupt Mask Register #0 */
 
 /* RESET register field */
@@ -33,6 +60,17 @@
 #define PROTE		BIT(5)		/* Ctrl read/write Protection Enable */
 #define CPS		GENMASK(2, 0)	/* Chunk Payload Size */
 
+/* STATUS0 register fields */
+#define CDPE		BIT(12)		/* Control Data Protection Error */
+#define TXFCSE		BIT(11)		/* Transmit Frame Check Sequence Error */
+#define RESETC		BIT(6)		/* Reset Complete */
+#define HDRE		BIT(5)		/* Header Error */
+#define LOFE		BIT(4)		/* Loss of Framing Error */
+#define RXBOE		BIT(3)		/* Receive Buffer Overflow Error */
+#define TXBUE		BIT(2)		/* Transmit Buffer Underflow Error */
+#define TXBOE		BIT(1)		/* Transmit Buffer Overflow Error */
+#define TXPE		BIT(0)		/* Transmit Protocol Error */
+
 /* Unmasking interrupt fields in IMASK0 */
 #define HDREM		~BIT(5)		/* Header Error Mask */
 #define LOFEM		~BIT(4)		/* Loss of Framing Error Mask */
@@ -44,24 +82,49 @@
 /* STATUS0 register field */
 #define RESETC		BIT(6)		/* Reset Complete */
 
+/* BUFSTS register fields */
+#define TXC		GENMASK(15, 8)	/* Transmit Credits Available */
+#define RCA		GENMASK(7, 0)	/* Receive Chunks Available */
+
 #define TC6_HDR_SIZE	4		/* Ctrl command header size as per OA */
 #define TC6_FTR_SIZE	4		/* Ctrl command footer size ss per OA */
 
+#define FTR_OK		0
+#define FTR_ERR		1
+
+#define MAX_ETH_LEN	1536
+#define OA_TC6_MAX_CPS	64
+
 struct oa_tc6 {
 	struct completion rst_complete;
 	struct task_struct *tc6_task;
+	struct net_device *netdev;
 	wait_queue_head_t tc6_wq;
 	struct spi_device *spi;
+	struct sk_buff *tx_skb;
+	u8 total_txc_needed;
+	bool rx_eth_started;
 	bool tx_cut_thr;
 	bool rx_cut_thr;
 	bool ctrl_prot;
+	u8 *spi_tx_buf;
+	u8 *spi_rx_buf;
+	u8 *eth_tx_buf;
+	u8 *eth_rx_buf;
 	bool int_flag;
+	u16 rxd_bytes;
+	u8 txc_needed;
+	bool tx_flag;
+	bool reset;
 	u8 cps;
+	u8 txc;
+	u8 rca;
 };
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
 int oa_tc6_deinit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
 int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr,
 		     bool rx_cut_thr);
+netdev_tx_t oa_tc6_send_eth_pkt(struct oa_tc6 *tc6, struct sk_buff *skb);
-- 
2.34.1

