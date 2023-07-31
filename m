Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F82E768AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGaExL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGaExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:53:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B83CA;
        Sun, 30 Jul 2023 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690779188; x=1722315188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeIUIrsWmxHz4B3bxwIvr2XSM0C5ERFy2zSd3NWsp1o=;
  b=NeapfpJsXugVqX7iZguvDSZfPjsLchJpkbxlWrLuJTOA2nBUfZ7WRTIP
   95izBbg/pkmdzOKUqKBEWtEkoACjMxKveKvXedzbuTT5rR48JfYLykCzO
   OJrCLxsOIQa3zQ09nmiDDCy1h47PKC3FkOs0E8EPpinK27tCQyLk2xvMX
   ncfABMdnzpH5cIwHSo1rnuzxDU/AFqmZdpvpPJ3g4FPquLvi0Ji3I+RZI
   EQvU9Gmx6K4kGZmfWB4S6E2rJT3dtdkdkiHTai+GCi/AUlt9mEzHwAuOo
   0eIwy56Pl6CHWq82bqMnOjJvozh/3UFldajlXNy/NHTvpp7q6r4Tylfxx
   A==;
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="164061127"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2023 21:53:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 30 Jul 2023 21:52:39 -0700
Received: from che-dk-ungapp04lx.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 30 Jul 2023 21:52:36 -0700
From:   Vishvambar Panth S <vishvambarpanth.s@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Subject: [PATCH net-next] net: lan743x: skip timestamping for non-PTP packets
Date:   Mon, 31 Jul 2023 18:24:18 +0530
Message-ID: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all the RX packets are timestamped and the timestamp is appended
to the RX packet for processing, this reduces RX throughput. This can be
optimized by timestamping packets only when the PTP messages are received.
The RX PTP Configuration register [PTP_RX_TS_CFG] specifies what are the
PTP message types to be timestamped. The PTP_RX_TS_CFG_MSG_EN_ configures
Sync, Delay_Req, Pdelay_Req, Pdelay_Resp Message types to be timestamped.
The RX_CFG_B_TS_ALL_RX_ bit enables storing the timestamp for all RX
frames, now this is cleared as only PTP packets will be timestamped. The
RX_CFG_B_TS_DESCR_EN_ enables storing the timestamp in an extension
descriptor. When PTP messages are received the timestamp will be stored
in an extension descriptor of the RX packet.

Test setup:  x86 PC with LAN7430 ---> x86 PC with i210 as partner

Before:

Connecting to host 192.168.10.3, port 5201
Reverse mode, remote host 192.168.10.3 is sending
[  5] local 192.168.10.10 port 54072 connected to 192.168.10.3 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  97.7 MBytes   819 Mbits/sec
[  5]   1.00-2.00   sec  97.6 MBytes   819 Mbits/sec
[  5]   2.00-3.00   sec  97.7 MBytes   819 Mbits/sec
[  5]   3.00-4.00   sec  97.7 MBytes   819 Mbits/sec
[  5]   4.00-5.00   sec  97.7 MBytes   820 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.05   sec   490 MBytes   814 Mbits/sec    0   sender
[  5]   0.00-5.00   sec   488 MBytes   819 Mbits/sec        receiver

iperf Done.

After:

Connecting to host 192.168.10.3, port 5201
Reverse mode, remote host 192.168.10.3 is sending
[  5] local 192.168.10.10 port 42438 connected to 192.168.10.3 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   112 MBytes   941 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec
[  5]   3.00-4.00   sec   112 MBytes   941 Mbits/sec
[  5]   4.00-5.00   sec   112 MBytes   941 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.04   sec   563 MBytes   936 Mbits/sec    0   sender
[  5]   0.00-5.00   sec   561 MBytes   941 Mbits/sec        receiver

