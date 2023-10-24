Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450B17D4F34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjJXLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjJXLuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:50:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AFDD68
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:50:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C5BC433C8;
        Tue, 24 Oct 2023 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698148202;
        bh=/di0nuchbi/scniKqa/QIzyLS/gyMwWSJ3huyvVHoTU=;
        h=From:To:Cc:Subject:Date:From;
        b=AXiGxmFohtREcmv1E7XvCwf13O44ss7wYntxcIqUOt39HWrCEtCmwmXskBRztiiDM
         PuIlFobNe93mWoUntxzeaRc4bsUVNiK10qIaXWPDbNVZ//bL57x+cowgOZK0AQdFaG
         3ks4UwmoJR+jnl6d22gK9G48CG07r9Z5yJZHKlYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-accelerators@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] uacce: make uacce_class constant
Date:   Tue, 24 Oct 2023 13:49:59 +0200
Message-ID: <2023102458-designate-vicinity-4c86@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  71
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/di0nuchbi/scniKqa/QIzyLS/gyMwWSJ3huyvVHoTU=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnm69NMrnaesteR5N94b0dbeW91etkX7549YkWT/B5we 0dPrrXqiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlwGzHMU7Fs/dCx5txKvrXH 1tzInXnqC1PXG4b5Xv2r43OFYnwn8e/qtDh/9mxJQDk/AA==
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

Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-accelerators@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/uacce/uacce.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 930c252753a0..bdc2e6fda782 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -7,10 +7,13 @@
 #include <linux/slab.h>
 #include <linux/uacce.h>
 
-static struct class *uacce_class;
 static dev_t uacce_devt;
 static DEFINE_XARRAY_ALLOC(uacce_xa);
 
+static const struct class uacce_class = {
+	.name = UACCE_NAME,
+};
+
 /*
  * If the parent driver or the device disappears, the queue state is invalid and
  * ops are not usable anymore.
@@ -530,7 +533,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	mutex_init(&uacce->mutex);
 	device_initialize(&uacce->dev);
 	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
-	uacce->dev.class = uacce_class;
+	uacce->dev.class = &uacce_class;
 	uacce->dev.groups = uacce_dev_groups;
 	uacce->dev.parent = uacce->parent;
 	uacce->dev.release = uacce_release;
@@ -623,13 +626,13 @@ static int __init uacce_init(void)
 {
 	int ret;
 
-	uacce_class = class_create(UACCE_NAME);
-	if (IS_ERR(uacce_class))
-		return PTR_ERR(uacce_class);
+	ret = class_register(&uacce_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
 	if (ret)
-		class_destroy(uacce_class);
+		class_unregister(&uacce_class);
 
 	return ret;
 }
@@ -637,7 +640,7 @@ static int __init uacce_init(void)
 static __exit void uacce_exit(void)
 {
 	unregister_chrdev_region(uacce_devt, MINORMASK);
-	class_destroy(uacce_class);
+	class_unregister(&uacce_class);
 }
 
 subsys_initcall(uacce_init);
-- 
2.42.0

