Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF5812883
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443294AbjLNGuy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 01:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjLNGuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:50:37 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D7F5;
        Wed, 13 Dec 2023 22:50:40 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8AB6F819D;
        Thu, 14 Dec 2023 14:50:33 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:33 +0800
Received: from ubuntu.mshome.net (113.72.145.168) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 14:50:31 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Marvin Lin" <milkfafa@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Ming Qian" <ming.qian@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v1 2/9] staging: media: starfive: camss: Add ISP controls
Date:   Wed, 13 Dec 2023 22:50:20 -0800
Message-ID: <20231214065027.28564-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.168]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ISP controls to config ISP parameter for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.h  |   8 +
 .../media/starfive/camss/stf-isp-hw-ops.c     | 527 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.c    | 299 +++++++++-
 .../staging/media/starfive/camss/stf-isp.h    | 154 +++++
 4 files changed, 987 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index e2b0cfb437bd..726aa38424d8 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -103,6 +103,14 @@ static inline void stf_isp_reg_set(struct stfcamss *stfcamss, u32 reg, u32 mask)
 		  stfcamss->isp_base + reg);
 }
 
+static inline void stf_isp_reg_fill_zero(struct stfcamss *stfcamss, u32 reg, u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++, reg += 4)
+		iowrite32(0, stfcamss->isp_base + reg);
+}
+
 static inline u32 stf_syscon_reg_read(struct stfcamss *stfcamss, u32 reg)
 {
 	return ioread32(stfcamss->syscon_base + reg);
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index c34631ff9422..c6295a14d509 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -10,6 +10,25 @@
 
 #include "stf-camss.h"
 
+static const struct stf_isp_module_info mod_info[] = {
+	{ ISP_REG_CSI_MODULE_CFG, 2 },
+	{ ISP_REG_CSI_MODULE_CFG, 4 },
+	{ ISP_REG_CSI_MODULE_CFG, 6 },
+	{ ISP_REG_CSI_MODULE_CFG, 7 },
+	{ ISP_REG_CSI_MODULE_CFG, 17 },
+	{ ISP_REG_ISP_CTRL_1, 1 },
+	{ ISP_REG_ISP_CTRL_1, 2 },
+	{ ISP_REG_ISP_CTRL_1, 3 },
+	{ ISP_REG_ISP_CTRL_1, 4 },
+	{ ISP_REG_ISP_CTRL_1, 5 },
+	{ ISP_REG_ISP_CTRL_1, 7 },
+	{ ISP_REG_ISP_CTRL_1, 8 },
+	{ ISP_REG_ISP_CTRL_1, 17 },
+	{ ISP_REG_ISP_CTRL_1, 19 },
+	{ ISP_REG_ISP_CTRL_1, 21 },
+	{ ISP_REG_ISP_CTRL_1, 22 },
+};
+
 static void stf_isp_config_obc(struct stfcamss *stfcamss)
 {
 	u32 reg_val, reg_add;
@@ -443,3 +462,511 @@ void stf_isp_stream_set(struct stf_isp_dev *isp_dev)
 	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSI_INPUT_EN_AND_STATUS,
 				CSI_EN_S, 10);
 }
