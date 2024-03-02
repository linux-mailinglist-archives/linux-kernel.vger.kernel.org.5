Return-Path: <linux-kernel+bounces-89580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268586F248
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A61D1F21FC0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79304436E;
	Sat,  2 Mar 2024 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYJERZB9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB741740
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410616; cv=none; b=iTw9U5gIfGZGMkhu4ppAQ6w+/0mj7dPAxE2/b/nDhW7J7LkLuyhB1EvOOq5N1gf1MWQRosKs32yYCEzDPZAGhQFi0p7bBfzxyImeS6ovunYLeiIowtfL/s27lzJH97KOdONoS0AUa44kTeUFalmbP5AD/q1JJJXvwLda61boHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410616; c=relaxed/simple;
	bh=0GrvhQMeDiqnvSKKSLm4FXuympZbNYitH8oNM1c1K2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uncqct6as38VlFqiaTmiH5UvV2O63MakYvpjG2qvuzyoYzBanJ1BGdpKCTXKavrg/BGZrHD3SU8RaHfdkmYiTKm/9pIveK2UajEIEvmcgez9e5rxTKBeXYWV9LfWzPYk50dyMk9bWrtTWZZGkjAuqFmlRs7+aXV1Y8lmLWVjY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYJERZB9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so5527255276.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410613; x=1710015413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBbBICcO6IvwKDEiRI+I7rx8MULu52MOhujWx/5/qGw=;
        b=uYJERZB9camoUaUqLYLPLa1tUH/NeYC5rMRbU3nBmmLwk4vnRWCQRaDGxN2SWsD6gB
         StiXOoqeVr/qZ8pwiQimg5IlJUOKHup0Ug+2fQvQFVLJSCE4DF+98DdYhrDhzLLoCeJ9
         aSeM756dtpN3H4arUSLgJvEX+ntorXyCtBwvnu3U26OdtYYmU+Ge1GEWTkuLXgga89Rb
         aFrnCztjxyUsUrlVKBRBlXKm2bcYIL/6RrotdopSuqjd9EAT/YYHFQ1y6Xa8dFDRG7+D
         n/9Xj3dHoqkZf5h1Iw7Kuyga3aIz6pJQ/waGUzU376wAn6EYH0k1ya1tkC0Dx3oJFWNE
         EcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410613; x=1710015413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBbBICcO6IvwKDEiRI+I7rx8MULu52MOhujWx/5/qGw=;
        b=RsFlV1bKQMd4ci7zNXhIOa0YtB4WkktYvdPzgR9FbIJj1cYNMOWzAEJtf0fPO+T620
         rWT8NTo+G44Wc65ucyEh8YUZmx+x1STPEsMHgcjzVaHD8uxzpVKvwdB7iUuta7hRbZ7H
         fDScxw5hIw6qv/8U8HDcK/n9l+Fqhcj4a322pxmhpxqLZFfzx2vo93tDLSLMK1GKoMt6
         m5xXxggIwskPkA3x6DMwWAFDn0+vzKclMToHIaSfVIrDXbZVWTaoqof/7oCf6bCz9SvA
         LuBR00Jryf63A1HRbipFZ/S4wC2dHfMbxvgLiON/01zTrai9y9M8nbsxV4fsDs36j/7g
         jj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSOIcKDkDCj0jdjQHOUgo9bt4lEPnsdC70Jg5ii+0YGABDaG+S3qjl1l/923SE8UKOkJt2FpWO5HFISMW4f3neKNLxn5PMKDP6b6t6
X-Gm-Message-State: AOJu0Yy6E8Gt4X3Qukzuew2XS3p6VsbyH/oJJMrdQinUuDjcRzOdfNx5
	iIVMyHarCWwawoXezovD2k+XiOLdLjdaqcCDZQJ513AyL0RolGHlMSzjYtFO5mGkjK8fWuPlZYA
	jExRpIha6/Q==
X-Google-Smtp-Source: AGHT+IEElMNXAZcLB6axPEJp76sxJvnK5Nzl6uufRXZTd0GtTRVv4w/r7SQ/DMKZfVZxIluVsVUK6Cq9Rh1ydA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1744:b0:dcf:6b50:9bd7 with SMTP
 id bz4-20020a056902174400b00dcf6b509bd7mr1307191ybb.7.1709410613026; Sat, 02
 Mar 2024 12:16:53 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:31 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-3-ipylypiv@google.com>
Subject: [PATCH v3 2/7] scsi: libsas: Define NCQ Priority sysfs attributes for
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

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/libsas/sas_ata.c | 92 +++++++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h        |  6 +++
 2 files changed, 98 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 12e2653846e3..e4d07134a0e4 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -964,3 +964,95 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
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
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev);
+	if (rc < 0)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", rc);
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
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev);
+	if (rc < 0)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", rc);
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
+	if (WARN_ON(!dev_is_sata(ddev)))
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


