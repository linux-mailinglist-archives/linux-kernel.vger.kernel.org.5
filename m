Return-Path: <linux-kernel+bounces-135327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1D89BF11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32A61F2131F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53B6CDA8;
	Mon,  8 Apr 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="S9Q7HphF"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17984433BA;
	Mon,  8 Apr 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579855; cv=none; b=LFIRqCuQw3mq0givcoBg2zOodihI/CDU2+696/sgYipEHNYGSzWW+wrIgRJKWD7TC0j3w4qhu/+/26G2kx8z/Yt9l3bYyKUndrb6ovMYP14D2AchVrDqjW3t2hknLSJgpHvsO9Y6UY8+EylSpmnu7ZVwTyNT/e4kYAR6ErUT97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579855; c=relaxed/simple;
	bh=yefMtkxcArShVlH4gKmHcFyVb/vZbZvOhfWn1j2P5VM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lBZdgtRz9KXfwcXoy8B2079Gsdy1HVGyKIZhF8u+0EPoiMX+TSSYBBT6fyF6XF+SRPlI67W2PrIb4XFBoX1LiWmL49fNWK5+jmTAL9chZZDhK+/lekBDSnM8Jb9+HgUc7mqKA1hQtEAmX7cXBtkVYzt5UszrD4My3C+QgLyMSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=S9Q7HphF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712579841; x=1713184641; i=w_armin@gmx.de;
	bh=L1BU2ousVKg/7DmZnw1u5sv8vb4fB8a7T761tiV3qfE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=S9Q7HphFy27GlMXLfw8AHgtihTfaL/SmvzwRaEDv2NlovsXJj8DykQvWlI8Ehk9u
	 gBLjviYaslpfZGYWozDg4ssLFTzi1l83LULosLpHpQ5NtH0BR/K9CZz9DmIG0h+7Q
	 giZWiki3YxPAd8CNDrBwIX9g5zSU3nd/23Uc1yd75oEQvVvIhA0VM9PWlR/GZh20V
	 k+IIxxSzKzuuqIOBq6xvzFez/Qh5mSqJbuG6PkLFonJs0fkGWawK2dlCKdXUdIMnA
	 iWTBYdmj5ciamUq+AMnTWhaMi8V2NLCsV7LlNDPjhWCJEQ0whSMolGV828c8uHY9a
	 YDNfGFwzTqTzkmuFiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MSKu0-1sMJVA45Um-00SfKi; Mon, 08 Apr 2024 14:37:21 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] ACPI: fan: Add hwmon support
Date: Mon,  8 Apr 2024 14:37:18 +0200
Message-Id: <20240408123718.15512-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TK8i3nSi3uO+dm9pfkFvHgu1Ru5aKAWC+801oPC3Z2vPUGCb6xd
 GSOfeeyZ+hwd391g2hc3ov22j6T0G75yPo82BuPRdypwM/ccL3tyC/nxiYWb5iS/8XK4PWK
 jnlB/yO/Mrx+//S7G8MJNPIOHOBOCEUI5iDJA6Wug3zQeS5RWKCZRrmKLObl2EE4Of2yHQh
 RwrJ6W91gzNngxumDt+YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NOgi25aLGd0=;iMCVK8eKt9CCCYGQdxi8VOTrS5H
 SF5wcrvUdxUqVXeT7r2zZtWQrKSVf3ElAmy5XvJnVR5LPER1mtXY0u0otXK+kKqyLAoUsA4HA
 zt9NU0tAWyLe/n73hw/2auc8J9vnRzp04bsSnmF+2Q6ulaKKf+T++Bo5F4MgGE3T1livVO0Zy
 H8hUPuPb3xQxn066Way1cN7LsW0VrAWfWTegtdnKeVkrVf6vpKwueFX2iQrEcEoY1hQxU9wKU
 G0sPYyP0qOWEfLvn5ZrXtLAAL+EvqY0lozhxqbA6LZUidvG5Nrqe4Yuer1AR2X+Ebpnnus0ee
 XdS220hOAS5MfIXGn/6WhN6LgDzgWOFwoNNkBT4CLBxuKpQW/5KHk+7mBdI2BC/D/dOQFzcHs
 HeUiDpc+ylKI+OcyQ7iMWMBXCwoK2NsrK+soK5Z2iKJqmAuF6KRuc4myilriu1SnouplGXQGA
 757ve82M+3+6/lJdtycsj4jq2rf7OecTTsbWgd9qrdGzoJHXhiM4JbzFxAjcbWVtQAkvpOFi4
 bDnXo9ylpu1X86b8efkFo6Y53RFmGDu9fnz5FluJDCs55X/JufpqgDql+/R6CtuZsk+36LVnv
 V+/P8GLgkzhW0aQ3gGo9kyp0V8MmrC4ul1iznuy2PEd096DqgcjMD2AIK+pXpGVgA3qCWtd4m
 1XEGq/v0VEXQNKl0XrTmMOZmLYvHmJBOCE1dGhw/40VXUBLhzm9DUl6Irf6D0LvX5bIfeLDaF
 EVZex4sm7SDJs2tLP0kQdRoRqHcR8kvkYpwfe97//eLwMcC9vGsSQI7CRMcloJUdEQoXvjkz+
 eTlmHKsB9eUiJYvRDZHToh5mAx2xnw/TzXzMgrvJJlGf8=

