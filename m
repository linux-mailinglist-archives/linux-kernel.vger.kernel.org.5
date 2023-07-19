Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF7758F60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGSHoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGSHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:43:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752D268F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:42:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26314c2be8eso3597491a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689752577; x=1690357377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kbs2DuWb4kB1m8a4nLkKBnUGt5UrZsO1n5+nbdXlnA=;
        b=NxYRpMQ1MI3s26pnW2g/EuUERfFiKqPtolriGBIpLZlPtkVKTzvs3UcHHtciA4FRBc
         tBmPpu1++ooa1smNKdUc/sF7158Vo8ra5BN2dcV7ZzjvtDZV+PjdQFOg8sQveIREZn3C
         vWkPZVwlxjajHG5oNnNVAPaaI5JbsJYcUpzxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752577; x=1690357377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kbs2DuWb4kB1m8a4nLkKBnUGt5UrZsO1n5+nbdXlnA=;
        b=VIjVsQEb3JUH3jai4XOgwSeN3o8VKKdQeZnqb5rmTFoZtax2TXho9FFQ2NLUnnocgA
         rPZrSTyIMRoFcWnQ2ouBoUrK55CNhFsbHWYZn33IC5F0qmXv8qMYqkQ/7NhKlCMf7O/8
         AzdUKOcuf1VrjRMW97K6J0HWr3xBMfsCU18+8eJyynl1V/ldgJ3qCBx4NXPO6ykG3tUu
         LPiI6UnD0c+Fd+TtRDTWdlsU/kytBqpJl3CwhNLgpu8R6UOAIsPcki4BydTBvqlNGIGt
         IYrJyjg0gJkvdE3zLSGfjf0B/LjLoKuI0iGKjAKhw/CX122uIRD+0mRqwrIfwmsi1xMb
         0dqw==
X-Gm-Message-State: ABy/qLbT+i8JldDU2tmCjMMVMGQuCS1Oc2ZcMwyZFVUHECFM6x5suuuO
        jM7/NXSlfXq73EuQZl4ASDja4A==
X-Google-Smtp-Source: APBJJlHj8emtlM2xqJSmgfj7e1lMySh3gNJProkHsWCZl2AjGt7U6HHZa476k9mL+uXpbwnw3nTGZA==
X-Received: by 2002:a17:90a:f2cf:b0:263:f856:a82c with SMTP id gt15-20020a17090af2cf00b00263f856a82cmr1076296pjb.15.1689752576701;
        Wed, 19 Jul 2023 00:42:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:dc1f:4359:d310:3643])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090a1fc100b002631f3d36a1sm710274pjz.36.2023.07.19.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:42:56 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt8183: Add back SSPM related clocks
Date:   Wed, 19 Jul 2023 15:42:50 +0800
Message-ID: <20230719074251.1219089-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 860690a93ef23b567f781c1b631623e27190f101.

On the MT8183, the SSPM related clocks were removed claiming a lack of
usage. This however causes some issues when the driver was converted to
the new simple-probe mechanism. This mechanism allocates enough space
for all the clocks defined in the clock driver, not the highest index
in the DT binding. This leads to out-of-bound writes if their are holes
in the DT binding or the driver (due to deprecated or unimplemented
clocks). These errors can go unnoticed and cause memory corruption,
leading to crashes in unrelated areas, or nothing at all. KASAN will
detect them.

Add the SSPM related clocks back to the MT8183 clock driver to fully
implement the DT binding. The SSPM clocks are for the power management
co-processor, and should never be turned off. They are marked as such.

Fixes: 3f37ba7cc385 ("clk: mediatek: mt8183: Convert all remaining clocks to common probe")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Please merge for fixes.

 drivers/clk/mediatek/clk-mt8183.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 1ba421b38ec5..e31f94387d87 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -328,6 +328,14 @@ static const char * const atb_parents[] = {
 	"syspll_d5"
 };
 
