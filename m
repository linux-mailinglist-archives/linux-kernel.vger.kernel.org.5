Return-Path: <linux-kernel+bounces-43093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB72840B79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ECC1C2272C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053415A4B0;
	Mon, 29 Jan 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pGfC5qfH"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088571586E3;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545687; cv=none; b=uM4tnW4HI1xsfSOBqmMT8b7ld2nvWFkEcvDonkU90hgEJj+rYoIlFtkrM9u2DnoWYHgiPm1utMRChgeQK6YVQ/17qh75GQo+oFGIcqLg+4d5xy+bqFtqme8mxcSutY0MEpFlPHbwg6QeKkJ3/X8pXj/oHy4Dgkib9CZ0IEMOxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545687; c=relaxed/simple;
	bh=IheahSJ5pZDyJHeh2vQaF9QieXomQ/EZmA8SfLYgLlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKFcqWkDTVUz4IvIXVd7ME9/Nod0ERl6lmA5Zbx1vYBQCfT1jb4PZu940mY9AP6Xgj3kxM/zaD5viGb2D/9qOUWu9mCXd5rt1WL1H+yZK5dM6QDEPRmagKqF/JQLWgDTES7MP/t4gtufXDonsx7mdfltaiiYG3j19FJE0aGEtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pGfC5qfH; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0H006968;
	Mon, 29 Jan 2024 10:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=lC1UKIEVkahfF2TN2WxdAFipqWeA28oaULEu5J51mKw=; b=
	pGfC5qfHgPLsge+lAwAHe8EeWQ/ECpHTh1VLZJWr+lISmMi1DpCCB8ntjHt/GLB+
	pQ8ykJ6sleszUk6AqxY7wg5CV85uPc7/cPp2Sr2knY6KespqilNkjJC8LOgHkj7g
	nm2JYrflf/meJCxIbXEO0NNUBAAa4AObgeXxcIwQBtP3XFzoTF5whsutJirYaHne
	0qtBUe58nCmBjGzNTy/UQ7pucyjr2qEcRbD9jLRcuP8GsC6X1UPxg1ZStzJS2QhH
	59Cla/r7A70xR4BTtY9j/cppPDsgV700mLk5SRAJVAVf9nan3myESbNOLZIQa8Br
	5XQPD5FXG95Y1lE42Q6inA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:44 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CAFF5820247;
	Mon, 29 Jan 2024 16:27:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 07/18] ASoC: cs35l56: Fix to ensure ASP1 registers match cache
Date: Mon, 29 Jan 2024 16:27:26 +0000
Message-ID: <20240129162737.497-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EnTpuE158EIT4QMYhyeE2EKHy7Y19WqZ
X-Proofpoint-GUID: EnTpuE158EIT4QMYhyeE2EKHy7Y19WqZ
X-Proofpoint-Spam-Reason: safe

Add a dummy SUPPLY widget connected to the ASP that forces the
chip registers to match the regmap cache when the ASP is
powered-up.

On a SoundWire system the ASP is free for use as a chip-to-chip
interconnect. This can be either for the firmware on multiple
CS35L56 to share reference audio; or as a bridge to another
device. If it is a firmware interconnect it is owned by the
firmware and the Linux driver should avoid writing the registers.
However. If it is a bridge then Linux may take over and handle
it as a normal codec-to-codec link.

CS35L56 is designed for SDCA and a generic SDCA driver would
know nothing about these chip-specific registers. So if the
ASP is being used on a SoundWire system the firmware sets up the
ASP registers. This means that we can't assume the default
state of the ASP registers. But we don't know the initial state
that the firmware set them to until after the firmware has been
downloaded and booted, which can take several seconds when
downloading multiple amps.

To avoid blocking probe() for several seconds waiting for the
firmware, the silicon defaults are assumed. This allows the machine
driver to setup the ASP configuration during probe() without being
blocked. If the ASP is hooked up and used, the SUPPLY widget
ensures that the chip registers match what was configured in the
regmap cache.

