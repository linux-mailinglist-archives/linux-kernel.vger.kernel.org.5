Return-Path: <linux-kernel+bounces-118071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FA88B34A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F81C1C25D58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEC7353F;
	Mon, 25 Mar 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ScM2dCWW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5073526
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403825; cv=none; b=SnRBmzKiYeWNP1R+Rpwbvs3UjhIdz1unP0ITnegeHkoYvTXeork+7p1WwPJL+p9pC9L0TY9OXlHz/8VG7Am8+gkgMytydQwDqelw/X+Va92r0XXjbGorz6SS/4wCPyfFW8H9lCtUa/3kFZtRMjKG97FU745IsspXaGKPOT+yRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403825; c=relaxed/simple;
	bh=Bb20oI//qEvmd75QVZ+Rh3ThPw8+5KlK9UtyeUDx1xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnBcK87wUYo/dN1/4vUr8xyDhzjhgI0ejkv4vyPxFyeB5LhfPfbUi7EoiBRWeErnHlO1a9196HJRVuHeaKhl0suB8/V3lT4V5uS5sk1KkmSenawUtc2qqdFkh+My+GTY5C3PFO7Lpy8I6YioRjjRjaNIU9tc0Qat45YE+fEQAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ScM2dCWW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0025ef1efso29701755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711403823; x=1712008623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhZQWaJshhfD9wSXRNVLw92v4FQ+jJkjj3c/jVf2VJg=;
        b=ScM2dCWWEfahm+vnXNusiYeSIY93QxxFSRCqk7nB3mWIntRVOYrsbFHhrhu+7dtHgL
         mhAlB9QQP8wNqNyYlVQJblV92LQvJzmjZPaBQCK83+deZDVyeM1fBw35NFT56//+wgTt
         XJBALzpmKIA1FFzfLNYUeGfkK4oVZ3qo28nRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403823; x=1712008623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhZQWaJshhfD9wSXRNVLw92v4FQ+jJkjj3c/jVf2VJg=;
        b=H3AcUnPnoXANcW/FcPV8kyKsNN+I+GoA05LlJBuVDKsCTefkqvQrTpGHwxmIytkUHg
         na/FQva57fz5NevyLkVwu9iJX9FvOqkPoHy8m98gjVx+6WrZisviWY2lk5/tfrAPYrmc
         1Cbeb1dJJrANC34DvnKl05ek9NyOx+60BM3F8ohT3+jbEADPC85EFF3u26D5uzy2NOJJ
         kfqRSXO7y5yXr45WXkt60USs43kXXIYIpPBnk5eKX/cQ3XrdksQThHRg4VTKdQzpmg4e
         y4e9V80d4+Z8GSUzXwA3Cuh1Bs6VCzYjjRtSnH7W5QOVVRR00HdeQdI/WSBQo0Rs4lRR
         UeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWW8W0pzbtwIlI1v0ob/np8fRRenu8xZYU47sojzKHfHUe1Uh1yjz5qEkxwOhYEhx425kW56z3QU6YvdZ83NJCx+agA58Wuf8VbmO
X-Gm-Message-State: AOJu0YzWWsTPoe9jeHBjiH1DyXgNT6g+FP3dZ5LO47RRzMEHzZNmF+kj
	Y3s/fZaTAhK3N/uwN0Rby60RSU8KDc5pAcjceR6dRp6osbPJZfIN7H2RgjJxQA==
X-Google-Smtp-Source: AGHT+IG1pvV8JIModEf24NBBDg2YYgu41Tt2PrJ+H3EuIJzXqbRq4KaflfyB/AcYHVm8d9sODDNTeg==
X-Received: by 2002:a17:902:cecb:b0:1e0:a678:5b55 with SMTP id d11-20020a170902cecb00b001e0a6785b55mr7152128plg.11.1711403823404;
        Mon, 25 Mar 2024 14:57:03 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f21b:7dde:93cc:b987])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5207866plf.76.2024.03.25.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:57:02 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Pin-yen Lin <treapking@chromium.org>,
	Prahlad Kilambi <prahladk@google.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm-panel: If drm_panel_dp_aux_backlight() fails, don't fail panel probe
Date: Mon, 25 Mar 2024 14:56:27 -0700
Message-ID: <20240325145626.3.I552e8af0ddb1691cc0fe5d27ea3d8020e36f7006@changeid>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325215631.3804796-1-dianders@chromium.org>
References: <20240325215631.3804796-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're using the AUX channel for eDP backlight and it fails to probe
for some reason, let's _not_ fail the panel probe.

At least one case where we could fail to init the backlight is because
of a dead or physically missing panel. As talked about in detail in
the earlier patch in this series, ("drm/panel-edp: If we fail to
powerup/get EDID, use conservative timings"), this can cause the
entire system's display pipeline to fail to come up and that's
non-ideal.

If we fail to init the backlight for some transitory reason, we should
dig in and see if there's a way to fix this (perhaps retries?). Even
in that case, though, having a panel whose backlight is stuck at 100%
(the default, at least in the panel Samsung ATNA33XC20 I tested) is
better than having no panel at all.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
If needed, I could split this into two patches: one for each of the
two panels that use drm_panel_dp_aux_backlight(). Since they both go
through drm-misc, though, it doesn't feel worth it.

 drivers/gpu/drm/panel/panel-edp.c                | 8 +++++++-
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 9 +++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 607cdd6feda9..0bf66d9dd5b8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -944,8 +944,14 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 		err = drm_panel_dp_aux_backlight(&panel->base, panel->aux);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
+
+		/*
+		 * Warn if we get an error, but don't consider it fatal. Having
+		 * a panel where we can't control the backlight is better than
+		 * no panel.
+		 */
 		if (err)
-			goto err_finished_pm_runtime;
+			dev_warn(dev, "failed to register dp aux backlight: %d\n", err);
 	}
 
 	drm_panel_add(&panel->base);
diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 9c336c71562b..6828a4f24d14 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -328,9 +328,14 @@ static int atana33xc20_probe(struct dp_aux_ep_device *aux_ep)
 	ret = drm_panel_dp_aux_backlight(&panel->base, aux_ep->aux);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+
+	/*
+	 * Warn if we get an error, but don't consider it fatal. Having
+	 * a panel where we can't control the backlight is better than
+	 * no panel.
+	 */
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to register dp aux backlight\n");
+		dev_warn(dev, "failed to register dp aux backlight: %d\n", ret);
 
 	drm_panel_add(&panel->base);
 
-- 
2.44.0.396.g6e790dbe36-goog


