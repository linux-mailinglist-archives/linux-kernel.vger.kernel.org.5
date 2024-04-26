Return-Path: <linux-kernel+bounces-160291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9A8B3B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB8E28920E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23F14B07D;
	Fri, 26 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jjsewEpI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E18148FE6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145400; cv=none; b=C7Wj4IBAu2rmtawK6TOiryYm4k9UnEO0Cv6RhD/OtFyL7/gTnlLlx1+4m5OxVGJ4kKnlNwnlv93sivYgzDRk5PdPHNnW4WSJKmx1RUcyMxKsZDtvY8TszHz9Ugj1lpSNqe+MyBhj2HVwozT0WB5SWefDQx7uXQ5NpzhQezM03No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145400; c=relaxed/simple;
	bh=XL4wNAHbKdLtic6750ztJIoB/ro7CVmirV6b234wNGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWGpijATeLwb10XdNsxElB5moe+l3QzoNLe9jZtWmH16h4PsUj3ETQD1B/Jgl/ettRBYl+qUscY25UiU1n79qgwgDfa3+mOuH86yTM+7+vCY5LWMDpwnHELXUF45OqUW7hUPNIg92C5iVLUfidgydF20QSAK1YjdJ+60g33vNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jjsewEpI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so3892865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145397; x=1714750197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ4CJQsXVTR1thlbAzx7uixAygG90ZyA723vL1wPyc4=;
        b=jjsewEpIM9BA/aQ3sktSAb8UzHcmuxtDsZQ2MRbw2uOxEakIRkwhrDKgzRFsgaI71P
         llbxbU96xo5tGaZUEnke4lTfiNAlYzQnm36mSCLebWxotO3Vz3t47UtrHn94bYob34CI
         eprpDUbB1OBd4PxskplrROfDGtwYUEvRAjDmyyZIvivHdBr5M9+WWwyGxkbyuONVpuof
         jBQ4nMskJQ3QHqFcceW+vkiFI+lYON+7jPls/djkJBG94yykUNLvzQTHvSzd1URUdsmf
         2BEMYDSwWaRk/0XPlUvpPvsxsKrmjTMbgmDYYTpQ9p+9jNTjQMTHnvq83Ylb27e0HThD
         5OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145397; x=1714750197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ4CJQsXVTR1thlbAzx7uixAygG90ZyA723vL1wPyc4=;
        b=nF3+mfME5SM1dEvF/t3k44Nh8/f0LjOTMRqu6WGFeB6lrmCxrTD+gdWVi6SrMlvC++
         pZ4/4bkv7An1can+fd390IitFs72lgwYA60pf8oLxMzb7rtgykucImWHF7RF054+SfMC
         rhCwg4S7i4E5OZdmqgZfxk+oMrTKlj5k2derYcDO2QAKTPMfA1kLKISFQsvmPuzE3oPv
         3LELf37QTvWzwq/TOYHuqYBc91Q+EmoRom9GKCTtvmUP1hBxdS9xUgblXOv6RGeF+JG+
         CeO6ZxE+OhNMWu3qBSL9Y1TbB/IecxHNvuBRp+aFKBa0NEh6zh4nL8j709wZFL9czAOS
         jBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWORe6j9KyR9V40fA50wgp7R61mfDDnNztybxC8ihk6jrTmQ8zmx98fqu6kHdQzioI90Y+W4eTr34dI40+c8wMubJN5S862V+zhp8Tw
X-Gm-Message-State: AOJu0YySZItBmFRg9o/uvYq2O+5PRFd+scQeC8b4T6Lpg7TPMvCWFJNB
	pK+FqHsmyBPqnCB586yKx4MS2tV2//P3Wq+N1XSzeWt/ptBts2RHcFDTvy4y9iM=
X-Google-Smtp-Source: AGHT+IH1/5s5CRPWdPZqkFw1JsMyITFCO5/+y/SMhOfip3B1nJoETVweJYnD+9vnKbqKCb2dr/aCkw==
X-Received: by 2002:a05:600c:4508:b0:418:37e1:3f73 with SMTP id t8-20020a05600c450800b0041837e13f73mr3024524wmo.2.1714145397352;
        Fri, 26 Apr 2024 08:29:57 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm22628687wmq.27.2024.04.26.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:29:56 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 3/4] ASoC: meson: axg-tdm-interface: manage formatters in trigger
Date: Fri, 26 Apr 2024 17:29:40 +0200
Message-ID: <20240426152946.3078805-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426152946.3078805-1-jbrunet@baylibre.com>
References: <20240426152946.3078805-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

So far, the formatters have been reset/enabled using the .prepare()
callback. This was done in this callback because walking the formatters use
a mutex. A mutex is used because formatter handling require dealing
possibly slow clock operation.

With the support of non-atomic, .trigger() callback may be used which also
allows to properly enable and disable formatters on start but also
pause/resume.

This solve a random shift on TDMIN as well repeated samples on for TDMOUT.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 34 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index bf708717635b..8bf3735dedaa 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -349,26 +349,31 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
+static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
+				 int cmd,
 				 struct snd_soc_dai *dai)
 {
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+	struct axg_tdm_stream *ts =
+		snd_soc_dai_get_dma_data(dai, substream);
 
-	/* Stop all attached formatters */
-	axg_tdm_stream_stop(ts);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		axg_tdm_stream_start(ts);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+		axg_tdm_stream_stop(ts);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
 
-static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
-
-	/* Force all attached formatters to update */
-	return axg_tdm_stream_reset(ts);
-}
-
 static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
 {
 	int stream;
@@ -412,8 +417,7 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
-	.prepare	= axg_tdm_iface_prepare,
-	.hw_free	= axg_tdm_iface_hw_free,
+	.trigger	= axg_tdm_iface_trigger,
 };
 
 /* TDM Backend DAIs */
-- 
2.43.0


