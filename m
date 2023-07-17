Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567AC75634F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGQMxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGQMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:53:15 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E0170B;
        Mon, 17 Jul 2023 05:53:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5Tq4r020449;
        Mon, 17 Jul 2023 05:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=7LK2XM3LL17DaGIHpxY204NBdCG/pN2QpZhAjPwmtg0=;
 b=c6itKt8f5vO/Vqzeji4OpjEa0A5FnzwTxo4189xOfuwhxUju8FqqUIM5aqJxyE9C3Bhm
 B9otvecfkyuKn5IWYKjYZdjpithwVegmcTS5YBY+Nv4UC0aDdX8ckJo0Hv9xYy/L8XTy
 3fA5ZqEHIMtR2bt6iJAva9y6WoHVQw9Yz41+6A7/93sX1t3oKnQAv0EmtktoXHpss927
 JUHe7P9upcQPJ4pZ1VWd8kLu1cXMiZuA7bT6N9jNiokARuiVE01vllkBoOF3qgR6yBEX
 gIYwhmOCrAgl7PCmjkc2UDk9l8WV5AQ9bvXG0NikQbEjlfFD++F8fVNtiTCEZ9RyECJH Rg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:58 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:52:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:52:57 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 03FC23F70A4;
        Mon, 17 Jul 2023 05:52:56 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 6/6] mmc: sdhci-cadence: Add debug option for SD6 controller
Date:   Mon, 17 Jul 2023 05:51:46 -0700
Message-ID: <20230717125146.16791-7-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717125146.16791-1-pmalgujar@marvell.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: i7lENjUZQkPZPFDaGSaXApkAiGCFiWs3
X-Proofpoint-ORIG-GUID: i7lENjUZQkPZPFDaGSaXApkAiGCFiWs3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support dumping PHY and host controller register configuration
if debug config enabled.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 156 ++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index f1e597219c603f3921439cedb22dcb2884abe68d..337a97bf906137f0eac4122cdd603f25df7ae8d9 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -116,6 +116,10 @@
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
 
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
+
 #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
 #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
 
@@ -813,7 +817,7 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
 }
 
 static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
-					u8 addr, u8 data)
+				    u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
@@ -971,6 +975,154 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
 	}
 }
 
