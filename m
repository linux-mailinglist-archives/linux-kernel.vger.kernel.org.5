Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5387FCD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376845AbjK2Dt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376838AbjK2Dty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:49:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E11BC6;
        Tue, 28 Nov 2023 19:49:57 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT3nibnF2515593, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT3nibnF2515593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 11:49:44 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 29 Nov 2023 11:49:45 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Wed, 29 Nov
 2023 11:49:44 +0800
From:   Ricky Wu <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <frank.li@vivo.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-mmc@vger.kernel.org>
CC:     <ricky_wu@realtek.com>
Subject: [PATCH v6 2/3] misc: rtsx: add to support new card reader rts5264
Date:   Wed, 29 Nov 2023 11:48:55 +0800
Message-ID: <20231129034856.2001223-3-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129034856.2001223-1-ricky_wu@realtek.com>
References: <20231129034856.2001223-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.81.102]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

In order to support rts5264 in rtsx_pcr add the id in and 
determine whether the device is rts5264 to call rts5264
functions and do rts5264 workflows or set rts5264 registers

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
v2: removed ic version check
v3: split the patch up with cardreader part and mmc part
v4: split new definition up from v3
---
 drivers/misc/cardreader/rtsx_pcr.c | 30 +++++++++++++++++++++++++-----
 drivers/misc/cardreader/rtsx_pcr.h |  1 +
 include/linux/rtsx_pci.h           |  8 ++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a30751ad3733..1a64364700eb 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -26,6 +26,7 @@
 #include "rtsx_pcr.h"
 #include "rts5261.h"
 #include "rts5228.h"
+#include "rts5264.h"
 
 static bool msi_en = true;
 module_param(msi_en, bool, S_IRUGO | S_IWUSR);
@@ -54,6 +55,7 @@ static const struct pci_device_id rtsx_pci_ids[] = {
 	{ PCI_DEVICE(0x10EC, 0x5260), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x5261), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ PCI_DEVICE(0x10EC, 0x5228), PCI_CLASS_OTHERS << 16, 0xFF0000 },
+	{ PCI_DEVICE(0x10EC, 0x5264), PCI_CLASS_OTHERS << 16, 0xFF0000 },
 	{ 0, }
 };
 
@@ -714,6 +716,9 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 	if (PCI_PID(pcr) == PID_5228)
 		return rts5228_pci_switch_clock(pcr, card_clock,
 				ssc_depth, initial_mode, double_clk, vpclk);
