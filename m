Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A57B3644
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjI2PDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjI2PD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80EE0F9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D761063;
        Fri, 29 Sep 2023 08:04:03 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2203F5A1;
        Fri, 29 Sep 2023 08:03:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:58 +0100
Subject: [PATCH v3 09/17] firmware: arm_ffa: Add schedule receiver callback
 mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-9-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6815; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=QTjl2nGOgYZchW93FMLg30GznbSP+X31xJeCsksgTOY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucvtP8Igd7LIpZ/OnLROdVloX0hZBMHnKWgp
 +rQrd+fzceJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLwAKCRAAQbq8MX7i
 mLzaD/47I2TU57DiWYGfG4LsOVQum65Qk6vaX+/RJ2Mqjwe8fHP5nynmS/L+E6ijv+ks4Y1ZwtZ
 jICzHYSINpp7L2ANkE8p84gMopNfwKVR23euvEGUBBHlCQDwRAHA4BGmasVm2n+AvsGWMEFKnrT
 TaeqNmMNa676IMmu1IltZSHw5h6C7GTiX/9UJx2zIgWNkRP+6a29P8P8NCgeyOEmAYXlLfO1AmI
 +PQDUvQ0cZWWTdvbtxTeGmQrbgqFy+7QuZ0RtxqOKrAWRyK4at3qofTsd970nWgHAtbxGDQgepR
 RBH2ACcCX/NCApIVZWI8ujAj2D1Z8K9BEfCbPf4g3PtrM1gL7ovpdIFL9mKRFQ6R2H95HJbcfx8
 ip9SA+DSyolWGdZoaPzuUMW22D4pob06jjcl/YNWIzKlMIn4jI88j4XE5wZTDzv0h7V+NKPERNm
 l9wpP/PoLi6AAa+ry4Zie7zlDhoobTpd97pECTuHBJ6AOhh8ECR/MIRF0K24UwKtlCWT7bBIVXo
 wGjOSmBt8EIEkqNCjvrwIlKp+v6UvqfFg/57hI7fVonOo7Z3+0rBKOmfZRK7SxEZXfyoRoEmdLB
 chdcC8bIbl4uvGvu9bkd++M+xFHrC7IF56+vVb98+hGA//Qudznlksq8VkxmhNIan8OQFRLjDCS
 gYbDXIUu1891Xnw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable client drivers to register a callback function that will be
called when one or more notifications are pending for a target
partition as part of schedule receiver interrupt handling.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 103 ++++++++++++++++++++++++++++++++++++--
 include/linux/arm_ffa.h           |   8 +++
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a0c80eff04c4..64f9c9e713d1 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/uuid.h>
+#include <linux/xarray.h>
 
 #include "common.h"
 
@@ -100,6 +101,8 @@ struct ffa_drv_info {
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct irq_work;
 	bool info_get_64b;
+	struct xarray partition_info;
+	unsigned int partition_count;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -695,9 +698,26 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
 	return 0;
 }
 
-static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_per_vcpu)
+struct ffa_dev_part_info {
+	ffa_sched_recv_cb callback;
+	void *cb_data;
+	rwlock_t rw_lock;
+};
+
+static void __do_sched_recv_cb(u16 part_id, u16 vcpu, bool is_per_vcpu)
 {
-	pr_err("Callback for partition 0x%x failed.\n", partition_id);
+	struct ffa_dev_part_info *partition;
+	ffa_sched_recv_cb callback;
+	void *cb_data;
+
+	partition = xa_load(&drv_info->partition_info, part_id);
+	read_lock(&partition->rw_lock);
+	callback = partition->callback;
+	cb_data = partition->cb_data;
+	read_unlock(&partition->rw_lock);
+
+	if (callback)
+		callback(vcpu, is_per_vcpu, cb_data);
 }
 
 static void ffa_notification_info_get(bool is_64b)