+
+int isp_set_ctrl_wb(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_awb];
+	const struct jh7110_isp_wb_setting *setting =
+		(const struct jh7110_isp_wb_setting *)value;
+	const struct jh7110_isp_wb_gain *gains = &setting->gains;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_fill_zero(stfcamss, ISP_REG_AWB_X0_CFG_0, 16);
+
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S0_CFG_0,
+			  AWB_S_SYMBOL_H(gains->gain_r) | AWB_S_SYMBOL_L(gains->gain_r));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S0_CFG_1,
+			  AWB_S_SYMBOL_H(gains->gain_r) | AWB_S_SYMBOL_L(gains->gain_r));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S1_CFG_0,
+			  AWB_S_SYMBOL_H(gains->gain_g) | AWB_S_SYMBOL_L(gains->gain_g));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S1_CFG_1,
+			  AWB_S_SYMBOL_H(gains->gain_g) | AWB_S_SYMBOL_L(gains->gain_g));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S2_CFG_0,
+			  AWB_S_SYMBOL_H(gains->gain_g) | AWB_S_SYMBOL_L(gains->gain_g));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S2_CFG_1,
+			  AWB_S_SYMBOL_H(gains->gain_g) | AWB_S_SYMBOL_L(gains->gain_g));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S3_CFG_0,
+			  AWB_S_SYMBOL_H(gains->gain_b) | AWB_S_SYMBOL_L(gains->gain_b));
+	stf_isp_reg_write(stfcamss, ISP_REG_AWB_S3_CFG_1,
+			  AWB_S_SYMBOL_H(gains->gain_b) | AWB_S_SYMBOL_L(gains->gain_b));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_car(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_car];
+	const struct jh7110_isp_car_setting *setting =
+		(const struct jh7110_isp_car_setting *)value;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_ccm(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_ccm];
+	const struct jh7110_isp_ccm_setting *setting =
+		(const struct jh7110_isp_ccm_setting *)value;
+	const struct jh7110_isp_ccm_smlow *ccm = &setting->ccm_smlow;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_0, DNRM_F(6));
+	stf_isp_reg_fill_zero(stfcamss, ISP_REG_ICAMD_1, 11);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_12, ccm->ccm[0][0]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_13, ccm->ccm[0][1]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_14, ccm->ccm[0][2]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_15, ccm->ccm[1][0]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_16, ccm->ccm[1][1]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_17, ccm->ccm[1][2]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_18, ccm->ccm[2][0]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_19, ccm->ccm[2][1]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_20, ccm->ccm[2][2]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_21, ccm->offsets[0]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_22, ccm->offsets[1]);
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_23, ccm->offsets[2]);
+	stf_isp_reg_fill_zero(stfcamss, ISP_REG_ICAMD_24, 2);
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_cfa(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_cfa];
+	const struct jh7110_isp_cfa_setting *setting =
+		(const struct jh7110_isp_cfa_setting *)value;
+	const struct jh7110_isp_cfa_params *cfa = &setting->settings;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ICFAM,
+			  HV_W(cfa->hv_width) | CROSS_COV(cfa->cross_cov));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_ctc(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_ctc];
+	const struct jh7110_isp_ctc_setting *setting =
+		(const struct jh7110_isp_ctc_setting *)value;
+	const struct jh7110_isp_ctc_params *ctc = &setting->settings;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ICTC,
+			  MINGT(ctc->min_gt) | MAXGT(ctc->max_gt) |
+			  GF_MODE(ctc->saf_mode | ctc->daf_mode));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_dbc(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_dbc];
+	const struct jh7110_isp_dbc_setting *setting =
+		(const struct jh7110_isp_dbc_setting *)value;
+	const struct jh7110_isp_dbc_params *dbc = &setting->settings;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_IDBC,
+			  BADXT(dbc->bad_xt) | BADGT(dbc->bad_gt));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_dnyuv(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_dnyuv];
+	const struct jh7110_isp_dnyuv_setting *setting =
+		(const struct jh7110_isp_dnyuv_setting *)value;
+	const struct jh7110_isp_dnyuv_params *cfg = &setting->settings;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YSWR0,
+			  YUVSW0(cfg->y_sweight[0]) | YUVSW1(cfg->y_sweight[1]) |
+			  YUVSW2(cfg->y_sweight[2]) | YUVSW3(cfg->y_sweight[3]) |
+			  YUVSW4(cfg->y_sweight[4]) | YUVSW5(cfg->y_sweight[5]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YSWR1,
+			  YUVSW0(cfg->y_sweight[6]) | YUVSW1(cfg->y_sweight[7]) |
+			  YUVSW2(cfg->y_sweight[8]) | YUVSW3(cfg->y_sweight[9]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CSWR0,
+			  YUVSW0(cfg->uv_sweight[0]) | YUVSW1(cfg->uv_sweight[1]) |
+			  YUVSW2(cfg->uv_sweight[2]) | YUVSW3(cfg->uv_sweight[3]) |
+			  YUVSW4(cfg->uv_sweight[4]) | YUVSW5(cfg->uv_sweight[5]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CSWR1,
+			  YUVSW0(cfg->uv_sweight[6]) | YUVSW1(cfg->uv_sweight[7]) |
+			  YUVSW2(cfg->uv_sweight[8]) | YUVSW3(cfg->uv_sweight[9]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR0,
+			  CURVE_D_L(cfg->y_curve[0]) | CURVE_D_H(cfg->y_curve[1]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR1,
+			  CURVE_D_L(cfg->y_curve[2]) | CURVE_D_H(cfg->y_curve[3]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR2,
+			  CURVE_D_L(cfg->y_curve[4]) | CURVE_D_H(cfg->y_curve[5]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR0,
+			  CURVE_D_L(cfg->uv_curve[0]) | CURVE_D_H(cfg->uv_curve[1]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR1,
+			  CURVE_D_L(cfg->uv_curve[2]) | CURVE_D_H(cfg->uv_curve[3]));
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR2,
+			  CURVE_D_L(cfg->uv_curve[4]) | CURVE_D_H(cfg->uv_curve[5]));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_gmargb(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_gmargb];
+	const struct jh7110_isp_gmargb_setting *setting =
+		(const struct jh7110_isp_gmargb_setting *)value;
+	const struct jh7110_isp_gmargb_point *curve = setting->curve;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_addr = ISP_REG_GAMMA_VAL0;
+	u32 i;
+
+	for (i = 0; i < 15; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr,
+				  GAMMA_S_VAL(curve[i].sg_val) | GAMMA_VAL(curve[i].g_val));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_lccf(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_lccf];
+	const struct jh7110_isp_lccf_setting *setting =
+		(const struct jh7110_isp_lccf_setting *)value;
+	const struct jh7110_isp_lccf_circle *circle = &setting->circle;
+	const struct jh7110_isp_lccf_curve_param *r_param = &setting->r_param;
+	const struct jh7110_isp_lccf_curve_param *gr_param = &setting->gr_param;
+	const struct jh7110_isp_lccf_curve_param *gb_param = &setting->gb_param;
+	const struct jh7110_isp_lccf_curve_param *b_param = &setting->b_param;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_0,
+			  Y_DISTANCE(circle->center_y) | X_DISTANCE(circle->center_x));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_1,
+			  LCCF_MAX_DIS(circle->radius));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_2,
+			  LCCF_F1_PAR(r_param->f1) | LCCF_F2_PAR(r_param->f2));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_3,
+			  LCCF_F1_PAR(gr_param->f1) | LCCF_F2_PAR(gr_param->f2));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_4,
+			  LCCF_F1_PAR(gb_param->f1) | LCCF_F2_PAR(gb_param->f2));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_5,
+			  LCCF_F1_PAR(b_param->f1) | LCCF_F2_PAR(b_param->f2));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_obc(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_obc];
+	const struct jh7110_isp_blacklevel_setting *setting =
+		(const struct jh7110_isp_blacklevel_setting *)value;
+	const struct jh7110_isp_blacklevel_win_size *win_size = &setting->win_size;
+	const struct jh7110_isp_blacklevel_gain *gain = setting->gain;
+	const struct jh7110_isp_blacklevel_offset *offset = setting->offset;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_OBC_CFG,
+			  OBC_W_W(win_size->width) | OBC_W_H(win_size->height));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCG_CFG_0,
+			  GAIN_A_POINT(gain[0].tl_gain) | GAIN_B_POINT(gain[0].tr_gain) |
+			  GAIN_C_POINT(gain[0].bl_gain) | GAIN_D_POINT(gain[0].br_gain));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCG_CFG_1,
+			  GAIN_A_POINT(gain[1].tl_gain) | GAIN_B_POINT(gain[1].tr_gain) |
+			  GAIN_C_POINT(gain[1].bl_gain) | GAIN_D_POINT(gain[1].br_gain));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCG_CFG_2,
+			  GAIN_A_POINT(gain[2].tl_gain) | GAIN_B_POINT(gain[2].tr_gain) |
+			  GAIN_C_POINT(gain[2].bl_gain) | GAIN_D_POINT(gain[2].br_gain));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCG_CFG_3,
+			  GAIN_A_POINT(gain[3].tl_gain) | GAIN_B_POINT(gain[3].tr_gain) |
+			  GAIN_C_POINT(gain[3].bl_gain) | GAIN_D_POINT(gain[3].br_gain));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCO_CFG_0,
+			  OFFSET_A_POINT(offset[0].tl_offset) |
+			  OFFSET_B_POINT(offset[0].tr_offset) |
+			  OFFSET_C_POINT(offset[0].bl_offset) |
+			  OFFSET_D_POINT(offset[0].br_offset));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCO_CFG_1,
+			  OFFSET_A_POINT(offset[1].tl_offset) |
+			  OFFSET_B_POINT(offset[1].tr_offset) |
+			  OFFSET_C_POINT(offset[1].bl_offset) |
+			  OFFSET_D_POINT(offset[1].br_offset));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCO_CFG_2,
+			  OFFSET_A_POINT(offset[2].tl_offset) |
+			  OFFSET_B_POINT(offset[2].tr_offset) |
+			  OFFSET_C_POINT(offset[2].bl_offset) |
+			  OFFSET_D_POINT(offset[2].br_offset));
+	stf_isp_reg_write(stfcamss, ISP_REG_OBCO_CFG_3,
+			  OFFSET_A_POINT(offset[3].tl_offset) |
+			  OFFSET_B_POINT(offset[3].tr_offset) |
+			  OFFSET_C_POINT(offset[3].bl_offset) |
+			  OFFSET_D_POINT(offset[3].br_offset));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_oecf(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_oecf];
+	const struct jh7110_isp_oecf_setting *setting =
+		(const struct jh7110_isp_oecf_setting *)value;
+	const struct jh7110_isp_oecf_point *oecf = setting->r_curve;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_x_addr = ISP_REG_OECF_X0_CFG0;
+	u32 reg_y_addr = ISP_REG_OECF_Y0_CFG0;
+	u32 reg_s_addr = ISP_REG_OECF_S0_CFG0;
+	u32 i;
+
+	for (i = 0; i < 64; i += 2, reg_x_addr += 4, reg_y_addr += 4, reg_s_addr += 4) {
+		stf_isp_reg_write(stfcamss, reg_x_addr,
+				  OCEF_PAR_L(oecf[i].x) | OCEF_PAR_H(oecf[i + 1].x));
+		stf_isp_reg_write(stfcamss, reg_y_addr,
+				  OCEF_PAR_L(oecf[i].y) | OCEF_PAR_H(oecf[i + 1].y));
+		stf_isp_reg_write(stfcamss, reg_s_addr,
+				  OCEF_PAR_L(oecf[i].slope) | OCEF_PAR_H(oecf[i + 1].slope));
+	}
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_r2y(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_r2y];
+	const struct jh7110_isp_r2y_setting *setting =
+		(const struct jh7110_isp_r2y_setting *)value;
+	const struct jh7110_isp_r2y_matrix *matrix = &setting->matrix;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_addr = ISP_REG_R2Y_0;
+	u32 i;
+
+	for (i = 0; i < 9; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr, matrix->m[i]);
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_sat(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_sat];
+	const struct jh7110_isp_sat_setting *setting =
+		(const struct jh7110_isp_sat_setting *)value;
+	const struct jh7110_isp_sat_info *sat = &setting->sat_info;
+	const struct jh7110_isp_sat_hue_info *hue = &setting->hue_info;
+	const struct jh7110_isp_sat_curve *curve = &setting->curve;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_GAIN,
+			  CMAB(sat->gain_cmab) | CMAD(sat->gain_cmmd));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_THRESHOLD,
+			  CMB(sat->threshold_cmb) | CMD(sat->threshold_cmd));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_OFFSET,
+			  UOFF(sat->offset_u) | VOFF(sat->offset_v));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_SCALE, sat->offset_u);
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_HUE_F,
+			  COS(hue->cos) | SIN(hue->sin));
+	stf_isp_reg_write(stfcamss, ISP_REG_YADJ0,
+			  YIMIN(curve->yi_min) | YOIR(curve->yo_ir));
+	stf_isp_reg_write(stfcamss, ISP_REG_YADJ1,
+			  YOMIN(curve->yo_min) | YOMAX(curve->yo_max));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_shrp(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_shrp];
+	const struct jh7110_isp_sharp_setting *setting =
+		(const struct jh7110_isp_sharp_setting *)value;
+	const struct jh7110_isp_sharp_weight *weight = &setting->weight;
+	const struct jh7110_isp_sharp_strength *strength = &setting->strength;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_addr = ISP_REG_SHARPEN0;
+	u32 i;
+
+	for (i = 0; i < 4; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr,
+				  S_WEIGHT(weight->weight[i]) | S_DELTA(strength->diff[i]));
+
+	for (; i < 15; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr, S_WEIGHT(weight->weight[i]));
+
+	reg_addr = ISP_REG_SHARPEN_FS0;
+
+	for (i = 0; i < 3; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr,
+				  S_SLOPE(strength->s[i]) | S_FACTOR(strength->f[i]));
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SHARPEN_WN,
+			  WSUM(weight->recip_wei_sum) | NDIRF(setting->ndirf) |
+			  PDIRF(setting->pdirf));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_ycrv(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_ycrv];
+	const struct jh7110_isp_ycrv_setting *setting =
+		(const struct jh7110_isp_ycrv_setting *)value;
+	const struct jh7110_isp_ycrv_curve *curve = &setting->curve;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_addr = ISP_REG_YCURVE_0;
+	u32 i;
+
+	for (i = 0; i < 64; i++, reg_addr += 4)
+		stf_isp_reg_write(stfcamss, reg_addr, curve->y[i]);
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
+
+int isp_set_ctrl_sc(struct stf_isp_dev *isp_dev, const void *value)
+{
+	const struct stf_isp_module_info *reg_info = &mod_info[imi_sc];
+	const struct jh7110_isp_sc_setting *setting =
+		(const struct jh7110_isp_sc_setting *)value;
+	const struct jh7110_isp_sc_config *crop = &setting->crop_config;
+	const struct jh7110_isp_sc_af_config *af = &setting->af_config;
+	const struct jh7110_isp_sc_awb_config *awb = &setting->awb_config;
+	const struct jh7110_isp_sc_awb_ps *awb_ps = &awb->ws_ps_config;
+	const struct jh7110_isp_sc_awb_ws *awb_ws = &awb->ws_config;
+	const struct jh7110_isp_sc_awb_point *pts = awb->pts;
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+	u32 reg_addr0, reg_addr1;
+	u32 i;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SCD_CFG_1, AXI_ID(1));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_CFG_0,
+			  HSTART(crop->h_start) | VSTART(crop->v_start));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_CFG_1,
+			  SC_WIDTH(crop->sw_width) | SC_HEIGHT(crop->sw_height) |
+			  AWB_PS_GRB_BA(awb->awb_ps_grb_ba) | SEL_TYPE(awb->sel));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_DEC,
+			  SC_DEC_H_PERIOD(crop->hperiod) | SC_DEC_H_KEEP(crop->hkeep) |
+			  SC_DEC_V_PERIOD(crop->vperiod) | SC_DEC_V_KEEP(crop->vkeep));
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_PS_CFG_0,
+			  AWB_PS_RL(awb_ps->awb_ps_rl) | AWB_PS_RU(awb_ps->awb_ps_ru) |
+			  AWB_PS_GL(awb_ps->awb_ps_gl) | AWB_PS_GU(awb_ps->awb_ps_gu));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_PS_CFG_1,
+			  AWB_PS_BL(awb_ps->awb_ps_bl) | AWB_PS_BU(awb_ps->awb_ps_bu) |
+			  AWB_PS_YL(awb_ps->awb_ps_yl) | AWB_PS_YU(awb_ps->awb_ps_yu));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_PS_CFG_2,
+			  AWB_PS_GRL(awb_ps->awb_ps_grl) | AWB_PS_GRU(awb_ps->awb_ps_gru));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_PS_CFG_3,
+			  AWB_PS_GBL(awb_ps->awb_ps_gbl) | AWB_PS_GBU(awb_ps->awb_ps_gbu));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_PS_CFG_4,
+			  AWB_PS_GRBL(awb_ps->awb_ps_grbl) | AWB_PS_GRBU(awb_ps->awb_ps_grbu));
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SCD_CFG_1,
+			  AF_ES_HM(af->es_hor_mode) | AF_ES_SM(af->es_sum_mode) |
+			  AF_ES_HE(af->hor_en) | AF_ES_VE(af->ver_en) |
+			  AF_ES_VTHR(af->es_ver_thr) | AF_ES_HTHR(af->es_hor_thr));
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_CFG_0,
+			  AWB_WS_RL(awb_ws->awb_ws_rl) | AWB_WS_RU(awb_ws->awb_ws_ru) |
+			  AWB_WS_GRL(awb_ws->awb_ws_grl) | AWB_WS_GRU(awb_ws->awb_ws_gru));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_CFG_1,
+			  AWB_WS_GBL(awb_ws->awb_ws_gbl) | AWB_WS_GBU(awb_ws->awb_ws_gbu) |
+			  AWB_WS_BL(awb_ws->awb_ws_bl) | AWB_WS_BU(awb_ws->awb_ws_bu));
+
+	reg_addr0 = ISP_REG_SC_AWB_WS_CW0_CFG_0;
+	reg_addr1 = ISP_REG_SC_AWB_WS_CW0_CFG_1;
+
+	for (i = 0; i < 13; i++, reg_addr0 += 8, reg_addr1 += 8) {
+		stf_isp_reg_write(stfcamss, reg_addr0,
+				  AWB_WS_CW_W_0(awb->awb_cw[13 * i]) |
+				  AWB_WS_CW_W_1(awb->awb_cw[13 * i + 1]) |
+				  AWB_WS_CW_W_2(awb->awb_cw[13 * i + 2]) |
+				  AWB_WS_CW_W_3(awb->awb_cw[13 * i + 3]) |
+				  AWB_WS_CW_W_4(awb->awb_cw[13 * i + 4]) |
+				  AWB_WS_CW_W_5(awb->awb_cw[13 * i + 5]) |
+				  AWB_WS_CW_W_6(awb->awb_cw[13 * i + 6]) |
+				  AWB_WS_CW_W_7(awb->awb_cw[13 * i + 7]));
+		stf_isp_reg_write(stfcamss, reg_addr1,
+				  AWB_WS_CW_W_0(awb->awb_cw[13 * i + 8]) |
+				  AWB_WS_CW_W_1(awb->awb_cw[13 * i + 9]) |
+				  AWB_WS_CW_W_2(awb->awb_cw[13 * i + 10]) |
+				  AWB_WS_CW_W_3(awb->awb_cw[13 * i + 11]) |
+				  AWB_WS_CW_W_4(awb->awb_cw[13 * i + 12]));
+	}
+
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWV_CFG_0,
+			  AWB_WS_IW_V_0(pts[0].weight) | AWB_WS_IW_V_1(pts[1].weight) |
+			  AWB_WS_IW_V_2(pts[2].weight) | AWB_WS_IW_V_3(pts[3].weight) |
+			  AWB_WS_IW_V_4(pts[4].weight) | AWB_WS_IW_V_5(pts[5].weight) |
+			  AWB_WS_IW_V_6(pts[6].weight) | AWB_WS_IW_V_7(pts[7].weight));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWV_CFG_1,
+			  AWB_WS_IW_V_0(pts[8].weight) | AWB_WS_IW_V_1(pts[9].weight) |
+			  AWB_WS_IW_V_2(pts[10].weight) | AWB_WS_IW_V_3(pts[11].weight) |
+			  AWB_WS_IW_V_4(pts[12].weight) | AWB_WS_IW_V_5(pts[13].weight) |
+			  AWB_WS_IW_V_6(pts[14].weight) | AWB_WS_IW_V_7(pts[15].weight));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWS_CFG_0,
+			  AWB_WS_IW_S_0(2 * (pts[1].weight - pts[0].weight)) |
+			  AWB_WS_IW_S_1(2 * (pts[2].weight - pts[1].weight)) |
+			  AWB_WS_IW_S_2(2 * (pts[3].weight - pts[2].weight)) |
+			  AWB_WS_IW_S_3(2 * (pts[4].weight - pts[3].weight)));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWS_CFG_1,
+			  AWB_WS_IW_S_0(2 * (pts[5].weight - pts[4].weight)) |
+			  AWB_WS_IW_S_1(2 * (pts[6].weight - pts[5].weight)) |
+			  AWB_WS_IW_S_2(2 * (pts[7].weight - pts[6].weight)) |
+			  AWB_WS_IW_S_3(2 * (pts[8].weight - pts[7].weight)));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWS_CFG_2,
+			  AWB_WS_IW_S_0(2 * (pts[9].weight - pts[8].weight)) |
+			  AWB_WS_IW_S_1(2 * (pts[10].weight - pts[9].weight)) |
+			  AWB_WS_IW_S_2(2 * (pts[11].weight - pts[10].weight)) |
+			  AWB_WS_IW_S_3(2 * (pts[12].weight - pts[11].weight)));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_AWB_WS_IWS_CFG_3,
+			  AWB_WS_IW_S_0(2 * (pts[13].weight - pts[12].weight)) |
+			  AWB_WS_IW_S_1(2 * (pts[14].weight - pts[13].weight)) |
+			  AWB_WS_IW_S_2(2 * (pts[15].weight - pts[14].weight)) |
+			  AWB_WS_IW_S_3(2 * (pts[16].weight - pts[15].weight)));
+
+	stf_isp_reg_set_bit(stfcamss, reg_info->en_reg, 1 << reg_info->en_nbit,
+			    setting->enabled ? 1 << reg_info->en_nbit : 0);
+
+	return 0;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d50616ef351e..ac83f23842df 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -6,6 +6,7 @@
  *
  * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
  */
