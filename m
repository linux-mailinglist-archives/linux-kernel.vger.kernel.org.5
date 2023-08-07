Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61226771F25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHGLCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjHGLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:01:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88C1FD0;
        Mon,  7 Aug 2023 04:01:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377B1Mbd125851;
        Mon, 7 Aug 2023 06:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691406082;
        bh=DaMI+qL9Q+yXfWZ7dR+mLKqN7JYeMzIasYOnffIaPrg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LZOwT8JLLTw3DXguWJNEiAlQtr+n2Ckl0tmVKCIdzN3PG7xDaI9SDZ+Ih49Z/uOmX
         0OCQ5P8iXWV9kZjOkBtiD1W1Kk2scbaCJRbwOKksuSQxObvhOubrt3Xz1fYZlQ4K0F
         xVqts9lQHEoXmsZ8N9EUsYq9wIu8oMYh++pGog2E=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377B1Mr7075217
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:01:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:01:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:01:21 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377B1LrT032143;
        Mon, 7 Aug 2023 06:01:21 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377B1KRv028419;
        Mon, 7 Aug 2023 06:01:21 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/5] net: ti: icssg-prueth: add packet timestamping and ptp support
Date:   Mon, 7 Aug 2023 16:30:47 +0530
Message-ID: <20230807110048.2611456-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807110048.2611456-1-danishanwar@ti.com>
References: <20230807110048.2611456-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

Add packet timestamping TS and PTP PHC clock support.

For AM65x and AM64x:
 - IEP1 is not used
 - IEP0 is configured in shadow mode with 1ms cycle and shared between
Linux and FW. It provides time and TS in number cycles, so special
conversation in ns is required.
 - IEP0 shared between PRUeth ports.
 - IEP0 supports PPS, periodic output.
 - IEP0 settime() and enabling PPS required FW interraction.
 - RX TS provided with each packet in CPPI5 descriptor.
 - TX TS returned through separate ICSSG hw queues for each port. TX TS
readiness is signaled by INTC IRQ. Only one packet at time can be requested
for TX TS.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Co-developed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c      |   2 +-
 drivers/net/ethernet/ti/icssg/icss_iep.h      |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 416 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
 5 files changed, 463 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index cc0ee113a2c5..455c803dea36 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -224,7 +224,7 @@ static u64 icss_iep_gettime(struct icss_iep *iep,
 	unsigned long flags;
 
 	if (iep->ops && iep->ops->gettime)
-		return iep->ops->gettime(iep->clockops_data);
+		return iep->ops->gettime(iep->clockops_data, sts);
 
 	/* use local_irq_x() to make it work for both RT/non-RT */
 	local_irq_save(flags);
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
index 4f9d4b6bb5d1..9c7f4d0a0916 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.h
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
@@ -13,12 +13,13 @@
 #include <linux/regmap.h>
 
 struct icss_iep;
+extern const struct icss_iep_clockops prueth_iep_clockops;
 
 /* Firmware specific clock operations */
 struct icss_iep_clockops {
 	void (*settime)(void *clockops_data, u64 ns);
 	void (*adjtime)(void *clockops_data, s64 delta);
-	u64 (*gettime)(void *clockops_data);
+	u64 (*gettime)(void *clockops_data, struct ptp_system_timestamp *sts);
 	int (*perout_enable)(void *clockops_data,
 			     struct ptp_perout_request *req, int on,
 			     u64 *cmp);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 02c312f01d10..a27ec1dcc8d5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -109,6 +109,26 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 			*(data++) = emac->stats[i];
 }
 
+static int emac_get_ts_info(struct net_device *ndev,
+			    struct ethtool_ts_info *info)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_HARDWARE |
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->phc_index = icss_iep_get_ptp_clock_idx(emac->iep);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
 static int emac_set_channels(struct net_device *ndev,
 			     struct ethtool_channels *ch)
 {
@@ -176,6 +196,7 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.get_sset_count = emac_get_sset_count,
 	.get_ethtool_stats = emac_get_ethtool_stats,
 	.get_strings = emac_get_strings,
+	.get_ts_info = emac_get_ts_info,
 	.get_channels = emac_get_channels,
 	.set_channels = emac_set_channels,
 	.get_link_ksettings = emac_get_link_ksettings,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 47b941fb0198..b82a718fd602 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -56,6 +56,8 @@
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
+#define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
+
 static void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 				   struct prueth_rx_chn *rx_chn,
 				   int max_rflows)
@@ -471,6 +473,37 @@ static int prueth_dma_rx_push(struct prueth_emac *emac,
 					desc_rx, desc_dma);
 }
 
