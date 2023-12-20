Return-Path: <linux-kernel+bounces-7645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6B81AB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C71F23B86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD814B5AD;
	Wed, 20 Dec 2023 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="YECAWy6y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD4AF79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42782692142so1234801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703115869; x=1703720669; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LaRy9gRQq7rXyzT31NR9WnKH22gY2ghjcVnzsA3mvxQ=;
        b=YECAWy6yh+/2VBJpymFwFoy6wZTc/hPl0riDi9JARmDqSIn11YVvwmvN+jiZSa8cQF
         gBu+1p5M+XDHfrYuP15r708yfVeMzs5iYaH0Y7J8AjuVHK2ZXMW0EiDyNp1Qhr0YGRBK
         pY6Li2ECVLixOEuX+B0oFGkk9FCVq5uCtU/14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115869; x=1703720669;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaRy9gRQq7rXyzT31NR9WnKH22gY2ghjcVnzsA3mvxQ=;
        b=PBAeNxjLabjPXr96a8h7b5WHSFiQJxsYNBu/HoKaXioMCoM9bXOU4Jpl7HlBfOvXNo
         aqYnC+EXSZ6eo1fVKL1ks1kw2QaWqKgDMdG4VY46LEPaOM7akC5XVHGtVIgFbDS3dVXt
         tW+wPKqh9zLWXXtfpnQ6+3gs0PiQHgrwBZr5h8PbuNSYDeCm1mwWPKRH9/UalTc5oJ+k
         UJRNC37k+Ub5bzv3nVBiFAOsxp4c122e4hO+PRVEBp4GS+lf40vu5OlMWKSdcFRBbQKC
         whophGkGt5G8D3y68Ws7E0Vb1pLYudD0MIZbiXe3gdkv0tPaxDuLZZOPFjSNLgIINxzW
         DmYg==
X-Gm-Message-State: AOJu0YzXHzvjxIPdzCux8+s8WW3ttnn5uKbeh3cymuXdDgiLClbFFFSb
	EhVgBeiOLyKq8rxt07V3+kzA2A==
X-Google-Smtp-Source: AGHT+IEb4Cfm+86Qa8Oe1c2nolXFP4IqMNy5qdnwahFMFx5qONSwY0dRnedfBfy/kLhv0eecAWt3RA==
X-Received: by 2002:ad4:576a:0:b0:67f:3285:d39a with SMTP id r10-20020ad4576a000000b0067f3285d39amr10439174qvx.18.1703115869616;
        Wed, 20 Dec 2023 15:44:29 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id qj6-20020a05620a880600b0077f1645282csm276742qkn.22.2023.12.20.15.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:44:29 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: add fan speed monitoring driver for Surface devices
Date: Wed, 20 Dec 2023 18:44:14 -0500
Message-Id: <20231220234415.5219-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220234415.5219-1-ivor@iwanders.net>
References: <20231220234415.5219-1-ivor@iwanders.net>
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
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/surface_fan.rst |  27 ++++++
 MAINTAINERS                         |   8 ++
 drivers/hwmon/Kconfig               |  13 +++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/surface_fan.c         | 125 ++++++++++++++++++++++++++++
 6 files changed, 175 insertions(+)
 create mode 100644 Documentation/hwmon/surface_fan.rst
 create mode 100644 drivers/hwmon/surface_fan.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 042e1cf95..4dfb3b9bd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -202,6 +202,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m1
    sparx5-temp
    stpddc60
+   surface_fan
    sy7636a-hwmon
    tc654
    tc74
diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/surface_fan.rst
new file mode 100644
index 000000000..6e27a6653
--- /dev/null
+++ b/Documentation/hwmon/surface_fan.rst
@@ -0,0 +1,27 @@
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
+``fan1_max``            RO      Approximate maximum fan speed.
+``fan1_min``            RO      Minimum fan speed used by the controller.
+======================= ======= =========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 439cf523b..8e7870af3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14078,6 +14078,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
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
index 307477b8a..4b4d999af 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1965,6 +1965,19 @@ config SENSORS_SMM665
 	  This driver can also be built as a module. If so, the module will
 	  be called smm665.
 
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
index 3f4b0fda0..5ae214c06 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -198,6 +198,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
new file mode 100644
index 000000000..7129b25ed
--- /dev/null
+++ b/drivers/hwmon/surface_fan.c
@@ -0,0 +1,125 @@
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
+#include <linux/platform_device.h>
+#include <linux/surface_aggregator/device.h>
+#include <linux/types.h>
+
+// The minimum speed for the fan when turned on by the controller. The onboard
+// controller uses this as minimum value before turning the fan on or off.
+#define SURFACE_FAN_MIN_SPEED 3000
+// The maximum speed, determined by observation and rounding up to the nearest
+// multiple of 500 to account for variation between individual fans.
+#define SURFACE_FAN_MAX_SPEED 7500
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
+	if (type != hwmon_fan)
+		return 0;
+
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_label:
+	case hwmon_fan_min:
+	case hwmon_fan_max:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int surface_fan_hwmon_read(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long *val)
+{
+	struct ssam_device *sdev = dev_get_drvdata(dev);
+	__le16 value;
+	int res;
+
+	if (type != hwmon_fan)
+		return -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		res = __ssam_fan_rpm_get(sdev, &value);
+		if (res)
+			return -EIO;
+		*val = le16_to_cpu(value);
+		return 0;
+	case hwmon_fan_min:
+		*val = SURFACE_FAN_MIN_SPEED;
+		return 0;
+	case hwmon_fan_max:
+		*val = SURFACE_FAN_MAX_SPEED;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *const surface_fan_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_MAX | HWMON_F_MIN),
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
+	hdev = devm_hwmon_device_register_with_info(&sdev->dev, "fan", sdev,
+						    &surface_fan_chip_info,
+						    NULL);
+	if (IS_ERR(hdev))
+		return PTR_ERR(hdev);
+
+	ssam_device_set_drvdata(sdev, sdev);
+
+	return 0;
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


