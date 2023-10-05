Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7B7BA244
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjJEPZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJEPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:25:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC34B1FEEF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592F01576;
        Thu,  5 Oct 2023 07:45:58 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34533F641;
        Thu,  5 Oct 2023 07:45:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:02 +0100
Subject: [PATCH v4 09/17] firmware: arm_ffa: Add schedule receiver callback
 mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-9-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6827; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=gJTWJRo2bKu1EdJbiC84iwBAD0RzFSDy4pUoU0x9hq8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvxGjQa+0sAlJhSFtCphaKPzxz2FRYB4zWti
 ArUgI9NfyCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8QAKCRAAQbq8MX7i
 mIqHEACkL+R/tDisIKTNBsGivvSys5ySeP71mI8sLeNBNOSl8IXDls5/yWM4iOMamS7mEGF98Wn
 lkCU+R8ZXSFIg3J8QLHwCeHxM67MbS/eS+va18UvHwdjPpYDgSZzetVPzMD9t6MEaLlSfQtUrmm
 gtjTd8uFdnUtxCgGk207A0q+8o3P8TSK/r1bRbvC110s5MpxI+2bzlMYQg/QLGkHGI/1BVrd/ne
 vwX0dZ9pouIYLKlX7A8aHPQAnfseCQU+zKXFDdEhiCTTis5E3nrIbFDTQH9qRQodzwvFe05E2Ae
 u9g1/vIlCmJw+WPCUxgEII5pRILJSxT8H9U+rN0eiQ4bFq+lC8dQdqxjw9SHvZNdvDMOOsQRSpn
 H/vdKzn82opVDsNQROy4SkcwxsvseMAqQJkYak15cvcYcE0QsN2QqEijzI1U8DX1SDP3U2mM+Hb
 LpqUiefyou9gofFy/4b5ZTRtdwHiCfkd1UOfMM4jg47GTgINo0U7ZtAcPUAbdLXGrred0TIYmZ4
 3f1LZBDGyvUxCSW0Vmlc1jMqexzGAAxDiJofkFVL3JuG22wrgvJyioh0DkXqqJ+YN39w6ihTI7/
 iFHbu615GbRfcsksbVB7FaXFR72+4k8tPDxvs/nxTv/3k9tj8hY8/txYo28nPKPSE+OXfNi4Xzw
 tTjcK34TWsnJaYA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index f8d01840f5ec..04cdb49cc78b 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/uuid.h>
+#include <linux/xarray.h>
 
 #include "common.h"
 
@@ -99,6 +100,8 @@ struct ffa_drv_info {
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct irq_work;
+	struct xarray partition_info;
+	unsigned int partition_count;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -694,9 +697,26 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
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
 
 static void ffa_notification_info_get(void)
@@ -845,6 +865,39 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
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
@@ -865,11 +918,17 @@ static const struct ffa_cpu_ops ffa_drv_cpu_ops = {
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
@@ -900,6 +959,7 @@ static void ffa_setup_partitions(void)
 	int count, idx;
 	uuid_t uuid;
 	struct ffa_device *ffa_dev;
+	struct ffa_dev_part_info *info;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
 	count = ffa_partition_probe(&uuid_null, &pbuf);
@@ -908,6 +968,7 @@ static void ffa_setup_partitions(void)
 		return;
 	}
 
+	xa_init(&drv_info->partition_info);
 	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
 		import_uuid(&uuid, (u8 *)tpbuf->uuid);
 
@@ -927,10 +988,42 @@ static void ffa_setup_partitions(void)
 		if (drv_info->version > FFA_VERSION_1_0 &&
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			ffa_mode_32bit_set(ffa_dev);
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
@@ -1164,9 +1257,11 @@ static int __init ffa_init(void)
 
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
@@ -1182,9 +1277,11 @@ subsys_initcall(ffa_init);
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

