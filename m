Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AF7BB9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjJFOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJFOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:00:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AEBB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:00:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A496C433C7;
        Fri,  6 Oct 2023 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696600817;
        bh=n60Zl5/dYdqZbu0B+NBdbry8iIlOp840xx7nxoVwwvo=;
        h=From:To:Cc:Subject:Date:From;
        b=VK7hsTp0UWarjXE4myPTx9v5PwbCI7E3mpqrpGnHuzAfW3Lf7LeLzPGEBZvQbh5+t
         3+chdH5S/plWueiR3gjHpuyGWrHK4tJ9h1gWfcWclwg6iEjy6woWSBQBZ1OoyTSr/L
         W8f/Dp2xZZs+ixlTe/uYMvDLUfTQ4udj5+l0aYro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     op-tee@lists.trustedfirmware.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] tee: make tee_class constant
Date:   Fri,  6 Oct 2023 16:00:14 +0200
Message-ID: <2023100613-lustiness-affiliate-7dcb@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  82
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=n60Zl5/dYdqZbu0B+NBdbry8iIlOp840xx7nxoVwwvo=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkKQm+DmW9IrpTaWZu1vX292vpn4c0z5ULuhH6v3j+Dp ywsykumI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyLZRhrnD/3llKbl7e7iwL 5hhJLz8S9tvDnmHBVhdJffvVG6bNUUvWkFs/wb+nwm0mAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tee/tee_core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0eb342de0b00..5ddfd5d9ac7f 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -40,7 +40,10 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
 static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
 static DEFINE_SPINLOCK(driver_lock);
 
-static struct class *tee_class;
+static const struct class tee_class = {
+	.name = "tee",
+};
+
 static dev_t tee_devt;
 
 struct tee_context *teedev_open(struct tee_device *teedev)
@@ -919,7 +922,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 		 teedesc->flags & TEE_DESC_PRIVILEGED ? "priv" : "",
 		 teedev->id - offs);
 
-	teedev->dev.class = tee_class;
+	teedev->dev.class = &tee_class;
 	teedev->dev.release = tee_release_device;
 	teedev->dev.parent = dev;
 
@@ -1112,7 +1115,7 @@ tee_client_open_context(struct tee_context *start,
 		dev = &start->teedev->dev;
 
 	do {
-		dev = class_find_device(tee_class, dev, &match_data, match_dev);
+		dev = class_find_device(&tee_class, dev, &match_data, match_dev);
 		if (!dev) {
 			ctx = ERR_PTR(-ENOENT);
 			break;
@@ -1226,10 +1229,10 @@ static int __init tee_init(void)
 {
 	int rc;
 
-	tee_class = class_create("tee");
-	if (IS_ERR(tee_class)) {
+	rc = class_register(&tee_class);
+	if (rc) {
 		pr_err("couldn't create class\n");
-		return PTR_ERR(tee_class);
+		return rc;
 	}
 
 	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
@@ -1249,8 +1252,7 @@ static int __init tee_init(void)
 out_unreg_chrdev:
 	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
 out_unreg_class:
-	class_destroy(tee_class);
-	tee_class = NULL;
+	class_unregister(&tee_class);
 
 	return rc;
 }
@@ -1259,8 +1261,7 @@ static void __exit tee_exit(void)
 {
 	bus_unregister(&tee_bus_type);
 	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
-	class_destroy(tee_class);
-	tee_class = NULL;
+	class_unregister(&tee_class);
 }
 
 subsys_initcall(tee_init);
-- 
2.42.0

