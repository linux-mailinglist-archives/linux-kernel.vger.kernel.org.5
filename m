Return-Path: <linux-kernel+bounces-91338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DC870FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C32EB244F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EDC7C088;
	Mon,  4 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHcY164w"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8F7B3FA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590108; cv=none; b=dY5v8/RLEsUCMjUESszb1bdwIeTYOcUql0wP3kpjNOwQndjFLye0iBrM3iwQAFfCpJqRztTRCo6o/PcIvVVAXfiHL2mo3wmp8igx+kEbtCT1hS4B9p819SOkNMIbpelg+UQS334JSUt59Ak6iW6BOOcGRl26jRzBD+NCxZPD1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590108; c=relaxed/simple;
	bh=KICc4dnvLGTzCC3FNqjGxTvq8eAy0dBzW/l8FVRxPb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IJZEnXBpAF5v+98UqZmCKL4Zq+dEt7mZV58mtYVTBTKnOQ41nzJuhZsy6cGLWK7pRJEoTzWf7fLBZO18NooolGj5zgHnm/M/pkUPX3LwANSUtribrqkOlYUhfYnCeGJxmysURuZ3nij3MC4R7FEQQZUuPTfl/5Kw+2c9NuZAU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHcY164w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6099e707622so1241097b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590105; x=1710194905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzsWWAo/xYiW4zw4aIXFlbocWe20WgmvCuPELvrmNDA=;
        b=oHcY164wFyyLolDBKByz903bcg+LfeKhxRyvxDB5msPR3mp8W3uYcKfCzUpYMSjHpp
         x1t1leSE3/G4Assjn7Xt4T898pfrPNk9B9sD/D/BmjsEOJ2yLmcDAL1GkTlsDFfwVyJp
         Io817hdATpyCgiIUf8E0TOj8P2CP6h2MDDChIHdVfKyThO+DFdVxAMLpSauj65Kn9M5y
         M0o9SX+zQHjlFEkuqNisKLv6Ru+0pReqUOK3x9QIdq3uI4EcaGFeO5WAd4aoG4545pQR
         gcce3rdehKeXR9NuYXmjQO4VeLHR9F3QWcS//q9CuBwJBEFTbN8zz7jVUKaFXkEEzQ5k
         DqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590105; x=1710194905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzsWWAo/xYiW4zw4aIXFlbocWe20WgmvCuPELvrmNDA=;
        b=JbPZ98ORBPCgLlWH6wpsL+STLCSWxafKCNEP5n5xIY41ji2dl0px++TESKq4ijC1nm
         lyqDmsX/vVwQ2eoEVUuZ2sXoWpMOThgXrYZi65uJow/A0rquK9qbfPN+lmfkCRxaGizm
         3D1CStdOJiqBQpRiyXMAK5qhKVopLIO8hcqzUhu/baWOg4tEryH5yMHHQ3QpPzZLGutJ
         pSCOLvUY18ZJY6ElCDE/x0Ud0BYgJxMOUJxCQVe4+v91KL/zgOS2ruia6Zt0WIlPPJSC
         vWZg6VEWZYn31eT8CsAu453sr7FjfYoNm2PJlHFeIknN2fO5QcjhA60VoEbUQTfz8XnA
         v5hg==
X-Forwarded-Encrypted: i=1; AJvYcCU8hQZEuaQ9FzL920b+2R1dxO96F9BkFlsu37cZDOE/Hde5owN8NYP3UBsJHNeR4HD5SG6NtXzac4ndD5kW5nw+VgySD2R0BBWNzsog
X-Gm-Message-State: AOJu0YzaUMmvdaNwfzg0wcFQ7WFHQNkY0Ejjbm2qxktGuOJG2vhVfj/Y
	/HeYvs4JwZEJdbkYEngDTX/Fo42thFsuKER+JnfHxTDRtC86DdNvk9OlXQhAwruFGRLAndqN88W
	Rk82/dCdF8A==
X-Google-Smtp-Source: AGHT+IEOaRN+2rpttgqPFFy44Mzu7rFPJhfK2j2F4PJmr0F0Ze4t1QA1Pg58rXLR6v1jmCQrYWR+aZmCF9C+YQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:150d:b0:dc6:fa35:b42 with SMTP
 id q13-20020a056902150d00b00dc6fa350b42mr2867409ybu.2.1709590105483; Mon, 04
 Mar 2024 14:08:25 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:09 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-2-ipylypiv@google.com>
Subject: [PATCH v4 1/7] ata: libata-sata: Factor out NCQ Priority
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


