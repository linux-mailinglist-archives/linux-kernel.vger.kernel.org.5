Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC425757FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjGROqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGROqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:46:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735AAEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:46:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36I7kHxC024058;
        Tue, 18 Jul 2023 09:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=0
        G3ywaHiTI2K4Iq59zz0mJoTcYfX+05Q6H/h75rm73M=; b=PNb+OnjBag/MGfHC0
        00o37F5KNsBH6vj9JJBzi0ZTOSPfCd/vnL5fP6WVxBwBGf5SZM/WNp7wT39BgF/C
        FbJakYU0eTtdFtRdhpp0mKO3wlASiMcK53/M38xm2pO22gLlAfXgFVB2EqcN1EFN
        nfj9WuabIF/loeXPWNDm/fP7pvTwq0pycnPrOS6IxXCs34pfzl4VCIHKuxSj2XKF
        yOvWb9qGcjgiDTSDunXwESK/9GxufHlX2jrJXBDd2SS4cz74ktBd9Ft4BDP2NyN8
        vfAD8t4DvpT4pCNmHUrDBV4kKk9alBYLfDeu5LduWqMzklVmF8v8qC5Jp5Bi79Oa
        cNGpA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62ucu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:46:41 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 15:46:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 18 Jul 2023 15:46:29 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.65.142])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E77DD11AB;
        Tue, 18 Jul 2023 14:46:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Patch soft registers to defaults
Date:   Tue, 18 Jul 2023 15:46:25 +0100
Message-ID: <20230718144625.39634-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: v5oVImHN2qJH3UiahHtCUQ8k9EC0bKRg
X-Proofpoint-ORIG-GUID: v5oVImHN2qJH3UiahHtCUQ8k9EC0bKRg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soft (firmware) registers for volume/mute/posture are not reset by
a chip soft-reset, so use a regmap patch to set them to defaults.

cs35l56_reread_firmware_registers() has been removed. Its intent was to
use whatever the firmware set as a default. But the driver now patches the
defaults to the registers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  2 +-
 sound/soc/codecs/cs35l56-shared.c | 38 +++++++++++++------------------
 sound/soc/codecs/cs35l56.c        |  5 ++--
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 1f9713d7ca76..ec672daa36cf 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -260,7 +260,7 @@ extern const struct cs_dsp_region cs35l56_dsp1_regions[CS35L56_NUM_DSP_REGIONS];
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
-void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap);
+int cs35l56_set_patch(struct regmap *regmap);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 60da8c75b7b9..7126f06b8047 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -11,6 +11,19 @@
 
 #include "cs35l56.h"
 
+static const struct reg_sequence cs35l56_patch[] = {
+	/* These are not reset by a soft-reset, so patch to defaults. */
+	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
+	{ CS35L56_MAIN_RENDER_USER_VOLUME,	0x00000000 },
+	{ CS35L56_MAIN_POSTURE_NUMBER,		0x00000000 },
+};
+
+int cs35l56_set_patch(struct regmap *regmap)
+{
+	return regmap_register_patch(regmap, cs35l56_patch, ARRAY_SIZE(cs35l56_patch));
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_set_patch, SND_SOC_CS35L56_SHARED);
+
 static const struct reg_default cs35l56_reg_defaults[] = {
 	{ CS35L56_ASP1_ENABLES1,		0x00000000 },
 	{ CS35L56_ASP1_CONTROL1,		0x00000028 },
@@ -35,9 +48,9 @@ static const struct reg_default cs35l56_reg_defaults[] = {
 	{ CS35L56_IRQ1_MASK_8,			0xfc000fff },
 	{ CS35L56_IRQ1_MASK_18,			0x1f7df0ff },
 	{ CS35L56_IRQ1_MASK_20,			0x15c00000 },
-	/* CS35L56_MAIN_RENDER_USER_MUTE - soft register, no default	*/
-	/* CS35L56_MAIN_RENDER_USER_VOLUME - soft register, no default	*/
-	/* CS35L56_MAIN_POSTURE_NUMBER - soft register, no default	*/
+	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
+	{ CS35L56_MAIN_RENDER_USER_VOLUME,	0x00000000 },
+	{ CS35L56_MAIN_POSTURE_NUMBER,		0x00000000 },
 };
 
 static bool cs35l56_is_dsp_memory(unsigned int reg)
@@ -181,25 +194,6 @@ static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const u32 cs35l56_firmware_registers[] = {
-	CS35L56_MAIN_RENDER_USER_MUTE,
-	CS35L56_MAIN_RENDER_USER_VOLUME,
-	CS35L56_MAIN_POSTURE_NUMBER,
-};
-
-void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap)
-{
-	int i;
-	unsigned int val;
-
-	for (i = 0; i < ARRAY_SIZE(cs35l56_firmware_registers); i++) {
-		regmap_read(regmap, cs35l56_firmware_registers[i], &val);
-		dev_dbg(dev, "%s: %d: %#x: %#x\n", __func__,
-			i, cs35l56_firmware_registers[i], val);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_reread_firmware_registers, SND_SOC_CS35L56_SHARED);
-
 const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c03f9d3c9a13..e046fdd26b74 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1572,8 +1572,9 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
-	/* Populate soft registers in the regmap cache */
-	cs35l56_reread_firmware_registers(cs35l56->dev, cs35l56->regmap);
+	ret = cs35l56_set_patch(cs35l56->regmap);
+	if (ret)
+		return ret;
 
 	/* Registers could be dirty after soft reset or SoundWire enumeration */
 	regcache_sync(cs35l56->regmap);
-- 
2.30.2

