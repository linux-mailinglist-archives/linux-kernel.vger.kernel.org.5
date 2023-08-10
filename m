Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2009777F08
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjHJRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjHJRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:22:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6272703;
        Thu, 10 Aug 2023 10:22:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe23319695so2964105e9.0;
        Thu, 10 Aug 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691688136; x=1692292936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUkVfj1binUFozuuQWoj/J/2JLdAkHVM+D4B3rrCqkQ=;
        b=DcU4u17CaNyy4zJcoaL5UM/WcjQKHjz/kTfR1Q+qEjUEqnJ4sBoYZbEiN0JA7vhRlO
         wNKcYNJ+WkojZtAlimX1QODizT1EEA2RhgVVJCp5JMu4xKNB7haIAJk6mQTCZE2sgOvv
         /YMYG+7bZUgh5mYcOm2Ml1x8c0/59HoYsKgzonXSKXEg8s2DzOJAh5AdTJXOqI1g5Tuy
         tdmtw+xrWl9oqLjZjLmMeEldsYlJNoZWfbW14q3Bed5jCo8RPkJmaiKLWBep/rrKtvj5
         dxJt5BZkhALjWX1UylNvYnq2/5ARAoWFjQUElWIuo3sLx7UDfOdboGB9rQNSMgSxfeYo
         PWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688136; x=1692292936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUkVfj1binUFozuuQWoj/J/2JLdAkHVM+D4B3rrCqkQ=;
        b=hEyikYPBaJfSAeJVdICqlO7hxW1somkovPdLAVlod6RgM02o8dpBwOEuCKe0d0AA04
         edhdc17OqGW++r+2sWANXea1dxsjinBYG9tQQ/laT/83YLRZntyDlY9G0ixrpZzg76s4
         yl3fsj5DwvppGK9x2PVoXctG33Llb2mLv4pvnnAoZF2+1ktS+TV0A5MKeYqbX7RCDHPP
         uE8vL+VsBneEX+b6LICswg63nCzxmYmS5FBKZnfMzaPzKGKR5hnUcUyBm+otrberAu5F
         rIN27LfXzx1hyDMHpUPM9QWx82y7S63DhhhEVBkI+dwB5tCL2AjqeljrP1lh9QpdyuYC
         Sf9Q==
X-Gm-Message-State: AOJu0Yy9DmOLSlbFWCHn/scsWf5VKAnUrRPmuzaS4RyB1KiphY8A5njV
        IGWH5CB+CtL4w/xbN88iPKs=
X-Google-Smtp-Source: AGHT+IF2bT6kBNAZQzdpOj+Zxk6lsZUXXFKxgglE41K99VWrzVB6IYoMKBS6j5vWMdO0e6YKRz3HLg==
X-Received: by 2002:adf:d087:0:b0:317:630d:1e8e with SMTP id y7-20020adfd087000000b00317630d1e8emr2468569wrh.2.1691688136392;
        Thu, 10 Aug 2023 10:22:16 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm2715754wrp.93.2023.08.10.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:22:16 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/3] fpga: fpga-mgr: make fpga_mgr_class a static const structure
Date:   Thu, 10 Aug 2023 21:22:09 +0400
Message-Id: <20230810172210.6338-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the fpga_mgr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/fpga/fpga-mgr.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index eb583f86a0b9..cd5b7371495b 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -19,7 +19,6 @@
 #include <linux/highmem.h>
 
 static DEFINE_IDA(fpga_mgr_ida);
-static struct class *fpga_mgr_class;
 
 struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
@@ -664,6 +663,20 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
+static void fpga_mgr_dev_release(struct device *dev)
+{
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	ida_free(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
+}
+
+static const struct class fpga_mgr_class = {
+	.name = "fpga_manager",
+	.dev_groups = fpga_mgr_groups,
+	.dev_release = fpga_mgr_dev_release,
+};
+
 static struct fpga_manager *__fpga_mgr_get(struct device *dev)
 {
 	struct fpga_manager *mgr;
@@ -693,7 +706,7 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
+	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
 						   fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
@@ -713,7 +726,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(fpga_mgr_class, node);
+	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -809,7 +822,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	mgr->priv = info->priv;
 	mgr->compat_id = info->compat_id;
 
-	mgr->dev.class = fpga_mgr_class;
+	mgr->dev.class = &fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = parent;
 	mgr->dev.of_node = parent->of_node;
@@ -959,31 +972,16 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
-static void fpga_mgr_dev_release(struct device *dev)
-{
-	struct fpga_manager *mgr = to_fpga_manager(dev);
-
-	ida_free(&fpga_mgr_ida, mgr->dev.id);
-	kfree(mgr);
-}
-
 static int __init fpga_mgr_class_init(void)
 {
 	pr_info("FPGA manager framework\n");
 
-	fpga_mgr_class = class_create("fpga_manager");
-	if (IS_ERR(fpga_mgr_class))
-		return PTR_ERR(fpga_mgr_class);
-
-	fpga_mgr_class->dev_groups = fpga_mgr_groups;
-	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
-
-	return 0;
+	return class_register(&fpga_mgr_class);
 }
 
 static void __exit fpga_mgr_class_exit(void)
 {
-	class_destroy(fpga_mgr_class);
+	class_unregister(&fpga_mgr_class);
 	ida_destroy(&fpga_mgr_ida);
 }
 
-- 
2.34.1

