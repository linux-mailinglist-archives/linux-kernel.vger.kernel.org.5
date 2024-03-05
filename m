Return-Path: <linux-kernel+bounces-91447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F5F87119E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50F01C21A62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095E10F4;
	Tue,  5 Mar 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b="wVPo0b2m";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CFylA4Mu"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FCEC2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598241; cv=none; b=bOMEJBSImIlNIit7aqymiuV+aARCkrHS7l9B+tPdZRRkpAkpLJM4+QC4KK2vzMB3t99O2BwrniXn7my4BCE0OYWRKOeSQqCsWAK78laoaHYXbfd1LBY7Eb+VTgH0hGNC862KQMmhcL9Dcs5kowVignuGL0qHGkLVuPi4vzEWqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598241; c=relaxed/simple;
	bh=2HIV57sf1HLLLdhagTk1qNW0ej68RudT31B3zhms368=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tp20I65jSJs96M17kxT3VQERLdIVDAKVP2KZZhP98fN6D6v4fJR0DNFjvH57vIF1RiYjShot4xxQqU2YbwkPOWLmvbGgJiFhvY/wdFChLqjqUh525+o3EiAjAT+6otW5NaT2apxlvDcCvIYf3p/bhFOKbpQUP8a/5weJGk9q3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com; spf=pass smtp.mailfrom=elbertmai.com; dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b=wVPo0b2m; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CFylA4Mu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elbertmai.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=wVPo0b2mctEKgxoIAmhmDG6e4uZorR6Ab9hRKSUuOjRb1n53V3RM1tlm4s0jYs8uGbN2Dqe6Fkz6RfaMjVlgn4PlIMWcadWWQgrB6HXg4UHRtviHSseNCHiT+oGfXDBtGQqs4q96oT9x6KX5HAoPdHopXJFNahzSDbVaxMCWH5ts0GWMTsQL4ylQrPjmeey/zSiyt75L8x2Fo/stpxpe8v7SpXcgaNcTBDsmldc3P5DI2ngbwtewSYu4/8BZ3pohbcBqgX56O/69l2BKAYswlV59pfxzHUdqarpcfrGYoGa7KWOvqxOHoRjxgd7loUorx6HAjOFa6UgpYgVOZ9AotQ==; s=purelymail2; d=elbertmai.com; v=1; bh=2HIV57sf1HLLLdhagTk1qNW0ej68RudT31B3zhms368=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=CFylA4MuSkFWNhsb7zv9C4JGGU5pxkssVVwow2GTbI44zktm/4oRdAI66p1Tuq7k7ig9HOvFFkcapH5ZAJyBuiNMm2ZYGAwj8TzWPe/KbhF4RmEIRQL9/1sediIz0jzLfRre4Z7+JCv3mZsoroCQ9jZHMEHqLswd2KkCPUollUypw3BLcYsJCMvIg2jo5SuPd+1t56dlyOKwaYP5hBnwif9FKwZIJiCtUFGdwUX3yAvOs0DyGTYydW1YTcS/TwQlFp/BIX6yTJPiehtN0/6SBFoZlJhZpdl0ZRCpge05PRSmAgOSmNhSyYuY9/VLMCTmirCJtBPLVoi5MucwyzVfPA==; s=purelymail2; d=purelymail.com; v=1; bh=2HIV57sf1HLLLdhagTk1qNW0ej68RudT31B3zhms368=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 5995:1482:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1986472728;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 05 Mar 2024 00:23:47 +0000 (UTC)
From: Elbert Mai <code@elbertmai.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Elbert Mai <code@elbertmai.com>
Subject: [PATCH v2] usb: Export BOS descriptor to sysfs
Date: Mon,  4 Mar 2024 16:23:01 -0800
Message-Id: <20240305002301.95323-1-code@elbertmai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Motivation
----------

The binary device object store (BOS) of a USB device consists of the BOS
descriptor followed by a set of device capability descriptors. One that is
of interest to users is the platform descriptor. This contains a 128-bit
UUID and arbitrary data, and it allows parties outside of USB-IF to add
additional metadata about a USB device in a standards-compliant manner.
Notable examples include the WebUSB and Microsoft OS 2.0 descriptors.

The kernel already retrieves and caches the BOS from USB devices if its
bcdUSB is >=3D 0x0201. Because the BOS is flexible and extensible, we expor=
t
the entire BOS to sysfs so users can retrieve whatever device capabilities
they desire, without requiring USB I/O or elevated permissions.

Implementation
--------------

Add bos_descriptors attribute to sysfs. This is a binary file and it works
the same way as the existing descriptors attribute. The file exists only if
the BOS is present in the USB device.

Also create a binary attribute group, so the driver core can handle the
creation of both the descriptors and bos_descriptors attributes in sysfs.

Signed-off-by: Elbert Mai <code@elbertmai.com>
---
Changes in v2:
 - Rename to bos_descriptors (plural) since the attribute contains the
   entire BOS, not just the first descriptor in it.
 - Use binary attribute groups to let driver core handle attribute
   creation for both descriptors and bos_descriptors.
 - The attribute is visible in sysfs only if the BOS is present in the
   USB device.

 Documentation/ABI/testing/sysfs-bus-usb | 10 ++++
 drivers/usb/core/sysfs.c                | 78 +++++++++++++++++++------
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/te=
sting/sysfs-bus-usb
index 614d216dff1d..102ee4215e48 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -293,3 +293,13 @@ Description:
 =09=09USB 3.2 adds Dual-lane support, 2 rx and 2 tx -lanes over Type-C.
 =09=09Inter-Chip SSIC devices support asymmetric lanes up to 4 lanes per
 =09=09direction. Devices before USB 3.2 are single lane (tx_lanes =3D 1)
