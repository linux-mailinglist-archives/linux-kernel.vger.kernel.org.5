Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93577DFF14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKCGQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjKCGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:51 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF91B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:48 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E6FFC2023B;
        Fri,  3 Nov 2023 14:15:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992144;
        bh=PBzGQ9XdHybgB4MnC4pIf/AcZ42td+dcXGF6qrKn84c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kVCSm2a6myZWDlqnkDlsyfh8Xpz8H2fzFwLKoagVmpeuvsRxVrhOVOpR2GUYpYyqq
         6X25J916IpFiZ0Dy5MH4yhfTuPbt2/RawMfC5tuFyIpTloFKvcipogKzalPvPP98N1
         gF9l07S4s4FGiLdiOEowTxFovr+r8XV7YR9hekifuuDmCTiCpEoewbSaffY9DC0OCB
         voqmRIPcs72ro0wCKnjZnBpvriCInCZJ9Oy9jXLP6Q6QcA1tHqprioPOVCQFDelsZA
         KUQhmKGwn4cM5yGTNrtGjw6UEvY9S+X6Cd4xWcetNnoyjqJNDrbT+EayEIgEvT4s6B
         0wiMCdEGOMkgQ==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 09/10] ipmi: kcs_bmc: Add module_kcs_bmc_driver()
Date:   Fri,  3 Nov 2023 16:45:21 +1030
Message-Id: <20231103061522.1268637-10-andrew@codeconstruct.com.au>
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

Remove some cruft in the client modules by adding the usual module macro
for the KCS subsystem.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.c           |  4 +++-
 drivers/char/ipmi/kcs_bmc.h           |  1 +
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 15 +--------------
 drivers/char/ipmi/kcs_bmc_client.h    |  7 ++++++-
 drivers/char/ipmi/kcs_bmc_serio.c     | 15 +--------------
 5 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 203cb73faa91..c69eb671d9d0 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -174,7 +174,7 @@ void kcs_bmc_remove_device(struct kcs_bmc_device *dev)
 }
 EXPORT_SYMBOL(kcs_bmc_remove_device);
 
-void kcs_bmc_register_driver(struct kcs_bmc_driver *drv)
+int kcs_bmc_register_driver(struct kcs_bmc_driver *drv)
 {
 	struct kcs_bmc_client *client;
 	struct kcs_bmc_device *dev;
@@ -191,6 +191,8 @@ void kcs_bmc_register_driver(struct kcs_bmc_driver *drv)
 		list_add(&client->entry, &kcs_bmc_clients);
 	}
 	mutex_unlock(&kcs_bmc_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL(kcs_bmc_register_driver);
 
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index 880d835fb90c..979d673f8f56 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -7,6 +7,7 @@
 #define __KCS_BMC_H__
 
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/spinlock.h>
 
 #define KCS_BMC_EVENT_TYPE_OBE	BIT(0)
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 9fca31f8c7c2..21d4c4c11e07 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -523,20 +523,7 @@ static struct kcs_bmc_driver kcs_bmc_ipmi_driver = {
 	.ops = &kcs_bmc_ipmi_driver_ops,
 };
 
-static int __init kcs_bmc_ipmi_init(void)
-{
-	kcs_bmc_register_driver(&kcs_bmc_ipmi_driver);
-
-	return 0;
-}
-module_init(kcs_bmc_ipmi_init);
-
-static void __exit kcs_bmc_ipmi_exit(void)
-{
-	kcs_bmc_unregister_driver(&kcs_bmc_ipmi_driver);
-}
-module_exit(kcs_bmc_ipmi_exit);
-
+module_kcs_bmc_driver(kcs_bmc_ipmi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
index 1c6c812d6edc..afc9e71c9fc0 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/drivers/char/ipmi/kcs_bmc_client.h
@@ -5,6 +5,7 @@
 #define __KCS_BMC_CONSUMER_H__
 
 #include <linux/irqreturn.h>
+#include <linux/module.h>
 
 #include "kcs_bmc.h"
 
@@ -44,9 +45,13 @@ struct kcs_bmc_driver {
 	const struct kcs_bmc_driver_ops *ops;
 };
 
-void kcs_bmc_register_driver(struct kcs_bmc_driver *drv);
+int kcs_bmc_register_driver(struct kcs_bmc_driver *drv);
 void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv);
 
+#define module_kcs_bmc_driver(__kcs_bmc_driver) \
+	module_driver(__kcs_bmc_driver, kcs_bmc_register_driver, \
+		kcs_bmc_unregister_driver)
+
 int kcs_bmc_enable_device(struct kcs_bmc_client *client);
 void kcs_bmc_disable_device(struct kcs_bmc_client *client);
 u8 kcs_bmc_read_data(struct kcs_bmc_client *client);
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 3cfda39506f6..8bb598c2aa38 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -123,20 +123,7 @@ static struct kcs_bmc_driver kcs_bmc_serio_driver = {
 	.ops = &kcs_bmc_serio_driver_ops,
 };
 
-static int __init kcs_bmc_serio_init(void)
-{
-	kcs_bmc_register_driver(&kcs_bmc_serio_driver);
-
-	return 0;
-}
-module_init(kcs_bmc_serio_init);
-
-static void __exit kcs_bmc_serio_exit(void)
-{
-	kcs_bmc_unregister_driver(&kcs_bmc_serio_driver);
-}
-module_exit(kcs_bmc_serio_exit);
-
+module_kcs_bmc_driver(kcs_bmc_serio_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
 MODULE_DESCRIPTION("Adapter driver for serio access to BMC KCS devices");
-- 
2.39.2

