Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400F7CDB57
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjJRMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjJRMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:11:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06420118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:11:34 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9V2F6kF4zvQJ3;
        Wed, 18 Oct 2023 20:06:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 20:11:30 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dpervushin@embeddedalley.com>, <Artem.Bityutskiy@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier
Date:   Wed, 18 Oct 2023 20:16:18 +0800
Message-ID: <20231018121618.778385-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both flt.ko and gluebi.ko are loaded, the notiier of ftl
triggers NULL pointer dereference when trying to access
‘gluebi->desc’ in gluebi_read().

ubi_gluebi_init
  ubi_register_volume_notifier
    ubi_enumerate_volumes
      ubi_notify_all
        gluebi_notify    nb->notifier_call()
          gluebi_create
            mtd_device_register
              mtd_device_parse_register
                add_mtd_device
                  blktrans_notify_add   not->add()
                    ftl_add_mtd         tr->add_mtd()
                      scan_header
                        mtd_read
                          mtd_read
                            mtd_read_oob
                              gluebi_read   mtd->read()
                                gluebi->desc - NULL

Detailed reproduction information available at the link[1],

In the normal case, obtain gluebi->desc in the gluebi_get_device(),
and accesses gluebi->desc in the gluebi_read(). However,
gluebi_get_device() is not executed in advance in the
ftl_add_mtd() process, which leads to NULL pointer dereference.

The value of gluebi->desc may also be a negative error code, which
triggers the page fault error.

This patch has the following modifications:

1. Do not assign gluebi->desc to the error code. Use the NULL instead.

2. Always check the validity of gluebi->desc in gluebi_read() If the
   gluebi->desc is NULL, try to get MTD device.

Such a modification currently works because the mutex "mtd_table_mutex"
is held on all necessary paths, including the ftl_add_mtd() call path,
open and close paths. Therefore, many race condition can be avoided.

Fixes: 2ba3d76a1e29 ("UBI: make gluebi a separate module")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/gluebi.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index 1b980d15d9fb..0ca7f104adbf 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -85,6 +85,7 @@ static int gluebi_get_device(struct mtd_info *mtd)
 {
 	struct gluebi_device *gluebi;
 	int ubi_mode = UBI_READONLY;
+	struct ubi_volume_desc *vdesc;
 
 	if (mtd->flags & MTD_WRITEABLE)
 		ubi_mode = UBI_READWRITE;
@@ -109,12 +110,14 @@ static int gluebi_get_device(struct mtd_info *mtd)
 	 * This is the first reference to this UBI volume via the MTD device
 	 * interface. Open the corresponding volume in read-write mode.
 	 */
-	gluebi->desc = ubi_open_volume(gluebi->ubi_num, gluebi->vol_id,
+	vdesc = ubi_open_volume(gluebi->ubi_num, gluebi->vol_id,
 				       ubi_mode);
-	if (IS_ERR(gluebi->desc)) {
+	if (IS_ERR(vdesc)) {
+		gluebi->desc = NULL;
 		mutex_unlock(&devices_mutex);
-		return PTR_ERR(gluebi->desc);
+		return PTR_ERR(vdesc);
 	}
+	gluebi->desc = vdesc;
 	gluebi->refcnt += 1;
 	mutex_unlock(&devices_mutex);
 	return 0;
@@ -134,8 +137,10 @@ static void gluebi_put_device(struct mtd_info *mtd)
 	gluebi = container_of(mtd, struct gluebi_device, mtd);
 	mutex_lock(&devices_mutex);
 	gluebi->refcnt -= 1;
-	if (gluebi->refcnt == 0)
+	if (gluebi->refcnt == 0) {
 		ubi_close_volume(gluebi->desc);
+		gluebi->desc = NULL;
+	}
 	mutex_unlock(&devices_mutex);
 }
 
@@ -154,9 +159,26 @@ static int gluebi_read(struct mtd_info *mtd, loff_t from, size_t len,
 		       size_t *retlen, unsigned char *buf)
 {
 	int err = 0, lnum, offs, bytes_left;
-	struct gluebi_device *gluebi;
+	struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
+						    mtd);
+	int no_desc = gluebi->desc == NULL ? 1 : 0;
+
+	/**
+	 * In normal case, the UBI volume desc has been initialized by
+	 * ->_get_device(). However, in the ftl notifier process, the
+	 * ->_get_device() is not executed in advance and the MTD device
+	 * is directly scanned which cause NULL pointer dereference.
+	 * Therefore, try to get the MTD device here.
+	 */
+	if (unlikely(no_desc)) {
+		err = __get_mtd_device(mtd);
+		if (err) {
+			err_msg("cannot get MTD device %d, UBI device %d, volume %d, error %d",
+				mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
+			return err;
+		}
+	}
 
-	gluebi = container_of(mtd, struct gluebi_device, mtd);
 	lnum = div_u64_rem(from, mtd->erasesize, &offs);
 	bytes_left = len;
 	while (bytes_left) {
@@ -176,6 +198,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	}
 
 	*retlen = len - bytes_left;
+
+	if (unlikely(no_desc))
+		__put_mtd_device(mtd);
 	return err;
 }
 
-- 
2.31.1

