Return-Path: <linux-kernel+bounces-160292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606958B3B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844FF1C22167
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7EC152501;
	Fri, 26 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2sc9IIH6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5E149C75
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145402; cv=none; b=G5L5idoNE2jDqkV9KBD8B2QDlw7DLMysajhHzRBQpP0gLlTo+23ajp9disL3AZZML/WENBZNd5Y0HSbTsXPsOi6znqxvdk94exf8sJhR33qwVGT3j26I6xmcF5QxAEr13olR6aPEYF/y9D9MjLLlLUIsbYrDFqZH4lqdlzsYo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145402; c=relaxed/simple;
	bh=S7RONIxFeXwe67F6fo0qfGrsfEGqrrUtec1UUThnSXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6/+rspVcJImuMmBYEaLEK6Tu80A0uJjXuKkAN9dj5iVBNrEprzGWOW15sN5T3VncLuiIYQmwdSCKitoB1FNXSwXj7JayonVUkl22qnu93jRlAsUAgEO7xo5BLl7qw6HJLHvKBUZeOcHmHzZDsTaJpoGZerdSkiLeYdOQExPcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2sc9IIH6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso3668025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145399; x=1714750199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bQrmumSWoqJQMi/l6xj2yc8RNYXdlpvWVWdoITuaG8=;
        b=2sc9IIH6oNnxx6qGtFwsu+aNXx9eZ9qb6NAImpYO4wXII/y4GtDZMOKgu65k5sdvEC
         ZyRdtMiGnxiA4kvcHPwA3kANxOwWb9IPYbCfLvDNVXK/WY/ekNeJ0zTmyeNyNlDZt54+
         WwvIhKy9whau9fRaVtsUQEUHLXW+we+ask9DvzGQ02Wm1LmQQe0Ru/Ql8+Y403GcFAUB
         MYcqqs6rWiFhDE+AwUDteQ9OWJwrv6kJXQ2BI0IJ4Nad/N8F3/jesVQmAAHkSGa7EHOR
         dSb1iSh80mtWjFuqby2mkxkakQ3CR9/HTgaVvcna7+gb5xUONT5KlCskD+Dne4VsvsDQ
         Igxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145399; x=1714750199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bQrmumSWoqJQMi/l6xj2yc8RNYXdlpvWVWdoITuaG8=;
        b=M9Aa6xXEY3lLR8oSxDxfubdXlAkljGURJ4M1CLS6RBv0NoQayzVfZ6Y9wDyQwErm6Y
         XwQvOL2NdqGKN6d2pkBIyo7yo7A+GnWlWmfyvlWWp7uk+FRAtC3opWzwly/ZLy/ptS0R
         v6YQU3wLXDNswbqSVD1Bvi3oqrVaaVeuIcetBhjD8mSmzntmi6Tddgfg5zvw93nhnbZA
         YS/eSyzuz0XhwTtea7TDOqPSaWA0aWIhv5P9T0/Hd8OXM6eZbOmaZLkE7xCUqIZ3B8LU
         IrVM8oDz40vsY2nAOoe1VXwHyi+1SbZjNva0fcB/XTfPPJpB7vRNTbjN0lhXWyJ/9zq+
         5JxA==
X-Forwarded-Encrypted: i=1; AJvYcCUmsgTf26RkBpdGsllSsrQnV3PyGUhofU54KcPnBccEWVCRJE/FI1TDVjN119ru4ZZyzXhMh6a0E3B5W+LkKbEgC0o5znaO0A7uoMzE
X-Gm-Message-State: AOJu0Yw2oahgnfVvjkI6EfLAh5/3dAaJNgwCSLXNVqmSvuRHKe+L70ax
	5HwzUusvu//ABcCWqlroHmfKyV6AA56lRMA33UXAossOe3BQTXuyzpu9bpC3hW4=
