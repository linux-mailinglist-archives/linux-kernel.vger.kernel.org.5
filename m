Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0978183D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjHSIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbjHSIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEB170E;
        Sat, 19 Aug 2023 01:04:53 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RSWSb6BdBz1L9GH;
        Sat, 19 Aug 2023 16:02:55 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.21) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 16:04:19 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <dan.carpenter@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] scsi: core: fix double free in raid_component_add()
Date:   Sat, 19 Aug 2023 08:03:45 +0000
Message-ID: <20230819080345.149144-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.21]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit 04b5b5cb0136 ("scsi: core: Fix possible memory leak if
device_add() fails") introduced a double free when device_add() failed.
When device_add() failed, the put_device(&rc->dev) is called, which will
call raid_component_release(), and this function will call
put_device(rc->dev.parent) and kfree(rc), but in the error path of
raid_component_release() above two functions are called again, so 'rc' are
freed twice.

We do not just revert the patch, since the memory allocated by
dev_set_name() is not released in the error path, it should be released
through calling put_device(&rc->dev) which will call kobject_cleanup(),
and the device name will be released in it. Though the commit 04b5b5cb0136
("scsi: core: Fix possible memory leak if device_add() fails") fixed the
memory leak, it didn't consider the double free problem. We removed
put_device(rc->dev.parent) and kfree(rc) in the error path, and we moved
put_device(&rc->dev) after rd->component-count--, since after
put_device(&rc->dev) is called, 'rc' is freed, so list_del(&rc->node)
cannot be called again.

Fixes: 04b5b5cb0136 ("scsi: core: Fix possible memory leak if device_add() fails")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/scsi/raid_class.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 711252e52d8e..86ed1f66d749 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,11 +248,9 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
-	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
+	put_device(&rc->dev);
 	return err;
 }
 EXPORT_SYMBOL(raid_component_add);
-- 
2.34.1

