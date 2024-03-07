Return-Path: <linux-kernel+bounces-95762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB668875231
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF16B1C24B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39F012D760;
	Thu,  7 Mar 2024 14:45:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45931EB21;
	Thu,  7 Mar 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822753; cv=none; b=TMN+gfX3F24M1pvcMEJv0MU+6plQUfCBItuGEA4dD+/tahYOySFzyyKhQ3WSVHNA0tP3UQVXlYEr43gbnVMUfXEEQhVAsE462LjRF1vHypslHKYcbePqJTxY5ffD1tRhpCHon4HM1aRf0exKX+dqT/1+sweBIVotnuFexVkeLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822753; c=relaxed/simple;
	bh=d0osuwdSLAIBmDw6/59ET28fwxKF1AVC4l5TDRDjL2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1zPpqhr8d6mHU+MGflZBfh8TGO0EKJ/zOL0P6lzLQZas29hzHUKnowTfhqoqi+REiEdk7iZVwa2ZnbcXTRszcnVgUJf/Hs7t1Y/4xXkrnqgNwur78a7dZ91X+ApvZLQKtAPOThepthOoTbQJmQD1VSsBZtWQULi4dLIjNzog40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrBqx5sfHz2Bf9W;
	Thu,  7 Mar 2024 22:43:25 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id F199B1A016C;
	Thu,  7 Mar 2024 22:45:47 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:45:47 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao2@huawei.com>, <louhongxiang@huawei.com>
Subject: [PATCH v4 1/3] scsi: core: Add new helper to iterate all devices of host
Date: Thu, 7 Mar 2024 22:43:09 +0800
Message-ID: <20240307144311.73735-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240307144311.73735-1-haowenchao2@huawei.com>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

shost_for_each_device() would skip devices which is in SDEV_CANCEL or
SDEV_DEL state, for some scenarios, we donot want to skip these devices,
so add a new macro shost_for_each_device_include_deleted() to handle it.

Following changes are introduced:

1. Rework scsi_device_get(), add new helper __scsi_device_get() which
   determine if skip deleted scsi_device by parameter "skip_deleted".
2. Add new parameter "skip_deleted" to __scsi_iterate_devices() which
   is used when calling __scsi_device_get()
3. Update shost_for_each_device() to call __scsi_iterate_devices() with
   "skip_deleted" true
4. Add new macro shost_for_each_device_include_deleted() which call
   __scsi_iterate_devices() with "skip_deleted" false

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
 include/scsi/scsi_device.h | 25 ++++++++++++++++++---
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8cad9792a562..ec0a5f7e6ab8 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -733,20 +733,18 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 	return 0;
 }
 
-/**
- * scsi_device_get  -  get an additional reference to a scsi_device
+/*
+ * __scsi_device_get  -  get an additional reference to a scsi_device
  * @sdev:	device to get a reference to
- *
- * Description: Gets a reference to the scsi_device and increments the use count
- * of the underlying LLDD module.  You must hold host_lock of the
- * parent Scsi_Host or already have a reference when calling this.
- *
- * This will fail if a device is deleted or cancelled, or when the LLD module
- * is in the process of being unloaded.
+ * @skip_deleted: when true, would return failed if device is deleted
  */
-int scsi_device_get(struct scsi_device *sdev)
+static int __scsi_device_get(struct scsi_device *sdev, bool skip_deleted)
 {
-	if (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL)
+	/*
+	 * if skip_deleted is true and device is in removing, return failed
+	 */
+	if (skip_deleted &&
+	    (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
 		goto fail;
 	if (!try_module_get(sdev->host->hostt->module))
 		goto fail;
@@ -759,6 +757,22 @@ int scsi_device_get(struct scsi_device *sdev)
 fail:
 	return -ENXIO;
 }
+
+/**
+ * scsi_device_get  -  get an additional reference to a scsi_device
+ * @sdev:	device to get a reference to
+ *
+ * Description: Gets a reference to the scsi_device and increments the use count
+ * of the underlying LLDD module.  You must hold host_lock of the
+ * parent Scsi_Host or already have a reference when calling this.
+ *
+ * This will fail if a device is deleted or cancelled, or when the LLD module
+ * is in the process of being unloaded.
+ */
+int scsi_device_get(struct scsi_device *sdev)
+{
+	return __scsi_device_get(sdev, 0);
+}
 EXPORT_SYMBOL(scsi_device_get);
 
 /**
@@ -778,9 +792,13 @@ void scsi_device_put(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL(scsi_device_put);
 
-/* helper for shost_for_each_device, see that for documentation */
+/**
+ * helper for shost_for_each_device, see that for documentation
+ * @skip_deleted: if true, sdev in progress of removing would be skipped
+ */
 struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
-					   struct scsi_device *prev)
+					   struct scsi_device *prev,
+					   bool skip_deleted)
 {
 	struct list_head *list = (prev ? &prev->siblings : &shost->__devices);
 	struct scsi_device *next = NULL;
@@ -790,7 +808,7 @@ struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
 	while (list->next != &shost->__devices) {
 		next = list_entry(list->next, struct scsi_device, siblings);
 		/* skip devices that we can't get a reference to */
-		if (!scsi_device_get(next))
+		if (!__scsi_device_get(next, skip_deleted))
 			break;
 		next = NULL;
 		list = list->next;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c38f4fe5e64c..fc6d999cd201 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -411,7 +411,8 @@ extern void __starget_for_each_device(struct scsi_target *, void *,
 
 /* only exposed to implement shost_for_each_device */
 extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
-						  struct scsi_device *);
+						  struct scsi_device *,
+						  bool);
 
 /**
  * shost_for_each_device - iterate over all devices of a host
@@ -421,11 +422,29 @@ extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
  * Iterator that returns each device attached to @shost.  This loop
  * takes a reference on each device and releases it at the end.  If
  * you break out of the loop, you must call scsi_device_put(sdev).
+ *
+ * Note: this macro would skip sdev which is in progress of removing
  */
 #define shost_for_each_device(sdev, shost) \
-	for ((sdev) = __scsi_iterate_devices((shost), NULL); \
+	for ((sdev) = __scsi_iterate_devices((shost), NULL, 1); \
+	     (sdev); \
+	     (sdev) = __scsi_iterate_devices((shost), (sdev), 1))
+
+/*
+ * shost_for_each_device_include_deleted- iterate over all devices of a host
+ * @sdev: the &struct scsi_device to use as a cursor
+ * @shost: the &struct scsi_host to iterate over
+ *
+ * Iterator that returns each device attached to @shost.  This loop
+ * takes a reference on each device and releases it at the end.  If
+ * you break out of the loop, you must call scsi_device_put(sdev).
+ *
+ * Note: this macro would include sdev which is in progress of removing
+ */
+#define shost_for_each_device_include_deleted(sdev, shost) \
+	for ((sdev) = __scsi_iterate_devices((shost), NULL, 0); \
 	     (sdev); \
-	     (sdev) = __scsi_iterate_devices((shost), (sdev)))
+	     (sdev) = __scsi_iterate_devices((shost), (sdev), 0))
 
 /**
  * __shost_for_each_device - iterate over all devices of a host (UNLOCKED)
-- 
2.32.0


