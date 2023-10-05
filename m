Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D07BA5FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjJEQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbjJEQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E14C61FEF9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B57F1596;
        Thu,  5 Oct 2023 07:45:59 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D53253F641;
        Thu,  5 Oct 2023 07:45:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:03 +0100
Subject: [PATCH v4 10/17] firmware: arm_ffa: Add interfaces to request
 notification callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-10-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6943; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=jS9ZlPVRWP8/Wp7yswbAzCodeaTe0yPLbi3t5Cfh9Ag=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvxxToFsUAseBZwM6KJxyCdYs3fXrYhfoBev
 HCeQCsEg1mJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8QAKCRAAQbq8MX7i
 mNK6EACWTqIstipLTxGSmcoa6S6ckNRC7YGl/dzKaA1U1CN4NJlnY7c3ndXCz5pXlEa4dYM/qS0
 jRxaMokUoAM+oTzQ7oHpHcsbwV+U94b7PZUf8LE43zwDehpCDOVZiUw+JG3P8TqWZHHvyJ1uKWi
 twxvwIdASgc+QLTKMBsFqccxnZaHifF4CefM40n+vllCJCxHNPJNdniQkgNdHQafj5059JAavWj
 //Rv28k+dZJFGRpOpjhleRQdTJzCKQljD15ayt5RgeLeiusqE3wFRak8Nlht2+DrgDzaLNQHX8o
 Rnf61LLiBqlGbwpa73pFUY1jbHWkhsX2KXCGUs+PvVw+Kkwun+mkzF0wmC/u4Pq1J9hxKnoR+/q
 rcu0UJ/bz961gkivXmEmB4rxsxgZRZHcdJvXxftpVOKft4eMWhZjmOcV7vx+//W7Q0yOHl3sMoI
 pex2Bh/FzNT9tHCikz7PHQEcLbNGpDmTy0O/w4HfcslvVVmORIrWb8oysRawD/Q0IOHeZJS2JQr
 qAYdTBJjDKZJhQ0uwJYOyF/URnhCcfE97aSQ4UhrSQ80ls54ZTnMYJR0nE3gDe5z9jB/xIJ56Oe
 eoNYe6U5TjkGeqs3WWmwsh3coiR2lAL3EQCD+TVYeafWSwnQk8y/2tTnnoE0nBXcd//xg/b0yCW
 cIMJ8icGIGdFEsg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface to the FFA driver to allow for client drivers to request
and relinquish a notification as well as provide a callback for the
notification.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 145 ++++++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h           |   5 ++
 2 files changed, 150 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 04cdb49cc78b..fc8b29648fb2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -27,11 +27,13 @@
 #include <linux/bitfield.h>
 #include <linux/cpuhotplug.h>
 #include <linux/device.h>
+#include <linux/hashtable.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/of_irq.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
@@ -57,6 +59,8 @@
  */
 #define RXTX_BUFFER_SIZE	SZ_4K
 
