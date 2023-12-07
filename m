Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353C80862A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378766AbjLGKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378629AbjLGKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:53:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3435D7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:53:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1e116f2072so170999266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701946385; x=1702551185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HGtQumyENSvxoSv9yvTghsd1fDswdajFSHTZc++Fwo=;
        b=IkfP7KvHKESCxMxWQpF4cXpUlFNUk7bOwTDmSoEF+Glb7i6XR5TgKy29IBZGshLUwR
         /BVtFMMxUFDkQBFzrJQXGkzRve76ocHuN/HNFDEgKcSKgPBT7fU/uYqyI60OQG5/C4hN
         eWszdocTUUOp8XcYyDuVlpiJqJF1fNI849AqGtg6aN9MWwigadrbewiBd+G1/GCEJm/6
         qcihbNItp4rEQf9LGFRjOcYMpIkp6HPb/AbjlFKkiOYfG4ACUULul26hCdMjErmEDmWu
         FjUYWDBSZmC64WKKR/U3Uc6noug+nEcyRKrpnXMInDp8ZYPcKMkAjenpzFgvxm7Fbj2H
         s/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946385; x=1702551185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HGtQumyENSvxoSv9yvTghsd1fDswdajFSHTZc++Fwo=;
        b=CPoWAh1fpbR+zx1+qGBXlNlEjAVEfj9IerbhbkR2z5ltEAL7jxOp/7VkBhHO/SBlGr
         ofcuJb8xSaETD9rkSN5ZTRvcVEO5HcAEsv1V5P7kkIxs9MSsUwq6xanOxkjMdOpE+AwY
         qidGfClKOesWvsu5tIjWArWMUgo8T27RLb8V8ZFO3sSahs2RzDAXXlQXr2k03zTsafMZ
         MQhMQ+To7Xg85ozPdWVlujpVW3qX1nSXuyedb4gSxG0u+QhLQ8sNq3D8I2QzCrArL+8G
         OitSuGznNDx/l2Zx9mH3HtqoOTlc1IIZVQrBdS+JtOapDikI8aQBjYJJJB8yBUy/iUuO
         Wb4g==
X-Gm-Message-State: AOJu0Yz49sFqtDRNPLEYH56p3fTrM2BQKtQV9K0s8UgMru+URYVqLBib
        Wpblx4PdOtVBzYAD/kMO1doYzg==
X-Google-Smtp-Source: AGHT+IG8rYk3HtxvWhQBD3gqEh3WTe7UnjpyF//V73AOL+L1DuVCJMfGjTAFEhxzyfHDLdLF9kimpA==
X-Received: by 2002:a17:906:101:b0:a18:81a3:a1fe with SMTP id 1-20020a170906010100b00a1881a3a1femr4846790eje.1.1701946385072;
        Thu, 07 Dec 2023 02:53:05 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a1db8b08610sm668700eji.148.2023.12.07.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:53:04 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 12:52:50 +0200
Subject: [PATCH v3 3/3] phy: qcom: edp: Add support for X1E80100 PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org>
References: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27496; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1OzVp06OdlamNxvG+R2odfAgsFuHfPs/bTQS1tnVBdU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcaQJrw6zd8/ZRiJLSCiw/B50+48Sm3xjKIzuO
 R3jdxe7Pn+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXGkCQAKCRAbX0TJAJUV
 VhGtD/9kXPajdRyHr8zk7W0i7cgVrj1Ut4yxX0i+lB0Qf7hf7/vhWdClS+jca+shM4fGuZf9hHJ
 6solyCvNF/usqN8Ryyd6LPcURv//Gbb2uHF/3T4Xk/L2+G+Seo4pJsjEjuxNA/gAwblUeh2LDuI
 PECYE5wF8Fiu8orZZyz7057lm3NZk9/B9m0t7UcYUQ43q8OXVyMJ+O1Zpi5iCWaPVh7S9v1WyPd
 8Z8fM9TtG3rXn+LudNSsWrC81fhb0b/adpUkBJuW/nW4j7FnF966w1o6ofOTWdqn+nTAtcBw6Av
 OLpSld8D5+e9wktiJDc85qg4iBz/rVJ9S0SLedS58S9NFVxxH8HIaY4C0q4ZFSKEYmSYHR+tcFC
 RH/mlGxJ4Dd/TXlzrjACiABpIu0slC/Vl4I0qP1F5rCLxZpcLVRk6blg8zXm5eWmARu3ilDFSet
 +nBt1vsqa4dpVX3KBahHoyDN5vptwqe5XKhqp2lLS2nMmoa5RrlQS13J/R0DSS0LuzokNYr/PUb
 o5AjYCu+PDQib44VGscd+sOZtpHhVtJQUM/IsDpkwQB759KY6Kvl0qQfcePx0y1w0/2rSIAn3ie
 EMulaiVJNr+5EDOxOyP/7GYCUDpxXQDFWFfVG7evGEuY6GYF7DvP99zzg3rqIS8wdy3pk/GmQEz
 F6cqP5b5tigv3xg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm X1E80100 platform has a number of eDP/DP PHY instances. These
