Return-Path: <linux-kernel+bounces-73713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051D85C785
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E821B214D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3FA151CE3;
	Tue, 20 Feb 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EG3j6/I9"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF2133987
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463617; cv=none; b=SAH+tcCgy9GPplr4ATw4kk5redPe5NVu/eeO0n3NqjEwsitLo6LpE0/iJag0G82YWyqgIpyfdjvqXMx9Sxdh4k3zNh9d557N051RoJvDU+eE8iK2qUhmjn9S51CsuBUdsfkKuGGbQ55zoVDXTdlOvD/GK1unna89aB92RDCDHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463617; c=relaxed/simple;
	bh=mWs5E7X9FqqKixvWnOWdMsVW4SYoh7sLP2BfN7RgoR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcmd9hXGOdgkw3tn7r81cpKsUplxe3jl3b/CT1G0bDUuO/vx+nAytF6mRe9439rsGHhSguS4Hkf3NV75YCsJ+wct9YnaxqwWzp4t6rTGUKR74FUH/kGC5XFPZZDdk+9THJw8pmObKOvc1EDHlucatXvuXNmJBAS7QvgANHIEN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EG3j6/I9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7872614af89so507133885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708463613; x=1709068413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFUM0XDK0ZVTj4kCTskFg/BdpgZIKaoWZSjy/zINkgc=;
        b=EG3j6/I9Z5Jm4bWXTV2g1jHigwYYQROjjcSxntOaQrErUExWYCS98lGNVOdmw4Gy0J
         qoPO4LFT5w7rG3NiXbY4eNmlYtuCM34XJmsIQyEUspvbY16fST2ppN5We/PnJEDaBhqc
         uVpveO1qD3KjD64uzp+411zJcD+yP6qGXwCDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463613; x=1709068413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFUM0XDK0ZVTj4kCTskFg/BdpgZIKaoWZSjy/zINkgc=;
        b=DVd5VauH/aq7C8m2qbdj8EFIRflbk8p+y0F3i3Wn4+6NRvTzY0U7JaFeTVl6K9ihXp
         lXKjeneOy8aqEzceTj7R7y7E15N9kAHHeLjSJT9OHitnKNYkIOfZhEZrVvraDjB8ws5m
         EMZINnZAYiXQg/0BglMybiwwgC2cKOmeRfpbwTJDjdftCgSCL1YA/f5CS5GaHSplzv3v
         0mHxwEIPsBDl/BYFyagNTmE4JOc/u7r/rSdeUCKCIBS9ayFfkvmf3l0NmcT7GYG0H/Gj
         cXmtwO0/4qZpfie7khy2XTnP0eRIO83hnmYCEyxHl5FmIXfHCPmmKjA8kOKPOwSQ/nH0
         F6LA==
X-Gm-Message-State: AOJu0Ywj1mhkZqFwJxcXjBCMUT3fkDe1amphrBLbjRdpIMZx2T0xbC9R
	5qs15Mo69AAHp3Z554ceNuCM+RkK09OBBcrKbWXRX4ko4HKCagGZiag8fNyPPUmE3O9AmA8uIPU
	=
X-Google-Smtp-Source: AGHT+IGb3TRgQ5pvEKeyUOQD9tS5jn+SqfoEY02pd04BL8Wl35Z1DguYO4ZJspag7M1nm0GQDt/d2Q==
X-Received: by 2002:a05:620a:e8b:b0:787:38a4:7bdd with SMTP id w11-20020a05620a0e8b00b0078738a47bddmr22892813qkm.2.1708463613174;
        Tue, 20 Feb 2024 13:13:33 -0800 (PST)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a134100b0078726621376sm3701207qkl.118.2024.02.20.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:13:32 -0800 (PST)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v1] drivers/i915/intel_bios: Fix parsing backlight BDB data
Date: Tue, 20 Feb 2024 14:12:57 -0700
Message-ID: <20240220141256.v1.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Starting BDB version 239, hdr_dpcd_refresh_timeout is introduced to
backlight BDB data. Commit 700034566d68 ("drm/i915/bios: Define more BDB
contents") updated the backlight BDB data accordingly. This broke the
parsing of backlight BDB data in VBT for versions 236 - 238 (both
inclusive) and hence the backlight controls are not responding on units
with the concerned BDB version.

backlight_control information has been present in backlight BDB data
from at least BDB version 191 onwards, if not before. Hence this patch
extracts the backlight_control information if the block size of
backlight BDB is >= version 191 backlight BDB block size.
Tested on Chromebooks using Jasperlake SoC (reports bdb->version = 236).
Tested on Chromebooks using Raptorlake SoC (reports bdb->version = 251).

Fixes: 700034566d68 ("drm/i915/bios: Define more BDB contents")
Cc: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

 drivers/gpu/drm/i915/display/intel_bios.c     | 22 +++++--------------
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |  2 --
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index aa169b0055e97..4ec50903b9e64 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1041,23 +1041,13 @@ parse_lfp_backlight(struct drm_i915_private *i915,
 
 	panel->vbt.backlight.type = INTEL_BACKLIGHT_DISPLAY_DDI;
 	panel->vbt.backlight.controller = 0;
-	if (i915->display.vbt.version >= 191) {
-		size_t exp_size;
+	if (i915->display.vbt.version >= 191 &&
+	    get_blocksize(backlight_data) >= EXP_BDB_LFP_BL_DATA_SIZE_REV_191) {
+		const struct lfp_backlight_control_method *method;
 
-		if (i915->display.vbt.version >= 236)
-			exp_size = sizeof(struct bdb_lfp_backlight_data);
-		else if (i915->display.vbt.version >= 234)
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_234;
-		else
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_191;
-
-		if (get_blocksize(backlight_data) >= exp_size) {
-			const struct lfp_backlight_control_method *method;
-
-			method = &backlight_data->backlight_control[panel_type];
-			panel->vbt.backlight.type = method->type;
-			panel->vbt.backlight.controller = method->controller;
-		}
+		method = &backlight_data->backlight_control[panel_type];
+		panel->vbt.backlight.type = method->type;
+		panel->vbt.backlight.controller = method->controller;
 	}
 
 	panel->vbt.backlight.pwm_freq_hz = entry->pwm_freq_hz;
diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
index a9f44abfc9fc2..aeea5635a37ff 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -899,8 +899,6 @@ struct lfp_brightness_level {
 
 #define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
 	offsetof(struct bdb_lfp_backlight_data, brightness_level)
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits)
 
 struct bdb_lfp_backlight_data {
 	u8 entry_size;
-- 
2.44.0.rc0.258.g7320e95886-goog


