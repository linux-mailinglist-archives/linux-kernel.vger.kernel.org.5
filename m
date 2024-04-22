Return-Path: <linux-kernel+bounces-153961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F518AD557
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8D1C2104A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484851553A1;
	Mon, 22 Apr 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ji+iLSdV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3891155388;
	Mon, 22 Apr 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815907; cv=none; b=plQIbPptdbx91+JKqzxss5W6qAlgE6yROpwROIbiGH/JbRfZusnHUNQvCmTqGTAUSsllXkVv5k7voTo4Y5VxSB4u44WoWlbm3fdZCJ3e6t7nXKo0c8Gcfw8H+8i7t+R7+jT1ut7WrbhvhcXFnv7XYnZs1qIQKV+sHXdgTXY4zGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815907; c=relaxed/simple;
	bh=t32HRfD9sG9xmkAj4Hx4PF6T67lBqSuSCmmzLTJAUIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itZ0cS2LfpA7fTvWnZzdHIh0QpWkGdcnZgfICuvFmTctCOQJX780CXKBTQL2Hbcuc5Nk8XCLWQ8dTytjdriuH+uLfEwx7freGSVBs8gbDvHeMNq802HutZ5wYgU8/AXc7rpUctz/o5Ki+JeDZrU65zyWjZBUyA/PcQSNmIz/gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ji+iLSdV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713815875; x=1714420675; i=w_armin@gmx.de;
	bh=PhE4wvQ3An5zSU9HfwvnZfpqrDTqYFQDdw5Xps9MeoM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ji+iLSdVxZ3bTwTx0xhSav0a6RVqYeFFx+5OnBnZyIMK7oaJcKR9nzFxTMy4tt9G
	 9a5RotdjAOGaOR8+F7jv1WeDcihQaHQs2skqz7UwSOIP5JKwTNIkJrNfZMXX/chcu
	 kg+7BKVaRg1ETiBfwsTbklDxjdAD7lixZieQeaoxQrw+D+43wexiPJJbFd19DHZa0
	 lDiNs5ASARtkrTzlXjcsn7BQs7jWrM59f9aoCxFzDkeYEjt+qHY82fQ/K68+KHVw5
	 sirWzrQYzFV60Lo563NhvKTXr3bLjDYejc0sf390v8j/wrngoODPM2ljfq7Kbpurr
	 XV6XT+B1BxmWI6JMHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBUm7-1rr4O41HOZ-00CwxP; Mon, 22 Apr 2024 21:57:55 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: jdelvare@suse.com,
	andy.shevchenko@gmail.com,
	linux@roeck-us.net,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6] ACPI: fan: Add hwmon support
Date: Mon, 22 Apr 2024 21:57:45 +0200
Message-Id: <20240422195745.5089-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OSEEtXt1eeEDxjM9sk4vcubd0If84q3/I5fazq07envpqjij5qj
 rLgNdf6A6NHcEe0atnKgoIx47o0y5igX4eHqJVk2Ij9q2oPdZC/5KZiH7oBUVGK8yoVSkTq
 gFkwZTIOaw4HrgLHYKdScNqDdDldr3UsG715K3OxSl1rbDr1lNdDWmuxM6oDZYNWNYgAz0W
 d2iPIa9ULBA3brhgKf02Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:exANISoh0lE=;kouWV9RiQez56XekA3xgj8BFyFo
 zEmnEigzAQo3uL1O9rJgT/QC+OMlwhUfNvkhJkGPUFcvplnffp2VxqgbbtGUmNs+EMJ81hY8c
 GyWQ1AfKpeoMC/EqpZDlDNlJuYCpKenDwXP7b0wzHnMxdE/1nSguPcqTElSPBjag4rBTHGY0e
 9JWWMzoUTBkGshJPIghjVqqJxLg2Cc7nqsiS18kHuYP+i1uJtiAHL9zgQyRqB4MKIFvu+7J3g
 a1gjdw6qBv9cLWuR+6i5ME5BrzSjolWPzACtHlLo0mJA0ajhRva1IqHFW+f0azqnyCXBZno/O
 pI84Q9yDFN6K52EDJ8wo7m5C/no64rZxSBVOrE7XJ0mTBLQsKkAZq4J0vjyz+L/gcP4cA7ItI
 XrOUOWEW6/gySKvcCp47kco8FEah4y+Ytosnp5mSm4JJPfKJ+aChRLHP+Tub3lIObzq+ILZ5s
 muq0LU4lEXPMvoM/NZIJD/guPbFj1jPSdD2gdxbru4r7FkMr3NzX+Ab8yUFU975LMmnOmLY/c
 vURrQZTMf11bhNnf/+XIRg0exdkSrHdXUx5Q+YlDQ3YWOTERBuKtBc5xYBfHF6/jB6ooKV0JY
 hktaMdpEO1D7ZGXNe8bbWzgMDn++CO6EGr/XQKBPvoV4lJVsz0CgOcJYa4jLdb5CbpSDTF6AW
 GeF8HLqv/kAmfV91if0Kqo1XmcOTYR5ZnLgeS9uwgX35WqTsBoLRxwVpCWmFdKCmq6w8R1XJA
 nc/2H4VgQQqYTi/rI7dIzqy/B9122sI5suuoNHoE7fd/rt44+sdCVU6Wcz9tT0QpsIE976z+0
 cUNw5zQ/D5gMNdAK1/oH902XwgUIc3GB0QAv2wQ7XCmUU=

Currently, the driver does only support a custom sysfs
interface to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Tested with a custom ACPI SSDT.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v5:
- fix coding style issues
- replace double break with return
- add missing includes

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
 drivers/acpi/fan.h       |   9 +++
 drivers/acpi/fan_core.c  |   4 +
 drivers/acpi/fan_hwmon.c | 169 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
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
index 000000000000..34a524c285a5
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hwmon interface for the ACPI Fan driver.
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/limits.h>
+#include <linux/units.h>
+
+#include "fan.h"
+
+/* Returned when the ACPI fan does not support speed reporting */
+#define FAN_SPEED_UNAVAILABLE	U32_MAX
+#define FAN_POWER_UNAVAILABLE	U32_MAX
+
+static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan=
, u64 control)
+{
+	unsigned int i;
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
+	unsigned int i;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			return 0444;
+		case hwmon_fan_target:
+			/*
+			 * When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			return 0444;
+		default:
+			return 0;
+		}
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			/*
+			 * When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			/*
+			 * When all fan performance states contain no valid power data,
+			 * when the associated attribute should not be created.
+			 */
+			for (i =3D 0; i < fan->fps_count; i++) {
+				if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE)
+					return 0444;
+			}
+
+			return 0;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
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
+			return -EOPNOTSUPP;
+		}
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
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
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
+	return PTR_ERR_OR_ZERO(hdev);
+}
=2D-
2.39.2


