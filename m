Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9F7CC01A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjJQKEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjJQKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:04:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D34FB;
        Tue, 17 Oct 2023 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697537061; x=1729073061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yiRMhfRRI5XPj9iKfDdOJuqpLz9PZ6v6grZ0x4NrzXc=;
  b=d56Zg7mXeHT9Hqlu1TpZo1Nl6jctrV22eJ4iA5nz8cde73Aopg+1742L
   MtFv2YPK468nmhSz/OrlXdEwc1nqxiKOeDi2MTuworUB1OCMuEL478MCa
   XaF77UJOS7S+W8Ug0nu5/185ErR46Okg8ft7f9UujpyfUYoQCGIK2Jdle
   HVQrJE9q8SeSAZWpxPksX+c1ApeoiT9qCiIjxeiBnkn+0AOS35U0dE4iz
   dpUuguIVBWOK9mRGu8vIfZnj3y1VWYRW3cC0Bk2JtVM+y0zDE2b3xUUPe
   KYXKa6O7X45DmlduqBrSqeVik4uQlKSLPbupl/xroF24f/EaAk9qXmcSx
   A==;
X-CSE-ConnectionGUID: nt62uvL+RDO24bDkS2dw3g==
X-CSE-MsgGUID: MCB3Z9MWS5uyUbhSzZ79iw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="177264717"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 03:04:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 03:03:57 -0700
Received: from che-dk-ungapp05lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 03:03:53 -0700
From:   Vishvambar Panth S <vishvambarpanth.s@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <jacob.e.keller@intel.com>, <kuba@kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
Subject: [PATCH v2 net-next] net: microchip: lan743x: improve throughput with rx timestamp config
Date:   Tue, 17 Oct 2023 23:35:42 +0530
Message-ID: <20231017180542.30613-1-vishvambarpanth.s@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all RX frames are timestamped which results in a performance
penalty when timestamping is not needed.  The default is now being
changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
support has been added to allow changing the desired RX timestamping
mode (HWTSTAMP_FILTER_ALL -  which was the previous setting and
HWTSTAMP_FILTER_PTP_V2_EVENT are now supported) using
SIOCSHWTSTAMP. All settings were tested using the hwstamp_ctl application.
It is also noted that ptp4l, when started, preconfigures the device to
timestamp using HWTSTAMP_FILTER_PTP_V2_EVENT, so this driver continues
to work properly "out of the box".

Test setup:  x64 PC with LAN7430 ---> x64 PC as partner

iperf3 with - Timestamp all incoming packets:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.05   sec   517 MBytes   859 Mbits/sec    0    sender
[  5]   0.00-5.00   sec   515 MBytes   864 Mbits/sec         receiver

iperf Done.

iperf3 with - Timestamp only PTP packets:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.04   sec   563 MBytes   937 Mbits/sec    0    sender
[  5]   0.00-5.00   sec   561 MBytes   941 Mbits/sec         receiver

Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
---
Change Log:
v1->v2
    	* As per community comments, dropped netif_warn 
	* dropped HWTSTAMP_FILTER_PTP_V2_DELAY_REQ & SYNC cases.
	* replaced two separate decision points with mask & setting

 .../net/ethernet/microchip/lan743x_ethtool.c  |  3 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 45 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  8 ++++
 drivers/net/ethernet/microchip/lan743x_ptp.c  |  9 ++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 2db5949b4c7e..6961cfc55fb9 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1047,7 +1047,8 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 			    BIT(HWTSTAMP_TX_ON) |
 			    BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-			      BIT(HWTSTAMP_FILTER_ALL);
+			      BIT(HWTSTAMP_FILTER_ALL) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a36f6369f132..1d99f9596b58 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1864,6 +1864,50 @@ static int lan743x_tx_get_avail_desc(struct lan743x_tx *tx)
 		return last_head - last_tail - 1;
 }
 
