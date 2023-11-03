Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7751B7DFF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjKCGQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKCGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:54 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4C1B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:48 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 396D22023A;
        Fri,  3 Nov 2023 14:15:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992143;
        bh=L7oKznO+QKSLgY6R8VCPalDfz9KTRfbux02CIZeP4js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UD7u725uFAOf/mmSOXBf/4JdTnF52QsZK+rN4Ab6LlOISnaaQ/srVoodkt/v4dcer
         p/8dOypXD0wZ34TYEkkgJhqI9V0tgu7v9Jya0rhgJCAyCYYahMqse/ekOhBXV1j59j
         6hKYcP62E4ZmwJAlTTXqj9unlS+XPJG0J554qM0xTho/sZpEQFapGdgc9GcK6E1otW
         /kXucfmwp5Nbdb5LcuNe4YUYhoqckka5zo/d4RnN1BCHehZ4pa8C4nmhOODps+EwXO
         3oUO/ln6J7teRXYAa3qRDywjXk/FbMUJCEfnM4cRGJR1hslD+oVOaEpUF1dkJT5S6s
         /6J/NoSvE8QLA==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 08/10] ipmi: kcs_bmc: Track clients in core
Date:   Fri,  3 Nov 2023 16:45:20 +1030
Message-Id: <20231103061522.1268637-9-andrew@codeconstruct.com.au>
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

I ran out of spoons before I could come up with a better client tracking
scheme back in the original refactoring series:

https://lore.kernel.org/all/20210608104757.582199-1-andrew@aj.id.au/

Jonathan prodded Konstantin about the issue in a review of Konstantin's
MCTP patches[1], prompting an attempt to clean it up.

[1]: https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com/

Prevent client modules from having to track their own instances by
requiring they return a pointer to a client object from their
add_device() implementation. We can then track this in the core, and
provide it as the argument to the remove_device() implementation to save
the client module from further work. The usual container_of() pattern
gets the client module access to its private data.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.c           | 68 ++++++++++++++++-----------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 42 ++++-------------
 drivers/char/ipmi/kcs_bmc_client.h    | 35 ++++++++++----
 drivers/char/ipmi/kcs_bmc_device.h    |  4 +-
 drivers/char/ipmi/kcs_bmc_serio.c     | 43 +++++------------
 5 files changed, 88 insertions(+), 104 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index d70e503041bd..203cb73faa91 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -19,6 +19,7 @@
 static DEFINE_MUTEX(kcs_bmc_lock);
 static LIST_HEAD(kcs_bmc_devices);
 static LIST_HEAD(kcs_bmc_drivers);
+static LIST_HEAD(kcs_bmc_clients);
 
 /* Consumer data access */
 
@@ -129,25 +130,27 @@ void kcs_bmc_disable_device(struct kcs_bmc_client *client)
 }
 EXPORT_SYMBOL(kcs_bmc_disable_device);
 
-int kcs_bmc_add_device(struct kcs_bmc_device *kcs_bmc)
+int kcs_bmc_add_device(struct kcs_bmc_device *dev)
 {
+	struct kcs_bmc_client *client;
 	struct kcs_bmc_driver *drv;
 	int error = 0;
-	int rc;
 
-	spin_lock_init(&kcs_bmc->lock);
-	kcs_bmc->client = NULL;
+	spin_lock_init(&dev->lock);
+	dev->client = NULL;
 
 	mutex_lock(&kcs_bmc_lock);
-	list_add(&kcs_bmc->entry, &kcs_bmc_devices);
+	list_add(&dev->entry, &kcs_bmc_devices);
 	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
-		rc = drv->ops->add_device(kcs_bmc);
-		if (!rc)
-			continue;
-
-		dev_err(kcs_bmc->dev, "Failed to add chardev for KCS channel %d: %d",
-			kcs_bmc->channel, rc);
-		error = rc;
+		client = drv->ops->add_device(drv, dev);
+		if (IS_ERR(client)) {
+			error = PTR_ERR(client);
+			dev_err(dev->dev,
+				"Failed to add chardev for KCS channel %d: %d",
+				dev->channel, error);
+			break;
+		}
+		list_add(&client->entry, &kcs_bmc_clients);
 	}
 	mutex_unlock(&kcs_bmc_lock);
 
