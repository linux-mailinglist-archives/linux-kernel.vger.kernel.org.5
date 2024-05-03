Return-Path: <linux-kernel+bounces-168267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F78BB606
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C81282A24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F864CDE0;
	Fri,  3 May 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l54dGb3M"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671858ABC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772196; cv=none; b=YkfYMPpy+ovVWAkddbdPTxZWKhUy1BszBad/tufxNtwDkxX6J6YAl75JbYW+gvOv7CqjC9BVAgy+CvBM7GZNQvc+aIDB1AZw8C0YkselWZNA+rSnadLfeSiXvR6DoGTKXsDT68xsJmQO2CkZWTTS4rtCeyB5lNe6rTh1+PFSO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772196; c=relaxed/simple;
	bh=hj+CoHiWh664elW2n6ckmx7SmywRTNBnurnsX4qarF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJRNGFTdFMBEur5O0p0Bcjq75LMmUtwZpzF/PZ5vYDUBvIn8fuIiO3GyoGPnjOTYg/WQCn05FfhuijjmrkKFZqMglXi38iUmvZ+cZbuNm46wNuUAHnERoED/ymmLlhegxtVvlsoE5GnROhU0coBTGNSsNhVXVNY1X1U0ijwq9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l54dGb3M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e5c7d087e1so1043295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772194; x=1715376994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJSS1xLEfY3Y1Nc4TX+Fmok5eKTdIJMR9yqmN0qgIiI=;
        b=l54dGb3Milw8mz0rLL6hSc97wxza/ORGLCu51w11xuvkKqv3sF9My90wKnAMDZ74b7
         xwqkbRleSHUMl8zbq3mdV4GI1clI3vhMlbVret0G3zLXFl2ep6Qn+lWgywA4VIO7c7gy
         IYu6TYynN9LXaAPHPf/t4HPRtO7KcHbDhw5kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772194; x=1715376994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJSS1xLEfY3Y1Nc4TX+Fmok5eKTdIJMR9yqmN0qgIiI=;
        b=mtyekhMlkZqXd5Ukb5/os4103DcAoKajx/UV2EcebSA+N1BVnqZ9ziP5dfHtqXo7vE
         02vzPZA4LGbQyCB9T56tKDamUf0Qp89cE4RJXZ4+CG/jNLoc1kRK/iFAZ91X7nV6rFHt
         TX5GmLE8L5ZN+srGqRe9hBkLAxLcGm7WETF819Nwjxkq44W94nu3LsYmhqxNwMLlQNey
         +tIAdq9lkevV32QEYg3J66bL8FYW34rkdKLG26Hdye3kdlFC6t82iuFC5EUg6s3jNc1t
         AoYhPHbq6NUgomrWekxzPOO0NUfuyP4EOvUfT1wK+7twg+Omdd/LX1j6E/QvvJtOGo3Y
         ZgCw==
X-Forwarded-Encrypted: i=1; AJvYcCVLwwVE8sZEBkxzajCk7Qc0oFmeH7vo68dcv5DL3+M+oWXucEAB+N6ssje2b/YjS5hiZBgiagd2dEoyJ2sjsIsolw3+CNiwv819tf00
X-Gm-Message-State: AOJu0YwqHHotBXQRs2Kh6AiQ5NeVs252cge/p3C8WnqySsEIKlkwAn6D
	2HRDQdq/v/nMHPNJMM71lmCnk2UpIaErd9FFz4izcLugi66eRZfrDDhN8jO3Dw==
X-Google-Smtp-Source: AGHT+IF/xaXv/X0Wte4aZNJO+64pdFolxJxdcSTQcUQ0uEZBKmCrVQEqCkWitBuj2PfiwIvx+UWLZQ==
X-Received: by 2002:a17:903:41d1:b0:1ec:22ca:b290 with SMTP id u17-20020a17090341d100b001ec22cab290mr5154916ple.21.1714772194313;
        Fri, 03 May 2024 14:36:34 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:32 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [RFT PATCH v2 04/48] drm/panel: boe-tv101wum-nl6: Stop tracking prepared
Date: Fri,  3 May 2024 14:32:45 -0700
Message-ID: <20240503143327.RFT.v2.4.Ib501f2eceb62016e09cfb17bca29bde0f605a567@changeid>
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

Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 0ffe8f8c01de..667e1bb4a58b 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -50,8 +50,6 @@ struct boe_panel {
 	struct regulator *avee;
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
-
-	bool prepared;
 };
 
 enum dsi_cmd_type {
@@ -1450,9 +1448,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 
-	if (!boe->prepared)
-		return 0;
-
 	if (boe->desc->discharge_on_disable) {
 		regulator_disable(boe->avee);
 		regulator_disable(boe->avdd);
@@ -1471,8 +1466,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->pp3300);
 	}
 
-	boe->prepared = false;
-
 	return 0;
 }
 
@@ -1481,9 +1474,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (boe->prepared)
-		return 0;
-
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
@@ -1523,8 +1513,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	boe->prepared = true;
-
 	return 0;
 
 poweroff:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


