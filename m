Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48E7BFF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjJJOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjJJOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:24:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D4A91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:24:31 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4dMW62kfztTGK;
        Tue, 10 Oct 2023 22:19:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 10 Oct
 2023 22:24:27 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier
Date:   Tue, 10 Oct 2023 22:29:25 +0800
Message-ID: <20231010142925.545238-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both flt.ko and gluebi.ko are loaded, the notiier of ftl
triggers NULL pointer dereference when trying to visit
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
ftl_add_mtd() process, which leads to null pointer dereference.

This patch assumes that the gluebi module is not designed to work with
the ftl module. In this case, the patch only needs to prevent the ftl
notifier operation.

Add some correctness check for gluebi->desc in gluebi_read/write/erase(),
If the pointer is invalid, the -EINVAL is returned.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/gluebi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index 1b980d15d9fb..189ecc0eacd1 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -157,6 +157,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct gluebi_device *gluebi;
 
 	gluebi = container_of(mtd, struct gluebi_device, mtd);
+	if (IS_ERR_OR_NULL(gluebi->desc))
+		return -EINVAL;
+
 	lnum = div_u64_rem(from, mtd->erasesize, &offs);
 	bytes_left = len;
 	while (bytes_left) {
@@ -197,6 +200,9 @@ static int gluebi_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct gluebi_device *gluebi;
 
 	gluebi = container_of(mtd, struct gluebi_device, mtd);
+	if (IS_ERR_OR_NULL(gluebi->desc))
+		return -EINVAL;
+
 	lnum = div_u64_rem(to, mtd->erasesize, &offs);
 
 	if (len % mtd->writesize || offs % mtd->writesize)
@@ -242,6 +248,8 @@ static int gluebi_erase(struct mtd_info *mtd, struct erase_info *instr)
 	lnum = mtd_div_by_eb(instr->addr, mtd);
 	count = mtd_div_by_eb(instr->len, mtd);
 	gluebi = container_of(mtd, struct gluebi_device, mtd);
+	if (IS_ERR_OR_NULL(gluebi->desc))
+		return -EINVAL;
 
 	for (i = 0; i < count - 1; i++) {
 		err = ubi_leb_unmap(gluebi->desc, lnum + i);
-- 
2.31.1

