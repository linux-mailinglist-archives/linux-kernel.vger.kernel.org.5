Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7454B7B14FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjI1Hgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjI1HgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:36:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD599;
        Thu, 28 Sep 2023 00:36:18 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rx4v30Wx9zMltm;
        Thu, 28 Sep 2023 15:32:31 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 15:36:14 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v2 1/4] scsi: core: Add new helper to iterate all devices of host
Date:   Thu, 28 Sep 2023 15:35:40 +0800
Message-ID: <20230928073543.3496394-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230928073543.3496394-1-haowenchao2@huawei.com>
References: <20230928073543.3496394-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shost_for_each_device() would skip devices which is in SDEV_CANCEL or
SDEV_DEL state, for some scenarios, we donot want to skip these devices,
so add a new macro shost_for_each_device_include_deleted() to handle it.

Splict scsi_device_get() and new parameter "skip_deleted" is added to
__scsi_iterate_devices() to implement this new macro.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi.c        | 43 +++++++++++++++++++++++++-------------
 include/scsi/scsi_device.h | 25 +++++++++++++++++++---
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d0911bc28663..9e31398b6e03 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -704,6 +704,26 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 	return 0;
 }
 
+static int __scsi_device_get(struct scsi_device *sdev, bool skip_deleted)
+{
+	/*
+	 * if skip_deleted is true and device is in removing, return failed
+	 */
+	if (skip_deleted &&
+	    (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
+		goto fail;
+	if (!try_module_get(sdev->host->hostt->module))
+		goto fail;
+	if (!get_device(&sdev->sdev_gendev))
+		goto fail_put_module;
+	return 0;
+
+fail_put_module:
+	module_put(sdev->host->hostt->module);
+fail:
+	return -ENXIO;
+}
+
 /**
  * scsi_device_get  -  get an additional reference to a scsi_device
  * @sdev:	device to get a reference to
@@ -717,18 +737,7 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
  */
 int scsi_device_get(struct scsi_device *sdev)
 {
-	if (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL)
-		goto fail;
-	if (!try_module_get(sdev->host->hostt->module))
-		goto fail;
-	if (!get_device(&sdev->sdev_gendev))
-		goto fail_put_module;
-	return 0;
-
-fail_put_module:
-	module_put(sdev->host->hostt->module);
-fail:
-	return -ENXIO;
+	return __scsi_device_get(sdev, 0);
 }
 EXPORT_SYMBOL(scsi_device_get);
 
@@ -749,9 +758,13 @@ void scsi_device_put(struct scsi_device *sdev)
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
@@ -761,7 +774,7 @@ struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
 	while (list->next != &shost->__devices) {
 		next = list_entry(list->next, struct scsi_device, siblings);
 		/* skip devices that we can't get a reference to */
-		if (!scsi_device_get(next))
+		if (!__scsi_device_get(next, skip_deleted))
 			break;
 		next = NULL;
 		list = list->next;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index b9230b6add04..6f8df9b04be3 100644
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
+/**
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

