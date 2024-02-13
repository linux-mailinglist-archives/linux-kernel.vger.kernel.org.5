Return-Path: <linux-kernel+bounces-64403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6C853DED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0061A28EAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F16312D;
	Tue, 13 Feb 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y82wqYvx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0E62A11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861500; cv=none; b=Jtd8HJHt9vzPxGWt1aq8Vn6UyAjp7QWUdtym2SLBbZfz0+x4i1XQBfXtzhdiKG2Y2ZAxppoGdAAUvi2SD8EEVsCTjIsYv5DBZFgUwlJz6w2r9lDnpERogytLQUvFr1YJkE5LbBqtJC6ctVDIJXVZ6fhOaScxYM/2uqVMczyQkxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861500; c=relaxed/simple;
	bh=XCEzGiySNrzVsGywGANcAcUebyxPHAJnm9xzwLcysLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAeg/k9ZXIDSammlRiyEMI5nHmR+/UEvfKypBmj1ODtoy8Udqw+PL1ICmamxllwMN8bRQcvr/VjqcA243xjN8kRO2T2EQhJUE5YzkAzV8KRWC28+LI5EwjaNVqLL9uzEaQIEpcnBStNv3NfV4GmwRNwmspCDwCEzAF5P0A9nYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y82wqYvx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4114e0a2978so15726715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707861497; x=1708466297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqyuBahTPLTAYF+110cUFRV0sBjf6cZZgU9lFVSbKt0=;
        b=Y82wqYvxcxh7adCikFQ8fzf9Zs9jaKLOkLJWN2TUWBoC6upJwmFLTnLrlln1oNFudt
         KbnV9JmcjdOb+K6kY395dYrRU8X+dGrlgLKtKkYJBULnhDJTeunHigTv1c+6rUh5ExmG
         Zhfwd3EVaGma+hNxPDLI8U7EnB1xCxXSkow3fnituaxCCryk4udu4TlztVP8PRnR3vua
         2u0PTo17hVOflZqkwtfQXYUprgniD3zdE3Ix8c3E8g0r6nKiEvR4Mf1pLfGmbMGIBGPo
         PgMNfVDv0lmPZjflq85U0SRKHuVHcE01bLEHfHDm21UMq9yek0QSMW+/aAC86inV7CQW
         vMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861497; x=1708466297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqyuBahTPLTAYF+110cUFRV0sBjf6cZZgU9lFVSbKt0=;
        b=P16weLiBllAuLw2UicqHgAm0qZ1jwQqOAEXn8zq/Svwgy+a0CkqxR/qEqk0CB93gPS
         Qa5yVVFUC4DVREITpv7awr4DtCuiH5gMd13EkmGCNqRZuhKKxTy8QNJm1QmaFTY4I3K0
         +y+jn9yBFf9C3K7eEErVFoPVe+jjSHymjjsJpfCmh709NC36jvUHIz0deQ8Yh9spTTmM
         uY10IHNbRhJeguuIOZ/fT/7wYbSe7a/iODyna30ysyEpwR5OeXxCjpdV3WJzlHb4n6Ea
         4flcl+AgMBVZ5lkCXPGl635cLOjaRtuGHYDYWX/lqBTJ266xeE2vrZr2Eq8r/i0m8bHy
         2lLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfeTbzwJyr7a7S1ys0TnLEn/ok6UzwCAzE8LjJ7i7BV29k6q2JBoHJL+Lj90Y29w8qlPhBYOlGnhPg6KM4IfJymBXpY1mm/FmNS1P4
X-Gm-Message-State: AOJu0YwtV8xfqxZqHWvXaRJTBOWmXWERx4BXgo2IlnFi6zYTQcgjyZvm
	V/1zS3IwBk2xupIw8N0t/IglXEXZscqnIw0GXXPLZAKV1WyUVHm3CKPKsdzonv0=
X-Google-Smtp-Source: AGHT+IFQmIg0n0GJLfQcjyAmY5aOtHbpVk0kKAcJWpMWmARHiy2H/vQt8V6epQv+QeBGgNL4tEMGfw==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e2d9:ad36 with SMTP id u3-20020a5d6ac3000000b0033ce2d9ad36mr369591wrw.20.1707861497019;
        Tue, 13 Feb 2024 13:58:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXatIVkhfi4XEgXz5p/gNLbo1vWmEs55v5qyHuI9D0zr8zRt8TJ8ZvxAEkAOJ8a3kznQNaB9CwA0yXFBxNMvj53rHwJ036OVmcocDuLVPfg+PhWLsrC9mlRpniTJxWwH6grCm6vDtmEPJKmWES7/cqSCgpdP/SP1XUCZZN/cAwDr9J27u3hbZyUxvljt3BMCZHmzTpd0QV0bB1cqVdFgl8r1MWmfH7UPkPZq5G2SLjKlWyYV1Bny7ioTDZ9a0tYFo0aVVX3mZT8YahfGGdNcI0a2y2v5rR2Q//H/EU2oWk+rBkR2RDeq8lDwto1myB3M5HTP7it3hesDm99vHUtWHz2n2VKv4Q4O3O2jjAJiuJUqYaCCLIdo0fHDM/dFr/tAaBy30Q6tJz0fcYSUXI8mhoAxW/AWT/oJ1y9vKLuEWj5f8/2i42oUMG6NlN/UzLWMOBw3vS/ecrqYiEobhSloI9qEMgg2SNdaAJXIWgEP2QA8Ev5ZO4piJzUKTZcua59IhWs2zPvSJydJocUe7HdqVKGsdBiuUkwwPb1YyCR9TYWE9OrWora9hpg0mrQsWDgwKLvGk2X3utxRuNVkTTdirRufduCj547YWj/gaQCGXx+o44FtvU=
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:af6b:4350:776e:dcda])
        by smtp.googlemail.com with ESMTPSA id r3-20020adfca83000000b0033cdbe335bcsm2415244wrh.71.2024.02.13.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:58:16 -0800 (PST)
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
Subject: [PATCH v2 1/2] ASoC: meson: aiu: fix function pointer type mismatch
Date: Tue, 13 Feb 2024 22:58:03 +0100
Message-ID: <20240213215807.3326688-2-jbrunet@baylibre.com>
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

sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  243 |                                        (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu.c | 19 ++++---------------
 sound/soc/meson/aiu.h |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 7109b81cc3d0..5d1419ed7a62 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -212,11 +212,12 @@ static const char * const aiu_spdif_ids[] = {
 static int aiu_clk_get(struct device *dev)
 {
 	struct aiu *aiu = dev_get_drvdata(dev);
+	struct clk *pclk;
 	int ret;
 
-	aiu->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(aiu->pclk))
-		return dev_err_probe(dev, PTR_ERR(aiu->pclk), "Can't get the aiu pclk\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "Can't get the aiu pclk\n");
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
 	if (IS_ERR(aiu->spdif_mclk))
@@ -233,18 +234,6 @@ static int aiu_clk_get(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 
-	ret = clk_prepare_enable(aiu->pclk);
-	if (ret) {
-		dev_err(dev, "peripheral clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       aiu->pclk);
-	if (ret)
-		dev_err(dev, "failed to add reset action on pclk");
-
 	return ret;
 }
 
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 393b6c2307e4..0f94c8bf6081 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -33,7 +33,6 @@ struct aiu_platform_data {
 };
 
 struct aiu {
-	struct clk *pclk;
 	struct clk *spdif_mclk;
 	struct aiu_interface i2s;
 	struct aiu_interface spdif;
-- 
2.43.0


