Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C77B3646
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjI2PD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjI2PD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E41911B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2845E1FB;
        Fri, 29 Sep 2023 08:04:06 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C59123F5A1;
        Fri, 29 Sep 2023 08:03:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:00 +0100
Subject: [PATCH v3 11/17] firmware: arm_ffa: Add interface to send a
 notification to a given partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-11-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=f4Gw9qi5dW5Ef+rKySqOZWY9UgWqEziJ+T29fyYYAJQ=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucw0qDNmU79mdBC/Sm4VFjwdP3A5KYk8XFDF
 lr0YD4RIgaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMAAKCRAAQbq8MX7i
 mEk5EADEAWUv/82JqDbfhVrIMI84gpGtF67+Q77nDFptg0Czw+joaWzzI78ZRTQFg3lkwfn6d82
 N49R/38j+mg8mpP96clRyYmcnDs+jkCmMXEZPyrfs31rlMBMdFzILvcUZFOsHhke69LQJJHLFEb
 w/eqzS4FYuXiHmxsfopzHI8o9HSd7dUCrREGSegHBSd+Qub4UbjN29sQfUyUHUJOrcKkqvzCxnp
 7O+D21eP//W2KUVkN7nvTf34yAl7VBVMRAf7S4W2TYn6XmFAeMnzV0T6xZcyy8p29zYqqtCUTef
 iLGunKeDB2sYEyUQTAuzg5TbH9faXqUd+o60UrjQPqjNE9yEfutyMlbY3IbIwVwbBgCgAtkFEDx
 ZGw4XTLAWKtoh3MisocU+yEFeGLAS9Luv1ANBivu5CjOzpCbbsIlIh0rG/kL0jWSwATPJ/OzIRD
 7wQWzblYr6tT9f+EiswyTjVI5LbxDcuVOCWlKfo6jyMJ6pXDH89GkbPDXwfceI6sp8TJmXCV1DL
 dx7Hs9cLKXYKoOqNUr8nnklk/Le/GCfs+rv6QDGcHVGpSjBKosswxyMSb67+iAbGhEj0y0Ezzq+
 a00K1Bvn1zDjWzRm/jrBLCki+vESjEOGUPlGsNZLJhoHAsG6oJqtK+JAkVZiSDYqmk/nJivdBTj
 VULpEsARIEChWwA==
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

The framework provides an interface to the sender endpoint to specify
the notification to signal to the receiver endpoint. A sender signals
a notification by requesting its partition manager to set the
corresponding bit in the notifications bitmap of the receiver.

Expose the ability to send a notification to another partition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 13 +++++++++++++
 include/linux/arm_ffa.h           |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 55707a5d333d..94e39ee83278 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1044,6 +1044,18 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	return rc;
 }
 
+static int ffa_notify_send(struct ffa_device *dev, int notify_id,
+			   bool is_per_vcpu, u16 vcpu)
+{
+	u32 flags = 0;
+
+	if (is_per_vcpu)
+		flags |= (PER_VCPU_NOTIFICATION_FLAG | vcpu << 16);
+
+	return ffa_notification_set(dev->vm_id, drv_info->vm_id, flags,
+				    BIT(notify_id));
+}
+
 static const struct ffa_info_ops ffa_drv_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
@@ -1069,6 +1081,7 @@ static const struct ffa_notifier_ops ffa_drv_notifier_ops = {
 	.sched_recv_cb_unregister = ffa_sched_recv_cb_unregister,
 	.notify_request = ffa_notify_request,
 	.notify_relinquish = ffa_notify_relinquish,
+	.notify_send = ffa_notify_send,
 };
 
 static const struct ffa_ops ffa_drv_ops = {
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index fb6f388a3737..f6df81f14b6d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -401,6 +401,8 @@ struct ffa_notifier_ops {
 	int (*notify_request)(struct ffa_device *dev, bool per_vcpu,
 			      ffa_notifier_cb cb, void *cb_data, int notify_id);
 	int (*notify_relinquish)(struct ffa_device *dev, int notify_id);
+	int (*notify_send)(struct ffa_device *dev, int notify_id, bool per_vcpu,
+			   u16 vcpu);
 };
 
 struct ffa_ops {

-- 
2.42.0