are based on QMP v6. So add support for v6 QMP COM registers by supporting
configuration-based register offsets. For legacy platforms, keep the eDP and DP
compatibles different, but for new platforms, use the phy-type DT property
instead. So add platform specific configs, specify the version and override
the PHY type where compatible dictates it.

Co-developed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 583 ++++++++++++++++++++++++++++++------
 1 file changed, 490 insertions(+), 93 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 8e5078304646..6fc18bf80db1 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -68,10 +68,333 @@
 
 #define TXn_TRAN_DRVR_EMP_EN                    0x0078
 
-struct qcom_edp_cfg {
-	bool is_dp;
+enum dp_qmp_com_version {
+	DP_QMP_VERSION_V4,
+	DP_QMP_VERSION_V6,
+};
+
+enum dp_link_rate {
+	DP_LINK_RATE_1_6_GHZ,
+	DP_LINK_RATE_2_7_GHZ,
+	DP_LINK_RATE_5_4_GHZ,
+	DP_LINK_RATE_8_1_GHZ,
+};
+
+struct qmp_com_regs_layout {
+	unsigned int cmn_status;
+	unsigned int ssc_en_center;
+	unsigned int resetsm_cntrl;
+	unsigned int c_ready_status;
+	unsigned int ssc_per1;
+	unsigned int ssc_per2;
+	unsigned int ssc_step_size1_mode0;
+	unsigned int ssc_step_size2_mode0;
+	unsigned int ssc_adj_per1;
+	unsigned int svs_mode_clk_sel;
+	unsigned int sysclk_en_sel;
+	unsigned int sys_clk_ctrl;
+	unsigned int clk_enable1;
+	unsigned int clk_select;
+	unsigned int sysclk_buf_enable;
+	unsigned int hsclk_sel;
+	unsigned int pll_ivco;
+	unsigned int lock_cmp_en;
+	unsigned int pll_cctrl_mode0;
+	unsigned int pll_rctrl_mode0;
+	unsigned int cp_ctrl_mode0;
+	unsigned int dec_start_mode0;
+	unsigned int div_frac_start1_mode0;
+	unsigned int div_frac_start2_mode0;
+	unsigned int div_frac_start3_mode0;
+	unsigned int cmn_config;
+	unsigned int integloop_gain0_mode0;
+	unsigned int integloop_gain1_mode0;
+	unsigned int vco_tune_map;
+	unsigned int lock_cmp1_mode0;
+	unsigned int lock_cmp2_mode0;
+	unsigned int bg_timer;
+	unsigned int pll_core_clk_div_mode0;
+	unsigned int vco_tune_ctrl;
+	unsigned int pll_bias_en_clk_buflr_en;
+	unsigned int core_clk_en;
+	unsigned int vco_tune1_mode0;
+	unsigned int vco_tune2_mode0;
+	unsigned int bin_vcocal_cmp_code1_mode0;
+	unsigned int bin_vcocal_cmp_code2_mode0;
+};
+
+static const struct qmp_com_regs_layout qmp_v4_com_regs = {
+	.cmn_status			= QSERDES_V4_COM_CMN_STATUS,
+	.c_ready_status			= QSERDES_V4_COM_C_READY_STATUS,
+	.resetsm_cntrl			= QSERDES_V4_COM_RESETSM_CNTRL,
+	.ssc_en_center			= QSERDES_V4_COM_SSC_EN_CENTER,
+	.ssc_per1			= QSERDES_V4_COM_SSC_PER1,
+	.ssc_per2			= QSERDES_V4_COM_SSC_PER2,
+	.ssc_step_size1_mode0		= QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0,
+	.ssc_step_size2_mode0		= QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0,
+	.ssc_adj_per1			= QSERDES_V4_COM_SSC_ADJ_PER1,
+	.svs_mode_clk_sel		= QSERDES_V4_COM_SVS_MODE_CLK_SEL,
+	.sysclk_en_sel			= QSERDES_V4_COM_SYSCLK_EN_SEL,
+	.sys_clk_ctrl			= QSERDES_V4_COM_SYS_CLK_CTRL,
+	.sysclk_buf_enable		= QSERDES_V4_COM_SYSCLK_BUF_ENABLE,
+	.clk_enable1			= QSERDES_V4_COM_CLK_ENABLE1,
+	.clk_select			= QSERDES_V4_COM_CLK_SELECT,
+	.hsclk_sel			= QSERDES_V4_COM_HSCLK_SEL,
+	.pll_ivco			= QSERDES_V4_COM_PLL_IVCO,
+	.lock_cmp_en			= QSERDES_V4_COM_LOCK_CMP_EN,
+	.pll_cctrl_mode0		= QSERDES_V4_COM_PLL_CCTRL_MODE0,
+	.pll_rctrl_mode0		= QSERDES_V4_COM_PLL_RCTRL_MODE0,
+	.cp_ctrl_mode0			= QSERDES_V4_COM_CP_CTRL_MODE0,
+	.dec_start_mode0		= QSERDES_V4_COM_DEC_START_MODE0,
+	.div_frac_start1_mode0		= QSERDES_V4_COM_DIV_FRAC_START1_MODE0,
+	.div_frac_start2_mode0		= QSERDES_V4_COM_DIV_FRAC_START2_MODE0,
+	.div_frac_start3_mode0		= QSERDES_V4_COM_DIV_FRAC_START3_MODE0,
+	.cmn_config			= QSERDES_V4_COM_CMN_CONFIG,
+	.integloop_gain0_mode0		= QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0,
+	.integloop_gain1_mode0		= QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0,
+	.vco_tune_map			= QSERDES_V4_COM_VCO_TUNE_MAP,
+	.lock_cmp1_mode0		= QSERDES_V4_COM_LOCK_CMP1_MODE0,
+	.lock_cmp2_mode0		= QSERDES_V4_COM_LOCK_CMP2_MODE0,
+	.bg_timer			= QSERDES_V4_COM_BG_TIMER,
+	.pll_core_clk_div_mode0		= QSERDES_V4_COM_CORECLK_DIV_MODE0,
+	.vco_tune_ctrl			= QSERDES_V4_COM_VCO_TUNE_CTRL,
+	.pll_bias_en_clk_buflr_en	= QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN,
+	.core_clk_en			= QSERDES_V4_COM_CORE_CLK_EN,
+	.vco_tune1_mode0		= QSERDES_V4_COM_VCO_TUNE1_MODE0,
+	.vco_tune2_mode0		= QSERDES_V4_COM_VCO_TUNE2_MODE0,
+};
+
+static const struct qmp_com_regs_layout qmp_v6_com_regs = {
+	.cmn_status			= QSERDES_V6_COM_CMN_STATUS,
+	.c_ready_status			= QSERDES_V6_COM_C_READY_STATUS,
+	.resetsm_cntrl			= QSERDES_V6_COM_RESETSM_CNTRL,
+	.ssc_en_center			= QSERDES_V6_COM_SSC_EN_CENTER,
+	.ssc_per1			= QSERDES_V6_COM_SSC_PER1,
+	.ssc_per2			= QSERDES_V6_COM_SSC_PER2,
+	.ssc_step_size1_mode0		= QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0,
+	.ssc_step_size2_mode0		= QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0,
+	.ssc_adj_per1			= QSERDES_V6_COM_SSC_ADJ_PER1,
+	.svs_mode_clk_sel		= QSERDES_V6_COM_SVS_MODE_CLK_SEL,
+	.sysclk_en_sel			= QSERDES_V6_COM_SYSCLK_EN_SEL,
+	.sys_clk_ctrl			= QSERDES_V6_COM_SYS_CLK_CTRL,
+	.sysclk_buf_enable		= QSERDES_V6_COM_SYSCLK_BUF_ENABLE,
+	.clk_enable1			= QSERDES_V6_COM_CLK_ENABLE1,
+	.clk_select			= QSERDES_V6_COM_CLK_SELECT,
+	.hsclk_sel			= QSERDES_V6_COM_HSCLK_SEL_1,
+	.pll_ivco			= QSERDES_V6_COM_PLL_IVCO,
+	.lock_cmp_en			= QSERDES_V6_COM_LOCK_CMP_EN,
+	.pll_cctrl_mode0		= QSERDES_V6_COM_PLL_CCTRL_MODE0,
+	.pll_rctrl_mode0		= QSERDES_V6_COM_PLL_RCTRL_MODE0,
+	.cp_ctrl_mode0			= QSERDES_V6_COM_CP_CTRL_MODE0,
+	.dec_start_mode0		= QSERDES_V6_COM_DEC_START_MODE0,
+	.div_frac_start1_mode0		= QSERDES_V6_COM_DIV_FRAC_START1_MODE0,
+	.div_frac_start2_mode0		= QSERDES_V6_COM_DIV_FRAC_START2_MODE0,
+	.div_frac_start3_mode0		= QSERDES_V6_COM_DIV_FRAC_START3_MODE0,
+	.cmn_config			= QSERDES_V6_COM_CMN_CONFIG_1,
+	.integloop_gain0_mode0		= QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0,
+	.integloop_gain1_mode0		= QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0,
+	.vco_tune_map			= QSERDES_V6_COM_VCO_TUNE_MAP,
+	.lock_cmp1_mode0		= QSERDES_V6_COM_LOCK_CMP1_MODE0,
+	.lock_cmp2_mode0		= QSERDES_V6_COM_LOCK_CMP2_MODE0,
+	.bg_timer			= QSERDES_V6_COM_BG_TIMER,
+	.pll_core_clk_div_mode0		= QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0,
+	.vco_tune_ctrl			= QSERDES_V6_COM_VCO_TUNE_CTRL,
+	.pll_bias_en_clk_buflr_en	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
+	.core_clk_en			= QSERDES_V6_COM_CORE_CLK_EN,
+	.bin_vcocal_cmp_code1_mode0	= QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0,
+	.bin_vcocal_cmp_code2_mode0	= QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0,
+};
+
+struct qmp_com_init {
+	const u8 ssc_per1;
+	const u8 ssc_per2;
+	const u8 pll_ivco;
+	const u8 cmn_config;
+	const u8 vco_tune1_mode0;
+	const u8 vco_tune2_mode0;
+	const u8 pll_bias_en_clk_buflr_en;
+
+	const u8 *ssc_step1;
+	const u8 *ssc_step2;
+	const u8 *hsclk_sel;
+	const u8 *dec_start_mode0;
+	const u8 *div_frac_start2_mode0;
+	const u8 *div_frac_start3_mode0;
+	const u8 *lock_cmp1_mode0;
+	const u8 *lock_cmp2_mode0;
+	const u8 *code1_mode0;
+	const u8 *code2_mode0;
+};
+
+static const u8 qmp_v4_com_ssc_step1[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x45,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x45,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x5c,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x45,
+};
+
+static const u8 qmp_v4_com_ssc_step2[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x06,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x06,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x08,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x06,
+};
+
+static const u8 qmp_v4_com_hsclk_sel[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x05,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x03,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x01,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x00,
+};
+
+static const u8 qmp_v4_com_dec_start_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x69,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x69,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x8c,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x69,
+};
+
+static const u8 qmp_v4_com_div_frac_start2_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x80,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x80,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x00,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x80,
+};
+
+static const u8 qmp_v4_com_div_frac_start3_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x07,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x07,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x0a,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x07,
+};
+
+static const u8 qmp_v4_com_lock_cmp1_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x6f,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x0f,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x1f,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x2f,
+};
+
+static const u8 qmp_v4_com_lock_cmp2_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x08,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x0e,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x1c,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x2a,
+};
+
+static const struct qmp_com_init qmp_v4_com_init = {
+	.ssc_per1 = 0x36,
+	.ssc_per2 = 0x01,
+	.pll_ivco = 0x0f,
+	.cmn_config = 0x02,
+	.pll_bias_en_clk_buflr_en = 0x17,
+	.ssc_step1 = qmp_v4_com_ssc_step1,
+	.ssc_step2 = qmp_v4_com_ssc_step2,
+	.hsclk_sel = qmp_v4_com_hsclk_sel,
+	.dec_start_mode0 = qmp_v4_com_dec_start_mode0,
+	.div_frac_start2_mode0 = qmp_v4_com_div_frac_start2_mode0,
+	.div_frac_start3_mode0 = qmp_v4_com_div_frac_start3_mode0,
+	.lock_cmp1_mode0 = qmp_v4_com_lock_cmp1_mode0,
+	.lock_cmp2_mode0 = qmp_v4_com_lock_cmp2_mode0,
+	.vco_tune1_mode0 = 0xa0,
+	.vco_tune2_mode0 = 0x03,
+};
+
+static const u8 qmp_v6_com_ssc_step1[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x92,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x92,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x18,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x92,
+};
+
+static const u8 qmp_v6_com_ssc_step2[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x01,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x01,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x02,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x01,
+};
+
+static const u8 qmp_v6_com_hsclk_sel[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x05,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x03,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x01,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x00,
+};
+
+static const u8 qmp_v6_com_dec_start_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x34,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x34,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x46,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x34,
+};
+
+static const u8 qmp_v6_com_div_frac_start2_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0xc0,
+	[DP_LINK_RATE_2_7_GHZ]	= 0xc0,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x00,
+	[DP_LINK_RATE_8_1_GHZ]	= 0xc0,
+};
+
+static const u8 qmp_v6_com_div_frac_start3_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x0b,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x0b,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x05,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x0b,
+};
+
+static const u8 qmp_v6_com_lock_cmp1_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x37,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x07,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x0f,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x17,
+};
 
