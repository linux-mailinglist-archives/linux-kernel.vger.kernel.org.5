Return-Path: <linux-kernel+bounces-168293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAADE8BB636
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA404B24610
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9183CA6;
	Fri,  3 May 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="do4ZuScf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2813340A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772253; cv=none; b=fZtkPZzcK8c5OX7Lw8f0sIMlsIxpjAUzPaZYGbFygVYnl53lhv5EfXgPxv8tGaZmz9CdWR8oIa4yMPvHhw7KxUhHz3crl2nVrdxBQKUyxgrxEh0ykgRjPrkQQpsavBsgd7QriWdp7oaLGxSxNbGYlQD8XrwKHAPPOhpbn044KmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772253; c=relaxed/simple;
	bh=6fe49YSjC4fc9GTEHnSGsu0MOQDQF/+C3YTKVOAm1sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVU6G13vYnR8a6J8EKLeQUYqdxL8iTxUFFnhNP0IJgXVN9D06OJEtKccMLkXrk0dY6pv+YOdddgXvxj31weGWWz3sDnFj8MjJDdEhJ/ZPBh1tdfiijZt1TWRNxBc/RUOfFqOrIlvo8DAlrd/M7/dGT45FtrbG6QAacP380QeCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=do4ZuScf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec486198b6so946505ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772251; x=1715377051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk2LC4K5RJqsx2QB9+nJgz+tBqijGejd/DYbrsWwU0M=;
        b=do4ZuScfLSh6LbMmS8dwFNsxsklId2q2gmRNI3TCZLVkwdTguVZf1ju/TZW4LTLj5K
         dgEzzXkc33yPV7FgQABmal6NvXzE3UgJvUMcOMhoiYFBm6okg8erjG2A3J1t8uJXsbv1
         NDSJbQ8nucIbUr3L/Td+5sSG+u0rFy+J+lT/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772251; x=1715377051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk2LC4K5RJqsx2QB9+nJgz+tBqijGejd/DYbrsWwU0M=;
        b=LpOn/RV0TA3Y7M+jrzouOo88Wi+9RTFJe6VbL7hh+zRIiIJhcdqIHZO7LKwte4GmCI
         WXyGTKoXh7vC7Us5DX5CgWBKPFa7dh2tJkuE8UCoYOZUQeKy73a9I+1IMvGG7A1BpGlr
         UStqV04XG8svmtC2IFegSKV52LiDSnZO/xzOqZ3dFah8AHDPI0V6kqAfjEpp+Agi+0At
         DzPklN04VLUq80UGJxxxDDZDCeXgxs5fGECa6AoOpRvmdzSnHJkMWXKj2hkzHn8KS7OW
         HdSjxwQT0OBpRr8PYiUReUHi+6wS54Z2yE1mg/xrk+oP34QkpZPG8K+cOFfMSRGChfYT
         SA6w==
X-Forwarded-Encrypted: i=1; AJvYcCVLIV6Sz6cFvLel4ZEe+1Xn9evWQVgTTqyupUujwJkrGI9/0l8H1tDOaFenWOKVdEPRmrywaNHEUY+jjIYY1h7YPYAKj8BgYcjEXZnA
X-Gm-Message-State: AOJu0YxnGBqZ8V3pA0a/zBJHtgToBXX7EaemOtcQlfgSf+Y5huhl0gKN
	AKD24LyF27MUY5vJD9KLNXI55s798q8YuUYbJlotDcSITrsbDy71QFJbWLbyEA==
X-Google-Smtp-Source: AGHT+IF25tSPTopP9g7n30MtXJROijO2HKPmfXJa+9xCs2KvJx4G7kvTTz0Y7toa0BkNX3wlMPNHNw==
X-Received: by 2002:a17:902:f685:b0:1eb:309a:ebdc with SMTP id l5-20020a170902f68500b001eb309aebdcmr5394677plg.30.1714772250902;
        Fri, 03 May 2024 14:37:30 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:30 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 28/48] drm/panel: tdo-tl070wsh30: Stop tracking prepared
Date: Fri,  3 May 2024 14:33:09 -0700
Message-ID: <20240503143327.RFT.v2.28.I5025ab14adc2efeef1be1843648547fb725106be@changeid>
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

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index d8487bc6d611..36f27c664b69 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -24,8 +24,6 @@ struct tdo_tl070wsh30_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *reset_gpio;
-
-	bool prepared;
 };
 
 static inline
@@ -39,9 +37,6 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
 	int err;
 
-	if (tdo_tl070wsh30->prepared)
-		return 0;
-
 	err = regulator_enable(tdo_tl070wsh30->supply);
 	if (err < 0)
 		return err;
@@ -74,8 +69,6 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 
 	msleep(20);
 
-	tdo_tl070wsh30->prepared = true;
-
 	return 0;
 }
 
@@ -84,9 +77,6 @@ static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
 	int err;
 
-	if (!tdo_tl070wsh30->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
@@ -103,8 +93,6 @@ static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(tdo_tl070wsh30->supply);
 
-	tdo_tl070wsh30->prepared = false;
-
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