+void lan743x_rx_cfg_b_tstamp_config(struct lan743x_adapter *adapter,
+				    int rx_ts_config)
+{
+	int channel_number;
+	int index;
+	u32 data;
+
+	for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
+		channel_number = adapter->rx[index].channel_number;
+		data = lan743x_csr_read(adapter, RX_CFG_B(channel_number));
+		data &= RX_CFG_B_TS_MASK_;
+		data |= rx_ts_config;
+		lan743x_csr_write(adapter, RX_CFG_B(channel_number),
+				  data);
+	}
+}
+
+int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
+			       int rx_filter)
+{
+	u32 data;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+			lan743x_rx_cfg_b_tstamp_config(adapter,
+						       RX_CFG_B_TS_DESCR_EN_);
+			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+			data |= PTP_RX_TS_CFG_EVENT_MSGS_;
+			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+			break;
+	case HWTSTAMP_FILTER_NONE:
+			lan743x_rx_cfg_b_tstamp_config(adapter,
+						       RX_CFG_B_TS_NONE_);
+			break;
+	case HWTSTAMP_FILTER_ALL:
+			lan743x_rx_cfg_b_tstamp_config(adapter,
+						       RX_CFG_B_TS_ALL_RX_);
+			break;
+	default:
+			return -ERANGE;
+	}
+	return 0;
+}
+
 void lan743x_tx_set_timestamping_mode(struct lan743x_tx *tx,
 				      bool enable_timestamping,
 				      bool enable_onestep_sync)
@@ -2938,7 +2982,6 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 		data |= RX_CFG_B_RX_PAD_2_;
 	data &= ~RX_CFG_B_RX_RING_LEN_MASK_;
 	data |= ((rx->ring_size) & RX_CFG_B_RX_RING_LEN_MASK_);
-	data |= RX_CFG_B_TS_ALL_RX_;
 	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0))
 		data |= RX_CFG_B_RDMABL_512_;
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 52609fc13ad9..b648461787d2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -522,6 +522,8 @@
 	(((u32)(rx_latency)) & 0x0000FFFF)
 #define PTP_CAP_INFO				(0x0A60)
 #define PTP_CAP_INFO_TX_TS_CNT_GET_(reg_val)	(((reg_val) & 0x00000070) >> 4)
+#define PTP_RX_TS_CFG				(0x0A68)
+#define PTP_RX_TS_CFG_EVENT_MSGS_               GENMASK(3, 0)
 
 #define PTP_TX_MOD				(0x0AA4)
 #define PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_	(0x10000000)
@@ -657,6 +659,9 @@
 
 #define RX_CFG_B(channel)			(0xC44 + ((channel) << 6))
 #define RX_CFG_B_TS_ALL_RX_			BIT(29)
+#define RX_CFG_B_TS_DESCR_EN_			BIT(28)
+#define RX_CFG_B_TS_NONE_			0
+#define RX_CFG_B_TS_MASK_			(0xCFFFFFFF)
 #define RX_CFG_B_RX_PAD_MASK_			(0x03000000)
 #define RX_CFG_B_RX_PAD_0_			(0x00000000)
 #define RX_CFG_B_RX_PAD_2_			(0x02000000)
@@ -991,6 +996,9 @@ struct lan743x_rx {
 	struct sk_buff *skb_head, *skb_tail;
 };
 
+int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
+			       int rx_filter);
+
 /* SGMII Link Speed Duplex status */
 enum lan743x_sgmii_lsd {
 	POWER_DOWN = 0,
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 39e1066ecd5f..2f04bc77a118 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1493,6 +1493,10 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter)
 	temp = lan743x_csr_read(adapter, PTP_TX_MOD2);
 	temp |= PTP_TX_MOD2_TX_PTP_CLR_UDPV4_CHKSUM_;
 	lan743x_csr_write(adapter, PTP_TX_MOD2, temp);
+
+	/* Default Timestamping */
+	lan743x_rx_set_tstamp_mode(adapter, HWTSTAMP_FILTER_NONE);
+
 	lan743x_ptp_enable(adapter);
 	lan743x_csr_write(adapter, INT_EN_SET, INT_BIT_1588_);
 	lan743x_csr_write(adapter, PTP_INT_EN_SET,
@@ -1653,6 +1657,9 @@ static void lan743x_ptp_disable(struct lan743x_adapter *adapter)
 {
 	struct lan743x_ptp *ptp = &adapter->ptp;
 
+	/* Disable Timestamping */
+	lan743x_rx_set_tstamp_mode(adapter, HWTSTAMP_FILTER_NONE);
+
 	mutex_lock(&ptp->command_lock);
 	if (!lan743x_ptp_is_enabled(adapter)) {
 		netif_warn(adapter, drv, adapter->netdev,
@@ -1785,6 +1792,8 @@ int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 		break;
 	}
 
+	ret = lan743x_rx_set_tstamp_mode(adapter, config.rx_filter);
+
 	if (!ret)
 		return copy_to_user(ifr->ifr_data, &config,
 			sizeof(config)) ? -EFAULT : 0;
-- 
2.25.1

