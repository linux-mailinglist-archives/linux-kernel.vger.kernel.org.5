Return-Path: <linux-kernel+bounces-64405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA3853DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD428F142
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222765E03;
	Tue, 13 Feb 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BmWQ659L"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FF63115
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861503; cv=none; b=QF6jW1zpG1qfEYNb73XMPSw1qZkXJw4wDcW9jgkFLhAG1tQ0dAYndu6ZRJ/7S0GVF1XZKvNklVSDkq8l6Aa9Do8l3bgIoud/R1s6SIg+dMCaqUmF2Wgrv+l2uDZKd799Jr/5b/3p1kzqTHC7+D17QSMd8BpH7qJyIx/qIT5nJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861503; c=relaxed/simple;
	bh=jfZkHq9HMbZcPnc0fldRolB1xckrU5dTpOn3zFrSjtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzcgksN4wCi5mshlhofVBmadaBjsKetxP72b4Io1ZfqH6a9k4OmjPpCnNtcRL4fYB6VsgeLD8D6upbBkKqEYz9r89VVuMIGntcS86ZfuFBUed3SEMGhy0ysZJ0V1Zsq7+zHal8HYn9KLm4L0men/wM0ZHhrQ3jBBMElRaIKx+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BmWQ659L; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ce58eebe4so129400f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707861498; x=1708466298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhlnphO38kFK64rZw6/MYfY4vE6pLo1I8JNTrKfTc6I=;
        b=BmWQ659LSRlnERUOvz0ZO6omAKBtcF7GLPQuL6lTdp6dtpuJcYeBCAq4Ph1CT7r64n
         ZT91gnTnq9B/DZrZPkEII/3jqJOXC9Iz68a+Kc0zn9XyqNJQv4vkxVHywa+Z/SHgpQgH
         e0dJ+Rij9JCGcKwF1o1XJUYyo2CBtHgtmkgdhVuC460zO1WbRJjRkhTuNDmIYyzFcF0h
         HB2MqpMifV8NmUT82aWirVt51ovy4v8WOFsQm+Q0+x9wb4tnFtF3Epyf6MSd+46hpcqC
         bBwkzdYDrb6Xw8nDVmaHWAcudF0k5EggbEKieCaTES8WY82KQ0cjT0899RpWAzeTr7l8
         Uz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861498; x=1708466298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhlnphO38kFK64rZw6/MYfY4vE6pLo1I8JNTrKfTc6I=;
        b=ciFNTeHG5Tg6ulwXZpBk42QGGMaER6QFCoW+KlbP9AWGo/1NpMviLxqdVbmD+zmMnt
         QH9DGy3KFXX2I3FCQXFD4s3TvYtP8rsiscupWqV1FplnVNbgk61Pt4TOozanEMRKjTpu
         iI/Lj+mpExJL/tjHiPW+KLRM3VsMrhGUttO/L6j2JHmhA7pZCa7AN1vyGopvqYsHcCna
         bXLduNK3nSfAjp9Vj6gcMP1Vn9C/gzFK2XFcWx43IOcCbuMdOdT6QTnIVSaKFMtwsptF
         JUCbavYEAhtMM+kIc+0ZLsWHNJIAexTB1+YmqdqUGKiiXQR53M0b0D3lfbm7gPvYEjBO
         CnJg==
X-Forwarded-Encrypted: i=1; AJvYcCU+JBGTavlNi2MQ0xMNVM8BZ4kzlwJmIB7PggX0tCdsiHPa054GWEHoI6wFZ1YdhG4ScWIBZ8E1eZNj/IekaaD9sDfBvOg0RX85H+7V
X-Gm-Message-State: AOJu0YzpkQ9GGAGXIJzMuTBDjRM5gyqBfm1NHI+4ZdpQx9CpFsxHIOTy
	J1f0UHcRFxJbFertELOlU+pAtmSlegRMpXRq0Eby9Rv/zaAyQfzmoivSs7emETc=
X-Google-Smtp-Source: AGHT+IFZ3n4e4596jcQPvb4/M0w5BxopAfbxvEnr7lIBU6iDbCf0cnXOAXxypGjN46bUXfIJV5p8/Q==
X-Received: by 2002:a05:6000:8c:b0:33b:eef:86bf with SMTP id m12-20020a056000008c00b0033b0eef86bfmr388447wrx.25.1707861498107;
        Tue, 13 Feb 2024 13:58:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJ0VVy771lMRNflwR2yXi3R6/+dub54OOGnNJcvbuYIcEQsS5QlZrroSyMaWyijwq5c2hC2NvAD1pLPuWErPD4resXTwAhLmgxRmddslpV+8WAJTZhqazEat8FROH6ieAWumwv9lwt2Yn+FPrC6KmppIxwT/69asnfrePkZYVyJm3MK8h6ONvWc4IVBliqIFds5PZnsuGbkN5YWb7v+EZ3lPaVlx8GQXS98E5BHdIkhe2fksr9g6fEQtBkmWZfjgIWHMdjABQC/Deor8k9BzNBZ/jZxeieUroSwXKpwXdAHo9GV7XRnDmuBhbRO+C92L59xtUs95jer13d1n3ZBFTan8/bDFyhPVJtW6W85pRJdzcG8SMhFTgzPnvTI9XyGvrfPCYEwTn2530CpHXZlnm58uKPeqEc/f4S8CjWah4EKiga/vB75UKu5a61ol+z+cTSNM2/+4nM0LDdsn3Xe02hOUew7hU8xN0JxTWaapP3O2LfNImUG8yZiMxgbypKxrbgjYv0pwfGsy5NiexdQymHchYp1g1/WlBYRa30jRBImDVuDC3qnO+VtTeO4PfPh4VlA4esexQfeGrSzLs05LRvxWwnxHyNEIOclcbc1msQ1BOqA/4=
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:af6b:4350:776e:dcda])
        by smtp.googlemail.com with ESMTPSA id r3-20020adfca83000000b0033cdbe335bcsm2415244wrh.71.2024.02.13.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:58:17 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/2] ASoC: meson: t9015: fix function pointer type mismatch
Date: Tue, 13 Feb 2024 22:58:04 +0100
Message-ID: <20240213215807.3326688-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213215807.3326688-1-jbrunet@baylibre.com>
References: <20240213215807.3326688-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

sound/soc/meson/t9015.c:274:4: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  274 |                         (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 33901f5b9b16 ("ASoC: meson: add t9015 internal DAC driver")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/t9015.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 9c6b4dac6893..571f65788c59 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -48,7 +48,6 @@
 #define POWER_CFG	0x10
 
 struct t9015 {
-	struct clk *pclk;
 	struct regulator *avdd;
 };
 
@@ -249,6 +248,7 @@ static int t9015_probe(struct platform_device *pdev)
 	struct t9015 *priv;
 	void __iomem *regs;
 	struct regmap *regmap;
+	struct clk *pclk;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -256,26 +256,14 @@ static int t9015_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk))
-		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get core clock\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "failed to get core clock\n");
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
 	if (IS_ERR(priv->avdd))
 		return dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 
-	ret = clk_prepare_enable(priv->pclk);
-	if (ret) {
-		dev_err(dev, "core clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			priv->pclk);
-	if (ret)
-		return ret;
-
 	ret = device_reset(dev);
 	if (ret) {
 		dev_err(dev, "reset failed\n");
-- 
2.43.0


