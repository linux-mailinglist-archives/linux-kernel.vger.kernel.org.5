Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F8809CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjLHHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjLHHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:00:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9C1991
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:00:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfb30ce241so16032845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018832; x=1702623632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEBpfCrqRZnjYKfTxZcI34SwwVZWbBFa1yYCM6JT/u4=;
        b=y1wpfN8C95UxqmktKm7G2HLFr+GqES9CpsCdyGG5CadxzSdPy5AP9GbpC8Qe36UWqS
         Th0Egq46rflVtSIpgbeX+JGMcSbw4p2Z9aoZLKrdMmUbOI4UToXAnaa5tx7KenmRQ7w/
         hMvIbCHpwzapxIyMXVKV+SwBnyTNEoeBv+Tlg82lYezLQHyNRfuCbXPzX2LDli2WUnEz
         ASOTg2uC7PTdpp7FLeXTb9gCiRPo/ovN6eRn/RjK5XR3KM2iQxfEUddUlPvR33iK65TE
         AwpLytyRcydOEFBU65x5r8JecY9Ba8rlv9vG+MTlq1ME2+WOseB9dcgjf5a28r7dKIWE
         xxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018832; x=1702623632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEBpfCrqRZnjYKfTxZcI34SwwVZWbBFa1yYCM6JT/u4=;
        b=I8Hb54G0EL4jamsheB457vF2qldBB7Gk2gWyOs2MytfJRJRCOUefUsGl6z3MEQCqr2
         JbKibsfZEJcEZj1uhDv7YIn+eWW97c7dwrKPtx+FHFRlmZZx1lecKNNkd8E+c8mtM3eT
         uoG3Wp+7VF3SFOXqIdyPhaTK/ihu2YHjmiy1K0nIkM2uu9ucbXIkqdiG4zKd7yGkIURA
         dC5KiJB7F5PyM/qyx7ZT1iXSlAwMITcObornSZTrSGtMryJNGNp4aKjLP1RQaP20xTaK
         GRb2e7GTmDI16Iz/LZJ5lgDC0c4GhGF3BWRdBWtc5WSM7fAned+wZqsPuo86B+Ml4VDa
         DV4A==
X-Gm-Message-State: AOJu0Yx3sNct6AT+4H/IyEuOQcWogijwM1MvwfUs1USAqjsbRok25S2s
        NWBNuHemAs//b94JpNTTxs/k
X-Google-Smtp-Source: AGHT+IHsPFGuGIcIX1P6q3HX0uLqAF+K1SKij2Se88dzPjPrLccO1PEACetl/ZR8Xty6jgQ27rgMBQ==
X-Received: by 2002:a17:903:2290:b0:1b8:90bd:d157 with SMTP id b16-20020a170903229000b001b890bdd157mr4567792plh.26.1702018832382;
        Thu, 07 Dec 2023 23:00:32 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.23.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:00:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/17] scsi: ufs: qcom: Remove support for host controllers older than v2.0
Date:   Fri,  8 Dec 2023 12:29:00 +0530
Message-Id: <20231208065902.11006-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy platforms making use of host controllers older than version 2.0
are not supported in upstream. So there is no need to carry code to support
them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 196 ++----------------------------------
 drivers/ufs/host/ufs-qcom.h |  27 -----
 2 files changed, 11 insertions(+), 212 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 9b3d6d3609c9..26aa8904c823 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -274,9 +274,7 @@ static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
 
 static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 {
-	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
-		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
-		   REG_UFS_CFG1);
+	ufshcd_rmwl(host->hba, QUNIPRO_SEL, QUNIPRO_SEL, REG_UFS_CFG1);
 
 	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
