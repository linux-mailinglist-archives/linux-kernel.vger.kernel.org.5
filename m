Return-Path: <linux-kernel+bounces-33962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C98370FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DDC2951D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DCA47F63;
	Mon, 22 Jan 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmR4wQPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008B47A6A;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947508; cv=none; b=aablPb5KF2tGeqM6T2YlUDL/SC8D2wX/ww14miKoQasH03AA1JYKv4Jq9iduZ1sjvwtgfgMNXXYquGu6HpzeL4ZqMpHQSQ92SbUP2W8KDpZ73sLw1fIYAko/a/wvQwBQWpPl1jVKgyriDtxPCISMtnrW+8ibLqbuKOoSv6mCL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947508; c=relaxed/simple;
	bh=6XwbyJxxFtTrLcIF9O68ZPB8kPUWDbYsKcVldHRoldY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYSyKDbanwgWIrT8z2wbg9E7Wga+3LaO93cVt6FPk1vv/8K6LZN9y9tBTNfSg9sUi5mDP4cAxYGJxy1K4HiLAfXsZLjCoe+Hx9gZfFx7DomMBjB/6Y+uDZOhVHfWIhNc19ARVYsfl+s6cBa4ecU+XRqAAYtlNF+gO+5Z+WB1HMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmR4wQPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36253C43609;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947508;
	bh=6XwbyJxxFtTrLcIF9O68ZPB8kPUWDbYsKcVldHRoldY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmR4wQPe2Qzsh6OpOQa0RHfxFqSZ247JgYaXjYka8c6T7mgGH+CrXX/RTOmOl1AoF
	 sOIXz0ZwirMlQTR09kPZOHtYE5l/WbWStwvIySAO1BmEGl65O6lNn+c+KZEVBKiSLk
	 gA6W+k+ExgxbYrIVgGMIyEVDxhU0XH4OYaPvRyzI4NlACq7YyP/7Zq21GUs9RR6JjO
	 /joGJaQyJIiivyMr8i0hcVWzDCfRgWKjWtlQleL7ZNlejy5corZwHU4C4FJEvFrS55
	 EMaWwmmde+jJOgv6xwl+5m52PN+/6ndY6wxcogBLkKH1wRDcdqCauSwsNUZBwf9poJ
	 Mr3wru/a86blw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRysa-0000000013Z-2VaM;
	Mon, 22 Jan 2024 19:18:40 +0100
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
Subject: [PATCH v5 4/4] ASoC: codecs: wcd9335: drop unused gain hack remnant
Date: Mon, 22 Jan 2024 19:18:19 +0100
Message-ID: <20240122181819.4038-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122181819.4038-1-johan+linaro@kernel.org>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor driver appears to be modifying the gain settings behind the
back of user space but these hacks never made it upstream except for
some essentially dead code that adds a constant zero to the current gain
setting on DAPM events.

Note that the volume registers still need to be written after enabling
clocks in order for any prior updates to take effect.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.43.0


