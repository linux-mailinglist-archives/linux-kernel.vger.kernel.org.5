Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA57ABCE4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 03:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjIWBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIWBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:03:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E2CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 18:03:19 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RsrRl5NFLz15NRV;
        Sat, 23 Sep 2023 09:01:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 23 Sep
 2023 09:03:16 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [RFC] mtd: Fix error code loss in mtdchar_read() function.
Date:   Sat, 23 Sep 2023 08:58:56 +0800
Message-ID: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first while loop, if the mtd_read() function returns -EBADMSG
and 'retlen' returns 0, the loop break and the function returns value
'total_retlen' is 0, not the error code.

This problem causes the user-space program to encounter EOF when it has
not finished reading the mtd partion, and this also violates the read
system call standard in POSIX.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217939
Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/mtdchar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 8dc4f5c493fc..ba60dc6bef98 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -211,7 +211,7 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 	}
 
 	kfree(kbuf);
-	return total_retlen;
+	return total_retlen ? total_retlen : ret;
 } /* mtdchar_read */
 
 static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t count,
-- 
2.31.1

