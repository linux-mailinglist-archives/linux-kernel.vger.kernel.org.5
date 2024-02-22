Return-Path: <linux-kernel+bounces-75751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6C85EE70
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665881C21734
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D311C83;
	Thu, 22 Feb 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+xdCPg0"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0108F45
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564017; cv=none; b=KWn7Yd8i0z9JMMvfX/2gDn929KYySmFQMgrX0awkghpw/DR4+JlHr5lQNhS3QrfiD9HrbqG5Iy8OgPlcywCrd4kdbTXOFUcsRb7XkG4/1Ba62tIpAlqt7KFTlbrMlYzsiOzn9nQHy24MKy5J9HT+LGoir4w84AfzSNgxlGBIs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564017; c=relaxed/simple;
	bh=Gvr78U7hYEaPZ6Fw/xNXoET2lyRuzDhOlH1UDF1/VvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bM+XHgUiu0eEUkokzRLDeHJXhc8UYbFZapMe0dfrEZmYzIf15uKJS3ksEUTgBHmKkX2/95WuzsyYH4IadyPYriqAskvBVAW88CuTu4NS2fr5EFLHqYuXBUVi0zBszgdZlEsetDSrSgsLnO2LDmtPRGGyXa87kabn+bMicBunhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+xdCPg0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-781753f52afso419033285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708564014; x=1709168814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=po77JXYuDK3AKWrYAL7OCKeGjP7qQRekYB5EzyekFyU=;
        b=I+xdCPg0AcRdIZ6INW5BUqwQ6F9OEOr45l2uREuIdmwtgO9LuoXoTOxFtaFxONhWat
         Gobdx1nd5dCAOSD3TZXaDRFnb6vMHjAZZe2blrBuroEiF1cw8SfFRN8RjRzx288d0Jxa
         hMSLbvxyhYfGlnwezQlieFeMana0+gMDLFmUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708564014; x=1709168814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po77JXYuDK3AKWrYAL7OCKeGjP7qQRekYB5EzyekFyU=;
        b=bmsNtZApeDYRAIftwFSJmaRwTpX2J/59JWPT6hBgEYnsMVYLQlawgQm6+guhnwFoFO
         dAgrCcRzw77pmGs2gPjx9ljAp0mE8vixbYSO6tAa57nmvNDfIIqtby00zqnH8O3OulU9
         KCXP3XnMlXw/NqXErNrNkc3UUnhetHDkE4KuPEx1McFKmSg71asggp/qgALRAUEpIjTQ
         He/o1MvWDhFJVIl9kCEPJC/zydpX9RRrl9Oify3pV2gBoHASt0W+KJEDhPXLInlnMDoF
         oI1LKa93QqAYWnYGU6VCCLLck/d02NbBF2Qts6bxIUIpvBy9Qw20KjDlwIpfJJQlJ062
         0xRQ==
X-Gm-Message-State: AOJu0YxbQ0CuXadCwwNSr0NXx469uPvuJhSdzKl2wZryMZApM8AxgYxD
	WtBohkt/hQGxDtDAr1hnIgQgymAWF/djqxKjIc+FvT77ZGWbyRqUozIlUQc8O/O40CLCZFsVAFE
	=
X-Google-Smtp-Source: AGHT+IEp7Fn0i4KJjuMnYv+dMkHmf+oY47g69f2lZyjT0/QpWePXbGK3ufigwAivUZ7J5jtwbH3koA==
X-Received: by 2002:a05:620a:167c:b0:787:1fb5:7e61 with SMTP id d28-20020a05620a167c00b007871fb57e61mr21927202qko.46.1708564014394;
        Wed, 21 Feb 2024 17:06:54 -0800 (PST)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a21c100b0078597896394sm4789415qka.51.2024.02.21.17.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 17:06:53 -0800 (PST)
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
Subject: [PATCH v2] drivers/i915/intel_bios: Fix parsing backlight BDB data
Date: Wed, 21 Feb 2024 18:06:24 -0700
Message-ID: <20240221180622.v2.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
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
extracts the backlight_control information for BDB version 191 or newer.
Tested on Chromebooks using Jasperlake SoC (reports bdb->version = 236).
Tested on Chromebooks using Raptorlake SoC (reports bdb->version = 251).

Fixes: 700034566d68 ("drm/i915/bios: Define more BDB contents")
Cc: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

Changes in v2:
- removed checking the block size of the backlight BDB data

 drivers/gpu/drm/i915/display/intel_bios.c     | 19 ++++---------------
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |  5 -----
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index aa169b0055e97..8c1eb05fe77d2 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1042,22 +1042,11 @@ parse_lfp_backlight(struct drm_i915_private *i915,
 	panel->vbt.backlight.type = INTEL_BACKLIGHT_DISPLAY_DDI;
 	panel->vbt.backlight.controller = 0;
 	if (i915->display.vbt.version >= 191) {
-		size_t exp_size;
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
index a9f44abfc9fc2..b50cd0dcabda9 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -897,11 +897,6 @@ struct lfp_brightness_level {
 	u16 reserved;
 } __packed;
 
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_level)
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits)
-
 struct bdb_lfp_backlight_data {
 	u8 entry_size;
 	struct lfp_backlight_data_entry data[16];
-- 
2.44.0.rc0.258.g7320e95886-goog