Currently, the driver does only supports a custom sysfs
interface to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/Makefile    |  1 +
 drivers/acpi/fan.h       |  2 ++
 drivers/acpi/fan_core.c  |  7 ++++
 drivers/acpi/fan_hwmon.c | 78 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 drivers/acpi/fan_hwmon.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d69d5444acdb..9a2e03acc1be 100644
=2D-- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-but=
ton.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
 fan-objs			:=3D fan_core.o
 fan-objs			+=3D fan_attr.o
+fan-objs			+=3D fan_hwmon.o

 obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index e7b4b4e4a55e..45c2637566da 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -56,4 +56,6 @@ struct acpi_fan {
 int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
+
+int devm_acpi_fan_create_hwmon(struct acpi_device *device);
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ff72e4ef8738..6bbdbb914e95 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2022 Intel Corporation. All rights reserved.
  */

+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -336,6 +337,12 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;

+		if (IS_REACHABLE(CONFIG_HWMON)) {
+			result =3D devm_acpi_fan_create_hwmon(device);
+			if (result)
+				return result;
+		}
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
new file mode 100644
index 000000000000..4f2bec8664f4
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * fan_hwmon.c - hwmon interface for the ACPI Fan driver
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/hwmon.h>
+#include <linux/limits.h>
+
+#include "fan.h"
+
+static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor=
_types type, u32 attr,
+				   int channel)
+{
+	return 0444;
+}
+
+static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type=
, u32 attr, int channel,
+			 long *val)
+{
+	struct acpi_device *adev =3D dev_get_drvdata(dev);
+	struct acpi_fan_fst fst;
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret =3D acpi_fan_get_fst(adev, &fst);
+		if (ret < 0)
+			return ret;
+
+		switch (attr) {
+		case hwmon_fan_input:
+			if (fst.speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fst.speed;
+			return 0;
+		case hwmon_fan_fault:
+			*val =3D (fst.speed =3D=3D U32_MAX);
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops acpi_fan_ops =3D {
+	.is_visible =3D acpi_fan_is_visible,
+	.read =3D acpi_fan_read,
+};
+
+static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_FAULT),
+	NULL
+};
+
+static const struct hwmon_chip_info acpi_fan_chip_info =3D {
+	.ops =3D &acpi_fan_ops,
+	.info =3D acpi_fan_info,
+};
+
+int devm_acpi_fan_create_hwmon(struct acpi_device *device)
+{
+	struct device *hdev;
+
+	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", =
device,
+						    &acpi_fan_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hdev);
+}
=2D-
2.39.2


