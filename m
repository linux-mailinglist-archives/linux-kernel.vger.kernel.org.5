Return-Path: <linux-kernel+bounces-152753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3808AC3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13AD1C20A74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631EC18AED;
	Mon, 22 Apr 2024 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FGGVDbru"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FC2F5E;
	Mon, 22 Apr 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764612; cv=none; b=kzuO2RDN8MhJ1U/+TBxfDq7BXNTtZFuRzJazp9d7ckGweA5VTXSxLoaPRAhIpSEKW/E98brtkjRYMKOC+LPc/eXs25DmljYwTuK7Jv+lDnFxQ0CDUCZKRrVg8Uumq5/dSzMhyc61WIesf9D/cUSjzlR9j3CWOXbclVZvmLURD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764612; c=relaxed/simple;
	bh=He0zbL0PU3S3TFQfRLYChmdyE6XrqZzNgLl89NZgNZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glwa26jym+69GAW56NvSHWx4Lk8tuIHwy3bi7XWo5EFPSrD/p2/uGPQO0kkjYcqo2A3shQdfg0SE2kLdW2e/q5v2+Ro+X4YpiUa8CceSqO/RX/NITK11FtwxahDDRwBqVenOY1ijib1fKDyLbZ5+jMYE4Yyq9VthJtybLRGDLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FGGVDbru; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713764580; x=1714369380; i=w_armin@gmx.de;
	bh=WEN7aBRlN37FKl+bSkFenqf1s7tCuOCXoTIAUr90SiY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FGGVDbruynrZbtCesQ2RVIaAwXexjyO8O87KZ+kfKo2dWHf6Bv277gTiEP00vuNY
	 w4PvW8goxQhWeU2vGMVBLB9dEWOVYuJ6y3EIrU7FAdpnT1S9fuJPDHcrAxRKHjbQy
	 +0uGLXqPKsQ902J8UZ4dBDXVErsbsJX51tsNcUTPFO5iVhwTpHhbQ1tOj326funUq
	 qKtGbo+hOuoGRfOG8SJoaKR/hTyJmneb7XXiwWALbgnX2YHjbtzSVXGhrOWHivKry
	 nQx2bItw29bM/ifbJnZuyNKjyx3+XlMF9BlKNSyFFEyzmni+jWfz0+iCPK0eqPZCq
	 U17IutvCKKSGL5wruA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1poA-1s0yJX3pYO-002DNE; Mon, 22 Apr 2024 07:42:59 +0200
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
Subject: [PATCH] ACPI: fan: Add hwmon support
Date: Mon, 22 Apr 2024 07:42:51 +0200
Message-Id: <20240422054251.4006-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sh2Myo4gEJPhKhQ1wv9rPhsWJer98VoeZpoLslc8+EINdyegc47
 EEHgjobh0mNieRw0jPuIRH3p3kkkFfQpOntcHRxoWyywOwrNOpkMD6AYGSa3vGOCtZES7+T
 LrRo3vWuzDcZu7nq7Mvy4G4HKz4+J7LPr8TuVaIZQ6RynCIF4q3WDGPFwb3Y1QLVPVrwhfX
 HKoipt70KPf/OhcakwgRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EgKfE8EYO8Q=;SWbmCLiqMw5lMuiiap7O4RjIWLC
 6ONLKNtA6tNueRgP3Jigp+D96eiT6uPfgqoVSjkc6TT565ovnJIHmzFDuvQBV9HHwiLm3h3N2
 BKm2cXBDht8FWSaX7pZ3z+D3KR+F2Y/XXaknZvalyFfDwmQv2IUrNkWl/VmzaXZK+QUIu+Gsz
 ASlROpy20QVKpzPBD5Y6zE7J+uiJbZvm9QnpZK6loiNHjtBzibp9yvyJkhjfCAJwTtxTMt0Ix
 n0FzOE9+GADUJNGReXUn24V0bAX0vOS/P2tAu4rKubD6SvQCj8H0fIt8UB5+XGlJD3yf4LW6z
 mlfgmoGIiAxGf9/D3mdd4tuYdkMrD2Y7noBZVannsuvH8wzkV90BzGrPst0etZjslll4tHdsT
 3jO+jpp0pXY0yX42Z4OuQ9S6CSxCOLYPWBIilSBbGPaSsDvfKc8EoPdFSwhmrMCoTwS3OrNt9
 v/DxRlfj+iHIjfecQCkMaMe5G65X8Qls34+uIHuh6ulovTFbAKKHFUTvaayV2OXBDtb/GxkVP
 eHIWbYR8D/i6lNJ9eNKtZPEb2vWW4mfpCjwruBnWQ0VQfE7NTFGY7NPCRmqMBZyc6id4Dv+B6
 4h0nqmvqIG8H1HMGAuikNkELTAjpn2dc11LOjPuQrlJWZyGSi/gilqiPI3s+TDD7JQQ0uhksx
 BCFw/LXkEnBhNRLqRIPco8rahO7Ztzy9YXGQJmnBISJYY8yYLmQtIJ5d23qF8W3U/VLVtUkGT
 Q7GvA5cxCUngVc6XzzhURO9koTiUIJcA5kpNczYxReVCteXgsGme0YA2dRPdZ8wEUV+Nn/smW
 Z18KzbXRRyf5lgEv4pFQl0wMVULIB3pbDNSAvaZYZnr9g=

Currently, the driver does only support a custom sysfs
interface to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Tested with a custom ACPI SSDT.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v4:
- fix spelling issues
- check power values for overflow condition too

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
=2D--
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/fan.h       |   9 ++
 drivers/acpi/fan_core.c  |   4 +
 drivers/acpi/fan_hwmon.c | 173 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
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
index 000000000000..e7e5b6a29e7f
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,173 @@
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
+			 * when the associated attribute should not be created.
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
+			if (fps->speed > LONG_MAX)
+				return -EOVERFLOW;
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


