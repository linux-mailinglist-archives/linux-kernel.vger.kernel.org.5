Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FC7781BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjHJTmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:42:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D4F26B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:42:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so2367375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691696571; x=1692301371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHgHVPT9NJJEy57ofYCBRT0494lyChFydr7q0MZfbDM=;
        b=R9kFksSJzZj/Iz1zeBAb1QoHkxPLoLqiRqywhOLGxFtlb3sZM23LR7DYgOQaHAIGkr
         VcVefruOfmgtM4yQmLX1fAzgPIS4YPONElZlJMzt/gYaCGyW9duahu9PW2XxCTcHOorq
         XREFCna2GS2+hpGqCFrJehCYDBI/XYJcm+r5fLetFChA/Zm6sSUx8nt+6Sls1u0yDhvK
         0fv+ks1ydEyHGscmiR0WIqPa45uy05zRy35gjhpw9EipDTKYAoBPGkx0T9RJxFioAq+C
         xyc5I+YMgsCtnVcUAR1mdo0rU5YHtjcm30ly96O63BEa1/51DxnZSEsgxYtXaIOYLQUj
         5JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696571; x=1692301371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHgHVPT9NJJEy57ofYCBRT0494lyChFydr7q0MZfbDM=;
        b=Zf7weoupnpvI6xBwEaQQrFtnXUKa1+a++E6Sx+2g1e7uHxtVg930chz42xaZO/4MSp
         7i0l9B+FhSMibZWwFDHm5mwdHG585FMV8gacUD71d1DjInWduRP7KhIKT4OS4Si/N7ht
         XjUh8gZbPp6Un8duZj9OS9ZOUw7YXnWjKPkDUHwWpkju5vg+y3uCWJQwSR+lkucf4m3A
         sqXboKJMaBwq1Twce/t05DSd/EQk+NsJD/2Zpp1XrM+II50rCj39Yjj3haEClODqxgFI
         HxBRuynNxz79fQ0OJkNZtGxtpdT18W8s7feRpuKTAUGRj/xGiYszLTfyDAGSOY/7G+L7
         lENA==
X-Gm-Message-State: AOJu0Yy+QZr1fcwl5KokymJBXweCMB6dstpIatpBCkOj8/lRRAw6UDmE
        +vs2jtqhH7/eH3kTpK6soq15TkpWoTeZv2qW
X-Google-Smtp-Source: AGHT+IElI7WnV4jymqSi3ldp58oFJIRROONACswY8mZRhfd8D8YNuHuxF+b8gvA+v2diFXbzs4osjw==
X-Received: by 2002:a05:6000:1372:b0:315:a32d:311a with SMTP id q18-20020a056000137200b00315a32d311amr2912668wrz.2.1691696571101;
        Thu, 10 Aug 2023 12:42:51 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d4d08000000b003178dc2371bsm3077905wrt.7.2023.08.10.12.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:42:50 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     matt.hsiao@hpe.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: hpilo: make ilo_class a static const structure
Date:   Thu, 10 Aug 2023 23:42:39 +0400
Message-Id: <20230810194239.26892-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the ilo_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/misc/hpilo.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 2fde8d63c5fe..f1b74d3f8958 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -25,7 +25,9 @@
 #include <linux/slab.h>
 #include "hpilo.h"
 
-static struct class *ilo_class;
+static const struct class ilo_class = {
+	.name = "iLO",
+};
 static unsigned int ilo_major;
 static unsigned int max_ccb = 16;
 static char ilo_hwdev[MAX_ILO_DEV];
@@ -746,7 +748,7 @@ static void ilo_remove(struct pci_dev *pdev)
 
 	minor = MINOR(ilo_hw->cdev.dev);
 	for (i = minor; i < minor + max_ccb; i++)
-		device_destroy(ilo_class, MKDEV(ilo_major, i));
+		device_destroy(&ilo_class, MKDEV(ilo_major, i));
 
 	cdev_del(&ilo_hw->cdev);
 	ilo_disable_interrupts(ilo_hw);
@@ -839,7 +841,7 @@ static int ilo_probe(struct pci_dev *pdev,
 
 	for (minor = 0 ; minor < max_ccb; minor++) {
 		struct device *dev;
-		dev = device_create(ilo_class, &pdev->dev,
+		dev = device_create(&ilo_class, &pdev->dev,
 				    MKDEV(ilo_major, minor), NULL,
 				    "hpilo!d%dccb%d", devnum, minor);
 		if (IS_ERR(dev))
@@ -882,11 +884,9 @@ static int __init ilo_init(void)
 	int error;
 	dev_t dev;
 
-	ilo_class = class_create("iLO");
-	if (IS_ERR(ilo_class)) {
-		error = PTR_ERR(ilo_class);
+	error = class_register(&ilo_class);
+	if (error)
 		goto out;
-	}
 
 	error = alloc_chrdev_region(&dev, 0, MAX_OPEN, ILO_NAME);
 	if (error)
@@ -902,7 +902,7 @@ static int __init ilo_init(void)
 chr_remove:
 	unregister_chrdev_region(dev, MAX_OPEN);
 class_destroy:
-	class_destroy(ilo_class);
+	class_unregister(&ilo_class);
 out:
 	return error;
 }
@@ -911,7 +911,7 @@ static void __exit ilo_exit(void)
 {
 	pci_unregister_driver(&ilo_driver);
 	unregister_chrdev_region(MKDEV(ilo_major, 0), MAX_OPEN);
-	class_destroy(ilo_class);
+	class_unregister(&ilo_class);
 }
 
 MODULE_VERSION("1.5.0");
-- 
2.34.1

