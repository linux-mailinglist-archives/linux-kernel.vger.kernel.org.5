Return-Path: <linux-kernel+bounces-46332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B8843E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C221C2ABD5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B978670;
	Wed, 31 Jan 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ooMNmd23"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1E76058;
	Wed, 31 Jan 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699832; cv=none; b=tbifSHV0+sT/Z/XEpsD+ACPDZPTELSCBuN2h7W8TmjVccqfsNNL8ZWxxSjjq8qe+33eD+fLLA/1YRcl1nbzjeVO1VQrODG9NjthZMcsvOBmfC/jmIq01k64dajAEABEfotvkaQ8yfDKcVIp663DQIEygFdDDTYeNovZw6b/F7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699832; c=relaxed/simple;
	bh=TrsKOF55qp1ILWmy4Bo/xU5i29aKGzHbP46d5jF2Hok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke/wKjbIBfbohRkXKfQwqHxHC5cByFZwa8bWHNAVvaG6lvN/ae2okBpHjB2b97TNE9xE4KE1YxAedxx8x8sNLT079jdiP2FCDlUmR4Hhs+aLtdMMfyQ8wOqctGGkQRBoG0EXbMWbtVbTjJ0BVRSdui4Dbe8neI8EEpE07UDHB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ooMNmd23; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706699819; x=1707304619; i=w_armin@gmx.de;
	bh=TrsKOF55qp1ILWmy4Bo/xU5i29aKGzHbP46d5jF2Hok=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ooMNmd23ht5HJN48DLiXxq5Sq6Rgu3ffwgof68L3zJscpm4O3hmo/NJHmQlVEAXf
	 zqtM8WKhlhSyFnkvpbC98JI0mKpVeKXfHyA4KDynn32N6NU/EpalOvBWQ1i7l3vmO
	 mQEuqKgGCzQ3iRCG5UiUrEvo+GeNSSnv2LL3rD4RBVYsakpqtD9seviIHbdYoT6d/
	 Cr0wGv6Khq5AImR/i8nOeDFM346LhQBLMMnyux5FJ3Rr0QK1s4RepGHvI2ktRoodf
	 iE2kHKylpNcV/I6Qi3nEXAqLdgTz/Ze39nwnTfIiHk1iY3v6OTK/s8RFNwM7WFINg
	 rRvPwdPyWWq77oYtZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGRA-1rnLxd0eNK-00JKnZ; Wed, 31 Jan 2024 12:16:59 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: dennisn@dennisn.mooo.com,
	lkml@vorpal.se,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: Add ACPI quickstart button (PNP0C32) driver
Date: Wed, 31 Jan 2024 12:16:40 +0100
Message-Id: <20240131111641.4418-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131111641.4418-1-W_Armin@gmx.de>
References: <20240131111641.4418-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AQu5VSnpGmVQT3zPMXhlCFUdcoyBR1IqdAB3qHwBnK3lcHRY3qZ
 k1/bMkLpHS8uEiFwxUyJEmW1H+6xkGtn5IIR91Vmuxr/bI90gV8d5ZGQf3rN9kF0rzcsXGA
 CpUTxjQOEhpV9irr/bFV6kfkJ7YTDdur9LOMYONfXzmRenHZBLbzSe1/DRV1bfqKSDtpBOz
 VykpM5uYku6gwsxa16ywg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qk9fWM+aFiE=;AXc0UpokgFZpe3NnzhbWkLD1php
 pEhPJrPVg5sDI0cec4MDUVOV2Nk950ZoLGAqJiFvWVxr/J817koKb/sUDxvanU+xjSG39PvBi
 8n4h8NyZ6cgUfcfv0BML4SO1Fbz3uYfyE0NTP8eGwzk0CyvtkETXY6YaD7XR+pXw7r71FSgJ7
 kbHeySZQB8kKUwJ4TjLS38BUsSun/+wWmjZgZX3PBgCENDavk+FxXvhBN+eoNUe762YbU1iNf
 2eHQ81QabduIO+u/X679dqo66cUZbJc/jnq7QRGORJXNZaj4K7AH10KDGXkiYBBaiGyGSspIz
 bGCZojPi6Gn/QButwtlAh5CnXkGAevqj9ACAq9ZgwQlS43LWKqytb2TAk3f97bgrbpVrcL5Sk
 GL30eFtS9G4bOJNFedvm8MuRybTxtzpDV96aYyA41MtOoOZ6nkWH67PQXYlxDaUhYUgGPIjN5
 20T10JxfarfvYdJTr45QFqjj+2jhd/taH9vrdgulmuW6mShjym2D4CtTIqzy8zylg6X/AnU/5
 GsQ+mE49yNAT7KuCFPZysEMhJzhmCXVL4DmL+WRwUT3eImSorhhB9wB7SceMNDE2RQVb9+9iH
 bzwmFlrOp/ADKwN44I4TbZ23k0JyES21hk/8cewS63Pi3F2FZdhQdkizK2p3TeALohEn16syp
 uRCNRSSPCDtPLkDkKwrKucykMrCXXe/yJpSAIXird/eUo390hvxPsBfGDtzKQg/aM4kWjgypX
 B1+t0PABMnuGoBKb04vvGF86vvuFWEAJvcNanv4ZvAdvfky1Jdf3y9/mN6ezQnTpnqcgguX0z
 Dhd4SiHScOHhulHhWDtDZXRL9A+fBLnUznTxWO+sYQzB9mn6EbOu8gMTzaMsDiqouMmGBNLdM
 VMxPTZlbqA3jkvU+b2bHlwLAsDX6w0sxMYk9Qi5IpHQAfEyMoE34ViZ6NqLYtAoJu9MyUHTGM
 mSU2kcNau6cntTq3mdeSTc2sFT0=

