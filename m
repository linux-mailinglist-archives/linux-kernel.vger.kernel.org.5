Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C017F2C64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjKUL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjKUL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0110E5;
        Tue, 21 Nov 2023 03:56:44 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57F686607314;
        Tue, 21 Nov 2023 11:56:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567803;
        bh=Ugc04MbnUnt7uzZ2TQCUP0pKACMxidFV1p9AUF2t0WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oupFyi+dkVp3wZPbsyOa6kNYGMQKF22jHyHa2CWm5XkIUaNDHrD0Y11bwOUSupE8C
         bE4nAWLsQkYntF1emkKPXejuYjs4DOVAI7cTQIGOf8SHK7u68fLXsryzI9UzOY13Hc
         85qWFkyFUA4kPYiha8KnqviWMbcgImTOE17HIhXfL694BEhXrdfym53f43IzBiCEPm
         h0K0kkR7lVEESu46CFCt49aL1F8AUwR1TFlABwNbBcWyIKscokh4aYL0qlUZFDGtHY
         YHLnfLBmemuh5ldvIp/GmZxLJ7OJoC38y8PKU6RyyVw9y51ucXTBx4vKRdSlBZvYi5
         1HKIY1kh6Y0Tg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 11/20] soc: mediatek: mtk-svs: Drop supplementary svs per-bank pointer
Date:   Tue, 21 Nov 2023 12:56:15 +0100
Message-ID: <20231121115624.56855-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
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

Drop the "pbank" pointer from struct svs_bank: this was used to simply
pass a pointer to the SVS bank that the flow was working on.
That for instance needs more locking, and it's avoidable by adding one
more parameter to functions working on specific banks, either a bank
index number, or passing the svs_bank pointer directly from the caller.

Even if the locking can now be reduced, for now, it was still left in
place for the sake of making sure to not introduce any stability and/or
reliability regression.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 87 ++++++++++++++++------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 517a27c58888..e7df3a577b4c 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -372,7 +372,6 @@ struct svs_fusemap {
  * @base: svs platform register base
  * @dev: svs platform device
  * @main_clk: main clock for svs bank
- * @pbank: svs bank pointer needing to be protected by spin_lock section
  * @banks: svs banks that svs platform supports
  * @rst: svs platform reset control
  * @efuse_max: total number of svs efuse
@@ -387,7 +386,6 @@ struct svs_platform {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *main_clk;
-	struct svs_bank *pbank;
 	struct svs_bank *banks;
 	struct reset_control *rst;
 	size_t efuse_max;
@@ -483,8 +481,8 @@ struct svs_bank {
 	struct regulator *buck;
 	struct thermal_zone_device *tzd;
 	struct mutex lock;	/* lock to protect voltage update process */
-	void (*set_freq_pct)(struct svs_platform *svsp);
-	void (*get_volts)(struct svs_platform *svsp);
+	void (*set_freq_pct)(struct svs_platform *svsp, struct svs_bank *svsb);
+	void (*get_volts)(struct svs_platform *svsp, struct svs_bank *svsb);
 	char *name;
 	char *buck_name;
 	char *tzone_name;
@@ -555,10 +553,8 @@ static void svs_writel_relaxed(struct svs_platform *svsp, u32 val,
 	writel_relaxed(val, svsp->base + svsp->regs[rg_i]);
 }
 
-static void svs_switch_bank(struct svs_platform *svsp)
+static void svs_switch_bank(struct svs_platform *svsp, struct svs_bank *svsb)
 {
-	struct svs_bank *svsb = svsp->pbank;
-
 	svs_writel_relaxed(svsp, svsb->core_sel, CORESEL);
 }
 
@@ -693,8 +689,7 @@ static void svs_bank_disable_and_restore_default_volts(struct svs_platform *svsp
 		return;
 
 	spin_lock_irqsave(&svs_lock, flags);
-	svsp->pbank = svsb;
-	svs_switch_bank(svsp);
+	svs_switch_bank(svsp, svsb);
 	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
 	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
 	spin_unlock_irqrestore(&svs_lock, flags);
@@ -926,9 +921,8 @@ static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
 	return DIV_ROUND_UP(vx, 100);
 }
 
-static void svs_get_bank_volts_v3(struct svs_platform *svsp)
+static void svs_get_bank_volts_v3(struct svs_platform *svsp, struct svs_bank *svsb)
 {
-	struct svs_bank *svsb = svsp->pbank;
 	u32 i, j, *vop, vop74, vop30, turn_pt = svsb->turn_pt;
 	u32 b_sft, shift_byte = 0, opp_start = 0, opp_stop = 0;
 	u32 middle_index = (svsb->opp_count / 2);
@@ -1041,9 +1035,8 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 	}
 }
 
-static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
+static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp, struct svs_bank *svsb)
 {
-	struct svs_bank *svsb = svsp->pbank;
 	u32 i, j, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
 	u32 b_sft, shift_byte = 0, turn_pt;
 	u32 middle_index = (svsb->opp_count / 2);
@@ -1124,9 +1117,8 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 	svs_writel_relaxed(svsp, freq_pct30, FREQPCT30);
 }
 
-static void svs_get_bank_volts_v2(struct svs_platform *svsp)
+static void svs_get_bank_volts_v2(struct svs_platform *svsp, struct svs_bank *svsb)
 {
-	struct svs_bank *svsb = svsp->pbank;
 	u32 temp, i;
 
 	temp = svs_readl_relaxed(svsp, VOP74);
@@ -1181,9 +1173,8 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 	}
 }
 