@@ -333,18 +331,8 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
-	if (host->hw_ver.major == 0x1) {
-		/*
-		 * HS-G3 operations may not reliably work on legacy QCOM
-		 * UFS host controller hardware even though capability
-		 * exchange during link startup phase may end up
-		 * negotiating maximum supported gear as G3.
-		 * Hence downgrade the maximum supported gear to HS-G2.
-		 */
-		return UFS_HS_G2;
-	} else if (host->hw_ver.major >= 0x4) {
+	if (host->hw_ver.major >= 0x4)
 		return UFS_QCOM_MAX_GEAR(ufshcd_readl(hba, REG_UFS_PARAM0));
-	}
 
 	/* Default is HS-G3 */
 	return UFS_HS_G3;
@@ -457,41 +445,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_clk_info *clki;
-	u32 core_clk_period_in_ns;
-	u32 tx_clk_cycles_per_us = 0;
 	unsigned long core_clk_rate = 0;
 	u32 core_clk_cycles_per_us;
 
-	static u32 pwm_fr_table[][2] = {
-		{UFS_PWM_G1, 0x1},
-		{UFS_PWM_G2, 0x1},
-		{UFS_PWM_G3, 0x1},
-		{UFS_PWM_G4, 0x1},
-	};
-
-	static u32 hs_fr_table_rA[][2] = {
-		{UFS_HS_G1, 0x1F},
-		{UFS_HS_G2, 0x3e},
-		{UFS_HS_G3, 0x7D},
-	};
-
-	static u32 hs_fr_table_rB[][2] = {
-		{UFS_HS_G1, 0x24},
-		{UFS_HS_G2, 0x49},
-		{UFS_HS_G3, 0x92},
-	};
-
 	/*
-	 * The Qunipro controller does not use following registers:
-	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
-	 * UFS_REG_PA_LINK_STARTUP_TIMER.
-	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
+	 * UTP controller uses SYS1CLK_1US_REG register for Interrupt
 	 * Aggregation logic.
 	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
 	 * controller V4.0.0 onwards.
 	 */
-	if (host->hw_ver.major < 4 && ufs_qcom_cap_qunipro(host) &&
-	    !ufshcd_is_intr_aggr_allowed(hba))
+	if (host->hw_ver.major < 4 && !ufshcd_is_intr_aggr_allowed(hba))
 		return 0;
 
 	if (gear == 0) {
@@ -524,79 +487,6 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		mb();
 	}
 
-	if (ufs_qcom_cap_qunipro(host))
-		return 0;
-
-	core_clk_period_in_ns = NSEC_PER_SEC / core_clk_rate;
-	core_clk_period_in_ns <<= OFFSET_CLK_NS_REG;
-	core_clk_period_in_ns &= MASK_CLK_NS_REG;
-
-	switch (hs) {
-	case FASTAUTO_MODE:
-	case FAST_MODE:
-		if (rate == PA_HS_MODE_A) {
-			if (gear > ARRAY_SIZE(hs_fr_table_rA)) {
-				dev_err(hba->dev,
-					"%s: index %d exceeds table size %zu\n",
-					__func__, gear,
-					ARRAY_SIZE(hs_fr_table_rA));
-				return -EINVAL;
-			}
-			tx_clk_cycles_per_us = hs_fr_table_rA[gear-1][1];
-		} else if (rate == PA_HS_MODE_B) {
-			if (gear > ARRAY_SIZE(hs_fr_table_rB)) {
-				dev_err(hba->dev,
-					"%s: index %d exceeds table size %zu\n",
-					__func__, gear,
-					ARRAY_SIZE(hs_fr_table_rB));
-				return -EINVAL;
-			}
-			tx_clk_cycles_per_us = hs_fr_table_rB[gear-1][1];
-		} else {
-			dev_err(hba->dev, "%s: invalid rate = %d\n",
-				__func__, rate);
-			return -EINVAL;
-		}
-		break;
-	case SLOWAUTO_MODE:
-	case SLOW_MODE:
-		if (gear > ARRAY_SIZE(pwm_fr_table)) {
-			dev_err(hba->dev,
-					"%s: index %d exceeds table size %zu\n",
-					__func__, gear,
-					ARRAY_SIZE(pwm_fr_table));
-			return -EINVAL;
-		}
-		tx_clk_cycles_per_us = pwm_fr_table[gear-1][1];
-		break;
-	case UNCHANGED:
-	default:
-		dev_err(hba->dev, "%s: invalid mode = %d\n", __func__, hs);
-		return -EINVAL;
-	}
-
-	if (ufshcd_readl(hba, REG_UFS_TX_SYMBOL_CLK_NS_US) !=
-	    (core_clk_period_in_ns | tx_clk_cycles_per_us)) {
-		/* this register 2 fields shall be written at once */
-		ufshcd_writel(hba, core_clk_period_in_ns | tx_clk_cycles_per_us,
-			      REG_UFS_TX_SYMBOL_CLK_NS_US);
-		/*
-		 * make sure above write gets applied before we return from
-		 * this function.
-		 */
-		mb();
-	}
-
-	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
-		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
-			      REG_UFS_CFG0);
-		/*
-		 * make sure that this configuration is applied before
-		 * we return
-		 */
-		mb();
-	}
-
 	return 0;
 }
 
