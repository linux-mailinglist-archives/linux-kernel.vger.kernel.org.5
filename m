Return-Path: <linux-kernel+bounces-103841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958E87C537
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6ECB1F21F17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71611718;
	Thu, 14 Mar 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="JaVtjs3o"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FADFC15
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455873; cv=none; b=lK4H2HDmbCW7yfRSkUgZ/DOgDaaceOcuSjQo4xAR9mxi4zp8z5zcWfaEi/a++8e3k0sYR66843iQ22gNS5mrqTSO7WnFz5V+G/UBiK/NFsof3pTTjTDMcxtchAO+iRKHQoblOBxodCrIeCTLbKD4TZVqZlZ/vhCcX5ws+TgAFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455873; c=relaxed/simple;
	bh=0RW01zh10iot+vDUgIci/vUldGmz44XOD84zNB9SgKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Wg0tx3oPKVKP879GnSILRzFlqjrlUwH0SZqTgLZkNMyVR5M+wRwElGLuFrSDEXIYZldEksKD2AiBSX+/Ciz+/c/QAIoI/l3l85HzlrY2XYZIBpGbUOHgqr0I9MmfLCgwO/iRnGD9ZMVVs7S4M6IKBHZ1eFh6GGsUJXE9wl/Ekfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=JaVtjs3o; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f41af71ebso10918066d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1710455870; x=1711060670; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wqIiAcmTY4cspT0Jt4o+nhnGAAsDHgZvUq8qIGKZuZU=;
        b=JaVtjs3oIQQ8nCt8CiKRJ4UAxewAeAkfKBRSgD5wsBG7DQjyi0jIPSmWOd17VrWxdR
         WxTcTNpOnNWFhv687xKBRVF4bbIzf7Ni17YFQqzY8pPU5bYmEMeRJV7ptAPMVWw9T1rP
         rtq6XCmP95szh5ucRZBMRBWLucw3VLNeInnBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455870; x=1711060670;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqIiAcmTY4cspT0Jt4o+nhnGAAsDHgZvUq8qIGKZuZU=;
        b=eEj6OVU5woko3QbvPBELEyuzlDXp02JIvR7MJSNSvS/oMOEigrsK2g8lU/P3/sZLxK
         SxCffTiOZzNIqGyocHUU/uAewMyrIJyQZX09PXkl0ydv8spC/ruoza9QrHXr0fbwNmh3
         Bw7RZz4gxljtrcU8ohlKxpMfSIuULz4rBBo4JJzrdfxYgCLE+gPtDcwpSGc2AgVDeKEL
         CadILrPCbUBVvawoZMFMkeLNjABWYyUIHEMlld47WXhY4fN1pjeWJIz/MKWkizpsFtD5
         jKuNwHubLkIUPnPwS9pimiutGSUnaGlx/hYIqN/Eyl3JHe+pQLIgqvncWjkZRiiX/v5a
         HHvA==
X-Forwarded-Encrypted: i=1; AJvYcCUkLRmud5PxETrEp4ce7A2DckA5zucvNMQoym/eOxx1U2S4xLJ08Pd79gqwIZND5ZPa8mPX7/X5EF0dX7OoRY+Z1/rF49d+TNKufnlz
X-Gm-Message-State: AOJu0Yzs6DVQF3f/5swdDqBo186biJULrnIgfBu+btujaOK/eSW5+PsS
	Yw3NooZO61JrqwZbuTqf8khEF3kyNGnzTfS0fee5KXiJPe6GNzUnh2SiRPRi2L4=
X-Google-Smtp-Source: AGHT+IELRZEJXRJEM9OhDOqs7vv1seGF83v0kHpV0Yyv7acfPE7jxvgsLpgdNTkegVEX0Y8xD3ACxg==
X-Received: by 2002:ad4:45a9:0:b0:691:72a:bc0e with SMTP id y9-20020ad445a9000000b00691072abc0emr3595460qvu.8.1710455867699;
        Thu, 14 Mar 2024 15:37:47 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id de33-20020a05620a372100b00789dd526bc7sm826447qkb.129.2024.03.14.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:37:46 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivor Wanders <ivor@iwanders.net>
