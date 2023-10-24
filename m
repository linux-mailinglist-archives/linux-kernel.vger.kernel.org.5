Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6FE7D4E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjJXK4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJXK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:56:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209EC109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:56:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BD715A1;
        Tue, 24 Oct 2023 03:57:10 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1357F3F64C;
        Tue, 24 Oct 2023 03:56:28 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 24 Oct 2023 11:56:19 +0100
Subject: [PATCH 3/4] firmware: arm_ffa: Add checks for the notification
 enabled state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-ffa-notification-fixes-v1-3-d552c0ec260d@arm.com>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=E6NSv6v1x1k9jYmSXi9wqAwct9jHzDEtdSLjqJZKdeA=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlN6LZlekawWTp6pU0+zIL+ooCxPn686rd+ILSC
 Hhq+w8T2puJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZTei2QAKCRAAQbq8MX7i
 mCbFD/9dxq64fStRXBbNV9s6lwBsfxZTteMfOZvLHCLYjvzHUn33Gf2sGL5fml/7Ren7MF8mPvA
 ZGnOLK9do+ElMIsJ569kWwjpP5edeBS5R+Qs2ckeDQrsMYHEny5Kmn54yEkJLygzho4l8CzdpeA
 6jI3WO+oNy8U13h7T3IJfmshizFhogR/+Tcl2OTEKMfVeQJKi4gBmA6BJRYGDHCcB3dTfs4Fkup
 Dnkuk74tbWojm5lL+l6wcxBIWZwc2R3BfAii9yUC+RSUHl1dNG643KBsKpMAOiHk9Nws1OWZboI
 u6X7lOacF8sfC0kDOjlpO/MuK57WHfYm7je5/8l0aI1BNQ/gOaN0u834vq3u4t8BzjwUjKzst1u
 1KznUD0V96WwUOA1uBn8e669hV+hMLDr2YbmEDxNKC1HfhplKzaG6M7K7RfX7/I5paZU40z7eaf
 LIoNAejPcbfDGJptk+bt2mf7eLm2n2gcZ/T3nrlCJsfodT9KuiceYAaj99Pd0ta9vIQYxfXsnjc
 EypyLPkGa7r3Qd3yico3Y5sz6fdKOU8Hze1GYzWWzSJTIvKa81z1kCvD+VDuNBvwRQysRTVGfI0
 8UKIHK9s/sASvLpEvKDrGHnCUcf7CyFSaV/aC1aHPdOVwQulkcXCsfciV3WN0KAe9eIVut9fQlh
 1p49MAylzEvosjg==
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

We need to check if the FF-A notifications are enabled or not in all
the notification operations that are accessible for the FF-A device
from the FF-A driver. This helps to avoid making calls to the FF-A
firmware even if the notification setup has failed.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 0ab30b571a69..b097452597a2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -99,6 +99,7 @@ struct ffa_drv_info {
 	void *tx_buffer;
 	bool mem_ops_native;
 	bool bitmap_created;
+	bool notif_enabled;
 	unsigned int sched_recv_irq;
 	unsigned int cpuhp_state;
 	struct ffa_pcpu_irq __percpu *irq_pcpu;
@@ -889,6 +890,8 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 
 #define FFA_SECURE_PARTITION_ID_FLAG	BIT(15)
 
+#define ffa_notifications_disabled()	(!drv_info->notif_enabled)
+
 enum notify_type {
 	NON_SECURE_VM,
 	SECURE_PARTITION,
@@ -908,6 +911,9 @@ static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
 	struct ffa_dev_part_info *partition;
 	bool cb_valid;
 
+	if (ffa_notifications_disabled())
+		return -EOPNOTSUPP;
+
 	partition = xa_load(&drv_info->partition_info, part_id);
 	write_lock(&partition->rw_lock);
 
@@ -1001,6 +1007,9 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 	int rc;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 
+	if (ffa_notifications_disabled())
+		return -EOPNOTSUPP;
+
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
@@ -1027,6 +1036,9 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	u32 flags = 0;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 
+	if (ffa_notifications_disabled())
+		return -EOPNOTSUPP;
+
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
@@ -1057,6 +1069,9 @@ static int ffa_notify_send(struct ffa_device *dev, int notify_id,
 {
 	u32 flags = 0;
 
+	if (ffa_notifications_disabled())
+		return -EOPNOTSUPP;
+
 	if (is_per_vcpu)
 		flags |= (PER_VCPU_NOTIFICATION_FLAG | vcpu << 16);
 
@@ -1388,6 +1403,7 @@ static void ffa_notifications_cleanup(void)
 		ffa_notification_bitmap_destroy();
 		drv_info->bitmap_created = false;
 	}
+	drv_info->notif_enabled = false;
 }
 
 static void ffa_notifications_setup(void)
@@ -1422,6 +1438,7 @@ static void ffa_notifications_setup(void)
 	hash_init(drv_info->notifier_hash);
 	mutex_init(&drv_info->notify_lock);
 
+	drv_info->notif_enabled = true;
 	return;
 cleanup:
 	pr_info("Notification setup failed %d, not enabled\n", ret);

-- 
2.42.0