-static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
+static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp, struct svs_bank *svsb)
 {
-	struct svs_bank *svsb = svsp->pbank;
 	u32 freqpct74_val, freqpct30_val;
 
 	freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
@@ -1201,12 +1192,13 @@ static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
 }
 
 static void svs_set_bank_phase(struct svs_platform *svsp,
+			       unsigned int bank_idx,
 			       enum svsb_phase target_phase)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 	u32 des_char, temp_char, det_char, limit_vals, init2vals, ts_calcs;
 
-	svs_switch_bank(svsp);
+	svs_switch_bank(svsp, svsb);
 
 	des_char = FIELD_PREP(SVSB_DESCHAR_FLD_BDES, svsb->bdes) |
 		   FIELD_PREP(SVSB_DESCHAR_FLD_MDES, svsb->mdes);
@@ -1225,7 +1217,7 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 	svs_writel_relaxed(svsp, svsb->age_config, AGECONFIG);
 	svs_writel_relaxed(svsp, SVSB_RUNCONFIG_DEFAULT, RUNCONFIG);
 
-	svsb->set_freq_pct(svsp);
+	svsb->set_freq_pct(svsp, svsb);
 
 	limit_vals = FIELD_PREP(SVSB_LIMITVALS_FLD_DTLO, SVSB_VAL_DTLO) |
 		     FIELD_PREP(SVSB_LIMITVALS_FLD_DTHI, SVSB_VAL_DTHI) |
@@ -1267,18 +1259,20 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 }
 
 static inline void svs_save_bank_register_data(struct svs_platform *svsp,
+					       unsigned short bank_idx,
 					       enum svsb_phase phase)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 	enum svs_reg_index rg_i;
 
 	for (rg_i = DESCHAR; rg_i < SVS_REG_MAX; rg_i++)
 		svsb->reg_data[phase][rg_i] = svs_readl_relaxed(svsp, rg_i);
 }
 
-static inline void svs_error_isr_handler(struct svs_platform *svsp)
+static inline void svs_error_isr_handler(struct svs_platform *svsp,
+					 unsigned short bank_idx)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 
 	dev_err(svsb->dev, "%s: CORESEL = 0x%08x\n",
 		__func__, svs_readl_relaxed(svsp, CORESEL));
@@ -1290,16 +1284,17 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 		svs_readl_relaxed(svsp, SMSTATE1));
 	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
 
-	svs_save_bank_register_data(svsp, SVSB_PHASE_ERROR);
+	svs_save_bank_register_data(svsp, bank_idx, SVSB_PHASE_ERROR);
 
 	svsb->phase = SVSB_PHASE_ERROR;
 	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
 	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
 }
 
-static inline void svs_init01_isr_handler(struct svs_platform *svsp)
+static inline void svs_init01_isr_handler(struct svs_platform *svsp,
+					  unsigned short bank_idx)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 	u32 val;
 
 	dev_info(svsb->dev, "%s: VDN74~30:0x%08x~0x%08x, DC:0x%08x\n",
@@ -1307,7 +1302,7 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 		 svs_readl_relaxed(svsp, VDESIGN30),
 		 svs_readl_relaxed(svsp, DCVALUES));
 
-	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT01);
+	svs_save_bank_register_data(svsp, bank_idx, SVSB_PHASE_INIT01);
 
 	svsb->phase = SVSB_PHASE_INIT01;
 	val = ~(svs_readl_relaxed(svsp, DCVALUES) & GENMASK(15, 0)) + 1;
@@ -1325,32 +1320,34 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 	svsb->core_sel &= ~SVSB_DET_CLK_EN;
 }
 