iperf Done.

Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c |  4 +++-
 drivers/net/ethernet/microchip/lan743x_main.c    |  2 +-
 drivers/net/ethernet/microchip/lan743x_main.h    |  5 ++++-
 drivers/net/ethernet/microchip/lan743x_ptp.c     | 11 +++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 2db5949b4c7e..01cb2e4cce82 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1047,7 +1047,9 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 			    BIT(HWTSTAMP_TX_ON) |
 			    BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-			      BIT(HWTSTAMP_FILTER_ALL);
+			      BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
+			      BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a36f6369f132..154f714f5b92 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2938,7 +2938,7 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 		data |= RX_CFG_B_RX_PAD_2_;
 	data &= ~RX_CFG_B_RX_RING_LEN_MASK_;
 	data |= ((rx->ring_size) & RX_CFG_B_RX_RING_LEN_MASK_);
-	data |= RX_CFG_B_TS_ALL_RX_;
+	data |= RX_CFG_B_TS_DESCR_EN_;
 	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0))
 		data |= RX_CFG_B_RDMABL_512_;
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 52609fc13ad9..e1b01a899002 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -522,6 +522,9 @@
 	(((u32)(rx_latency)) & 0x0000FFFF)
 #define PTP_CAP_INFO				(0x0A60)
 #define PTP_CAP_INFO_TX_TS_CNT_GET_(reg_val)	(((reg_val) & 0x00000070) >> 4)
+#define PTP_RX_TS_CFG				(0x0A68)
+/* Config for Sync, Delay_Req, Pdelay_Req, Pdelay_Resp Message types */
+#define PTP_RX_TS_CFG_MSG_EN_			(0x000F)
 
 #define PTP_TX_MOD				(0x0AA4)
 #define PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_	(0x10000000)
@@ -656,7 +659,7 @@
 #define RX_CFG_A_RX_HP_WB_EN_			BIT(5)
 
 #define RX_CFG_B(channel)			(0xC44 + ((channel) << 6))
-#define RX_CFG_B_TS_ALL_RX_			BIT(29)
+#define RX_CFG_B_TS_DESCR_EN_			BIT(28)
 #define RX_CFG_B_RX_PAD_MASK_			(0x03000000)
 #define RX_CFG_B_RX_PAD_0_			(0x00000000)
 #define RX_CFG_B_RX_PAD_2_			(0x02000000)
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 39e1066ecd5f..74204f5bf8b0 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1636,9 +1636,14 @@ static bool lan743x_ptp_is_enabled(struct lan743x_adapter *adapter)
 static void lan743x_ptp_enable(struct lan743x_adapter *adapter)
 {
 	struct lan743x_ptp *ptp = &adapter->ptp;
+	u32 data;
 
 	mutex_lock(&ptp->command_lock);
 
+	data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+	data |= PTP_RX_TS_CFG_MSG_EN_;
+	lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+
 	if (lan743x_ptp_is_enabled(adapter)) {
 		netif_warn(adapter, drv, adapter->netdev,
 			   "PTP already enabled\n");
@@ -1652,6 +1657,7 @@ static void lan743x_ptp_enable(struct lan743x_adapter *adapter)
 static void lan743x_ptp_disable(struct lan743x_adapter *adapter)
 {
 	struct lan743x_ptp *ptp = &adapter->ptp;
+	u32 data;
 
 	mutex_lock(&ptp->command_lock);
 	if (!lan743x_ptp_is_enabled(adapter)) {
@@ -1659,6 +1665,11 @@ static void lan743x_ptp_disable(struct lan743x_adapter *adapter)
 			   "PTP already disabled\n");
 		goto done;
 	}
+
+	data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
+	data &= ~PTP_RX_TS_CFG_MSG_EN_;
+	lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
+
 	lan743x_csr_write(adapter, PTP_CMD_CTL, PTP_CMD_CTL_PTP_DISABLE_);
 	lan743x_ptp_wait_till_cmd_done(adapter, PTP_CMD_CTL_PTP_ENABLE_);
 done:
-- 
2.25.1