+static u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
+{
+	u32 iepcount_lo, iepcount_hi, hi_rollover_count;
+	u64 ns;
+
+	iepcount_lo = lo & GENMASK(19, 0);
+	iepcount_hi = (hi & GENMASK(11, 0)) << 12 | lo >> 20;
+	hi_rollover_count = hi >> 11;
+
+	ns = ((u64)hi_rollover_count) << 23 | (iepcount_hi + hi_sw);
+	ns = ns * cycle_time_ns + iepcount_lo;
+
+	return ns;
+}
+
+static void emac_rx_timestamp(struct prueth_emac *emac,
+			      struct sk_buff *skb, u32 *psdata)
+{
+	struct skb_shared_hwtstamps *ssh;
+	u64 ns;
+
+	u32 hi_sw = readl(emac->prueth->shram.va +
+			  TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
+	ns = icssg_ts_to_ns(hi_sw, psdata[1], psdata[0],
+			    IEP_DEFAULT_CYCLE_TIME_NS);
+
+	ssh = skb_hwtstamps(skb);
+	memset(ssh, 0, sizeof(*ssh));
+	ssh->hwtstamp = ns_to_ktime(ns);
+}
+
 static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
@@ -480,6 +513,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	struct sk_buff *skb, *new_skb;
 	dma_addr_t desc_dma, buf_dma;
 	void **swdata;
+	u32 *psdata;
 	int ret;
 
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
@@ -497,6 +531,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	skb = *swdata;
 
+	psdata = cppi5_hdesc_get_psdata(desc_rx);
+	/* RX HW timestamp */
+	if (emac->rx_ts_enabled)
+		emac_rx_timestamp(emac, skb, psdata);
+
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
@@ -557,6 +596,82 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
 	dev_kfree_skb_any(skb);
 }
 