@@ -604,7 +494,6 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 					enum ufs_notify_change_status status)
 {
 	int err = 0;
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	switch (status) {
 	case PRE_CHANGE:
@@ -615,11 +504,9 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			return -EINVAL;
 		}
 
-		if (ufs_qcom_cap_qunipro(host)) {
-			err = ufs_qcom_set_core_clk_ctrl(hba, true);
-			if (err)
-				dev_err(hba->dev, "cfg core clk ctrl failed\n");
-		}
+		err = ufs_qcom_set_core_clk_ctrl(hba, true);
+		if (err)
+			dev_err(hba->dev, "cfg core clk ctrl failed\n");
 		/*
 		 * Some UFS devices (and may be host) have issues if LCC is
 		 * enabled. So we are setting PA_Local_TX_LCC_Enable to 0
@@ -918,12 +805,7 @@ static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
 
 static u32 ufs_qcom_get_ufs_hci_version(struct ufs_hba *hba)
 {
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-
-	if (host->hw_ver.major == 0x1)
-		return ufshci_version(1, 1);
-	else
-		return ufshci_version(2, 0);
+	return ufshci_version(2, 0);
 }
 
 /**
@@ -939,46 +821,21 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
-	if (host->hw_ver.major == 0x01) {
-		hba->quirks |= UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS
-			    | UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP
-			    | UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE;
-
-		if (host->hw_ver.minor == 0x0001 && host->hw_ver.step == 0x0001)
-			hba->quirks |= UFSHCD_QUIRK_BROKEN_INTR_AGGR;
-
-		hba->quirks |= UFSHCD_QUIRK_BROKEN_LCC;
-	}
-
-	if (host->hw_ver.major == 0x2) {
+	if (host->hw_ver.major == 0x2)
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
 
-		if (!ufs_qcom_cap_qunipro(host))
-			/* Legacy UniPro mode still need following quirks */
-			hba->quirks |= (UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS
-				| UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE
-				| UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
-	}
-
 	if (host->hw_ver.major > 0x3)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
 {
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-
 	hba->caps |= UFSHCD_CAP_CLK_GATING | UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
 	hba->caps |= UFSHCD_CAP_CLK_SCALING | UFSHCD_CAP_WB_WITH_CLK_SCALING;
 	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
 	hba->caps |= UFSHCD_CAP_WB_EN;
 	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
 	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
-
-	if (host->hw_ver.major >= 0x2) {
-		host->caps = UFS_QCOM_CAP_QUNIPRO |
-			     UFS_QCOM_CAP_RETAIN_SEC_CFG_AFTER_PWR_COLLAPSE;
-	}
 }
 
 /**
@@ -1101,9 +958,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 {
 	int err;
 	struct device *dev = hba->dev;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct ufs_qcom_host *host;
-	struct resource *res;
 	struct ufs_clk_info *clki;
 
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
@@ -1154,25 +1009,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	ufs_qcom_get_controller_revision(hba, &host->hw_ver.major,
 		&host->hw_ver.minor, &host->hw_ver.step);
 
-	/*
-	 * for newer controllers, device reference clock control bit has
-	 * moved inside UFS controller register address space itself.
-	 */
-	if (host->hw_ver.major >= 0x02) {
-		host->dev_ref_clk_ctrl_mmio = hba->mmio_base + REG_UFS_CFG1;
-		host->dev_ref_clk_en_mask = BIT(26);
-	} else {
-		/* "dev_ref_clk_ctrl_mem" is optional resource */
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "dev_ref_clk_ctrl_mem");
-		if (res) {
-			host->dev_ref_clk_ctrl_mmio =
-					devm_ioremap_resource(dev, res);
-			if (IS_ERR(host->dev_ref_clk_ctrl_mmio))
-				host->dev_ref_clk_ctrl_mmio = NULL;
-			host->dev_ref_clk_en_mask = BIT(5);
-		}
-	}
+	host->dev_ref_clk_ctrl_mmio = hba->mmio_base + REG_UFS_CFG1;
+	host->dev_ref_clk_en_mask = BIT(26);
 
 	list_for_each_entry(clki, &hba->clk_list_head, list) {
 		if (!strcmp(clki->name, "core_clk_unipro"))
@@ -1351,9 +1189,6 @@ static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
 	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
 	int ret;
 
-	if (!ufs_qcom_cap_qunipro(host))
-		return 0;
-
 	ret = ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
 				  attr->hs_rate, false, true);
 	if (ret) {
@@ -1371,13 +1206,9 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 
 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 {
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	int err;
 	u32 core_clk_ctrl_reg;
 
-	if (!ufs_qcom_cap_qunipro(host))
-		return 0;
-
 	err = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    &core_clk_ctrl_reg);
@@ -1396,11 +1227,6 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 
 static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 {
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-
-	if (!ufs_qcom_cap_qunipro(host))
-		return 0;
-
 	/* set unipro core clock attributes and clear clock divider */
 	return ufs_qcom_set_core_clk_ctrl(hba, false);
 }
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index a109d3359db4..385480499e71 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -114,13 +114,6 @@ enum {
 				 DFC_HW_CGC_EN | TRLUT_HW_CGC_EN |\
 				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
 
-/* bit offset */
-#define OFFSET_CLK_NS_REG		0xa
-
-/* bit masks */
-#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
-#define MASK_CLK_NS_REG			GENMASK(23, 10)
-
 /* QUniPro Vendor specific attributes */
 #define PA_VS_CONFIG_REG1	0x9000
 #define DME_VS_CORE_CLK_CTRL	0xD002
@@ -189,21 +182,6 @@ struct ufs_qcom_testbus {
 struct gpio_desc;
 
 struct ufs_qcom_host {
-	/*
-	 * Set this capability if host controller supports the QUniPro mode
-	 * and if driver wants the Host controller to operate in QUniPro mode.
-	 * Note: By default this capability will be kept enabled if host
-	 * controller supports the QUniPro mode.
-	 */
-	#define UFS_QCOM_CAP_QUNIPRO	0x1
-
-	/*
-	 * Set this capability if host controller can retain the secure
-	 * configuration even after UFS controller core power collapse.
-	 */
-	#define UFS_QCOM_CAP_RETAIN_SEC_CFG_AFTER_PWR_COLLAPSE	0x2
-	u32 caps;
-
 	struct phy *generic_phy;
 	struct ufs_hba *hba;
 	struct ufs_pa_layer_attr dev_req_params;
@@ -253,9 +231,4 @@ ufs_qcom_get_debug_reg_offset(struct ufs_qcom_host *host, u32 reg)
 
 int ufs_qcom_testbus_config(struct ufs_qcom_host *host);
 
-static inline bool ufs_qcom_cap_qunipro(struct ufs_qcom_host *host)
-{
-	return host->caps & UFS_QCOM_CAP_QUNIPRO;
-}
-
 #endif /* UFS_QCOM_H_ */
-- 
2.25.1