+#if defined(DEBUG) || IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
+
+static
+void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy,
+			     struct sdhci_host *host)
+{
+	dev_dbg(mmc_dev(host->mmc), "PHY Timings\n");
+	dev_dbg(mmc_dev(host->mmc), "mode %d t_sdclk %d\n", phy->mode,
+		phy->t_sdclk);
+
+	dev_dbg(mmc_dev(host->mmc), "cp_clk_wr_delay %d\n",
+		phy->settings.cp_clk_wr_delay);
+	dev_dbg(mmc_dev(host->mmc), "cp_clk_wrdqs_delay %d\n",
+		phy->settings.cp_clk_wrdqs_delay);
+	dev_dbg(mmc_dev(host->mmc), "cp_data_select_oe_end %d\n",
+		phy->settings.cp_data_select_oe_end);
+	dev_dbg(mmc_dev(host->mmc), "cp_dll_bypass_mode %d\n",
+		phy->settings.cp_dll_bypass_mode);
+	dev_dbg(mmc_dev(host->mmc), "cp_dll_locked_mode %d\n",
+		phy->settings.cp_dll_locked_mode);
+	dev_dbg(mmc_dev(host->mmc), "cp_dll_start_point %d\n",
+		phy->settings.cp_dll_start_point);
+	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_always_on %d\n",
+		phy->settings.cp_io_mask_always_on);
+	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_end %d\n",
+		phy->settings.cp_io_mask_end);
+	dev_dbg(mmc_dev(host->mmc), "cp_io_mask_start %d\n",
+		phy->settings.cp_io_mask_start);
+	dev_dbg(mmc_dev(host->mmc), "cp_rd_del_sel %d\n",
+		phy->settings.cp_rd_del_sel);
+	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_cmd_delay %d\n",
+		phy->settings.cp_read_dqs_cmd_delay);
+	dev_dbg(mmc_dev(host->mmc), "cp_read_dqs_delay %d\n",
+		phy->settings.cp_read_dqs_delay);
+	dev_dbg(mmc_dev(host->mmc), "cp_sw_half_cycle_shift %d\n",
+		phy->settings.cp_sw_half_cycle_shift);
+	dev_dbg(mmc_dev(host->mmc), "cp_sync_method %d\n",
+		phy->settings.cp_sync_method);
+	dev_dbg(mmc_dev(host->mmc), "cp_use_ext_lpbk_dqs %d\n",
+		phy->settings.cp_use_ext_lpbk_dqs);
+	dev_dbg(mmc_dev(host->mmc), "cp_use_lpbk_dqs %d\n",
+		phy->settings.cp_use_lpbk_dqs);
+	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs %d\n",
+		phy->settings.cp_use_phony_dqs);
+	dev_dbg(mmc_dev(host->mmc), "cp_use_phony_dqs_cmd %d\n",
+		phy->settings.cp_use_phony_dqs_cmd);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_rd_mode %d\n",
+		phy->settings.sdhc_extended_rd_mode);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_extended_wr_mode %d\n",
+		phy->settings.sdhc_extended_wr_mode);
+
+	dev_dbg(mmc_dev(host->mmc), "sdhc_hcsdclkadj %d\n",
+		phy->settings.sdhc_hcsdclkadj);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_idelay_val %d\n",
+		phy->settings.sdhc_idelay_val);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_rdcmd_en %d\n",
+		phy->settings.sdhc_rdcmd_en);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_rddata_en %d\n",
+		phy->settings.sdhc_rddata_en);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_rw_compensate %d\n",
+		phy->settings.sdhc_rw_compensate);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsh %d\n",
+		phy->settings.sdhc_sdcfsh);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_sdcfsl %d\n",
+		phy->settings.sdhc_sdcfsl);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd0_dly %d %d\n",
+		phy->settings.sdhc_wrcmd0_dly,
+		phy->settings.sdhc_wrcmd0_sdclk_dly);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_wrcmd1_dly %d %d\n",
+		phy->settings.sdhc_wrcmd1_dly,
+		phy->settings.sdhc_wrcmd1_sdclk_dly);
+	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata0_dly %d %d\n",
+		phy->settings.sdhc_wrdata0_dly,
+		phy->settings.sdhc_wrdata0_sdclk_dly);
+
+	dev_dbg(mmc_dev(host->mmc), "sdhc_wrdata1_dly %d %d\n",
+		phy->settings.sdhc_wrdata1_dly,
+		phy->settings.sdhc_wrdata1_sdclk_dly);
+	dev_dbg(mmc_dev(host->mmc), "hs200_tune_val %d\n",
+		phy->settings.hs200_tune_val);
+}
+
+static
+void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv, struct sdhci_host *host)
+{
+	struct sdhci_cdns_sd6_phy *phy = priv->phy;
+	int id;
+
+	sdhci_cdns_sd6_phy_dump(phy);
+
+	dev_dbg(mmc_dev(host->mmc), "Host controller Register Dump\n");
+	for (id = 0; id < 14; id++) {
+		dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
+			readl(priv->hrs_addr + (id * 4)));
+	}
+
+	id = 29;
+	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
+		readl(priv->hrs_addr + (id * 4)));
+	id = 30;
+	dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
+		readl(priv->hrs_addr + (id * 4)));
+
+	for (id = 0; id < 27; id++) {
+		dev_dbg(mmc_dev(host->mmc), "SRS%d 0x%x\n", id,
+			readl(priv->hrs_addr + 0x200 + (id * 4)));
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DQS_TIMING));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_GATE_LPBK));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DLL_MASTER));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DQ_TIMING));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
+	dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
+		sdhci_cdns_sd6_read_phy_reg(priv,
+					    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
+}
+
+#else
+
+static inline void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv,
+				       struct sdhci_host *host)
+{
+}
+
+#endif
+
 static
 int sdhci_cdns_sd6_get_delay_params(struct device *dev,
 				    struct sdhci_cdns_priv *priv)
@@ -1322,6 +1474,8 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
 		pr_debug("%s: phy init failed\n", __func__);
 
 	sdhci_set_clock(host, clock);
+
+	sdhci_cdns_sd6_dump(priv, host);
 }
 
 static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
-- 
2.17.1

