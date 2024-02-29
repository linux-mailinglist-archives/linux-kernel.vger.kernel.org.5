Return-Path: <linux-kernel+bounces-87713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D186D814
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E31F22D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684D13C9EE;
	Thu, 29 Feb 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b="U3sIgO3l";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bn/qr6Eb"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648344374
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251192; cv=none; b=JvAtlPOTXHQAPTGXRtkfv3eCk6gR4Jn+HJG1/9G1sV/Y2mdJzH/nz20m7hgpOT8hfWVkBY+thBOJEfgMcn5Bihf94BhtqSbG0mSpRsFoU7qcevFst/i21I8F9gljxFcHn8bKcVobvk5VqJS1o+oZyZ4Mlu28OyLHV17UyOcDkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251192; c=relaxed/simple;
	bh=OOOCsGxQH/wxU/CG8sZCXZFdEfx3IZ9cD1UMgPqoejI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tAAaQg8HeDgODtPOdfp5MczQfPV/RQaw23Knajne7Zag6k9AKiTMHvFnjyix4REbbEsOuKBrTRUdSVFh+U33KimOerWVchiQL7+ab9KaeHXeqeFbstssIIVKU5S9xnRm9uR+rrTj4cAgqSJzLw4ucUv0EwoqJbKb474ZIPguaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com; spf=pass smtp.mailfrom=elbertmai.com; dkim=pass (2048-bit key) header.d=elbertmai.com header.i=@elbertmai.com header.b=U3sIgO3l; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bn/qr6Eb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elbertmai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elbertmai.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=U3sIgO3lqTzN/z5hQyfzPw4s9+yl5E1EGxOdfTty0MSKjQ6d2FjCTouDqFDDUUqCWMQ+PPy2rhcDKy5qh9UYD6Vyaexsi/qN0O7Y35bNgfwziQRG7N/O5l1v9/86CqRr7TuqbaZzDwKxK00iGx8A+6oOCGBHD38x+swMLVUorvZPMDjYczSm+rKgiiS4h4TpqXo49czACtt0LflITl6DbSVMsr8KoY1N+iWQ9Us3Isjrz4hcewT4JK0mmDffSxiSsiLLxCDWEPKgYBVsjzmWW7IqVdCFdAzm01uY22rY3v4TATqs0YngMTxgYfmNgM34ryX+gQbKEx8Y0jPuosercw==; s=purelymail1; d=elbertmai.com; v=1; bh=OOOCsGxQH/wxU/CG8sZCXZFdEfx3IZ9cD1UMgPqoejI=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=bn/qr6Ebpw63GwRPkSkgkHh2wf3tAJtJY7NPyPSTPM/OqoLUHRV1xuiuHvJOKgD/MjNX+dnMYO+vnNb3nvcZycNjSW0dODcVl/3yQdphUcpwhyB14hS7Omxul4L/IxlnXkbilCpFF6JxTyk8uArA2kxxYn29qR82d+a/EhJmx3aOnRq5c+cCHQ45L0BG9BNCZJxbtTAeBd9tKqsN4c5QKyprAkWPYiWcEhTm84pk7FvcPGDg/jPvFsMq6VK8LZN8R7AzjYe/b8n4pgiPhJR6bEiKMzPoUbNByMhOeq4Dt3Njb/TlNqhHuiGJ7KY90ocFvPEWzUPBOFv1NEhiLYZzhQ==; s=purelymail1; d=purelymail.com; v=1; bh=OOOCsGxQH/wxU/CG8sZCXZFdEfx3IZ9cD1UMgPqoejI=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 5995:1482:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -265359410;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 29 Feb 2024 23:59:22 +0000 (UTC)
From: Elbert Mai <code@elbertmai.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Elbert Mai <code@elbertmai.com>
Subject: [PATCH] usb: Export BOS descriptor to sysfs
Date: Thu, 29 Feb 2024 15:59:05 -0800
Message-Id: <20240229235905.569705-1-code@elbertmai.com>
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

The kernel already retrieves and caches the binary device object store
(BOS) descriptor from USB devices it enumerates. Export this descriptor to
userspace via sysfs, so users do not need to open the USB device with the
correct permissions and requesting the descriptor themselves.

