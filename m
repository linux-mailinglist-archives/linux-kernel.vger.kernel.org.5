Return-Path: <linux-kernel+bounces-91472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226A871207
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891E1B23CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ECCDDC4;
	Tue,  5 Mar 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9KHuD5s"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B801944E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599873; cv=none; b=rEnIxhppRvpwpl7PkZ2M1by91/6ibCBEe6gkb8F05fgHX7moxRLNsW2RmZiahWk87a/yzFaUOazRuD7ExwcIMCx/I8UQoJHfPTMP9GMWFQcPJcSOyePoORfgWB3dbl3u4xCDpxK4mssEF2ZJ/6a8MY9Iup2bQP97dPINWzhnfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599873; c=relaxed/simple;
	bh=YTgx3WEe4nP8Np9FZNVT4X89BHfmUTsxsDDNkC5GZ1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NmXxQLg/Jmtb0tZ99soMC9UujBa08m/qq1l7nSd9HZJs6ThwPZtU6cx86JztZdV4hI8cDHvn+bcFlsK9ObdZJfDfrR1UUp8gWnHzPWITIusCXPMVj7QlMrzj3XJCYHQ/Ri4SW6j4civg6troVdqrt+d0xyWXYO1qr2vB61w/3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9KHuD5s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so6966499276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599871; x=1710204671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvi5ygT6WAyce3RYZ1KHwBcishPIpdItYF4EiC3R2c=;
        b=x9KHuD5sysZFEmVAIS3VKO8Sg/YFwZrLKm6i9lTjSXxJR7AaOTTwGuOK2J7DxPHCJh
         0pBCZ+SxoHjQBY0CtIMw069uMQZwEsyv9Y/76yoh6MiJkTs3TV6FLtAHZv8u3aUUFq/1
         5z9V6jPY86q+qbbCYGPcw2hsGQFTDFwYBb3wsgjLI0DtahEVWX6g1o8U3MUp87jKlpdN
         VfOXp42BvmqjflzzDYfyhnT11DIH7aVOLDCvMQZ+qHqRR13pIEYSp3DEVXgCXn05GjOJ
         f4EgYrdIeNcaqNeAx/002dVtm7L0y2TBDsK1SM7TBBKkIyB5q5/bFyZ7wqxBl1vCWzyh
         b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599871; x=1710204671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvi5ygT6WAyce3RYZ1KHwBcishPIpdItYF4EiC3R2c=;
        b=J0o+4yCiERdvE5sRmp1lg5sDGcldTvMEaapukxcsTkmIcoQ/9kX6KvQUXg2xwVuX4F
         TZjy7lWX3v67MCLIDoa5abf8P/4G4CdB1dsos42ziXVQCISS42zdZp4ZWOsZIR/LZ1zm
         UgJzaEZdsZ9/LXfTnDo0uUyFbk5C8MlZ1fiSGTsNA9DMMBGbps3ywPEFuXF9PDC5GJaf
         8BrKROlKCb5IcYUQF6wsAHKUFh2F/3KjFpnWVDq4ht0xDebmhHboTwbgUBsnAzZx9jZt
         zp1RHQTVQ4lOX+/kjnnt0YNBcRqVtaK45c+cR9HP2KxgjD5B++Un2pCNqJeV/lZ7d1bN
         6qsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsSHkjIITGcqOIB+LZ2K+GFbNPdd3No3kfUbuV3oRPdqX5SbIkShaDVzqdR7SalJuPxC8+lzz/srFWXjFE3biB4e0y0CH4t127QTZ5
X-Gm-Message-State: AOJu0YyeSjsRf91XUKEXPo4EJYbAAT4Hduhb16y23yXqPPpFzIqc0bd8
	53+nNdZ3GN/klIvSsPdFLcJvfvpEmGVKdkC6dNhjlwGri0XxRjUjrifqomIm8jzZ6k+XF+8yGdc
	SFmjsfe9W1A==
X-Google-Smtp-Source: AGHT+IFJjsZYiWXboDnHwWPLxZRDjqhfWxS4gVjqhuk3la2dYUeCqDR/H3YDuZseHOnChRDRlRD8ggqzL2MK6Q==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:154e:b0:dc7:3189:4e75 with SMTP
 id r14-20020a056902154e00b00dc731894e75mr362935ybu.3.1709599871454; Mon, 04
 Mar 2024 16:51:11 -0800 (PST)
Date: Mon,  4 Mar 2024 16:50:58 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-3-ipylypiv@google.com>
Subject: [PATCH v5 2/7] scsi: libsas: Define NCQ Priority sysfs attributes for
 SATA devices
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Libata sysfs attributes cannot be used for libsas managed SATA devices
because the ata_port location is different for libsas.

Defined sysfs attributes (visible for SATA devices only):
- /sys/block/sda/device/ncq_prio_enable
- /sys/block/sda/device/ncq_prio_supported

The newly defined attributes will pass the correct ata_port to libata
helper functions.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h        |  6 +++
 2 files changed, 100 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 12e2653846e3..04b0bd9a4e01 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
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
+	bool supported;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", supported);
+}
+
+DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
+
+static ssize_t sas_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	bool enabled;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", enabled);
+}
+
+static ssize_t sas_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	bool enable;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
+	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
+
+static struct attribute *sas_ata_sdev_attrs[] = {
+	&dev_attr_ncq_prio_supported.attr,
+	&dev_attr_ncq_prio_enable.attr,
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


