Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817B80ED3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376606AbjLLNSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376674AbjLLNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F1197
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702387057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+u1S2AY/jEGnaBOw0WBoMATED3t5u4RyQxPWcyrfwg=;
        b=ExqaaPmKwFJ8zDuyYBjpmRwzekFmNLNvXNqA69XKUlKZLVTGRqq7gLWBUhT0wX0QqDLK4B
        4wJlnBiuDJjV7O0QA5QyRpyzCaD0Xd4F3XYNO/gurZeXcy9WkQ2xy4eoG5+d/xRhD3ffb8
        h733sqmxe6YmWNy4EY0PXEhjYODafw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-4GXjYFpzO-GvKEOSKHlLSA-1; Tue, 12 Dec 2023 08:17:34 -0500
X-MC-Unique: 4GXjYFpzO-GvKEOSKHlLSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 576E984A298;
        Tue, 12 Dec 2023 13:17:33 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39C001121312;
        Tue, 12 Dec 2023 13:17:30 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
Date:   Tue, 12 Dec 2023 14:17:12 +0100
Message-ID: <20231212131712.1816324-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a LSM hook for devices creation,
destruction (ioctl()) and opening (open()) operations,
checking the application is allowed to perform these
operations for the Virtio device type.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 MAINTAINERS                         |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c  | 13 ++++++++++++
 include/linux/lsm_hook_defs.h       |  2 ++
 include/linux/security.h            |  6 ++++++
 include/linux/vduse.h               | 14 +++++++++++++
 security/security.c                 | 15 ++++++++++++++
 security/selinux/hooks.c            | 32 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 8 files changed, 85 insertions(+)
 create mode 100644 include/linux/vduse.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a0fb0df07b43..4e83b14358d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23040,6 +23040,7 @@ F:	drivers/net/virtio_net.c
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
+F:	include/linux/vduse.h
 F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index fa62825be378..59ab7eb62e20 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include "linux/security.h"
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
@@ -30,6 +31,7 @@
 #include <uapi/linux/virtio_blk.h>
 #include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
+#include <linux/vduse.h>
 
 #include "iova_domain.h"
 
@@ -1442,6 +1444,10 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
 	if (dev->connected)
 		goto unlock;
 
+	ret = -EPERM;
+	if (security_vduse_perm_check(VDUSE_PERM_OPEN, dev->device_id))
+		goto unlock;
+
 	ret = 0;
 	dev->connected = true;
 	file->private_data = dev;
@@ -1664,6 +1670,9 @@ static int vduse_destroy_dev(char *name)
 	if (!dev)
 		return -EINVAL;
 
+	if (security_vduse_perm_check(VDUSE_PERM_DESTROY, dev->device_id))
+		return -EPERM;
+
 	mutex_lock(&dev->lock);
 	if (dev->vdev || dev->connected) {
 		mutex_unlock(&dev->lock);
@@ -1828,6 +1837,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	int ret;
 	struct vduse_dev *dev;
 
+	ret = -EPERM;
+	if (security_vduse_perm_check(VDUSE_PERM_CREATE, config->device_id))
+		goto err;
+
 	ret = -EEXIST;
 	if (vduse_find_dev(config->name))
 		goto err;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ff217a5ce552..3930ab2ae974 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -419,3 +419,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(int, 0, vduse_perm_check, enum vduse_op_perm op_perm, u32 device_id)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..2a2054172394 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <linux/vduse.h>
 
 struct linux_binprm;
 struct cred;
@@ -484,6 +485,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1397,10 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/include/linux/vduse.h b/include/linux/vduse.h
new file mode 100644
index 000000000000..7a20dcc43997
--- /dev/null
+++ b/include/linux/vduse.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VDUSE_H
+#define _LINUX_VDUSE_H
+
+/*
+ * The permission required for a VDUSE device operation.
+ */
+enum vduse_op_perm {
+	VDUSE_PERM_CREATE,
+	VDUSE_PERM_DESTROY,
+	VDUSE_PERM_OPEN,
+};
+
+#endif /* _LINUX_VDUSE_H */
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..150abf85f97d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5337,3 +5337,18 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+/**
+ * security_vduse_perm_check() - Check if a VDUSE device type operation is allowed
+ * @op_perm: the operation type
+ * @device_id: the Virtio device ID
+ *
+ * Check whether the Virtio device creation is allowed
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
+{
+	return call_int_hook(vduse_perm_check, 0, op_perm, device_id);
+}
+EXPORT_SYMBOL(security_vduse_perm_check);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711c6b7b..18845e4f682f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -21,6 +21,8 @@
  *  Copyright (C) 2016 Mellanox Technologies
  */
 
+#include "av_permissions.h"
+#include "linux/vduse.h"
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
@@ -92,6 +94,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/virtio_ids.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6950,6 +6953,34 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static int selinux_vduse_perm_check(enum vduse_op_perm op_perm, u32 device_id)
+{
+	u32 requested_op, requested_type, sid = current_sid();
+	int ret;
+
+	if (op_perm == VDUSE_PERM_CREATE)
+		requested_op = VDUSE__CREATE;
+	else if (op_perm == VDUSE__DESTROY)
+		requested_op = VDUSE__DESTROY;
+	else if (op_perm == VDUSE_PERM_OPEN)
+		requested_op = VDUSE__OPEN;
+	else
+		return -EINVAL;
+
+	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_op, NULL);
+	if (ret)
+		return ret;
+
+	if (device_id == VIRTIO_ID_NET)
+		requested_type = VDUSE__NET;
+	else if (device_id == VIRTIO_ID_BLOCK)
+		requested_type = VDUSE__BLOCK;
+	else
+		return -EINVAL;
+
+	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested_type, NULL);
+}
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7243,6 +7274,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
 #endif
+	LSM_HOOK_INIT(vduse_perm_check, selinux_vduse_perm_check),
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a3c380775d41..b0a358cbac1c 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { "override_creds", "sqpoll", "cmd", NULL } },
 	{ "user_namespace",
 	  { "create", NULL } },
+	{ "vduse",
+	  { "create", "destroy", "open", "net", "block", NULL} },
 	{ NULL }
   };
 
-- 
2.43.0

