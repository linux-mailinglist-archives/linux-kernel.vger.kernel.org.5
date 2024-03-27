Return-Path: <linux-kernel+bounces-120494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9448E88D85A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FC29C77A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7F2C6B6;
	Wed, 27 Mar 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="FNs720Yz"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899ADF4D;
	Wed, 27 Mar 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526752; cv=none; b=GR95OIIrCo6Bp24YAn6UwUvtlCW79OXISh4+b4nsjzI3DeQFieUML1wsF4YFI7JiDrqCNDIMUoegeeRhbWhhFoGTbtU/FX24x8ooVut7myzPbQ0p2RTktjGME6OHMX+DohPUcA/18QeqAhcsWEPtvjjo/8m41hPSRh0PB9Z3jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526752; c=relaxed/simple;
	bh=r4JXMW58E7i8lNoJ31XYYNnSGQR/YuEX7KZrH5t3UyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxrrbZk9Q7UWtdzKQ/ywYKXC48xrhRzmsot0iW8ymu4ZCNou4CVOq/cOVditqOOLJx5XITg5xL1Il9oGlq7EsLUksiSBpbVOwqQxfAiZk8Xx+xeN+GDJT7XrRVjyO7V5hIf+35FG9IPGr2+Fj0lH4tG5kVO3+aSHD1X3rbohp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=FNs720Yz; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1711526745; bh=r4JXMW58E7i8lNoJ31XYYNnSGQR/YuEX7KZrH5t3UyE=;
	h=From:To:Cc:Subject:Date:From;
	b=FNs720YzlUVg+LJFcaUHuBsJLiF6gKZLE6FYoYAy+4PcQed1GZnX12dX5Ot6qHu6G
	 hdcEfh1WJ0ZNPzzeDBZwkRSz24z4wz6wDvWgcIFpTKyzGRuhrgvph+d7GcZAhVRN8y
	 /jNXuG0LdO6JsQlDpFHHPbmhnInQNrR/JVIC1yVs=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	kernel test robot <lkp@intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH] ASoC: sun8i-codec: Fix build with CONFIG_SND_JACK_INPUT_DEV disabled
Date: Wed, 27 Mar 2024 09:05:34 +0100
Message-ID: <20240327080542.3649840-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

When CONFIG_SND_JACK_INPUT_DEV is disabled, struct snd_jack doesn't
have 'type' field. We can't rely on this field being always present,
so store the jack_type in the codec driver itself.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403261243.kcXCPAYs-lkp@intel.com/
---
This is a followup for https://lore.kernel.org/lkml/2vhd45kylttgonosdcfn7ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh/

 sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 43795362fed0..b5dafb749c3f 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -232,6 +232,7 @@ struct sun8i_codec {
 	struct delayed_work		jack_work;
 	int				jack_irq;
 	int				jack_status;
+	int				jack_type;
 	int				jack_last_sample;
 	ktime_t				jack_hbias_ready;
 	struct mutex			jack_mutex;
@@ -1352,7 +1353,6 @@ static void sun8i_codec_jack_work(struct work_struct *work)
 	struct sun8i_codec *scodec = container_of(work, struct sun8i_codec,
 						  jack_work.work);
 	unsigned int mdata;
-	int type_mask = scodec->jack->jack->type;
 	int type;
 
 	guard(mutex)(&scodec->jack_mutex);
@@ -1363,7 +1363,7 @@ static void sun8i_codec_jack_work(struct work_struct *work)
 
 		scodec->jack_last_sample = -1;
 
-		if (type_mask & SND_JACK_MICROPHONE) {
+		if (scodec->jack_type & SND_JACK_MICROPHONE) {
 			/*
 			 * If we were in disconnected state, we enable HBIAS and
 			 * wait 600ms before reading initial HDATA value.
@@ -1376,7 +1376,7 @@ static void sun8i_codec_jack_work(struct work_struct *work)
 			scodec->jack_status = SUN8I_JACK_STATUS_WAITING_HBIAS;
 		} else {
 			snd_soc_jack_report(scodec->jack, SND_JACK_HEADPHONE,
-					    type_mask);
+					    scodec->jack_type);
 			scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
 		}
 	} else if (scodec->jack_status == SUN8I_JACK_STATUS_WAITING_HBIAS) {
@@ -1417,17 +1417,17 @@ static void sun8i_codec_jack_work(struct work_struct *work)
 		if (type == SND_JACK_HEADPHONE)
 			sun8i_codec_set_hmic_bias(scodec, false);
 
-		snd_soc_jack_report(scodec->jack, type, type_mask);
+		snd_soc_jack_report(scodec->jack, type, scodec->jack_type);
 		scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
 	} else if (scodec->jack_status == SUN8I_JACK_STATUS_CONNECTED) {
 		if (scodec->last_hmic_irq != SUN8I_HMIC_STS_JACK_OUT_IRQ_ST)
 			return;
 
 		scodec->jack_status = SUN8I_JACK_STATUS_DISCONNECTED;
-		if (type_mask & SND_JACK_MICROPHONE)
+		if (scodec->jack_type & SND_JACK_MICROPHONE)
 			sun8i_codec_set_hmic_bias(scodec, false);
 
-		snd_soc_jack_report(scodec->jack, 0, type_mask);
+		snd_soc_jack_report(scodec->jack, 0, scodec->jack_type);
 	}
 }
 
@@ -1491,7 +1491,7 @@ static irqreturn_t sun8i_codec_jack_irq(int irq, void *dev_id)
 		if (scodec->jack_last_sample >= 0 &&
 		    scodec->jack_last_sample == value)
 			snd_soc_jack_report(scodec->jack, type,
-					    scodec->jack->jack->type);
+					    scodec->jack_type);
 
 		scodec->jack_last_sample = value;
 	}
-- 
2.44.0


