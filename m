Return-Path: <linux-kernel+bounces-28687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44938301DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D91D1F268EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3F14277;
	Wed, 17 Jan 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/HNpbZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391714002;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482224; cv=none; b=XMWWddm21l45L3C4phYvr0qMF4ne/Bx35briSnrqCvdT6ayGEPE1uxThpdfiOz+/YYczly3CPyGMjxAHtkReyn/zUK3QqV6X/Ig5J2NjT/+Nk2ox1q4Nu/LMXdOp+WkgZCIXKWmwMuWDzW0PnCdJto6v1E2r1GhDSwe//MHJdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482224; c=relaxed/simple;
	bh=l7DGGpCso7bX08YQvGfXDvfIrpjxnzkTzOG8xe3VBVk=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=b2L1xI0r05QMH+7VLsztpxk6mfG0IzeRzNEZ3JhHCC9s1XRRMrVbqm5dC0L18jBXnBMZLks/M0JuXMHpKVBsbRPNFOyX19iWL0+oTzrGVq4NDTFhFPWkn4lUZEr8hqC+9w9Slvgfg92qyZlpWTW70jrnq8z6NdUjIHnI0xeXfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/HNpbZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA95C43390;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482224;
	bh=l7DGGpCso7bX08YQvGfXDvfIrpjxnzkTzOG8xe3VBVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/HNpbZGrfbAT3q2jXppVUPeibMPSrHpQGFDwjq9X7e77lqAhcVCXQOtPAWynwfsm
	 0McWzvFtXOpJLL+PgsIuaj7P1Tkwv9Sv9S5lf7jIoL+U2p8LtIJ/Gq+dhu8c/4XDve
	 J2agzb07jUmA3XTb7fZ7pYeyHrJt+bmysAS+oA10d55K/mOOezsjn+PjqudEHz+Oda
	 CcosS1+qu5BVsJFVpip0kVWav3TU1jmelziY20pqKvDDgUAmOrD40S1RfVv3udz5sX
	 NOOQmwLBunfxQSxFZHTRFBe7U8eNYfDIsdQOAZsMFlN8LQoXnhbzsNALsrPrfaiC5g
	 u98tTjQjFzAPA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQ1pt-00086W-0L;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
Date: Wed, 17 Jan 2024 10:03:30 +0100
Message-ID: <20240117090331.31111-3-johan+linaro@kernel.org>
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


