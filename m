Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02177E584
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjHPPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjHPPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:45:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6882708
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:45:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso5730838a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692200732; x=1692805532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALFYlgXP19h+jNDGmhGhnbO/hS5Sm/mDypmguRP2npI=;
        b=plSat8b+T6+hVO2umpz6n9y9gbM861T15Vi+WvJQMhqQsnkK5GpQBramSGZyQHvcs6
         5qCmFD3fIE+PcxJShlxOdtBFYA+z1TMLiS3D9VrCb1uRNpTCNA25l/LI+7261jSVagbE
         p0cySMTWmrrejk1JI47xgtV5zL68MSqTYHOlMFKHB2++c87dVIEZZcVawMY/bVbp6DQs
         1EVEz3suYiXPCDsCcS+LiyVU4qtxpmC5NSIw7GmmET18P87+B3vHb0ycVHsVX0SxTdwa
         qphFQyBf2W2V7i9rBwggU3Q1MyriMUFNiAQcAI6tGFuJCmBK3dx/JiPpzK4/Pm7Stqa8
         enyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200732; x=1692805532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALFYlgXP19h+jNDGmhGhnbO/hS5Sm/mDypmguRP2npI=;
        b=Ya+JI8BBv/LtjQO0kyxBlKXo2nXU//fAiReTHNZyJknXUSyaJvdvJdhjZNo95QLe7n
         Pwo+6wspR/FATVVTMuyrKLWyWMW4PTTWWA9yKuzLwnfvWt/IqwM51IWmLBlt2X6/JHwm
         u4Ngdsz+EqUekzp4v7gAZ08iegOgd5LqlwAmm1gOH8nfEC5JS3FdGrnen7ZsIXrgunaH
         D40mf/Kzjkn8vsaZWxELtWYc+oFnzORMSnbetdWoLsm5ZjW0zd/vIqkIsOVCo8xye5PV
         ugWTBpv8aOpCNFLYmlrhpnt5qw7xFct9+ttVoNeSph50KiIVz2F5LkQ9BztwHxhtxKIM
         7A/Q==
X-Gm-Message-State: AOJu0YyH+kvWYuGZkFH2GdTApWyy4CRKeaQEA1/w/vKkYrjsyy/ZG9T6
        R2yy21mSrcWYVZjnU6d56Uh++BGEKZA=
X-Google-Smtp-Source: AGHT+IH5wpTtuB7Q6izVEQNiXsqFHEuxy1aeFGARgCs89DlZlbT1+A/rM0qoKl9+zJAjSGHbyh/yuw==
X-Received: by 2002:a9d:4817:0:b0:6b9:37e2:76fc with SMTP id c23-20020a9d4817000000b006b937e276fcmr2355461otf.30.1692200732192;
        Wed, 16 Aug 2023 08:45:32 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id j12-20020a9d7f0c000000b006b83a36c08bsm6206712otq.53.2023.08.16.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:45:31 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] driver core: shut down devices asynchronously
Date:   Wed, 16 Aug 2023 10:45:18 -0500
Message-Id: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to shut down devices asynchronously, by making a tree of devices with
associated work and completion structs, to ensure that child devices are shut
down before parents.

This can dramatically reduce system shutdown/reboot time on systems that have
devices that take many seconds to shut down, such as some NVMe drives.  On once
system tested, the shutdown time went from 11 minutes before the patch to 55
seconds with the patch.

