Return-Path: <linux-kernel+bounces-33963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BA8370E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B051C22EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BB47F66;
	Mon, 22 Jan 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lImPn0vA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005B47A64;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947508; cv=none; b=q0vD1qPeHJ/ITKEqQ6Jqn5GXlcU2YmFDN9h2N604VbZlCwTRd6ClrAol4uJJg2A79y6/OemrhJuBHZ0LgSV8JGWpDk0ulnWEr1ehvDk2GCmeZCRCS4OLb4NZ/b+ufvuOgZ73QNgdfg8KP8S8el8EITnGYivDX8O8PKVsnZV2ON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947508; c=relaxed/simple;
	bh=Lh26btgQP3JMyEbw/WcBqZn6EmesDwfSrRfDbLyisSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc4umBOfM6mO0Fo2xP+K0lRxytACWIHGOvSr9cfDkpVmlm+5/DhlxfLVcKCHKJZ091PtrKjXctIsAUBznzZIwaHPqPP9jOVfcd7UXe1q9VeCjwN3fqvzOOjChRGK9azO5zyTRJWACXdDcAC2s9nZ+0Lpiqph+/GWNcT9Nu9Luqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lImPn0vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B90C433B2;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947508;
	bh=Lh26btgQP3JMyEbw/WcBqZn6EmesDwfSrRfDbLyisSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lImPn0vAhkzpA6lJL6Q/O4/xwKx2Evk+EErvcYTyArIU9MFB5m0KoQBBnnbBulKnz
	 dwWEaMKrfTqLpcOaUrkDHZ8La/1p0L78UGyR9kOwsmSi/qjI6+mATjrJfCn1vyfhQW
	 EX1W3Lz+VFJtzJfypQNClv2tPkfDp1cLZ7kccwl0IsKAy0vLjV3Qu7UBZy05Nwt3vr
	 7CMiXciPrqD4pyLunXeVc9VeDyFS8UcJQtC5d9PM+XpGEroAdjMsL+uj/uDR5+SF24
	 dYS+bNVCU7MHMn4+IrkjC25WP3bY+vW0PkjDp7iA0i1hPIfSFsmWDrZ9hTd3qxFZT9
	 SdNb4Fk9LbKhw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRysa-0000000013X-2DzD;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/4] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
Date: Mon, 22 Jan 2024 19:18:18 +0100
Message-ID: <20240122181819.4038-4-johan+linaro@kernel.org>
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
2.43.0


