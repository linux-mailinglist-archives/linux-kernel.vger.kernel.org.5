Return-Path: <linux-kernel+bounces-152770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CA8AC409
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60525B22281
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FE1BC41;
	Mon, 22 Apr 2024 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Dvqp8S9J"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE718042;
	Mon, 22 Apr 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766158; cv=none; b=ArMV60QQZsyIqz0UwUhvMpHvPk/WfbsgMKU6FJD4XyZMxAbbG0xNL2uN0uoOmAqJVfZnDb4CKZ+SDo1aRrDvKvQjRYyG0rlOwF6Ws0hUBQJTeuQAD+UHm4UBxd90EPjtq1X7LiU55E8HgNRcMDSvBQKqtRIfDNYhmar5utksrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766158; c=relaxed/simple;
	bh=He0zbL0PU3S3TFQfRLYChmdyE6XrqZzNgLl89NZgNZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9k1ORWeENagAI1M71LSNNZ/X1WD3HOwwEhHq8mki7BTlaK/MHqR03mseEP5fTiIFx/h1/2Eok4SOflHW4FMQGbSpFwYt7rfMUHH+CO6KseDVD+Z883jIzBsPPNRoXLM0SaFFI1NHSL8ikDSkoKvrVt8Gl1bGmLvSitsR1/+21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Dvqp8S9J; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713766128; x=1714370928; i=w_armin@gmx.de;
	bh=WEN7aBRlN37FKl+bSkFenqf1s7tCuOCXoTIAUr90SiY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dvqp8S9JQQVINoWKocwqKcl7/zQP5yw+GhOsXvAp6ym7oXFFD/9MClFohBFr1Jes
	 c1rcM5khVSp3TB3WB5Voc2rcgwW8zW69GCP8KNmuEjtcZLF5aoqv3KiA5vQKDuvw8
	 SRjLNKt9h9TKpOKQyvuS5Qmq/cro+ixONJDrRCB/q5pGcmQ0BFmsbkRPJdUZgxT5d
	 mhLY6UxYVmhXaY6FBiOF/3brGua0PDFPK7LW9AD4SmAPJpPZ/DqBpsG/P5DeSLFB+
	 f2lzACxtmQMlH20dec85+5kG6UdUjmWt7PeLvu2CbslM3UC/dFRBapak2RD4IaaE3
	 ulYX48qFU7dq9mOBwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1My32F-1sv7VP04eV-00zZ98; Mon, 22 Apr 2024 08:08:48 +0200
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
Subject: [PATCH RESEND v5] ACPI: fan: Add hwmon support
Date: Mon, 22 Apr 2024 08:08:35 +0200
Message-Id: <20240422060835.71708-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XymzL+xZUhXnHU/30jYAXRTwXlcY46UBJQeingUz2ca1mN4C7ge
 yMxO8lRdlIDEFi1xD9ceAwgytRR8gzouN92WO0sIrVEvXqaAbg+pAOKWbIS3mOfxTxAS5Q/
 eqrHqt9ugv0G5TDYrQsddsjau41ECQvSlIT7DgDHZDA6c0eP34a5fhTfzxnlKaahRO2D7aG
 hjtbXPBGWqpuzlpRAtyJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BrTNafZfKhA=;hT+tE1vUPXs/Zy4yarizHRAD9NZ
 XkdR1/7Kuk6clNTwQ3PHeiLHxN730CTpDpz0Nqgd63IL5VNqBNkRpDMPLP8/SAoe9HKH9nwpv
 DupNjgVL6A/oAtBV4CFm9CK2vC7n3nLcJblQBSNmx1i0F7MU0IBe29hg2o/wd0A1CjY1mGNkj
 u+lcgSwW+qVurmyUYU/rUbghsVgTSCp16w4xl9Or6Ha8Uj3hRNA4rnHuY9Yy7iqQAxTkHvs3t
 txIq/AUEZoSavtbTteT+ImVlJVKSQE1X+T4jRK5FMjpFgET8XRqAWx1gHpUUbUASxEytxCuYp
 Afjg4g+QHs5xSMaXHFe/aSVVHe1nQve7CxRsyjoBKtgOsNTM/yPLFkoy1F3hrAKOlu91dLShA
 rRZLChlPNJXrIryeW1qMJGnepNecBc9nlXL9hmLGuxlF3hL/TMM2QfaqrXeWWmKqVfr/17lpp
 F2oPAqzpEFAnZP1lAZdp/poAOlDWi8rl0xE8c7tdpo+x6R2tpp4U/bnHg7AJJcqmnNQ44NGhE
 JLHb6AZmQNjVfM3hddwB2KnXL3EdYTG+ZCS3OSYB1vuhjgiYLTfk4N6qLEGGDQSJ338Mzjzpm
 /avQ7cZTPnLhOnNornO2i1XPTJc5xuDl2LKW07HzeuNbTolYHAne/JGgOdcAcE/0OD5AMf8ck
 Mk+7hojHiNDOK/E1xC06lsNZLPoas8NMKYCj/8eow11WbfQDMYsDaaFwrxQ97rShSDWsHcntf
 1z14famHpHhlw1n7gw1HccEAnpWadiGxmQq2A9a0eUBy+b1XcwEldZF3lsaaxzySIjRf17Aog
 fT2RQWeQRv/KonFVAJ4Er/ZRjFnqz9kZfT+dSOlOzy8CA=

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


