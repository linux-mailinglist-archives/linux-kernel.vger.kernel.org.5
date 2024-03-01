Return-Path: <linux-kernel+bounces-87783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A585A86D8F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252A21F211CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FA374D9;
	Fri,  1 Mar 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJOk0s1m"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114C2C68F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257109; cv=none; b=mYpM4WHKyci4lHfevl4DcBw55ZTVsf369UJpo6aVgoV08jLRlYFdkNMC3WAHzf4dsl33VbvOui+w49Ku8JLhsOOiUaFBOco4LzezAxev3nS7PdZEn0T0Tc1iKfYDFdanAUasG2Bm1yVO+ouz5BfSKGcjCiHqRsUxstxcSHr6Yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257109; c=relaxed/simple;
	bh=mtBbiWcmZwxQCRaOzE/9koGDdChW/PDs00KLcj5CSkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+BA/ESvd3Ysuklo/N7rUlxfvabuBtsxgvBZbf1LdGZF/NRUrMR1VDEFihpqu1M+ef/lareMem9FEbFqmtYcTCazH1CeCXTZYRveeZcQ1rvOlsYhNSorlL069BDCAp4XOCHKbX8onaaXsYdszJCHViMfLO7NHEqlvcp4uL7BGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJOk0s1m; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6097cdb2d5aso12090817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709257106; x=1709861906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDkT/7hqQtX4FOcw/2DmNvRmQOdZa31qDgMRBQViLvw=;
        b=LJOk0s1mxgkfrZTG6s2qp/xYwHJrpo4prNDT/u+1Kg0gSjB7kVIBYMqt2D638l/Gvi
         K9kxeRTfUyoaH29T1d6/5VVMWGFAr2gcuGUgWwSPgF4BiboQJwU8H/1lI0a+oBIpm78t
         JLGAzj7o52UAuaVID3MFIcQyc7N9wGjeHlwC+uxtedyVmNjvrzvR7rmqSZj1YaOXCdV9
         Phdvq54FfV18IWXZVAUMUU1eWeZYDKMPxEit7ZpRtK0TUfdLQM0YQYdR+lImgfbLXz52
         3IDT5wTGpEqGyPI170doBpXtUFl51W15SdMnGMqwgpuDxjwhi37195+iQ1aU7ukx4sqz
         LYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257106; x=1709861906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDkT/7hqQtX4FOcw/2DmNvRmQOdZa31qDgMRBQViLvw=;
        b=EtkPpGjtzwVDkoh0br0ZO3QC37d50RKoLXK1cj9r3TgNeVeoBGVcp4VAurDA1Ad0m2
         EaIAh94JjlJBoorA4NXoHiH31MEdD5gQ7phD8jezOFWAq5+0l+h6vEGwJIbyUZHKxGTx
         GGjToR5pDgmXuPToRv7UwXuxCKw8lK+tiMleNZ/vgfrw+6pgewS6uhu1qwk958QrMmL5
         CSjD7z/iK7Cd0IyfAjDVFQyxfS9NPmp7DBjBYkqsbj+azm1SEcHcCcO5EjkGdopw84QJ
         4TwCrP5cvJKpvXIxI32qnUZrHmUMY4pZkZsJbNf00lqZfpfzN38TWq8OU/pb9hBccLlo
         pgSw==
X-Forwarded-Encrypted: i=1; AJvYcCVgqeDBujWAS1P3dtBtY1yOZxfUTulYO4rbbqzRd9TmuHg3qKyk+oUw/4ewFHCTCCvUc00Id5ZeEGKtfb/7vfBzm9xFaeFqaIqZqm+q
X-Gm-Message-State: AOJu0YxL0zxuSkUIk5s+8QikdJFZFjTKTmOBhBPzoVLjS6w9NYcDF0x9
	CGXETVQoXrjShE+2mqL+Y0M9zfPP4SHOg6JouqMFH6CkIbeK2at1+2nKryotbkBaeDtQBHahfYh
	EbDeAxIz2zw==
X-Google-Smtp-Source: AGHT+IFEW5MICD1/UrHacRaBJO3UKnMsj3Gm5OFwprSbIwJL/b+4i1JOhUDskT+1vG6zKS1ucgIMJho3+h7WYg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:3564:51b2:6cdf:92fb])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:338c:b0:608:e70d:8215 with SMTP
 id fl12-20020a05690c338c00b00608e70d8215mr61639ywb.5.1709257105531; Thu, 29
 Feb 2024 17:38:25 -0800 (PST)