+#include <media/v4l2-event.h>
 #include <media/v4l2-rect.h>
 
 #include "stf-camss.h"
@@ -306,6 +307,11 @@ static int isp_init_formats(struct v4l2_subdev *sd,
 	return isp_set_format(sd, sd_state, &format);
 }
 
+static const struct v4l2_subdev_core_ops isp_core_ops = {
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
 static const struct v4l2_subdev_video_ops isp_video_ops = {
 	.s_stream = isp_set_stream,
 };
@@ -319,6 +325,7 @@ static const struct v4l2_subdev_pad_ops isp_pad_ops = {
 };
 
 static const struct v4l2_subdev_ops isp_v4l2_ops = {
+	.core = &isp_core_ops,
 	.video = &isp_video_ops,
 	.pad = &isp_pad_ops,
 };
@@ -331,6 +338,292 @@ static const struct media_entity_operations isp_media_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static int isp_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct stf_isp_dev *isp_dev =
+		container_of(ctrl->handler, struct stf_isp_dev, handler);
+	int ret = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_USER_JH7110_ISP_WB_SETTING:
+		ret = isp_set_ctrl_wb(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_CAR_SETTING:
+		ret = isp_set_ctrl_car(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_CCM_SETTING:
+		ret = isp_set_ctrl_ccm(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_CFA_SETTING:
+		ret = isp_set_ctrl_cfa(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_CTC_SETTING:
+		ret = isp_set_ctrl_ctc(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_DBC_SETTING:
+		ret = isp_set_ctrl_dbc(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_DNYUV_SETTING:
+		ret = isp_set_ctrl_dnyuv(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_GMARGB_SETTING:
+		ret = isp_set_ctrl_gmargb(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_LCCF_SETTING:
+		ret = isp_set_ctrl_lccf(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_OBC_SETTING:
+		ret = isp_set_ctrl_obc(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_OECF_SETTING:
+		ret = isp_set_ctrl_oecf(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_R2Y_SETTING:
+		ret = isp_set_ctrl_r2y(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_SAT_SETTING:
+		ret = isp_set_ctrl_sat(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_SHRP_SETTING:
+		ret = isp_set_ctrl_shrp(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_YCRV_SETTING:
+		ret = isp_set_ctrl_ycrv(isp_dev, ctrl->p_new.p_u8);
+		break;
+	case V4L2_CID_USER_JH7110_ISP_STAT_SETTING:
+		ret = isp_set_ctrl_sc(isp_dev, ctrl->p_new.p_u8);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops isp_ctrl_ops = {
+	.s_ctrl = isp_s_ctrl,
+};
+
+struct v4l2_ctrl_config isp_ctrl[] = {
+	[0] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "WB Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_WB_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_wb_setting),
+		.flags		= 0,
+	},
+	[1] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "Car Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_CAR_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_car_setting),
+		.flags		= 0,
+	},
+	[2] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "CCM Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_CCM_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_ccm_setting),
+		.flags		= 0,
+	},
+	[3] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "CFA Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_CFA_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_cfa_setting),
+		.flags		= 0,
+	},
+	[4] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "CTC Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_CTC_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_ctc_setting),
+		.flags		= 0,
+	},
+	[5] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "DBC Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_DBC_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_dbc_setting),
+		.flags		= 0,
+	},
+	[6] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "DNYUV Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_DNYUV_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_dnyuv_setting),
+		.flags		= 0,
+	},
+	[7] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "GMARGB Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_GMARGB_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_gmargb_setting),
+		.flags		= 0,
+	},
+	[8] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "LCCF Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_LCCF_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_lccf_setting),
+		.flags		= 0,
+	},
+	[9] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "OBC Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_OBC_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_blacklevel_setting),
+		.flags		= 0,
+	},
+	[10] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "OECF Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_OECF_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_oecf_setting),
+		.flags		= 0,
+	},
+	[11] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "R2Y Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_R2Y_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_r2y_setting),
+		.flags		= 0,
+	},
+	[12] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "SAT Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_SAT_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_sat_setting),
+		.flags		= 0,
+	},
+	[13] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "SHRP Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_SHRP_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_sharp_setting),
+		.flags		= 0,
+	},
+	[14] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "YCRV Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_YCRV_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_ycrv_setting),
+		.flags		= 0,
+	},
+	[15] = {
+		.ops		= &isp_ctrl_ops,
+		.type		= V4L2_CTRL_TYPE_U8,
+		.def		= 0,
+		.min		= 0x00,
+		.max		= 0xff,
+		.step		= 1,
+		.name		= "SC Setting",
+		.id		= V4L2_CID_USER_JH7110_ISP_STAT_SETTING,
+		.dims[0]	= sizeof(struct jh7110_isp_sc_setting),
+		.flags		= 0,
+	},
+};
+
+static int isp_init_controls(struct stf_isp_dev *isp_dev)
+{
+	struct v4l2_ctrl_handler *hdl = &isp_dev->handler;
+	int ret;
+	int i;
+
+	v4l2_ctrl_handler_init(hdl, ARRAY_SIZE(isp_ctrl));
+
+	for (i = 0; i < ARRAY_SIZE(isp_ctrl); i++)
+		v4l2_ctrl_new_custom(hdl, &isp_ctrl[i], NULL);
+
+	if (hdl->error) {
+		ret = hdl->error;
+		goto free_ctrls;
+	}
+
+	isp_dev->subdev.ctrl_handler = hdl;
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(hdl);
+	return ret;
+}
+
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 {
 	struct v4l2_subdev *sd = &isp_dev->subdev;
@@ -339,7 +632,7 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 
 	v4l2_subdev_init(sd, &isp_v4l2_ops);
 	sd->internal_ops = &isp_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 	snprintf(sd->name, ARRAY_SIZE(sd->name), "stf_isp");
 	v4l2_set_subdevdata(sd, isp_dev);
 
@@ -355,6 +648,10 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 		return ret;
 	}
 