@@ -851,6 +871,39 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
+static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
+				    void *cb_data, bool is_registration)
+{
+	struct ffa_dev_part_info *partition;
+	bool cb_valid;
+
+	partition = xa_load(&drv_info->partition_info, part_id);
+	write_lock(&partition->rw_lock);
+
+	cb_valid = !!partition->callback;
+	if (!(is_registration ^ cb_valid)) {
+		write_unlock(&partition->rw_lock);
+		return -EINVAL;
+	}
+
+	partition->callback = callback;
+	partition->cb_data = cb_data;
+
+	write_unlock(&partition->rw_lock);
+	return 0;
+}
+
+static int ffa_sched_recv_cb_register(struct ffa_device *dev,
+				      ffa_sched_recv_cb cb, void *cb_data)
+{
+	return ffa_sched_recv_cb_update(dev->vm_id, cb, cb_data, true);
+}
+
+static int ffa_sched_recv_cb_unregister(struct ffa_device *dev)
+{
+	return ffa_sched_recv_cb_update(dev->vm_id, NULL, NULL, false);
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -871,11 +924,17 @@ static const struct ffa_cpu_ops ffa_drv_cpu_ops = {
 	.run = ffa_run,
 };
 
+static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
+	.sched_recv_cb_register = ffa_sched_recv_cb_register,
+	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
+};
+
 static const struct ffa_ops ffa_drv_ops = {
 	.info_ops = &ffa_drv_info_ops,
 	.msg_ops = &ffa_drv_msg_ops,
 	.mem_ops = &ffa_drv_mem_ops,
 	.cpu_ops = &ffa_drv_cpu_ops,
+	.notifier_ops = &ffa_drv_notifier_ops,
 };
 
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
@@ -906,6 +965,7 @@ static void ffa_setup_partitions(void)
 	int count, idx;
 	uuid_t uuid;
 	struct ffa_device *ffa_dev;
+	struct ffa_dev_part_info *info;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
 	count = ffa_partition_probe(&uuid_null, &pbuf);
@@ -914,6 +974,7 @@ static void ffa_setup_partitions(void)
 		return;
 	}
 
+	xa_init(&drv_info->partition_info);
 	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
 		import_uuid(&uuid, (u8 *)tpbuf->uuid);
 
@@ -933,10 +994,42 @@ static void ffa_setup_partitions(void)
 		if (drv_info->version > FFA_VERSION_1_0 &&
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			_ffa_mode_32bit_set(ffa_dev);
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ffa_device_unregister(ffa_dev);
+			continue;
+		}
+		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
 	}
+	drv_info->partition_count = count;
+
 	kfree(pbuf);
 }
 
+static void ffa_partitions_cleanup(void)
+{
+	struct ffa_dev_part_info **info;
+	int idx, count = drv_info->partition_count;
+
+	if (!count)
+		return;
+
+	info = kcalloc(count, sizeof(**info), GFP_KERNEL);
+	if (!info)
+		return;
+
+	xa_extract(&drv_info->partition_info, (void **)info, 0, VM_ID_MASK,
+		   count, XA_PRESENT);
+
+	for (idx = 0; idx < count; idx++)
+		kfree(info[idx]);
+	kfree(info);
+
+	drv_info->partition_count = 0;
+	xa_destroy(&drv_info->partition_info);
+}
+
 /* FFA FEATURE IDs */
 #define FFA_FEAT_NOTIFICATION_PENDING_INT	(1)
 #define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)
@@ -1172,9 +1265,11 @@ static int __init ffa_init(void)
 
 	ret = ffa_notifications_setup();
 	if (ret)
-		goto free_pages;
+		goto partitions_cleanup;
 
 	return 0;
+partitions_cleanup:
+	ffa_partitions_cleanup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
@@ -1190,9 +1285,11 @@ subsys_initcall(ffa_init);
 static void __exit ffa_exit(void)
 {
 	ffa_notifications_cleanup();
+	ffa_partitions_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);
+	xa_destroy(&drv_info->partition_info);
 	kfree(drv_info);
 	arm_ffa_bus_exit();
 }
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 12fd134bf670..f9cf6114ef82 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -391,11 +391,19 @@ struct ffa_cpu_ops {
 	int (*run)(struct ffa_device *dev, u16 vcpu);
 };
 
+typedef void (*ffa_sched_recv_cb)(u16 vcpu, bool is_per_vcpu, void *cb_data);
+struct ffa_notifier_ops {
+	int (*sched_recv_cb_register)(struct ffa_device *dev,
+				      ffa_sched_recv_cb cb, void *cb_data);
+	int (*sched_recv_cb_unregister)(struct ffa_device *dev);
+};
+
 struct ffa_ops {
 	const struct ffa_info_ops *info_ops;
 	const struct ffa_msg_ops *msg_ops;
 	const struct ffa_mem_ops *mem_ops;
 	const struct ffa_cpu_ops *cpu_ops;
+	const struct ffa_notifier_ops *notifier_ops;
 };
 
 #endif /* _LINUX_ARM_FFA_H */

-- 
2.42.0

