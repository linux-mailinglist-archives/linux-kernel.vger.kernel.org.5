Return-Path: <linux-kernel+bounces-137648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E789E502
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C11C21F40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9A4158A25;
	Tue,  9 Apr 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OejyuHux"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94F158213;
	Tue,  9 Apr 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698440; cv=none; b=hsLj6JwBxfrG/zJ8MJ4cmhXHcU0h+mdPYdXy9FMLp0NoKXZycVgG7+XzzjTePjWw15caBOdYwqhokRz5fxJL/lu3NlfA3pBz8Dq6R0GpKwb8Awj8q1pCavSl6QqpDffcfrGjG8lQ5LNsnu6xqujTpzpUxil9zmZ6DtbguW5P+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698440; c=relaxed/simple;
	bh=6GDlg+zLBx4PsLbRoItai3KSHzYY5NK1nUnquIRqNRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8D05nez2smU5HLEdUzrJTMasGRyOfd48DJuWf7s+NaNbs2/crJ9TYZ5CcLT06Ke+I/ZHLZRO/0hafOQ6Ax6b1wkzlxFYYgcDCQZAoHckeMStfjqbcMi0s1J8RuA5MIyAyDJXY0b018qJb6K4cHi2c99XTMacSkJ3S3+cGom+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OejyuHux; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712698408; x=1713303208; i=w_armin@gmx.de;
	bh=sjuhz+TaLmV9ixOiAi3uRJXQXF3anu1HLOApgAGNu3w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=OejyuHuxq9kd6VqEiWc4efIV7P2tLRwE60CmjTJCKvPEEeCx1wZ9StpeHtCBZkPa
	 Urc4Gd5fK9g+l12DW/I6GEWnT4hrt4CAUJp/cvtT9K81Z9GGPbqmGKKmBRCFEfjE0
	 OdSGdaWn9AkB9hWDAij5I/znCxnaMF3KnVCa5bK+qL/ANmnwzjh5hUdB3jeoB860f
	 EOmdIGZwA2Jv/k5s9Ni3GsWsCFBN72rn6WAtCTuzG4xWVsouZpNMfWMKbOO2WRqFq
	 MH3RVZ0sJOXC2ud1azJuBsjaXsjiCNxKz87+FqOud1eBU57Xh6U0K36AH3evclMPY
	 ZfRyjtKApYwwC3DJCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N6bfq-1sr2Xu1PAs-0181f3; Tue, 09 Apr 2024 23:33:28 +0200
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
Subject: [PATCH v2] ACPI: fan: Add hwmon support
Date: Tue,  9 Apr 2024 23:33:23 +0200
Message-Id: <20240409213323.8031-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yYdU5SWqH/bNqNsamsZdNYjgngACK2VgYu9rtYrDw57TzVQOfzk
 nbwx7FnKGIQD4a8CQDvsHEZ/Ospk5g7w4vd5fY8vJGFGBwg7MiETD/G1gpBdl12yKFbcc2z
 A0B0HMdpaANJd+A3Ya97MirLbdVG2NtLy1UxNDhf/yeY1inuODu5Nz3awDzud4o6PG0khzh
 Cmf0GOTxKcwAgCqFJ/GtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wtmSOyWMUO4=;7DDBbaFiuDx6Dit4uUKw2lAzbRA
 k7pkIyPjTCgqpyjA8tgOz/neI3lGQj7fWg26E65YT+M3NP2shf5PJEX7Oqr6eeMEgmeX0mM4o
 0M8pDyPdv3Sy5Arh30XY+Wd9PbSqxrbZet5pjcWPEm1lTZs0BbBN+GpZtbW2F1RgCC7neVtjK
 ViiyTuenqv8liQVouUHwCZKKnDcQihN3YlxNbf/E/41eLbMLlBaypRv3VumgtOtTziiI/yNyQ
 e4ju/GD0HqHBFILae98JDql4ETFH58Ht/CxXqfKZT/UVyrjSCyLHxg7CkDNx1es/mpDVPiLxX
 WygY6lpfkj+UJ9o7etf5WTRebiu+Q8U9J7VuGsVcyCdf/T+SDsCYsgibDMsh//+kVjFuod3So
 Q5PHW+mCldy9Hdq7efwz30J0ljeT2vq22SEqqMzbAq2lSYjEw7Q2+gIWl4DW2Nj1EuRhxukXc
 kC6CJSG79591XxqBilNEWavox4u3HyVaWCQxGrbnCOnj4cJ33BEboAm5aRkplldsQkx7H7gm8
 kMoGd/5s1T8rAHS833amsTd1OkyCflbjHumzsGXAtcUzWy8Ple5ZxD1v782H53gQr/Dek/EEP
 lSR0GmWKlHsR29qgyDmifLBjTFdNrNvxxSXDgU8q9UO1yx0ObiN+T7fNw6QrwfdWbO1S/RVL0
 gF0CXVlIRbyct79se4m/bVsL+DZUCr+nFZ8RMFHayA9BlbuvC1U8x2hm6LhQia/5cn3DWytaJ
 dGOcF7qn8JNCCop976XiNgLkw8GU/KprE3h45fDXGXFfNETCn7+HeAlluLez8nM+cYOaPLbhN
 YbjU5X96fOBnfdhhrmKiMWwwVG/4deimRs4Gu7ErQWSYY=

Currently, the driver does only support a custom sysfs
to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- fix undefined reference error
- fix fan speed validation
- coding style fixes
- clarify that the changes are compile-tested only
- add hwmon maintainers to cc list

The changes will be tested by Mikael Lund Jepsen from Danelec and
should be merged only after those tests.
=2D--
 drivers/acpi/Makefile    |  1 +
 drivers/acpi/fan.h       |  9 +++++
 drivers/acpi/fan_core.c  |  4 ++
 drivers/acpi/fan_hwmon.c | 83 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 drivers/acpi/fan_hwmon.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d69d5444acdb..c272ab2c93b9 100644
=2D-- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-but=
ton.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
 fan-objs			:=3D fan_core.o
 fan-objs			+=3D fan_attr.o
+fan-$(CONFIG_HWMON)		+=3D fan_hwmon.o

 obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index e7b4b4e4a55e..97863bdb6303 100644
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
@@ -56,4 +58,11 @@ struct acpi_fan {
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
index 000000000000..b01055432ded
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,83 @@
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
+/* Returned when the ACPI fan does not support speed reporting */
+#define FAN_SPEED_UNAVAILABLE	0xffffffff
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
+			if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
+				return -ENODATA;
+
+			if (fst.speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fst.speed;
+			return 0;
+		case hwmon_fan_fault:
+			*val =3D (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE);
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
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT),
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