Subject: [PATCH v2 1/1] platform/surface: platform_profile: add fan profile switching
Date: Thu, 14 Mar 2024 18:37:33 -0400
Message-Id: <20240314223733.6236-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240314223733.6236-1-ivor@iwanders.net>
References: <20240314223733.6236-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Change naming from tmp to platform profile to clarify the module may
interact with both the TMP and FAN subystems. Add functionality that
switches the fan profile when the platform profile is changed when
a fan is present.

Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Link: https://github.com/linux-surface/kernel/pull/145
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Changes in v2:
  - Added link entry to commit message.
  - Use u8 instead of char for the argument of __sam_fan_profile_set.
  - Made profile and profile_le variable const.
---
---
 .../surface/surface_aggregator_registry.c     | 36 +++++---
 .../surface/surface_platform_profile.c        | 88 ++++++++++++++++---
 2 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 035d6b4105cd..79e52eddabd0 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -68,12 +68,26 @@ static const struct software_node ssam_node_bat_sb3base = {
 	.parent = &ssam_node_hub_base,
 };
 
-/* Platform profile / performance-mode device. */
-static const struct software_node ssam_node_tmp_pprof = {
+/* Platform profile / performance-mode device without a fan. */
+static const struct software_node ssam_node_tmp_perf_profile = {
 	.name = "ssam:01:03:01:00:01",
 	.parent = &ssam_node_root,
 };
 
+/* Platform profile / performance-mode device with a fan, such that
+ * the fan controller profile can also be switched.
+ */
+static const struct property_entry ssam_node_tmp_perf_profile_has_fan[] = {
+	PROPERTY_ENTRY_BOOL("has_fan"),
+	{ }
+};
+
+static const struct software_node ssam_node_tmp_perf_profile_with_fan = {
+	.name = "ssam:01:03:01:00:01",
+	.parent = &ssam_node_root,
+	.properties = ssam_node_tmp_perf_profile_has_fan,
+};
+
 /* Fan speed function. */
 static const struct software_node ssam_node_fan_speed = {
 	.name = "ssam:01:05:01:01:01",
@@ -208,7 +222,7 @@ static const struct software_node ssam_node_pos_tablet_switch = {
  */
 static const struct software_node *ssam_node_group_gen5[] = {
 	&ssam_node_root,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -219,7 +233,7 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_bat_sb3base,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_bas_dtx,
 	&ssam_node_hid_base_keyboard,
 	&ssam_node_hid_base_touchpad,
@@ -233,7 +247,7 @@ static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
@@ -245,7 +259,7 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
@@ -258,7 +272,7 @@ static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_sam_keyboard,
 	&ssam_node_hid_sam_penstash,
@@ -274,7 +288,7 @@ static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -283,7 +297,7 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -293,7 +307,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_kip_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
@@ -310,7 +324,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile_with_fan,
 	&ssam_node_fan_speed,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index a5a3941b3f43..3de864bc6610 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Surface Platform Profile / Performance Mode driver for Surface System
- * Aggregator Module (thermal subsystem).
+ * Aggregator Module (thermal and fan subsystem).
  *
  * Copyright (C) 2021-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
@@ -14,6 +14,7 @@
 
 #include <linux/surface_aggregator/device.h>
 
+// Enum for the platform performance profile sent to the TMP module.
 enum ssam_tmp_profile {
 	SSAM_TMP_PROFILE_NORMAL             = 1,
 	SSAM_TMP_PROFILE_BATTERY_SAVER      = 2,
@@ -21,15 +22,26 @@ enum ssam_tmp_profile {
 	SSAM_TMP_PROFILE_BEST_PERFORMANCE   = 4,
 };
 
+// Enum for the fan profile sent to the FAN module. This fan profile is
+// only sent to the EC if the 'has_fan' property is set. The integers are
+// not a typo, they differ from the performance profile indices.
+enum ssam_fan_profile {
+	SSAM_FAN_PROFILE_NORMAL             = 2,
+	SSAM_FAN_PROFILE_BATTERY_SAVER      = 1,
+	SSAM_FAN_PROFILE_BETTER_PERFORMANCE = 3,
+	SSAM_FAN_PROFILE_BEST_PERFORMANCE   = 4,
+};
+
 struct ssam_tmp_profile_info {
 	__le32 profile;
 	__le16 unknown1;
 	__le16 unknown2;
 } __packed;
 
-struct ssam_tmp_profile_device {
+struct ssam_platform_profile_device {
 	struct ssam_device *sdev;
 	struct platform_profile_handler handler;
+	bool has_fan;
 };
 
 SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
@@ -42,6 +54,13 @@ SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
 	.command_id      = 0x03,
 });
 
+SSAM_DEFINE_SYNC_REQUEST_W(__ssam_fan_profile_set, u8, {
+	.target_category = SSAM_SSH_TC_FAN,
+	.target_id = SSAM_SSH_TID_SAM,
+	.command_id = 0x0e,
+	.instance_id = 0x01,
+});
+
 static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
 {
 	struct ssam_tmp_profile_info info;
@@ -57,12 +76,19 @@ static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile
 
 static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile p)
 {
-	__le32 profile_le = cpu_to_le32(p);
+	const __le32 profile_le = cpu_to_le32(p);
 
 	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
 }
 
-static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
+static int ssam_fan_profile_set(struct ssam_device *sdev, enum ssam_fan_profile p)
+{
+	const u8 profile = p;
+
+	return ssam_retry(__ssam_fan_profile_set, sdev->ctrl, &profile);
+}
+
+static int convert_ssam_tmp_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
 {
 	switch (p) {
 	case SSAM_TMP_PROFILE_NORMAL:
@@ -83,7 +109,8 @@ static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profi
 	}
 }
 
-static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profile_option p)
+
+static int convert_profile_to_ssam_tmp(struct ssam_device *sdev, enum platform_profile_option p)
 {
 	switch (p) {
 	case PLATFORM_PROFILE_LOW_POWER:
@@ -105,20 +132,42 @@ static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profi
 	}
 }
 
+static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_profile_option p)
+{
+	switch (p) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		return SSAM_FAN_PROFILE_BATTERY_SAVER;
+
+	case PLATFORM_PROFILE_BALANCED:
+		return SSAM_FAN_PROFILE_NORMAL;
+
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		return SSAM_FAN_PROFILE_BETTER_PERFORMANCE;
+
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return SSAM_FAN_PROFILE_BEST_PERFORMANCE;
+
+	default:
+		/* This should have already been caught by platform_profile_store(). */
+		WARN(true, "unsupported platform profile");
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
 				     enum platform_profile_option *profile)
 {
-	struct ssam_tmp_profile_device *tpd;
+	struct ssam_platform_profile_device *tpd;
 	enum ssam_tmp_profile tp;
 	int status;
 
-	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
+	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
 
 	status = ssam_tmp_profile_get(tpd->sdev, &tp);
 	if (status)
 		return status;
 
-	status = convert_ssam_to_profile(tpd->sdev, tp);
+	status = convert_ssam_tmp_to_profile(tpd->sdev, tp);
 	if (status < 0)
 		return status;
 
@@ -129,21 +178,32 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
 static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 				     enum platform_profile_option profile)
 {
-	struct ssam_tmp_profile_device *tpd;
+	struct ssam_platform_profile_device *tpd;
 	int tp;
 
-	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
+	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
+
+	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
+	if (tp < 0)
+		return tp;
 
-	tp = convert_profile_to_ssam(tpd->sdev, profile);
+	tp = ssam_tmp_profile_set(tpd->sdev, tp);
 	if (tp < 0)
 		return tp;
 
-	return ssam_tmp_profile_set(tpd->sdev, tp);
+	if (tpd->has_fan) {
+		tp = convert_profile_to_ssam_fan(tpd->sdev, profile);
+		if (tp < 0)
+			return tp;
+		tp = ssam_fan_profile_set(tpd->sdev, tp);
+	}
+
+	return tp;
 }
 
 static int surface_platform_profile_probe(struct ssam_device *sdev)
 {
-	struct ssam_tmp_profile_device *tpd;
+	struct ssam_platform_profile_device *tpd;
 
 	tpd = devm_kzalloc(&sdev->dev, sizeof(*tpd), GFP_KERNEL);
 	if (!tpd)
@@ -154,6 +214,8 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
+	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
+
 	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
-- 
2.17.1


