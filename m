Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDEB76FF30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHDLHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHDLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:06:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E777AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:06:57 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHNCk74PfzVjdL;
        Fri,  4 Aug 2023 19:05:06 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:06:54 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <linux@armlinux.org.uk>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v4] drm/i2c: tda998x: remove redundant CONFIG_OF and of_match_ptr()
Date:   Fri, 4 Aug 2023 19:06:25 +0800
Message-ID: <20230804110625.98520-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use CONFIG_OF
and of_match_ptr() here, we remove them all.

Even for drivers that do not depend on CONFIG_OF, it's almost always
better to leave out the of_match_ptr(), since the only thing it can
possibly do is to save a few bytes of .text if a driver can be used both
with and without it.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

---
Changes in v2:
- Remove CONFIG_OF which includes tda998x_ids.

---
Changes in v3:
- Changes of_match_ptr to of_match_ptr() in the commit message.

---
Changes in v4:
- Remove "Reviewed-by: Andy Shevchenko".
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d8d7de18dd65..9666e0746240 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -2084,13 +2084,11 @@ static void tda998x_remove(struct i2c_client *client)
 	tda998x_destroy(&client->dev);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id tda998x_dt_ids[] = {
 	{ .compatible = "nxp,tda998x", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tda998x_dt_ids);
-#endif
 
 static const struct i2c_device_id tda998x_ids[] = {
 	{ "tda998x", 0 },
@@ -2103,7 +2101,7 @@ static struct i2c_driver tda998x_driver = {
 	.remove = tda998x_remove,
 	.driver = {
 		.name = "tda998x",
-		.of_match_table = of_match_ptr(tda998x_dt_ids),
+		.of_match_table = tda998x_dt_ids,
 	},
 	.id_table = tda998x_ids,
 };
-- 
2.17.1

