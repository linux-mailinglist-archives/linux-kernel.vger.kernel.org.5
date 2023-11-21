Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340B7F2DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjKUMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjKUMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90074D49;
        Tue, 21 Nov 2023 04:50:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 896F06607324;
        Tue, 21 Nov 2023 12:50:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571054;
        bh=bxh5Gx+Fb0RV/Yt4vunB8wvLU6bWVnKSjAMj8DBawUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1G5PHS55UWSBxIpMg2wN7v/VDKnw26FRDP6qccyw8ydlv484574Z5i49D0swYLZy
         CzG116ZqowhHxMySIFa57KSls9jfXSnuXEmO7VicWA8+DhLe1ROL+4GSinNAyh2Dmd
         3SSFw+8+wk6RfTrAduNu7t+jNSiOdGMOv161+Wr6EzZki14fJHpXU01TDAJozbLZtZ
         LldiWwg+KfqM7Clq5BcFQAPM1nIiFB9FBH861PUYXz1i8/AFfDeK3TAnFdrOT1Pab5
         Mou1iEFrQnrSobBm7nK8Vd9o0eQscZCPM0RFA9Rfw+RY//zPtrELNPjudSdxh3nv+f
         W3GWYtrjQcWIA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 03/20] soc: mediatek: mtk-svs: Convert sw_id and type to enumerations
Date:   Tue, 21 Nov 2023 13:50:27 +0100
Message-ID: <20231121125044.78642-4-angelogioacchino.delregno@collabora.com>
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

The sw_id and type specifiers currently are defined as BIT(x) for
unknown reasons: nothing in this code makes any AND/OR check for
those, and that would never happen anyway because both sw_id and
type are exclusive, as in:
 - There will never be a bank that is for both CPU and GPU, or
   for CPU and CCI together;
 - A bank cannot be contemporarily of one-line and two-line type,
   as much as it cannot contemporarily have both HIGH and LOW roles

Change those definitions to enumerations and also add some kerneldoc
to better describe what they are for and what they indicate.

While at it, also change the names adding _SWID or _TYPE to increase
human readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 192 ++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 86 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 416e9b313c0a..ddbb9ba3e47d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -32,16 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
 
-/* svs bank 1-line software id */
-#define SVSB_CPU_LITTLE			BIT(0)
-#define SVSB_CPU_BIG			BIT(1)
-#define SVSB_CCI			BIT(2)
-#define SVSB_GPU			BIT(3)
-
-/* svs bank 2-line type */
-#define SVSB_LOW			BIT(8)
-#define SVSB_HIGH			BIT(9)
-
 /* svs bank mode support */
 #define SVSB_MODE_ALL_DISABLE		0
 #define SVSB_MODE_INIT01		BIT(1)
@@ -174,6 +164,36 @@ static DEFINE_SPINLOCK(svs_lock);
 #define svs_dentry_data(name)	{__stringify(name), &svs_##name##_debug_fops}
 #endif
 
+/**
+ * enum svsb_sw_id - SVS Bank Software ID
+ * @SVSB_SWID_CPU_LITTLE: CPU little cluster Bank
+ * @SVSB_SWID_CPU_BIG:    CPU big cluster Bank
+ * @SVSB_SWID_CCI:        Cache Coherent Interconnect Bank
+ * @SVSB_SWID_GPU:        GPU Bank
+ * @SVSB_SWID_MAX:        Total number of Banks
+ */
+enum svsb_sw_id {
+	SVSB_SWID_CPU_LITTLE,
+	SVSB_SWID_CPU_BIG,
+	SVSB_SWID_CCI,
+	SVSB_SWID_GPU,
+	SVSB_SWID_MAX
+};
+
+/**
+ * enum svsb_type - SVS Bank 2-line: Type and Role
+ * @SVSB_TYPE_NONE: One-line type Bank - Global role
+ * @SVSB_TYPE_LOW:  Two-line type Bank - Low bank role
+ * @SVSB_TYPE_HIGH: Two-line type Bank - High bank role
+ * @SVSB_TYPE_MAX:  Total number of bank types
+ */
+enum svsb_type {
+	SVSB_TYPE_NONE,
+	SVSB_TYPE_LOW,
+	SVSB_TYPE_HIGH,
+	SVSB_TYPE_MAX
+};
+
 /**
  * enum svsb_phase - svs bank phase enumeration
  * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
@@ -549,10 +569,10 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 	 * 2-line bank updates its corresponding opp volts.
 	 * 1-line bank updates all opp volts.
 	 */