+#define FFA_MAX_NOTIFICATIONS		64
+
 static ffa_fn *invoke_ffa_fn;
 
 static const int ffa_linux_errmap[] = {
@@ -102,6 +106,8 @@ struct ffa_drv_info {
 	struct work_struct irq_work;
 	struct xarray partition_info;
 	unsigned int partition_count;
+	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
+	struct mutex notify_lock; /* lock to protect notifier hashtable  */
 };
 
 static struct ffa_drv_info *drv_info;
@@ -626,6 +632,8 @@ static int ffa_notification_bitmap_destroy(void)
 #define MAX_IDS_64				20
 #define MAX_IDS_32				10
 
+#define PER_VCPU_NOTIFICATION_FLAG		BIT(0)
+
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
 {
@@ -865,6 +873,21 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
+#define FFA_SECURE_PARTITION_ID_FLAG	BIT(15)
+
+enum notify_type {
+	NON_SECURE_VM,
+	SECURE_PARTITION,
+	FRAMEWORK,
+};
+
+struct notifier_cb_info {
+	struct hlist_node hnode;
+	ffa_notifier_cb cb;
+	void *cb_data;
+	enum notify_type type;
+};
+
 static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
 				    void *cb_data, bool is_registration)
 {
@@ -898,6 +921,123 @@ static int ffa_sched_recv_cb_unregister(struct ffa_device *dev)
 	return ffa_sched_recv_cb_update(dev->vm_id, NULL, NULL, false);
 }
 
+static int ffa_notification_bind(u16 dst_id, u64 bitmap, u32 flags)
+{
+	return ffa_notification_bind_common(dst_id, bitmap, flags, true);
+}
+
+static int ffa_notification_unbind(u16 dst_id, u64 bitmap)
+{
+	return ffa_notification_bind_common(dst_id, bitmap, 0, false);
+}
+
+/* Should be called while the notify_lock is taken */
+static struct notifier_cb_info *
+notifier_hash_node_get(u16 notify_id, enum notify_type type)
+{
+	struct notifier_cb_info *node;
+
+	hash_for_each_possible(drv_info->notifier_hash, node, hnode, notify_id)
+		if (type == node->type)
+			return node;
+
+	return NULL;
+}
+
+static int
+update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
+		   void *cb_data, bool is_registration)
+{
+	struct notifier_cb_info *cb_info = NULL;
+	bool cb_found;
+
+	cb_info = notifier_hash_node_get(notify_id, type);
+	cb_found = !!cb_info;
+
+	if (!(is_registration ^ cb_found))
+		return -EINVAL;
+
+	if (is_registration) {
+		cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
+		if (!cb_info)
+			return -ENOMEM;
+
+		cb_info->type = type;
+		cb_info->cb = cb;
+		cb_info->cb_data = cb_data;
+
+		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
+	} else {
+		hash_del(&cb_info->hnode);
+	}
+
+	return 0;
+}
+
+static enum notify_type ffa_notify_type_get(u16 vm_id)
+{
+	if (vm_id & FFA_SECURE_PARTITION_ID_FLAG)
+		return SECURE_PARTITION;
+	else
+		return NON_SECURE_VM;
+}
+
+static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
+{
+	int rc;
+	enum notify_type type = ffa_notify_type_get(dev->vm_id);
+
+	if (notify_id >= FFA_MAX_NOTIFICATIONS)
+		return -EINVAL;
+
+	mutex_lock(&drv_info->notify_lock);
+
+	rc = update_notifier_cb(notify_id, type, NULL, NULL, false);
+	if (rc) {
+		pr_err("Could not unregister notifcation callback\n");
+		mutex_unlock(&drv_info->notify_lock);
+		return rc;
+	}
+
+	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+
+	mutex_unlock(&drv_info->notify_lock);
+
+	return rc;
+}
+
+static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id)
+{
+	int rc;
+	u32 flags = 0;
+	enum notify_type type = ffa_notify_type_get(dev->vm_id);
+
+	if (notify_id >= FFA_MAX_NOTIFICATIONS)
+		return -EINVAL;
+
+	mutex_lock(&drv_info->notify_lock);
+
+	if (is_per_vcpu)
+		flags = PER_VCPU_NOTIFICATION_FLAG;
+
+	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
+	if (rc) {
+		mutex_unlock(&drv_info->notify_lock);
+		return rc;
+	}
+
+	rc = update_notifier_cb(notify_id, type, cb, cb_data, true);
+	if (rc) {
+		pr_err("Failed to register callback for %d - %d\n",
+		       notify_id, rc);
+		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
+	}
+	mutex_unlock(&drv_info->notify_lock);
+
+	return rc;
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -921,6 +1061,8 @@ static const struct ffa_cpu_ops ffa_drv_cpu_ops = {
 static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_register = ffa_sched_recv_cb_register,
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
+	.notify_request = ffa_notify_request,
+	.notify_relinquish = ffa_notify_relinquish,
 };
 
 static const struct ffa_ops ffa_drv_ops = {
@@ -1194,6 +1336,9 @@ static int ffa_notifications_setup(void)
 	if (ret)
 		goto cleanup;
 
+	hash_init(drv_info->notifier_hash);
+	mutex_init(&drv_info->notify_lock);
+
 	return 0;
 cleanup:
 	ffa_notifications_cleanup();
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index f9cf6114ef82..fb6f388a3737 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -392,10 +392,15 @@ struct ffa_cpu_ops {
 };
 
 typedef void (*ffa_sched_recv_cb)(u16 vcpu, bool is_per_vcpu, void *cb_data);
+typedef void (*ffa_notifier_cb)(int notify_id, void *cb_data);
+
 struct ffa_notifier_ops {
 	int (*sched_recv_cb_register)(struct ffa_device *dev,
 				      ffa_sched_recv_cb cb, void *cb_data);
 	int (*sched_recv_cb_unregister)(struct ffa_device *dev);
+	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
+			      ffa_notifier_cb cb, void *cb_data, int notify_id);
+	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
 };
 
 struct ffa_ops {

-- 
2.42.0

