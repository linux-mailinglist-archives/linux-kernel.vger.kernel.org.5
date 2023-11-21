Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978327F2C60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjKUL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjKUL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F6D5F;
        Tue, 21 Nov 2023 03:56:40 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 393646607286;
        Tue, 21 Nov 2023 11:56:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567799;
        bh=y4hC7rjcvzTRTeQC8pyo7KQ1ZhxtsknG+ldiwzI/d40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4lEWDUBYAYOdtl+gW2+VN8SHrWi3YN7fv79PVM5uX19xytbyS1mmkLyq/qd3sY4s
         wxAYfOp1mlNj5U/293LYIlWMO0RIQEC2mvzFrIHM0PJPFF7SfS0JXjPet3bgY6n8uC
         +Dr9sV7J2WxoMPb5BTK+xtk1lZU1CLn5oIkM74b3YDlDLzHXD2ypqrJjQExfSeFdaY
         /r3Jmh1MtaayI+cKLtFN60D2AKPKjIHAg5WLJgf5z6TlzWBEEM1FpvLUpF4G68f+di
         bDyJAPGnduKJqNfPi3+Znkxpt0wWbPodDhqVKrG2AZBjlA8PVDjCe5MWI+x+vsXBO3
         jkMhyJ7quSbsw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 07/20] soc: mediatek: mtk-svs: Add a map to retrieve fused values
Date:   Tue, 21 Nov 2023 12:56:11 +0100
Message-ID: <20231121115624.56855-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a common efuse parsing function which will
greatly reduce code duplication, add a SoC-specific mapping that will
be used to retrieve the right SVS calibration values from the fuses.
The maps are two: one is a Global Map used for reading parameters that
are SVS-global, and one is a Bank Map for reading calibrations for
each SVS Bank.

While at it, also populate the map in the platform data for each SoC.

Being this a preparation commit, there are no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 87 ++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index b5beb33c95ba..6c6f133c327f 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -340,6 +340,26 @@ static const char * const svs_type_names[SVSB_TYPE_MAX] = {
 	"", "_LOW", "_HIGH"
 };
 
+enum svs_fusemap_dev {
+	BDEV_BDES,
+	BDEV_MDES,
+	BDEV_MTDES,
+	BDEV_DCBDET,
+	BDEV_DCMDET,
+	BDEV_MAX
+};
+
+enum svs_fusemap_glb {
+	GLB_FT_PGM,
+	GLB_VMIN,
+	GLB_MAX
+};
+
+struct svs_fusemap {
+	s8 index;
+	u8 ofst;
+};
+
 /**
  * struct svs_platform - svs platform control
  * @base: svs platform register base
@@ -375,12 +395,14 @@ struct svs_platform_data {
 	struct svs_bank *banks;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
 	int (*probe)(struct svs_platform *svsp);
+	const struct svs_fusemap *glb_fuse_map;
 	const u32 *regs;
 	u32 bank_max;
 };
 
 /**
  * struct svs_bank - svs bank representation
+ * @dev_fuse_map: Bank fuse map data
  * @dev: bank device
  * @opp_dev: device for opp table/buck control
  * @init_completion: the timeout completion for bank init
@@ -444,6 +466,7 @@ struct svs_platform_data {
  * opp_volt[i] = (volt[i] * volt_step) + volt_base;
  */
 struct svs_bank {
+	const struct svs_fusemap *dev_fuse_map;
 	struct device *dev;
 	struct device *opp_dev;
 	struct completion init_completion;
@@ -2457,6 +2480,9 @@ static struct svs_bank svs_mt8195_banks[] = {
 		.core_sel		= 0x0fff0100,
 		.int_st			= BIT(0),
 		.ctl0			= 0x00540003,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 10, 16 }, { 10, 24 }, { 10, 0 }, { 8, 0 }, { 8, 8 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_GPU,
@@ -2486,6 +2512,9 @@ static struct svs_bank svs_mt8195_banks[] = {
 		.tzone_htemp_voffset	= 0,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 7,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 9, 16 }, { 9, 24 }, { 9, 0 }, { 8, 0 }, { 8, 8 }
+		},
 	},
 };
 
@@ -2517,6 +2546,9 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.tzone_htemp_voffset	= 0,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 7,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 10, 16 }, { 10, 24 }, { 10, 0 }, { 17, 0 }, { 17, 8 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_GPU,
@@ -2546,6 +2578,9 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.tzone_htemp_voffset	= 0,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 7,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 9, 16 }, { 9, 24 }, { 17, 0 }, { 17, 16 }, { 17, 24 }
+		}
 	},
 };
 
