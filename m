Return-Path: <linux-kernel+bounces-78923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFA861AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F81C25AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535661448F5;
	Fri, 23 Feb 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rLvW8bQf"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C947133991
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710689; cv=none; b=pT33a7juz+90zjxcAwgPDikCFbhKo2vfFRs54yxQmtuE2v1TvSNsPSgkgJmfVZaHIldjmebTkPILexC3e6j2OY3EiP3p9KKKzhZiwhx21atG9vtYFg3eCkMZwDMKnAlKCHWJnfCOncq6RDaBbaLJ7gga/xVF1pH2o5c6ayvrBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710689; c=relaxed/simple;
	bh=D6ZViuQxxu5LLhWeN+tNr7Qy788hI6Q6B6sgjHGd1ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui9BxxfsMK4x9ZJT/w0fuSYgAs914JW53/MNMFEBcOrowa8YIyrOUX2iSkbVBZmuOyYm2UXGZd+TQjR3vOb+1z9BVADIch5z3HF8aNKURtJ6KqEUj+sRj1//HQUY3DW0pRDxSKzphFmLGe+SO/2Iv3LFTEtH2ZSw50Ic1rAi1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rLvW8bQf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so400969f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710686; x=1709315486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvElMeb2g6xpqhFWcI8ix09RRMkAlSO99O6608hvkMQ=;
        b=rLvW8bQfqLtaZQuokiMeMyttNo3pRVHoziZXYD5g7t+LsiXEAg/TV1ylfgzMCc6WKF
         1shEP2ADVqjPNAQXEbIKrRJYbQogpN0p9ZdiakMMxf48cSbd7++3OxJRy0hC4JKbKkrm
         bU8OWGlv9cfHrghE1KNzif+McoiyO2MYkMR7EHuEXx/BXgH3rLFLqa/Jrtt2A3exCD53
         hSmiGjJ8fAva/1WIyzF6GthaIciNQ2Bw6Qhj3yIdkVN8Wm4IM6Wl/7De4bu7gHb/wWyy
         BR+mwEiTToKVVr0DLt5PpcM3RFXBOMTnpeKSiyJiREtFRZs1A7JJR9wWmOwvFV5yIwiJ
         hVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710686; x=1709315486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvElMeb2g6xpqhFWcI8ix09RRMkAlSO99O6608hvkMQ=;
        b=jUYuH0gNqLUHTioYRHfu0y5V7ztMbj+68FocqzFiKUaNPTzZ58UqaJasxVPFM9IhOk
         joDhFGoN3L/y9fFq5RyYkE2lHwjc2CegLDK1nXLwfHLHvEpz3yeSsH9uwdk7fWx1UNYN
         +KCi+L3TrjmUKQe9t7YF+GBNtex6z8fHOIdvM4KMAEGhfVZaf9UqW/CVlW8kFvKUQv3k
         d6c+MhHF5/KqsHi1nMY0Xtr4mzLPoZONChbw558yo6pPh3xg/9cMQs6QFLtX2JLL/o3J
         uIg7Ym+CvSdMpl0PJ8qRmmrO0IDW76W5mRiSOkhjsn0LZY8+kctlUdQitccpNRgL7/p3
         db3g==
X-Forwarded-Encrypted: i=1; AJvYcCULiusXI/w1l6GzJCGugmuIzoYTCjD+1LlhLGrd2lefh+Cc3z/aazroowvU8kH1ihl5QaSKWi4ydKHigWP2fZEtRmasTUO+S0CChOiR
X-Gm-Message-State: AOJu0YwbgXgHt9NxUsvXVuJI9qf+8X1WRyTRUzEwEOX+PrlB7c6VRMzo
	No/5Xjw9HefWFXa8u1bPD0ltge9wk1wk+lCd7pXa60Tn7YYXe6oEohOxmSzmJEY=
X-Google-Smtp-Source: AGHT+IGsZP6H+91NdmJ6i8soaEWmdRDIYCoyh52OhJZC6bOgqY/X/r4JhNQ6kUaz+Xc1LH/5RJoMXA==
X-Received: by 2002:a5d:4a4a:0:b0:33d:3cf6:a2ca with SMTP id v10-20020a5d4a4a000000b0033d3cf6a2camr361594wrs.30.1708710685868;
        Fri, 23 Feb 2024 09:51:25 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:25 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 5/6] ASoC: meson: axg-fifo: take continuous rates
Date: Fri, 23 Feb 2024 18:51:11 +0100
Message-ID: <20240223175116.2005407-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The rate of the stream does not matter for the fifos of the axg family.
Fifos will just push or pull data to/from the DDR according to consumption
or production of the downstream element, which is the DPCM backend.

Drop the rate list and allow continuous rates. The lower and upper rate are
set according what is known to work with the different backends

This allows the PDM input backend to also use continuous rates.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.h  | 2 --
 sound/soc/meson/axg-frddr.c | 8 ++++++--
 sound/soc/meson/axg-toddr.c | 8 ++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index df528e8cb7c9..a14c31eb06d8 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -21,8 +21,6 @@ struct snd_soc_dai_driver;
 struct snd_soc_pcm_runtime;
 
 #define AXG_FIFO_CH_MAX			128
-#define AXG_FIFO_RATES			(SNDRV_PCM_RATE_5512 |		\
-					 SNDRV_PCM_RATE_8000_384000)
 #define AXG_FIFO_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
 					 SNDRV_PCM_FMTBIT_S16_LE |	\
 					 SNDRV_PCM_FMTBIT_S20_LE |	\
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 8c166a5f338c..98140f449eb3 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -109,7 +109,9 @@ static struct snd_soc_dai_driver axg_frddr_dai_drv = {
 		.stream_name	= "Playback",
 		.channels_min	= 1,
 		.channels_max	= AXG_FIFO_CH_MAX,
-		.rates		= AXG_FIFO_RATES,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5515,
+		.rate_max	= 384000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &axg_frddr_ops,
@@ -184,7 +186,9 @@ static struct snd_soc_dai_driver g12a_frddr_dai_drv = {
 		.stream_name	= "Playback",
 		.channels_min	= 1,
 		.channels_max	= AXG_FIFO_CH_MAX,
-		.rates		= AXG_FIFO_RATES,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5515,
+		.rate_max	= 384000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &g12a_frddr_ops,
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 1a0be177b8fe..32ee45cce7f8 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -131,7 +131,9 @@ static struct snd_soc_dai_driver axg_toddr_dai_drv = {
 		.stream_name	= "Capture",
 		.channels_min	= 1,
 		.channels_max	= AXG_FIFO_CH_MAX,
-		.rates		= AXG_FIFO_RATES,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5515,
+		.rate_max	= 384000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &axg_toddr_ops,
@@ -226,7 +228,9 @@ static struct snd_soc_dai_driver g12a_toddr_dai_drv = {
 		.stream_name	= "Capture",
 		.channels_min	= 1,
 		.channels_max	= AXG_FIFO_CH_MAX,
-		.rates		= AXG_FIFO_RATES,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5515,
+		.rate_max	= 384000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &g12a_toddr_ops,
-- 
2.43.0


