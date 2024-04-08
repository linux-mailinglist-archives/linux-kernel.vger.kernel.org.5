Return-Path: <linux-kernel+bounces-135218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C189BCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA661C21B67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23A53804;
	Mon,  8 Apr 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HGQ462Cs"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32C52F83;
	Mon,  8 Apr 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571509; cv=none; b=VLcKtwA/c4/WsS1Cto7lu42LQElFtXioK6bh0JSM9CM9edufwWa4FhPK0lfPWa7cI75stOzkJ/wD4wYPMhLys/gwRg7pG7DkR5lu+KLJz22XbG57PkmC1z9c05ntKbrTuJShmDaX7/zilu3TSc8GC+SakieMtF4/lDyMPIpBLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571509; c=relaxed/simple;
	bh=TQWosqsbyYiX0BmKteXRyNXP2meiRxmUQbjuOgUFR78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2yVrwnboj9aA87zdOqbte2HNrvk/TPDYWf7MZDr5HbOpiYI2Ozbk9B+k/Coridt+nbaBoTPmxjqBtBn4WuB7A6Kf7SRizlb5jySzojiQcBuJzr+2HhzHwPEW38+d47YLxMQYso3VbBlP/XCo53SZBC6IQVfz1ZSHCq+V6IV61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HGQ462Cs; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43850rVB005178;
	Mon, 8 Apr 2024 05:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=l+DAz+9pELwzHlKhsrPSykE9OC1nwW1PQzFJmLp40gs=; b=
	HGQ462Cs/xqLP4NU+PyAc+GbZsKdvW/v+WCZfz0eu8pffuQxzw/8r7kb5gf7Ri6y
	hoC/gSvssJTVewMSFQMYhEQ6mmCrXTpw4blk1wPyYEhfIKzsmFrwMqmfPlN95P2G
	FvxA10cl9qimTecBopbHjq8Ahgu5dwgtkVamq4jmMlHJW3NH5IrVCDbE9ETb9r0j
	/GNynAu0cZ9Y2feo6XCeTm06e9Ul5zJuA2U4KWnhPHD7F69N6oX4u0rXUAFoUeVA
	bGe6D4K2p3TtDeGfEympHAchcTU0C5d+QstDnTd3H3v4g4//db6MWNqSuAZB+mis
	X7buJFCK48kMqj7Dy1Zn6g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhbbq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 05:18:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:18:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 11:18:03 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 47750820259;
	Mon,  8 Apr 2024 10:18:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: cs35l56: Prevent overwriting firmware ASP config
Date: Mon, 8 Apr 2024 11:18:03 +0100
Message-ID: <20240408101803.43183-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408101803.43183-1-rf@opensource.cirrus.com>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s124VKN2L7DIJ_4Pm6W4ADAx66Orsnkt
X-Proofpoint-GUID: s124VKN2L7DIJ_4Pm6W4ADAx66Orsnkt
X-Proofpoint-Spam-Reason: safe

Only populate the ASP1 config registers in the regmap cache if the
ASP DAI is used. This prevents regcache_sync() from overwriting
these registers with their defaults when the firmware owns
control of these registers.

On a SoundWire system the ASP could be owned by the firmware to
share reference audio with the firmware on other cs35l56. Or it
can be used as a normal codec-codec interface owned by the driver.
The driver must not overwrite the registers if the firmware has
control of them.

The original implementation for this in commit 07f7d6e7a124
("ASoC: cs35l56: Fix for initializing ASP1 mixer registers") was
to still provide defaults for these registers, assuming that if
they were never reconfigured from defaults then regcache_sync()
would not write them out because they are not dirty. Unfortunately
regcache_sync() is not that smart. If the chip has not reset (so
the driver has not called regcache_mark_dirty()) a regcache_sync()
could write out registers that are not dirty.

