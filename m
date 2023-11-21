Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43BB7F3704
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKUT7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjKUT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:59:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC055D49;
        Tue, 21 Nov 2023 11:59:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce3084c2d1so50378975ad.3;
        Tue, 21 Nov 2023 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596770; x=1701201570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRRUJUOXJctvN9PLktMW3h80GnHZHmmhDQykuiBWWWw=;
        b=buX7GBHEwXDVpVodg80gJvMUemu87ywu4VX83eJ+Rj3JTWAZu1hSPfcSeMqONDP/X8
         iEzcxFOG2/s8e94NvoVIIOlYlKMOjTXlQQt4W5knMwYFhp4sGjOw5wZM/MoC+5buEK7q
         DBAKS8sRpLy2bI5gRc33gibudnPqfteJlIRbNWir0MHhBku0e/79zOZov/bHJIXNMLOi
         qjKUDLBcpmGBelOanB+69efhwEHwPCngMhIIuBGs73p3R7YREBjJP41bDsX+yN3rtPg/
         Ul9wcAXYZkDBCFJ6KmEONi+h03TvwgXbYDpnx/hNjnpNI1G2pFYE9ZryHzhCMzF+Yns0
         6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596770; x=1701201570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRRUJUOXJctvN9PLktMW3h80GnHZHmmhDQykuiBWWWw=;
        b=tS6Q1S8DHBHEJ+nW97AnwXvZkA1dMTbltVemfrVnCfoDlBPrJlbXWOKjLQ55aTemFn
         bpE90IIB4c1mYxD06twpS0V3sU3L06RKu1vpjEdrR97BrmEoGVsDzSUjGiO3oDx36Sqa
         7A2Hc60Q5esdauBjSdB4iPGa6p4PR66fsV6tgfi2b1sJlbfjyTgZp1ldDLMf85vy24Hs
         oKcFrmV7+iMeLkYSjxpTFeTyvpMHWVvYzWhbmlrdlKrIZuALNAilHW/CKKeUTEUS3khm
         tBffO0pCzm4Hjd3b0naBTlKG9dc7SgQYWx3cqZ2/+J6mS1JTNBzALO/NWATsgv4XEv4I
         rQYw==
X-Gm-Message-State: AOJu0YyhQrpXE3FSbVzojXR06JgzsGpp4GKjlHt+N1oDyB0jCHLkfvME
        MXpKu5SmW1q34eRDsc3SeO0=
X-Google-Smtp-Source: AGHT+IEwZLt6boXN/rFe5zyZS+0no6k+QuYk7RqBfVCOdntVCBhgpDHl8KneJ2Tajs1CmHgmU+h7xA==
X-Received: by 2002:a17:903:124b:b0:1cc:2dad:7ae9 with SMTP id u11-20020a170903124b00b001cc2dad7ae9mr190268plh.32.1700596770331;
        Tue, 21 Nov 2023 11:59:30 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001cc615e6850sm8310732plz.90.2023.11.21.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 11:59:29 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: acer-wmi: add fan speed monitoring for
Date:   Wed, 22 Nov 2023 04:58:16 +0900
Message-ID: <20231121195817.18128-3-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231121195817.18128-1-onenowy@gmail.com>
References: <20231121195817.18128-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/platform/x86/acer-wmi.c | 101 +++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6572a8f7a..6ad9d4030 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,7 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
+#include <linux/hwmon.h>
 
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
@@ -96,6 +97,8 @@ enum acer_wmi_event_ids {
 
 enum acer_wmi_predator_v4_sys_info_command {
 	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
+	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
+	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -241,6 +244,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_LED     BIT(8)
 #define ACER_CAP_TURBO_FAN     BIT(9)
 #define ACER_CAP_PLAFORM_PROFILE BIT(10)
+#define ACER_CAP_FAN_SPEED_READ BIT(11)
 
 /*
  * Interface type flags
@@ -353,7 +357,8 @@ static void __init set_quirks(void)
 					 | ACER_CAP_TURBO_FAN;
 
 	if (quirks->predator_v4)
-		interface->capability |= ACER_CAP_PLAFORM_PROFILE;
+		interface->capability |= ACER_CAP_PLAFORM_PROFILE |
+					 ACER_CAP_FAN_SPEED_READ;
 }
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1722,6 +1727,25 @@ static int acer_gsensor_event(void)
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
+		return fanspeed >> 8;
+	}
+	return -EOPNOTSUPP;
+}
+
 /*
  *  Predator series turbo button
  */
@@ -2476,6 +2500,8 @@ static u32 get_wmid_devices(void)
 	return devices;
 }
 
+static int acer_wmi_hwmon_init(void);
+
 /*
  * Platform device
  */
@@ -2505,6 +2531,12 @@ static int acer_platform_probe(struct platform_device *device)
 			goto error_platform_profile;
 	}
 
+	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
+		err = acer_wmi_hwmon_init();
+		if (err < 0)
+			return err;
+	}
+
 	return err;
 
 error_rfkill:
@@ -2617,6 +2649,73 @@ static void __init create_debugfs(void)
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

