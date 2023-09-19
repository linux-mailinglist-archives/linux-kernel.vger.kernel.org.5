Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2F7A69C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjISRmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjISRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED494186
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9A2FEC;
        Tue, 19 Sep 2023 10:42:10 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7B6D3F5A1;
        Tue, 19 Sep 2023 10:41:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:00 +0100
Subject: [PATCH RFT v2 12/18] firmware: arm_ffa: Add notification handling
 mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-12-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3653; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=O2oYfFgNyaZT+oxSu90NE22HRT7VXlpCfSjWMW7VjBc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd07bZhnpL9OoP0arA4+yGtA3Q/neollvQxIX
 4uia80jWpWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOwAKCRAAQbq8MX7i
 mK7BD/91rxn4y8+6ztrYeXUpXFt+f/hD/vur9TXBxo8cfX5kacB5JP5YT0oyeWLw7CVkrULwDyL
 2IoWT0P0Kl+asv45U4oNS8gwLLPXaPE/yO3EPzJA2TRa/l0a2CKsvW079BqBfDSYqy7s9fSca35
 jjBRcwtU8TLhOLbpCqQWjtcY6nifjSz9AmPxjdPjcIPr+zqTNWerTw1szspLP/sGtrSIkyia521
 6tAi2spKFff0bsiY3OaLUXGZt9iW1bpOKXAtXaT8CViRAiVFUGqNan9TF+LyZaHLpgXmB7rVqr4
 gmIL6lfF5KDMAHNq0YRcCL2kREFFgYddVLRPxPXs4qkvMlcGZixMfQ6mqlB2Cpgd3Tmpwh0MS4p
 AQAOlIfPoqMpCODO2XTD8k/G5bm9Axud6OcfUmpausa/TTfFxu6i+mXEkKgVcezgM1hWRWMXjtI
 mjsfVm6VFQZPMIPaTtLW9Z18jpCAvG9DV2dqXmsWWmrEBNnFpjipg43S0/eFdw7LpqWjWBqiGnR
 SZbhCxtVMChsRhaEZa7+wX87aUc5b5IEjvNUPO2SChJro12fWU8avMe6dzjGetyg4vOrtvpGRJl
 Qz0MD836q/7nvDgVEOF62a3LkoSXj21MeH9Jy3VK//4k+4nU1IZAP7+amdtW2T4LFf0UuYDvqHJ
 d0Uy4NTguEagQLQ==
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
 drivers/firmware/arm_ffa/driver.c | 62 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b95c7979da8d..8a5b5c274bb9 100644
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
@@ -1045,6 +1046,55 @@ static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 				    BIT(notify_id));
 }
 
+static void handle_notif_callbacks(u64 bitmap, u16 part_id)
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
+		cb_info = notifier_hash_node_get(part_id, notify_id);
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
+	struct ffa_drv_info *info = container_of(work, struct ffa_drv_info,
+						 notif_pcpu_work);
+
+	rc = ffa_notification_get(ALL_NOTIFICATION_BITMAPS_FLAGS, &bitmaps);
+	if (rc) {
+		pr_err("Failed to retrieve notifications with %d!\n", rc);
+		return;
+	}
+
+	handle_notif_callbacks(bitmaps.vm_map, info->vm_id);
+	handle_notif_callbacks(bitmaps.sp_map, info->vm_id);
+	handle_notif_callbacks(bitmaps.arch_map, info->vm_id);
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
@@ -1149,6 +1199,13 @@ static void ffa_setup_partitions(void)
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
@@ -1292,6 +1349,7 @@ static int ffa_init_pcpu_irq(unsigned int irq)
 	}
 
 	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	INIT_WORK(&drv_info->notif_pcpu_work, notif_pcpu_irq_work_fn);
 	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
 	if (!drv_info->notif_pcpu_wq)
 		return -EINVAL;
@@ -1349,7 +1407,9 @@ static int ffa_notifications_setup(void)
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

