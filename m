Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016057D136B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377858AbjJTQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbjJTQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A1D6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMYHGo5Ykl6Wn0M8yf0bZNH2F3mIqZDULBM08KnlTxM=;
        b=DEnqxbFL3fn47ltofID7PhrZbHBT85peFvHjN/SEZDre4Yzz722WQWYsndVmp1xhrxi+20
        Jg6yLptAcmp3ZfXz7t3OZb8sxbXGbFgayJK8Awn6CaLwhlK+2onTPV3FY+cXNgasU9VuyQ
        L/qJZdsz5LNUjzfLMneHEU+BF3JTQHg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-9ZumjUbuNZaU9A4VhoVF5g-1; Fri, 20 Oct 2023 11:58:43 -0400
X-MC-Unique: 9ZumjUbuNZaU9A4VhoVF5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89CBB29AA2CE;
        Fri, 20 Oct 2023 15:58:42 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D33710828;
        Fri, 20 Oct 2023 15:58:39 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Date:   Fri, 20 Oct 2023 17:58:19 +0200
Message-ID: <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-1-maxime.coquelin@redhat.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces LSM hooks for devices creation,
destruction and opening operations, checking the
application is allowed to perform these operations for
the Virtio device type.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
 include/linux/lsm_hook_defs.h       |  4 +++
 include/linux/security.h            | 15 ++++++++
 security/security.c                 | 42 ++++++++++++++++++++++
 security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 6 files changed, 130 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0243dee9cf0e..ca64eac11ddb 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include "linux/security.h"
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
@@ -1443,6 +1444,10 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
 	if (dev->connected)
 		goto unlock;
 
+	ret = -EPERM;
+	if (security_vduse_dev_open(dev->device_id))
+		goto unlock;
+
 	ret = 0;
 	dev->connected = true;
 	file->private_data = dev;
@@ -1655,6 +1660,9 @@ static int vduse_destroy_dev(char *name)
 	if (!dev)
 		return -EINVAL;
 
+	if (security_vduse_dev_destroy(dev->device_id))
+		return -EPERM;
+
 	mutex_lock(&dev->lock);
 	if (dev->vdev || dev->connected) {
 		mutex_unlock(&dev->lock);
@@ -1819,6 +1827,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	int ret;
 	struct vduse_dev *dev;
 
+	ret = -EPERM;
+	if (security_vduse_dev_create(config->device_id))
+		goto err;
+
 	ret = -EEXIST;
 	if (vduse_find_dev(config->name))
 		goto err;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..0b3999ab3264 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -419,3 +419,7 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(int, 0, vduse_dev_create, u32 device_id)
+LSM_HOOK(int, 0, vduse_dev_destroy, u32 device_id)
+LSM_HOOK(int, 0, vduse_dev_open, u32 device_id)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f16eecde00b..a650c500f841 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,9 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_vduse_dev_create(u32 device_id);
+int security_vduse_dev_destroy(u32 device_id);
+int security_vduse_dev_open(u32 device_id);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1398,18 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int security_vduse_dev_create(u32 device_id)
+{
+	return 0;
+}
+static inline int security_vduse_dev_destroy(u32 device_id)
+{
+	return 0;
+}
+static inline int security_vduse_dev_open(u32 device_id)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..8d7d4d2eca0b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5337,3 +5337,45 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+/**
+ * security_vduse_dev_create() - Check if a VDUSE device type creation is allowed
+ * @device_id: the Virtio device ID
+ *
+ * Check whether the Virtio device creation is allowed
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_vduse_dev_create(u32 device_id)
+{
+	return call_int_hook(vduse_dev_create, 0, device_id);
+}
+EXPORT_SYMBOL(security_vduse_dev_create);
+
+/**
+ * security_vduse_dev_destroy() - Check if a VDUSE device type destruction is allowed
+ * @device_id: the Virtio device ID
+ *
+ * Check whether the Virtio device destruction is allowed
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_vduse_dev_destroy(u32 device_id)
+{
+	return call_int_hook(vduse_dev_destroy, 0, device_id);
+}
+EXPORT_SYMBOL(security_vduse_dev_destroy);
+
+/**
+ * security_vduse_dev_open() - Check if a VDUSE device type opening is allowed
+ * @device_id: the Virtio device ID
+ *
+ * Check whether the Virtio device opening is allowed
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_vduse_dev_open(u32 device_id)
+{
+	return call_int_hook(vduse_dev_open, 0, device_id);
+}
+EXPORT_SYMBOL(security_vduse_dev_open);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2aa0e219d721..65d9262a37f7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2016 Mellanox Technologies
  */
 
+#include "av_permissions.h"
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
@@ -92,6 +93,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/virtio_ids.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static int vduse_check_device_type(u32 sid, u32 device_id)
+{
+	u32 requested;
+
+	if (device_id == VIRTIO_ID_NET)
+		requested = VDUSE__NET;
+	else if (device_id == VIRTIO_ID_BLOCK)
+		requested = VDUSE__BLOCK;
+	else
+		return -EINVAL;
+
+	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
+}
+
+static int selinux_vduse_dev_create(u32 device_id)
+{
+	u32 sid = current_sid();
+	int ret;
+
+	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
+	if (ret)
+		return ret;
+
+	return vduse_check_device_type(sid, device_id);
+}
+
+static int selinux_vduse_dev_destroy(u32 device_id)
+{
+	u32 sid = current_sid();
+	int ret;
+
+	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVDESTROY, NULL);
+	if (ret)
+		return ret;
+
+	return vduse_check_device_type(sid, device_id);
+}
+
+static int selinux_vduse_dev_open(u32 device_id)
+{
+	u32 sid = current_sid();
+	int ret;
+
+	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVOPEN, NULL);
+	if (ret)
+		return ret;
+
+	return vduse_check_device_type(sid, device_id);
+}
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7243,6 +7295,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
 #endif
+	LSM_HOOK_INIT(vduse_dev_create, selinux_vduse_dev_create),
+	LSM_HOOK_INIT(vduse_dev_destroy, selinux_vduse_dev_destroy),
+	LSM_HOOK_INIT(vduse_dev_open, selinux_vduse_dev_open),
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..d3dc37fb03d4 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { "override_creds", "sqpoll", "cmd", NULL } },
 	{ "user_namespace",
 	  { "create", NULL } },
+	{ "vduse",
+	  { "devcreate", "devdestroy", "devopen", "net", "block", NULL} },
 	{ NULL }
   };
 
-- 
2.41.0

