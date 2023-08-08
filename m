Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D50773D38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjHHQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHHQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 556163C10;
        Tue,  8 Aug 2023 08:47:29 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37865U8s8011396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37865U8s8011396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 14:05:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Aug 2023 14:05:31 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 14:05:30 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 8 Aug 2023 14:05:30 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Date:   Tue, 8 Aug 2023 14:05:22 +0800
Message-ID: <20230808060530.9727-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Synopsys's dwc3 data book:
To avoid underrun and overrun during the burst, in a high-latency bus
system (like USB), threshold and burst size control is provided through
GTXTHRCFG and GRXTHRCFG registers.

In Realtek DHC SoC, DWC3 USB 3.0 uses AHB system bus. When dwc3 is
connected with USB 2.5G Ethernet, there will be overrun problem.
Therefore, setting TX/RX thresholds can avoid this issue.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v1 to v2 change:
    Add the properties for TX/RX threshold setting
---
 drivers/usb/dwc3/core.c | 51 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h | 13 +++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..1f74a53816c3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1246,6 +1246,39 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		}
 	}
 
+	if (DWC3_IP_IS(DWC3)) {
+		u8 rx_thr_num = dwc->rx_thr_num_pkt;
+		u8 rx_maxburst = dwc->rx_max_burst;
+		u8 tx_thr_num = dwc->tx_thr_num_pkt;
+		u8 tx_maxburst = dwc->tx_max_burst;
+
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC3_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC3_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC3_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC3_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC3_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC3_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC3_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC3_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+
 	return 0;
 
 err_power_off_phy:
@@ -1380,6 +1413,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt = 0;
+	u8			rx_max_burst = 0;
+	u8			tx_thr_num_pkt = 0;
+	u8			tx_max_burst = 0;
 	u8			rx_thr_num_pkt_prd = 0;
 	u8			rx_max_burst_prd = 0;
 	u8			tx_thr_num_pkt_prd = 0;
@@ -1442,6 +1479,14 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb2-lpm-disable");
 	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-gadget-lpm-disable");
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
+				&rx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,rx-max-burst",
+				&rx_max_burst);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
+				&tx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,tx-max-burst",
+				&tx_max_burst);
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1523,6 +1568,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->hird_threshold = hird_threshold;
 
+	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
+	dwc->rx_max_burst = rx_max_burst;
+
+	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
+	dwc->tx_max_burst = tx_max_burst;
+
 	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
 	dwc->rx_max_burst_prd = rx_max_burst_prd;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..6782ec8bfd64 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -211,6 +211,11 @@
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
 #define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
+/* Global TX Threshold Configuration Register */
+#define DWC3_GTXTHRCFG_MAXTXBURSTSIZE(n) (((n) & 0xff) << 16)
+#define DWC3_GTXTHRCFG_TXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GTXTHRCFG_PKTCNTSEL BIT(29)
+
 /* Global RX Threshold Configuration Register for DWC_usb31 only */
 #define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
 #define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
@@ -1045,6 +1050,10 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @rx_thr_num_pkt: USB receive packet count
+ * @rx_max_burst: max USB receive burst size
+ * @tx_thr_num_pkt: USB transmit packet count
+ * @tx_max_burst: max USB transmit burst size
  * @rx_thr_num_pkt_prd: periodic ESS receive packet count
  * @rx_max_burst_prd: max periodic ESS receive burst size
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
@@ -1273,6 +1282,10 @@ struct dwc3 {
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt;
+	u8			rx_max_burst;
+	u8			tx_thr_num_pkt;
+	u8			tx_max_burst;
 	u8			rx_thr_num_pkt_prd;
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
-- 
2.34.1