+static int emac_get_tx_ts(struct prueth_emac *emac,
+			  struct emac_tx_ts_response *rsp)
+{
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	int addr;
+
+	addr = icssg_queue_pop(prueth, slice == 0 ?
+			       ICSSG_TS_POP_SLICE0 : ICSSG_TS_POP_SLICE1);
+	if (addr < 0)
+		return addr;
+
+	memcpy_fromio(rsp, prueth->shram.va + addr, sizeof(*rsp));
+	/* return buffer back for to pool */
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_TS_PUSH_SLICE0 : ICSSG_TS_PUSH_SLICE1, addr);
+
+	return 0;
+}
+
+static void tx_ts_work(struct prueth_emac *emac)
+{
+	struct skb_shared_hwtstamps ssh;
+	struct emac_tx_ts_response tsr;
+	struct sk_buff *skb;
+	int timeout = 10;
+	int ret = 0;
+	u32 hi_sw;
+	u64 ns;
+
+	if (!test_bit(__STATE_TX_TS_IN_PROGRESS, &emac->state)) {
+		netdev_err(emac->ndev, "unexpected TS response\n");
+		return;
+	}
+
+	skb = emac->tx_ts_skb;
+	while (timeout-- > 0) {
+		/* wait for response or timeout */
+		ret = emac_get_tx_ts(emac, &tsr);
+		if (!ret)
+			break;
+		usleep_range(10, 20);
+	}
+
+	if (ret) {
+		netdev_err(emac->ndev, "TX timestamp timeout\n");
+		goto error;
+	}
+
+	if (tsr.cookie != emac->tx_ts_cookie) {
+		netdev_err(emac->ndev, "TX TS cookie mismatch 0x%x:0x%x\n",
+			   tsr.cookie, emac->tx_ts_cookie);
+		goto error;
+	}
+
+	hi_sw = readl(emac->prueth->shram.va +
+		      TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
+	ns = icssg_ts_to_ns(hi_sw, tsr.hi_ts, tsr.lo_ts,
+			    IEP_DEFAULT_CYCLE_TIME_NS);
+
+	emac->tx_ts_cookie++;
+	memset(&ssh, 0, sizeof(ssh));
+	ssh.hwtstamp = ns_to_ktime(ns);
+	clear_bit_unlock(__STATE_TX_TS_IN_PROGRESS, &emac->state);
+
+	skb_tstamp_tx(skb, &ssh);
+	dev_consume_skb_any(skb);
+
+	return;
+
+error:
+	dev_kfree_skb_any(skb);
+	emac->tx_ts_skb = NULL;
+	clear_bit_unlock(__STATE_TX_TS_IN_PROGRESS, &emac->state);
+}
+
 /**
  * emac_ndo_start_xmit - EMAC Transmit function
  * @skb: SKB pointer
@@ -577,6 +692,7 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
 	int i, ret = 0, q_idx;
+	bool in_tx_ts = 0;
 	void **swdata;
 	u32 pkt_len;
 	u32 *epib;
@@ -608,6 +724,19 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 	epib = first_desc->epib;
 	epib[0] = 0;
 	epib[1] = 0;
+	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+	    emac->tx_ts_enabled) {
+		/* We currently support only one TX HW timestamp at a time */
+		if (!test_and_set_bit_lock(__STATE_TX_TS_IN_PROGRESS,
+					   &emac->state)) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			/* Request TX timestamp */
+			epib[0] = emac->tx_ts_cookie;
+			epib[1] = 0x80000000;	/* TX TS request */
+			emac->tx_ts_skb = skb_get(skb);
+			in_tx_ts = 1;
+		}
+	}
 
 	/* set dst tag to indicate internal qid at the firmware which is at
 	 * bit8..bit15. bit0..bit7 indicates port num for directed
@@ -629,7 +758,7 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 		if (!next_desc) {
 			netdev_err(ndev,
 				   "tx: failed to allocate frag. descriptor\n");
-			goto free_desc_stop_q_busy;
+			goto free_desc_stop_q_busy_cleanup_tx_ts;
 		}
 
 		buf_dma = skb_frag_dma_map(tx_chn->dma_dev, frag, 0, frag_size,
@@ -638,7 +767,7 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 			netdev_err(ndev, "tx: Failed to map skb page\n");
 			k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
 			ret = NETDEV_TX_OK;
-			goto drop_free_descs;
+			goto cleanup_tx_ts;
 		}
 
 		cppi5_hdesc_reset_hbdesc(next_desc);
@@ -682,6 +811,13 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 
 	return NETDEV_TX_OK;
 
+cleanup_tx_ts:
+	if (in_tx_ts) {
+		dev_kfree_skb_any(emac->tx_ts_skb);
+		emac->tx_ts_skb = NULL;
+		clear_bit_unlock(__STATE_TX_TS_IN_PROGRESS, &emac->state);
+	}
+
 drop_free_descs:
 	prueth_xmit_free(tx_chn, first_desc);
 
@@ -694,7 +830,12 @@ static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device
 
 	return ret;
 
-free_desc_stop_q_busy:
+free_desc_stop_q_busy_cleanup_tx_ts:
+	if (in_tx_ts) {
+		dev_kfree_skb_any(emac->tx_ts_skb);
+		emac->tx_ts_skb = NULL;
+		clear_bit_unlock(__STATE_TX_TS_IN_PROGRESS, &emac->state);
+	}
 	prueth_xmit_free(tx_chn, first_desc);
 
 drop_stop_q_busy:
@@ -717,6 +858,16 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 	dev_kfree_skb_any(skb);
 }
 
+static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
+{
+	struct prueth_emac *emac = dev_id;
+
+	/* currently only TX timestamp is being returned */
+	tx_ts_work(emac);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 {
 	struct prueth_emac *emac = dev_id;
@@ -992,6 +1143,139 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
+static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+{
+	u32 hi_rollover_count, hi_rollover_count_r;
+	struct prueth_emac *emac = clockops_data;
+	struct prueth *prueth = emac->prueth;
+	void __iomem *fw_hi_r_count_addr;
+	void __iomem *fw_count_hi_addr;
+	u32 iepcount_hi, iepcount_hi_r;
+	unsigned long flags;
+	u32 iepcount_lo;
+	u64 ts = 0;
+
+	fw_count_hi_addr = prueth->shram.va + TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET;
+	fw_hi_r_count_addr = prueth->shram.va + TIMESYNC_FW_WC_HI_ROLLOVER_COUNT_OFFSET;
+
+	local_irq_save(flags);
+	do {
+		iepcount_hi = icss_iep_get_count_hi(emac->iep);
+		iepcount_hi += readl(fw_count_hi_addr);
+		hi_rollover_count = readl(fw_hi_r_count_addr);
+		ptp_read_system_prets(sts);
+		iepcount_lo = icss_iep_get_count_low(emac->iep);
+		ptp_read_system_postts(sts);
+
+		iepcount_hi_r = icss_iep_get_count_hi(emac->iep);
+		iepcount_hi_r += readl(fw_count_hi_addr);
+		hi_rollover_count_r = readl(fw_hi_r_count_addr);
+	} while ((iepcount_hi_r != iepcount_hi) ||
+		 (hi_rollover_count != hi_rollover_count_r));
+	local_irq_restore(flags);
+
+	ts = ((u64)hi_rollover_count) << 23 | iepcount_hi;
+	ts = ts * (u64)IEP_DEFAULT_CYCLE_TIME_NS + iepcount_lo;
+
+	return ts;
+}
+
+static void prueth_iep_settime(void *clockops_data, u64 ns)
+{
+	struct icssg_setclock_desc __iomem *sc_descp;
+	struct prueth_emac *emac = clockops_data;
+	struct icssg_setclock_desc sc_desc;
+	u64 cyclecount;
+	u32 cycletime;
+	int timeout;
+
+	if (!emac->fw_running)
+		return;
+
+	sc_descp = emac->prueth->shram.va + TIMESYNC_FW_WC_SETCLOCK_DESC_OFFSET;
+
+	cycletime = IEP_DEFAULT_CYCLE_TIME_NS;
+	cyclecount = ns / cycletime;
+
+	memset(&sc_desc, 0, sizeof(sc_desc));
+	sc_desc.margin = cycletime - 1000;
+	sc_desc.cyclecounter0_set = cyclecount & GENMASK(31, 0);
+	sc_desc.cyclecounter1_set = (cyclecount & GENMASK(63, 32)) >> 32;
+	sc_desc.iepcount_set = ns % cycletime;
+	sc_desc.CMP0_current = cycletime - 4; //Count from 0 to (cycle time)-4
+
+	memcpy_toio(sc_descp, &sc_desc, sizeof(sc_desc));
+
+	writeb(1, &sc_descp->request);
+
+	timeout = 5;	/* fw should take 2-3 ms */
+	while (timeout--) {
+		if (readb(&sc_descp->acknowledgment))
+			return;
+
+		usleep_range(500, 1000);
+	}
+
+	dev_err(emac->prueth->dev, "settime timeout\n");
+}
+
+static int prueth_perout_enable(void *clockops_data,
+				struct ptp_perout_request *req, int on,
+				u64 *cmp)
+{
+	struct prueth_emac *emac = clockops_data;
+	u32 reduction_factor = 0, offset = 0;
+	struct timespec64 ts;
+	u64 ns_period;
+
+	if (!on)
+		return 0;
+
+	/* Any firmware specific stuff for PPS/PEROUT handling */
+	ts.tv_sec = req->period.sec;
+	ts.tv_nsec = req->period.nsec;
+	ns_period = timespec64_to_ns(&ts);
+
+	/* f/w doesn't support period less than cycle time */
+	if (ns_period < IEP_DEFAULT_CYCLE_TIME_NS)
+		return -ENXIO;
+
+	reduction_factor = ns_period / IEP_DEFAULT_CYCLE_TIME_NS;
+	offset = ns_period % IEP_DEFAULT_CYCLE_TIME_NS;
+
+	/* f/w requires at least 1uS within a cycle so CMP
+	 * can trigger after SYNC is enabled
+	 */
+	if (offset < 5 * NSEC_PER_USEC)
+		offset = 5 * NSEC_PER_USEC;
+
+	/* if offset is close to cycle time then we will miss
+	 * the CMP event for last tick when IEP rolls over.
+	 * In normal mode, IEP tick is 4ns.
+	 * In slow compensation it could be 0ns or 8ns at
+	 * every slow compensation cycle.
+	 */
+	if (offset > IEP_DEFAULT_CYCLE_TIME_NS - 8)
+		offset = IEP_DEFAULT_CYCLE_TIME_NS - 8;
+
+	/* we're in shadow mode so need to set upper 32-bits */
+	*cmp = (u64)offset << 32;
+
+	writel(reduction_factor, emac->prueth->shram.va +
+		TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET);
+
+	writel(0, emac->prueth->shram.va +
+		TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
+
+	return 0;
+}
+
+const struct icss_iep_clockops prueth_iep_clockops = {
+	.settime = prueth_iep_settime,
+	.gettime = prueth_iep_gettime,
+	.perout_enable = prueth_perout_enable,
+};
+
 /**
  * emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -1066,10 +1350,20 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
 
+	if (!prueth->emacs_initialized) {
+		ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
+				    emac, IEP_DEFAULT_CYCLE_TIME_NS);
+	}
+
+	ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
+				   IRQF_ONESHOT, dev_name(dev), emac);
+	if (ret)
+		goto stop;
+
 	/* Prepare RX */
 	ret = prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
 	if (ret)
-		goto stop;
+		goto free_tx_ts_irq;
 
 	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
 	if (ret)
@@ -1102,6 +1396,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	prueth_reset_tx_chan(emac, i, false);
 reset_rx_chn:
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
+free_tx_ts_irq:
+	free_irq(emac->tx_ts_irq, emac);
 stop:
 	prueth_emac_stop(emac);
 free_rx_irq:
@@ -1173,6 +1469,14 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* stop PRUs */
 	prueth_emac_stop(emac);
 
+	if (prueth->emacs_initialized == 1)
+		icss_iep_exit(emac->iep);
+
+	/* stop PRUs */
+	prueth_emac_stop(emac);
+
+	free_irq(emac->tx_ts_irq, emac);
+
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 	prueth_cleanup_tx_chns(emac);
@@ -1235,8 +1539,79 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 	queue_work(emac->cmd_wq, &emac->rx_mode_work);
 }
 
+static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		emac->tx_ts_enabled = 0;
+		break;
+	case HWTSTAMP_TX_ON:
+		emac->tx_ts_enabled = 1;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		emac->rx_ts_enabled = 0;
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+		emac->rx_ts_enabled = 1;
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
+static int emac_get_ts_config(struct net_device *ndev, struct ifreq *ifr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct hwtstamp_config config;
+
+	config.flags = 0;
+	config.tx_type = emac->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config.rx_filter = emac->rx_ts_enabled ? HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+			    -EFAULT : 0;
+}
+
 static int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
 {
+	switch (cmd) {
+	case SIOCGHWTSTAMP:
+		return emac_get_ts_config(ndev, ifr);
+	case SIOCSHWTSTAMP:
+		return emac_set_ts_config(ndev, ifr);
+	default:
+		break;
+	}
+
 	return phy_do_ioctl(ndev, ifr, cmd);
 }
 
@@ -1316,6 +1691,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	struct prueth_emac *emac;
 	struct net_device *ndev;
 	enum prueth_port port;
+	const char *irq_name;
 	enum prueth_mac mac;
 
 	port = prueth_node_port(eth_node);
@@ -1355,6 +1731,15 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	emac->tx_ch_num = 1;
 
+	irq_name = "tx_ts0";
+	if (emac->port_id == PRUETH_PORT_MII1)
+		irq_name = "tx_ts1";
+	emac->tx_ts_irq = platform_get_irq_byname_optional(prueth->pdev, irq_name);
+	if (emac->tx_ts_irq < 0) {
+		ret = dev_err_probe(prueth->dev, emac->tx_ts_irq, "could not get tx_ts_irq\n");
+		goto free;
+	}
+
 	SET_NETDEV_DEV(ndev, prueth->dev);
 	spin_lock_init(&emac->lock);
 	mutex_init(&emac->cmd_lock);
@@ -1680,6 +2065,22 @@ static int prueth_probe(struct platform_device *pdev)
 	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
 		prueth->msmcram.va, prueth->msmcram.size);
 