@@ -2572,6 +2607,9 @@ static struct svs_bank svs_mt8188_banks[] = {
 		.core_sel		= 0x0fff0000,
 		.int_st			= BIT(0),
 		.ctl0			= 0x00100003,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 5, 16 }, { 5, 24 }, { 5, 0 }, { 15, 16 }, { 15, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_GPU,
@@ -2601,6 +2639,9 @@ static struct svs_bank svs_mt8188_banks[] = {
 		.tzone_htemp_voffset	= 0,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 7,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 4, 16 }, { 4, 24 }, { 4, 0 }, { 14, 0 }, { 14, 8 }
+		}
 	},
 };
 
@@ -2629,6 +2670,9 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.core_sel		= 0x0fff0100,
 		.int_st			= BIT(0),
 		.ctl0			= 0x00540003,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 3, 16 }, { 3, 24 }, { 3, 0 }, { 14, 16 }, { 14, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_CPU_BIG,
@@ -2660,6 +2704,9 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_htemp_voffset	= 8,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 8,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 2, 16 }, { 2, 24 }, { 2, 0 }, { 13, 0 }, { 13, 8 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_CPU_LITTLE,
@@ -2689,6 +2736,9 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_htemp_voffset	= 8,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 8,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 4, 16 }, { 4, 24 }, { 4, 0 }, { 14, 0 }, { 14, 8 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_CCI,
@@ -2717,6 +2767,9 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_htemp_voffset	= 8,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 8,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 5, 16 }, { 5, 24 }, { 5, 0 }, { 15, 16 }, { 15, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_GPU,
@@ -2744,6 +2797,9 @@ static struct svs_bank svs_mt8186_banks[] = {
 		.tzone_htemp_voffset	= 8,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 7,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 6, 16 }, { 6, 24 }, { 6, 0 }, { 15, 8 }, { 15, 0 }
+		}
 	},
 };
 
@@ -2771,6 +2827,9 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.core_sel		= 0x8fff0000,
 		.int_st			= BIT(0),
 		.ctl0			= 0x00010001,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 16, 0 }, { 16, 8 }, { 17, 16 }, { 16, 16 }, { 16, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_CPU_BIG,
@@ -2795,6 +2854,9 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.core_sel		= 0x8fff0001,
 		.int_st			= BIT(1),
 		.ctl0			= 0x00000001,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 18, 0 }, { 18, 8 }, { 17, 0 }, { 18, 16 }, { 18, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_CCI,
@@ -2818,6 +2880,9 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.core_sel		= 0x8fff0002,
 		.int_st			= BIT(2),
 		.ctl0			= 0x00100003,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 4, 0 }, { 4, 8 }, { 5, 16 }, { 4, 16 }, { 4, 24 }
+		}
 	},
 	{
 		.sw_id			= SVSB_SWID_GPU,
@@ -2848,6 +2913,9 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.tzone_htemp_voffset	= 0,
 		.tzone_ltemp		= 25000,
 		.tzone_ltemp_voffset	= 3,
+		.dev_fuse_map		= (const struct svs_fusemap[BDEV_MAX]) {
+			{ 6, 0 }, { 6, 8 }, { 5, 0 }, { 6, 16 }, { 6, 24 }
+		}
 	},
 };
 
@@ -2858,6 +2926,9 @@ static const struct svs_platform_data svs_mt8195_platform_data = {
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8195_banks),
+	.glb_fuse_map = (const struct svs_fusemap[GLB_MAX]) {
+		{ 0, 0 }, { 19, 4 }
+	}
 };
 
 static const struct svs_platform_data svs_mt8192_platform_data = {
@@ -2867,6 +2938,10 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
+	.glb_fuse_map = (const struct svs_fusemap[GLB_MAX]) {
+		/* FT_PGM not present */
+		{ -1, 0 }, { 19, 4 }
+	}
 };
 
 static const struct svs_platform_data svs_mt8188_platform_data = {
@@ -2876,6 +2951,10 @@ static const struct svs_platform_data svs_mt8188_platform_data = {
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8188_banks),
+	.glb_fuse_map = (const struct svs_fusemap[GLB_MAX]) {
+		/* FT_PGM and VMIN not present */
+		{ -1, 0 }, { -1, 0 }
+	}
 };
 
 static const struct svs_platform_data svs_mt8186_platform_data = {
@@ -2885,6 +2964,10 @@ static const struct svs_platform_data svs_mt8186_platform_data = {
 	.probe = svs_mt8186_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8186_banks),
+	.glb_fuse_map = (const struct svs_fusemap[GLB_MAX]) {
+		/* FT_PGM and VMIN not present */
+		{ -1, 0 }, { -1, 0 }
+	}
 };
 
 static const struct svs_platform_data svs_mt8183_platform_data = {
@@ -2894,6 +2977,10 @@ static const struct svs_platform_data svs_mt8183_platform_data = {
 	.probe = svs_mt8183_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8183_banks),
+	.glb_fuse_map = (const struct svs_fusemap[GLB_MAX]) {
+		/* VMIN not present */
+		{ 0, 4 }, { -1, 0 }
+	}
 };
 
 static const struct of_device_id svs_of_match[] = {
-- 
2.42.0