+static const char * const sspm_parents[] = {
+	"clk26m",
+	"univpll_d2_d4",
+	"syspll_d2_d2",
+	"univpll_d2_d2",
+	"syspll_d3"
+};
+
 static const char * const dpi0_parents[] = {
 	"clk26m",
 	"tvdpll_d2",
@@ -507,6 +515,9 @@ static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_6 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_ATB, "atb_sel",
 		atb_parents, 0xa0, 0xa4, 0xa8, 0, 2, 7, 0x004, 24),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_SSPM, "sspm_sel",
+				   sspm_parents, 0xa0, 0xa4, 0xa8, 8, 3, 15, 0x004, 25,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_DPI0, "dpi0_sel",
 		dpi0_parents, 0xa0, 0xa4, 0xa8, 16, 4, 23, 0x004, 26),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SCAM, "scam_sel",
@@ -673,10 +684,18 @@ static const struct mtk_gate_regs infra3_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift,	\
 		&mtk_clk_gate_ops_setclr)
 
+#define GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, _flag)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra2_cg_regs, 	\
+		       _shift, &mtk_clk_gate_ops_setclr, _flag)
+
 #define GATE_INFRA3(_id, _name, _parent, _shift)		\
 	GATE_MTK(_id, _name, _parent, &infra3_cg_regs, _shift,	\
 		&mtk_clk_gate_ops_setclr)
 
+#define GATE_INFRA3_FLAGS(_id, _name, _parent, _shift, _flag)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra3_cg_regs, 	\
+		       _shift, &mtk_clk_gate_ops_setclr, _flag)
+
 static const struct mtk_gate infra_clks[] = {
 	/* INFRA0 */
 	GATE_INFRA0(CLK_INFRA_PMIC_TMR, "infra_pmic_tmr", "axi_sel", 0),
@@ -748,7 +767,11 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA2(CLK_INFRA_UNIPRO_TICK, "infra_unipro_tick", "fufs_sel", 12),
 	GATE_INFRA2(CLK_INFRA_UFS_MP_SAP_BCLK, "infra_ufs_mp_sap_bck", "fufs_sel", 13),
 	GATE_INFRA2(CLK_INFRA_MD32_BCLK, "infra_md32_bclk", "axi_sel", 14),
+	/* infra_sspm is main clock in co-processor, should not be closed in Linux. */
+	GATE_INFRA2_FLAGS(CLK_INFRA_SSPM, "infra_sspm", "sspm_sel", 15, CLK_IS_CRITICAL),
 	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, "infra_unipro_mbist", "axi_sel", 16),
+	/* infra_sspm_bus_hclk is main clock in co-processor, should not be closed in Linux. */
+	GATE_INFRA2_FLAGS(CLK_INFRA_SSPM_BUS_HCLK, "infra_sspm_bus_hclk", "axi_sel", 17, CLK_IS_CRITICAL),
 	GATE_INFRA2(CLK_INFRA_I2C5, "infra_i2c5", "i2c_sel", 18),
 	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, "infra_i2c5_arbiter", "i2c_sel", 19),
 	GATE_INFRA2(CLK_INFRA_I2C5_IMM, "infra_i2c5_imm", "i2c_sel", 20),
@@ -766,6 +789,10 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_MSDC0_SELF, "infra_msdc0_self", "msdc50_0_sel", 0),
 	GATE_INFRA3(CLK_INFRA_MSDC1_SELF, "infra_msdc1_self", "msdc50_0_sel", 1),
 	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, "infra_msdc2_self", "msdc50_0_sel", 2),
+	/* infra_sspm_26m_self is main clock in co-processor, should not be closed in Linux. */
+	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self", "f_f26m_ck", 3, CLK_IS_CRITICAL),
+	/* infra_sspm_32k_self is main clock in co-processor, should not be closed in Linux. */
+	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "f_f26m_ck", 4, CLK_IS_CRITICAL),
 	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi", "axi_sel", 5),
 	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6", "i2c_sel", 6),
 	GATE_INFRA3(CLK_INFRA_AP_MSDC0, "infra_ap_msdc0", "msdc50_hclk_sel", 7),
-- 
2.41.0.455.g037347b96a-goog

