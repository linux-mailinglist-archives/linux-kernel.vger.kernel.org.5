Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5487D3B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJWPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjJWPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:49:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809710E2;
        Mon, 23 Oct 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076181; x=1729612181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/izdiZhTIAFpixIdmHImp1j/dWWgoDq11M5yXTYGQk=;
  b=y+FtTpZ7aeV7zD5ssUNDxtEK/ilsnrF4QlG0xUxmAs7jzGeDaBl+V564
   E2qip0F1SVdBdk8Bt8/JhZYtfjuoLYNiP2V4l+Wl5LlXUYylWz6JwXazT
   rD4g4zTTTsb8fQk/jyHKbMOqcq3+5uON1luQ3n/g/WT90rekB5luvdgrW
   iiFS4dwW87AM/3IkTQXuuSVuAbnHc18Z8q4i65H8Hi71A2uySU3A31NQl
   8hPiBkObxUV5vZ8+cW2/YVzhNVjLNJE8wcE+lyVS9k9fwpcWCZm1/Cpcf
   yMW3faBAuIVfygl4yE9t58/VEgvi5VcIcPZEuEGwS/0eMf/LvFXXWAKLU
   g==;
X-CSE-ConnectionGUID: QHZHViV/SCKDGxPPfhUelg==
X-CSE-MsgGUID: Jfx4f8Y7TT2VvZGTiS4uyQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="241208245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:49:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:48:44 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:48:30 -0700
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
Subject: [PATCH net-next v2 7/9] net: ethernet: oa_tc6: implement data transaction interface
Date:   Mon, 23 Oct 2023 21:16:47 +0530
Message-ID: <20231023154649.45931-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
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
 drivers/net/ethernet/oa_tc6.c | 546 +++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        |  47 ++-
 2 files changed, 591 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index a4532c83e909..1306ca0b0884 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -14,17 +14,36 @@
 
 /* Opaque structure for MACPHY drivers */
 struct oa_tc6 {
+	int (*config_cps_buf)(void *tc6, u32 cps);
+	struct work_struct tx_work;
 	struct net_device *netdev;
 	struct phy_device *phydev;
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
+	struct sk_buff *tx_skb;
+	bool rx_eth_started;
 	struct device *dev;
+	/* Protects oa_tc6_perform_spi_xfer function elements between MAC-PHY
+	 * interrupt handler and the tx work handler.
+	 */
+	struct mutex lock;
 	u8 *ctrl_tx_buf;
 	u8 *ctrl_rx_buf;
+	u8 *spi_tx_buf;
+	u8 *spi_rx_buf;
+	u8 *eth_tx_buf;
+	u8 *eth_rx_buf;
+	u16 rxd_bytes;
+	u8 txc_needed;
+	bool int_flag;
+	bool tx_flag;
 	bool dprac;
 	bool iprac;
 	bool prote;
+	u16 tx_pos;
 	u32 cps;
+	u8 txc;
+	u8 rca;
 };
 
 static int oa_tc6_spi_transfer(struct spi_device *spi, u8 *ptx, u8 *prx, u16 len)
@@ -55,6 +74,24 @@ static int oa_tc6_get_parity(u32 p)
 	return !((p >> 28) & 1);
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
+		*(__be32 *)&buf[i * (tc6->cps + TC6_HDR_SIZE)] = cpu_to_be32(hdr);
+		memset(&buf[TC6_HDR_SIZE + (i * (tc6->cps + TC6_HDR_SIZE))], 0,
+		       tc6->cps);
+	}
+
+	return cp_count * (tc6->cps + TC6_HDR_SIZE);
+}
+
 static void oa_tc6_prepare_ctrl_buf(struct oa_tc6 *tc6, u32 addr, u32 val[],
 				    u8 len, bool wnr, u8 *buf, bool prote)
 {
@@ -218,6 +255,14 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 	bool ctc;
 	int ret;
 
+	/* Read BUFSTS register to get the current txc and rca. */
+	ret = oa_tc6_read_register(tc6, OA_TC6_BUFSTS, &regval);
+	if (ret)
+		return ret;
+
+	tc6->txc = FIELD_GET(TXC, regval);
+	tc6->rca = FIELD_GET(RCA, regval);
+
 	/* Read and configure the IMASK0 register for unmasking the interrupts */
 	ret = oa_tc6_perform_ctrl(tc6, IMASK0, &regval, 1, false, false);
 	if (ret)
@@ -259,6 +304,12 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 		} else {
 			tc6->cps = OA_TC6_MAX_CPS;
 		}
