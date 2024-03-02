Return-Path: <linux-kernel+bounces-89579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EE86F245
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946CE1F221FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0541AAB;
	Sat,  2 Mar 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oie5CDw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A640866
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410613; cv=none; b=YQun+/f3Zcq0J6z1hDVnExsrTUat/ib2c0VJRwf9bhAyTdPutr0RDMJq0YtOGgHYPrmiVep75GRuX7ymo9pGNSxFrl8HXSK4Shv8v4go1pAG5oSeP+S3nw4aXA7wIvsq/JO9KaoMxCUJSoculpjmPQIzXvB06obE9u5mqkNGRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410613; c=relaxed/simple;
	bh=Dr1gHME6UhZzljl3CDtFvx0fMB3rr1EwYhk4f6Q7U3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RVRH0VimJs7/1MXvxawGo+y9IhvEoM+qS5f3w2UYr6jA2EQWEfUlRLVo4I0XMfL+x7Cnat9tfet42CM6+wY6JGsgm5xvUX7g9VttXMFsWeI+8UpwqHc8FFdQxpIkFZbD6GQOmjEZrHvzhptPhKjfUwNC2gc0X+dvPa/acowsW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oie5CDw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so5936112276.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410611; x=1710015411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4qRVCwUT6U2lE1it/3KAP9Dql1inh3yxdaUzH18pmU=;
        b=4oie5CDw5PvS9wI9rGwlbAFMuTxzmjU/07cqn4NzhtcqRX53z7HOysQqrtfjHYZ+9F
         nJOSwlwEVomVrSPHdAZKq3++2ndUon8qHs4xsUYi3a8eoIeBl5lLJXRjYi2I6ogb+8it
         /7D5QV65bZZ5g4Q3WQdnVusTNFkAihwAk0FsahLkaZdUBlccndbKD+wAaf/1r/zBxrJv
         NHHd0m8+wSCbJa2HGQ9ZMH4taeBaPtkgwK5Cqth4/bTZJfmkMgSibAbLi7kL9QuDJGf7
         591VlceDJ7qGFty2NGy5eyLgiOhUZXs0krldiZoqwuOtNY7EF5jDwFFwYtQLDzk/q/fx
         BWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410611; x=1710015411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4qRVCwUT6U2lE1it/3KAP9Dql1inh3yxdaUzH18pmU=;
        b=CYBfDJh285GPwqTSJkhxKVvz9e1d+5489Yonosl8LdsE5Fy4fla3+iVACJD4tOEaxg
         AlItbwXbKlyu1HiRJerYKIipww3JrSgqJ8dAM3gOOMX339o81CyeiMdHwtum1IrZTLuy
         qkMFyckBR1oKsvTRGsC/mxxYpnz/4YUWee8EUrfBKotz1cTi7VIMD/Pips8vOWzaqZv/
         GG5/lXF49DoJk3OycTqrje6bk8OCUoL3Qn7IN+XPfPHIBUIdlow6I0aReo+03YI8qTA9
         hnmg97O5lGiKQ7Jrx8tLpz3D6b+zl+A3QGVph/LGpQLcGbAGhlMbQP2GL/z52VGRuhpw
         nEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXZFX4BKnzrD25yYAG/QLvcCBHblLOlc83jN6PzuTy7uIXZCqwdT/FopAbcU1ZB8ibCPELuBDwFcEibSNX/wFDCO96JkfLJ5SCFYUc
X-Gm-Message-State: AOJu0YyD7w2JpFP7IIToNDdQ/mTS7rz88Y/mNVlOcwvOnA+ElOONrMpf
	pYme9WpacdVCS8MY5bvoMgsCFlHvNWXa2fUyGxRzKw+/pR0G5WRa6E/HhWRPV8iCWo/MGdaQNFv
	SouO8b5LNBA==
X-Google-Smtp-Source: AGHT+IGOW7SBJh4WP3KpmE2TKXdeEoDMr8V7/Lvbu1fuVnc60rYhGJoHBqHZ0S79O1x3nEtKwjjpI25HI3zqFA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:2492:b0:dcb:b9d7:2760 with SMTP
 id ds18-20020a056902249200b00dcbb9d72760mr1372955ybb.13.1709410610740; Sat,
 02 Mar 2024 12:16:50 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:30 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-2-ipylypiv@google.com>
Subject: [PATCH v3 1/7] ata: libata-sata: Factor out NCQ Priority
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
 drivers/ata/libata-sata.c | 139 +++++++++++++++++++++++++++-----------
 include/linux/libata.h    |   4 ++
 2 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..a8d5e36d5211 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -848,29 +848,73 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
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
+	if (!dev)
+		rc = -ENODEV;
+	else
+		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO);
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
+	int rc;
+
+	rc = ata_ncq_prio_supported(ap, sdev);
+	if (rc < 0)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", rc);
+}
+
+DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
+
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
 	struct ata_device *dev;
-	bool ncq_prio_supported;
-	int rc = 0;
+	unsigned long flags;
+	int rc;
 
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev)
 		rc = -ENODEV;
 	else
-		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
-	spin_unlock_irq(ap->lock);
-
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
+		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED);
+	spin_unlock_irqrestore(ap->lock, flags);
+	return rc;
 }
-
-DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
-EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
 
 static ssize_t ata_ncq_prio_enable_show(struct device *device,
 					struct device_attribute *attr,
@@ -878,50 +922,45 @@ static ssize_t ata_ncq_prio_enable_show(struct device *device,
 {
 	struct scsi_device *sdev = to_scsi_device(device);
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev;
-	bool ncq_prio_enable;
-	int rc = 0;
+	int rc;
 
-	spin_lock_irq(ap->lock);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev)
-		rc = -ENODEV;
-	else
-		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
-	spin_unlock_irq(ap->lock);
+	rc = ata_ncq_prio_enabled(ap, sdev);
+	if (rc < 0)
+		return rc;
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
+	return sysfs_emit(buf, "%d\n", rc);
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
@@ -934,9 +973,29 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
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


