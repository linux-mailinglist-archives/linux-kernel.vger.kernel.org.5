Return-Path: <linux-kernel+bounces-144312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C58A4477
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD06F1F21449
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501E135A6C;
	Sun, 14 Apr 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="T+SGprR1"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B317551;
	Sun, 14 Apr 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116898; cv=none; b=hosijtEUZ/4V+56LT6lvS+5KQapI9zG7vKCl7lnByw0Xcv9O+bGX66YgUwr3vlYfFVzNi95Yh1q81y/HTBL12ZcTIrsQE/Nr4AhHaM0QAutxwzTAjuJM9zjjovNcq0aK0OL36iC+SmIMjBNOPgShK1yB3CsgaGI72kzo5JbrFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116898; c=relaxed/simple;
	bh=zhVnywKsEUVVn68Ox5CjsJoC5KY2EseaaYYPUAX69wM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZKdlmUxCchn+KB+iVFbgBdyea7D4CbPRwCP+L5Wv+zuJ73bzVsZzUG16oUP0/WKP3OPYyIwEelrp+yG56SwhuUnfK/P6c6qfcnCmOl/3rlwtd9TrTea3U3Adq+pH1jpZgpn+K6xOXHHA4YUGDlxzr1b5skVdJXdAXYkESdTSKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=T+SGprR1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713116867; x=1713721667; i=w_armin@gmx.de;
	bh=FMQEYJPewr7GILJ3NurF0NrXO7XmqpcHPKyvchRKn38=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=T+SGprR16ucGdS5+p9tfmzAWAh9dkhGfA4veeoWmwuko9/wDjtKu1yMyellNE42j
	 m6xqD8ZZbG+4Ygl57pYW8evNBGDB2gAE8edFMy4+b2+JlNXelXuJgvYGR+y4ssrJx
	 cB1CBUZQzbmbOgdQwnjpnfp6OqTni7Ua5KQbwwlFjLV9P74CNokz9R2SAKA37oNEQ
	 vQPrgmUYCr2/j5B7X0FpE3THW1p7psietw9t5i9QfdWhRZSLFcZE7uhrLakFizGTR
	 FcSxtJklfzrstPcSTwQ2C6cT8vmYascXdFZLXRkRKDEVahuwCtB82LGND354ZuYMC
	 DYc8dsi+pP5j1Wzu5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M6llE-1rotkz1lQU-008LhE; Sun, 14 Apr 2024 19:47:47 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4] ACPI: fan: Add hwmon support
Date: Sun, 14 Apr 2024 19:47:43 +0200
Message-Id: <20240414174743.8575-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JTAIN1SDiJ+ioZAZSegP/Wnm7T0hGNjAXPgf9eB/nHXlRr74H6x
 UnU5+37nwIfdBKcwXdL/Fe4llLagEnGx7ZLIRxrmSs44BTYepp7ijd+lsJs16TBnGMFQt+R
 iw4KdrsXgWyisVqeHY+CDm066R9LTzINZq4TStrUJEfMdqNdioiVhtuYRNluVWOM5hswE7/
 7eowojLL4QzbEqAfSGMnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2eyDB5KdDLM=;P5ZRJy52lXzbxhzYa4GA1d80HDB
 sDnk0bgWvVlxpsQTag5Q+60ysWXUkleNz1FQ/prTl9DJ0gynf8Mhh9EXOMTGlXp7d4xe3V6wZ
 ZY5KvqZZ6+M12aAHqP3pATcgQpvMWlRLsMEf7+xNZhy92lGyUmWBanF3ptGpauD8PJlnGrRCw
 IzJtysBAjX+RvhuR64I+wn9g/rhlhcS9+kRNu1Y7gidya4NikP7EghS5ktSRSCxJX8goWPz7o
 +qFHryP+KDiA7QHTMEmdJQg5CqL8P52oipS7elzhIq8B4debTk4S26IY32LS4G5ok77m56AEb
 q39yfRrIsh539QApFNPONwPDV0xZcNqFgkyU7ihOrMKjfxQ6G9TxHgsaSFOR9qHyhPfbysAN/
 BGaK4jeTORSts9ekDGy6CP8ULOdqf0At1AbQKemogGfmTC/f4RZkVtgSF1WCWqiOfkFXhPgwM
 krMKbi4UUxPRYulRYx7JZS1ASyVbD0pFouwlXNR6WD58ENeH3/Vtn7VnJtMunnQifk2A682hs
 7XDr++NUiDneL2YGeQXHB53Fa5FrmKhlSJf17Xor775Ib0vgQwmTozAWdL5/eagXmzMZT4qql
 T+RE3Z/5kSgRtxg4MhchU8ehH/X6O+tDLSPuE2GQ81HnZ/Me7xDWlI0/uiFMvmXPS1ADw0Rnq
 11NOf0wW/315socfkCANrJwZt7AnFda7T6xErC4hTZ+ZVKS/xmCZ6QOHwuh/0mYTPNDxfvAMD
 JmHO7kMZu4NRPILlNQF54lSFWYF+oUpN0SEwXDMwHBDOrvujd+IshJHEb5v/u7gEC0ifnmwRS
 yfwsbVLWFVWjWfMCFUck+6wVq7M20oztz5+dSmXFbsHv0=