A BOS descriptor contains a set of device capability descriptors. One that
is of interest to users is the platform descriptor. This contains a 128-bit
UUID and arbitrary data. The descriptor allows parties outside of USB-IF to
add additional metadata about a device in a standards-compliant manner.

Notable examples include the WebUSB and Microsoft OS 2.0 descriptors. Of
course, there could be more. By exporting the entire BOS descriptor we can
handle these and all future device capabilities. In addition, tools like
udev can match rules on device capabilities in the BOS without requiring
additional I/O with the USB device.

Implementation
--------------

Add bos_descriptor file to sysfs. This is a binary file and it works the
same way as the existing descriptors file. The file exists even if a device
does not have a BOS descriptor (the file will be empty in this case). This
allows users to detect if the kernel supports reading the BOS via sysfs and
fall back to direct USB I/O if needed.

Signed-off-by: Elbert Mai <code@elbertmai.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
 drivers/usb/core/sysfs.c                | 35 ++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/te=
sting/sysfs-bus-usb
index 614d216dff1d..bfffaa752a13 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -293,3 +293,12 @@ Description:
 =09=09USB 3.2 adds Dual-lane support, 2 rx and 2 tx -lanes over Type-C.
 =09=09Inter-Chip SSIC devices support asymmetric lanes up to 4 lanes per
 =09=09direction. Devices before USB 3.2 are single lane (tx_lanes =3D 1)
+
+What:=09=09/sys/bus/usb/devices/.../bos_descriptor
+Date:=09=09March 2024
+Contact:=09Elbert Mai <code@elbertmai.com>
+Description:
+=09=09Binary file containing the cached binary device object store (BOS)
+=09=09descriptor of the device. This file is empty if the BOS descriptor
+=09=09is not present. The kernel will not request a BOS descriptor from
+=09=09the device if its bcdUSB value is less than 0x0201.
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index a2ca38e25e0c..208d2f8cde2d 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -901,7 +901,7 @@ read_descriptors(struct file *filp, struct kobject *kob=
j,
 =09=09=09srclen =3D sizeof(struct usb_device_descriptor);
 =09=09} else {
 =09=09=09src =3D udev->rawdescriptors[cfgno];
-=09=09=09srclen =3D __le16_to_cpu(udev->config[cfgno].desc.
+=09=09=09srclen =3D le16_to_cpu(udev->config[cfgno].desc.
 =09=09=09=09=09wTotalLength);
 =09=09}
 =09=09if (off < srclen) {
@@ -923,6 +923,34 @@ static struct bin_attribute dev_bin_attr_descriptors =
=3D {
 =09.size =3D 18 + 65535,=09/* dev descr + max-size raw descriptor */
 };
=20
+static ssize_t
+read_bos_descriptor(struct file *filp, struct kobject *kobj,
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
+
+static struct bin_attribute dev_bin_attr_bos_descriptor =3D {
+=09.attr =3D {.name =3D "bos_descriptor", .mode =3D 0444},
+=09.read =3D read_bos_descriptor,
+=09.size =3D 65535,=09/* max-size BOS descriptor */
+};
+
 /*
  * Show & store the current value of authorized_default
  */
@@ -1042,6 +1070,10 @@ int usb_create_sysfs_dev_files(struct usb_device *ud=
ev)
 =09if (retval)
 =09=09goto error;
=20
+=09retval =3D device_create_bin_file(dev, &dev_bin_attr_bos_descriptor);
+=09if (retval)
+=09=09goto error;
+
 =09retval =3D add_persist_attributes(dev);
 =09if (retval)
 =09=09goto error;
@@ -1071,6 +1103,7 @@ void usb_remove_sysfs_dev_files(struct usb_device *ud=
ev)
=20
 =09remove_power_attributes(dev);
 =09remove_persist_attributes(dev);
+=09device_remove_bin_file(dev, &dev_bin_attr_bos_descriptor);
 =09device_remove_bin_file(dev, &dev_bin_attr_descriptors);
 }
=20
--=20
2.34.1


