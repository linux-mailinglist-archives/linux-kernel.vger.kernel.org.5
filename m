Return-Path: <linux-kernel+bounces-45554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06497843255
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660BBB23C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F01859;
	Wed, 31 Jan 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="Q1gQI4Vw"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C63A34
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662744; cv=none; b=rJIEQdW3AZYqklHXtZpuBEHm2hPZ7ADslDJUOcCGJTpBq6wsw9upVNfChocnIanY4zCjuI+4uZn7V4diLDYNBamxn+ZSQvoTycgAKdlVIeHftoybcxBY/XXc62SuGXvOxxOAWTkbAbaBKOn2tZpE1yCao9wnu9+mMrLS8oH1YGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662744; c=relaxed/simple;
	bh=IH75rlbHfhO17wkZ8j6BbXXQVv64KNeiofeASP3F9Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uf51eGsAJitVjOAS+yxtO+41vFKorqAzHHjWA4L2kgDkUgTr4aHNoFN8McnFPGB9xD8Li59Q/hUZtVEcG7cgYt9Rey4zPzJ4AQr0F6SjcuWL29oT8FOrxtqFhzImU/bY0ry++odz423b753bpLT0HVzGnYP9EZykSbCoggGoS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=Q1gQI4Vw; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso16152316d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1706662741; x=1707267541; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipQdxC8whwOIJQEFS5+H7cNnhVcrVT6wXK5Q0123pmI=;
        b=Q1gQI4VwkQ+dwX5UKtV8ugHMqqz20EB8fddQOHz/PH41Ict7dE4vTz6ONsRxSHcznj
         DvGYkC2FA6jG35FxbVfyySKjPpQSBcrKMCjZMHYgoaQNUFHUzB3GnOH9jEGD02qM0rYQ
         KdCyKPxhuXZkhqpkWS2QRVJGWIqjpy3hdTk+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662741; x=1707267541;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipQdxC8whwOIJQEFS5+H7cNnhVcrVT6wXK5Q0123pmI=;
        b=aTyeEvlxaWnIDjwHAh3PkGySxl2bRTC1uGYnP3AdJd02IDC7RoZx10rZUgZ1TT36+i
         H6QIgg7+I5IdFWP42NnQZqywDknqQWDwklF7D8nmNSQ9N9y3h7HYvQKmvV6sBrrXl+lF
         q4fMKVCGRYh0Ds4PQAVgoGCZ8W7Vm05ZvdAdRLjHOIZBd6xP2F1fSkjfl7INz6bK9Cg5
         +QwtqVxxd1XIZTIDlTaNGwPcE4KtW2fuA7DscA0oQDIeA/ovFsh4n1sAybcZmJrYzpij
         paVd3B2VETezdbBgGeg1XMo+YboLlKbxs6uTVH+KkVxhKcvA34wWjUle2taNFyyZNt5t
         Ckpg==
X-Gm-Message-State: AOJu0YzAhXGJpBYz/r69ERG42BDn/WKAAxabk/N62/JrlkSCHkPlE+hR
	oQ+djY3LXgJLjGcIaI3AyoY2faXg0jgPa2pOne4sFGtWyI3guNJWk93HACwSzHY=
X-Google-Smtp-Source: AGHT+IFLbu5AT03wnfPhJ8JcjZdCsowZO3ySL8EDkNLEZxl6hiJHVnZ2nSBkjT8BctmLTqaJmDOpRw==
X-Received: by 2002:a05:6214:246d:b0:685:6715:9693 with SMTP id im13-20020a056214246d00b0068567159693mr294784qvb.8.1706662741364;
        Tue, 30 Jan 2024 16:59:01 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b006869e0eed00sm4969090qvb.26.2024.01.30.16.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 16:59:01 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ivor Wanders <ivor@iwanders.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 1/2] hwmon: add fan speed monitoring driver for Surface devices
Date: Tue, 30 Jan 2024 19:58:55 -0500
Message-Id: <20240131005856.10180-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131005856.10180-1-ivor@iwanders.net>
References: <20240131005856.10180-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Adds a driver that provides read only access to the fan speed for Microsoft
Surface Pro devices. The fan speed is always regulated by the EC and cannot
be influenced directly.

Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Link: https://github.com/linux-surface/kernel/pull/144
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
Changes in v5:
  - No changes in this patch.
Changes in v4:
  - Return 0 from surface_fan_hwmon_read instead of ret.
  - Use PTR_ERR_OR_ZERO in probe instead of if statement.
Changes in v3:
  - Removed type and attr checks in read and is_visible.
  - Removed assigning sdev to ssam_device drvdata.
  - Propagate return from __ssam_fan_rpm_get.
  - Renamed hwmon chip name from 'fan' to 'surface_fan'.
  - Removed unnecessary platform_device header.
Changes in v2:
  - Removed all sysfs attributes except fan1_input. Simplified code
    and updated documentation accordingly.