@@ -155,31 +158,37 @@ int kcs_bmc_add_device(struct kcs_bmc_device *kcs_bmc)
 }
 EXPORT_SYMBOL(kcs_bmc_add_device);
 
-void kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc)
+void kcs_bmc_remove_device(struct kcs_bmc_device *dev)
 {
-	struct kcs_bmc_driver *drv;
+	struct kcs_bmc_client *curr, *tmp;
 
 	mutex_lock(&kcs_bmc_lock);
-	list_del(&kcs_bmc->entry);
-	list_for_each_entry(drv, &kcs_bmc_drivers, entry) {
-		drv->ops->remove_device(kcs_bmc);
+	list_for_each_entry_safe(curr, tmp, &kcs_bmc_clients, entry) {
+		if (curr->dev == dev) {
+			list_del(&curr->entry);
+			curr->drv->ops->remove_device(curr);
+		}
 	}
+	list_del(&dev->entry);
 	mutex_unlock(&kcs_bmc_lock);
 }
 EXPORT_SYMBOL(kcs_bmc_remove_device);
 
 void kcs_bmc_register_driver(struct kcs_bmc_driver *drv)
 {
-	struct kcs_bmc_device *kcs_bmc;
-	int rc;
+	struct kcs_bmc_client *client;
+	struct kcs_bmc_device *dev;
 
 	mutex_lock(&kcs_bmc_lock);
 	list_add(&drv->entry, &kcs_bmc_drivers);
-	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
-		rc = drv->ops->add_device(kcs_bmc);
-		if (rc)
-			dev_err(kcs_bmc->dev, "Failed to add driver for KCS channel %d: %d",
-				kcs_bmc->channel, rc);
+	list_for_each_entry(dev, &kcs_bmc_devices, entry) {
+		client = drv->ops->add_device(drv, dev);
+		if (IS_ERR(client)) {
+			dev_err(dev->dev, "Failed to add driver for KCS channel %d: %ld",
+				dev->channel, PTR_ERR(client));
+			continue;
+		}
+		list_add(&client->entry, &kcs_bmc_clients);
 	}
 	mutex_unlock(&kcs_bmc_lock);
 }
@@ -187,13 +196,16 @@ EXPORT_SYMBOL(kcs_bmc_register_driver);
 
 void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
 {
-	struct kcs_bmc_device *kcs_bmc;
+	struct kcs_bmc_client *curr, *tmp;
 
 	mutex_lock(&kcs_bmc_lock);
-	list_del(&drv->entry);
-	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
-		drv->ops->remove_device(kcs_bmc);
+	list_for_each_entry_safe(curr, tmp, &kcs_bmc_clients, entry) {
+		if (curr->drv == drv) {
+			list_del(&curr->entry);
+			drv->ops->remove_device(curr);
+		}
 	}
+	list_del(&drv->entry);
 	mutex_unlock(&kcs_bmc_lock);
 }
 EXPORT_SYMBOL(kcs_bmc_unregister_driver);
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 98f231f24c26..9fca31f8c7c2 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -71,8 +71,6 @@ enum kcs_ipmi_errors {
 #define KCS_ZERO_DATA     0
 
 struct kcs_bmc_ipmi {
-	struct list_head entry;
-
 	struct kcs_bmc_client client;
 
 	spinlock_t lock;
@@ -462,27 +460,24 @@ static const struct file_operations kcs_bmc_ipmi_fops = {
 	.unlocked_ioctl = kcs_bmc_ipmi_ioctl,
 };
 
-static DEFINE_SPINLOCK(kcs_bmc_ipmi_instances_lock);
-static LIST_HEAD(kcs_bmc_ipmi_instances);
-
-static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
+static struct kcs_bmc_client *
+kcs_bmc_ipmi_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
 {
 	struct kcs_bmc_ipmi *priv;
 	int rc;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-		return -ENOMEM;
+		return ERR_PTR(ENOMEM);
 
 	spin_lock_init(&priv->lock);
 	mutex_init(&priv->mutex);
 	init_waitqueue_head(&priv->queue);
 
-	priv->client.dev = kcs_bmc;
-	priv->client.ops = &kcs_bmc_ipmi_client_ops;
+	kcs_bmc_client_init(&priv->client, &kcs_bmc_ipmi_client_ops, drv, dev);
 
 	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
-	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, kcs_bmc->channel);
+	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, dev->channel);
 	if (!priv->miscdev.name) {
 		rc = -ENOMEM;
 		goto cleanup_priv;
@@ -496,13 +491,9 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 		goto cleanup_miscdev_name;
 	}
 
-	spin_lock_irq(&kcs_bmc_ipmi_instances_lock);
-	list_add(&priv->entry, &kcs_bmc_ipmi_instances);
-	spin_unlock_irq(&kcs_bmc_ipmi_instances_lock);
+	pr_info("Initialised IPMI client for channel %d\n", dev->channel);
 
-	pr_info("Initialised IPMI client for channel %d\n", kcs_bmc->channel);
-
-	return 0;
+	return &priv->client;
 
 cleanup_miscdev_name:
 	kfree(priv->miscdev.name);
@@ -510,25 +501,12 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 cleanup_priv:
 	kfree(priv);
 
-	return rc;
+	return ERR_PTR(rc);
 }
 
-static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
+static void kcs_bmc_ipmi_remove_device(struct kcs_bmc_client *client)
 {
-	struct kcs_bmc_ipmi *priv = NULL, *pos;
-
-	spin_lock_irq(&kcs_bmc_ipmi_instances_lock);
-	list_for_each_entry(pos, &kcs_bmc_ipmi_instances, entry) {
-		if (pos->client.dev == kcs_bmc) {
-			priv = pos;
-			list_del(&pos->entry);
-			break;
-		}
-	}
-	spin_unlock_irq(&kcs_bmc_ipmi_instances_lock);
-
-	if (!priv)
-		return;
+	struct kcs_bmc_ipmi *priv = client_to_kcs_bmc_ipmi(client);
 
 	misc_deregister(&priv->miscdev);
 	kcs_bmc_disable_device(&priv->client);
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
index 1251e9669bcd..1c6c812d6edc 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/drivers/char/ipmi/kcs_bmc_client.h
@@ -8,16 +8,7 @@
 
 #include "kcs_bmc.h"
 
-struct kcs_bmc_driver_ops {
-	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
-	void (*remove_device)(struct kcs_bmc_device *kcs_bmc);
-};
-
-struct kcs_bmc_driver {
-	struct list_head entry;
-
-	const struct kcs_bmc_driver_ops *ops;
-};
+struct kcs_bmc_driver;
 
 struct kcs_bmc_client_ops {
 	irqreturn_t (*event)(struct kcs_bmc_client *client);
@@ -26,7 +17,31 @@ struct kcs_bmc_client_ops {
 struct kcs_bmc_client {
 	const struct kcs_bmc_client_ops *ops;
 
+	struct kcs_bmc_driver *drv;
 	struct kcs_bmc_device *dev;
+	struct list_head entry;
+};
+
+struct kcs_bmc_driver_ops {
+	struct kcs_bmc_client *(*add_device)(struct kcs_bmc_driver *drv,
+					     struct kcs_bmc_device *dev);
+	void (*remove_device)(struct kcs_bmc_client *client);
+};
+
+static inline void kcs_bmc_client_init(struct kcs_bmc_client *client,
+				       const struct kcs_bmc_client_ops *ops,
+				       struct kcs_bmc_driver *drv,
+				       struct kcs_bmc_device *dev)
+{
+	client->ops = ops;
+	client->drv = drv;
+	client->dev = dev;
+}
+
+struct kcs_bmc_driver {
+	struct list_head entry;
+
+	const struct kcs_bmc_driver_ops *ops;
 };
 
 void kcs_bmc_register_driver(struct kcs_bmc_driver *drv);
diff --git a/drivers/char/ipmi/kcs_bmc_device.h b/drivers/char/ipmi/kcs_bmc_device.h
index 17c572f25c54..ca2b5dc2031d 100644
--- a/drivers/char/ipmi/kcs_bmc_device.h
+++ b/drivers/char/ipmi/kcs_bmc_device.h
@@ -16,7 +16,7 @@ struct kcs_bmc_device_ops {
 };
 
 irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc);
-int kcs_bmc_add_device(struct kcs_bmc_device *kcs_bmc);
-void kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc);
+int kcs_bmc_add_device(struct kcs_bmc_device *dev);
+void kcs_bmc_remove_device(struct kcs_bmc_device *dev);
 
 #endif
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 0a68c76da955..3cfda39506f6 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -13,8 +13,6 @@
 #include "kcs_bmc_client.h"
 
 struct kcs_bmc_serio {
-	struct list_head entry;
-
 	struct kcs_bmc_client client;
 	struct serio *port;
 
@@ -64,10 +62,8 @@ static void kcs_bmc_serio_close(struct serio *port)
 	kcs_bmc_disable_device(&priv->client);
 }
 
-static DEFINE_SPINLOCK(kcs_bmc_serio_instances_lock);
-static LIST_HEAD(kcs_bmc_serio_instances);
-
-static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
+static struct kcs_bmc_client *
+kcs_bmc_serio_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
 {
 	struct kcs_bmc_serio *priv;
 	struct serio *port;
@@ -75,12 +71,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-		return -ENOMEM;
+		return ERR_PTR(ENOMEM);
 
 	/* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
-		rc = -ENOMEM;
+		rc = ENOMEM;
 		goto cleanup_priv;
 	}
 
@@ -88,45 +84,28 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
 	port->open = kcs_bmc_serio_open;
 	port->close = kcs_bmc_serio_close;
 	port->port_data = priv;
-	port->dev.parent = kcs_bmc->dev;
+	port->dev.parent = dev->dev;
 
 	spin_lock_init(&priv->lock);
 	priv->port = port;
-	priv->client.dev = kcs_bmc;
-	priv->client.ops = &kcs_bmc_serio_client_ops;
 
-	spin_lock_irq(&kcs_bmc_serio_instances_lock);
-	list_add(&priv->entry, &kcs_bmc_serio_instances);
-	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
+	kcs_bmc_client_init(&priv->client, &kcs_bmc_serio_client_ops, drv, dev);
 
 	serio_register_port(port);
 
-	pr_info("Initialised serio client for channel %d\n", kcs_bmc->channel);
+	pr_info("Initialised serio client for channel %d\n", dev->channel);
 
-	return 0;
+	return &priv->client;
 
 cleanup_priv:
 	kfree(priv);
 
-	return rc;
+	return ERR_PTR(rc);
 }
 
-static void kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
+static void kcs_bmc_serio_remove_device(struct kcs_bmc_client *client)
 {
-	struct kcs_bmc_serio *priv = NULL, *pos;
-
-	spin_lock_irq(&kcs_bmc_serio_instances_lock);
-	list_for_each_entry(pos, &kcs_bmc_serio_instances, entry) {
-		if (pos->client.dev == kcs_bmc) {
-			priv = pos;
-			list_del(&pos->entry);
-			break;
-		}
-	}
-	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
-
-	if (!priv)
-		return;
+	struct kcs_bmc_serio *priv = client_to_kcs_bmc_serio(client);
 
 	/* kfree()s priv->port via put_device() */
 	serio_unregister_port(priv->port);
-- 
2.39.2

