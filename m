Return-Path: <linux-kernel+bounces-84119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7B86A250
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C621C22307
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B71534EF;
	Tue, 27 Feb 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLpKLYHB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D54CE17
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072394; cv=none; b=bAmlnUZem41wN6rxM2S0ooyRqXEg7BgrERpds/x2xYDOl4en0mmwn0Al81Sc/EGufu/pNFki44K3Uc8oNFkPQyVsmRr1DxC3W1zAYYDyQTr52qi+a0oN2sNyV6eAl3DTEUbEYr8lfz/Uf/pzsDlFGpfJFcz7q/ijAWKJBqvPNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072394; c=relaxed/simple;
	bh=zz+unVt7q5p60XbIw7tQi7Q0UZeD5a+xqYylMLrjnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak8nyWn7ejr88WlDOUheWCVkHqGDvk7YQyRZuvQkhYtYb1qnXQotJ8j8oFMjnjDkDPBCi6A57BzNK8ILcJcwKLUoLulZSBatcCmzXvFl/fPgBCLkkrv0bLHon9LVvAPiUGeI5sbKguQEJDn5i6XF2jF8c2RGWZoVvH7DQXwr4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FLpKLYHB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so25475695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709072392; x=1709677192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=siqoqedRmX2wPOUVHojbCwdAvexAbFGkcd6CPRaGDIY=;
        b=FLpKLYHBsZ8q8icyQVUQQY93fWi7+xWrN7vFipf9htxpuiNTqYSJ/IcOe5vXoP/SXK
         S9MB7cJa/3n2QB2n7otH3XQ/TLL7k0lxQddrP5LIf9qt2ZXlLDP29v5lsPRn5jOaGZDR
         xrvkhrRtw/pYBeJK0hM02QtIKvnnPOoIPsADE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072392; x=1709677192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siqoqedRmX2wPOUVHojbCwdAvexAbFGkcd6CPRaGDIY=;
        b=S2NQudM0/G4t6WMJvzWTF67tXIdKBXja8U1q7D/J93amEmivU9ufCPUR9bDW4XdjZW
         JD/CHY5fY1QSVywg4wE08G/QC/kzIxGPAScAKsL2TrnEEgMZ0KLTOSgC0URE2T/FOcEt
         og9D0nQmWAPae2qMRkMDpGetrcHvZ67HZSx+p9FMOXGSoEXkbLfs+++7oj6b7uYPDzMo
         X9aDm2TYFwK84wLYVStpW4Mbk1jGFFMP/sj4GBJJpQOZ85ngSnZu7ZleZlemO2ss62Uu
         LI9/5TBeF9/r1ljG8rM6vWMzgXIt/U7b0wsFHUP8LBmX0MrhaMec4dCqSHs8+0gWNyuT
         uKCg==
X-Forwarded-Encrypted: i=1; AJvYcCUiRyU+RrS3i5tv9pY+8+82VcORBchOQ/egocsy4X9PW6SVze6rSmxJaeNeD/dR7YPQbIkdZfJmyTcd3sb6QvSzErulwF+TEzB6iUgI
X-Gm-Message-State: AOJu0Yz+ltin+enYJwlj3oL4d/DborpUjj0jIOAdIuJnUftiEpvx0wd/
	66GRPqp6h3IiQqAobFAKRPExaD2YqWtsBAHPqiRlWLX2lV8m2/dmLb9pA24dFw==
X-Google-Smtp-Source: AGHT+IH1lcjzhqQizUXuOPIrr9G1+WlHe9Wkmz7qQRPWhtBpFB1p3i5u5gHC00NhNR/XxtpIWOdy9g==
X-Received: by 2002:a17:902:dac6:b0:1dc:c445:b253 with SMTP id q6-20020a170902dac600b001dcc445b253mr1771550plx.36.1709072391882;
        Tue, 27 Feb 2024 14:19:51 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ff74:aba4:ea8d:f18e])
        by smtp.gmail.com with ESMTPSA id f13-20020a170903104d00b001dc78455383sm2006780plc.223.2024.02.27.14.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:19:51 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sean Paul <sean@poorly.run>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/udl: Add ARGB8888 as a format
Date: Tue, 27 Feb 2024 14:19:29 -0800
Message-ID: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though the UDL driver converts to RGB565 internally (see
pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
compatibility. Let's add ARGB8888 to that list.

This makes UDL devices work on ChromeOS again after commit
c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
commit things were "working" because we'd silently treat the ARGB8888
that ChromeOS wanted as XRGB8888.

Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/udl/udl_modeset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 7702359c90c2..0f8d3678770e 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -253,6 +253,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 static const uint32_t udl_primary_plane_formats[] = {
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
 };
 
 static const uint64_t udl_primary_plane_fmtmods[] = {
-- 
2.44.0.rc1.240.g4c46232300-goog


