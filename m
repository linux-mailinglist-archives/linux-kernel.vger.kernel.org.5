Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73C7E827F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjKJTVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbjKJTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036F6EA0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:14:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28307847ea4so1029495a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699643643; x=1700248443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD1dV3f2O7u955hezn07tiOBc51OBGshXDAo/OfAZrA=;
        b=A5Ays0f50Ej1KUUbEz0A2pRKMiAC9tURsWqI9K1cSjtmtqoHl2XVkkcPDra7H/VO4B
         HHzk1At91mMKLEXHZ5rce/MvtBhWSSTB+qIrZTRlUo9qXggpnZbKTMiIoVbrgwGIfmzB
         Y4MplJJvVGYh/kM1JzjlN1uKnnFfR8AwlGak8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699643643; x=1700248443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD1dV3f2O7u955hezn07tiOBc51OBGshXDAo/OfAZrA=;
        b=k0iblftpcFafDumwRyUOLjkfna//rmFOsivyxreE9AXwtbyxWdtyC4dxIcMEwA4kzC
         5InHd9sznXVaAyPmXl8zq/eKUDtUGgXVEHO6VeQPHu5wnFv8yXDxjQf/NpEnxaYHX1/W
         v7rPPx8N2slMcx2E25y5tMxaFqiDk30x+oZRZxAOYsd17fHuwawdHNcTheKNN3xzyVih
         xk5BAgNBWHub8zT8ORgeDZGupBU4ZCuAORrWOz4GSzOxwy6UPAd7Rg/fnsB8BroGsUFk
         edjZAOI2vUXnMXwR0EzpNgi7E+rLO1h9VHmu0JzZo4TyQyodr5G17f73MZScenPkVazX
         +dGA==
X-Gm-Message-State: AOJu0Yz2EwNtQm6qMYNDrpWFXv2mQHoW2Mm+2A292B36WTAwUwhVVX5O
        /+kGVPssI7bxV397a3PtLHVEXQ==
X-Google-Smtp-Source: AGHT+IG56L/poRnCSG+JgnV/8FlZGz4mVVijUIZfx7X/ZKyDxkv3Cg5t+LEK6GYKkue8BeIvRwpjsw==
X-Received: by 2002:a17:90b:1c8b:b0:281:5860:12f3 with SMTP id oo11-20020a17090b1c8b00b00281586012f3mr5459831pjb.3.1699643642943;
        Fri, 10 Nov 2023 11:14:02 -0800 (PST)
Received: from ballway1.c.googlers.com.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090ad14900b00280976d4ce3sm1960160pjw.37.2023.11.10.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 11:14:02 -0800 (PST)
From:   Allen Ballway <ballway@chromium.org>
To:     dmitry.torokhov@gmail.com
Cc:     ballway@chromium.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/quirk: Add quirk for devices with incorrect PWM frequency
Date:   Fri, 10 Nov 2023 19:13:37 +0000
Message-ID: <20231110191340.4157610-1-ballway@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <ZU0fa6fvT4ZWTNXr@google.com>
References: <ZU0fa6fvT4ZWTNXr@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyernet T10C has a bad default PWM frequency causing the display to
strobe when the brightness is less than 100%. Create a new quirk to use
the value from the BIOS rather than the default register value.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
V1 -> V2: Fix style issues.

 .../gpu/drm/i915/display/intel_backlight.c    |  6 +++--
 drivers/gpu/drm/i915/display/intel_quirks.c   | 26 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 2e8f17c045222..b4171952343eb 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -1385,8 +1385,10 @@ static int vlv_setup_backlight(struct intel_connector *connector, enum pipe pipe
 	ctl2 = intel_de_read(i915, VLV_BLC_PWM_CTL2(pipe));
 	panel->backlight.active_low_pwm = ctl2 & BLM_POLARITY_I965;

-	ctl = intel_de_read(i915, VLV_BLC_PWM_CTL(pipe));
-	panel->backlight.pwm_level_max = ctl >> 16;
+	if (!intel_has_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY)) {
+		ctl = intel_de_read(i915, VLV_BLC_PWM_CTL(pipe));
+		panel->backlight.pwm_level_max = ctl >> 16;
+	}

 	if (!panel->backlight.pwm_level_max)
 		panel->backlight.pwm_level_max = get_backlight_max_vbt(connector);
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index a280448df771a..ff6cb499428ce 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -65,6 +65,12 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
 	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
 }

+static void quirk_ignore_default_pwm_frequency(struct drm_i915_private *i915)
+{
+	intel_set_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY);
+	drm_info(&i915->drm, "Applying ignore default pwm frequency quirk");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -90,6 +96,12 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
 	return 1;
 }

+static int intel_dmi_ignore_default_pwm_frequency(const struct dmi_system_id *id)
+{
+	DRM_INFO("Default PWM frequency is incorrect and is overridden on %s\n", id->ident);
+	return 1;
+}
+
 static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 	{
 		.dmi_id_list = &(const struct dmi_system_id[]) {
@@ -136,6 +148,20 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 		},
 		.hook = quirk_no_pps_backlight_power_hook,
 	},
+	{
+		.dmi_id_list = &(const struct dmi_system_id[]) {
+			{
+				.callback = intel_dmi_ignore_default_pwm_frequency,
+				.ident = "Cybernet T10C Tablet",
+				.matches = {DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
+							    "Cybernet Manufacturing Inc."),
+					    DMI_EXACT_MATCH(DMI_BOARD_NAME, "T10C Tablet"),
+				},
+			},
+			{ }
+		},
+		.hook = quirk_ignore_default_pwm_frequency,
+	},
 };

 static struct intel_quirk intel_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 10a4d163149fd..ca34dacf0c242 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -17,6 +17,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY,
 };

 void intel_init_quirks(struct drm_i915_private *i915);
--
2.42.0.869.gea05f2083d-goog

