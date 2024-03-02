Return-Path: <linux-kernel+bounces-89524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690A86F18C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688C61C21400
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DF2BB1D;
	Sat,  2 Mar 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="dVSwYfue"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B472421F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398916; cv=none; b=nGlS7yBaotMpBpyAm1hWPxEVvTGYNmHlfbXBR6mnp3SlUBSESZdYPYLdPmZQX5jWiI4Rb08AW3rn1nSsflEc/a6UCjIlMxBkdwdqICmaZJr7w8HZLhrjz6R2fw3XLWoTX6DMSkPzOs0EQeN536eCZlcer13p3om18kj9akat/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398916; c=relaxed/simple;
	bh=U1acnAJ/wgnrq3yLvFuauf+B9G53rUdQ4yfEFVUHlpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YPucgFtAW0CwgxXjBuniXH8zH4IFZma/BZi+zJQyP3Xjcn6O+GMciWMZ/wauAAxBWm/AAht7d6KOHw4zM3TcqGYqb1P5o0wzSF/EiIAn9qjLZjCUxcZZaSRJBi5gr9EKGTyJNPkEGo82BlMu9CDTLJXta1aJ7i7ZQTmnINM3TgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=dVSwYfue; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-788201e3a87so23116585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 09:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1709398912; x=1710003712; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9fwuh8oCKIZyIz0PJcapjAHJQL1lsI+nQ02gZDDkxM=;
        b=dVSwYfueodbvm5nB8ao8xh6YD+6Mr0DHUKA9nKEHORmk0XZGn+bSzANzYeh8JDF7kr
         6y2c3/1DymVSxlI9klxdTgzA5y94wc0PVImfNrjRcBC3KhXJs8kFNR3eiYtuDHdRHmNE
         S13kIOnM0xyWSM4Fwe93uH7mLAHTxtRMdqbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398912; x=1710003712;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9fwuh8oCKIZyIz0PJcapjAHJQL1lsI+nQ02gZDDkxM=;
        b=g3hbZGsKxIz18o3HUhTbvGN3J4porZWwe2QyhLoh/jYTFojIwA+VeE6gSKtm7QEBXQ
         ITmxNFs4Pnx9XCtOWcGHzvTOCgb6BNbhEBk5aiQ5Pg1S3v0H8Y34M/mCTY/VBd+Q7jtG
         nqc3W+uw+swOYTGJQKNW7Jwy1Xb5dd5GLkyUFfWUwRTKrlsKl+/2xRkXjrz5GH+Ht27j
         h7yQkz2bghcaKV4d4w/pFT4ayDLIlPF8yozNFP/7tCUVATci/igt/xE3anN/0Z2LJe/I
         sSa9bcFs8KU9kxA28RWXeADgha8b3vC2u/4BVI/OogLC5vUhq2yEkwXvdC5gByf0e/SN
         Zxew==
X-Forwarded-Encrypted: i=1; AJvYcCWrN32UL80JDHBMKnBIQuOjVkyWRN8siP+/AN9ce1jbRo4gvlqXAFJtvOmXI+wkZxPlKDQWjlBIjtvUb3CELQPORau4IovFSUWYeoBJ
X-Gm-Message-State: AOJu0YxnhR2ochj75P862Csivn8Wjx4rxBPLaiu+Cqz8cpT54twwOUo7
	pXcfn2xuP03ZrouVT0yujRfJr8ibBgUZDouV1QHRYbV+1g1Q+IToqMpKoOKSmA8=
X-Google-Smtp-Source: AGHT+IHv+wTnNFJRD3hMTRAbNsYVVdn4TeJdhmOtSkYucuXpGLsKq6UpRnEx/X7c3yWyJZo/zDrm5w==
X-Received: by 2002:a05:620a:1721:b0:787:a64a:b05a with SMTP id az33-20020a05620a172100b00787a64ab05amr6236601qkb.6.1709398912448;
        Sat, 02 Mar 2024 09:01:52 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm2684871qkl.91.2024.03.02.09.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:01:52 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivor Wanders <ivor@iwanders.net>
Subject: [PATCH 1/1] platform/surface: platform_profile: add fan profile switching
Date: Sat,  2 Mar 2024 12:01:47 -0500
Message-Id: <20240302170147.13026-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240302170147.13026-1-ivor@iwanders.net>
References: <20240302170147.13026-1-ivor@iwanders.net>
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
---
 .../surface/surface_aggregator_registry.c     | 36 +++++---
 .../surface/surface_platform_profile.c        | 86 ++++++++++++++++---
 2 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index aeb3feae40ff..05fd98998d67 100644
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
 /* Tablet-mode switch via KIP subsystem. */
 static const struct software_node ssam_node_kip_tablet_switch = {
 	.name = "ssam:01:0e:01:00:01",
@@ -202,7 +216,7 @@ static const struct software_node ssam_node_pos_tablet_switch = {
  */
 static const struct software_node *ssam_node_group_gen5[] = {
 	&ssam_node_root,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -213,7 +227,7 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_bat_sb3base,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_bas_dtx,
 	&ssam_node_hid_base_keyboard,
 	&ssam_node_hid_base_touchpad,
@@ -227,7 +241,7 @@ static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
@@ -239,7 +253,7 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
@@ -252,7 +266,7 @@ static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_sam_keyboard,
 	&ssam_node_hid_sam_penstash,
@@ -268,7 +282,7 @@ static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -277,7 +291,7 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	NULL,
 };
 
@@ -287,7 +301,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile,
 	&ssam_node_kip_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
@@ -304,7 +318,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_perf_profile_with_fan,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index a5a3941b3f43..e54d0a8f7daa 100644
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
 
+SSAM_DEFINE_SYNC_REQUEST_W(__ssam_fan_profile_set, char, {
+	.target_category = SSAM_SSH_TC_FAN,
+	.target_id = SSAM_SSH_TID_SAM,
+	.command_id = 0x0e,
+	.instance_id = 0x01,
+});
+
 static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
 {
 	struct ssam_tmp_profile_info info;
@@ -62,7 +81,14 @@ static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile
 	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
 }
 
-static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
+static int ssam_fan_profile_set(struct ssam_device *sdev, enum ssam_fan_profile p)
+{
+	char profile = p;
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


