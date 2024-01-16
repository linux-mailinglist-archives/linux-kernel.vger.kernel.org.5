Return-Path: <linux-kernel+bounces-27188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F482EBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3AFB22421
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8E134DB;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajxrKBJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13512B9E;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D27C433F1;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=Bedn57ruaI8vaei65DA95W6x7hJEXXYsGj9Dv4JJWYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajxrKBJf6arEbXQ5f+gdeuNkpLXGzIqLvQQdw3sG/5LMMyliy+LcghBsTF1EmTMtB
	 5Z7z/GsF1PxKqo92QXGMQ05T80pQuspKYoSFy3mtMbnt2o/3fEkEvSTvwZ60yXEib7
	 nxbFZd6eZ4h+bK3isUAyFF5Q4FyHOibE7cmAoYm5DxtHSgKqAkieC0L4RK6qbG3AaP
	 ldSM62IlYcOAGnhYSzL3dzYgjgW72qEXrjl2E1+z0Ke5XDzPavveJUnMR6zzUskjId
	 i1nJQL3AwaodK1RWP5qBFz0PLi5X4p/h7AuY0jZFBp+uQnpo0YyLOKZDKU3ILT1tdH
	 nOh4DZwqHYJGA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053X-1Q;
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
Subject: [PATCH 4/7] ASoC: codecs: lpass-rx-macro: drop dead mixer-path gain hack
Date: Tue, 16 Jan 2024 10:39:00 +0100
Message-ID: <20240116093903.19403-5-johan+linaro@kernel.org>
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

The vendor driver modifies the gain settings behind the back of user
space but some of these hacks never made it upstream except for some
essentially dead code that reads out the (cached) gain setting and
writes it back again on DAPM events.

Drop the incomplete and pointless hack when enabling mixer paths.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index f35187d69cac..b1ec41eed851 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -1956,10 +1956,9 @@ static int rx_macro_enable_main_path(struct snd_soc_dapm_widget *w,
 					int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	u16 gain_reg, reg;
+	u16 reg;
 
 	reg = CDC_RX_RXn_RX_PATH_CTL(w->shift);
-	gain_reg = CDC_RX_RXn_RX_VOL_CTL(w->shift);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1969,10 +1968,6 @@ static int rx_macro_enable_main_path(struct snd_soc_dapm_widget *w,
 						      CDC_RX_PATH_CLK_EN_MASK,
 						      CDC_RX_PATH_CLK_ENABLE);
 		break;
-	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_component_write(component, gain_reg,
-			snd_soc_component_read(component, gain_reg));
-		break;
 	case SND_SOC_DAPM_POST_PMD:
 		rx_macro_enable_interp_clk(component, event, w->shift);
 		break;
@@ -3031,16 +3026,13 @@ static const struct snd_soc_dapm_widget rx_macro_dapm_widgets[] = {
 
 	SND_SOC_DAPM_MUX_E("RX INT0_1 INTERP", SND_SOC_NOPM, INTERP_HPHL, 0,
 		&rx_int0_1_interp_mux, rx_macro_enable_main_path,
-		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_POST_PMD),
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT1_1 INTERP", SND_SOC_NOPM, INTERP_HPHR, 0,
 		&rx_int1_1_interp_mux, rx_macro_enable_main_path,
-		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_POST_PMD),
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT2_1 INTERP", SND_SOC_NOPM, INTERP_AUX, 0,
 		&rx_int2_1_interp_mux, rx_macro_enable_main_path,
-		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_POST_PMD),
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_MUX("RX INT0_2 INTERP", SND_SOC_NOPM, 0, 0,
 			 &rx_int0_2_interp_mux),
-- 
2.41.0