+	ret = isp_init_controls(isp_dev);
+	if (ret)
+		goto err_entity_cleanup;
+
 	ret = v4l2_subdev_init_finalize(sd);
 	if (ret)
 		goto err_entity_cleanup;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 955cbb048363..1d98754964ce 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -10,6 +10,8 @@
 #ifndef STF_ISP_H
 #define STF_ISP_H
 
+#include <linux/jh7110-isp.h>
+#include <media/v4l2-ctrls.h>
 #include <media/v4l2-subdev.h>
 
 #include "stf-video.h"
@@ -107,6 +109,60 @@
 #define Y_COOR(y)				((y) << 16)
 #define X_COOR(x)				((x) << 0)
 
+#define ISP_REG_SCD_CFG_0			0x098
+
+#define ISP_REG_SCD_CFG_1			0x09c
+#define AXI_ID(n)				((n) << 24)
+
+#define ISP_REG_SC_CFG_0			0x0b8
+#define VSTART(n)				((n) << 16)
+#define HSTART(n)				((n) << 0)
+
+#define ISP_REG_SC_CFG_1			0x0bc
+#define ISP_SC_SEL_MASK				GENMASK(31, 30)
+#define SEL_TYPE(n)				((n) << 30)
+#define AWB_PS_GRB_BA(n)			((n) << 16)
+#define SC_HEIGHT(n)				((n) << 8)
+#define SC_WIDTH(n)				((n) << 0)
+
+#define ISP_REG_SC_AF				0x0c0
+#define AF_ES_HTHR(n)				((n) << 16)
+#define AF_ES_VTHR(n)				((n) << 8)
+#define AF_ES_VE(n)				((n) << 3)
+#define AF_ES_HE(n)				((n) << 2)
+#define AF_ES_SM(n)				((n) << 1)
+#define AF_ES_HM(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_0			0x0c4
+#define AWB_PS_GU(n)				((n) << 24)
+#define AWB_PS_GL(n)				((n) << 16)
+#define AWB_PS_RU(n)				((n) << 8)
+#define AWB_PS_RL(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_1			0x0c8
+#define AWB_PS_YU(n)				((n) << 24)
+#define AWB_PS_YL(n)				((n) << 16)
+#define AWB_PS_BU(n)				((n) << 8)
+#define AWB_PS_BL(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_2			0x0cc
+#define AWB_PS_GRU(n)				((n) << 16)
+#define AWB_PS_GRL(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_3			0x0d0
+#define AWB_PS_GBU(n)				((n) << 16)
+#define AWB_PS_GBL(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_PS_CFG_4			0x0d4
+#define AWB_PS_GRBU(n)				((n) << 16)
+#define AWB_PS_GRBL(n)				((n) << 0)
+
+#define ISP_REG_SC_DEC				0x0d8
+#define SC_DEC_V_KEEP(n)			((n) << 24)
+#define SC_DEC_V_PERIOD(n)			((n) << 16)
+#define SC_DEC_H_KEEP(n)			((n) << 8)
+#define SC_DEC_H_PERIOD(n)			((n) << 0)
+
 #define ISP_REG_LCCF_CFG_2			0x0e0
 #define ISP_REG_LCCF_CFG_3			0x0e4
 #define ISP_REG_LCCF_CFG_4			0x0e8
