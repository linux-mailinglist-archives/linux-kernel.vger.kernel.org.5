Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923187F703A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbjKXJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjKXJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:42:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69DD7E;
        Fri, 24 Nov 2023 01:42:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c4d06b6ddaso1459018b3a.3;
        Fri, 24 Nov 2023 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818942; x=1701423742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF9QdMXKGxlJo/tlvdS6nf0ZE/rvd7pmC2onSppTCRo=;
        b=bTTONaRb3SCAhL/CSqFxvvjtX/fuKKtdSs6Ei+Y+FCqUM6Za2YijDlZTwMKmhGVYu/
         L5DjLBW4qr+2OdImyqrGIyfpWW3vEZaiWF/qEbti9Ktu25IQ/z9UVDgcSFpwrZ76wylB
         1/ExQkrDA1wGHf6Km691s1XlQ2fg7rSBITIdw8MeuK8bhnqVNgpExy6GrVwa8j0mAhLK
         gvWPiKrr8tLbGuh5lY2boPoZMpw3vqmI1WhOI1NJudIyhoj58UCeO9Yj2e9Gl0iAWmDN
         66NgcNd7vAPiRXfF9DhKoPS8PFitbLi5ezace6xoguo0vo4LkyTrv4HWTfea3nxomOX9
         d4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818942; x=1701423742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF9QdMXKGxlJo/tlvdS6nf0ZE/rvd7pmC2onSppTCRo=;
        b=mummuGtJA491OZrmbOj6KEHSBT/JtYpqtEe7zlCeiptGS50o+Tp21EdJx0YdqvBSEi
         rMni4MdBGsQSxui5BiEU6hPUu3IT00iM/Lr0QnOOJDT52VPodPtfCDcsBg+WVaweTfpH
         ndLNN08JdejGIA0giO+7KpiyppMJIGjtx9wprWkwlo4rw7ZIOCBKvdIUS4yhSKmqm/JK
         +s9pbNCUw9aytuJqXW6pDJ06hcOivL33excdJVOCn8YJaDwCFAzSpN+Uv0uGd1V2KQLi
         MfF5CS9zbB23ZXZl+fSJzqmOstfD8W7LCiS0jZbb9Oi5DEFLDyohhlY6RTQuSfaJHH6O
         X/aQ==
X-Gm-Message-State: AOJu0YzGQg9nTbBOrhyzTwwkrswrImLnkqosFq6pd7sH/ZDl3kxrDHYa
        BjEsiaBYKIepezJv4XJnQhY=
X-Google-Smtp-Source: AGHT+IEfNA/YYc8Zh7wpPDDMaJK2zn66cNmo5mWt+dqSUsBWwB8OFgO5gWzbvsLjZsl/L6taSqkVaQ==
X-Received: by 2002:a05:6a00:88f:b0:6b3:f29c:dde1 with SMTP id q15-20020a056a00088f00b006b3f29cdde1mr2075641pfj.21.1700818941687;
        Fri, 24 Nov 2023 01:42:21 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7868a000000b006cb8c92a8acsm2489956pfo.113.2023.11.24.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:42:21 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v4 2/3] platform/x86: acer-wmi: add fan speed monitoring for Predator  PHN16-71
Date:   Fri, 24 Nov 2023 18:41:19 +0900
Message-ID: <20231124094122.100707-3-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124094122.100707-1-onenowy@gmail.com>
References: <20231124094122.100707-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support CPU and GPU fan speed monitoring through WMI for Predator
PHN16-71.

This patch depends on patch "platform/x86: acer-wmi: Add platform
profile and mode key support for Predator PHN16-71"

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 drivers/platform/x86/Kconfig    |   1 +
 drivers/platform/x86/acer-wmi.c | 104 +++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7e69fdacc..caf3f4c6b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -177,6 +177,7 @@ config ACER_WMI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
 	depends on ACPI_WMI
+	depends on HWMON
 	select ACPI_VIDEO
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index e3650dce0..5e7b9f5d5 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,8 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
+#include <linux/hwmon.h>
+#include <linux/bitfield.h>
 
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
@@ -69,6 +71,8 @@ MODULE_LICENSE("GPL");
 
 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
 
+#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
+
 /*
  * Acer ACPI method GUIDs
  */
@@ -96,6 +100,8 @@ enum acer_wmi_event_ids {
 
 enum acer_wmi_predator_v4_sys_info_command {
 	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
+	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
+	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -240,7 +246,8 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_OC     BIT(7)
 #define ACER_CAP_TURBO_LED     BIT(8)
 #define ACER_CAP_TURBO_FAN     BIT(9)
-#define ACER_CAP_PLATFORM_PROFILE BIT(10)
+#define ACER_CAP_PLATFORM_PROFILE	BIT(10)
+#define ACER_CAP_FAN_SPEED_READ	BIT(11)
 
 /*
  * Interface type flags
@@ -353,7 +360,8 @@ static void __init set_quirks(void)
 					 | ACER_CAP_TURBO_FAN;
 
 	if (quirks->predator_v4)
-		interface->capability |= ACER_CAP_PLATFORM_PROFILE;
+		interface->capability |= ACER_CAP_PLATFORM_PROFILE |
+					 ACER_CAP_FAN_SPEED_READ;
 }
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1722,6 +1730,26 @@ static int acer_gsensor_event(void)
 	return 0;
 }
 
+static int acer_get_fan_speed(int fan)
+{
+	if (quirks->predator_v4) {
+		acpi_status status;
+		u64 fanspeed;
+
+		status = WMI_gaming_execute_u64(
+			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
+			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
+				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
+			&fanspeed);
+
+		if (ACPI_FAILURE(status))
+			return -EIO;
+
+		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
+	}
+	return -EOPNOTSUPP;
+}
+
 /*
  *  Predator series turbo button
  */
@@ -2476,6 +2504,8 @@ static u32 get_wmid_devices(void)
 	return devices;
 }
 
+static int acer_wmi_hwmon_init(void);
+
 /*
  * Platform device
  */
@@ -2505,6 +2535,9 @@ static int acer_platform_probe(struct platform_device *device)
 			goto error_platform_profile;
 	}
 
+	if (has_cap(ACER_CAP_FAN_SPEED_READ))
+		err = acer_wmi_hwmon_init();
+
 	return err;
 
 error_rfkill:
@@ -2617,6 +2650,73 @@ static void __init create_debugfs(void)
 			   &interface->debug.wmid_devices);
 }
 
+static umode_t acer_wmi_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type, u32 attr,
+					 int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		if (acer_get_fan_speed(channel) >= 0)
+			return 0444;
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret = acer_get_fan_speed(channel);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT), NULL
+};
+
+static const struct hwmon_ops acer_wmi_hwmon_ops = {
+	.read = acer_wmi_hwmon_read,
+	.is_visible = acer_wmi_hwmon_is_visible,
+};
+
+static const struct hwmon_chip_info acer_wmi_hwmon_chip_info = {
+	.ops = &acer_wmi_hwmon_ops,
+	.info = acer_wmi_hwmon_info,
+};
+
+static int acer_wmi_hwmon_init(void)
+{
+	struct device *dev = &acer_platform_device->dev;
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "acer",
+						     &acer_platform_driver,
+						     &acer_wmi_hwmon_chip_info,
+						     NULL);
+
+	if (IS_ERR(hwmon)) {
+		dev_err(dev, "Could not register acer hwmon device\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
 static int __init acer_wmi_init(void)
 {
 	int err;
-- 
2.43.0

