Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A87BA45A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjJEQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJEQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:03:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC52618BBF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46ABB15BF;
        Thu,  5 Oct 2023 07:46:02 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F8C3F641;
        Thu,  5 Oct 2023 07:45:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:05 +0100
Subject: [PATCH v4 12/17] firmware: arm_ffa: Add notification handling
 mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-12-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4050; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=GHIh6ClSLWjbfe+dbK9XBffuB6q16AXPdqCkeJlcuXE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvypoEExryuzL9TlqjKcrV/X62vuDwcXQGTN
 A+YUdxhg4qJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8gAKCRAAQbq8MX7i
 mDeFD/901XcmtIPEPA/bjc45RGEcElECvD2xcHIFEzydP8tYoOD68Z5I43vLBDzveQ95360VKDl
 wUCNdHj3d7NQ9xgrv1G/kSlyMdkt4H4DiNzIq/Z/0K6lxJD1RirhRlOUqdJQ6/MYzF5GCC29FEl
 XfcURhAXY2q1T6yrH8yz7N5fOfi+18MO11iKs/twtwb+6nCqznoCue4sBefC4ewqrAu/8fdh3aQ
 NFvgRgh2Ih1GiLUzjDO9nWDycMdMcra78eosR46uOydc3d0oOi6sus0JZUlBkU/w80cOOo1bsNk
 iEmkw6kMBugHB+npBBNVZgRRJKEfRIxoKjfP3LzRS8voe0KyhJdYutOF28Addnf818VFjtugfuG
 O+vNfJ1rSZPCXpBDFFXvMn7YK9dW6ZP5pLcgQTaHZI/njc9Sv88KQpCn99vd1GpPQB3h29lDf+j
 7q3I2Ow5Dr+6I95FjWndkgBbhAPXcqttaqi7jNauOCEFsX3L8SQi+7tcthh0ZjhcsNa2pt1+PpM
 bIQqnPe07SMzI0aSRRwTlhvb1cVgJIINcHQy7XYLmOQw9R3sDJIOAgiDc9nkHa4GLQwSTrFNsw2
 Ziq0cuX0y74ADM8wE537ofiX7S3BpGkJVAUne4Az9iUU+92cHHRC1UIOYUote06csWz8r5DFVz7
 kCWTo3GBnqxNAFg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all the necessary plumbing in place, let us add handling the
notifications as part of schedule receiver interrupt handler. In order
to do so, we need to just register scheduling callback on behalf of the
driver partition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 67 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2a46052a280a..9dd5335001ee 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -103,6 +103,7 @@ struct ffa_drv_info {
 	unsigned int cpuhp_state;
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
 	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
 	struct work_struct irq_work;
 	struct xarray partition_info;
 	unsigned int partition_count;
@@ -633,6 +634,10 @@ static int ffa_notification_bitmap_destroy(void)
 #define MAX_IDS_32				10
 
 #define PER_VCPU_NOTIFICATION_FLAG		BIT(0)
+#define SECURE_PARTITION_BITMAP			BIT(0)
+#define NON_SECURE_VM_BITMAP			BIT(1)
+#define SPM_FRAMEWORK_BITMAP			BIT(2)
+#define NS_HYP_FRAMEWORK_BITMAP			BIT(3)
 
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
@@ -1050,6 +1055,54 @@ static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 				    BIT(notify_id));
 }
 
+static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
+{
+	int notify_id;
+	struct notifier_cb_info *cb_info = NULL;
+
+	for (notify_id = 0; notify_id <= FFA_MAX_NOTIFICATIONS && bitmap;
+	     notify_id++, bitmap >>= 1) {
+		if (!(bitmap & 1))
+			continue;
+
+		mutex_lock(&drv_info->notify_lock);
+		cb_info = notifier_hash_node_get(notify_id, type);
+		mutex_unlock(&drv_info->notify_lock);
+
+		if (cb_info && cb_info->cb)
+			cb_info->cb(notify_id, cb_info->cb_data);
+	}
+}
+
+static void notif_pcpu_irq_work_fn(struct work_struct *work)
+{
+	int rc;
+	struct ffa_notify_bitmaps bitmaps;
+
+	rc = ffa_notification_get(SECURE_PARTITION_BITMAP |
+				  SPM_FRAMEWORK_BITMAP, &bitmaps);
+	if (rc) {
+		pr_err("Failed to retrieve notifications with %d!\n", rc);
+		return;
+	}
+
+	handle_notif_callbacks(bitmaps.vm_map, NON_SECURE_VM);
+	handle_notif_callbacks(bitmaps.sp_map, SECURE_PARTITION);
+	handle_notif_callbacks(bitmaps.arch_map, FRAMEWORK);
+}
+
+static void
+ffa_self_notif_handle(u16 vcpu, bool is_per_vcpu, void *cb_data)
+{
+	struct ffa_drv_info *info = cb_data;
+
+	if (!is_per_vcpu)
+		notif_pcpu_irq_work_fn(&info->notif_pcpu_work);
+	else
+		queue_work_on(vcpu, info->notif_pcpu_wq,
+			      &info->notif_pcpu_work);
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -1154,6 +1207,13 @@ static void ffa_setup_partitions(void)
 	drv_info->partition_count = count;
 
 	kfree(pbuf);
+
+	/* Allocate for the host */
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+	xa_store(&drv_info->partition_info, drv_info->vm_id, info, GFP_KERNEL);
+	drv_info->partition_count++;
 }
 
 static void ffa_partitions_cleanup(void)
@@ -1294,6 +1354,7 @@ static int ffa_init_pcpu_irq(unsigned int irq)
 	}
 
 	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	INIT_WORK(&drv_info->notif_pcpu_work, notif_pcpu_irq_work_fn);
 	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
 	if (!drv_info->notif_pcpu_wq)
 		return -EINVAL;
@@ -1352,7 +1413,11 @@ static int ffa_notifications_setup(void)
 	hash_init(drv_info->notifier_hash);
 	mutex_init(&drv_info->notify_lock);
 
-	return 0;
+	/* Register internal scheduling callback */
+	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
+				       drv_info, true);
+	if (!ret)
+		return ret;
 cleanup:
 	ffa_notifications_cleanup();
 	return ret;

-- 
2.42.0