This drivers supports the ACPI quickstart button device, which
is used to send manufacturer-specific events to userspace.
Since the meaning of those events is not standardized, userspace
has to use for example hwdb to decode them.

The driver itself is based on an earlier proposal, but contains
some improvements and uses the device wakeup API instead of a
custom sysfs file.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  13 ++
 drivers/platform/x86/Makefile     |   3 +
 drivers/platform/x86/quickstart.c | 225 ++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 drivers/platform/x86/quickstart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..b71692c55f7b 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -354,6 +354,12 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	drivers/acpi/pmic/

+ACPI QUICKSTART DRIVER
+M:	Armin Wolf <W_Armin@gmx.de>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/quickstart.c
+
 ACPI SERIAL MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6dbd40e2aeda..9cba9a410e28 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -641,6 +641,19 @@ config THINKPAD_LMI

 source "drivers/platform/x86/intel/Kconfig"

+config ACPI_QUICKSTART
+	tristate "ACPI Quickstart button driver"
+	depends on ACPI
+	depends on INPUT
+	select INPUT_SPARSE_KEYMAP
+	help
+	  This driver adds support for ACPI quickstart button (PNP0C32) devices.
+	  The button emits a manufacturer-specific key value when pressed, so
+	  userspace has to map this value to a standard key code.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called quickstart.
+
 config MSI_EC
 	tristate "MSI EC Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1de432e8861e..0801ccc37e9b 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -70,6 +70,9 @@ obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
 # Intel
 obj-y				+=3D intel/

+# Microsoft
+obj-$(CONFIG_ACPI_QUICKSTART)  +=3D quickstart.o
+
 # MSI
 obj-$(CONFIG_MSI_EC)		+=3D msi-ec.o
 obj-$(CONFIG_MSI_LAPTOP)	+=3D msi-laptop.o
diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quic=
kstart.c
new file mode 100644
index 000000000000..ba3a7a25dda7
=2D-- /dev/null
+++ b/drivers/platform/x86/quickstart.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * quickstart.c - ACPI Direct App Launch driver
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ * Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
+ * Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
+ *
+ * Information gathered from disassembled dsdt and from here:
+ * <https://archive.org/details/microsoft-acpi-dirapplaunch>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME	"quickstart"
+
+/*
+ * There will be two events:
+ * 0x02 - Button was pressed while device was off/sleeping.
+ * 0x80 - Button was pressed while device was up.
+ */
+#define QUICKSTART_EVENT_RUNTIME	0x80
+
+struct quickstart_data {
+	struct device *dev;
+	struct input_dev *input_device;
+	char input_name[32];
+	char phys[32];
+	u32 id;
+};
+
+/*
+ * Knowing what these buttons do require system specific knowledge.
+ * This could be done by matching on DMI data in a long quirk table.
+ * However, it is easier to leave it up to user space to figure this out.
+ *
+ * Using for example udev hwdb the scancode 0x1 can be remapped suitably.
+ */
+static const struct key_entry quickstart_keymap[] =3D {
+	{ KE_KEY, 0x1, { KEY_UNKNOWN } },
+	{ KE_END, 0 },
+};
+
+static ssize_t button_id_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
+{
+	struct quickstart_data *data =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", data->id);
+}
+static DEVICE_ATTR_RO(button_id);
+
+static struct attribute *quickstart_attrs[] =3D {
+	&dev_attr_button_id.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(quickstart);
+
+static void quickstart_notify(acpi_handle handle, u32 event, void *contex=
t)
+{
+	struct quickstart_data *data =3D context;
+
+	switch (event) {
+	case QUICKSTART_EVENT_RUNTIME:
+		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
+		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event=
, 0);
+		break;
+	default:
+		dev_err(data->dev, FW_INFO "Unexpected ACPI notify event (%u)\n", event=
);
+		break;
+	}
+}
+
+/*
+ * The GHID ACPI method is used to indicate the "role" of the button.
+ * However, all the meanings of these values are vendor defined.
+ *
+ * We do however expose this value to user space.
+ */
+static int quickstart_get_ghid(struct quickstart_data *data)
+{
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle handle =3D ACPI_HANDLE(data->dev);
+	union acpi_object *obj;
+	acpi_status status;
+	int ret =3D 0;
+
+	/*
+	 * This returns a buffer telling the button usage ID,
+	 * and triggers pending notify events (The ones before booting).
+	 */
+	status =3D acpi_evaluate_object_typed(handle, "GHID", NULL, &buffer, ACP=
I_TYPE_BUFFER);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj =3D buffer.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	/*
+	 * Quoting the specification:
+	 * "The GHID method can return a BYTE, WORD, or DWORD.
+	 *  The value must be encoded in little-endian byte
+	 *  order (least significant byte first)."
+	 */
+	switch (obj->buffer.length) {
+	case 1:
+		data->id =3D obj->buffer.pointer[0];
+		break;
+	case 2:
+		data->id =3D get_unaligned_le16(obj->buffer.pointer);
+		break;
+	case 4:
+		data->id =3D get_unaligned_le32(obj->buffer.pointer);
+		break;
+	default:
+		dev_err(data->dev,
+			FW_BUG "GHID method returned buffer of unexpected length %u\n",
+			obj->buffer.length);
+		ret =3D -EIO;
+		break;
+	}
+
+	kfree(obj);
+
+	return ret;
+}
+
+static void quickstart_notify_remove(void *context)
+{
+	struct quickstart_data *data =3D context;
+	acpi_handle handle;
+
+	handle =3D ACPI_HANDLE(data->dev);
+
+	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify=
);
+}
+
+static int quickstart_probe(struct platform_device *pdev)
+{
+	struct quickstart_data *data;
+	acpi_handle handle;
+	acpi_status status;
+	int ret;
+
+	handle =3D ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, data);
+
+	/* We have to initialize the device wakeup before evaluating GHID becaus=
e
+	 * doing so will notify the device if the button was used to wake the ma=
chine
+	 * from S5.
+	 */
+	device_init_wakeup(&pdev->dev, true);
+
+	ret =3D quickstart_get_ghid(data);
+	if (ret < 0)
+		return ret;
+
+	data->input_device =3D devm_input_allocate_device(&pdev->dev);
+	if (!data->input_device)
+		return -ENOMEM;
+
+	ret =3D sparse_keymap_setup(data->input_device, quickstart_keymap, NULL)=
;
+	if (ret < 0)
+		return ret;
+
+	snprintf(data->input_name, sizeof(data->input_name), "Quickstart Button =
%u", data->id);
+	snprintf(data->phys, sizeof(data->phys), DRIVER_NAME "/input%u", data->i=
d);
+
+	data->input_device->name =3D data->input_name;
+	data->input_device->phys =3D data->phys;
+	data->input_device->id.bustype =3D BUS_HOST;
+
+	ret =3D input_register_device(data->input_device);
+	if (ret < 0)
+		return ret;
+
+	status =3D acpi_install_notify_handler(handle, ACPI_DEVICE_NOTIFY, quick=
start_notify, data);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return devm_add_action_or_reset(&pdev->dev, quickstart_notify_remove, da=
ta);
+}
+
+static const struct acpi_device_id quickstart_device_ids[] =3D {
+	{ "PNP0C32", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
+
+static struct platform_driver quickstart_platform_driver =3D {
+	.driver	=3D {
+		.name =3D DRIVER_NAME,
+		.dev_groups =3D quickstart_groups,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+		.acpi_match_table =3D quickstart_device_ids,
+	},
+	.probe =3D quickstart_probe,
+};
+module_platform_driver(quickstart_platform_driver);
+
+MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
+MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
+MODULE_AUTHOR("Angelo Arrifano");
+MODULE_DESCRIPTION("ACPI Direct App Launch driver");
+MODULE_LICENSE("GPL");
=2D-
2.39.2


