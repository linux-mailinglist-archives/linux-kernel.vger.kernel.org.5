Return-Path: <linux-kernel+bounces-168311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258B8BB64D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856811C20A85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FFA137917;
	Fri,  3 May 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dctPQnKg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07819137766
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772294; cv=none; b=rpYhCnkK9tbbnGMK8CQEI16MKMPTsA9v6qZYcJmxfnHOl/UtzwSkAr3IRGVzRVfjVVBzzMs1ITEHaQJE2exUJHHzmKwuEzh0gAbW2TFmtUEmi8RPLkSA5bHVWeA1zivr2bxz4lnEM6L+TLoh+7pdkvz53iBrEZVeEYptkh3klkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772294; c=relaxed/simple;
	bh=wi3nhmfubaEs7FDrXqrqYUjUQwr5WxQmbUhvxgTasvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO4oIf7l4uCV2v964HNkRqT5sDfN7P9ZohabygVLXDswzIQ3EbwtHvBLyhAJdfDfXnljO7QdcUzvEOpVI/Cvm3OermssquDnhfuy23jJlRTBDvefkNJ3P6KZ2DDUUULwWkBpUxZU3q9t9qttCa3iNJdG3ElZrqHnJhU1J64R9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dctPQnKg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso733305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772292; x=1715377092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9J+mwbNCcE7m50P9Dlsv1H2Zyb5eg1SoTrNCCSKKxs=;
        b=dctPQnKgta/9VLmEkKA7V7Bmlord9jpRKM7e1lcSKJqOTSJAvvU8MUPsee4Jf6FnEQ
         QAHfnPXR7oyyUveBYTozIAO8ztruoqKNHQutO5r7tFU2f0V5yCplDSdBq7TpOYZPEkbV
         SWV9nnEX6xBfTCLDl94DUekp8h1OYMmM0OijI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772292; x=1715377092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9J+mwbNCcE7m50P9Dlsv1H2Zyb5eg1SoTrNCCSKKxs=;
        b=F7vNHpxP0InFUidowu47dkfrMYd2LpoWOm7R020h2J8AzriEZDYgra9jH6fCsLm3x4
         w+DuF8bjZFKORIRZ2mm5q+zRE6YWKORlSNrlaip3l8gCyiIocccQpIaJVzqyX1/YuUUx
         0FXwZA22aUJVW4c4Qyqa/oElAK3+pFUau2xN4e+e4C2MsaS6kpVOQ36zWpiGY0DGDhS5
         1Jqn4aHbQaqrGNe1HYz2qjrfL4+AGVDb1OdzSdszp4ueG1Tlgb2INlMHA1SylLCCx2ge
         ONsyQxQfTJDJpZcA7Q0bde/DMj5CnX5z+qzGzuLtaRWHZIIeLkEmiIYHnhYO32B4Uz26
         prsA==
X-Forwarded-Encrypted: i=1; AJvYcCWKbfqxy/5TEboS5bOti0NfhIyBn6JsX8QOI+wl2uCUMt2SFbzVHrYZvvfr22GIi1YQHre+fiJN1wyAxRTW5R61PyNa8uMSQv/0bW1k
X-Gm-Message-State: AOJu0YxciW4yP84QD804r1ElUC0YL58HnKOV6Hq9eUfLLWcZ9gbHwIac
	e9vDwxv4Vr8f5Y8Qi6mJpgBOkTxK4YmPmWo9xk6vdaujDBQE7Ev0VI3ZrmWvTQ==
X-Google-Smtp-Source: AGHT+IEhvNbol5zNlkCIgLPtF12l61bvixPmv0EHaY4itQnvJImVMXDJ99WT0lhGIYbPhxxJaaynFw==
X-Received: by 2002:a17:902:da8c:b0:1e3:cfc5:589e with SMTP id j12-20020a170902da8c00b001e3cfc5589emr4661779plx.64.1714772292404;
        Fri, 03 May 2024 14:38:12 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:11 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 46/48] drm/panel: sony-acx565akm: Don't double-check enabled state in disable
Date: Fri,  3 May 2024 14:33:27 -0700
Message-ID: <20240503143327.RFT.v2.46.I6a51b36831a5c7b2b82bccf8c550cf0d076aa541@changeid>
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

The acx565akm seems to do some unique stuff with the "enabled"
state. Specifically:
1. It seems to detect the enabled state based on how the bootloader
   left the panel.
2. It uses the enabled state to prevent certain sysfs files from
   accessing a disabled panel.

We'll leave the "enabled" state tracking for this. However, we can at
least get rid of the double-check when trying to disable.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 3d6a286056a0..a9a545a56404 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -454,9 +454,6 @@ static int acx565akm_power_on(struct acx565akm_panel *lcd)
 
 static void acx565akm_power_off(struct acx565akm_panel *lcd)
 {
-	if (!lcd->enabled)
-		return;
-
 	acx565akm_set_display_state(lcd, 0);
 	acx565akm_set_sleep_mode(lcd, 1);
 	lcd->enabled = false;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


