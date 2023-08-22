Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C446778379E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjHVBxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjHVBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:53:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0C113;
        Mon, 21 Aug 2023 18:53:32 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVC5G6LfDz1L9ZS;
        Tue, 22 Aug 2023 09:52:02 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.21) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:53:30 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <bvanassche@acm.org>,
        <bblock@linux.ibm.com>, <dan.carpenter@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v2] scsi: Remove raid_component_add()
Date:   Tue, 22 Aug 2023 01:52:54 +0000
Message-ID: <20230822015254.184270-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.21]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raid_component_add() function was added to the kernel tree via
patch "[SCSI] embryonic RAID class" (2005). Remove this function since
it never has had any callers in the Linux kernel. And also
raid_component_release is only used in raid_component_add(), so it is
also removed.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/scsi/raid_class.c  | 48 --------------------------------------
 include/linux/raid_class.h |  4 ----
 2 files changed, 52 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 711252e52d8e..95a86e0dfd77 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -209,54 +209,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 6a9b177d5c41..e50416ba9cd9 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-
-- 
2.34.1

