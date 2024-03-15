Return-Path: <linux-kernel+bounces-104335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4C87CC47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA851C213C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C01C29C;
	Fri, 15 Mar 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kTyKJc4y"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A421B80C;
	Fri, 15 Mar 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502083; cv=none; b=pTRJa85o0G52D1JK9y+kf9RvRhQLBw2Z3siele8sjJX+0Cw/ZEUQQ1ny/nnEKxvW4Yq+L9/svbbmhDKzfbAKfivxmky8xF4Zn95uAn4cDviayRLKuDK2zcYJ5GxUW9UcgCr4dpb2KclAIQkeTe8dHe7v6VAbyE61Lq6VPcRJpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502083; c=relaxed/simple;
	bh=xf2gnirs9NBtEZ1Xk3wbbzWcel2ZGkgx1esK1/Rn/mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi+7T6MwbH5Zo7XlufPZyg1u92vyI5jpeVuxVzofdP1EQfaW9yColbo5L3glFRgM8CHXgkmRAuu1jwLRG4HKxOTRTwzqC+b66Ev/i0wrBEqZq+KZh34HET2B/G9UeHsRkRedojDX1ZK8BXFnfTt3tlifzNAFWMsm0qYJJOhNusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kTyKJc4y; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2E639E0006;
	Fri, 15 Mar 2024 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oS6/v1Kh5XV6ssrnHrgLVDsnztMrvT6ht6wxi9TnOcg=;
	b=kTyKJc4y0z+lIgkuSyNi01osbBGdO7ZLmmuvrb8zXyHQ90gw0aOZSI4oSB9yE09emHWDoY
	MisZ0sKNhK5wnsX/tn9A0gZAoMXMN3NOfujWFB9CACbamn37dSavFNnRu9xbjzbaQbX6i8
	ltUlnqKfBRI06fXUgBmfeVetBTydwntSgQEz7Aq3GBxEqx8LQnJ+XcJk/4Wqu8xb4qCrWH
	m+sAE96bTNbbLDcDCFXJ8227GRAvPXBewgxQNxK9cdEQySCYBFZgxkcdl2PtahmhLbX0T2
	9Z/UBf3J/LHX9belXvrDI95Qlx8RT9o5N2Fwwv09n6BjatqjcsXcvZzU9h/2qQ==
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
Subject: [PATCH 03/13] ASoC: ti: davinci-i2s: Remove the unused clk_input_pin attribute
Date: Fri, 15 Mar 2024 12:27:35 +0100
Message-ID: <20240315112745.63230-4-bastien.curutchet@bootlin.com>
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

The clk_input_pin attribute of davinci_mcbsp_dev struct is not set since
commit 257ade78b601 ("ASoC: davinci-i2s: Convert to use edma-pcm").

Remove the attribute.
Keep the behaviour of the MCBSP_CLKR case as MCBSP_CLKR == 0.
I can't test the BC_FP format so I added back the initial comment that
was removed by commit ec6375533748 ("ASoC: DaVinci: Added selection of
clk input pin for McBSP"). This was the last dependency to
linux/platform_data/davinci_asp.h so it is not included anymore.

Remove the enum mcbsp_clk_input_pin from davinci_asp.h as it is not used
anywhere else.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 include/linux/platform_data/davinci_asp.h | 15 --------------
 sound/soc/ti/davinci-i2s.c                | 24 ++++-------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index c8645b2ed3c0..b9c8520b4bd3 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -25,16 +25,6 @@ struct davinci_mcasp_pdata {
 	unsigned sram_size_capture;
 	struct gen_pool *sram_pool;
 
-	/*
-	 * If McBSP peripheral gets the clock from an external pin,
-	 * there are three chooses, that are MCBSP_CLKX, MCBSP_CLKR
-	 * and MCBSP_CLKS.
-	 * Depending on different hardware connections it is possible
-	 * to use this setting to change the behaviour of McBSP
-	 * driver.
-	 */
-	int clk_input_pin;
-
 	/*
 	 * This flag works when both clock and FS are outputs for the cpu
 	 * and makes clock more accurate (FS is not symmetrical and the
@@ -91,11 +81,6 @@ enum {
 	MCASP_VERSION_OMAP,	/* OMAP4/5 */
 };
 
-enum mcbsp_clk_input_pin {
-	MCBSP_CLKR = 0,		/* as in DM365 */
-	MCBSP_CLKS,
-};
-
 #define INACTIVE_MODE	0
 #define TX_MODE		1
 #define RX_MODE		2
diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 07c8b2259208..5c906641640e 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/platform_data/davinci_asp.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -159,7 +158,6 @@ struct davinci_mcbsp_dev {
 
 	unsigned int fmt;
 	int clk_div;
-	int clk_input_pin;
 	bool i2s_accurate_sck;
 };
 
@@ -239,26 +237,12 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			DAVINCI_MCBSP_PCR_CLKRM;
 		break;
 	case SND_SOC_DAIFMT_BC_FP:
-		pcr = DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCBSP_PCR_FSXM;
 		/*
-		 * Selection of the clock input pin that is the
-		 * input for the Sample Rate Generator.
-		 * McBSP FSR and FSX are driven by the Sample Rate
-		 * Generator.
+		 * McBSP CLKR pin is the input for the Sample Rate Generator.
+		 * McBSP FSR and FSX are driven by the Sample Rate Generator.
 		 */
-		switch (dev->clk_input_pin) {
-		case MCBSP_CLKS:
-			pcr |= DAVINCI_MCBSP_PCR_CLKXM |
-				DAVINCI_MCBSP_PCR_CLKRM;
-			break;
-		case MCBSP_CLKR:
-			pcr |= DAVINCI_MCBSP_PCR_SCLKME;
-			break;
-		default:
-			dev_err(dev->dev, "bad clk_input_pin\n");
-			return -EINVAL;
-		}
-
+		pcr = DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCBSP_PCR_FSXM;
+		pcr |= DAVINCI_MCBSP_PCR_SCLKME;
 		break;
 	case SND_SOC_DAIFMT_BC_FC:
 		/* codec is master */
-- 
2.43.2


