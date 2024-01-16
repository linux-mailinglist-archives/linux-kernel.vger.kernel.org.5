Return-Path: <linux-kernel+bounces-27187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B61182EBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22621C204F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4230134D9;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEFze6N4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853F12B9C;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F57C43399;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=oXGwkRr+pTlA9URBIwOHy4z7wRIJRjTwPvC7AmtNWLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEFze6N4PSjBVOpIiLLK/f83TnQUY8KnW+bXk41i5ZwRMx+uL92kX5IrTEkGBUvAZ
	 CCPGl+2c8pglScIUg6cfgA5+RVown6mGlOndo3JKfwERmpNyzCcqVuQANikyw/a6BB
	 ym6vhp3tGMM0RUJGqmnYHp57oi88a7wf1zV1EeZN8VvpxvOPvUxeJcq0ajXBoXV9mF
	 Vl+dKHikM3b9KW8Im9pckTXN3V0a3ctomNYM0ARsPmZHIAYY2bwn/eJrZHRNEI22pA
	 AlLgkGD7gGuJZ+/lAyKt7GuVs+xwmUIoT6zrAyfXy8K+IcIXJgDJ6hR51lNpEcPfiI
	 JbteXyN7ybXww==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053d-2G;
	Tue, 16 Jan 2024 10:39:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 7/7] ASoC: codecs: msm8916-wcd-digital: drop dead gain hacks
Date: Tue, 16 Jan 2024 10:39:03 +0100
Message-ID: <20240116093903.19403-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240116093903.19403-1-johan+linaro@kernel.org>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor driver appears to be modifying the gain settings behind the
back of user space but these hacks never made it upstream except for
some essentially dead code that reads out the (cached) gain setting and
writes it back again on DAPM events.

Drop these incomplete and pointless hacks.

Note that seemingly related 10 ms delay after enabling the interpolator
is removed in the process.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 978c4d056e81..f73731aa4b58 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -228,17 +228,6 @@ struct msm8916_wcd_digital_priv {
 	struct clk *ahbclk, *mclk;
 };
 
-static const unsigned long rx_gain_reg[] = {
-	LPASS_CDC_RX1_VOL_CTL_B2_CTL,
-	LPASS_CDC_RX2_VOL_CTL_B2_CTL,
-	LPASS_CDC_RX3_VOL_CTL_B2_CTL,
-};
-
-static const unsigned long tx_gain_reg[] = {
-	LPASS_CDC_TX1_VOL_CTL_GAIN,
-	LPASS_CDC_TX2_VOL_CTL_GAIN,
-};
-
 static const char *const rx_mix1_text[] = {
 	"ZERO", "IIR1", "IIR2", "RX1", "RX2", "RX3"
 };
@@ -580,12 +569,6 @@ static int msm8916_wcd_digital_enable_interpolator(
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		/* apply the digital gain after the interpolator is enabled */
-		usleep_range(10000, 10100);
-		snd_soc_component_write(component, rx_gain_reg[w->shift],
-			      snd_soc_component_read(component, rx_gain_reg[w->shift]));
-		break;
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_component_update_bits(component, LPASS_CDC_CLK_RX_RESET_CTL,
 					      1 << w->shift, 1 << w->shift);
@@ -630,9 +613,6 @@ static int msm8916_wcd_digital_enable_dec(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_mux_ctl_reg,
 				    TX_MUX_CTL_HPF_BP_SEL_MASK,
 				    TX_MUX_CTL_HPF_BP_SEL_NO_BYPASS);
-		/* apply the digital gain after the decimator is enabled */
-		snd_soc_component_write(component, tx_gain_reg[w->shift],
-			      snd_soc_component_read(component, tx_gain_reg[w->shift]));
 		snd_soc_component_update_bits(component, tx_vol_ctl_reg,
 				    TX_VOL_CTL_CFG_MUTE_EN_MASK, 0);
 		break;
@@ -739,13 +719,13 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	/* Interpolator */
 	SND_SOC_DAPM_MIXER_E("RX1 INT", LPASS_CDC_CLK_RX_B1_CTL, 0, 0, NULL,
 			     0, msm8916_wcd_digital_enable_interpolator,
-			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			     SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MIXER_E("RX2 INT", LPASS_CDC_CLK_RX_B1_CTL, 1, 0, NULL,
 			     0, msm8916_wcd_digital_enable_interpolator,
-			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			     SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MIXER_E("RX3 INT", LPASS_CDC_CLK_RX_B1_CTL, 2, 0, NULL,
 			     0, msm8916_wcd_digital_enable_interpolator,
-			     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			     SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("RX1 MIX1 INP1", SND_SOC_NOPM, 0, 0,
 			 &rx_mix1_inp1_mux),
 	SND_SOC_DAPM_MUX("RX1 MIX1 INP2", SND_SOC_NOPM, 0, 0,
-- 
2.41.0


