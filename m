Return-Path: <linux-kernel+bounces-87784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB086D8FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B89A284E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEE33994;
	Fri,  1 Mar 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgrZpb5A"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8337718
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257114; cv=none; b=FlTJgRsqXaeCi8kpDuVyk2O2liTGG2x94kVlAwCAjtVhv2SNkR+uDBgtcUom5XdGUPyHpd/ixUia6nSgdR0vRE5I9Ju1/3qJEjLS3h0CBtMl6AqBpaNn7v7LpDpNbu8SbU9bTxeGw6QkoM4aQB+2h4mX9GA7IYqoQ73ARl1xkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257114; c=relaxed/simple;
	bh=b5qJ6alfFk5gLcVcBzAlcYXOHCF2Ivt3yvp+GD4igj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRxj7GnbpvG/sB+20MkQUbQhewz4Z3o1E+8d9SrMyry5V0hH11W6WVWhrtTQih+9x1yPh3Hdigk9s3Df+G87mjoGhaXW3a4uQERWZqTVBpJhB6gQxJ5A2sQNclgEa0ks/MrOOngtH2ZV5IIVPzvAOMoN/7lIBiRFhM+GeLPfWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgrZpb5A; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60983922176so1878127b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709257111; x=1709861911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq3k5LtaA6RfQgw3thOdumiq5cQzFEQyUv+IanRfVV0=;
        b=rgrZpb5AKE7o4O3XwlB+TJYUIAkdjOUQHpVSQj7QoeRkMtYDI5714Jq8Q24rMmBg29
         6fevqyq6RpHJhYQ6lVF8dtBNi96dua7U47SYlEOY2Eh/uw8FQx+zlMmGixKe6Vd6XJmW
         rjeZw7AW/syM8djPQ3TitMGl4H+TZ3HVVuMLKejrBGvQ0Ts8FPwqlf0svvPQaMhZtyx8
         A08pyHF8LRUdd8evphy/zs8Liwb39ynbXxpzj60iVmrecq1Xd8XXXE2NjwuWI9LApGlw
         v0oXR9qD7Kd6Kwv4L4aTR2BCvOkQOH50TvJmTNGiNzOF5ShlTHw9Xpu34VFOGkjvTaTm
         qPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257111; x=1709861911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq3k5LtaA6RfQgw3thOdumiq5cQzFEQyUv+IanRfVV0=;
        b=XjZ+IsYvhiX4BFz1fp+VrUQ37OYyzXXhsCLfXg6ZpbCUifpbRf89dpn/I+Od7WGADD
         qnWEToJemVicZTFlELZTJ/KOQjgdBO1T+sW0xpuQtsfvybgJ9Q1z70LXKZpZ+XyIbs4F
         TDUlhLgiPb+tylW3w9fsbyEW9YMKQNYgCPQUwg7vnA0eNzGDNkumTkiAKAWoQpLXNTB3
         h0Oq3cWgNTFqh7eysYrEzKFm+LTErPLCDZFssd5x39eYIodHQqzixetQBRmrcNa/JhDb
         cxmG9QG50tHL00+5okMSJ2jlkE6ezikJpjW/sXkhJ31fK8UCxk+ItfEmWmoSWTN69Ap0
         0UTg==
X-Forwarded-Encrypted: i=1; AJvYcCUBbqCbLGg3RugZeb5F07hWQNONyrgIwBwmfS3jYj6JrML9hTAo6+3xc6HqBF6GpATC4gBy4VdCacj6TXFg3Eqf3DLDPHUpRagEER3d
X-Gm-Message-State: AOJu0Yx5yDEjgV9B1+e3Ibzyv4r5hbue9aMTrYlckBkIsRHARzWITyqs
	LqlFuTZ/7HDscp/gZWfHPvCwr0GMGwZFHnBt5eW9zP15Sx7Q98s259t8VNLZQ+v5andwo9zxePg
	hLyp8UqvCEA==
X-Google-Smtp-Source: AGHT+IFekquhzOvV35dLZc9bj3yYN4OH+EDKblzlUZ7HCoTrEmq4spS48DAE3Xq2zCqt+PVtRjNkB8vGqBVGww==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:3564:51b2:6cdf:92fb])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1101:b0:dc6:fec4:1c26 with SMTP
 id o1-20020a056902110100b00dc6fec41c26mr42186ybu.1.1709257111635; Thu, 29 Feb
 2024 17:38:31 -0800 (PST)
Date: Thu, 29 Feb 2024 17:37:58 -0800
In-Reply-To: <20240301013759.516817-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301013759.516817-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301013759.516817-3-ipylypiv@google.com>
Subject: [PATCH 2/3] scsi: libsas: Define NCQ Priority sysfs attributes for
 SATA devices
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

Libata sysfs attributes cannot be used for libsas managed SATA devices
because the ata_port location is different for libsas.

Defined sysfs attributes (visible for SATA devices only):
- /sys/block/*/device/sas_ncq_prio_enable
- /sys/block/*/device/sas_ncq_prio_supported

The newly defined attributes will pass the correct ata_port to libata
helper functions.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: TJ Adams <tadamsjr@google.com>
---
 drivers/scsi/libsas/sas_ata.c | 87 +++++++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h        |  6 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 12e2653846e3..e0b19eee09b5 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -964,3 +964,90 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
 			       force_phy_id, &tmf_task);
 }
 EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
+
+static ssize_t sas_ncq_prio_supported_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	int res;
+
+	// This attribute shall be visible for SATA devices only
+	if (WARN_ON(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	res = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev);
+	if (res < 0)
+		return res;
+
+	return sysfs_emit(buf, "%u\n", res);
+}
+static DEVICE_ATTR_RO(sas_ncq_prio_supported);
+
+static ssize_t sas_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	int res;
+
+	// This attribute shall be visible for SATA devices only
+	if (WARN_ON(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	res = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev);
+	if (res < 0)
+		return res;
+
+	return sysfs_emit(buf, "%u\n", res);
+}
+
+static ssize_t sas_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	long input;
+	int res;
+
+	// This attribute shall be visible for SATA devices only
+	if (WARN_ON(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	res = kstrtol(buf, 10, &input);
+	if (res)
+		return res;
+	if ((input < 0) || (input > 1))
+		return -EINVAL;
+
+	return ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, input) ? : len;
+}
+static DEVICE_ATTR_RW(sas_ncq_prio_enable);
+
+static struct attribute *sas_ata_sdev_attrs[] = {
+	&dev_attr_sas_ncq_prio_supported.attr,
+	&dev_attr_sas_ncq_prio_enable.attr,
+	NULL
+};
+
+static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+
+	if (!dev_is_sata(ddev))
+		return 0;
+
+	return attr->mode;
+}
+
+const struct attribute_group sas_ata_sdev_attr_group = {
+	.attrs = sas_ata_sdev_attrs,
+	.is_visible = sas_ata_attr_is_visible,
+};
+EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 2f8c719840a6..cded782fdf33 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
 int sas_discover_sata(struct domain_device *dev);
 int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
 		    struct domain_device *child, int phy_id);
+
+extern const struct attribute_group sas_ata_sdev_attr_group;
 #else
 
 static inline void sas_ata_disabled_notice(void)
@@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
 	sas_ata_disabled_notice();
 	return -ENODEV;
 }
+
+static const struct attribute_group sas_ata_sdev_attr_group = {
+	.attrs = NULL,
+};
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.44.0.278.ge034bb2e1d-goog


