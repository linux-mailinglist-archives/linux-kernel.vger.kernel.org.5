Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CBE7E4D08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjKGXYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbjKGXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:24:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1201709;
        Tue,  7 Nov 2023 15:23:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A14AC433C7;
        Tue,  7 Nov 2023 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399422;
        bh=xSKDbMjZxWCuofpDuLk9rbV6CGlLNun1ecOTlgQ0OZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpknelIGKQkiY8Z6wkIuSoUK5fFLb96VfznqwCOyrff37aEdZhY0SJb+iGUHvvFFB
         cCJn9sXtVIbH800dx7SpyNgQR5w5cj8vNASEowhkoZfpcrHvSWzLceWfUqZzZszoxm
         pIiWy006eIsV1r2xfihGmzpyqCB3smyaYl8FYU9ryOWCIeZZeGiMj+wYFkgtNUoiXU
         /cPXVwt7y26hs0Rrz5Mfnlr3/Fe0tM+mU//thUGcjnHw5fOxrprzYze6QHTc6LXqVS
         A3YKB6Hz8apCMkJy378K5ReH8QKrswUsuO5yNh5aNghRkW/XLvC3W2rOeylzVTAgg9
         g9Pk4WLZagDtg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 06/18] phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs
Date:   Tue,  7 Nov 2023 18:23:01 -0500
Message-ID: <20231107232330.3776001-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232330.3776001-1-sashal@kernel.org>
References: <20231107232330.3776001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 99a517a582fc1272d1d3cf3b9e671a14d7db77b8 ]

The vendor kernel zeroes out all tuning data outside the init sequence
as part of initialization. Follow suit to avoid UB.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230830-topic-eusb2_override-v2-3-7d8c893d93f6@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 58 ++++++++++++++-----
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index b20b805414a2a..6777532dd4dc9 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -25,9 +25,18 @@
 #define EUSB2_FORCE_VAL_5		0xeD
 #define V_CLK_19P2M_EN			BIT(6)
 
+#define EUSB2_TUNE_USB2_CROSSOVER	0x50
 #define EUSB2_TUNE_IUSB2		0x51
+#define EUSB2_TUNE_RES_FSDIF		0x52
+#define EUSB2_TUNE_HSDISC		0x53
 #define EUSB2_TUNE_SQUELCH_U		0x54
+#define EUSB2_TUNE_USB2_SLEW		0x55
+#define EUSB2_TUNE_USB2_EQU		0x56
 #define EUSB2_TUNE_USB2_PREEM		0x57
