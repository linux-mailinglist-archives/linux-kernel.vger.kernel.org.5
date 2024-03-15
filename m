Return-Path: <linux-kernel+bounces-104342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E382B87CC57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE75B223C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF1374EC;
	Fri, 15 Mar 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ors2H1q9"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAB288CF;
	Fri, 15 Mar 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502092; cv=none; b=BdU237YfCmBGPTlv6H0Pvmaj7Ka5QgLNQa3Yruo8FLa6dMqfCUWzTTNSRWwaryyIhnBvonSHj6jyJlMrzNeKbnUa6cmwPrPOIlve4E8GrDi9mVbwpmHnYtMYf9eJvrPoDioouL+ZDUHUyhwT3x9nxeCIHs4AFC1iUufEBsDxEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502092; c=relaxed/simple;
	bh=tiG1anIwJmGks5IJ0snXqu0mldVVMpJ+/7sMXbGSGZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MET7szesxQhN3cRS0gq0crSNdE3rUqOs+91J0ImTc1nS4XRDDo6Oh+O6zZEYemsaRW4waaAvl1j7bXNuaG1cgnzLOsBWFLZjMrdn2TFk1AAEqcn0Jlxqeo7NJCgdvI20kWHh+SSPVkS/sZziW33tszbWD/rm8jcg58Y7ZhC+G2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ors2H1q9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BB0DAE0006;
	Fri, 15 Mar 2024 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UC3LFE9iQk44oAEepOsnaMuAe4UaFfXnY3Wv95ahIcU=;
	b=ors2H1q93yIavTqvTxO2+ezzZGIR3PHeFDto3uGs3gMYAxkCg3D73uUBl+Pha3DYfmnNZi
	9mDGgDc8F4hNbaRQDa9ZUKJHduQMCJOuvGjKYn+yhFJXpHQBTybeRFA05ZsZhCSefT4GEr
	/8ho2AMjLy1mreLRDzNIaCa26GTR1wey3/P1HorIfj0ens1kcDdZxCu8JcEBtuAubd6K/e
	0md0/5Oku8eOPmLbn63Zjde9cmK9jiITb3FcTAkNjB1jPQPiLMAz3C7xn5Cy0LymMZNXGI
	QBnUl7njGZDW9zmTIdBJEF9Jd1aCS7fQuxYmNFA6sHwSmvYaNudaB/We+JytbQ==
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
Subject: [PATCH 10/13] ASoC: ti: davinci-i2s: Make free-running mode optional
Date: Fri, 15 Mar 2024 12:27:42 +0100
Message-ID: <20240315112745.63230-11-bastien.curutchet@bootlin.com>
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

McBSP has free-running mode where serial clocks continue to run during
emulation halts. This mode is always enabled by the driver.

Disable this free-running mode according to the 'ti,disable-free-run'
device-tree property.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 2c19e45b6b54..67307e75f2a8 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -165,6 +165,7 @@ struct davinci_mcbsp_dev {
 	int slot_width;
 
 	bool sync_err;
+	bool free_run;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -444,11 +445,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (dev->free_run)
+		spcr |= DAVINCI_MCBSP_SPCR_FREE;
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	} else {
-		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
@@ -766,6 +769,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->base = io_base;
 
+	dev->free_run = !of_property_read_bool(pdev->dev.of_node, "ti,disable-free-run");
 	dev->sync_err = of_property_read_bool(pdev->dev.of_node, "ti,enable-sync-err");
 
 	/* setup DMA, first TX, then RX */
-- 
2.43.2