Date: Thu, 29 Feb 2024 17:37:57 -0800
In-Reply-To: <20240301013759.516817-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301013759.516817-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301013759.516817-2-ipylypiv@google.com>
Subject: [PATCH 1/3] ata: libata-sata: Factor out NCQ Priority configuration helpers
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

Export libata NCQ Priority configuration helpers to be reused
for libsas managed SATA devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: TJ Adams <tadamsjr@google.com>
---
 drivers/ata/libata-sata.c | 130 +++++++++++++++++++++++++-------------
 include/linux/libata.h    |   4 ++
 2 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..9c6c69d7feab 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -848,80 +848,104 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
 	    ata_scsi_lpm_show, ata_scsi_lpm_store);
 EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
 
+/**
+ *	ata_ncq_prio_supported - Check if device supports NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *
+ *	Helper to check if device supports NCQ Priority feature,
+ *	usable with both libsas and libata.
+ */
+int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(ap->lock, flags);
+	dev = ata_scsi_find_dev(ap, sdev);
+	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO) : -ENODEV;
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
+
 static ssize_t ata_ncq_prio_supported_show(struct device *device,
 					   struct device_attribute *attr,
 					   char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(device);
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev;
-	bool ncq_prio_supported;
-	int rc = 0;
-
-	spin_lock_irq(ap->lock);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev)
-		rc = -ENODEV;
-	else
-		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
-	spin_unlock_irq(ap->lock);
+	int rc = ata_ncq_prio_supported(ap, sdev);
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
+	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);
 }
-
 DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
 EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
 
+/**
+ *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *
+ *	Helper to check if NCQ Priority feature is enabled,
+ *	usable with both libsas and libata.
+ */
+int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(ap->lock, flags);
+	dev = ata_scsi_find_dev(ap, sdev);
+	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) : -ENODEV;
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
+
 static ssize_t ata_ncq_prio_enable_show(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(device);
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev;
-	bool ncq_prio_enable;
-	int rc = 0;
-
-	spin_lock_irq(ap->lock);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev)
-		rc = -ENODEV;
-	else
-		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
-	spin_unlock_irq(ap->lock);
+	int rc = ata_ncq_prio_enabled(ap, sdev);
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
+	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);
 }
 
-static ssize_t ata_ncq_prio_enable_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
+/**
+ *	ata_ncq_prio_enable - Enable/disable NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
+ *
+ *	Helper to enable/disable NCQ Priority feature, usable with both
+ *	libsas and libata.
+ */
+int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			bool enable)
 {
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap;
 	struct ata_device *dev;
-	long int input;
+	unsigned long flags;
 	int rc = 0;
 
-	rc = kstrtol(buf, 10, &input);
-	if (rc)
-		return rc;
-	if ((input < 0) || (input > 1))
-		return -EINVAL;
+	spin_lock_irqsave(ap->lock, flags);
 
-	ap = ata_shost_to_port(sdev->host);
 	dev = ata_scsi_find_dev(ap, sdev);
-	if (unlikely(!dev))
-		return  -ENODEV;
-
-	spin_lock_irq(ap->lock);
+	if (unlikely(!dev)) {
+		rc = -ENODEV;
+		goto unlock;
+	}
 
 	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
 		rc = -EINVAL;
 		goto unlock;
 	}
 
-	if (input) {
+	if (enable) {
 		if (dev->flags & ATA_DFLAG_CDL_ENABLED) {
 			ata_dev_err(dev,
 				"CDL must be disabled to enable NCQ priority\n");
@@ -934,9 +958,27 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
 	}
 
 unlock:
-	spin_unlock_irq(ap->lock);
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enable);
+
+static ssize_t ata_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	long input;
+	int rc = 0;
+
+	rc = kstrtol(buf, 10, &input);
+	if (rc)
+		return rc;
+	if ((input < 0) || (input > 1))
+		return -EINVAL;
 
-	return rc ? rc : len;
+	return ata_ncq_prio_enable(ap, sdev, input) ? : len;
 }
 
 DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..f3ff2bf3ec6b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1157,6 +1157,10 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 				  int queue_depth);
+extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev);
+extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev);
+extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			       bool enable);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
-- 
2.44.0.278.ge034bb2e1d-goog


