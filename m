Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F077DFF18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjKCGQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjKCGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:54 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F31AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:48 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7D4A620239;
        Fri,  3 Nov 2023 14:15:42 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992143;
        bh=GGoKlYnNvXC2BTeqK17rcaRkc8buHyC3L9pFQJ9S1nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZJnq4a3YRZSxvojAQk9umAAuupbrSi5V7STrRJp5mmCmvT7wQCI+5IElH4GMD8D0r
         SGmdB/ug4tocPNv9AUKUP/+36S8hRF1olkq6rdWBwp+uP6xrSIpl455UblT3YJzN3N
         aNh/Oi9hE8V30J3hzE2mr8yO+BK3BWfeBWGcSaenjtsWbk2j8KIg0S79zqZc0EcPyR
         wN+xuCv1Vu0gmALBqr5SzPS5QnUmDaqlrQm5H5hscGbqVfpNmqPZGsNyu/uYGch9b8
         FRE+HN87DyNJHRC+vQHEwrXox1lI2y5jDN7aGhkTnqrbqTuX9kNDbDm8meS7unlUZP
         IOxW5OkCHBOGw==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 07/10] ipmi: kcs_bmc: Disassociate client from device lifetimes
Date:   Fri,  3 Nov 2023 16:45:19 +1030
Message-Id: <20231103061522.1268637-8-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCS client modules may be removed by actions unrelated to KCS devices.
As usual, removing a KCS client module requires unbinding all client
instances from the underlying devices to prevent further use of the code.

Previously, KCS client resource lifetimes were tied to the underlying
KCS device instance with the use of `devm_k[mz]alloc()` APIs. This
requires the use of `devm_free()` as a consequence. It's necessary to
scrutinise use of explicit `devm_free()`s because they generally
indicate there's a concerning corner-case in play, but that's not really
the case here. Switch to explicit kmalloc()/kfree() to align
expectations with the intent of the code.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 28 ++++++++++++++++++---------
 drivers/char/ipmi/kcs_bmc_serio.c     | 20 ++++++++++++-------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 45ac930172ec..98f231f24c26 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -470,7 +470,7 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 	struct kcs_bmc_ipmi *priv;
 	int rc;
 
-	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -482,26 +482,35 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 	priv->client.ops = &kcs_bmc_ipmi_client_ops;
 
 	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
-	priv->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u", DEVICE_NAME,
-					   kcs_bmc->channel);
-	if (!priv->miscdev.name)
-		return -EINVAL;
+	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, kcs_bmc->channel);
+	if (!priv->miscdev.name) {
+		rc = -ENOMEM;
+		goto cleanup_priv;
+	}
 
 	priv->miscdev.fops = &kcs_bmc_ipmi_fops;
 
 	rc = misc_register(&priv->miscdev);
 	if (rc) {
-		dev_err(kcs_bmc->dev, "Unable to register device: %d\n", rc);
-		return rc;
+		pr_err("Unable to register device: %d\n", rc);
+		goto cleanup_miscdev_name;
 	}
 
 	spin_lock_irq(&kcs_bmc_ipmi_instances_lock);
 	list_add(&priv->entry, &kcs_bmc_ipmi_instances);
 	spin_unlock_irq(&kcs_bmc_ipmi_instances_lock);
 
-	dev_info(kcs_bmc->dev, "Initialised IPMI client for channel %d", kcs_bmc->channel);
+	pr_info("Initialised IPMI client for channel %d\n", kcs_bmc->channel);
 
 	return 0;
+
+cleanup_miscdev_name:
+	kfree(priv->miscdev.name);
+
+cleanup_priv:
+	kfree(priv);
+
+	return rc;
 }
 
 static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
@@ -523,7 +532,8 @@ static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 
 	misc_deregister(&priv->miscdev);
 	kcs_bmc_disable_device(&priv->client);
-	devm_kfree(kcs_bmc->dev, priv);
+	kfree(priv->miscdev.name);
+	kfree(priv);
 }
 
 static const struct kcs_bmc_driver_ops kcs_bmc_ipmi_driver_ops = {
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 713e847bbc4e..0a68c76da955 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -71,15 +71,18 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_serio *priv;
 	struct serio *port;
+	int rc;
 
-	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
+	if (!port) {
+		rc = -ENOMEM;
+		goto cleanup_priv;
+	}
 
 	port->id.type = SERIO_8042;
 	port->open = kcs_bmc_serio_open;
@@ -98,9 +101,14 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
 
 	serio_register_port(port);
 
-	dev_info(kcs_bmc->dev, "Initialised serio client for channel %d", kcs_bmc->channel);
+	pr_info("Initialised serio client for channel %d\n", kcs_bmc->channel);
 
 	return 0;
+
+cleanup_priv:
+	kfree(priv);
+
+	return rc;
 }
 
 static void kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
@@ -122,11 +130,9 @@ static void kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
 
 	/* kfree()s priv->port via put_device() */
 	serio_unregister_port(priv->port);
-
 	/* Ensure the IBF IRQ is disabled if we were the active client */
 	kcs_bmc_disable_device(&priv->client);
-
-	devm_kfree(priv->client.dev->dev, priv);
+	kfree(priv);
 }
 
 static const struct kcs_bmc_driver_ops kcs_bmc_serio_driver_ops = {
-- 
2.39.2