To avoid accidental overwriting of the ASP registers, they are
removed from the table of defaults and instead are populated with
defaults only if one of the ASP DAI configuration functions is
called. So if the DAI has never been configured, the firmware is
assumed to have ownership of these registers, and the regmap cache
will not contain any entries for them.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 07f7d6e7a124 ("ASoC: cs35l56: Fix for initializing ASP1 mixer registers")
---
 include/sound/cs35l56.h           |  2 +
 sound/soc/codecs/cs35l56-shared.c | 63 ++++++++++++++++++++-----------
 sound/soc/codecs/cs35l56.c        | 24 +++++++++++-
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e0629699b563..1a3c6f66f620 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -267,6 +267,7 @@ struct cs35l56_base {
 	bool fw_patched;
 	bool secured;
 	bool can_hibernate;
+	bool fw_owns_asp1;
 	bool cal_data_valid;
 	s8 cal_index;
 	struct cirrus_amp_cal_data cal_data;
@@ -283,6 +284,7 @@ extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
 int cs35l56_set_patch(struct cs35l56_base *cs35l56_base);
+int cs35l56_init_asp1_regs_for_driver_control(struct cs35l56_base *cs35l56_base);
 int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base);
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
 int cs35l56_firmware_shutdown(struct cs35l56_base *cs35l56_base);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index a83317db75ed..ec1d95e57061 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -40,16 +40,11 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_set_patch, SND_SOC_CS35L56_SHARED);
 static const struct reg_default cs35l56_reg_defaults[] = {
 	/* no defaults for OTP_MEM - first read populates cache */
 
-	{ CS35L56_ASP1_ENABLES1,		0x00000000 },
-	{ CS35L56_ASP1_CONTROL1,		0x00000028 },
-	{ CS35L56_ASP1_CONTROL2,		0x18180200 },
-	{ CS35L56_ASP1_CONTROL3,		0x00000002 },
-	{ CS35L56_ASP1_FRAME_CONTROL1,		0x03020100 },
-	{ CS35L56_ASP1_FRAME_CONTROL5,		0x00020100 },
-	{ CS35L56_ASP1_DATA_CONTROL1,		0x00000018 },
-	{ CS35L56_ASP1_DATA_CONTROL5,		0x00000018 },
-
-	/* no defaults for ASP1TX mixer */
+	/*
+	 * No defaults for ASP1 control or ASP1TX mixer. See
+	 * cs35l56_populate_asp1_register_defaults() and
+	 * cs35l56_sync_asp1_mixer_widgets_with_firmware().
+	 */
 
 	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
@@ -210,6 +205,36 @@ static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_sequence cs35l56_asp1_defaults[] = {
+	REG_SEQ0(CS35L56_ASP1_ENABLES1,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1_CONTROL1,		0x00000028),
+	REG_SEQ0(CS35L56_ASP1_CONTROL2,		0x18180200),
+	REG_SEQ0(CS35L56_ASP1_CONTROL3,		0x00000002),
+	REG_SEQ0(CS35L56_ASP1_FRAME_CONTROL1,	0x03020100),
+	REG_SEQ0(CS35L56_ASP1_FRAME_CONTROL5,	0x00020100),
+	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL1,	0x00000018),
+	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL5,	0x00000018),
+};
+
+/*
+ * The firmware can have control of the ASP so we don't provide regmap
+ * with defaults for these registers, to prevent a regcache_sync() from
+ * overwriting the firmware settings. But if the machine driver hooks up
+ * the ASP it means the driver is taking control of the ASP, so then the
+ * registers are populated with the defaults.
+ */
+int cs35l56_init_asp1_regs_for_driver_control(struct cs35l56_base *cs35l56_base)
+{
+	if (!cs35l56_base->fw_owns_asp1)
+		return 0;
+
+	cs35l56_base->fw_owns_asp1 = false;
+
+	return regmap_multi_reg_write(cs35l56_base->regmap, cs35l56_asp1_defaults,
+				      ARRAY_SIZE(cs35l56_asp1_defaults));
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_init_asp1_regs_for_driver_control, SND_SOC_CS35L56_SHARED);
+
 /*
  * The firmware boot sequence can overwrite the ASP1 config registers so that
  * they don't match regmap's view of their values. Rewrite the values from the
@@ -217,19 +242,15 @@ static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
  */
 int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base)
 {
-	struct reg_sequence asp1_regs[] = {
-		{ .reg = CS35L56_ASP1_ENABLES1 },
-		{ .reg = CS35L56_ASP1_CONTROL1 },
-		{ .reg = CS35L56_ASP1_CONTROL2 },
-		{ .reg = CS35L56_ASP1_CONTROL3 },
-		{ .reg = CS35L56_ASP1_FRAME_CONTROL1 },
-		{ .reg = CS35L56_ASP1_FRAME_CONTROL5 },
-		{ .reg = CS35L56_ASP1_DATA_CONTROL1 },
-		{ .reg = CS35L56_ASP1_DATA_CONTROL5 },
-	};
+	struct reg_sequence asp1_regs[ARRAY_SIZE(cs35l56_asp1_defaults)];
 	int i, ret;
 
-	/* Read values from regmap cache into a write sequence */
+	if (cs35l56_base->fw_owns_asp1)
+		return 0;
+
+	memcpy(asp1_regs, cs35l56_asp1_defaults, sizeof(asp1_regs));
+
+	/* Read current values from regmap cache into the write sequence */
 	for (i = 0; i < ARRAY_SIZE(asp1_regs); ++i) {
 		ret = regmap_read(cs35l56_base->regmap, asp1_regs[i].reg, &asp1_regs[i].def);
 		if (ret)
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 5a4e0e479414..6331b8c6136e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -454,9 +454,14 @@ static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int f
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int val;
+	int ret;
 
 	dev_dbg(cs35l56->base.dev, "%s: %#x\n", __func__, fmt);
 
+	ret = cs35l56_init_asp1_regs_for_driver_control(&cs35l56->base);
+	if (ret)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_CBC_CFC:
 		break;
@@ -530,6 +535,11 @@ static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx
 					unsigned int rx_mask, int slots, int slot_width)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	ret = cs35l56_init_asp1_regs_for_driver_control(&cs35l56->base);
+	if (ret)
+		return ret;
 
 	if ((slots == 0) || (slot_width == 0)) {
 		dev_dbg(cs35l56->base.dev, "tdm config cleared\n");
@@ -578,6 +588,11 @@ static int cs35l56_asp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
 	unsigned int rate = params_rate(params);
 	u8 asp_width, asp_wl;
+	int ret;
+
+	ret = cs35l56_init_asp1_regs_for_driver_control(&cs35l56->base);
+	if (ret)
+		return ret;
 
 	asp_wl = params_width(params);
 	if (cs35l56->asp_slot_width)
@@ -634,7 +649,11 @@ static int cs35l56_asp_dai_set_sysclk(struct snd_soc_dai *dai,
 				      int clk_id, unsigned int freq, int dir)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
-	int freq_id;
+	int freq_id, ret;
+
+	ret = cs35l56_init_asp1_regs_for_driver_control(&cs35l56->base);
+	if (ret)
+		return ret;
 
 	if (freq == 0) {
 		cs35l56->sysclk_set = false;
@@ -1403,6 +1422,9 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 	cs35l56->base.cal_index = -1;
 	cs35l56->speaker_id = -ENOENT;
 
+	/* Assume that the firmware owns ASP1 until we know different */
+	cs35l56->base.fw_owns_asp1 = true;
+
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
 	cs35l56_fill_supply_names(cs35l56->supplies);
-- 
2.39.2