+		/* Call queue buffer size config function if defined by MAC */
+		if (tc6->config_cps_buf) {
+			ret = tc6->config_cps_buf(tc6, tc6->cps);
+			if (ret)
+				return ret;
+		}
 		if (of_property_present(oa_node, "oa-txcte")) {
 			/* Return error if the tx cut through mode is configured
 			 * but it is not supported by MAC-PHY.
@@ -498,6 +549,240 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 	return 0;
 }
 
+static int oa_tc6_process_exst(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, STATUS0, &regval);
+	if (ret)
+		return ret;
+
+	if (regval & TXPE)
+		net_err_ratelimited("%s: Transmit protocol error\n",
+				    tc6->netdev->name);
+
+	if (regval & TXBOE)
+		net_err_ratelimited("%s: Transmit buffer overflow\n",
+				    tc6->netdev->name);
+
+	if (regval & TXBUE)
+		net_err_ratelimited("%s: Transmit buffer underflow\n",
+				    tc6->netdev->name);
+
+	if (regval & RXBOE)
+		net_err_ratelimited("%s: Receive buffer overflow\n",
+				    tc6->netdev->name);
+
+	if (regval & LOFE)
+		net_err_ratelimited("%s: Loss of frame\n", tc6->netdev->name);
+
+	if (regval & HDRE)
+		net_err_ratelimited("%s: Header error\n", tc6->netdev->name);
+
+	if (regval & TXFCSE)
+		net_err_ratelimited("%s: Tx Frame Check Seq Error\n",
+				    tc6->netdev->name);
+
+	return oa_tc6_write_register(tc6, STATUS0, regval);
+}
+
+static void oa_tc6_rx_eth_ready(struct oa_tc6 *tc6)
+{
+	struct sk_buff *skb;
+
+	/* Send the received ethernet packet to network layer */
+	skb = netdev_alloc_skb(tc6->netdev, tc6->rxd_bytes + NET_IP_ALIGN);
+	if (!skb) {
+		tc6->netdev->stats.rx_dropped++;
+		netdev_dbg(tc6->netdev, "Out of memory for rx'd frame");
+	} else {
+		skb_reserve(skb, NET_IP_ALIGN);
+		memcpy(skb_put(skb, tc6->rxd_bytes), &tc6->eth_rx_buf[0],
+		       tc6->rxd_bytes);
+		skb->protocol = eth_type_trans(skb, tc6->netdev);
+		tc6->netdev->stats.rx_packets++;
+		tc6->netdev->stats.rx_bytes += tc6->rxd_bytes;
+		/* 0 for NET_RX_SUCCESS and 1 for NET_RX_DROP */
+		if (netif_rx(skb))
+			tc6->netdev->stats.rx_dropped++;
+	}
+}
+
+static void oa_tc6_rx_eth_complete2(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
+{
+	u16 ebo;
+
+	if (FIELD_GET(DATA_FTR_EV, ftr))
+		ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
+	else
+		ebo = tc6->cps;
+
+	memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[0], ebo);
+	tc6->rxd_bytes += ebo;
+	if (FIELD_GET(DATA_FTR_EV, ftr)) {
+		/* If EV set then send the received ethernet frame to n/w */
+		oa_tc6_rx_eth_ready(tc6);
+		tc6->rxd_bytes = 0;
+		tc6->rx_eth_started = false;
+	}
+}
+
+static void oa_tc6_rx_eth_complete1(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
+{
+	u16 ebo;
+	u16 sbo;
+
+	sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
+	ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
+
+	if (ebo <= sbo) {
+		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[0], ebo);
+		tc6->rxd_bytes += ebo;
+		oa_tc6_rx_eth_ready(tc6);
+		tc6->rxd_bytes = 0;
+		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo],
+		       tc6->cps - sbo);
+		tc6->rxd_bytes += (tc6->cps - sbo);
+	} else {
+		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo],
+		       ebo - sbo);
+		tc6->rxd_bytes += (ebo - sbo);
+		oa_tc6_rx_eth_ready(tc6);
+		tc6->rxd_bytes = 0;
+	}
+}
+
+static void oa_tc6_start_rx_eth(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
+{
+	u16 sbo;
+
+	tc6->rxd_bytes = 0;
+	tc6->rx_eth_started = true;
+	sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
+	memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo], tc6->cps - sbo);
+	tc6->rxd_bytes += (tc6->cps - sbo);
+}
+
+static u32 oa_tc6_get_footer(struct oa_tc6 *tc6, u8 *buf, u8 cp_num)
+{
+	__be32 ftr;
+
+	ftr = *(__be32 *)&buf[tc6->cps + (cp_num * (tc6->cps + TC6_FTR_SIZE))];
+
+	return be32_to_cpu(ftr);
+}
+
+static void oa_tc6_update_txc_rca(struct oa_tc6 *tc6, u32 ftr)
+{
+	tc6->txc = FIELD_GET(DATA_FTR_TXC, ftr);
+	tc6->rca = FIELD_GET(DATA_FTR_RCA, ftr);
+}
+
+static int oa_tc6_check_ftr_errors(struct oa_tc6 *tc6, u32 ftr)
+{
+	/* Check for footer parity error */
+	if (oa_tc6_get_parity(ftr)) {
+		net_err_ratelimited("%s: Footer parity error\n",
+				    tc6->netdev->name);
+		return FTR_ERR;
+	}
+	/* If EXST set in the footer then read STS0 register to get the
+	 * status information.
+	 */
+	if (FIELD_GET(DATA_FTR_EXST, ftr)) {
+		if (oa_tc6_process_exst(tc6))
+			net_err_ratelimited("%s: Failed to process EXST\n",
+					    tc6->netdev->name);
+		return FTR_ERR;
+	}
+	if (FIELD_GET(DATA_FTR_HDRB, ftr)) {
+		net_err_ratelimited("%s: Footer eeceived header bad\n",
+				    tc6->netdev->name);
+		return FTR_ERR;
+	}
+	if (!FIELD_GET(DATA_FTR_SYNC, ftr)) {
+		net_err_ratelimited("%s: Footer configuration unsync\n",
+				    tc6->netdev->name);
+		return FTR_ERR;
+	}
+	return FTR_OK;
+}
+
+static void oa_tc6_drop_rx_eth(struct oa_tc6 *tc6)
+{
+	tc6->rxd_bytes = 0;
+	tc6->rx_eth_started = false;
+	tc6->netdev->stats.rx_dropped++;
+	net_err_ratelimited("%s: Footer frame drop\n",
+			    tc6->netdev->name);
+}
+
+static int oa_tc6_process_rx_chunks(struct oa_tc6 *tc6, u8 *buf, u16 len)
+{
+	u8 cp_count;
+	u8 *payload;
+	u32 ftr;
+	int ret;
+
+	/* Calculate the number of chunks received */
+	cp_count = len / (tc6->cps + TC6_FTR_SIZE);
+
+	for (u8 i = 0; i < cp_count; i++) {
+		/* Get the footer and payload */
+		ftr = oa_tc6_get_footer(tc6, buf, i);
+		payload = &buf[(i * (tc6->cps + TC6_FTR_SIZE))];
+		/* Check for footer errors */
+		ret = oa_tc6_check_ftr_errors(tc6, ftr);
+		if (ret) {
+			if (tc6->rx_eth_started)
+				oa_tc6_drop_rx_eth(tc6);
+			return ret;
+		}
+		/* If Frame Drop is set, indicates that the MAC has detected a
+		 * condition for which the SPI host should drop the received
+		 * ethernet frame.
+		 */
+		if (FIELD_GET(DATA_FTR_FD, ftr) && FIELD_GET(DATA_FTR_EV, ftr)) {
+			if (tc6->rx_eth_started)
+				oa_tc6_drop_rx_eth(tc6);
+
+			if (FIELD_GET(DATA_FTR_SV, ftr)) {
+				oa_tc6_start_rx_eth(tc6, payload, ftr);
+				oa_tc6_update_txc_rca(tc6, ftr);
+			}
+			continue;
+		}
+		/* Check for data valid */
+		if (FIELD_GET(DATA_FTR_DV, ftr)) {
+			/* Check whether both start valid and end valid are in a
+			 * single chunk payload means a single chunk payload may
+			 * contain an entire ethernet frame.
+			 */
+			if (FIELD_GET(DATA_FTR_SV, ftr) &&
+			    FIELD_GET(DATA_FTR_EV, ftr)) {
+				oa_tc6_rx_eth_complete1(tc6, payload, ftr);
+				oa_tc6_update_txc_rca(tc6, ftr);
+				continue;
+			}
+			/* Check for start valid to start capturing the incoming
+			 * ethernet frame.
+			 */
+			if (FIELD_GET(DATA_FTR_SV, ftr) && !tc6->rx_eth_started) {
+				oa_tc6_start_rx_eth(tc6, payload, ftr);
+				oa_tc6_update_txc_rca(tc6, ftr);
+				continue;
+			}
+
+			/* Check for end valid and calculate the copy length */
+			if (tc6->rx_eth_started)
+				oa_tc6_rx_eth_complete2(tc6, payload, ftr);
+		}
+		oa_tc6_update_txc_rca(tc6, ftr);
+	}
+	return FTR_OK;
+}
+
 static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 {
 	phy_disconnect(tc6->phydev);
@@ -505,17 +790,237 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 	mdiobus_free(tc6->mdiobus);
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
+		*(__be32 *)&buf[i * (tc6->cps + TC6_HDR_SIZE)] = cpu_to_be32(hdr);
+		/* Copy the ethernet frame in the chunk payload section */
+		memcpy(&buf[TC6_HDR_SIZE + (i * (tc6->cps + TC6_HDR_SIZE))],
+		       &skb->data[copied_bytes - copy_len], copy_len);
+	}
+}
+
+static u16 oa_tc6_calculate_tx_len(struct oa_tc6 *tc6)
+{
+	/* If the available txc is greater than the txc needed (calculated from
+	 * the tx ethernet frame then the tx length can be txc needed. Else the
+	 * tx length can be available txc and the remaining needed txc will be
+	 * updated either in the footer of the current transfer or through the
+	 * interrupt.
+	 */
+	if (tc6->txc >= tc6->txc_needed)
+		return tc6->txc_needed * (tc6->cps + TC6_HDR_SIZE);
+	else
+		return tc6->txc * (tc6->cps + TC6_HDR_SIZE);
+}
+
+static u16 oa_tc6_calculate_rca_len(struct oa_tc6 *tc6, u16 tx_len)
+{
+	u16 rca_needed = 0;
+	u16 tx_txc;
+
+	/* If tx eth frame and rca are available at the same time then check
+	 * whether the rca is less than the needed txc for the tx eth frame. If
+	 * not then add additional empty chunks along with the tx chunks to get
+	 * all the rca.
+	 */
+	if (tc6->tx_flag && tc6->txc) {
+		tx_txc = tc6->txc_needed - (tx_len / (tc6->cps + TC6_HDR_SIZE));
+		if (tx_txc < tc6->rca)
+			rca_needed = tc6->rca - tx_txc;
+	} else {
+		/* Add only empty chunks for rca if there is no tx chunks
+		 * available to transmit.
+		 */
+		rca_needed = tc6->rca;
+	}
+	return oa_tc6_prepare_empty_chunk(tc6, &tc6->spi_tx_buf[tx_len],
+					  rca_needed);
+}
+
+static void oa_tc6_tx_eth_complete(struct oa_tc6 *tc6)
+{
+	tc6->netdev->stats.tx_packets++;
+	tc6->netdev->stats.tx_bytes += tc6->tx_skb->len;
+	dev_kfree_skb(tc6->tx_skb);
+	tc6->tx_pos = 0;
+	tc6->tx_skb = NULL;
+	tc6->tx_flag = false;
+	if (netif_queue_stopped(tc6->netdev))
+		netif_wake_queue(tc6->netdev);
+}
+
+static int oa_tc6_perform_spi_xfer(struct oa_tc6 *tc6)
+{
+	bool do_tx_again;
+	u16 total_len;
+	u16 rca_len;
+	u16 tx_len;
+	int ret;
+
+	do {
+		do_tx_again = false;
+		rca_len = 0;
+		tx_len = 0;
+
+		/* In case of an interrupt, perform an empty chunk transfer to
+		 * know the purpose of the interrupt. Interrupt may occur in
+		 * case of RCA (Receive Chunk Available) and TXC (Transmit
+		 * Credit Count). Both will occur if they are not indicated
+		 * through the previous footer.
+		 */
+		if (tc6->int_flag) {
+			tc6->int_flag = false;
+			total_len = oa_tc6_prepare_empty_chunk(tc6,
+							       tc6->spi_tx_buf,
+							       1);
+		} else {
+			/* Calculate the transfer length */
+			if (tc6->tx_flag && tc6->txc) {
+				tx_len = oa_tc6_calculate_tx_len(tc6);
+				memcpy(&tc6->spi_tx_buf[0],
+				       &tc6->eth_tx_buf[tc6->tx_pos], tx_len);
+			}
+
+			if (tc6->rca)
+				rca_len = oa_tc6_calculate_rca_len(tc6, tx_len);
+
+			total_len = tx_len + rca_len;
+		}
+		ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
+					  tc6->spi_rx_buf, total_len);
+		if (ret)
+			return ret;
+		/* Process the rxd chunks to get the ethernet frame or status */
+		ret = oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf, total_len);
+		if (ret)
+			return ret;
+		if (tc6->tx_flag) {
+			tc6->tx_pos += tx_len;
+			tc6->txc_needed = tc6->txc_needed -
+					  (tx_len / (tc6->cps + TC6_HDR_SIZE));
+			/* If the complete ethernet frame is transmitted then
+			 * return the skb and update the details to n/w layer.
+			 */
+			if (!tc6->txc_needed)
+				oa_tc6_tx_eth_complete(tc6);
+			else if (tc6->txc)
+				/* If txc is available again and updated from
+				 * the previous footer then perform tx again.
+				 */
+				do_tx_again = true;
+		}
+
+		/* If rca is updated from the previous footer then perform empty
+		 * tx to receive ethernet frame.
+		 */
+		if (tc6->rca)
+			do_tx_again = true;
+	} while (do_tx_again);
+
+	return 0;
+}
+
+/* MAC-PHY interrupt handler */
+static irqreturn_t macphy_irq_handler(int irq, void *dev_id)
+{
+	struct oa_tc6 *tc6 = dev_id;
+
+	tc6->int_flag = true;
+	mutex_lock(&tc6->lock);
+	if (oa_tc6_perform_spi_xfer(tc6))
+		net_err_ratelimited("%s: SPI transfer failed\n",
+				    tc6->netdev->name);
+	mutex_unlock(&tc6->lock);
+
+	return IRQ_HANDLED;
+}
+
+/* Workqueue to perform SPI transfer */
+static void tc6_tx_work_handler(struct work_struct *work)
+{
+	struct oa_tc6 *tc6 = container_of(work, struct oa_tc6, tx_work);
+
+	mutex_lock(&tc6->lock);
+	if (oa_tc6_perform_spi_xfer(tc6))
+		net_err_ratelimited("%s: SPI transfer failed\n",
+				    tc6->netdev->name);
+	mutex_unlock(&tc6->lock);
+}
+
+/**
+ * oa_tc6_send_eth_pkt - function for sending the tx ethernet frame.
+ * @tc6: oa_tc6 struct.
+ * @skb: socket buffer in which the ethernet frame is stored.
+ *
+ * As this is called from atomic context, work queue is used here because the
+ * spi_sync will block for the transfer completion.
+ *
+ * Returns NETDEV_TX_OK if the tx work is scheduled or NETDEV_TX_BUSY if the
+ * previous enqueued tx skb is in progress.
+ */
+netdev_tx_t oa_tc6_send_eth_pkt(struct oa_tc6 *tc6, struct sk_buff *skb)
+{
+	if (tc6->tx_flag) {
+		netif_stop_queue(tc6->netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	tc6->tx_skb = skb;
+	/* Prepare tx chunks using the tx ethernet frame */
+	oa_tc6_prepare_tx_chunks(tc6, tc6->eth_tx_buf, skb);
+
+	tc6->tx_flag = true;
+	schedule_work(&tc6->tx_work);
+
+	return NETDEV_TX_OK;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_send_eth_pkt);
+
 /**
  * oa_tc6_init - allocates and intializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
  * @netdev: network device to use.
+ * @config_cps_buf: function pointer passed by MAC driver to be called for
+ * configuring cps buffer size. Queue buffer size in the MAC has to be configured
+ * according to the cps.
  *
  * Returns pointer reference to the oa_tc6 structure if all the memory
  * allocation success otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
+			   int (*config_cps_buf)(void *tc6, u32 cps))
 {
 	struct oa_tc6 *tc6;
+	int ret;
 
 	tc6 = devm_kzalloc(&spi->dev, sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
@@ -531,9 +1036,37 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	if (!tc6->ctrl_rx_buf)
 		return NULL;
 
+	/* Allocate memory for the tx buffer used for SPI transfer. */
+	tc6->spi_tx_buf = devm_kzalloc(&spi->dev, ETH_LEN + (OA_TC6_MAX_CPS * TC6_HDR_SIZE),
+				       GFP_KERNEL);
+	if (!tc6->spi_tx_buf)
+		return NULL;
+
+	/* Allocate memory for the rx buffer used for SPI transfer. */
+	tc6->spi_rx_buf = devm_kzalloc(&spi->dev, ETH_LEN + (OA_TC6_MAX_CPS * TC6_FTR_SIZE),
+				       GFP_KERNEL);
+	if (!tc6->spi_rx_buf)
+		return NULL;
+
+	/* Allocate memory for the tx ethernet chunks to transfer on SPI. */
+	tc6->eth_tx_buf = devm_kzalloc(&spi->dev, ETH_LEN + (OA_TC6_MAX_CPS * TC6_HDR_SIZE),
+				       GFP_KERNEL);
+	if (!tc6->eth_tx_buf)
+		return NULL;
+
+	/* Allocate memory for the rx ethernet packet. */
+	tc6->eth_rx_buf = devm_kzalloc(&spi->dev, ETH_LEN + (OA_TC6_MAX_CPS * TC6_FTR_SIZE),
+				       GFP_KERNEL);
+	if (!tc6->eth_rx_buf)
+		return NULL;
+
 	tc6->spi = spi;
 	tc6->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &spi->dev);
+	tc6->config_cps_buf = config_cps_buf;
+	/* Set the SPI controller to pump at realtime priority */
+	spi->rt = true;
+	spi_setup(spi);
 
 	/* Perform MAC-PHY software reset */
 	if (oa_tc6_sw_reset(tc6)) {
@@ -552,6 +1085,16 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		dev_err(&spi->dev, "PHY initialization failed\n");
 		return NULL;
 	}
+	mutex_init(&tc6->lock);
+	INIT_WORK(&tc6->tx_work, tc6_tx_work_handler);
+	/* Register MAC-PHY interrupt service routine */
+	ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
+					macphy_irq_handler, IRQF_ONESHOT,
+					"macphy int", tc6);
+	if (ret) {
+		dev_err(&spi->dev, "Error attaching macphy irq %d\n", ret);
+		return NULL;
+	}
 
 	return tc6;
 }
