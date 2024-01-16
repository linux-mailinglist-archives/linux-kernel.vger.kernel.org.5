Return-Path: <linux-kernel+bounces-27189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0D82EBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2831C220FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFE134DE;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzZKRWMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CF12B9D;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFEFC43394;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=N8c8yQ8JoVaZ43ekrgFMJaI6nSmiX70JukNaBce+F1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzZKRWMrHhV/16BojQ69j2BghzEVFFRdYyUQsp9ne6dQpadmkTlTbx6LxBT483wRm
	 xDA1RCjOqZqOeb8D7WPBMXeUmEr/3z6qzsMYhBvuz2TZ2lsgL1xwFomapPg2QcNnan
	 OTGBQem22S3QJ5C0gZUdmpIyeIdd8fsUi05I3wt0MqJc1xJpEQTCkg8UI11YOx60LI
	 O4esH6VYlFUFOX1I57ZFeeC9ma3NFmTyINVkDozvRZY2rSqV595p/9q7iS8mkE4UMb
	 KAnyQ0VYAmhNSRGjcVucA72rkvPu4TFzgB3HhyoB/c/InpqjOQhDMRFIgNrqKlmQ0G
	 uoMcWnfQEsClg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053T-0r;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
Date: Tue, 16 Jan 2024 10:38:58 +0100
Message-ID: <20240116093903.19403-3-johan+linaro@kernel.org>
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

Fix this by simply dropping the compander gain hack. If someone cares
about modelling the impact of the compander setting this can possibly be
done by exporting it as a volume control later.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: stable@vger.kernel.org      # 5.11
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 7e21cec3c2fb..7de221464d47 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1583,8 +1583,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	u16 gain_reg;
 	u16 reg;
-	int val;
-	int offset_val = 0;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
 	if (w->shift == WSA_MACRO_COMP1) {
@@ -1623,11 +1621,7 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
 					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
 					CDC_WSA_RX_PGA_HALF_DB_MASK,
 					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
-			offset_val = -2;
 		}
-		val = snd_soc_component_read(component, gain_reg);
-		val += offset_val;
-		snd_soc_component_write(component, gain_reg, val);
 		wsa_macro_config_ear_spkr_gain(component, wsa,
 						event, gain_reg);
 		break;
@@ -1654,10 +1648,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
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