+	prueth->iep0 = icss_iep_get_idx(np, 0);
+	if (IS_ERR(prueth->iep0)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
+		prueth->iep0 = NULL;
+		goto free_pool;
+	}
+
+	prueth->iep1 = icss_iep_get_idx(np, 1);
+	if (IS_ERR(prueth->iep1)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
+		icss_iep_put(prueth->iep0);
+		prueth->iep0 = NULL;
+		prueth->iep1 = NULL;
+		goto free_pool;
+	}
+
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = prueth_netdev_init(prueth, eth0_node);
@@ -1688,6 +2089,7 @@ static int prueth_probe(struct platform_device *pdev)
 				      eth0_node->name);
 			goto netdev_exit;
 		}
+		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
 
 	if (eth1_node) {
@@ -1697,6 +2099,8 @@ static int prueth_probe(struct platform_device *pdev)
 				      eth1_node->name);
 			goto netdev_exit;
 		}
+
+		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
 
 	/* register the network devices */
@@ -1754,6 +2158,7 @@ static int prueth_probe(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+free_pool:
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
 
@@ -1798,6 +2203,9 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+	icss_iep_put(prueth->iep1);
+	icss_iep_put(prueth->iep0);
+
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va,
 		      MSMC_RAM_SIZE);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index a8ce4d01ef16..67ddbff40108 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -35,6 +35,7 @@
 #include <net/devlink.h>
 
 #include "icssg_config.h"
