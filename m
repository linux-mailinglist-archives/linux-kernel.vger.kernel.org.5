Return-Path: <linux-kernel+bounces-104339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFC87CC50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAFE1C20B12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4EA249FC;
	Fri, 15 Mar 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DNynfv49"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6ED1C6B6;
	Fri, 15 Mar 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502088; cv=none; b=Er26nvepl/+mvEE9zi98oEQ5/EDNntsL3CJ8vqdxtgiwSB6YCMCCWCL6ldhwVj1VEgURfLUJN0/3A+GNluJkw/NIkiTG3wiJRqyoHwbGC+k4HzYSf+Ec9+18PSPCvFxaSTkU8u26Q6US1cKjjNqj/v+9d5deqK9bZsoHGfoxqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502088; c=relaxed/simple;
	bh=MAOpYtzIi5nSAxTwhZTwchxlNt0JYzz6RgEXHKtioD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3PxYLwZEgVsXP9XC2Di8hGFAoLsEU77KkJvRmjyJx29jbtIBBNcQ/Zvd1bUvL/jzmzAORF/OfomL+24iHNRXdprCjFYSMbKDrRG1VxNQcLI/dRvHOfwQBRVOckkTA80llTEcsZCUekNkr5peiA3hUhEQQOAeyG0UvpqrmIy0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DNynfv49; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A324DE0011;
	Fri, 15 Mar 2024 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yx0wGhoCKKR0NqDBheYxgoW20rIDo8sjPDarWAgrdTI=;
	b=DNynfv491FuAHe5AwDyA6vZ1A7uXAvagyCefuAYE4qwxog4M9xv3D1Zez4RQWNcbZqLL/Q
	E2QxtXQz/Up4hN8GWEEK8Z2uwdHnCJt6VggJSwHEOuNRthS1On23nsJvVTrEHTitDAQ3sI
	OlMhdHKE4V8E013Fuy4/gkAsO6Be53YWUfP/7G+TLTD508ldtevYmC0bCvsEKov9HIzrSd
	2LFCTDPf7Snnz3tGRiJ5Qm9fx5gPLjeWVSP0eRmr1iu+WLgHaX4HF3wOpAAS59EqWkzgLV
	RKcnZeUUjunSZZVmEiqMti2lON9sssaBXmRBHRObMC77wpKC8mzwyZKYnr2xbw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 07/13] ASoC: ti: davinci-i2s: Add TDM support
Date: Fri, 15 Mar 2024 12:27:39 +0100
Message-ID: <20240315112745.63230-8-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

TDM is not supported by the McBSP driver. The McBSP datasheet does not
name explicitly TDM as a supported format but it is possible to configure
the McBSP to do TDM if all slots are used by McBSP.

Add TDM support. It uses single-phase frame. Slot width is used to
compute the McBSP's word length.

Implement the set_tdm_slot() hook of snd_soc_dai_ops struct. It only
supports TDM if all slots are used by McBSP.

The snd_soc_dai_driver's capture.channels_max is updated from 2 to 128.
128 is the maximum frame length when using single-phase frame.
playback.channels_max has not been updated as I could not test TDM on
playbacks with my hardware.

This was tested on platform designed off of DAVINCI/OMAP_L138 with BP_FC
format so this is only supported format for TDM yet. A check is done in
davinci_i2s_set_dai_fmt() to prevent TDM to be used with other formats

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 81 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index f4514d4dff07..4adaed010700 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -160,6 +160,9 @@ struct davinci_mcbsp_dev {
 	unsigned int fmt;
 	int clk_div;
 	bool i2s_accurate_sck;
+
+	int tdm_slots;
+	int slot_width;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -213,6 +216,57 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 	toggle_clock(dev, playback);
 }
 
+static int davinci_i2s_tdm_word_length(int tdm_slot_width)
+{
+	switch (tdm_slot_width) {
+	case 8:
+		return DAVINCI_MCBSP_WORD_8;
+	case 12:
+		return DAVINCI_MCBSP_WORD_12;
+	case 16:
+		return DAVINCI_MCBSP_WORD_16;
+	case 20:
+		return DAVINCI_MCBSP_WORD_20;
+	case 24:
+		return DAVINCI_MCBSP_WORD_24;
+	case 32:
+		return DAVINCI_MCBSP_WORD_32;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int davinci_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
+				    unsigned int tx_mask,
+				    unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+
+	dev_dbg(dev->dev, "%s - slots %d, slot_width %d\n", __func__, slots, slot_width);
+
+	if (slots > 128 || !slots) {
+		dev_err(dev->dev, "Invalid number of slots\n");
+		return -EINVAL;
+	}
+
+	if (rx_mask != (1 << slots) - 1) {
+		dev_err(dev->dev, "Invalid RX mask (0x%08x) : all slots must be used by McBSP\n",
+			rx_mask);
+		return -EINVAL;
+	}
+
+	if (davinci_i2s_tdm_word_length(slot_width) < 0) {
+		dev_err(dev->dev, "%s: Unsupported slot_width %d\n", __func__, slot_width);
+		return -EINVAL;
+	}
+
+	dev->tdm_slots = slots;
+	dev->slot_width = slot_width;
+
+	return 0;
+}
+
 #define DEFAULT_BITPERSAMPLE	16
 
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -228,6 +282,13 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
 
 	dev->fmt = fmt;
+
+	if ((dev->tdm_slots || dev->slot_width) &&
+	    ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_BP_FC)) {
+		dev_err(dev->dev, "TDM is only supported for BP_FC format\n");
+		return -EINVAL;
+	}
+
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -383,7 +444,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	master = dev->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
 	fmt = params_format(params);
-	mcbsp_word_length = asp_word_length[fmt];
+	if (dev->slot_width)
+		mcbsp_word_length = davinci_i2s_tdm_word_length(dev->slot_width);
+	else
+		mcbsp_word_length = asp_word_length[fmt];
+
+	if (mcbsp_word_length < 0)
+		return mcbsp_word_length;
 
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -483,8 +550,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
 	case SND_SOC_DAIFMT_BP_FC:
-		rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
-		xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
+		if (dev->tdm_slots > 0) {
+			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(dev->tdm_slots - 1);
+			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(dev->tdm_slots - 1);
+		} else {
+			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
+			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
+		}
 		break;
 	case SND_SOC_DAIFMT_BC_FC:
 	case SND_SOC_DAIFMT_BC_FP:
@@ -609,6 +681,7 @@ static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 	.hw_params	= davinci_i2s_hw_params,
 	.set_fmt	= davinci_i2s_set_dai_fmt,
 	.set_clkdiv	= davinci_i2s_dai_set_clkdiv,
+	.set_tdm_slot   = davinci_i2s_set_tdm_slot,
 
 };
 
@@ -621,7 +694,7 @@ static struct snd_soc_dai_driver davinci_i2s_dai = {
 	},
 	.capture = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 128,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = DAVINCI_I2S_FORMATS,
 	},
-- 
2.43.2


