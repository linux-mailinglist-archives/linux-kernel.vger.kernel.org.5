Return-Path: <linux-kernel+bounces-78922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A174861AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9691C23939
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7313DB94;
	Fri, 23 Feb 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d1Ob/D6L"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6B133985
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710688; cv=none; b=u32U/WlEfpnQKdMG8nl6gWSyGrFUpgHQT/WAYoQO/GeZMD9b6AhmaXOOLK9wclcdbYY4LxyksLMnGjUPC8i+PhqijRqvglq0uLFDbP+sdkMLvXHCVprD8wNh/jwJvEKJRe08n0Kscr+sFyQqxGw4gkdKt8EUmFq8K7bBCHQ8xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710688; c=relaxed/simple;
	bh=YbwFPjo6ccRVq4UzuSvS6LZFtetWcxbtqaMWTpTxTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5i9+Kr09I0qir3DyfCWFwNYgxX9G41JLhLrbXHntI7fkja9T2wT4sxdOaYFYMApmuzVqrOmVSa2/pSXJY/QaDAUlCDw0C1IuMy6Wrb9Jfbi1/MJy2sdYNfQf/GCKsy9nut0/sC2bhw57EmYP433r+rkaFhoRJ55hOgIKZGVPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d1Ob/D6L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d7b04f7e9so662202f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710685; x=1709315485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5onlIQPMa8EU8sK1NqJS82W4yBogcW0MtBFux+iSL0=;
        b=d1Ob/D6L0zsjyvH79I6uKqqoxs7Udses5ujcA88eE77p35fIILwi+EbFV31NqUnyGB
         6snux43U6CMRS8t83JAtNMM9iXLAp3bKM9HMt30M1ZPQp2QEMg6Kgq2diLZkcd8ASMot
         cHaEBNK4nAeT9C5802b0Lk22bcdZjy71j1YASLfujo9x3rvlqBJIRd+4D9vjO/iE9ekF
         y3fZIFqvEOXydRHE0zRHEQ3sD9ccRgQgCXdhFUGrEcj/f/nBzDKeiaRk3ZBjZxzYMTv5
         sZyX23TEfcRES5/BBn2OGsG90Gpf91w3rZLan0dYV1qlU/3CpjpzRLfIVvIdSmcBJpC9
         s5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710685; x=1709315485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5onlIQPMa8EU8sK1NqJS82W4yBogcW0MtBFux+iSL0=;
        b=w5VVRCXHL2m1ncZij8+Hiaesx8hXAgTebeJZHW4HsVhtrnlPT8tGwQCjHITSiKY2W9
         TsiOoXTOuGz6I7KzpSnoMOs4r5Tk8+IAfkDoJ1utYIYrk2NvKx7KgyJCdJsPpCB6q39B
         f3XmoQLqC/gONok8NBMkQ1Zu9mYgl44uWwBfET753Nlhpish/PMv0MMcziwge3J7H2tf
         96WMuL6XuzVyb0m1diS6w5veBc8XTd4+1MjIaeCYCQJ/CzTFH5pMa+stsC5gKYiyh19O
         CstypNK43XeRL99wtv6sJrBt7LS/fv9h5eJDatk7lLn/vyxyU3IIOcRVWMvmvBn6l/jN
         ecGw==
X-Forwarded-Encrypted: i=1; AJvYcCWWN0Vs4zBnxytgZ6ql9sOTMi95WoWkPMMg/OCQ9EpaFQ3nFhykACwVAiaFMMDQpjTSY3/UuvXBV4BPPrR4HUotX77GEann6lLUod35
X-Gm-Message-State: AOJu0YwdSbqtK/gQbKtWRzhiqcbyyN3kx/LTq9qgO4zlWly8bNkMwUao
	VW4tsAzm+RxrxYghM9+xl+q1j+5tHoqxa6ThcxTBd0ADhri8B2HQzpOLQU0jrls=
X-Google-Smtp-Source: AGHT+IGbVheYYWSnBsZMt7MWcRfxMQjAjkyXcfMrBJ55mpI+QDGAkuDrALH5oqVlvASElX3LNqQCRA==
X-Received: by 2002:adf:fcc6:0:b0:33d:9283:93b with SMTP id f6-20020adffcc6000000b0033d9283093bmr329883wrs.47.1708710684884;
        Fri, 23 Feb 2024 09:51:24 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:24 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 4/6] ASoC: meson: axg-spdifin: use max width for rate detection
Date: Fri, 23 Feb 2024 18:51:10 +0100
Message-ID: <20240223175116.2005407-5-jbrunet@baylibre.com>
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

Use maximum width between 2 edges to setup spdifin thresholds
and detect the input sample rate. This comes from Amlogic SDK and
seems to be marginally more reliable than minimum width.

This is done to align with a future eARC support.
No issue was reported with minimum width so far, this is considered
to be an update so no Fixes tag is set.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-spdifin.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index bc2f2849ecfb..e721f579321e 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -179,9 +179,9 @@ static int axg_spdifin_sample_mode_config(struct snd_soc_dai *dai,
 			   SPDIFIN_CTRL1_BASE_TIMER,
 			   FIELD_PREP(SPDIFIN_CTRL1_BASE_TIMER, rate / 1000));
 
-	/* Threshold based on the minimum width between two edges */
+	/* Threshold based on the maximum width between two edges */
 	regmap_update_bits(priv->map, SPDIFIN_CTRL0,
-			   SPDIFIN_CTRL0_WIDTH_SEL, SPDIFIN_CTRL0_WIDTH_SEL);
+			   SPDIFIN_CTRL0_WIDTH_SEL, 0);
 
 	/* Calculate the last timer which has no threshold */
 	t_next = axg_spdifin_mode_timer(priv, i, rate);
@@ -199,7 +199,7 @@ static int axg_spdifin_sample_mode_config(struct snd_soc_dai *dai,
 		axg_spdifin_write_timer(priv->map, i, t);
 
 		/* Set the threshold value */
-		axg_spdifin_write_threshold(priv->map, i, t + t_next);
+		axg_spdifin_write_threshold(priv->map, i, 3 * (t + t_next));
 
 		/* Save the current timer for the next threshold calculation */
 		t_next = t;
-- 
2.43.0


