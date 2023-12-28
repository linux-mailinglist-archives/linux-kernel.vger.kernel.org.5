Return-Path: <linux-kernel+bounces-12325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E4981F36A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5851C2827D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D215C3;
	Thu, 28 Dec 2023 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="LMhFzJle"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05716EA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-427c4bf6017so34957851cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703723696; x=1704328496; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JIC8r2ltUkXyvkEzaAyOSCPzaMSEfKzsjJ+cCjcFUZc=;
        b=LMhFzJleSlJGkiHEu6PpxzbWqPfmSpGDELqH8ZZBzr6FxzpZxePstHQ7mQHCxJAg85
         9ljUm6suDXNtz135g53cyMmQeqaeND+IBceTUaVMYJ1Ho+CG6rUJcTAnx3UFQS/x2gAy
         X7lYJBLZLN9LPXYX+haBIur7cyxZpkF1ugIeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723696; x=1704328496;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIC8r2ltUkXyvkEzaAyOSCPzaMSEfKzsjJ+cCjcFUZc=;
        b=cHJGlEaK4vSSxzJ6d2lUl5xb6eV+WiVVurATdrXQ9/WUYAyO0+WAdEnU8uxH41KwW1
         8HM6lH92Kq+PwFxuPrY5b2vvSlo99NyTLQDbWDiseKXf53Gy74g8H8BkkXlSb9KSlN0m
         0dJMfdWBwOITZq0jAguqIpT+ckZ5Em1j6H5e3dwgHt+y4YLVAGCDtJmKHpt6V77pUjpi
         vnDUgw3TcJSsT/btx30veraEUPxfImgrwoCFyaH+TLIoGTCn1zbso/tREaY6CbxBzEYz
         mGhpdl/3Gf+zo5e0fQvu11geV15JAQLy4Blx57U33UMcqadNEsDoLBLSu8127cA6OtU8
         mY7g==
X-Gm-Message-State: AOJu0Yzr7xW5kC2Z61LEG5OlQOgipFN4fWKAjp+Bf+XwmSW/acSlTN0F
	QaMvthyBxM5TtLXjZuuoYb2Kf9MYkc4HhA==
X-Google-Smtp-Source: AGHT+IHejzFWiBplHTCVq4s9nVFkVXqDdTh9iKuc9QWiGEkQgyypkOHg8qbSHcYidvLiTMV2C3GgmA==
X-Received: by 2002:a05:622a:305:b0:427:a316:a279 with SMTP id q5-20020a05622a030500b00427a316a279mr13735922qtw.3.1703723695937;
        Wed, 27 Dec 2023 16:34:55 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id fb9-20020a05622a480900b004279315b3besm7710684qtb.0.2023.12.27.16.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:34:55 -0800 (PST)
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
Subject: [PATCH v2 1/2] hwmon: add fan speed monitoring driver for Surface devices
Date: Wed, 27 Dec 2023 19:34:43 -0500
Message-Id: <20231228003444.5580-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231228003444.5580-1-ivor@iwanders.net>
References: <20231228003444.5580-1-ivor@iwanders.net>
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
Changes in v2:
  - Removed all sysfs attributes except fan1_input. Simplified code
    and updated documentation accordingly.
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/surface_fan.rst |  25 +++++++
 MAINTAINERS                         |   8 +++
 drivers/hwmon/Kconfig               |  13 ++++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/surface_fan.c         | 105 ++++++++++++++++++++++++++++
 6 files changed, 153 insertions(+)
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
index 000000000..0160a585c
--- /dev/null
+++ b/drivers/hwmon/surface_fan.c
@@ -0,0 +1,105 @@
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
+	if (attr != hwmon_fan_input)
+		return 0;
+
+	return 0444;
+}
+
+static int surface_fan_hwmon_read(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long *val)
+{
+	struct ssam_device *sdev = dev_get_drvdata(dev);
+	__le16 value;
+
+	if (type != hwmon_fan)
+		return -EOPNOTSUPP;
+
+	if (attr != hwmon_fan_input)
+		return -EOPNOTSUPP;
+
+	if (__ssam_fan_rpm_get(sdev, &value))
+		return -EIO;
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


