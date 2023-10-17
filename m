Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535FD7CCA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjJQSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjJQSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:03:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670659E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:03:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d0acd0903so3757757a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697565826; x=1698170626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZe4Izl0NOH1/nIrnEIDX6DLuh+4li4EhUKl+KwsF4Q=;
        b=OYyok9zbirWgLWCXpgvjJ6E2SWCzIrAb6HqGQg4/TrIKsyEV6TUe9K866oQkxs5DE2
         hyowsA5jZW5IqttbCldSbP/C5XvjXGDXbu/5olQhRAMspP6ufSEzqsbNXMP5Y1xecLT7
         Nfqvhg32jhNVW1J/uQLJ3iE7NAQ2Wr+v9U7q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565826; x=1698170626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZe4Izl0NOH1/nIrnEIDX6DLuh+4li4EhUKl+KwsF4Q=;
        b=tJkA0ZMGbevYvoBwfr7It5AzAyr84dcymhk7moIIrpaoRcakETJ2Ob4ysUI/oMFLFn
         urJXDfoeRhMM0Q1hGBaImstTgOxHEgJmEv3doL2FlCRkmAHlpudXP87l/3yxi1Tk50SA
         WK0PDuv4heniE1ujdY0j0+2hjzfmWiegVJ0eJxnIG0dUiUhLYKf9rdw6CMeKR1+SXoBM
         DhEzL1OvPBlm/wlCj14R5QWUTNZTt7Raz5BljX8jkKwYcIfu/+GzBL5hMCS6EJn+ApgF
         og5JNdegTQvrigP2rfOtHU2rUvZOP7z4p/O25SKpWoK/GfUkPe8w6eEN/itaRmlNPquT
         iDKQ==
X-Gm-Message-State: AOJu0Yw/3ujQOKpLmMScbpdadJuu+GwrmJfUvn/SPibJeWVlsRpwP75b
        uuvOoCiawQXoKSLubcd+0u6Eaw==
X-Google-Smtp-Source: AGHT+IGAc29rrHQbeX1Qn4Vt4Mo3SzXJt7OCYsLTl7p8+z8Pzk6oL2HpCWvQ7yd7NptpYo6WTzRrqA==
X-Received: by 2002:a17:90a:1dd:b0:27d:4282:e3d2 with SMTP id 29-20020a17090a01dd00b0027d4282e3d2mr2754844pjd.30.1697565825722;
        Tue, 17 Oct 2023 11:03:45 -0700 (PDT)
Received: from ballway1.c.googlers.com.com (155.248.125.34.bc.googleusercontent.com. [34.125.248.155])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b0027d0af2e9c3sm6675469pjb.40.2023.10.17.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:03:45 -0700 (PDT)
From:   Allen Ballway <ballway@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     arun.r.murthy@intel.com, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        Allen Ballway <ballway@chromium.org>
Subject: [PATCH] drm/i915/quirk: Add quirk for devices with incorrect PWM frequency
Date:   Tue, 17 Oct 2023 18:01:39 +0000
Message-ID: <20231017175728.1.Ibc6408a8ff1f334974104c5bcc25f2f35a57f36e@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 .../gpu/drm/i915/display/intel_backlight.c    |  3 ++-
 drivers/gpu/drm/i915/display/intel_quirks.c   | 26 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 2e8f17c045222..c4dcfece9deca 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -1388,7 +1388,8 @@ static int vlv_setup_backlight(struct intel_connector *connector, enum pipe pipe
 	ctl = intel_de_read(i915, VLV_BLC_PWM_CTL(pipe));
 	panel->backlight.pwm_level_max = ctl >> 16;

-	if (!panel->backlight.pwm_level_max)
+	if (!panel->backlight.pwm_level_max ||
+	    intel_has_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY))
 		panel->backlight.pwm_level_max = get_backlight_max_vbt(connector);

 	if (!panel->backlight.pwm_level_max)
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
index 10a4d163149fd..70589505e5a0e 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -17,6 +17,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY
 };

 void intel_init_quirks(struct drm_i915_private *i915);
--
2.42.0.655.g421f12c284-goog