@@ -123,6 +179,8 @@
 #define ISP_REG_OECF_X0_CFG6			0x118
 #define ISP_REG_OECF_X0_CFG7			0x11c
 
+#define ISP_REG_OECF_Y0_CFG0			0x180
+
 #define ISP_REG_OECF_Y3_CFG0			0x1e0
 #define ISP_REG_OECF_Y3_CFG1			0x1e4
 #define ISP_REG_OECF_Y3_CFG2			0x1e8
@@ -187,6 +245,49 @@
 #define OFFSET_B_POINT(x)			((x) << 8)
 #define OFFSET_A_POINT(x)			((x) << 0)
 
+#define ISP_REG_SC_AWB_WS_CW0_CFG_0		0x4d0
+#define ISP_REG_SC_AWB_WS_CW0_CFG_1		0x4d4
+#define AWB_WS_CW_W_7(x)			((x) << 28)
+#define AWB_WS_CW_W_6(x)			((x) << 24)
+#define AWB_WS_CW_W_5(x)			((x) << 20)
+#define AWB_WS_CW_W_4(x)			((x) << 16)
+#define AWB_WS_CW_W_3(x)			((x) << 12)
+#define AWB_WS_CW_W_2(x)			((x) << 8)
+#define AWB_WS_CW_W_1(x)			((x) << 4)
+#define AWB_WS_CW_W_0(x)			((x) << 0)
+
+#define ISP_REG_SC_AWB_WS_IWV_CFG_0		0x538
+#define ISP_REG_SC_AWB_WS_IWV_CFG_1		0x53c
+#define AWB_WS_IW_V_7(x)			((x) << 28)
+#define AWB_WS_IW_V_6(x)			((x) << 24)
+#define AWB_WS_IW_V_5(x)			((x) << 20)
+#define AWB_WS_IW_V_4(x)			((x) << 16)
+#define AWB_WS_IW_V_3(x)			((x) << 12)
+#define AWB_WS_IW_V_2(x)			((x) << 8)
+#define AWB_WS_IW_V_1(x)			((x) << 4)
+#define AWB_WS_IW_V_0(x)			((x) << 0)
+
+#define ISP_REG_SC_AWB_WS_IWS_CFG_0		0x540
+#define ISP_REG_SC_AWB_WS_IWS_CFG_1		0x544
+#define ISP_REG_SC_AWB_WS_IWS_CFG_2		0x548
+#define ISP_REG_SC_AWB_WS_IWS_CFG_3		0x54c
+#define AWB_WS_IW_S_3(x)			((x) << 24)
+#define AWB_WS_IW_S_2(x)			((x) << 16)
+#define AWB_WS_IW_S_1(x)			((x) << 8)
+#define AWB_WS_IW_S_0(x)			((x) << 0)
+
+#define ISP_REG_SC_AWB_WS_CFG_0			0x5d0
+#define AWB_WS_GRU(n)				((n) << 24)
+#define AWB_WS_GRL(n)				((n) << 16)
+#define AWB_WS_RU(n)				((n) << 8)
+#define AWB_WS_RL(n)				((n) << 0)
+
+#define ISP_REG_SC_AWB_WS_CFG_1			0x5d4
+#define AWB_WS_BU(n)				((n) << 24)
+#define AWB_WS_BL(n)				((n) << 16)
+#define AWB_WS_GBU(n)				((n) << 8)
+#define AWB_WS_GBL(n)				((n) << 0)
+
 #define ISP_REG_ISP_CTRL_0			0xa00
 #define ISPC_LINE				BIT(27)
 #define ISPC_SC					BIT(26)