+#define EUSB2_TUNE_USB2_HS_COMP_CUR	0x58
+#define EUSB2_TUNE_EUSB_SLEW		0x59
+#define EUSB2_TUNE_EUSB_EQU		0x5A
+#define EUSB2_TUNE_EUSB_HS_COMP_CUR	0x5B
 
 #define QCOM_EUSB2_REPEATER_INIT_CFG(r, v)	\
 	{					\
@@ -36,9 +45,18 @@
 	}
 
 enum reg_fields {
+	F_TUNE_EUSB_HS_COMP_CUR,
+	F_TUNE_EUSB_EQU,
+	F_TUNE_EUSB_SLEW,
+	F_TUNE_USB2_HS_COMP_CUR,
 	F_TUNE_USB2_PREEM,
+	F_TUNE_USB2_EQU,
+	F_TUNE_USB2_SLEW,
 	F_TUNE_SQUELCH_U,
+	F_TUNE_HSDISC,
+	F_TUNE_RES_FSDIF,
 	F_TUNE_IUSB2,
+	F_TUNE_USB2_CROSSOVER,
 	F_NUM_TUNE_FIELDS,
 
 	F_FORCE_VAL_5 = F_NUM_TUNE_FIELDS,
@@ -51,9 +69,18 @@ enum reg_fields {
 };
 
 static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
+	[F_TUNE_EUSB_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_EUSB_HS_COMP_CUR, 0, 1),
+	[F_TUNE_EUSB_EQU] = REG_FIELD(EUSB2_TUNE_EUSB_EQU, 0, 1),
+	[F_TUNE_EUSB_SLEW] = REG_FIELD(EUSB2_TUNE_EUSB_SLEW, 0, 1),
+	[F_TUNE_USB2_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_USB2_HS_COMP_CUR, 0, 1),
 	[F_TUNE_USB2_PREEM] = REG_FIELD(EUSB2_TUNE_USB2_PREEM, 0, 2),
+	[F_TUNE_USB2_EQU] = REG_FIELD(EUSB2_TUNE_USB2_EQU, 0, 1),
+	[F_TUNE_USB2_SLEW] = REG_FIELD(EUSB2_TUNE_USB2_SLEW, 0, 1),
 	[F_TUNE_SQUELCH_U] = REG_FIELD(EUSB2_TUNE_SQUELCH_U, 0, 2),
+	[F_TUNE_HSDISC] = REG_FIELD(EUSB2_TUNE_HSDISC, 0, 2),
+	[F_TUNE_RES_FSDIF] = REG_FIELD(EUSB2_TUNE_RES_FSDIF, 0, 2),
 	[F_TUNE_IUSB2] = REG_FIELD(EUSB2_TUNE_IUSB2, 0, 3),
+	[F_TUNE_USB2_CROSSOVER] = REG_FIELD(EUSB2_TUNE_USB2_CROSSOVER, 0, 2),
 
 	[F_FORCE_VAL_5] = REG_FIELD(EUSB2_FORCE_VAL_5, 0, 7),
 	[F_FORCE_EN_5] = REG_FIELD(EUSB2_FORCE_EN_5, 0, 7),
@@ -63,13 +90,8 @@ static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
 	[F_RPTR_STATUS] = REG_FIELD(EUSB2_RPTR_STATUS, 0, 7),
 };
 
-struct eusb2_repeater_init_tbl {
-	unsigned int reg;
-	unsigned int val;
-};
-
 struct eusb2_repeater_cfg {
-	const struct eusb2_repeater_init_tbl *init_tbl;
+	const u32 *init_tbl;
 	int init_tbl_num;
 	const char * const *vreg_list;
 	int num_vregs;
@@ -88,10 +110,10 @@ static const char * const pm8550b_vreg_l[] = {
 	"vdd18", "vdd3",
 };
 
-static const struct eusb2_repeater_init_tbl pm8550b_init_tbl[] = {
-	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_IUSB2, 0x8),
-	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_SQUELCH_U, 0x3),
-	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_USB2_PREEM, 0x5),
+static const u32 pm8550b_init_tbl[F_NUM_TUNE_FIELDS] = {
+	[F_TUNE_IUSB2] = 0x8,
+	[F_TUNE_SQUELCH_U] = 0x3,
+	[F_TUNE_USB2_PREEM] = 0x5,
 };
 
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
@@ -119,8 +141,9 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 
 static int eusb2_repeater_init(struct phy *phy)
 {
+	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
-	const struct eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
+	const u32 *init_tbl = rptr->cfg->init_tbl;
 	u32 val;
 	int ret;
 	int i;
@@ -131,9 +154,16 @@ static int eusb2_repeater_init(struct phy *phy)
 
 	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
 
-	for (i = 0; i < rptr->cfg->init_tbl_num; i++)
-		regmap_field_update_bits(rptr->regs[init_tbl[i].reg],
-					 init_tbl[i].val, init_tbl[i].val);
+	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
+		if (init_tbl[i]) {
+			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
+		} else {
+			/* Write 0 if there's no value set */
+			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
+
+			regmap_field_update_bits(rptr->regs[i], mask, 0);
+		}
+	}
 
 	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
 					     val, val & RPTR_OK, 10, 5);
-- 
2.42.0