Currently, the driver does only support a custom sysfs
to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v3:
- drop fault attrs
- rework initialization

Changes since v2:
- add support for fanX_target and power attrs

Changes since v1:
- fix undefined reference error
- fix fan speed validation
- coding style fixes
- clarify that the changes are compile-tested only
- add hwmon maintainers to cc list

The changes will be tested by Mikael Lund Jepsen from Danelec and
should be merged only after those tests.
=2D--
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/fan.h       |   9 +++
 drivers/acpi/fan_core.c  |   4 +
 drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/acpi/fan_hwmon.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 39ea5cfa8326..61ca4afe83dc 100644
=2D-- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-but=
ton.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
 fan-objs			:=3D fan_core.o
 fan-objs			+=3D fan_attr.o
+fan-$(CONFIG_HWMON)		+=3D fan_hwmon.o

 obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index f89d19c922dc..db25a3898af7 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -10,6 +10,8 @@
 #ifndef _ACPI_FAN_H_
 #define _ACPI_FAN_H_

+#include <linux/kconfig.h>
+
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
@@ -57,4 +59,11 @@ struct acpi_fan {
 int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
+
+#if IS_REACHABLE(CONFIG_HWMON)
+int devm_acpi_fan_create_hwmon(struct acpi_device *device);
+#else
+static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) =
{ return 0; };
+#endif
+
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ff72e4ef8738..7cea4495f19b 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;

+		result =3D devm_acpi_fan_create_hwmon(device);
+		if (result)
+			return result;
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
new file mode 100644
index 000000000000..0ae9017bdbae
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,170 @@
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
+#include <linux/units.h>
+
+#include "fan.h"
+
+/* Returned when the ACPI fan does not support speed reporting */
+#define FAN_SPEED_UNAVAILABLE	0xffffffff
+#define FAN_POWER_UNAVAILABLE	0xffffffff
+
+static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan=
, u64 control)
+{
+	int i;
+
+	for (i =3D 0; i < fan->fps_count; i++) {
+		if (fan->fps[i].control =3D=3D control)
+			return &fan->fps[i];
+	}
+
+	return NULL;
+}
+
+static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor=
_types type, u32 attr,
+				   int channel)
+{
+	const struct acpi_fan *fan =3D drvdata;
+	int i;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			return 0444;
+		case hwmon_fan_target:
+			/* When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			/* When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			/* When all fan performance states contain no valid power data,
+			 * when the associated atttribute should not be created.
+			 */
+			for (i =3D 0; i < fan->fps_count; i++) {
+				if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE)
+					return 0444;
+			}
+
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type=
, u32 attr, int channel,
+			 long *val)
+{
+	struct acpi_device *adev =3D to_acpi_device(dev->parent);
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	struct acpi_fan_fps *fps;
+	struct acpi_fan_fst fst;
+	int ret;
+
+	ret =3D acpi_fan_get_fst(adev, &fst);
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
+				return -ENODATA;
+
+			if (fst.speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fst.speed;
+			return 0;
+		case hwmon_fan_target:
+			fps =3D acpi_fan_get_current_fps(fan, fst.control);
+			if (!fps)
+				return -ENODATA;
+
+			*val =3D fps->speed;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			fps =3D acpi_fan_get_current_fps(fan, fst.control);
+			if (!fps)
+				return -ENODATA;
+
+			if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
+				return -ENODATA;
+
+			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
+				return -EOVERFLOW;
+
+			*val =3D fps->power * MICROWATT_PER_MILLIWATT;
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
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
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
+	struct acpi_fan *fan =3D acpi_driver_data(device);
+	struct device *hdev;
+
+	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", =
fan,
+						    &acpi_fan_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hdev);
+}
=2D-
2.39.2


