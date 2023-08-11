Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F88778834
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHKHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHKHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:30:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497726AB;
        Fri, 11 Aug 2023 00:30:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3177b6bd875so341690f8f.0;
        Fri, 11 Aug 2023 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739049; x=1692343849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEv32t7KuKnu76Su3ZwHlZ7/4J+m/5lEE/A/fA+qZ2A=;
        b=WoikOm6gDp+Ujph37rerOPX3aCCabmlsmOt0bCgYsi/2MOMm3R2H8Ush0vUy5pHBz+
         IMHvpp1p/HTLky0laHymHDBcAi789kAKtyimYdH9W1LEIzHCwq3ZL6GjtflxIPBEKpjp
         0jUYUBF80ydmUh4PzHUys5UvTkXNTHpEBZQW2NnVph+0pFBFbKmRrLEftNntQxKII624
         PUEQw/vmhpMRSxi6zuzXsJAGT/VFQi3io050YBo4/kKAXTewZT6xek2SxNze8yCEfRha
         gHNXWnGhV9bwsPwkJ6fcOdIfEksECpVrkjlCtDTc4CLW7TychIK3DFTJZ2j6ZcUmbGfh
         AR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739049; x=1692343849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEv32t7KuKnu76Su3ZwHlZ7/4J+m/5lEE/A/fA+qZ2A=;
        b=ERFf5UmcT11uV3cEBMvnEpqwKLIFr5tH2LZdjY6KfWapkwAoeGcbN0epnjMEQjvKVJ
         lACggzcFsjn/NN8bZflrS1LqOVoQra2VNk+W2geVwxVVLPnuxEjt7/W+Ab2Zl9b7QI5x
         ELu/Mc0696oK1jVv0qn7UU/t23eC2natIEwhSqfdQeebOh69BkxZq32pcfavImaFt6jB
         7K+0m87lMXF/AJdTkWB5cteQNM1o5quoiOtsJDzduc3h6kmA/fbPQYNZRiYBqkaNdRsH
         piwpl+u2/zlbzR0GDaHThGLPjPM+eVB0Y73vchObLlIhuHdz6+5tkPl42ETDDxVqQ6ny
         NJKw==
X-Gm-Message-State: AOJu0Yy0EPtusmbtW6uv1oh+TeBdX1BL4HdDMG0ZG/mesziZCSeiH3iq
        YUntxJ9LvyLiefaN54EELBo=
X-Google-Smtp-Source: AGHT+IHa3EN/O3/q/fpx0gijThR+U/oOfEpqtBFXq8Ryw8OyDO9VM94WW+yZOIXKae/vKSBahROtYA==
X-Received: by 2002:a5d:4391:0:b0:317:5de0:8ba8 with SMTP id i17-20020a5d4391000000b003175de08ba8mr722915wrq.1.1691739049449;
        Fri, 11 Aug 2023 00:30:49 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm4510166wrr.44.2023.08.11.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:30:49 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 2/3] fpga: fpga-mgr: make fpga_mgr_class a static const structure
Date:   Fri, 11 Aug 2023 11:30:42 +0400
Message-Id: <20230811073043.52808-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
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
 drivers/fpga/fpga-mgr.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index eb583f86a0b9..06651389c592 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -19,7 +19,7 @@
 #include <linux/highmem.h>
 
 static DEFINE_IDA(fpga_mgr_ida);
-static struct class *fpga_mgr_class;
+static const struct class fpga_mgr_class;
 
 struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
@@ -693,7 +693,7 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
+	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
 						   fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
@@ -713,7 +713,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(fpga_mgr_class, node);
+	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -809,7 +809,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	mgr->priv = info->priv;
 	mgr->compat_id = info->compat_id;
 
-	mgr->dev.class = fpga_mgr_class;
+	mgr->dev.class = &fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = parent;
 	mgr->dev.of_node = parent->of_node;
@@ -967,23 +967,22 @@ static void fpga_mgr_dev_release(struct device *dev)
 	kfree(mgr);
 }
 
+static const struct class fpga_mgr_class = {
+	.name = "fpga_manager",
+	.dev_groups = fpga_mgr_groups,
+	.dev_release = fpga_mgr_dev_release,
+};
+
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

