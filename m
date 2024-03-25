Return-Path: <linux-kernel+bounces-118069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7888B347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57B81C3ECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70871B48;
	Mon, 25 Mar 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OL+HjDen"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC26FE1D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403821; cv=none; b=MyuQ4q5wLbUnZy81Uk6G2Mdd8gANIKOWzoXXuNV0cqNGU3tBw7KwX37+rInaNbkp6NcaW1cBxLuVWG/jD+y76N65iSyOMTCXePekCKaaOUkxrP8XOs4ZoiWZ41xomzEiwry2tWw4OJUVKJoFFfmEuJQSTpQSFOAyfDS27vSMSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403821; c=relaxed/simple;
	bh=ngVMa4Y4C6kIuuCCqhT5eZ4TiM3c8xVLXr+IwYPYqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLOlxSL0vQWkq0ZfngwdnDaJJKWEKx/0d/5BaB0nq1580ZPlfxRQeThYROI9VyTQ1VlgmDdGF+w3SjHIMTwY/h9hYG9l8c/V5qvpB1FetzMoSRIdA6sk1xNWPX38FCEGEUm3ni5klWsg8H/lx3x9YpwiAsXPNfWzVa21W5T+Ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OL+HjDen; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0b213efa3so12609775ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711403819; x=1712008619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bVuVcBwYjbmIMugv7i5Wq0OqJpJ+55dldjg1iRzEkE=;
        b=OL+HjDenpMqzOvHpgRd5hgUoLRBZEhIwdR/Uyi+9hDG/+WJd4+BXoWaJBKo9gX3d2r
         nnAsOht9p5i7BJDN1yWzTnSuO9KnGOj6PPmWhkootUMuMrgN5Hpm4JRdvzI8RgKcBHOD
         wXlAzI2ZHQ5hj/CVT7cMTGiEpWczXMl43BI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403819; x=1712008619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bVuVcBwYjbmIMugv7i5Wq0OqJpJ+55dldjg1iRzEkE=;
        b=Z7RaYj6ghu9szsPD/zGyaHEaeu+Dybb/XzFmkm5b1fbp1HdBt5p8lRa9otd4JH+BLj
         GzMfJrrsmtb2YYEZAhfPhzaewn+KlsHtTcy5w4mCI8fOnzIJ8p2rhS9JKgZ7flDykNUV
         l8zTvh1+I+0zy+ipxswNBZLxkX7TEyZHKcmYyC6fNIfEsN9YBhKPBkxr9Re69FFt8h8E
         pNLl5zZUfQM+0kVBqJ2SYkN8DhgAZ5cu+q21zEOZdMIocCxhZHQDnE8VSoRxRiNPLqpX
         KxPcDWyQa9+mmvzT3ydOgU/7i+pe93vJYxHMcqe9kaQxpUQJSKaeMLXbGNr0M94sIIIL
         MT9A==
X-Forwarded-Encrypted: i=1; AJvYcCWY4nDx0wGX8lP3kgXiPqdLwIhJWTFcBfWH6l+Y3W9iFTkoj2kPk9i0g9W+dC199StjIe2M15Y9xu0EIDwRHEggNuCOw9gpTPGalLg1
X-Gm-Message-State: AOJu0YyQ3KV0ON8Edif0qk+KAh7EI2UuwF9zD7jbwfMeYNEF2utYLy+r
	QWAs0l8PdiIK/W9+S5yfWFzsFdQyKR9br+rQF6R9zgce4l3ixq+nyVAH19EyIw==
X-Google-Smtp-Source: AGHT+IFeEjtB0EjG3yoGX3VoRn27+gcFHG2pO1/kdc6fNCLKOImMjn5d9qKrY7U83VyykAGWyY6r3Q==
X-Received: by 2002:a17:902:eb8d:b0:1e0:10c1:6288 with SMTP id q13-20020a170902eb8d00b001e010c16288mr7281408plg.51.1711403819205;
        Mon, 25 Mar 2024 14:56:59 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f21b:7dde:93cc:b987])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5207866plf.76.2024.03.25.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:56:58 -0700 (PDT)
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
Subject: [PATCH 1/3] drm/panel-edp: Abstract out function to set conservative timings
Date: Mon, 25 Mar 2024 14:56:25 -0700
Message-ID: <20240325145626.1.I659b2517d9f619d09e804e071591ecab76335dfb@changeid>
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

If we're using the generic "edp-panel" compatible string and we fail
to detect an eDP panel then we fall back to conservative timings for
powering up and powering down the panel. Abstract out the function for
setting these timings so it can be used in future patches.

No functional change expected--just code movement.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c4f851200aa2..8a19fea90ddf 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -760,6 +760,25 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
 
 static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const struct drm_edid *edid);
 
+static void panel_edp_set_conservative_timings(struct panel_edp *panel, struct panel_desc *desc)
+{
+	/*
+	 * It's highly likely that the panel will work if we use very
+	 * conservative timings, so let's do that.
+	 *
+	 * Nearly all panels have a "unprepare" delay of 500 ms though
+	 * there are a few with 1000. Let's stick 2000 in just to be
+	 * super conservative.
+	 *
+	 * An "enable" delay of 80 ms seems the most common, but we'll
+	 * throw in 200 ms to be safe.
+	 */
+	desc->delay.unprepare = 2000;
+	desc->delay.enable = 200;
+
+	panel->detected_panel = ERR_PTR(-EINVAL);
+}
+
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
 	struct panel_desc *desc;
@@ -816,26 +835,7 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		dev_warn(dev,
 			 "Unknown panel %s %#06x, using conservative timings\n",
 			 vend, product_id);
-
-		/*
-		 * It's highly likely that the panel will work if we use very
-		 * conservative timings, so let's do that. We already know that
-		 * the HPD-related delays must have worked since we got this
-		 * far, so we really just need the "unprepare" / "enable"
-		 * delays. We don't need "prepare_to_enable" since that
-		 * overlaps the "enable" delay anyway.
-		 *
-		 * Nearly all panels have a "unprepare" delay of 500 ms though
-		 * there are a few with 1000. Let's stick 2000 in just to be
-		 * super conservative.
-		 *
-		 * An "enable" delay of 80 ms seems the most common, but we'll
-		 * throw in 200 ms to be safe.
-		 */
-		desc->delay.unprepare = 2000;
-		desc->delay.enable = 200;
-
-		panel->detected_panel = ERR_PTR(-EINVAL);
+		panel_edp_set_conservative_timings(panel, desc);
 	} else {
 		dev_info(dev, "Detected %s %s (%#06x)\n",
 			 vend, panel->detected_panel->ident.name, product_id);
-- 
2.44.0.396.g6e790dbe36-goog


