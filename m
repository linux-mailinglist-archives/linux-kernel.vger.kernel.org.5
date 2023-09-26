Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC42E7AEA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjIZK3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjIZK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:29:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FBE5;
        Tue, 26 Sep 2023 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695724145; x=1727260145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ognUAqaDQjgGkcWwKxjzZ+4BvYgpoYdpC6wXGrJmSxQ=;
  b=1OxqR1+ZXwOxg513H0uIMu+oJDUCbySDf+WLC2m8whpXZWlEio+r7sa/
   oK63zHAPut6XQKoVJW4Y/oyl1atbei6YhwwWpaDaNeLjMgGN3ibwp8zeC
   ukiQjcusazSGxsD+h7xhlT5+kOhr3aGDUrlpvX18YzKiRUFVUTj/j0JCg
   AmjC1dnDMmCGvDEdLBkVfYFI9M5lDtbYXzNl7Sjf8GMB0X1qQ70a5v2Ml
   5H0EZ9I+MFQ+9/D+/JOtrn+R9N1c7Pd48PscevPvaAb1nm5rzwR2lB2xP
   ZFXdjMtr2ERChw+RMYyfVGSNUbwJ4j9u42vE3/yZiRNou06d7crv3MeZM
   A==;
X-CSE-ConnectionGUID: NNnylNGLQ6iR0WtNE4SGdA==
X-CSE-MsgGUID: UKJ4CXG9S7mQstpaB0F0mg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="6637609"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 03:29:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 03:28:21 -0700
Received: from che-dk-testitlx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 26 Sep 2023 03:28:18 -0700
From:   Vishvambar Panth S <vishvambarpanth.s@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <unglinuxdriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: [PATCH net-next] net: microchip: lan743x: improve throughput with rx timestamp config
Date:   Tue, 26 Sep 2023 21:26:58 +0530
Message-ID: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all RX frames are timestamped which results in a performance
penalty when timestamping is not needed.  The default is now being
changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
support has been added to allow changing the desired RX timestamping
mode (HWTSTAMP_FILTER_ALL -  which was the previous setting,
HWTSTAMP_FILTER_PTP_V2_EVENT, HWTSTAMP_FILTER_PTP_V2_SYNC and
HWTSTAMP_FILTER_PTP_V2_DELAY_REQ are the supported options) using
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

Please find the earlier conversation at the link below
Link: https://lore.kernel.org/all/20230731125418.75140-1-vishvambarpanth.s@microchip.com/

Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
---
 .../net/ethernet/microchip/lan743x_ethtool.c  |  5 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 58 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  8 +++
 drivers/net/ethernet/microchip/lan743x_ptp.c  |  9 +++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 2db5949b4c7e..855844df5ea1 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1047,7 +1047,10 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 			    BIT(HWTSTAMP_TX_ON) |
 			    BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-			      BIT(HWTSTAMP_FILTER_ALL);
+			      BIT(HWTSTAMP_FILTER_ALL) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f940895b14e8..0389bc7cf603 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1870,6 +1870,63 @@ static int lan743x_tx_get_avail_desc(struct lan743x_tx *tx)
 		return last_head - last_tail - 1;
 }
 
+int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
+			       int rx_filter)
+{
+	int channel_number;
+	int index;
+	u32 data;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+			data &= ~PTP_RX_TS_CFG_EVENT_MSGS_;
+			data |= PTP_RX_TS_CFG_SYNC_MSG_;
+			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+			break;
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+			data &= ~PTP_RX_TS_CFG_EVENT_MSGS_;
+			data |= PTP_RX_TS_CFG_DELAY_REQ_MSG_;
+			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+			break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+			data |= PTP_RX_TS_CFG_EVENT_MSGS_;
+			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+			break;
+	case HWTSTAMP_FILTER_NONE:
+	case HWTSTAMP_FILTER_ALL:
+			break;
+	default:
+			netif_warn(adapter, drv, adapter->netdev,
+				   "rx timestamp = %d is not supported\n",
+				   rx_filter);
+			return -EINVAL;
+	}
+
+	for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
+		channel_number = adapter->rx[index].channel_number;
+		data = lan743x_csr_read(adapter, RX_CFG_B(channel_number));
+		if (rx_filter == HWTSTAMP_FILTER_NONE) {
+			data &= ~(RX_CFG_B_TS_ALL_RX_ |
+				  RX_CFG_B_TS_DESCR_EN_);
+		} else if (rx_filter == HWTSTAMP_FILTER_ALL) {
+			data |= RX_CFG_B_TS_ALL_RX_;
+		} else {
+			/* enable storing timestamping in extension descriptor
+			 * instead of timestamping all the packets
+			 */
+			data &= ~RX_CFG_B_TS_ALL_RX_;
+			data |= RX_CFG_B_TS_DESCR_EN_;
+		}
+		lan743x_csr_write(adapter, RX_CFG_B(channel_number),
+				  data);
+	}
+
+	return 0;
+}
+
 void lan743x_tx_set_timestamping_mode(struct lan743x_tx *tx,
 				      bool enable_timestamping,
 				      bool enable_onestep_sync)
@@ -2944,7 +3001,6 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 		data |= RX_CFG_B_RX_PAD_2_;
 	data &= ~RX_CFG_B_RX_RING_LEN_MASK_;
 	data |= ((rx->ring_size) & RX_CFG_B_RX_RING_LEN_MASK_);
-	data |= RX_CFG_B_TS_ALL_RX_;
 	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0))
 		data |= RX_CFG_B_RDMABL_512_;
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 52609fc13ad9..b0ddc32a2d85 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -522,6 +522,10 @@
 	(((u32)(rx_latency)) & 0x0000FFFF)
 #define PTP_CAP_INFO				(0x0A60)
 #define PTP_CAP_INFO_TX_TS_CNT_GET_(reg_val)	(((reg_val) & 0x00000070) >> 4)
+#define PTP_RX_TS_CFG				(0x0A68)
+#define PTP_RX_TS_CFG_SYNC_MSG_                 BIT(0)
+#define PTP_RX_TS_CFG_DELAY_REQ_MSG_            BIT(1)
+#define PTP_RX_TS_CFG_EVENT_MSGS_               GENMASK(3, 0)
 
 #define PTP_TX_MOD				(0x0AA4)
 #define PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_	(0x10000000)
@@ -657,6 +661,7 @@
 
 #define RX_CFG_B(channel)			(0xC44 + ((channel) << 6))
 #define RX_CFG_B_TS_ALL_RX_			BIT(29)
+#define RX_CFG_B_TS_DESCR_EN_			BIT(28)
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