-	/* DP PHY swing and pre_emphasis tables */
+static const u8 qmp_v6_com_lock_cmp2_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x04,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x07,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x0e,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x15,
+};
+
+static const u8 qmp_v6_com_code1_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x71,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x71,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x97,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x71,
+};
+
+static const u8 qmp_v6_com_code2_mode0[] = {
+	[DP_LINK_RATE_1_6_GHZ]	= 0x0c,
+	[DP_LINK_RATE_2_7_GHZ]	= 0x0c,
+	[DP_LINK_RATE_5_4_GHZ]	= 0x10,
+	[DP_LINK_RATE_8_1_GHZ]	= 0x0c,
+};
+
+static const struct qmp_com_init qmp_v6_com_init = {
+	.ssc_per1 = 0x6b,
+	.ssc_per2 = 0x02,
+	.pll_ivco = 0x07,
+	.cmn_config = 0x12,
+	.pll_bias_en_clk_buflr_en = 0x1f,
+	.ssc_step1 = qmp_v6_com_ssc_step1,
+	.ssc_step2 = qmp_v6_com_ssc_step2,
+	.hsclk_sel = qmp_v6_com_hsclk_sel,
+	.dec_start_mode0 = qmp_v6_com_dec_start_mode0,
+	.div_frac_start2_mode0 = qmp_v6_com_div_frac_start2_mode0,
+	.div_frac_start3_mode0 = qmp_v6_com_div_frac_start3_mode0,
+	.lock_cmp1_mode0 = qmp_v6_com_lock_cmp1_mode0,
+	.lock_cmp2_mode0 = qmp_v6_com_lock_cmp2_mode0,
+	.code1_mode0 = qmp_v6_com_code1_mode0,
+	.code2_mode0 = qmp_v6_com_code2_mode0,
+};
+
+struct qmp_phy_cfg {
+	int type;
+	enum dp_qmp_com_version version;
+	bool needs_swing_pre_emph_cfg;
+};
+
+struct qcom_dp_swing_pre_emph_cfg {
 	const u8 (*swing_hbr_rbr)[4][4];
 	const u8 (*swing_hbr3_hbr2)[4][4];
 	const u8 (*pre_emphasis_hbr_rbr)[4][4];
@@ -80,7 +403,9 @@ struct qcom_edp_cfg {
 
 struct qcom_edp {
 	struct device *dev;
-	const struct qcom_edp_cfg *cfg;
+	const struct qcom_dp_swing_pre_emph_cfg *swing_pre_emph_cfg;
+	const struct qmp_com_regs_layout *com_regs;
+	const struct qmp_com_init *init_values;
 
 	struct phy *phy;
 
@@ -96,6 +421,8 @@ struct qcom_edp {
 
 	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
+
+	bool is_dp;
 };
 
 static const u8 dp_swing_hbr_rbr[4][4] = {
@@ -126,8 +453,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x04, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg dp_phy_cfg = {
-	.is_dp = true,
+static const struct qcom_dp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
 	.swing_hbr_rbr = &dp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
@@ -162,18 +488,40 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x00, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg edp_phy_cfg = {
-	.is_dp = false,
+static const struct qcom_dp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
 	.swing_hbr_rbr = &edp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
 	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
 };
 
+static struct qmp_phy_cfg sc7280_dp_phy_cfg = {
+	.type = PHY_TYPE_DP,
+	.version = DP_QMP_VERSION_V4,
+};
+
+static struct qmp_phy_cfg sc8280xp_dp_phy_cfg = {
+	.type = PHY_TYPE_DP,
+	.version = DP_QMP_VERSION_V4,
+	.needs_swing_pre_emph_cfg = true,
+};
+
+static struct qmp_phy_cfg sc8280xp_edp_phy_cfg = {
+	.type = PHY_TYPE_EDP,
+	.version = DP_QMP_VERSION_V4,
+	.needs_swing_pre_emph_cfg = true,
+};
+
+static struct qmp_phy_cfg x1e80100_phy_cfg = {
+	.version = DP_QMP_VERSION_V6,
+	.needs_swing_pre_emph_cfg = true,
+};
+
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qmp_com_init *init = edp->init_values;
+	const struct qmp_com_regs_layout *regs = edp->com_regs;
 	int ret;
 	u8 cfg8;
 
@@ -190,7 +538,8 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       edp->edp + DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
-	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+	writel(init->pll_bias_en_clk_buflr_en,
+	       edp->pll + regs->pll_bias_en_clk_buflr_en);
 
 	writel(DP_PHY_PD_CTL_PSR_PWRDN, edp->edp + DP_PHY_PD_CTL);
 	msleep(20);
@@ -200,7 +549,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	if (cfg && cfg->is_dp)
+	if (edp->is_dp)
 		cfg8 = 0xb7;
 	else
 		cfg8 = 0x37;
@@ -234,7 +583,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_dp_swing_pre_emph_cfg *cfg = edp->swing_pre_emph_cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -261,7 +610,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	ldo_config = edp->is_dp ? 0x1 : 0x0;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -291,20 +640,21 @@ static int qcom_edp_phy_configure(struct phy *phy, union phy_configure_opts *opt
 static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
-	u32 step1;
-	u32 step2;
+	const struct qmp_com_regs_layout *regs = edp->com_regs;
+	const struct qmp_com_init *init = edp->init_values;
+	int link_rate;
+	u8 step1, step2;
+	u8 per1, per2;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
 	case 2700:
 	case 8100:
-		step1 = 0x45;
-		step2 = 0x06;
+		link_rate = DP_LINK_RATE_1_6_GHZ;
 		break;
 
 	case 5400:
-		step1 = 0x5c;
-		step2 = 0x08;
+		link_rate = DP_LINK_RATE_5_4_GHZ;
 		break;
 
 	default:
@@ -312,12 +662,18 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 		return -EINVAL;
 	}
 
-	writel(0x01, edp->pll + QSERDES_V4_COM_SSC_EN_CENTER);
-	writel(0x00, edp->pll + QSERDES_V4_COM_SSC_ADJ_PER1);
-	writel(0x36, edp->pll + QSERDES_V4_COM_SSC_PER1);
-	writel(0x01, edp->pll + QSERDES_V4_COM_SSC_PER2);
-	writel(step1, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0);
-	writel(step2, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0);
+	step1 = init->ssc_step1[link_rate];
+	step2 = init->ssc_step2[link_rate];
+
+	per1 = init->ssc_per1;
+	per2 = init->ssc_per2;
+
+	writel(0x01, edp->pll + regs->ssc_en_center);
+	writel(0x00, edp->pll + regs->ssc_adj_per1);
+	writel(per1, edp->pll + regs->ssc_per1);
+	writel(per2, edp->pll + regs->ssc_per2);
+	writel(step1, edp->pll + regs->ssc_step_size1_mode0);
+	writel(step2, edp->pll + regs->ssc_step_size2_mode0);
 
 	return 0;
 }
@@ -325,48 +681,30 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct qmp_com_regs_layout *regs = edp->com_regs;
+	const struct qmp_com_init *init = edp->init_values;
 	u32 div_frac_start2_mode0;
 	u32 div_frac_start3_mode0;
 	u32 dec_start_mode0;
 	u32 lock_cmp1_mode0;
 	u32 lock_cmp2_mode0;
+	u32 code1_mode0;
+	u32 code2_mode0;
 	u32 hsclk_sel;
+	int link_rate;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
-		hsclk_sel = 0x5;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x6f;
-		lock_cmp2_mode0 = 0x08;
+		link_rate = DP_LINK_RATE_1_6_GHZ;
 		break;
-
 	case 2700:
-		hsclk_sel = 0x3;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x0f;
-		lock_cmp2_mode0 = 0x0e;
+		link_rate = DP_LINK_RATE_2_7_GHZ;
 		break;
-
 	case 5400:
-		hsclk_sel = 0x1;
-		dec_start_mode0 = 0x8c;
-		div_frac_start2_mode0 = 0x00;
-		div_frac_start3_mode0 = 0x0a;
-		lock_cmp1_mode0 = 0x1f;
-		lock_cmp2_mode0 = 0x1c;
+		link_rate = DP_LINK_RATE_5_4_GHZ;
 		break;
-
 	case 8100:
-		hsclk_sel = 0x0;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x2f;
-		lock_cmp2_mode0 = 0x2a;
+		link_rate = DP_LINK_RATE_8_1_GHZ;
 		break;
 
 	default:
@@ -374,36 +712,59 @@ static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 		return -EINVAL;
 	}
 
-	writel(0x01, edp->pll + QSERDES_V4_COM_SVS_MODE_CLK_SEL);
-	writel(0x0b, edp->pll + QSERDES_V4_COM_SYSCLK_EN_SEL);
-	writel(0x02, edp->pll + QSERDES_V4_COM_SYS_CLK_CTRL);
-	writel(0x0c, edp->pll + QSERDES_V4_COM_CLK_ENABLE1);
-	writel(0x06, edp->pll + QSERDES_V4_COM_SYSCLK_BUF_ENABLE);
-	writel(0x30, edp->pll + QSERDES_V4_COM_CLK_SELECT);
-	writel(hsclk_sel, edp->pll + QSERDES_V4_COM_HSCLK_SEL);
-	writel(0x0f, edp->pll + QSERDES_V4_COM_PLL_IVCO);
-	writel(0x08, edp->pll + QSERDES_V4_COM_LOCK_CMP_EN);
-	writel(0x36, edp->pll + QSERDES_V4_COM_PLL_CCTRL_MODE0);
-	writel(0x16, edp->pll + QSERDES_V4_COM_PLL_RCTRL_MODE0);
-	writel(0x06, edp->pll + QSERDES_V4_COM_CP_CTRL_MODE0);
-	writel(dec_start_mode0, edp->pll + QSERDES_V4_COM_DEC_START_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_DIV_FRAC_START1_MODE0);
-	writel(div_frac_start2_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START2_MODE0);
-	writel(div_frac_start3_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START3_MODE0);
-	writel(0x02, edp->pll + QSERDES_V4_COM_CMN_CONFIG);
-	writel(0x3f, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_MAP);
-	writel(lock_cmp1_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP1_MODE0);
-	writel(lock_cmp2_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP2_MODE0);
-
-	writel(0x0a, edp->pll + QSERDES_V4_COM_BG_TIMER);
-	writel(0x14, edp->pll + QSERDES_V4_COM_CORECLK_DIV_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_CTRL);
-	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
-	writel(0x0f, edp->pll + QSERDES_V4_COM_CORE_CLK_EN);
-	writel(0xa0, edp->pll + QSERDES_V4_COM_VCO_TUNE1_MODE0);
-	writel(0x03, edp->pll + QSERDES_V4_COM_VCO_TUNE2_MODE0);
+	hsclk_sel = init->hsclk_sel[link_rate];
+	dec_start_mode0 = init->dec_start_mode0[link_rate];
+	div_frac_start2_mode0 = init->div_frac_start2_mode0[link_rate];
+	div_frac_start3_mode0 = init->div_frac_start3_mode0[link_rate];
+	lock_cmp1_mode0	= init->lock_cmp1_mode0[link_rate];
+	lock_cmp2_mode0	= init->lock_cmp2_mode0[link_rate];
+
+	if (init->code1_mode0)
+		code1_mode0 = init->code1_mode0[link_rate];
+
+	if (init->code2_mode0)
+		code2_mode0 = init->code2_mode0[link_rate];
+
+	writel(0x01, edp->pll + regs->svs_mode_clk_sel);
+	writel(0x0b, edp->pll + regs->sysclk_en_sel);
+	writel(0x02, edp->pll + regs->sys_clk_ctrl);
+	writel(0x0c, edp->pll + regs->clk_enable1);
+	writel(0x06, edp->pll + regs->sysclk_buf_enable);
+	writel(0x30, edp->pll + regs->clk_select);
+	writel(hsclk_sel, edp->pll + regs->hsclk_sel);
+	writel(init->pll_ivco, edp->pll + regs->pll_ivco);
+	writel(0x08, edp->pll + regs->lock_cmp_en);
+	writel(0x36, edp->pll + regs->pll_cctrl_mode0);
+	writel(0x16, edp->pll + regs->pll_rctrl_mode0);
+	writel(0x06, edp->pll + regs->cp_ctrl_mode0);
+	writel(dec_start_mode0, edp->pll + regs->dec_start_mode0);
+	writel(0x00, edp->pll + regs->div_frac_start1_mode0);
+	writel(div_frac_start2_mode0, edp->pll + regs->div_frac_start2_mode0);
+	writel(div_frac_start3_mode0, edp->pll + regs->div_frac_start3_mode0);
+	writel(init->cmn_config, edp->pll + regs->cmn_config);
+	writel(0x3f, edp->pll + regs->integloop_gain0_mode0);
+	writel(0x00, edp->pll + regs->integloop_gain1_mode0);
+	writel(0x00, edp->pll + regs->vco_tune_map);
+	writel(lock_cmp1_mode0, edp->pll + regs->lock_cmp1_mode0);
+	writel(lock_cmp2_mode0, edp->pll + regs->lock_cmp2_mode0);
+
+	writel(0x0a, edp->pll + regs->bg_timer);
+	writel(0x14, edp->pll + regs->pll_core_clk_div_mode0);
+	writel(0x00, edp->pll + regs->vco_tune_ctrl);
+	writel(0x17, edp->pll + regs->pll_bias_en_clk_buflr_en);
+	writel(0x0f, edp->pll + regs->core_clk_en);
+
+	if (regs->vco_tune1_mode0)
+		writel(init->vco_tune1_mode0, edp->pll + regs->vco_tune1_mode0);
+
+	if (regs->vco_tune2_mode0)
+		writel(init->vco_tune2_mode0, edp->pll + regs->vco_tune2_mode0);
+
+	if (regs->bin_vcocal_cmp_code1_mode0)
+		writel(code1_mode0, edp->pll + regs->bin_vcocal_cmp_code1_mode0);
+
+	if (regs->bin_vcocal_cmp_code2_mode0)
+		writel(code2_mode0, edp->pll + regs->bin_vcocal_cmp_code2_mode0);
 
 	return 0;
 }
@@ -447,10 +808,10 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qmp_com_regs_layout *regs = edp->com_regs;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
-	u8 ldo_config;
+	u8 ldo_config = 0x0;
 	int timeout;
 	int ret;
 	u32 val;
@@ -462,13 +823,14 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	       edp->edp + DP_PHY_PD_CTL);
 	writel(0xfc, edp->edp + DP_PHY_MODE);
 
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_CMN_STATUS,
+	timeout = readl_poll_timeout(edp->pll + regs->cmn_status,
 				     val, val & BIT(7), 5, 200);
 	if (timeout)
 		return timeout;
 
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (edp->swing_pre_emph_cfg && edp->is_dp)
+		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -512,9 +874,9 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x01, edp->edp + DP_PHY_CFG);
 	writel(0x09, edp->edp + DP_PHY_CFG);
 
