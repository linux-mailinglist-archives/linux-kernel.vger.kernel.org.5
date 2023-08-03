Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C576F331
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHCTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHCTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:03:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BCFC468E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159F31477;
        Thu,  3 Aug 2023 12:03:21 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE5F43F6C4;
        Thu,  3 Aug 2023 12:02:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 12/12] firmware: arm_ffa: Add notification handling mechanism
Date:   Thu,  3 Aug 2023 20:02:16 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-12-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3617; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=alNQ8WKZzdLc226LuzWNQjd8s+t3f1uUa9m/aytNi74=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iOoWGRp8MIkYKLKd/x+ellGoFwhm3RhX3kz sKucyPu4VCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jgAKCRAAQbq8MX7i mPDcEADPet/4EO7Br+XNllMSOUk+R0E485k23G+eMp9JL6aTv25MKnHpCBeB1peYYV7olLJ7t0n uEGziIcBnphjXKyQPp3Y7VjrPbXa4dqRUJvfVxvGzMFcX62lAP3ZXtgeqY2PS0p1Get13IgBBCr CPB368Q8teY84JnzlCWVvNJik+FfWneVKQiyn7+KMVagA/rXueVthuBBQ9HI6RYGKzk/aT2YV/C I0S3gyinCVWCXUAdeXADVaDyIrRs20AtVqs6e2UhPApN9Y8Az5dIDV+1LVEI8bXuKOtGpuqktjQ 3tlEaHe7rlVYYJEBrpivp2VTtZLKZVYB+aRtyyFUNVa6wJNLySLr////uUd9twpMoStIa6sdaI8 aDRZLQ7u02Qs7ytjtYnNqKYoY5FGAmwdH6AN5YuIERO3hCJe6bzs3Q/vn0Rek9YcxNJkLtQM49X Q6/EhcX6RGvqvs9CYGwZjKLEN4qwIuLMFqQXGJek2YZ1zN61C96rjlYV0iLjzFlbFn2nNY29xfD bR8tIekEK8fuF7tLJyy7uIsN6K9jCpsx3Um42ZV+9aTYop7zuP9WMHlgpOvg0haxXaSlMKo52Kd 39VfO9lywpdqe17XkyHDZ/lBbL4Of1d6v/rYtrPAW4TOI+WJp2kmwKZwYEIDT1ctelZtcQq62lh rS9GM59D
 ta7ofVg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp; fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/arm_ffa/driver.c | 61 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index d98d0fbe5605..63daef95b048 100644
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
@@ -1027,6 +1028,54 @@ static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 				    BIT(notify_id));
 }
 
+static void handle_notif_callbacks(u64 bitmap, u16 part_id)
+{
+	int i = 0;
+	struct notifier_cb_info *cb_info = NULL;
+
+	while (bitmap) {
+		if (bitmap & 1) {
+			mutex_lock(&drv_info->notify_lock);
+			cb_info = notifier_hash_node_get(part_id, i);
+			mutex_unlock(&drv_info->notify_lock);
+			if (cb_info->cb)
+				cb_info->cb(part_id, i, cb_info->cb_data);
+		}
+		i++;
+		bitmap >>= 1;
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
+ffa_self_notif_handle(u16 part_id, u16 vcpu, bool is_per_vcpu, void *cb_data)
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
@@ -1128,7 +1177,12 @@ static void ffa_setup_partitions(void)
 		}
 		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
 	}
-	drv_info->partition_count = count;
+	/* Allocate for the host */
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+	xa_store(&drv_info->partition_info, drv_info->vm_id, info, GFP_KERNEL);
+	drv_info->partition_count = count + 1;
 
 	kfree(pbuf);
 }
@@ -1270,6 +1324,7 @@ static int ffa_init_pcpu_irq(unsigned int irq)
 	}
 
 	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	INIT_WORK(&drv_info->notif_pcpu_work, notif_pcpu_irq_work_fn);
 	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
 	if (!drv_info->notif_pcpu_wq)
 		return -EINVAL;
@@ -1325,7 +1380,9 @@ static int ffa_notifications_setup(void)
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
2.41.0

