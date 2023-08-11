Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6796B778835
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjHKHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjHKHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:30:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FD26AB;
        Fri, 11 Aug 2023 00:30:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so3336615e9.0;
        Fri, 11 Aug 2023 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739051; x=1692343851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDYVwSVB6NZ2unwDki7gCfr1BW56LAuUdkJUooc7tzg=;
        b=NZeUjpKtHs7KtIaGLddTphxLla2HHFwXcf2ZVG/9hwDqf2yqybFFdhiYQL00WBpbKK
         YnN6iRxHFCBfXrS7GnX6v1nD/i3smaPnuRLUBQkniuKw8Pz0tK4f3OHHPM0zP6QVYQF2
         EMJmWSRTNSvq9Y/pyvNEz/gsFE41YHacHSwD4EZe4pbBJfJUyr+Y5O3BLFYR678tzMCS
         CsFdqSxV0wC3xAL0lTExP9T9nsTD0eoF6lugad21aw368ekZeC/kOCEEDGNobHa2deJS
         UlBsV/xOr719HjaQEpOvPn+PF3PP003iJ77eyn9ervYKnXDaeTeRyjY4HSiEH+RhoIDj
         pm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739051; x=1692343851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDYVwSVB6NZ2unwDki7gCfr1BW56LAuUdkJUooc7tzg=;
        b=VQg97Ok0L45jJuB2QGW5+rZ9QF6XXkSaT7i3+XWGPmrkvRBqoHwgpBof4GppBa4ief
         iI3FuJaR0QbyI/QOtO+FUYtTw/S1zAaEl6Z0QFlnKTdH3WZzi87Q+mMz2RffcKU4J2Oe
         AwA6F+MeFuLtKX0keJ6k5dahobnRV186pJKvUjhAHgDwg2KTdb2Do9soJeO7uTE5XJk0
         3prFu0px73QPw9Kv6hzM0fSotJpch9+MYofgL2HhDYsy3uAZDhyoL9mg8bLivF8rYf/C
         FO9SeW52G5wHxZLGFPOfGlOeqtKpNXfn+lGrrlcZhoMFjAWreQuoTFCaNo4mfK/PCkXL
         PKyA==
X-Gm-Message-State: AOJu0YxdU5/3cDNQBusSABEpaGIXz1pJlENb7FOtXuJc1gFkTCpbYGON
        iS1ljKkrkJwlGVEneCBBqKs=
X-Google-Smtp-Source: AGHT+IH9uaa6k5ZXUcXSkHCA7jIh5J4NDAAiPXLOPJnXtc0SigJsqD9YUIMse2W9KQRlVU387auhnA==
X-Received: by 2002:adf:fe0b:0:b0:317:3d36:b2c1 with SMTP id n11-20020adffe0b000000b003173d36b2c1mr625690wrr.7.1691739050965;
        Fri, 11 Aug 2023 00:30:50 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm4510166wrr.44.2023.08.11.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:30:50 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 3/3] fpga: region: make fpga_region_class a static const structure
Date:   Fri, 11 Aug 2023 11:30:43 +0400
Message-Id: <20230811073043.52808-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the fpga_region_class structure to be declared at build
time placing it into read-only memory, instead of having to be
dynamically allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/fpga/fpga-region.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ccf6fdab1360..6abd8a154047 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -16,7 +16,7 @@
 #include <linux/spinlock.h>
 
 static DEFINE_IDA(fpga_region_ida);
-static struct class *fpga_region_class;
+static const struct class fpga_region_class;
 
 struct fpga_region *
 fpga_region_class_find(struct device *start, const void *data,
@@ -24,7 +24,7 @@ fpga_region_class_find(struct device *start, const void *data,
 {
 	struct device *dev;
 
-	dev = class_find_device(fpga_region_class, start, data, match);
+	dev = class_find_device(&fpga_region_class, start, data, match);
 	if (!dev)
 		return NULL;
 
@@ -216,7 +216,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	region->dev.class = fpga_region_class;
+	region->dev.class = &fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
@@ -287,25 +287,24 @@ static void fpga_region_dev_release(struct device *dev)
 	kfree(region);
 }
 
+static const struct class fpga_region_class = {
+	.name = "fpga_region",
+	.dev_groups = fpga_region_groups,
+	.dev_release = fpga_region_dev_release,
+};
+
 /**
  * fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
  */
 static int __init fpga_region_init(void)
 {
-	fpga_region_class = class_create("fpga_region");
-	if (IS_ERR(fpga_region_class))
-		return PTR_ERR(fpga_region_class);
-
-	fpga_region_class->dev_groups = fpga_region_groups;
-	fpga_region_class->dev_release = fpga_region_dev_release;
-
-	return 0;
+	return class_register(&fpga_region_class);
 }
 
 static void __exit fpga_region_exit(void)
 {
-	class_destroy(fpga_region_class);
+	class_unregister(&fpga_region_class);
 	ida_destroy(&fpga_region_ida);
 }
 
-- 
2.34.1

