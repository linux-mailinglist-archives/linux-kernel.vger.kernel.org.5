Return-Path: <linux-kernel+bounces-28686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6B8301D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4EE1F26942
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC314275;
	Wed, 17 Jan 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEHLmJHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E614000;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482224; cv=none; b=d+FDbz0HTEYvdcl607TSIOP1D21q/puSkew5GBW2YEyD4YfPxRg3v2FJeZXLLgOfxgJNIIB24SMokPzHpT7nlldf/9VvtsLVLlrY5yLzpABcnOSzozASgcsNO3pqDeqBExB/YvQ4GLXrLpsPpzA0Q6N2OUfaSZzRv86eZ5JqPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482224; c=relaxed/simple;
	bh=vEtn9XD7xyubHLGGICH9x1XRbBU8Muy2s+oZUo5w6Zc=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=b3EnNd+pqpDO/8N/lkolsTjWZ0tUJCWSqnT/OCFw27eHcTSC74WJcRoi60SqPVa1IMk4gyF3k4Y6eKljzM42m8XZ1wrsBvu40xjxOIi5s3ChEd5OJhWvFK1U0RGAJVVF7cR9MZyZRZJba/rKXyjjiRIQIaaTsV4/sGxm8Qbe0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEHLmJHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50DC43394;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482224;
	bh=vEtn9XD7xyubHLGGICH9x1XRbBU8Muy2s+oZUo5w6Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEHLmJHoFnVJOtBCMyEqHJ7tYtCFYxtXYlp6KjBLXwAoLviq6KXa2J33VefHQsH5N
	 RJHheVMGHfnUDlMf1IZhJQ3OTcPa5T5R5r+huyTsxRKJurmZWA6MNfc/Qxulfnr0fR
	 S+JJH9NETF28J/AAsfq929kjrcK5p0HlY1yguZ2mrZjUd+K5C2GL9DIHYKPvmzgt3s
	 NxpmdkBj+OLvgzGaPj68JFyRYne7FQeh7tP+Wp1jUMGZDrVmqVqGSs/8cN8rDrPUZ0
	 VLeuOrCIv6whNLKISOaGRHA/ABShs/L0/X9Wke+QtxFxpsXC4aY0FiBKOKSiZOs1Wl
	 7cAyQpSy2hITg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQ1pt-00086Y-0d;
	Wed, 17 Jan 2024 10:03:49 +0100
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
Subject: [PATCH v2 3/3] ASoC: codecs: wcd9335: drop unused gain hack remnant
Date: Wed, 17 Jan 2024 10:03:31 +0100
Message-ID: <20240117090331.31111-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117090331.31111-1-johan+linaro@kernel.org>
References: <20240117090331.31111-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor driver appears to be modifying the gain settings behind the
back of user space but these hacks never made it upstream except for
some essentially dead code that adds a constant zero to the current
settings on DAPM events.

Note that the volume registers still need to be written after enabling
clocks in order for any prior updates to take effect.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 43c648efd0d9..deb15b95992d 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3033,7 +3033,6 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	u16 gain_reg;
-	int offset_val = 0;
 	int val = 0;
 
 	switch (w->reg) {
@@ -3073,7 +3072,6 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		val = snd_soc_component_read(comp, gain_reg);
-		val += offset_val;
 		snd_soc_component_write(comp, gain_reg, val);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
@@ -3294,7 +3292,6 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 	u16 gain_reg;
 	u16 reg;
 	int val;
-	int offset_val = 0;
 
 	if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT0 INTERP"))) {
 		reg = WCD9335_CDC_RX0_RX_PATH_CTL;
@@ -3337,7 +3334,6 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		wcd9335_config_compander(comp, w->shift, event);
 		val = snd_soc_component_read(comp, gain_reg);
-		val += offset_val;
 		snd_soc_component_write(comp, gain_reg, val);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-- 
2.41.0