X-Google-Smtp-Source: AGHT+IHMerJdt74ThT9W2AwuFt/nqHhB935A349L3A9erdfLScSRYmjfvTF+QLgGqsuEAmQiV3l5MA==
X-Received: by 2002:a05:600c:4f11:b0:419:87ab:f6db with SMTP id l17-20020a05600c4f1100b0041987abf6dbmr2369314wmq.23.1714145398045;
        Fri, 26 Apr 2024 08:29:58 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm22628687wmq.27.2024.04.26.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:29:57 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 4/4] ASoC: meson: axg-tdm: add continuous clock support
Date: Fri, 26 Apr 2024 17:29:41 +0200
Message-ID: <20240426152946.3078805-5-jbrunet@baylibre.com>
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

Some devices may need the clocks running, even while paused.
Add support for this use case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-formatter.c | 40 +++++++++++++++++++++++++++++
 sound/soc/meson/axg-tdm-interface.c | 16 +++++++++++-
 sound/soc/meson/axg-tdm.h           |  5 ++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 63333a2b0a9c..a6579efd3775 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -392,6 +392,46 @@ void axg_tdm_stream_free(struct axg_tdm_stream *ts)
 }
 EXPORT_SYMBOL_GPL(axg_tdm_stream_free);
 
+int axg_tdm_stream_set_cont_clocks(struct axg_tdm_stream *ts,
+				   unsigned int fmt)
+{
+	int ret = 0;
+
+	if (fmt & SND_SOC_DAIFMT_CONT) {
+		/* Clock are already enabled - skipping */
+		if (ts->clk_enabled)
+			return 0;
+
+		ret = clk_prepare_enable(ts->iface->mclk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(ts->iface->sclk);
+		if (ret)
+			goto err_sclk;
+
+		ret = clk_prepare_enable(ts->iface->lrclk);
+		if (ret)
+			goto err_lrclk;
+
+		ts->clk_enabled = true;
+		return 0;
+	}
+
+	/* Clocks are already disabled - skipping */
+	if (!ts->clk_enabled)
+		return 0;
+
+	clk_disable_unprepare(ts->iface->lrclk);
+err_lrclk:
+	clk_disable_unprepare(ts->iface->sclk);
+err_sclk:
+	clk_disable_unprepare(ts->iface->mclk);
+	ts->clk_enabled = false;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_stream_set_cont_clocks);
+
 MODULE_DESCRIPTION("Amlogic AXG TDM formatter driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 8bf3735dedaa..62057c71f742 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -309,6 +309,7 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
 	int ret;
 
 	switch (iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -346,7 +347,19 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
-	return 0;
+	ret = axg_tdm_stream_set_cont_clocks(ts, iface->fmt);
+	if (ret)
+		dev_err(dai->dev, "failed to apply continuous clock setting\n");
+
+	return ret;
+}
+
+static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+
+	return axg_tdm_stream_set_cont_clocks(ts, 0);
 }
 
 static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
@@ -417,6 +430,7 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
+	.hw_free	= axg_tdm_iface_hw_free,
 	.trigger	= axg_tdm_iface_trigger,
 };
 
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index 42f7470b9a7f..daaca10fec9e 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -58,12 +58,17 @@ struct axg_tdm_stream {
 	unsigned int physical_width;
 	u32 *mask;
 	bool ready;
+
+	/* For continuous clock tracking */
+	bool clk_enabled;
 };
 
 struct axg_tdm_stream *axg_tdm_stream_alloc(struct axg_tdm_iface *iface);
 void axg_tdm_stream_free(struct axg_tdm_stream *ts);
 int axg_tdm_stream_start(struct axg_tdm_stream *ts);
 void axg_tdm_stream_stop(struct axg_tdm_stream *ts);
+int axg_tdm_stream_set_cont_clocks(struct axg_tdm_stream *ts,
+				   unsigned int fmt);
 
 static inline int axg_tdm_stream_reset(struct axg_tdm_stream *ts)
 {
-- 
2.43.0


