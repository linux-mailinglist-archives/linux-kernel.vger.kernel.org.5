Return-Path: <linux-kernel+bounces-57656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF284DBDA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18F6284BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99665762D9;
	Thu,  8 Feb 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOEmzCzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056E74E2A;
	Thu,  8 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381938; cv=none; b=XvpprrpUgadia5CVM1NSfbgfarfEg2WH3gAFQsQQQ/RMtNqLK9CMP09m9oZfyaSzCDTQUCw8UC82r1TDvo6ejO9arz3C8Uah3zWxuBqIEkbYXwvjwKav66MOquzOCS5knTWGAjwg0A3uhAGOkQe7A2LOs2rOJq/r2Vc/UI7eNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381938; c=relaxed/simple;
	bh=qmbHfN/f8YgSLjrFL2hPNhuDBX1LYqccIkoXslfVQ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRrK3aks/8IQLgXXaD9OhBbxitdQf8znf7J0WXTZz27P6djHe7VX4KzeiHhR87JYXwX1iZZSF+Is6sNxEnKZXHVoI+GYwbuTYKZzGCT5Dhu4aNM3vUk2t7bYT/pDC7+ZNkQql88yrraDSq3eNIvbqzcB3qvuj7z64a8IhLnjIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOEmzCzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F1C433B1;
	Thu,  8 Feb 2024 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381938;
	bh=qmbHfN/f8YgSLjrFL2hPNhuDBX1LYqccIkoXslfVQ1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOEmzCzgxxjlFn+1XmC8QqhwKpmjJFNJilrBiaaa5pcylqyqEEg8E4wf2GwOCaUU9
	 fegkkGzEwK1cmtc+QpLPwbHg96F2C7Ie9tVls5Ah66PKkdfldLMY9XXQaNy+MNK3dQ
	 TzGwHdq/qNrgG/Cr+pjuxFRRm9NPhHiumqhc+QF3WTcRiCnwaCytOg2fObaVSrBmY3
	 ox5G+HNe7WQOAeVbl057M+XYrRXShmn+DlS41O5L/tlxnFXemnFTuln958Q11MuV1e
	 mbJcvIB59oJizF3UieAN2VSxFeZK+qYR8l+ueWh663SQ/ZO+NG9tBSATUUryXlpqrB
	 XKnFiJpyUgDUQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	support@areca.com.tw,
	linux-scsi@vger.kernel.org
Subject: [PATCH 10/10] scsi: arcmsr: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu,  8 Feb 2024 08:44:22 +0000
Message-ID: <20240208084512.3803250-11-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: support@areca.com.tw
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/arcmsr/arcmsr_attr.c | 40 ++++++++-----------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e7956902..c430c835503be 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -258,9 +258,7 @@ static ssize_t
 arcmsr_attr_host_driver_version(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			ARCMSR_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ARCMSR_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -270,9 +268,7 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			atomic_read(&acb->ccboutstandingcount));
+	return sysfs_emit(buf, "%4d\n",	atomic_read(&acb->ccboutstandingcount));
 }
 
 static ssize_t
@@ -282,9 +278,7 @@ arcmsr_attr_host_driver_reset(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_resets);
+	return sysfs_emit(buf, "%4d\n", acb->num_resets);
 }
 
 static ssize_t
@@ -294,9 +288,7 @@ arcmsr_attr_host_driver_abort(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_aborts);
+	return sysfs_emit(buf, "%4d\n", acb->num_aborts);
 }
 
 static ssize_t
@@ -306,9 +298,7 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_model);
+	return sysfs_emit(buf, "%s\n", acb->firm_model);
 }
 
 static ssize_t
@@ -319,9 +309,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
 	struct AdapterControlBlock *acb =
 			(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_version);
+	return sysfs_emit(buf, "%s\n", acb->firm_version);
 }
 
 static ssize_t
@@ -332,9 +320,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_request_len);
+	return sysfs_emit(buf, "%4d\n", acb->firm_request_len);
 }
 
 static ssize_t
@@ -345,9 +331,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_numbers_queue);
+	return sysfs_emit(buf, "%4d\n",	acb->firm_numbers_queue);
 }
 
 static ssize_t
@@ -358,9 +342,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_sdram_size);
+	return sysfs_emit(buf, "%4d\n", acb->firm_sdram_size);
 }
 
 static ssize_t
@@ -371,9 +353,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_hd_channels);
+	return sysfs_emit(buf, "%4d\n", acb->firm_hd_channels);
 }
 
 static DEVICE_ATTR(host_driver_version, S_IRUGO, arcmsr_attr_host_driver_version, NULL);
-- 
2.43.0.594.gd9cf4e227d-goog