-	if (svsb->type == SVSB_HIGH) {
+	if (svsb->type == SVSB_TYPE_HIGH) {
 		opp_start = 0;
 		opp_stop = svsb->turn_pt;
-	} else if (svsb->type == SVSB_LOW) {
+	} else if (svsb->type == SVSB_TYPE_LOW) {
 		opp_start = svsb->turn_pt;
 		opp_stop = svsb->opp_count;
 	} else {
@@ -576,8 +596,8 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 			temp_voffset += svsb->tzone_ltemp_voffset;
 
 		/* 2-line bank update all opp volts when running mon mode */
-		if (svsb->phase == SVSB_PHASE_MON && (svsb->type == SVSB_HIGH ||
-						      svsb->type == SVSB_LOW)) {
+		if (svsb->phase == SVSB_PHASE_MON && (svsb->type == SVSB_TYPE_HIGH ||
+						      svsb->type == SVSB_TYPE_LOW)) {
 			opp_start = 0;
 			opp_stop = svsb->opp_count;
 		}
@@ -881,7 +901,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 
 	/* Target is to set svsb->volt[] by algorithm */
 	if (turn_pt < middle_index) {
-		if (svsb->type == SVSB_HIGH) {
+		if (svsb->type == SVSB_TYPE_HIGH) {
 			/* volt[0] ~ volt[turn_pt - 1] */
 			for (i = 0; i < turn_pt; i++) {
 				b_sft = BITS8 * (shift_byte % REG_BYTES);
@@ -890,7 +910,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 				svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
 				shift_byte++;
 			}
-		} else if (svsb->type == SVSB_LOW) {
+		} else if (svsb->type == SVSB_TYPE_LOW) {
 			/* volt[turn_pt] + volt[j] ~ volt[opp_count - 1] */
 			j = svsb->opp_count - 7;
 			svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
@@ -912,7 +932,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 							    svsb->freq_pct[i]);
 		}
 	} else {
-		if (svsb->type == SVSB_HIGH) {
+		if (svsb->type == SVSB_TYPE_HIGH) {
 			/* volt[0] + volt[j] ~ volt[turn_pt - 1] */
 			j = turn_pt - 7;
 			svsb->volt[0] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
@@ -932,7 +952,7 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 							    svsb->volt[0],
 							    svsb->volt[j],
 							    svsb->freq_pct[i]);
-		} else if (svsb->type == SVSB_LOW) {
+		} else if (svsb->type == SVSB_TYPE_LOW) {
 			/* volt[turn_pt] ~ volt[opp_count - 1] */
 			for (i = turn_pt; i < svsb->opp_count; i++) {
 				b_sft = BITS8 * (shift_byte % REG_BYTES);
@@ -944,10 +964,10 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 		}
 	}
 
-	if (svsb->type == SVSB_HIGH) {
+	if (svsb->type == SVSB_TYPE_HIGH) {
 		opp_start = 0;
 		opp_stop = svsb->turn_pt;
-	} else if (svsb->type == SVSB_LOW) {
+	} else if (svsb->type == SVSB_TYPE_LOW) {
 		opp_start = svsb->turn_pt;
 		opp_stop = svsb->opp_count;
 	}
@@ -998,11 +1018,11 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 
 	/* Target is to fill out freq_pct74 / freq_pct30 by algorithm */
 	if (turn_pt < middle_index) {
-		if (svsb->type == SVSB_HIGH) {
+		if (svsb->type == SVSB_TYPE_HIGH) {
 			/*
 			 * If we don't handle this situation,
-			 * SVSB_HIGH's FREQPCT74 / FREQPCT30 would keep "0"
-			 * and this leads SVSB_LOW to work abnormally.
+			 * SVSB_TYPE_HIGH's FREQPCT74 / FREQPCT30 would keep "0"
+			 * and this leads SVSB_TYPE_LOW to work abnormally.
 			 */
 			if (turn_pt == 0)
 				freq_pct30 = svsb->freq_pct[0];
@@ -1015,7 +1035,7 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 				*freq_pct |= (svsb->freq_pct[i] << b_sft);
 				shift_byte++;
 			}
-		} else if (svsb->type == SVSB_LOW) {
+		} else if (svsb->type == SVSB_TYPE_LOW) {
 			/*
 			 * freq_pct[turn_pt] +
 			 * freq_pct[opp_count - 7] ~ freq_pct[opp_count -1]
@@ -1032,7 +1052,7 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 			}
 		}
 	} else {
-		if (svsb->type == SVSB_HIGH) {
+		if (svsb->type == SVSB_TYPE_HIGH) {
 			/*
 			 * freq_pct[0] +
 			 * freq_pct[turn_pt - 7] ~ freq_pct[turn_pt - 1]
@@ -1047,7 +1067,7 @@ static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
 				*freq_pct |= (svsb->freq_pct[i] << b_sft);
 				shift_byte++;
 			}
-		} else if (svsb->type == SVSB_LOW) {
+		} else if (svsb->type == SVSB_TYPE_LOW) {
 			/* freq_pct[turn_pt] ~ freq_pct[opp_count - 1] */
 			for (i = turn_pt; i < svsb->opp_count; i++) {
 				b_sft = BITS8 * (shift_byte % REG_BYTES);
@@ -1550,7 +1570,7 @@ static int svs_init02(struct svs_platform *svsp)
 		if (!(svsb->mode_support & SVSB_MODE_INIT02))
 			continue;
 
-		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+		if (svsb->type == SVSB_TYPE_HIGH || svsb->type == SVSB_TYPE_LOW) {
 			if (svs_sync_bank_volts_from_opp(svsb)) {
 				dev_err(svsb->dev, "sync volt fail\n");
 				ret = -EPERM;
@@ -1677,19 +1697,19 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 		svsb = &svsp->banks[idx];
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
+		case SVSB_SWID_CPU_LITTLE:
 			svsb->name = "SVSB_CPU_LITTLE";
 			break;
-		case SVSB_CPU_BIG:
+		case SVSB_SWID_CPU_BIG:
 			svsb->name = "SVSB_CPU_BIG";
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			svsb->name = "SVSB_CCI";
 			break;
-		case SVSB_GPU:
-			if (svsb->type == SVSB_HIGH)
+		case SVSB_SWID_GPU:
+			if (svsb->type == SVSB_TYPE_HIGH)
 				svsb->name = "SVSB_GPU_HIGH";
-			else if (svsb->type == SVSB_LOW)
+			else if (svsb->type == SVSB_TYPE_LOW)
 				svsb->name = "SVSB_GPU_LOW";
 			else
 				svsb->name = "SVSB_GPU";
@@ -1821,13 +1841,13 @@ static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
 		if (ft_pgm == 0)
 			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
 
-		if (svsb->type == SVSB_LOW) {
+		if (svsb->type == SVSB_TYPE_LOW) {
 			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[8] >> 8) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_HIGH) {
+		} else if (svsb->type == SVSB_TYPE_HIGH) {
 			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
@@ -1886,13 +1906,13 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 		if (vmin == 0x1)
 			svsb->vmin = 0x1e;
 
-		if (svsb->type == SVSB_LOW) {
+		if (svsb->type == SVSB_TYPE_LOW) {
 			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_HIGH) {
+		} else if (svsb->type == SVSB_TYPE_HIGH) {
 			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
@@ -1946,13 +1966,13 @@ static bool svs_mt8188_efuse_parsing(struct svs_platform *svsp)
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
 
-		if (svsb->type == SVSB_LOW) {
+		if (svsb->type == SVSB_TYPE_LOW) {
 			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_HIGH) {
+		} else if (svsb->type == SVSB_TYPE_HIGH) {
 			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
@@ -2007,14 +2027,14 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 		svsb = &svsp->banks[idx];
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_BIG:
-			if (svsb->type == SVSB_HIGH) {
+		case SVSB_SWID_CPU_BIG:
+			if (svsb->type == SVSB_TYPE_HIGH) {
 				svsb->mdes = (svsp->efuse[2] >> 24) & GENMASK(7, 0);
 				svsb->bdes = (svsp->efuse[2] >> 16) & GENMASK(7, 0);
 				svsb->mtdes = svsp->efuse[2] & GENMASK(7, 0);
 				svsb->dcmdet = (svsp->efuse[13] >> 8) & GENMASK(7, 0);
 				svsb->dcbdet = svsp->efuse[13] & GENMASK(7, 0);
-			} else if (svsb->type == SVSB_LOW) {
+			} else if (svsb->type == SVSB_TYPE_LOW) {
 				svsb->mdes = (svsp->efuse[3] >> 24) & GENMASK(7, 0);
 				svsb->bdes = (svsp->efuse[3] >> 16) & GENMASK(7, 0);
 				svsb->mtdes = svsp->efuse[3] & GENMASK(7, 0);
@@ -2022,21 +2042,21 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 				svsb->dcbdet = (svsp->efuse[14] >> 16) & GENMASK(7, 0);
 			}
 			break;
-		case SVSB_CPU_LITTLE:
+		case SVSB_SWID_CPU_LITTLE:
 			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
 			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
 			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
 			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
 			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
 			break;
-		case SVSB_GPU:
+		case SVSB_SWID_GPU:
 			svsb->mdes = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
 			svsb->bdes = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
 			svsb->mtdes = svsp->efuse[6] & GENMASK(7, 0);
@@ -2098,7 +2118,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
+		case SVSB_SWID_CPU_LITTLE:
 			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
@@ -2110,7 +2130,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 			else
 				svsb->volt_od += 2;
 			break;
-		case SVSB_CPU_BIG:
+		case SVSB_SWID_CPU_BIG:
 			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
@@ -2122,7 +2142,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 			else
 				svsb->volt_od += 12;
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
@@ -2134,7 +2154,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 			else
 				svsb->volt_od += 2;
 			break;
-		case SVSB_GPU:
+		case SVSB_SWID_GPU:
 			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
 			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
 			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
@@ -2219,16 +2239,16 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		svsb->mts = mts;
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
+		case SVSB_SWID_CPU_LITTLE:
 			tb_roomt = x_roomt[3];
 			break;
-		case SVSB_CPU_BIG:
+		case SVSB_SWID_CPU_BIG:
 			tb_roomt = x_roomt[4];
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			tb_roomt = x_roomt[3];
 			break;
-		case SVSB_GPU:
+		case SVSB_SWID_GPU:
 			tb_roomt = x_roomt[1];
 			break;
 		default:
@@ -2321,9 +2341,9 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
 
-		if (svsb->type == SVSB_HIGH)
+		if (svsb->type == SVSB_TYPE_HIGH)
 			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
-		else if (svsb->type == SVSB_LOW)
+		else if (svsb->type == SVSB_TYPE_LOW)
 			svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
 
 		if (IS_ERR(svsb->opp_dev))
@@ -2355,14 +2375,14 @@ static int svs_mt8186_platform_probe(struct svs_platform *svsp)
 		svsb = &svsp->banks[idx];
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-		case SVSB_CPU_BIG:
+		case SVSB_SWID_CPU_LITTLE:
+		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
 			break;
-		case SVSB_GPU:
+		case SVSB_SWID_GPU:
 			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
 			break;
 		default:
@@ -2394,14 +2414,14 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 		svsb = &svsp->banks[idx];
 
 		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-		case SVSB_CPU_BIG:
+		case SVSB_SWID_CPU_LITTLE:
+		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
 			break;
-		case SVSB_CCI:
+		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
 			break;
-		case SVSB_GPU:
+		case SVSB_SWID_GPU:
 			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
 			break;
 		default:
@@ -2420,8 +2440,8 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 
 static struct svs_bank svs_mt8195_banks[] = {
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_LOW,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_LOW,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
@@ -2443,8 +2463,8 @@ static struct svs_bank svs_mt8195_banks[] = {
 		.ctl0			= 0x00540003,
 	},
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_HIGH,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_HIGH,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.tzone_name		= "gpu1",
@@ -2475,8 +2495,8 @@ static struct svs_bank svs_mt8195_banks[] = {
 
 static struct svs_bank svs_mt8192_banks[] = {
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_LOW,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_LOW,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.tzone_name		= "gpu1",
@@ -2503,8 +2523,8 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.tzone_ltemp_voffset	= 7,
 	},
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_HIGH,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_HIGH,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.tzone_name		= "gpu1",
@@ -2535,8 +2555,8 @@ static struct svs_bank svs_mt8192_banks[] = {
 
 static struct svs_bank svs_mt8188_banks[] = {
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_LOW,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_LOW,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
@@ -2558,8 +2578,8 @@ static struct svs_bank svs_mt8188_banks[] = {
 		.ctl0			= 0x00100003,
 	},
 	{
-		.sw_id			= SVSB_GPU,
-		.type			= SVSB_HIGH,
+		.sw_id			= SVSB_SWID_GPU,
+		.type			= SVSB_TYPE_HIGH,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.tzone_name		= "gpu1",
@@ -2590,8 +2610,8 @@ static struct svs_bank svs_mt8188_banks[] = {
 
 static struct svs_bank svs_mt8186_banks[] = {
 	{
-		.sw_id			= SVSB_CPU_BIG,
-		.type			= SVSB_LOW,
+		.sw_id			= SVSB_SWID_CPU_BIG,
+		.type			= SVSB_TYPE_LOW,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.cpu_id			= 6,
@@ -2615,8 +2635,8 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.ctl0			= 0x00540003,
 	},
 	{
-		.sw_id			= SVSB_CPU_BIG,
-		.type			= SVSB_HIGH,
+		.sw_id			= SVSB_SWID_CPU_BIG,
+		.type			= SVSB_TYPE_HIGH,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
 		.cpu_id			= 6,
@@ -2646,7 +2666,7 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_ltemp_voffset	= 8,
 	},
 	{
-		.sw_id			= SVSB_CPU_LITTLE,
+		.sw_id			= SVSB_SWID_CPU_LITTLE,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.cpu_id			= 0,
@@ -2675,7 +2695,7 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_ltemp_voffset	= 8,
 	},
 	{
-		.sw_id			= SVSB_CCI,
+		.sw_id			= SVSB_SWID_CCI,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.tzone_name		= "cpu_zone0",
@@ -2703,7 +2723,7 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_ltemp_voffset	= 8,
 	},
 	{
-		.sw_id			= SVSB_GPU,
+		.sw_id			= SVSB_SWID_GPU,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.tzone_name		= "mfg",
@@ -2733,7 +2753,7 @@ static struct svs_bank svs_mt8186_banks[] = {
 
 static struct svs_bank svs_mt8183_banks[] = {
 	{
-		.sw_id			= SVSB_CPU_LITTLE,
+		.sw_id			= SVSB_SWID_CPU_LITTLE,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.cpu_id			= 0,
@@ -2757,7 +2777,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.ctl0			= 0x00010001,
 	},
 	{
-		.sw_id			= SVSB_CPU_BIG,
+		.sw_id			= SVSB_SWID_CPU_BIG,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.cpu_id			= 4,
@@ -2781,7 +2801,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.ctl0			= 0x00000001,
 	},
 	{
-		.sw_id			= SVSB_CCI,
+		.sw_id			= SVSB_SWID_CCI,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.buck_name		= "proc",
@@ -2804,7 +2824,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.ctl0			= 0x00100003,
 	},
 	{
-		.sw_id			= SVSB_GPU,
+		.sw_id			= SVSB_SWID_GPU,
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.buck_name		= "mali",
-- 
2.42.0