-	writel(0x20, edp->pll + QSERDES_V4_COM_RESETSM_CNTRL);
+	writel(0x20, edp->pll + regs->resetsm_cntrl);
 
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_C_READY_STATUS,
+	timeout = readl_poll_timeout(edp->pll + regs->c_ready_status,
 				     val, val & BIT(0), 500, 10000);
 	if (timeout)
 		return timeout;
@@ -768,6 +1130,37 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	return devm_of_clk_add_hw_provider(edp->dev, of_clk_hw_onecell_get, data);
 }
 
+static int qcom_edp_setup_phy(struct platform_device *pdev, struct qcom_edp *edp)
+{
+	struct device *dev = &pdev->dev;
+	const struct qmp_phy_cfg *cfg = of_device_get_match_data(dev);
+	enum dp_qmp_com_version version = cfg->version;
+	struct device_node *node = dev->of_node;
+	int type = cfg->type;
+
+	of_property_read_u32(node, "phy-type", &type);
+
+	if (type != PHY_TYPE_DP && type != PHY_TYPE_EDP)
+		return -EINVAL;
+
+	edp->is_dp = (type == PHY_TYPE_DP) ? true : false;
+
+	if (cfg->needs_swing_pre_emph_cfg)
+		edp->swing_pre_emph_cfg = edp->is_dp ?
+						&dp_phy_swing_pre_emph_cfg:
+						&edp_phy_swing_pre_emph_cfg;
+
+	if (version == DP_QMP_VERSION_V6) {
+		edp->com_regs = &qmp_v6_com_regs;
+		edp->init_values = &qmp_v6_com_init;
+	} else {
+		edp->com_regs = &qmp_v4_com_regs;
+		edp->init_values = &qmp_v4_com_init;
+	}
+
+	return 0;
+}
+
 static int qcom_edp_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -780,7 +1173,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	edp->dev = dev;
-	edp->cfg = of_device_get_match_data(&pdev->dev);
+
+	ret = qcom_edp_setup_phy(pdev, edp);
+	if (ret)
+		return ret;
 
 	edp->edp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edp->edp))
@@ -839,10 +1235,11 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
-	{ .compatible = "qcom,sc7280-edp-phy" },
-	{ .compatible = "qcom,sc8180x-edp-phy" },
-	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
-	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
+	{ .compatible = "qcom,sc7280-edp-phy" , .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
+	{ .compatible = "qcom,x1e80100-dp-phy" , .data = &x1e80100_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1

