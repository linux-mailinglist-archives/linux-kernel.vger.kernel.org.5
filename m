Return-Path: <linux-kernel+bounces-89259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4D86ED53
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5951F225B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A516DDB2;
	Sat,  2 Mar 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INwPm8bn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F78C04
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338618; cv=none; b=RcI8XTyhl6db8MK0Bj7rC8SH0eA/QdIJLzbTtYGjWPAD2JJcTesroqXyIFlEVwroHYKdGe6FYb3W09CY1Ozp5xK6cLyVm1SohcouwIY53rIE5RQEufu6KEw/JhV3Ryw7zUtAD1E+4IUXdYD+OJ8oj2hvU1egI3b+Wi9Gf47Sdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338618; c=relaxed/simple;
	bh=Dr1gHME6UhZzljl3CDtFvx0fMB3rr1EwYhk4f6Q7U3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rf1qJgj/rk4jnSilX5O1ylSPvYVutrQpPcH2+Z0P4JJaT1OM3fGe4G+9EomYcySrecfmGqezl7Gv1nQ1McH7a1UsNcxImdeZQ6hRH+i04NvANQwEsTDfCZNvHx8B6G02zHWs131qnKCDv9nnV6Ra5m/b0zvoz2H2V+YCspnvl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INwPm8bn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60957b52eecso44542097b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338616; x=1709943416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4qRVCwUT6U2lE1it/3KAP9Dql1inh3yxdaUzH18pmU=;
        b=INwPm8bnvPkpvRrvkTM4Bblov2tYt9jMtyrcQhRMME/0Fz5GeeRBGncU9ZoF28hIuF
         5DGNPwVvqhYp6t9zBgFcsuN0+xxWQYMhxze4ITYrtc2z5it9uWV7j3RGYCXhlPJkkOuH
         M+1shUfmIMPPQfRufboRWNyn4mLsKPzs/ScAtzHy19dCVr3az0hLlzLL41KuAmhwHOjP
         t1jVjfDGvVqV4QSGqmDtz8yVtrr357ydZN275emYt8bzfXymD50QNTwO11WRROLed5Uv
         7UuFu9pLZD+bUyE8qknXj2flGc3wMLB4JIn5UYPo2u8oD8VhCVuaRkuGUbTS04jXNDYP
         VatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338616; x=1709943416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4qRVCwUT6U2lE1it/3KAP9Dql1inh3yxdaUzH18pmU=;
        b=n3Dhp08cp/kZJUMae2NW/0HC5DUL9yeQ/Xiva9nco9P4UTLpdFhoXpS+lIUOwRg5Dv
         uX3m7KmJu0nH1iEHjo9M2rQWZWtLZz0TM/02K9+Uu3wSjUw97L31crqfkXdQoCkEI2qH
         ZFzHpYNgQGZ4HtBsNKusMKhvoqbm26k1m7+4uPaNcHPvW+smthVDz85zUacXv0m/r2p1
         zkK0b3viOZblw3sliuv9D+cBnRQ/f7lHcAhZ0vFOM9zbcBYs4BLUhVFiT+8ADiUPumOP
         cRFWzJGeo7aa1+ZuWIY0HmbIz2A/mymw8/dkFVthEgdYHwW9zOJUVaFPVTFKVjchcpZZ
         1MCw==
X-Forwarded-Encrypted: i=1; AJvYcCXHZU0OoYfK2uTq1JYGoIzz+S3rG78Ay3+XLL46dRKd6gleZZNST/Vd7OiIkzMpiJlXBr3q6xI5BOV5FwYh8ApeVvprJqe3mnh9sVnz
X-Gm-Message-State: AOJu0YzIvXaBN4J8v/7BpJ1wcH4A12KoPD6nKRrYaQFRdOmJB7xSjJvD
	OqXzu6M/8I9OzXaroJRC5j7NLzWJaIjQmZwQXynnVPdxAc0xohDUqfyax78OFXJZOitllY3rAik
	5kqLsqss27w==
X-Google-Smtp-Source: AGHT+IECx6PpDaRn3lWCO4kqH6mkOTlKcZ2HgzcSoL7uxuJwnrYEOtuQSx0/r4Fj2I8xm3fPVt4EsAa7ObBmsQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:3612:b0:607:a30d:8cf with SMTP
 id ft18-20020a05690c361200b00607a30d08cfmr636509ywb.4.1709338615938; Fri, 01
 Mar 2024 16:16:55 -0800 (PST)
Date: Fri,  1 Mar 2024 16:15:58 -0800
In-Reply-To: <20240302001603.1012084-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302001603.1012084-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-2-ipylypiv@google.com>
Subject: [PATCH v2 1/5] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
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


