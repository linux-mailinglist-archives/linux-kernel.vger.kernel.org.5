Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A377C9D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJPCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjJPCDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:03:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665CE95;
        Sun, 15 Oct 2023 19:03:40 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S80dl2C9HzvPyk;
        Mon, 16 Oct 2023 09:58:51 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 10:03:32 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v3 1/4] scsi: core: Add new helper to iterate all devices of host
Date:   Mon, 16 Oct 2023 10:03:11 +0800
Message-ID: <20231016020314.1269636-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231016020314.1269636-1-haowenchao2@huawei.com>
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d1c0ba3ef1f5..a9d695841250 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -704,20 +704,18 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
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
@@ -730,6 +728,22 @@ int scsi_device_get(struct scsi_device *sdev)
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
@@ -749,9 +763,13 @@ void scsi_device_put(struct scsi_device *sdev)
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
@@ -761,7 +779,7 @@ struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
 	while (list->next != &shost->__devices) {
 		next = list_entry(list->next, struct scsi_device, siblings);
 		/* skip devices that we can't get a reference to */
-		if (!scsi_device_get(next))
+		if (!__scsi_device_get(next, skip_deleted))
 			break;
 		next = NULL;
 		list = list->next;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index b9230b6add04..ed02755bbc42 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -390,7 +390,8 @@ extern void __starget_for_each_device(struct scsi_target *, void *,
 
 /* only exposed to implement shost_for_each_device */
 extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
-						  struct scsi_device *);
+						  struct scsi_device *,
+						  bool);
 
 /**
  * shost_for_each_device - iterate over all devices of a host
@@ -400,11 +401,29 @@ extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
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