The code could be simplified by adding the work and completion structs to
struct device, but it may make more sense to not burden it with that when there
is likely enough memory to allocate this at shutdown time, and if there isn’t,
it just falls back to the current synchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/base/core.c | 216 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 189 insertions(+), 27 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..fec571f56843 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4709,6 +4709,187 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static void shutdown_device(struct device *dev, struct device *parent)
+{
+	/* hold lock to avoid race with probe/release */
+	if (parent)
+		device_lock(parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+}
+
+struct shutdown_work {
+	struct list_head node;
+	struct device *dev;
+	struct work_struct work;
+	struct completion complete;
+	struct list_head children;
+};
+
+void shutdown_dev_work(struct work_struct *work)
+{
+	struct shutdown_work *sd_work = container_of(work, struct shutdown_work, work);
+	struct shutdown_work *child_sd_work;
+	struct device *dev = sd_work->dev;
+
+	/*
+	 * wait for child devices to finish shutdown
+	 */
+	list_for_each_entry(child_sd_work, &sd_work->children, node) {
+		wait_for_completion(&child_sd_work->complete);
+	}
+
+	if (dev) {
+		/*
+		 * Make sure the device is off the kset list, in the
+		 * event that dev->*->shutdown() doesn't remove it.
+		 */
+		spin_lock(&devices_kset->list_lock);
+		list_del_init(&dev->kobj.entry);
+		spin_unlock(&devices_kset->list_lock);
+
+		shutdown_device(dev, dev->parent);
+	}
+
+	complete(&sd_work->complete);
+}
+
+static void schedule_shutdown_work(struct shutdown_work *dev_shutdown_work)
+{
+	struct shutdown_work *child;
+
+	/*
+	 * schedule children to be shutdown before parents
+	 */
+	list_for_each_entry(child, &dev_shutdown_work->children, node) {
+		schedule_shutdown_work(child);
+	}
+
+	schedule_work(&dev_shutdown_work->work);
+}
+
+static void free_shutdown_tree(struct shutdown_work *tree)
+{
+	struct shutdown_work *childitem, *tmp;
+
+	if (tree) {
+		list_for_each_entry_safe(childitem, tmp, &tree->children, node) {
+			put_device(childitem->dev);
+			list_del(&childitem->node);
+			free_shutdown_tree(childitem);
+		}
+		kfree(tree);
+	}
+}
+
+static struct shutdown_work *create_shutdown_tree(struct device *dev,
+						  struct shutdown_work *parent)
+{
+	struct klist_iter i;
+	struct shutdown_work *dev_sdwork;
+	int error = 0;
+
+	/*
+	 * alloc & init shutdown_work for this device
+	 */
+	dev_sdwork = kzalloc(sizeof(*dev_sdwork), GFP_KERNEL);
+	if (!dev_sdwork)
+		goto fail;
+
+	if (dev) {
+		dev_sdwork->dev = dev;
+		get_device(dev);
+	}
+	INIT_WORK(&dev_sdwork->work, shutdown_dev_work);
+	INIT_LIST_HEAD(&dev_sdwork->children);
+	INIT_LIST_HEAD(&dev_sdwork->node);
+	init_completion(&dev_sdwork->complete);
+
+	if (parent) {
+		/*
+		 * add shutdown_work for a device's children
+		 */
+		klist_iter_init(&dev_sdwork->dev->p->klist_children, &i);
+		while (!error && (dev = next_device(&i)))
+			error = !create_shutdown_tree(dev, dev_sdwork);
+		klist_iter_exit(&i);
+
+		if (error)
+			goto fail;
+
+		list_add_tail(&dev_sdwork->node, &parent->children);
+		return dev_sdwork;
+	}
+
+	/*
+	 * add shutdown_work for top level devices
+	 */
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_entry(dev, &devices_kset->list, kobj.entry) {
+		if (!dev->parent)
+			error = !create_shutdown_tree(dev, dev_sdwork);
+		if (error)
+			break;
+	}
+	spin_unlock(&devices_kset->list_lock);
+
+	if (error)
+		goto fail;
+
+	return dev_sdwork;
+
+fail:
+	free_shutdown_tree(dev_sdwork);
+	return NULL;
+}
+
+/**
+ * device_shutdown_async - schedule ->shutdown() on each device to shutdown
+ * asynchronously, ensuring each device's children are shut down before
+ * shutting down the device
+ */
+static int device_shutdown_async(void)
+{
+	struct shutdown_work *shutdown_work_tree;
+
+	/*
+	 * build tree with devices to be shut down
+	 */
+	shutdown_work_tree = create_shutdown_tree(NULL, NULL);
+	if (!shutdown_work_tree)
+		return -ENOMEM;
+
+	/*
+	 * schedule the work to run & wait for it to finish
+	 */
+	schedule_shutdown_work(shutdown_work_tree);
+	wait_for_completion(&shutdown_work_tree->complete);
+	free_shutdown_tree(shutdown_work_tree);
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4721,6 +4902,13 @@ void device_shutdown(void)
 
 	cpufreq_suspend();
 
+	if (initcall_debug)
+		pr_info("attempting asynchronous device shutdown\n");
+	if (!device_shutdown_async())
+		return;
+	if (initcall_debug)
+		pr_info("starting synchronous device shutdown\n");
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
@@ -4745,33 +4933,7 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
+		shutdown_device(dev, parent);
 
 		put_device(dev);
 		put_device(parent);
-- 
2.39.3

