Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C627B3647
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjI2PEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjI2PDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 141AF1BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55718DA7;
        Fri, 29 Sep 2023 08:04:07 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2DDE3F5A1;
        Fri, 29 Sep 2023 08:03:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:01 +0100
Subject: [PATCH v3 12/17] firmware: arm_ffa: Add notification handling
 mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-12-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=P0A5RMcFNkidNv2DNz6gtpSgVPPefciFbLXlHTbsR/M=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucwYmIkcIk2FrlNkANdeNEyh1b6LuU9cIg6j
 jetsf0+Ho6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMAAKCRAAQbq8MX7i
 mJwoEACek+U4yIiIyf+5+1Vh7WX8nlg+7YdLyiDPGJYHdqU881l2wYDmoBWzUK19uCCgbFPgGXv
 ZUVO/jtWZHzOEC1wjgPqt5GTcWcnOt0m5H4NMoSR4AfzZ1eKTFxGRiW9tJVxFVl0NkRgxGGaP9j
 Q2Emlt3TD140Qd+A3VSJCzq9fj73LIaN3iDy0kk9QFxHPiU1TK8Mp1deUeJFC8l7iAFn+xWo7m5
 d1yqm5NcMcxCQVF6J4gS3wiGTPHrhDPnPNHTefpTFHGK5YrNlGaq8A6S33T3PlYN5BKR+JqW7SF
 CADpA27cPbfNbUznDeM6Fq19FwLCrNmYIC8ZaCUMoHfDCTp4t6gL6Z55kRx+TCikMvyxgk4P6sO
 1lK4Q0K8nlx42ck/2b+Y8ZFsotH7zRlRZanCTU4uIvEtyuZQcfhtXhEK3jG7Eub63YfqntyOLCv
 1jgzman0nENiAQ+jfiOSIYmOM1YYzFclo9DgEOYMYSWwBCPvV9u4G/AFHmg0wk67EfGlS4+jdYU
 JDdM95MHp9GRpO9C9vPfq9Mn8zCPG43/ew1PrFb+8+XoRYNBgxzsOftfJ+I9UDRMdjh0d+LQxUF
 NdngDiMl16m67dHvft3/T6GRck9IDJPmsnk0wKMosXReNgB+CgQ6BxmfT+k6Tf+OOo7DSaX6FO1
 aox1d4DkRrF8gSg==
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

With all the necessary plumbing in place, let us add handling the
notifications as part of schedule receiver interrupt handler. In order
to do so, we need to just register scheduling callback on behalf of the
driver partition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 65 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 94e39ee83278..28bf345862d9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -103,6 +103,7 @@ struct ffa_drv_info {
 	unsigned int cpuhp_state;
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
 	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
 	struct work_struct irq_work;
 	bool info_get_64b;
 	struct xarray partition_info;
@@ -634,6 +635,10 @@ static int ffa_notification_bitmap_destroy(void)
 #define MAX_IDS_32				10
 
 #define PER_VCPU_NOTIFICATION_FLAG		BIT(0)
+#define SECURE_PARTITION_BITMAP			BIT(0)
+#define NON_SECURE_VM_BITMAP			BIT(1)
+#define SPM_FRAMEWORK_BITMAP			BIT(2)
+#define NS_HYP_FRAMEWORK_BITMAP			BIT(3)
 
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
@@ -1056,6 +1061,54 @@ static int ffa_notify_send(struct ffa_device *dev, int notify_id,
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
@@ -1160,6 +1213,13 @@ static void ffa_setup_partitions(void)
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
@@ -1303,6 +1363,7 @@ static int ffa_init_pcpu_irq(unsigned int irq)
 	}
 
 	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	INIT_WORK(&drv_info->notif_pcpu_work, notif_pcpu_irq_work_fn);
 	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
 	if (!drv_info->notif_pcpu_wq)
 		return -EINVAL;
@@ -1360,7 +1421,9 @@ static int ffa_notifications_setup(void)
 	hash_init(drv_info->notifier_hash);
 	mutex_init(&drv_info->notify_lock);
 
-	return 0;
+	/* Register internal scheduling callback */
+	return ffa_sched_recv_cb_update(drv_info->vm_id,
+					ffa_self_notif_handle, drv_info, true);
 cleanup:
 	ffa_notifications_cleanup();
 	return ret;

-- 
2.42.0