+
+What:=09=09/sys/bus/usb/devices/.../bos_descriptors
+Date:=09=09March 2024
+Contact:=09Elbert Mai <code@elbertmai.com>
+Description:
+=09=09Binary file containing the cached binary device object store (BOS)
+=09=09of the device. This consists of the BOS descriptor followed by the
+=09=09set of device capability descriptors. All descriptors read from
+=09=09this file are in bus-endian format. Note that the kernel will not
+=09=09request the BOS from a device if its bcdUSB is less than 0x0201.
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index a2ca38e25e0c..a50b6f496eb6 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -870,16 +870,10 @@ static struct attribute_group dev_string_attr_grp =3D=
 {
 =09.is_visible =3D=09dev_string_attrs_are_visible,
 };
=20
-const struct attribute_group *usb_device_groups[] =3D {
-=09&dev_attr_grp,
-=09&dev_string_attr_grp,
-=09NULL
-};
-
 /* Binary descriptors */
=20
 static ssize_t
-read_descriptors(struct file *filp, struct kobject *kobj,
+descriptors_read(struct file *filp, struct kobject *kobj,
 =09=09struct bin_attribute *attr,
 =09=09char *buf, loff_t off, size_t count)
 {
@@ -901,7 +895,7 @@ read_descriptors(struct file *filp, struct kobject *kob=
j,
 =09=09=09srclen =3D sizeof(struct usb_device_descriptor);
 =09=09} else {
 =09=09=09src =3D udev->rawdescriptors[cfgno];
-=09=09=09srclen =3D __le16_to_cpu(udev->config[cfgno].desc.
+=09=09=09srclen =3D le16_to_cpu(udev->config[cfgno].desc.
 =09=09=09=09=09wTotalLength);
 =09=09}
 =09=09if (off < srclen) {
@@ -916,11 +910,66 @@ read_descriptors(struct file *filp, struct kobject *k=
obj,
 =09}
 =09return count - nleft;
 }
+static BIN_ATTR_RO(descriptors, 18 + 65535); /* dev descr + max-size raw d=
escriptor */
+
+static ssize_t
+bos_descriptors_read(struct file *filp, struct kobject *kobj,
+=09=09struct bin_attribute *attr,
+=09=09char *buf, loff_t off, size_t count)
+{
+=09struct device *dev =3D kobj_to_dev(kobj);
+=09struct usb_device *udev =3D to_usb_device(dev);
+=09struct usb_host_bos *bos =3D udev->bos;
+=09struct usb_bos_descriptor *desc;
+=09size_t desclen, n =3D 0;
+
+=09if (bos) {
+=09=09desc =3D bos->desc;
+=09=09desclen =3D le16_to_cpu(desc->wTotalLength);
+=09=09if (off < desclen) {
+=09=09=09n =3D min(count, desclen - (size_t) off);
+=09=09=09memcpy(buf, (void *) desc + off, n);
+=09=09}
+=09}
+=09return n;
+}
+static BIN_ATTR_RO(bos_descriptors, 65535); /* max-size BOS */
=20
-static struct bin_attribute dev_bin_attr_descriptors =3D {
-=09.attr =3D {.name =3D "descriptors", .mode =3D 0444},
-=09.read =3D read_descriptors,
-=09.size =3D 18 + 65535,=09/* dev descr + max-size raw descriptor */
+/* When modifying this list, be sure to modify dev_bin_attrs_are_visible()
+ * accordingly.
+ */
+static struct bin_attribute *dev_bin_attrs[] =3D {
+=09&bin_attr_descriptors,
+=09&bin_attr_bos_descriptors,
+=09NULL
+};
+
+static umode_t dev_bin_attrs_are_visible(struct kobject *kobj,
+=09=09struct bin_attribute *a, int n)
+{
+=09struct device *dev =3D kobj_to_dev(kobj);
+=09struct usb_device *udev =3D to_usb_device(dev);
+
+=09/* All USB devices have a device descriptor, so the descriptors
+=09 * attribute always exists. No need to check for its visibility.
+=09 */
+=09if (a =3D=3D &bin_attr_bos_descriptors) {
+=09=09if (udev->bos =3D=3D NULL)
+=09=09=09return 0;
+=09}
+=09return a->attr.mode;
+}
+
+static const struct attribute_group dev_bin_attr_grp =3D {
+=09.bin_attrs =3D=09=09dev_bin_attrs,
+=09.is_bin_visible =3D=09dev_bin_attrs_are_visible,
+};
+
+const struct attribute_group *usb_device_groups[] =3D {
+=09&dev_attr_grp,
+=09&dev_string_attr_grp,
+=09&dev_bin_attr_grp,
+=09NULL
 };
=20
 /*
@@ -1038,10 +1087,6 @@ int usb_create_sysfs_dev_files(struct usb_device *ud=
ev)
 =09struct device *dev =3D &udev->dev;
 =09int retval;
=20
-=09retval =3D device_create_bin_file(dev, &dev_bin_attr_descriptors);
-=09if (retval)
-=09=09goto error;
-
 =09retval =3D add_persist_attributes(dev);
 =09if (retval)
 =09=09goto error;
@@ -1071,7 +1116,6 @@ void usb_remove_sysfs_dev_files(struct usb_device *ud=
ev)
=20
 =09remove_power_attributes(dev);
 =09remove_persist_attributes(dev);
-=09device_remove_bin_file(dev, &dev_bin_attr_descriptors);
 }
=20
 /* Interface Association Descriptor fields */
--=20
2.34.1