-static inline void svs_init02_isr_handler(struct svs_platform *svsp)
+static inline void svs_init02_isr_handler(struct svs_platform *svsp,
+					  unsigned short bank_idx)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 
 	dev_info(svsb->dev, "%s: VOP74~30:0x%08x~0x%08x, DC:0x%08x\n",
 		 __func__, svs_readl_relaxed(svsp, VOP74),
 		 svs_readl_relaxed(svsp, VOP30),
 		 svs_readl_relaxed(svsp, DCVALUES));
 
-	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT02);
+	svs_save_bank_register_data(svsp, bank_idx, SVSB_PHASE_INIT02);
 
 	svsb->phase = SVSB_PHASE_INIT02;
-	svsb->get_volts(svsp);
+	svsb->get_volts(svsp, svsb);
 
 	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
 	svs_writel_relaxed(svsp, SVSB_INTSTS_F0_COMPLETE, INTSTS);
 }
 
-static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
+static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp,
+					    unsigned short bank_idx)
 {
-	struct svs_bank *svsb = svsp->pbank;
+	struct svs_bank *svsb = &svsp->banks[bank_idx];
 
-	svs_save_bank_register_data(svsp, SVSB_PHASE_MON);
+	svs_save_bank_register_data(svsp, bank_idx, SVSB_PHASE_MON);
 
 	svsb->phase = SVSB_PHASE_MON;
-	svsb->get_volts(svsp);
+	svsb->get_volts(svsp, svsb);
 
 	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
 	svs_writel_relaxed(svsp, SVSB_INTSTS_FLD_MONVOP, INTSTS);
@@ -1368,7 +1365,6 @@ static irqreturn_t svs_isr(int irq, void *data)
 		WARN(!svsb, "%s: svsb(%s) is null", __func__, svsb->name);
 
 		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
 
 		/* Find out which svs bank fires interrupt */
 		if (svsb->int_st & svs_readl_relaxed(svsp, INTST)) {
@@ -1376,20 +1372,20 @@ static irqreturn_t svs_isr(int irq, void *data)
 			continue;
 		}
 
-		svs_switch_bank(svsp);
+		svs_switch_bank(svsp, svsb);
 		int_sts = svs_readl_relaxed(svsp, INTSTS);
 		svs_en = svs_readl_relaxed(svsp, SVSEN);
 
 		if (int_sts == SVSB_INTSTS_F0_COMPLETE &&
 		    svs_en == SVSB_PTPEN_INIT01)
-			svs_init01_isr_handler(svsp);
+			svs_init01_isr_handler(svsp, idx);
 		else if (int_sts == SVSB_INTSTS_F0_COMPLETE &&
 			 svs_en == SVSB_PTPEN_INIT02)
-			svs_init02_isr_handler(svsp);
+			svs_init02_isr_handler(svsp, idx);
 		else if (int_sts & SVSB_INTSTS_FLD_MONVOP)
-			svs_mon_mode_isr_handler(svsp);
+			svs_mon_mode_isr_handler(svsp, idx);
 		else
-			svs_error_isr_handler(svsp);
+			svs_error_isr_handler(svsp, idx);
 
 		spin_unlock_irqrestore(&svs_lock, flags);
 		break;
@@ -1518,8 +1514,7 @@ static int svs_init01(struct svs_platform *svsp)
 		}
 
 		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
-		svs_set_bank_phase(svsp, SVSB_PHASE_INIT01);
+		svs_set_bank_phase(svsp, idx, SVSB_PHASE_INIT01);
 		spin_unlock_irqrestore(&svs_lock, flags);
 
 		time_left = wait_for_completion_timeout(&svsb->init_completion,
@@ -1588,8 +1583,7 @@ static int svs_init02(struct svs_platform *svsp)
 
 		reinit_completion(&svsb->init_completion);
 		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
-		svs_set_bank_phase(svsp, SVSB_PHASE_INIT02);
+		svs_set_bank_phase(svsp, idx, SVSB_PHASE_INIT02);
 		spin_unlock_irqrestore(&svs_lock, flags);
 
 		time_left = wait_for_completion_timeout(&svsb->init_completion,
@@ -1645,8 +1639,7 @@ static void svs_mon_mode(struct svs_platform *svsp)
 			continue;
 
 		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
-		svs_set_bank_phase(svsp, SVSB_PHASE_MON);
+		svs_set_bank_phase(svsp, idx, SVSB_PHASE_MON);
 		spin_unlock_irqrestore(&svs_lock, flags);
 	}
 }
-- 
2.42.0

