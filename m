Return-Path: <linux-kernel+bounces-31092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B688328BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B181C1F23635
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DA4D111;
	Fri, 19 Jan 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhJkk+cM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58A4CB4F;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663615; cv=none; b=mMiBqZkbf4ThSVoO4OgvGE1trc91th3yvyQE16O6N6ACxayIDA9L1rdeFld214qdnud2BARAwkxDuPE4NA8aYnVLADMsIrcpuetXBhHpCFEHnienVOiAvX6uJz5fmuV69xTEFCv23DmcrH+EN7xmF+rDCyEFh8lZJhEcCWjV5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663615; c=relaxed/simple;
	bh=l7DGGpCso7bX08YQvGfXDvfIrpjxnzkTzOG8xe3VBVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1XnosuyqUw/57+D/NCmNMhVeETF/uX26unSt0YiBtqkrC1HyB3MVhTBMio2xd79ixV/8TJaVlNKnOQNQt0M2/oxORdKOT1injmp1F5zKIuDS5QDgo0ykaAbAVkF7GalNJt2NNGFTOBVL1PGCjoE8pjJkgUFmHQ6ZZBa9S1UeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhJkk+cM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A93C433A6;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663615;
	bh=l7DGGpCso7bX08YQvGfXDvfIrpjxnzkTzOG8xe3VBVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhJkk+cMaTlopP1irGiiDq13+a7TBtsEZ6otbU7M/ljnD1V55EZePRM0XtewkayqI
	 UeyqWcv6XBo//CpsOZwirvLsTenlMeTkrtCq5RBz0m3/3MavweFxj46tRj0ADjKj3d
	 2aYFpqtsrJs2973P54qVLkBGOjt4BhDhLSuAk8B+PEMpXz6ZDiJmjn867D1dLYq7rs
	 7Qq56OAjruTuHV18kW0T0U5hhu4P+hodxMSfJbQmuunEBxbA+iAgyFVZbhwsi9fa85
	 qMZgPi//RtVTz9TFUE5gc7viZH2lk2UINQbmIX349Lfd+KejHhSCNhdrph5rUardAc
	 eVBmMXD2G+KvQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQn1b-0001xN-3C;
	Fri, 19 Jan 2024 12:27:04 +0100
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/4] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
Date: Fri, 19 Jan 2024 12:24:19 +0100
Message-ID: <20240119112420.7446-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119112420.7446-1-johan+linaro@kernel.org>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LPASS WSA macro codec driver is updating the digital gain settings
behind the back of user space on DAPM events if companding has been
enabled.

As compander control is exported to user space, this can result in the
digital gain setting being incremented (or decremented) every time the
sound server is started and the codec suspended depending on what the
UCM configuration looks like.

Soon enough playback will become distorted (or too quiet).

This is specifically a problem on the Lenovo ThinkPad X13s as this
bypasses the limit for the digital gain setting that has been set by the
machine driver.

Fix this by simply dropping the compander gain offset hack. If someone
cares about modelling the impact of the compander setting this can
possibly be done by exporting it as a volume control later.

Note that the volume registers still need to be written after enabling
clocks in order for any prior updates to take effect.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: stable@vger.kernel.org      # 5.11
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 7e21cec3c2fb..6ce309980cd1 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1584,7 +1584,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 	u16 gain_reg;
 	u16 reg;
 	int val;
-	int offset_val = 0;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
 	if (w->shift == WSA_MACRO_COMP1) {
@@ -1623,10 +1622,8 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
 					CDC_WSA_RX_PGA_HALF_DB_MASK,
 					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
-			offset_val = -2;
 		}
 		val = snd_soc_component_read(component, gain_reg);
-		val += offset_val;
 		snd_soc_component_write(component, gain_reg, val);
 		wsa_macro_config_ear_spkr_gain(component, wsa,
 						event, gain_reg);
@@ -1654,10 +1651,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
 					CDC_WSA_RX_PGA_HALF_DB_MASK,
 					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
-			offset_val = 2;
-			val = snd_soc_component_read(component, gain_reg);
-			val += offset_val;
-			snd_soc_component_write(component, gain_reg, val);
 		}
 		wsa_macro_config_ear_spkr_gain(component, wsa,
 						event, gain_reg);
-- 
2.41.0