@@ -564,6 +1107,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
  */
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
+	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
 	oa_tc6_phy_exit(tc6);
 }
 EXPORT_SYMBOL_GPL(oa_tc6_exit);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 36b729c384ac..58d1143f15ba 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -18,9 +18,39 @@
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
 #define TC6_HDR_SIZE		4	/* Ctrl command header size as per OA */
 #define TC6_FTR_SIZE		4	/* Ctrl command footer size ss per OA */
 #define TC6_CTRL_BUF_SIZE	1032	/* Max ctrl buffer size for 128 regs */
+
+#define FTR_OK		0
+#define FTR_ERR		1
+
+#define ETH_LEN		(ETH_DATA_LEN + ETH_HLEN + ETH_FCS_LEN)
 #define OA_TC6_MAX_CPS	64
 
 /* Open Alliance TC6 Standard Control and Status Registers */
@@ -45,7 +75,20 @@
 
 /* Status Register #0 */
 #define STATUS0		0x0008
+#define CDPE		BIT(12)	/* Control Data Protection Error */
+#define TXFCSE		BIT(11)	/* Transmit Frame Check Sequence Error */
 #define RESETC		BIT(6)	/* Reset Complete */
+#define HDRE		BIT(5)	/* Header Error */
+#define LOFE		BIT(4)	/* Loss of Framing Error */
+#define RXBOE		BIT(3)	/* Receive Buffer Overflow Error */
+#define TXBUE		BIT(2)	/* Transmit Buffer Underflow Error */
+#define TXBOE		BIT(1)	/* Transmit Buffer Overflow Error */
+#define TXPE		BIT(0)	/* Transmit Protocol Error */
+
+/* Buffer Status Register */
+#define OA_TC6_BUFSTS	0x000B
+#define TXC		GENMASK(15, 8)	/* Transmit Credits Available */
+#define RCA		GENMASK(7, 0)	/* Receive Chunks Available */
 
 /* Interrupt Mask Register #0 */
 #define IMASK0		0x000C
@@ -56,9 +99,11 @@
 #define TXBOEM		BIT(1)	/* Tx Buffer Overflow Error Mask */
 #define TXPEM		BIT(0)	/* Tx Protocol Error Mask */
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
+			   int (*config_cps_buf)(void *tc6, u32 cps));
 void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 *val);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len);
 int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len);
+netdev_tx_t oa_tc6_send_eth_pkt(struct oa_tc6 *tc6, struct sk_buff *skb);
-- 
2.34.1