+	if (PCI_PID(pcr) == PID_5264)
+		return rts5264_pci_switch_clock(pcr, card_clock,
+				ssc_depth, initial_mode, double_clk, vpclk);
 
 	if (initial_mode) {
 		/* We use 250k(around) here, in initial stage */
@@ -987,7 +992,8 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 
 	int_reg &= (pcr->bier | 0x7FFFFF);
 
-	if (int_reg & SD_OC_INT)
+	if ((int_reg & SD_OC_INT) ||
+			((int_reg & SD_OVP_INT) && (PCI_PID(pcr) == PID_5264)))
 		rtsx_pci_process_ocp_interrupt(pcr);
 
 	if (int_reg & SD_INT) {
@@ -1159,7 +1165,9 @@ void rtsx_pci_enable_oobs_polling(struct rtsx_pcr *pcr)
 {
 	u16 val;
 
-	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+	if ((PCI_PID(pcr) != PID_525A) &&
+		(PCI_PID(pcr) != PID_5260) &&
+		(PCI_PID(pcr) != PID_5264)) {
 		rtsx_pci_read_phy_register(pcr, 0x01, &val);
 		val |= 1<<9;
 		rtsx_pci_write_phy_register(pcr, 0x01, val);
@@ -1175,7 +1183,9 @@ void rtsx_pci_disable_oobs_polling(struct rtsx_pcr *pcr)
 {
 	u16 val;
 
-	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+	if ((PCI_PID(pcr) != PID_525A) &&
+		(PCI_PID(pcr) != PID_5260) &&
+		(PCI_PID(pcr) != PID_5264)) {
 		rtsx_pci_read_phy_register(pcr, 0x01, &val);
 		val &= ~(1<<9);
 		rtsx_pci_write_phy_register(pcr, 0x01, val);
@@ -1226,7 +1236,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_enable_bus_int(pcr);
 
 	/* Power on SSC */
-	if (PCI_PID(pcr) == PID_5261) {
+	if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
 		/* Gating real mcu clock */
 		err = rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
 			RTS5261_MCU_CLOCK_GATING, 0);
@@ -1270,6 +1280,11 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	else if (PCI_PID(pcr) == PID_5228)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF,
 			RTS5228_SSC_DEPTH_2M);
+	else if (is_version(pcr, 0x5264, IC_VER_A))
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, 0);
+	else if (PCI_PID(pcr) == PID_5264)
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF,
+			RTS5264_SSC_DEPTH_2M);
 	else
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2, 0xFF, 0x12);
 
@@ -1305,6 +1320,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	case PID_5260:
 	case PID_5261:
 	case PID_5228:
+	case PID_5264:
 		rtsx_pci_write_register(pcr, PM_CLK_FORCE_CTL, 1, 1);
 		break;
 	default:
@@ -1404,6 +1420,10 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 	case 0x5228:
 		rts5228_init_params(pcr);
 		break;
+
+	case 0x5264:
+		rts5264_init_params(pcr);
+		break;
 	}
 
 	pcr_dbg(pcr, "PID: 0x%04x, IC version: 0x%02x\n",
@@ -1544,7 +1564,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	pcr->pci = pcidev;
 	dev_set_drvdata(&pcidev->dev, handle);
 
-	if (CHK_PCI_PID(pcr, 0x525A))
+	if ((CHK_PCI_PID(pcr, 0x525A)) || (CHK_PCI_PID(pcr, 0x5264)))
 		bar = 1;
 	len = pci_resource_len(pcidev, bar);
 	base = pci_resource_start(pcidev, bar);
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index 37d1f316ae17..9215d66de00c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -74,6 +74,7 @@ void rtl8411b_init_params(struct rtsx_pcr *pcr);
 void rts5260_init_params(struct rtsx_pcr *pcr);
 void rts5261_init_params(struct rtsx_pcr *pcr);
 void rts5228_init_params(struct rtsx_pcr *pcr);
+void rts5264_init_params(struct rtsx_pcr *pcr);
 
 static inline u8 map_sd_drive(int idx)
 {
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 534038d962e4..4612ef09a0c7 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -60,6 +60,7 @@
 #define   SD_EXIST			(1 << 16)
 #define   DELINK_INT			GPIO0_INT
 #define   MS_OC_INT			(1 << 23)
+#define   SD_OVP_INT		(1 << 23)
 #define   SD_OC_INT			(1 << 22)
 
 #define CARD_INT		(XD_INT | MS_INT | SD_INT)
@@ -80,6 +81,7 @@
 #define   OC_INT_EN			(1 << 23)
 #define   DELINK_INT_EN			GPIO0_INT_EN
 #define   MS_OC_INT_EN			(1 << 23)
+#define   SD_OVP_INT_EN			(1 << 23)
 #define   SD_OC_INT_EN			(1 << 22)
 
 #define RTSX_DUM_REG			0x1C
@@ -583,6 +585,7 @@
 #define   OBFF_DISABLE			0x00
 
 #define CDRESUMECTL			0xFE52
+#define CDGW				0xFE53
 #define WAKE_SEL_CTL			0xFE54
 #define PCLK_CTL			0xFE55
 #define   PCLK_MODE_SEL			0x20
@@ -764,6 +767,9 @@
 #define   SD_VIO_LDO_1V8		0x40
 #define   SD_VIO_LDO_3V3		0x70
 
+#define RTS5264_AUTOLOAD_CFG2		0xFF7D
+#define RTS5264_CHIP_RST_N_SEL		(1 << 6)
+
 #define RTS5260_AUTOLOAD_CFG4		0xFF7F
 #define   RTS5260_MIMO_DISABLE		0x8A
 /*RTS5261*/
@@ -1261,6 +1267,7 @@ struct rtsx_pcr {
 	u8				dma_error_count;
 	u8			ocp_stat;
 	u8			ocp_stat2;
+	u8			ovp_stat;
 	u8			rtd3_en;
 };
 
@@ -1271,6 +1278,7 @@ struct rtsx_pcr {
 #define PID_5260	0x5260
 #define PID_5261	0x5261
 #define PID_5228	0x5228
+#define PID_5264	0x5264
 
 #define CHK_PCI_PID(pcr, pid)		((pcr)->pci->device == (pid))
 #define PCI_VID(pcr)			((pcr)->pci->vendor)
-- 
2.25.1

