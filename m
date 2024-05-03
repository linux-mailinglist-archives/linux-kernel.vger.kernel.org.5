Return-Path: <linux-kernel+bounces-168285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6B8BB62C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE93B1C2107E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822813172C;
	Fri,  3 May 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9tIzGJ5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF57E116
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772233; cv=none; b=ducluE/7sL4kJVrgjUbPH2HLHcDpHHbm7SeaTcgRnf7JW4N734NlRQICvC+biN07m5h9CqB+QiB0kNHY3xKXkdqmdxdhtMxS/pmoxjbZd2Y2+TrI7Wg+bUgnHDHE0n6E3BR+L7CeoSVSu4qp/Q6EjvQ9JSgLVDMGtFbzOWmav1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772233; c=relaxed/simple;
	bh=olvoMor9lk9RgjsPtUNMpvGYduJbBc8bUMlTJb3Saag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adnZfpV4TvEp53LSJjpRTQVhniTvyVXunMNU/ZIRoDNoWVNlrC1kXa9GrlCg/7NRuyh2cCpYaW95IIYZUhPEDrMSqGF2G8xiUE0vfZa7JDiw7YXOOcWLEdkbdGjAUGHrICMQg72al+e0cSxGueaGsueUzlAibSVES6m3K3+WprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C9tIzGJ5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso1158365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772231; x=1715377031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkEQE93f5W3qrIiQKk9BZKKCez6HKRClYa+QpRpQRiA=;
        b=C9tIzGJ5MksCGHycLYWutyzPT52K0Oj0Xx147zwHjgUNY64s3sSFe/x3gOE1C7X28o
         IH0pDpjm3EEFp0/oX1uzd3BM2Cy5mX0x6Jf5stDa15gEvKq82fffWmfnXuFM7YdOJa7f
         0rI2KC6NvgxHdVlNoIwH9Qg50ey8LVqWIpwe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772231; x=1715377031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkEQE93f5W3qrIiQKk9BZKKCez6HKRClYa+QpRpQRiA=;
        b=dDjhMVX27m213BPtsD3hp3c2BD/JNlVXCukvwIxYvSrZJU3bylMhkSaWIC6Y8YEVAd
         RxL2pxG0tr8Ui2yRYQAsoLLG6pFIpP01DUZhnEOMHj+Fxujp4M1gk2RzodT6f9ZvvS8l
         IFaoF1Cdog3aC7IC7QyzY+K0NoYNvaxW+uQyv/+qCaCi6lEuh52SPJA6+UaXXDnM1sGH
         Npd6gigPGPFhLfhjOKw4rvFrIm0JSXb9auftcsfsdYBYjIOZ5a5oKy2KS/KnPIgfzysR
         JUeayhXJZZDCY7cm3hJyExlmBpj+2YhsbdldlTQKha+sqNTtrpg1ti+YWgDql6TJSXjI
         wG9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpFt334g9e9ydh/XA4S6a74RZAHv6IHlFpN87Z7dkIM2Qjor/s3/bCEa+dMYBh+ORr5anAp5UJsn3YzIbxBvdERiP443yvkm3sZCzy
X-Gm-Message-State: AOJu0YzHU4uBnXmgX+52zyY9b/NxgeX61xeFDQTD8LnD2d0m7y4T5ACj
	bf18oQN/Sq/okfTfG5SpbjoKYregVfpQU4PF+hPoGRv2BEAVb5ck8i+Va+y2cA==
X-Google-Smtp-Source: AGHT+IErDEdWQJDxA1HZWTCGw5TL3HdjrluPTuCRLtiAQGGfIJv8XgK1D0yAqk5RVYxDWbW7F4IUEA==
X-Received: by 2002:a17:902:ecc7:b0:1e3:ca5a:2d9a with SMTP id a7-20020a170902ecc700b001e3ca5a2d9amr4783895plh.53.1714772231641;
        Fri, 03 May 2024 14:37:11 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:10 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 20/48] drm/panel: olimex-lcd-olinuxino: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:01 -0700
Message-ID: <20240503143327.RFT.v2.20.I6a96d762be98321e02f56b5864359258d65d9da8@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Stefan Mavrodiev <stefan@olimex.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-olimex-lcd-olinuxino.c    | 41 -------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 4819ada69482..8a687d3ba236 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -64,9 +64,6 @@ struct lcd_olinuxino {
 	struct i2c_client *client;
 	struct mutex mutex;
 
-	bool prepared;
-	bool enabled;
-
 	struct regulator *supply;
 	struct gpio_desc *enable_gpio;
 
@@ -78,30 +75,13 @@ static inline struct lcd_olinuxino *to_lcd_olinuxino(struct drm_panel *panel)
 	return container_of(panel, struct lcd_olinuxino, panel);
 }
 
-static int lcd_olinuxino_disable(struct drm_panel *panel)
-{
-	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
-
-	if (!lcd->enabled)
-		return 0;
-
-	lcd->enabled = false;
-
-	return 0;
-}
-
 static int lcd_olinuxino_unprepare(struct drm_panel *panel)
 {
 	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
 
-	if (!lcd->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
 	regulator_disable(lcd->supply);
 
-	lcd->prepared = false;
-
 	return 0;
 }
 
@@ -110,27 +90,11 @@ static int lcd_olinuxino_prepare(struct drm_panel *panel)
 	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
 	int ret;
 
-	if (lcd->prepared)
-		return 0;
-
 	ret = regulator_enable(lcd->supply);
 	if (ret < 0)
 		return ret;
 
 	gpiod_set_value_cansleep(lcd->enable_gpio, 1);
-	lcd->prepared = true;
-
-	return 0;
-}
-
-static int lcd_olinuxino_enable(struct drm_panel *panel)
-{
-	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
-
-	if (lcd->enabled)
-		return 0;
-
-	lcd->enabled = true;
 
 	return 0;
 }
@@ -195,10 +159,8 @@ static int lcd_olinuxino_get_modes(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs lcd_olinuxino_funcs = {
-	.disable = lcd_olinuxino_disable,
 	.unprepare = lcd_olinuxino_unprepare,
 	.prepare = lcd_olinuxino_prepare,
-	.enable = lcd_olinuxino_enable,
 	.get_modes = lcd_olinuxino_get_modes,
 };
 
@@ -264,9 +226,6 @@ static int lcd_olinuxino_probe(struct i2c_client *client)
 		lcd->eeprom.num_modes = 4;
 	}
 
-	lcd->enabled = false;
-	lcd->prepared = false;
-
 	lcd->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(lcd->supply))
 		return PTR_ERR(lcd->supply);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


