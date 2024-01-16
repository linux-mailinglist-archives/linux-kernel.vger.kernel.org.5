Return-Path: <linux-kernel+bounces-27192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF982EBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE02282EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957A1B7FA;
	Tue, 16 Jan 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srMWK9ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAD134A1;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E34AC43330;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=mnsvv8nLXcpID7aeu/iuGLMoF7xZR5DEBr8yX7bAx7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srMWK9ab1BIYiHFwgI2B2+w1VwIwAs5MRYycieUR/UqX2/NlVT1DqOvkuvQZFwuI2
	 1NZ2CkD1LX+bjLz1x75526r3oggFIXzPzVbwpcvY8bkZ0enYTmIiSJkDxokVwWjG96
	 U8HrIVW/M0I9DB0vq0SxvTqBaZlewFzpm4DPwn9aF4cZIbXdETXpbmRThEmHC30v9M
	 ShVnMrj0oKVqRsfmLodGn59RPmz1aySjA3HTv9m5vGaUYvA9juNQGy+SiIkvVfMiUn
	 kfR3DcAi1pqcnjGTyglSKBEL70kFgKP0vqpqlwVChEWtub2LLiFsNMzCWuTg8UmEEI
	 yt2hpY6514q5Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053V-18;
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
Subject: [PATCH 3/7] ASoC: codecs: lpass-wsa-macro: drop dead mixer-path gain hack
Date: Tue, 16 Jan 2024 10:38:59 +0100
Message-ID: <20240116093903.19403-4-johan+linaro@kernel.org>
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
 sound/soc/codecs/lpass-wsa-macro.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 7de221464d47..36a8f1980c6e 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1220,27 +1220,20 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
 				     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	u16 path_reg, gain_reg;
-	int val;
+	u16 path_reg;
 
 	switch (w->shift) {
 	case WSA_MACRO_RX_MIX0:
 		path_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL;
-		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
 		break;
 	case WSA_MACRO_RX_MIX1:
 		path_reg = CDC_WSA_RX1_RX_PATH_MIX_CTL;
-		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
 		break;
 	default:
 		return 0;
 	}
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		val = snd_soc_component_read(component, gain_reg);
-		snd_soc_component_write(component, gain_reg, val);
-		break;
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_component_update_bits(component, path_reg,
 					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
-- 
2.41.0


