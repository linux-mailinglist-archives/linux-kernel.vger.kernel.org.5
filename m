Return-Path: <linux-kernel+bounces-26990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C266E82E8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF091C22C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB11D556;
	Tue, 16 Jan 2024 04:52:41 +0000 (UTC)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F21CD01;
	Tue, 16 Jan 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125556479"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125556479"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:22 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A925CD6C5;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D6779D3F0C;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 73DE56B4C7;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D2B51A015F;
	Tue, 16 Jan 2024 12:52:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 19/42] drivers/scsi/arcmsr: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:28 +0800
Message-Id: <20240116045151.3940401-17-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--13.423200-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtptIv0A3hSOW84WYLmQfXYmpoPHQXywp1ccUAl2qrF9ySUnLzk1+Ixzd3XtjqAaoMKO2Z
	R/UHJk1ZSE6QsCXaxnIAsIvOHmXuGXBXaJoB9JZxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7oIGx
	JmGmz8hCBt8f7dUWk/wDN9PxHK8r5Rj7je41fFwPpCuffGH9zI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/arcmsr/arcmsr_attr.c:261:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:273:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:285:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:297:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:309:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:322:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:335:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:348:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:361:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/arcmsr/arcmsr_attr.c:374:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/arcmsr/arcmsr_attr.c | 40 ++++++++-----------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e795690..0eecd354a3d0 100644
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
+	return sysfs_emit(buf, "%4d\n", atomic_read(&acb->ccboutstandingcount));
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
+	return sysfs_emit(buf, "%4d\n", acb->firm_numbers_queue);
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
+	return sysfs_emit(buf, PAGE_SIZE, "%4d\n", acb->firm_hd_channels);
 }
 
 static DEVICE_ATTR(host_driver_version, S_IRUGO, arcmsr_attr_host_driver_version, NULL);
-- 
2.29.2