@@ -298,8 +399,19 @@
 #define CURVE_D_L(n)				((n) << 0)
 
 #define ISP_REG_ICAMD_0				0xc40
+#define ISP_REG_ICAMD_1				0xc44
 #define ISP_REG_ICAMD_12			0xc70
+#define ISP_REG_ICAMD_13			0xc74
+#define ISP_REG_ICAMD_14			0xc78
+#define ISP_REG_ICAMD_15			0xc7c
+#define ISP_REG_ICAMD_16			0xc80
+#define ISP_REG_ICAMD_17			0xc84
+#define ISP_REG_ICAMD_18			0xc88
+#define ISP_REG_ICAMD_19			0xc8c
 #define ISP_REG_ICAMD_20			0xc90
+#define ISP_REG_ICAMD_21			0xc94
+#define ISP_REG_ICAMD_22			0xc98
+#define ISP_REG_ICAMD_23			0xc9c
 #define ISP_REG_ICAMD_24			0xca0
 #define ISP_REG_ICAMD_25			0xca4
 #define DNRM_F(n)				((n) << 16)
@@ -396,6 +508,30 @@ enum stf_isp_pad_id {
 	STF_ISP_PAD_MAX
 };
 
+enum stf_isp_modules_index {
+	imi_obc = 0,
+	imi_oecf,
+	imi_lccf,
+	imi_awb,
+	imi_sc,
+	imi_cfa,
+	imi_car,
+	imi_ccm,
+	imi_gmargb,
+	imi_r2y,
+	imi_shrp,
+	imi_sat,
+	imi_dnyuv,
+	imi_ycrv,
+	imi_ctc,
+	imi_dbc,
+};
+
+struct stf_isp_module_info {
+	u32 en_reg;
+	u8 en_nbit;
+};
+
 struct stf_isp_format {
 	u32 code;
 	u8 bpp;
@@ -414,6 +550,7 @@ struct stf_isp_dev {
 	unsigned int nformats;
 	struct v4l2_subdev *source_subdev;
 	const struct stf_isp_format *current_fmt;
+	struct v4l2_ctrl_handler handler;
 };
 
 int stf_isp_reset(struct stf_isp_dev *isp_dev);
@@ -425,4 +562,21 @@ int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
+int isp_set_ctrl_wb(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_car(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_ccm(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_cfa(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_ctc(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_dbc(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_dnyuv(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_gmargb(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_lccf(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_obc(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_oecf(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_r2y(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_sat(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_shrp(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_ycrv(struct stf_isp_dev *isp_dev, const void *value);
+int isp_set_ctrl_sc(struct stf_isp_dev *isp_dev, const void *value);
+
 #endif /* STF_ISP_H */
-- 
2.25.1

