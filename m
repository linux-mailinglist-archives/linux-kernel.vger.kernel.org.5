Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B6B757535
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGRHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGRHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:21:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB4610C;
        Tue, 18 Jul 2023 00:21:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36I7L8h44009295, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36I7L8h44009295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 18 Jul 2023 15:21:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Jul 2023 15:21:17 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Jul 2023 15:21:15 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 18 Jul 2023 15:21:15 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Date:   Tue, 18 Jul 2023 15:21:08 +0800
Message-ID: <20230718072115.19685-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/usb/dwc3/core.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f6689b731718..a0a54e5c4ad9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1262,6 +1262,39 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		}
 	}
 
+	if (DWC3_IP_IS(DWC3)) {
+		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
+		u8 rx_maxburst = dwc->rx_max_burst_prd;
+		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
+		u8 tx_maxburst = dwc->tx_max_burst_prd;
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
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8b1295e4dcdd..5480fcb59bcb 100644
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
-- 
2.34.1

