Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA17FCDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376843AbjK2DuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376850AbjK2DuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:50:02 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323B1BCC;
        Tue, 28 Nov 2023 19:50:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT3noPnB2515599, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT3noPnB2515599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 11:49:50 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 29 Nov 2023 11:49:51 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Wed, 29 Nov
 2023 11:49:50 +0800
From:   Ricky Wu <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <frank.li@vivo.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-mmc@vger.kernel.org>
CC:     <ricky_wu@realtek.com>
Subject: [PATCH v6 3/3] mmc: rtsx: add rts5264 to support sd express card
Date:   Wed, 29 Nov 2023 11:48:56 +0800
Message-ID: <20231129034856.2001223-4-ricky_wu@realtek.com>
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

rts5264 can support sd express card, so add the id in sd express card init
to do rts5264 register setting when the sd express card insert

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
v3: split up mmc part from v2 patch
v4: split new definition up from v3
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 87d78432a1e0..7dfe7c4e0077 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -7,6 +7,7 @@
  *   Wei WANG <wei_wang@realsil.com.cn>
  */
 
+#include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -947,7 +948,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
 	/* send at least 74 clocks */
 	rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
 
-	if (PCI_PID(pcr) == PID_5261) {
+	if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
 		/*
 		 * If test mode is set switch to SD Express mandatorily,
 		 * this is only for factory testing.
@@ -1364,6 +1365,14 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
 
+	if (PCI_PID(pcr) == PID_5264) {
+		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
+				PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_2_5GT);
+		pci_write_config_byte(pcr->pci, 0x80e, 0x02);
+		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
+				PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_5_0GT);
+	}
+
 	/* Set relink_time for changing to PCIe card */
 	relink_time = 0x8FFF;
 
@@ -1379,6 +1388,12 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (pcr->ops->disable_auto_blink)
 		pcr->ops->disable_auto_blink(pcr);
 
+	if (PCI_PID(pcr) == PID_5264) {
+		rtsx_pci_write_register(pcr, RTS5264_AUTOLOAD_CFG2,
+			RTS5264_CHIP_RST_N_SEL, RTS5264_CHIP_RST_N_SEL);
+		rtsx_pci_write_register(pcr, GPIO_CTL, 0x02, 0x00);
+	}
+
 	/* For PCIe/NVMe mode can't enter delink issue */
 	pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
 	rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
-- 
2.25.1