If the machine driver does not hook up the ASP, it is assumed that
it won't call any functions to configure the ASP DAI. Therefore
the regmap cache will be clean for these registers so a
regcache_sync() will not overwrite the chip registers. If the
DAI is not hooked up, the dummy SUPPLY widget will not be
invoked so it will never force-overwrite the chip registers.

Backport note:
This won't apply cleanly to kernels older than v6.6.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 41 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 21 ++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 8c18e8b6d27d..4db36c893d9d 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -272,6 +272,7 @@ extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
 int cs35l56_set_patch(struct cs35l56_base *cs35l56_base);
+int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base);
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
 int cs35l56_firmware_shutdown(struct cs35l56_base *cs35l56_base);
 int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 0cd572de73a9..35789ffc63af 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -195,6 +195,47 @@ static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+/*
+ * The firmware boot sequence can overwrite the ASP1 config registers so that
+ * they don't match regmap's view of their values. Rewrite the values from the
+ * regmap cache into the hardware registers.
+ */
+int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base)
+{
+	struct reg_sequence asp1_regs[] = {
+		{ .reg = CS35L56_ASP1_ENABLES1 },
+		{ .reg = CS35L56_ASP1_CONTROL1 },
+		{ .reg = CS35L56_ASP1_CONTROL2 },
+		{ .reg = CS35L56_ASP1_CONTROL3 },
+		{ .reg = CS35L56_ASP1_FRAME_CONTROL1 },
+		{ .reg = CS35L56_ASP1_FRAME_CONTROL5 },
+		{ .reg = CS35L56_ASP1_DATA_CONTROL1 },
+		{ .reg = CS35L56_ASP1_DATA_CONTROL5 },
+	};
+	int i, ret;
+
+	/* Read values from regmap cache into a write sequence */
+	for (i = 0; i < ARRAY_SIZE(asp1_regs); ++i) {
+		ret = regmap_read(cs35l56_base->regmap, asp1_regs[i].reg, &asp1_regs[i].def);
+		if (ret)
+			goto err;
+	}
+
+	/* Write the values cache-bypassed so that they will be written to silicon */
+	ret = regmap_multi_reg_write_bypassed(cs35l56_base->regmap, asp1_regs,
+					      ARRAY_SIZE(asp1_regs));
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(cs35l56_base->dev, "Failed to sync ASP1 registers: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_force_sync_asp1_registers_from_cache, SND_SOC_CS35L56_SHARED);
+
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
 {
 	unsigned int val;
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index ea5d2b2eb82a..41aa79848b15 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -148,6 +148,21 @@ static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx4_enum,
 static const struct snd_kcontrol_new sdw1_tx4_mux =
 	SOC_DAPM_ENUM("SDW1TX4 SRC", cs35l56_sdw1tx4_enum);
 
+static int cs35l56_asp1_cfg_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Override register values set by firmware boot */
+		return cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
+	default:
+		return 0;
+	}
+}
+
 static int cs35l56_play_event(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol, int event)
 {
@@ -184,6 +199,9 @@ static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_B", 0, 0),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_AMP", 0, 0),
 
+	SND_SOC_DAPM_SUPPLY("ASP1 CFG", SND_SOC_NOPM, 0, 0, cs35l56_asp1_cfg_event,
+			    SND_SOC_DAPM_PRE_PMU),
+
 	SND_SOC_DAPM_SUPPLY("PLAY", SND_SOC_NOPM, 0, 0, cs35l56_play_event,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
@@ -251,6 +269,9 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
 	{ "AMP", NULL, "VDD_B" },
 	{ "AMP", NULL, "VDD_AMP" },
 
+	{ "ASP1 Playback", NULL, "ASP1 CFG" },
+	{ "ASP1 Capture", NULL, "ASP1 CFG" },
+
 	{ "ASP1 Playback", NULL, "PLAY" },
 	{ "SDW1 Playback", NULL, "PLAY" },
 
-- 
2.39.2


