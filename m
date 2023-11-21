Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88C7F2D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjKUMvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjKUMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B0D40;
        Tue, 21 Nov 2023 04:50:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A17FD6607314;
        Tue, 21 Nov 2023 12:50:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571056;
        bh=HjqA+sAHeyELuvvhdsMlpINGaociXjYFjdm6q68a7V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asVihs0lKspnKojWxFlpYVRcUfG+duWidqbA5ziqx7fNXdoUpGLD1p71fUVyfL05f
         5ySn/H+mo/46WeUGKUUcWGhoXN/JRFx7R9ic0F4ZKbYPneAkspQrY95jGjTaWHjxG6
         2wYinIfHnmyLyq6WfYZqOy+GElxIx28jdM4rwBj+R6QEFck1tcEz3IKTQ8iFTZP2DS
         fS++It+Ta+hpLXJ5XYQ/L+HO9pxh9W1HQnHPPz2+mbCKrDV5kd58JwJINPLivS3yvK
         q/6+jYCq98uVkjOEfzsGsT5Pny+Q7zA3OF8xeTrc7B6Il4GgBM0yA27Mfeq9UEAeL8
         eTWfIS7kLp6cA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 05/20] soc: mediatek: mtk-svs: Reduce memory footprint of struct svs_bank
Date:   Tue, 21 Nov 2023 13:50:29 +0100
Message-ID: <20231121125044.78642-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many 32-bit members of this struct can be size reduced to either 16-bit
or even 8-bit, for a total saving of ~61 bytes per bank. Keeping in mind
that one SoC declares at least two banks, this brings a minimum of ~122
bytes saving (depending on compiler optimization).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 51 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 1c7592fd6ae7..6c27fb523bfa 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -456,13 +456,13 @@ struct svs_bank {
 	char *buck_name;
 	char *tzone_name;
 	enum svsb_phase phase;
-	s32 volt_od;
+	short int volt_od;
 	u32 reg_data[SVSB_PHASE_MAX][SVS_REG_MAX];
 	u32 pm_runtime_enabled_count;
-	u32 mode_support;
+	u8 mode_support;
 	u32 freq_base;
 	u32 turn_freq_base;
-	u32 vboot;
+	u8 vboot;
 	u32 opp_dfreq[MAX_OPP_ENTRIES];
 	u32 opp_dvolt[MAX_OPP_ENTRIES];
 	u32 freq_pct[MAX_OPP_ENTRIES];
@@ -470,36 +470,36 @@ struct svs_bank {
 	u32 volt_step;
 	u32 volt_base;
 	u32 volt_flags;
-	u32 vmax;
-	u32 vmin;
+	u8 vmax;
+	u8 vmin;
 	u32 age_config;
-	u32 age_voffset_in;
+	u16 age_voffset_in;
 	u32 dc_config;
-	u32 dc_voffset_in;
-	u32 dvt_fixed;
-	u32 vco;
-	u32 chk_shift;
+	u16 dc_voffset_in;
+	u8 dvt_fixed;
+	u8 vco;
+	u8 chk_shift;
 	u32 core_sel;
-	u32 opp_count;
+	u8 opp_count;
 	u32 int_st;
-	u32 sw_id;
-	u32 cpu_id;
+	u8 sw_id;
+	u8 cpu_id;
 	u32 ctl0;
 	u32 temp;
 	u32 tzone_htemp;
-	u32 tzone_htemp_voffset;
+	u16 tzone_htemp_voffset;
 	u32 tzone_ltemp;
-	u32 tzone_ltemp_voffset;
-	u32 bts;
-	u32 mts;
-	u32 bdes;
-	u32 mdes;
-	u32 mtdes;
-	u32 dcbdet;
-	u32 dcmdet;
+	u16 tzone_ltemp_voffset;
+	u16 bts;
+	u16 mts;
+	u16 bdes;
+	u16 mdes;
+	u8 mtdes;
+	u8 dcbdet;
+	u8 dcmdet;
 	u32 turn_pt;
 	u32 vbin_turn_pt;
-	u32 type;
+	u8 type;
 };
 
 static u32 percent(u32 numerator, u32 denominator)
@@ -1267,6 +1267,7 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
+	u32 val;
 
 	dev_info(svsb->dev, "%s: VDN74~30:0x%08x~0x%08x, DC:0x%08x\n",
 		 __func__, svs_readl_relaxed(svsp, VDESIGN74),
@@ -1276,8 +1277,8 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT01);
 
 	svsb->phase = SVSB_PHASE_INIT01;
-	svsb->dc_voffset_in = ~(svs_readl_relaxed(svsp, DCVALUES) &
-				GENMASK(15, 0)) + 1;
+	val = ~(svs_readl_relaxed(svsp, DCVALUES) & GENMASK(15, 0)) + 1;
+	svsb->dc_voffset_in = val & GENMASK(15, 0);
 	if (svsb->volt_flags & SVSB_INIT01_VOLT_IGNORE ||
 	    (svsb->dc_voffset_in & SVSB_DC_SIGNED_BIT &&
 	     svsb->volt_flags & SVSB_INIT01_VOLT_INC_ONLY))
-- 
2.42.0