---
 Documentation/hwmon/index.rst       |  1 +
 Documentation/hwmon/surface_fan.rst | 25 ++++++++
 MAINTAINERS                         |  8 +++
 drivers/hwmon/Kconfig               | 13 +++++
 drivers/hwmon/Makefile              |  1 +
 drivers/hwmon/surface_fan.c         | 91 +++++++++++++++++++++++++++++
 6 files changed, 139 insertions(+)
 create mode 100644 Documentation/hwmon/surface_fan.rst
 create mode 100644 drivers/hwmon/surface_fan.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c7ed1f73a..58be92e94 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -208,6 +208,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m1
    sparx5-temp
    stpddc60
+   surface_fan
    sy7636a-hwmon
    tc654
    tc74
diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/surface_fan.rst
new file mode 100644
index 000000000..07942574c
--- /dev/null
+++ b/Documentation/hwmon/surface_fan.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver surface_fan
+=========================
+
+Supported Devices:
+
+  * Microsoft Surface Pro 9
+
+Author: Ivor Wanders <ivor@iwanders.net>
+
+Description
+-----------
+
+This provides monitoring of the fan found in some Microsoft Surface Pro devices,
+like the Surface Pro 9. The fan is always controlled by the onboard controller.
+
+Sysfs interface
+---------------
+
+======================= ======= =========================================
+Name                    Perm    Description
+======================= ======= =========================================
+``fan1_input``          RO      Current fan speed in RPM.
+======================= ======= =========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index c4828ab15..2c5c4d7e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14560,6 +14560,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
 F:	drivers/platform/surface/surface_dtx.c
 F:	include/uapi/linux/surface_aggregator/dtx.h
 
+MICROSOFT SURFACE SENSOR FAN DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+M:	Ivor Wanders <ivor@iwanders.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/surface_fan.rst
+F:	drivers/hwmon/surface_fan.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a608264da..e762f6138 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1994,6 +1994,19 @@ config SENSORS_SFCTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called sfctemp.
 
+config SENSORS_SURFACE_FAN
+	tristate "Surface Fan Driver"
+	depends on SURFACE_AGGREGATOR
+	help
+	  Driver that provides monitoring of the fan on Surface Pro devices that
+	  have a fan, like the Surface Pro 9.
+
+	  This makes the fan's current speed accessible through the hwmon
+	  system. It does not provide control over the fan, the firmware is
+	  responsible for that, this driver merely provides monitoring.
+
+	  Select M or Y here, if you want to be able to read the fan's speed.
+
 config SENSORS_ADC128D818
 	tristate "Texas Instruments ADC128D818"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 47be39af5..30cc90f40 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -201,6 +201,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
new file mode 100644
index 000000000..31cd5da9e
--- /dev/null
+++ b/drivers/hwmon/surface_fan.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface Fan driver for Surface System Aggregator Module. It provides access
+ * to the fan's rpm through the hwmon system.
+ *
+ * Copyright (C) 2023 Ivor Wanders <ivor@iwanders.net>
+ */
+
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/surface_aggregator/device.h>
+#include <linux/types.h>
+
+// SSAM
+SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_fan_rpm_get, __le16, {
+	.target_category = SSAM_SSH_TC_FAN,
+	.command_id      = 0x01,
+});
+
+// hwmon
+umode_t surface_fan_hwmon_is_visible(const void *drvdata,
+				     enum hwmon_sensor_types type, u32 attr,
+				     int channel)
+{
+	return 0444;
+}
+
+static int surface_fan_hwmon_read(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long *val)
+{
+	struct ssam_device *sdev = dev_get_drvdata(dev);
+	int ret;
+	__le16 value;
+
+	ret = __ssam_fan_rpm_get(sdev, &value);
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(value);
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *const surface_fan_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops surface_fan_hwmon_ops = {
+	.is_visible = surface_fan_hwmon_is_visible,
+	.read = surface_fan_hwmon_read,
+};
+
+static const struct hwmon_chip_info surface_fan_chip_info = {
+	.ops = &surface_fan_hwmon_ops,
+	.info = surface_fan_info,
+};
+
+static int surface_fan_probe(struct ssam_device *sdev)
+{
+	struct device *hdev;
+
+	hdev = devm_hwmon_device_register_with_info(&sdev->dev,
+						    "surface_fan", sdev,
+						    &surface_fan_chip_info,
+						    NULL);
+
+	return PTR_ERR_OR_ZERO(hdev);
+}
+
+static const struct ssam_device_id ssam_fan_match[] = {
+	{ SSAM_SDEV(FAN, SAM, 0x01, 0x01) },
+	{},
+};
+MODULE_DEVICE_TABLE(ssam, ssam_fan_match);
+
+static struct ssam_device_driver surface_fan = {
+	.probe = surface_fan_probe,
+	.match_table = ssam_fan_match,
+	.driver = {
+		.name = "surface_fan",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(surface_fan);
+
+MODULE_AUTHOR("Ivor Wanders <ivor@iwanders.net>");
+MODULE_DESCRIPTION("Fan Driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.17.1


