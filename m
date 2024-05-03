Return-Path: <linux-kernel+bounces-168310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E71D8BB64C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89601C215D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89429137775;
	Fri,  3 May 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NPr1KpgS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADB13775F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772291; cv=none; b=eyxzaReKdmW0pa5qRf9ZChXZ2zY3mV9ogT/6mzHMerhMwXqqE+6jHrlFxGqHKKoFn67xQSmJ1FoHswmllyzjf/alV9h28/cXvg/O3La2KYsyLKyDZlxvUxe/xQlDWLz9nWqTgPTK4z7/OngSKPQssPryZvubQLdnnR+9FWp6io4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772291; c=relaxed/simple;
	bh=mdz7Fil6G5HtVsThsciyp8mFKe8053PCBwsR0ckmCe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHBHWWetPSiifb0Cw6d160Ed1zJHi+u408P6V07XOcnuHJlLG+jKOO+68jH3V+7lZSEtfJ6RdX06rJjoXXyXbtfqBPD9ASW6hy7TITPWVwDVSzkuTky7VQjPL7gKyAmvpB/l5JMAFtbbB8HqLAtT7KrFWG/Yp0KEE01Uqhx0N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NPr1KpgS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso791345ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772290; x=1715377090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmnOhTLenfwPbkZ+9fOpNpevbnj0AgHZgHCpxDLbWgM=;
        b=NPr1KpgSXZk5gKHbyx0ZceKqrUITAdaA32k4r1g9A6aMu3BW9XKr8kBsKVQyw2CWL3
         dUtdGRb4ohTG8IpHXhIHKybsy/FWBw6TMAua46EOUA5kNS8eHLFH5cPs/c6vQZY0aTWx
         akdO+qllMGtLIGV3Opv29qLFUVSLgO5XjLVbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772290; x=1715377090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmnOhTLenfwPbkZ+9fOpNpevbnj0AgHZgHCpxDLbWgM=;
        b=FEEXWAbdOgWf8O+1OLcMiSnoZdWoeylcecj8dfLqJayDLq7PuKzfuGT0y0+xgK2DTG
         lbJnVV7a5dSQV8EyyijdEyM+o95kxI/BAW1kDt6elM4obJkD7KTBb7E6M2xOmnV2TsFB
         LA67tRYK2Oq++0womuWT0axiFXTbFn55bjy9wSJv7mKvEd1Zl5zwnAfZMCqfiNeiTRFs
         vDYVQGFEVROTVhpRqLslIpHaZbQB5hrnm1LMtHxcXUXVY/H8Vj85pWjxjKPX7k9mqZDz
         +9iHZIlJEdEDUKwA3gEhOgL4CfIjq9Glx5w23LLbrd1a6C87/dJjImwnfXqYo46g8mv5
         +0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXxqSTH/HSC6KpeO2s9Hpkp51T/8QRDriUKfxVWRl4cdfiapLcrmm9q4MPQWgt2yJv7c9oOHYW12xDzNKN5YG0Hfn6jewJ8gwmjPMxi
X-Gm-Message-State: AOJu0Yy/ASgm7+vrX+2JhN72zK9Ul/BB4o52QATGnShXc/f3buQ9Cxyc
	/bqr1nS+5ku5ddtrAul5WH3kTXPUiSKRFGudFrR8aKM88QPSrRG2vQkd0EXVLA==
X-Google-Smtp-Source: AGHT+IGBGVcpKQhnQ/va5QMpwiScWawVFF//2NM+v5dTbUM+lAsV+J43k0O4T3CyMAnt3mgiK6JpMQ==
X-Received: by 2002:a17:903:234b:b0:1e2:b13f:bd64 with SMTP id c11-20020a170903234b00b001e2b13fbd64mr5192227plh.0.1714772289909;
        Fri, 03 May 2024 14:38:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:09 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 45/48] drm/panel: raydium-rm67191: Don't call unprepare+disable at shutdown
Date: Fri,  3 May 2024 14:33:26 -0700
Message-ID: <20240503143327.RFT.v2.45.Id14188f1a8af7d524751c27c343a5b583ff5361f@changeid>
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

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by IMX boards. The IMX driver appears to be
correctly calling drm_atomic_helper_shutdown() so we can remove the
calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index fa9bf89d3bb5..b2029e035635 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -612,14 +612,6 @@ static void rad_panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&rad->panel);
 }
 
-static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&rad->panel);
-	drm_panel_unprepare(&rad->panel);
-}
-
 static const struct of_device_id rad_of_match[] = {
 	{ .compatible = "raydium,rm67191", },
 	{ /* sentinel */ }
@@ -633,7 +625,6 @@ static struct mipi_dsi_driver rad_panel_driver = {
 	},
 	.probe = rad_panel_probe,
 	.remove = rad_panel_remove,
-	.shutdown = rad_panel_shutdown,
 };
 module_mipi_dsi_driver(rad_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


