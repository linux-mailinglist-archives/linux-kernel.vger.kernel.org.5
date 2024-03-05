Return-Path: <linux-kernel+bounces-91471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B838F871203
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE791C22472
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973B9473;
	Tue,  5 Mar 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Y0hEL0c"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78063C8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599872; cv=none; b=nufdFpXzSIpUOn96/mDkMnzOIU13jdG+aEP7GWq0t1O40DjlEdrbXfupTBmyR269tzzXo/xbEIx+DBE4itufXEzAz3gw7i2CztNQal/V1vc432tePBP29SXRj0sAEM0fA2NCrqwPdY5xCFiOm2t7I/wKcvQ+c0Z0Gg6aaqI1TjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599872; c=relaxed/simple;
	bh=4Wx/6B3zZCXye3rApBiOXYExLJx00xF0c05Ex3qDfC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sH6HLu+zIjXl9HoXtnCUh/mHuHvQTTIZUn1ozJLHS6SAYvmUTqIRqcu3W8+dEvFEq6QxsNyEp7FkvOwXPt58lYvWCPBGReTolQvNRDCGIqKYKPrwLDZSYSTsbui/0tvSJqgiRdMSjFPmisR5dHI+s46ZXesmnR0roMgGxjQqDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Y0hEL0c; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092bf785d7so95328417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599869; x=1710204669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq5KdOW2n6/uRJ2XLw3ji0Kzg2Wa90eF3I/52cGKVKA=;
        b=0Y0hEL0ciXdYqKSRpep0VnbzPyLN3t3FrLho/+Rm6FzKPbxt+oYC5nsuMzKjeuA2vZ
         s+SyteeC79E+f/C6dRPwYqYRz/Brz/C4ul7xJwNYtIEDDRr8XQkMluaHZpFX2ro1m7I6
         7ZWwLd7MrIQhMIcEwHWkEt4sz+lebZMRk64RzEi8mVHoVNOQowQzvgR/P7CG+0exAP6Q
         RPwYaiK1YxSFYwVkGl4Bq0oXhtXVp6VmbKnfA16ggVUU3UPYL7v3bV9yEOdYwEJmKbE8
         u2UFH6UGKeyefgqqzDyHPSFx9eJD8v3Uctj4zdg2KbbWtGs9h2IvsvgF0I8KOiRX6ru5
         cjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599869; x=1710204669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq5KdOW2n6/uRJ2XLw3ji0Kzg2Wa90eF3I/52cGKVKA=;
        b=vfPJ8CQ4kNGNxBMZGAjaQA/a7iDNbuIUbgx1YfQUG8xEvpTcvTbvVVuLk0BesUWVpd
         kEoQQzQeMS8wcZNhN+JdDZs04YJFbK64FlrxXeMOBSofOY/m5V4O67V6qtK+iOW7JObp
         XXMiVocwRFnaXa/QFrtz3yoCIQD1+PPx9aSMOKUWR5g2S9335hjumckfnQRPfRErgoSA
         ZW7tuLX10wsnsjBjhc2PAwpNTQsmSodDDpA+QCZzmeHAnws0TC/uCUZNSxj9Z/ycsTfj
         I33XYCRmK/DH9kDL2yQfL0Xv9e21OblpfwC1WConUOH9pPINaMa/y1JHfCYZFt+qCA2+
         n/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVtyFaJhapPmCYqWf4EBhq+FrHgRG3Dbv2YHSxB+S9tL+UxZKo1e1VJWUk1eBfbHmzCWzFn4/G54grq9+87vxZ5iL6dYLc/z019+Ru+
X-Gm-Message-State: AOJu0YwhvMxn+dk3/2mYVBwHGGWscRnDGteY+CgLddbQoeaDQ0UGn0yb
	LZx5MG6/5KXuXQHL636VYs22ZuRfJC1o+bvGn1C5cTCr7In8F4QQJmxMbD1EpJnRk5eWt1WqwZz
	VPpPG+v+eMA==
X-Google-Smtp-Source: AGHT+IETC0ilKp0VGNwzeHzXpNduZxbFkDR1iqMOurCmEF3CmB/y1el4/RowlH133UVUWhxNfGTKeJfaWGachg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:c17:b0:609:3834:e0f4 with SMTP
 id cl23-20020a05690c0c1700b006093834e0f4mr3273696ywb.7.1709599869416; Mon, 04
 Mar 2024 16:51:09 -0800 (PST)
Date: Mon,  4 Mar 2024 16:50:57 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-2-ipylypiv@google.com>
Subject: [PATCH v5 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
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

Export libata NCQ Priority configuration helpers to be reused
for libsas managed SATA devices.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-sata.c | 140 +++++++++++++++++++++++++++-----------
 include/linux/libata.h    |   6 ++
 2 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..f00dd02dc6f8 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -848,80 +848,122 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
 	    ata_scsi_lpm_show, ata_scsi_lpm_store);
 EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
 
-static ssize_t ata_ncq_prio_supported_show(struct device *device,
-					   struct device_attribute *attr,
-					   char *buf)
+/**
+ *	ata_ncq_prio_supported - Check if device supports NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@supported: Address of a boolean to store the result
+ *
+ *	Helper to check if device supports NCQ Priority feature.
+ */
+int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
+			   bool *supported)
 {
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
-	bool ncq_prio_supported;
+	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev)
 		rc = -ENODEV;
 	else
-		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
-	spin_unlock_irq(ap->lock);
+		*supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
+
+static ssize_t ata_ncq_prio_supported_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	bool supported;
+	int rc;
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
+	rc = ata_ncq_prio_supported(ap, sdev, &supported);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", supported);
 }
 
 DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
 EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
 
-static ssize_t ata_ncq_prio_enable_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
+/**
+ *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@enabled: Address of a boolean to store the result
+ *
+ *	Helper to check if NCQ Priority feature is enabled.
+ */
+int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
+			 bool *enabled)
 {
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
-	bool ncq_prio_enable;
+	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev)
 		rc = -ENODEV;
 	else
-		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
-	spin_unlock_irq(ap->lock);
-
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
+		*enabled = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
 
-static ssize_t ata_ncq_prio_enable_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
+static ssize_t ata_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap;
-	struct ata_device *dev;
-	long int input;
-	int rc = 0;
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	bool enabled;
+	int rc;
 
-	rc = kstrtol(buf, 10, &input);
+	rc = ata_ncq_prio_enabled(ap, sdev, &enabled);
 	if (rc)
 		return rc;
-	if ((input < 0) || (input > 1))
-		return -EINVAL;
 
-	ap = ata_shost_to_port(sdev->host);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (unlikely(!dev))
-		return  -ENODEV;
+	return sysfs_emit(buf, "%d\n", enabled);
+}
+
+/**
+ *	ata_ncq_prio_enable - Enable/disable NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
+ *
+ *	Helper to enable/disable NCQ Priority feature.
+ */
+int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			bool enable)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(ap->lock, flags);
 
-	spin_lock_irq(ap->lock);
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev) {
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
@@ -934,9 +976,29 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
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
+	bool enable;
+	int rc;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	rc = ata_ncq_prio_enable(ap, sdev, enable);
+	if (rc)
+		return rc;
 
-	return rc ? rc : len;
+	return len;
 }
 
 DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..6dd9a4f9ca7c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1157,6 +1157,12 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 				  int queue_depth);
+extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
+				  bool *supported);
+extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
+				bool *enabled);
+extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			       bool enable);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
-- 
2.44.0.278.ge034bb2e1d-goog


