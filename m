Return-Path: <linux-kernel+bounces-104341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D909E87CC55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B541282AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B552E636;
	Fri, 15 Mar 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EiiBBzN9"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B045241E0;
	Fri, 15 Mar 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502090; cv=none; b=ccAe0mAiwq7muYeTZCHcSFilfuVySPlRoY/ox4p0AFbh7GLVBwHDC0DRcC9KFFB6d+yskhtWcMiXKzVyXEexTwrGC0MK3Z05kKT0SinFU2F5771FAiid/irr+AzmnloEIFFK06GbnUS2m/DQ+HXNCNACdOFGZKFk7pvD1czwEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502090; c=relaxed/simple;
	bh=UUEMGYTWx7hSbIotL4/4C7MIZafTER3ZfeVzf1vYOUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UljVA5fpbxwgjBxA+h//30mqDxjbshJB8IFjeozCw4XgQYbi8VM9X7Zl/hbYoNpu2+7pzAYgrDsaIwmaR1RWHz5I8Eg90zeatX3t9GViWlH0G2WGa5Vlnke+oNojJer7PkoJ919kzlk1Tld0xeCKt7hkB3dJWa/U07ZRIfwxHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EiiBBzN9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 54481E0002;
	Fri, 15 Mar 2024 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVFVDw+1H0r8Xsrvu6KZ3OKr5htVuJOvlACpebRa/Dc=;
	b=EiiBBzN95HqvkJVIx018Xh4otOv/gqgzfN6yZ94Kt4PHXhlq9JEosn/xu6UFUnKbljyv3C
	d0JCnQkmekizZ208iSbdvbfBnwfIoNit9aQLFyb+9WhtzMXFpAaOsl0oH4KuxVxL7t8omr
	KZU8Bbc5LZcVFaOA9f1s6/okWfCUAebbzTv8duG6mrdssmpDg9Oum1eN/D5cprdwC8+DoB
	yAz1xpTGEe3BsUTJWSym2KWuSHU8PMZnsrock1eB/7yQM8HSGowbYos+FOXFRMBQd6ekgA
	Qeq6nSG9y8z5PirFvKnBKRzoVCdOZ7vuqfoyS0t4qznc1aC4Mf4OA+V5zRZSPg==
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
Subject: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
Date: Fri, 15 Mar 2024 12:27:41 +0100
Message-ID: <20240315112745.63230-10-bastien.curutchet@bootlin.com>
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

McBSP can generate an SYNCERR when unexpected frame pulses are
detected. The driver always disables this feature and ignore the
unexpected frame pulses.

Enable the generation of SYNCERR by the McBSP according to the
'ti,enable-sync-err' device-tree property.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 7cdd86f47ead..2c19e45b6b54 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -163,6 +163,8 @@ struct davinci_mcbsp_dev {
 
 	int tdm_slots;
 	int slot_width;
+
+	bool sync_err;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -432,8 +434,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length, master;
-	unsigned int rcr, xcr, clk_div, freq, framesize;
+	unsigned int clk_div, freq, framesize;
 	unsigned int srgr = 0;
+	unsigned int rcr = 0;
+	unsigned int xcr = 0;
 	u32 spcr;
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
@@ -530,8 +534,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 
-	rcr = DAVINCI_MCBSP_RCR_RFIG;
-	xcr = DAVINCI_MCBSP_XCR_XFIG;
+	if (!dev->sync_err) {
+		rcr |= DAVINCI_MCBSP_RCR_RFIG;
+		xcr |= DAVINCI_MCBSP_XCR_XFIG;
+	}
 	if (dev->mode == MOD_DSP_B) {
 		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(0);
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(0);
@@ -760,6 +766,8 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->base = io_base;
 
+	dev->sync_err = of_property_read_bool(pdev->dev.of_node, "ti,enable-sync-err");
+
 	/* setup DMA, first TX, then RX */
 	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->addr = (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
-- 
2.43.2


