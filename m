Return-Path: <linux-kernel+bounces-67731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222C856FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D231C21B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06901419B1;
	Thu, 15 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CZJ2wMMY"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFC1420D4;
	Thu, 15 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034711; cv=none; b=txCrd9yl+JzBn2q2HchU8td9P/sT/iOYVC5GxzRcJ2oPV1N/sazI6ICuqsjRO10gSuFPM0yjx7MBDaZePG0mCFluu6N3ITaq0oxj4KF110gOMHIfKZKlQB+hFE5zwSLVakEoOOJTho5Hby/hgcST81s7HlvX5JZwPvYu/5IA+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034711; c=relaxed/simple;
	bh=ipHGcTNFt2L60EUgIOT6z3XhY/RM+pxVLwQKS22O3Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fqf3YqguAj6iR7IqeFMBJ8OLwh4nBtgjDwCbVTx+Fs5Y0Ghe7EysZGfnajsef4NNYY57+FbeIdIau9X8yevgN3G3WaFDdTFgBYOTo8BVPRPJfjfWbwuAUl4rDPoyQGpxnvEctY9GYedX2OfDMOAJiNB1QDqzlVXISRsF6QeUuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CZJ2wMMY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511a4a1c497so1558322e87.3;
        Thu, 15 Feb 2024 14:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708034707; x=1708639507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rc6eGU7njaSrd3gOPv3RWA0Ip0OaiWxwVmzreal714=;
        b=CZJ2wMMYvYxC67/KJQ6kbOGnA2WFKkcQUwIfcLd8s4djE5DYi5BVyM/bnjV4yk4AIg
         XIA/ZCB/jb6s9IORTPgGpPBmK0SXCaCdzpe+hVtlQhrHWlCPslcafwwOthsFwsQ/o7GS
         Uftc0W8Q2YyaTcfyT4LHDjSZS+PSsLT1EAENHrmYN21uqKYZwknksd7QY8oRojMPfAZl
         3l1umMYwNFYxQStYGAXX5CusCBrMzkpLlxedRLpWZEt2xegZ29QBhnyXIpGj0p2foDSg
         s2SiYYkz7F1WjSWldFdlR07glpd9OL0oX4nUVSqmFZ34BZfc+i1VkUKWPmnT/jskOVJN
         5CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034707; x=1708639507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rc6eGU7njaSrd3gOPv3RWA0Ip0OaiWxwVmzreal714=;
        b=oXwBruRCqb4clQZ58slO9OjmfjSFEwlmKDPy+UUx0eSLi5mywSFEdq4Llw/JSDiM6L
         R0L7cq4rseIDRcWVbNLQK/S9E97CO73K1QYwBRkUsVcXQUUYItVgOr34hfMD32XfrzQ5
         3iAogDb+pw1ga4wQ1my9yiNxdnWNIoK0zHLYphp4FkINYO0HeZUs65hQpFAoxGJKcoTi
         aXXZgFZLcYHd3CdRFGPabHj2VQUePlMhNryOxzRD+zr5atfVK1G4frBQMo6De/3kaEdQ
         alxjx+suKnfTkHlvHBG++MC/6YITqlx9MyU7kqlPCWCUIDZQYzRgHYW6Syi9+NQqRgov
         jr6A==
X-Forwarded-Encrypted: i=1; AJvYcCU+29pBr1eftuD7GQM58uB0rhGeyeifNrPTMjSmd4wIlXHmDpvLHfK4cHS4fK3D6wEebmimKXSI/Ap9+zO+YYFDfBI3KoHIiz8tnTUaj58eqvRXDQSEKHcLnxbnvrJNbCEuj2Zf
X-Gm-Message-State: AOJu0Yyf/hukki069X4l8s+moEFnpTitd7pFzLT8p14X34D7gGc1m2vc
	oGOx0KhiQr95OiOi8ieBbFR9zZHj8wsymWhQ9gDbB74axaOM3Mzz
X-Google-Smtp-Source: AGHT+IGSIYZ0XnvTKya7l899GJk/rCpQGsTezNi2GKDId5wCowIGk1MLv8BFbvHyGiVhfeUDOVhy5Q==
X-Received: by 2002:a19:e054:0:b0:511:79ef:529 with SMTP id g20-20020a19e054000000b0051179ef0529mr2474521lfj.55.1708034707051;
        Thu, 15 Feb 2024 14:05:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b54-ff00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7b54:ff00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id p17-20020a1709060e9100b00a3d11feb32esm945630ejf.186.2024.02.15.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:05:06 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	adrian.larumbe@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	stable@vger.kernel.org,
	Steve Morvai <stevemorvai@hotmail.com>
Subject: [PATCH] drm/meson: Don't remove bridges which are created by other drivers
Date: Thu, 15 Feb 2024 23:04:42 +0100
Message-ID: <20240215220442.1343152-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop calling drm_bridge_remove() for bridges allocated/managed by other
drivers in the remove paths of meson_encoder_{cvbs,dsi,hdmi}.
drm_bridge_remove() unregisters the bridge so it cannot be used
anymore. Doing so for bridges we don't own can lead to the video
pipeline not being able to come up after -EPROBE_DEFER of the VPU
because we're unregistering a bridge that's managed by another driver.
The other driver doesn't know that we have unregistered it's bridge
and on subsequent .probe() we're not able to find those bridges anymore
(since nobody re-creates them).

This fixes probe errors on Meson8b boards with the CVBS outputs enabled.

Fixes: 09847723c12f ("drm/meson: remove drm bridges at aggregate driver unbind time")
Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc: stable@vger.kernel.org
Reported-by: Steve Morvai <stevemorvai@hotmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This issue was reported by Steve off-list to me (thanks again for your
patience and sorry it took so long)!
The Meson8b VPU driver is not upstream, but the problematic code is.
Meaning: This issue can also appear on SoCs which are supported
upstream if the meson DRM driver probe has to be re-tried (with
-EPROBE_DEFER). That's why I chose to Cc the stable list.


 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 1 -
 drivers/gpu/drm/meson/meson_encoder_dsi.c  | 1 -
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index 3f73b211fa8e..3407450435e2 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -294,6 +294,5 @@ void meson_encoder_cvbs_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_CVBS]) {
 		meson_encoder_cvbs = priv->encoders[MESON_ENC_CVBS];
 		drm_bridge_remove(&meson_encoder_cvbs->bridge);
-		drm_bridge_remove(meson_encoder_cvbs->next_bridge);
 	}
 }
diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index 3f93c70488ca..311b91630fbe 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -168,6 +168,5 @@ void meson_encoder_dsi_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_DSI]) {
 		meson_encoder_dsi = priv->encoders[MESON_ENC_DSI];
 		drm_bridge_remove(&meson_encoder_dsi->bridge);
-		drm_bridge_remove(meson_encoder_dsi->next_bridge);
 	}
 }
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 25ea76558690..c4686568c9ca 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -474,6 +474,5 @@ void meson_encoder_hdmi_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_HDMI]) {
 		meson_encoder_hdmi = priv->encoders[MESON_ENC_HDMI];
 		drm_bridge_remove(&meson_encoder_hdmi->bridge);
-		drm_bridge_remove(meson_encoder_hdmi->next_bridge);
 	}
 }
-- 
2.43.2


