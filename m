Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA41B7DFF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjKCGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:48 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86A1B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:42 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5786A20235;
        Fri,  3 Nov 2023 14:15:40 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992140;
        bh=gMOtRmTdZKiT17CY+VYm9GvQ641VhOnLGRnNlkCuGwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XZs4h8UbvvAYE97E+7Fsk/JgsmsXEo7Ih0IzeDoIw8NGNVrdIi234MrwI+ZXnqUX3
         oUUat3f25yVPuAKyClcmDojd7I/yCowQkySkXmmvWNP5gO5xIuuyfhrvn0zzFMiBsJ
         CUz0Yo0GNK0M09QdftdYS3pmzGbnFLiw/fHHpQRjGLiwwxEBRIGa3n3kUcaGI+pNv7
         EWOCRucSNmIJPDxyC4zxe9fy19s1JgdLLV7HT4K9udWPaVcYoxR78uYWYG0UY+JGRO
         39WZmGBbBDJU7fIOBtj28+dx/BQpzleRYtvRmSeoaqVICZxEt+j5yxzIMQkWsH0W0V
         5PnhydiC9df0w==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 04/10] ipmi: kcs_bmc: Make remove_device() callback return void
Date:   Fri,  3 Nov 2023 16:45:16 +1030
Message-Id: <20231103061522.1268637-5-andrew@codeconstruct.com.au>
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

Don't pretend there's a valid failure path when there's not.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.c           | 12 ++----------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c |  6 ++----
 drivers/char/ipmi/kcs_bmc_client.h    |  2 +-
 drivers/char/ipmi/kcs_bmc_serio.c     |  6 ++----
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 1a827db8a465..5a3f199241d2 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -135,15 +135,11 @@ EXPORT_SYMBOL(kcs_bmc_add_device);
 void kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_driver *drv;
-	int rc;
 
 	mutex_lock(&kcs_bmc_lock);
 	list_del(&kcs_bmc->entry);
 	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
-		rc = drv->ops->remove_device(kcs_bmc);
-		if (rc)
-			dev_err(kcs_bmc->dev, "Failed to remove chardev for KCS channel %d: %d",
-				kcs_bmc->channel, rc);
+		drv->ops->remove_device(kcs_bmc);
 	}
 	mutex_unlock(&kcs_bmc_lock);
 }
@@ -169,15 +165,11 @@ EXPORT_SYMBOL(kcs_bmc_register_driver);
 void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
 {
 	struct kcs_bmc_device *kcs_bmc;
-	int rc;
 
 	mutex_lock(&kcs_bmc_lock);
 	list_del(&drv->entry);
 	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
-		rc = drv->ops->remove_device(kcs_bmc);
-		if (rc)
-			dev_err(kcs_bmc->dev, "Failed to remove driver for KCS channel %d: %d",
-				kcs_bmc->channel, rc);
+		drv->ops->remove_device(kcs_bmc);
 	}
 	mutex_unlock(&kcs_bmc_lock);
 }
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index cf670e891966..0552a07d6775 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -512,7 +512,7 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 	return 0;
 }
 
-static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
+static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_ipmi *priv = NULL, *pos;
 
@@ -527,7 +527,7 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 	spin_unlock_irq(&kcs_bmc_ipmi_instances_lock);
 
 	if (!priv)
-		return -ENODEV;
+		return;
 
 	misc_deregister(&priv->miscdev);
 	kcs_bmc_disable_device(priv->client.dev, &priv->client);
@@ -535,8 +535,6 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 	devm_kfree(kcs_bmc->dev, priv->data_out);
 	devm_kfree(kcs_bmc->dev, priv->data_in);
 	devm_kfree(kcs_bmc->dev, priv);
-
-	return 0;
 }
 
 static const struct kcs_bmc_driver_ops kcs_bmc_ipmi_driver_ops = {
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
index 814ad8e052ef..1c0df184860d 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/drivers/char/ipmi/kcs_bmc_client.h
@@ -10,7 +10,7 @@
 
 struct kcs_bmc_driver_ops {
 	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
-	int (*remove_device)(struct kcs_bmc_device *kcs_bmc);
+	void (*remove_device)(struct kcs_bmc_device *kcs_bmc);
 };
 
 struct kcs_bmc_driver {
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 1793358be782..0320ea974e03 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -103,7 +103,7 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
 	return 0;
 }
 
-static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
+static void kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_serio *priv = NULL, *pos;
 
@@ -118,7 +118,7 @@ static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
 	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
 
 	if (!priv)
-		return -ENODEV;
+		return;
 
 	/* kfree()s priv->port via put_device() */
 	serio_unregister_port(priv->port);
@@ -127,8 +127,6 @@ static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
 	kcs_bmc_disable_device(kcs_bmc, &priv->client);
 
 	devm_kfree(priv->client.dev->dev, priv);
-
-	return 0;
 }
 
 static const struct kcs_bmc_driver_ops kcs_bmc_serio_driver_ops = {
-- 
2.39.2