+#include "icss_iep.h"
 #include "icssg_switch_map.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
@@ -117,6 +118,10 @@ struct prueth_rx_chn {
 	char name[32];
 };
 
+enum prueth_state_flags {
+	__STATE_TX_TS_IN_PROGRESS,
+};
+
 /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
  * and lower three are lower priority channels or threads.
  */
@@ -139,6 +144,9 @@ struct prueth_emac {
 	struct device_node *phy_node;
 	phy_interface_t phy_if;
 	enum prueth_port port_id;
+	struct icss_iep *iep;
+	unsigned int rx_ts_enabled : 1;
+	unsigned int tx_ts_enabled : 1;
 
 	/* DMA related */
 	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
@@ -151,6 +159,14 @@ struct prueth_emac {
 	spinlock_t lock;	/* serialize access */
 
 	unsigned long state;
+	/* TX HW Timestamping */
+	u32 tx_ts_cookie;
+	struct sk_buff *tx_ts_skb;
+	int tx_ts_irq;
+
+	u8 cmd_seq;
+	/* shutdown related */
+	u32 cmd_data[4];
 	struct completion cmd_complete;
 	/* Mutex to serialize access to firmware command interface */
 	struct mutex cmd_lock;
@@ -193,6 +209,8 @@ struct prueth_pdata {
  * @pdata: pointer to platform data for ICSSG driver
  * @icssg_hwcmdseq: seq counter or HWQ messages
  * @emacs_initialized: num of EMACs/ext ports that are up/running
+ * @iep0: pointer to IEP0 device
+ * @iep1: pointer to IEP1 device
  */
 struct prueth {
 	struct device *dev;
@@ -214,8 +232,16 @@ struct prueth {
 	struct platform_device *pdev;
 	struct prueth_pdata pdata;
 	u8 icssg_hwcmdseq;
-
 	int emacs_initialized;
+	struct icss_iep *iep0;
+	struct icss_iep *iep1;
+};
+
+struct emac_tx_ts_response {
+	u32 reserved[2];
+	u32 cookie;
+	u32 lo_ts;
+	u32 hi_ts;
 };
 
 /* get PRUSS SLICE number from prueth_emac */
-- 
2.34.1

