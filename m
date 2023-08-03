Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A601D76F327
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjHCTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjHCTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D2281734
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30F861480;
        Thu,  3 Aug 2023 12:03:10 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15A3B3F6C4;
        Thu,  3 Aug 2023 12:02:25 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 04/12] firmware: arm_ffa: Implement the FFA_RUN interface
Date:   Thu,  3 Aug 2023 20:02:08 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-4-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=8UCCbjCIAGT3DvQq6khWZB7ln9w5pDlIi1zeSYgu1Gs=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iNz8e7tlD4ADSye1xFoilF+9E6QAkr3Wlr+ vNDIyzwNgyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jQAKCRAAQbq8MX7i mAk6D/98H1br3BLgYDjviipRcx6zJ1BF4rGi7dR1v2O8kSdokik+nyBljy56Bx54mY/neK5YSEL V3OYu770AaQ5mIOjZ/jtYreLtn3FI0oZDILv0kdkicEfbRkg6vMtRpI3UwRP8N+fOMX4JwbRciy f1l7VnBCn4BWlMuQ3NAuUTwWEo8FRYs7lG/k0Yk4Pp/FLt9RzaAPYP6rL2qNWNkbR6yTA4yGjOM YCLFgOK7nl7gGIW59NSCaqGrcsN2tr9hxl3pbTzuE8l8d5s0exBV3xeinKM/624DBJbPdheU3Eq Y/i21/woZzEcTiDl7OsLsfMq4KCXXncZ8lhth/PUv+iSKd8U9qG/FQW7WlCPYE4jXLKzj8cD6ON CgmTkzjOI7P9Vsyd1DBT44s1tKYnt/DrQsU4jDlLcQ8eje7udinc84lun2SPhXgBoZVogVb0vdv I9PcwAiPZrJok2N9sRr0KSKmxlCQnMo4CwEw5nzbx1cl91rJTHPNsEvK8JnBG0wiaVx/99+gvQo XqvJKaGd0V8ZMSIM/qCBfPxzwD1MbG9iBFvmSQqvb3BjKi4aJhwg7ukMq3X7m1yrIW7vHbaqWPb R2ueissxARbclA8P2ks0gzOrPycGMJ4pHhJ1GOWXCZUghYePYfnELmTY5n08Eno+2o6fNxlMF3U DKtZi0Ox
 b2IMgrA==
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

FFA_RUN is used by a scheduler to allocate CPU cycles to a target
endpoint execution context specified in the target information parameter.

If the endpoint execution context is in the waiting/blocked state, it
transitions to the running state.

Expose the ability to call FFA_RUN in order to give any partition in the
system cpu cycles to perform IMPDEF functionality.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 22 ++++++++++++++++++++++
 include/linux/arm_ffa.h           |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a76e5d3a2422..41171ae7f63a 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -604,6 +604,23 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 	return 0;
 }
 
+static int ffa_run(struct ffa_device *dev, u16 vcpu)
+{
+	ffa_value_t ret;
+	u32 target = dev->vm_id << 16 | vcpu;
+
+	invoke_ffa_fn((ffa_value_t){ .a0 = FFA_RUN, .a1 = target, }, &ret);
+
+	while (ret.a0 == FFA_INTERRUPT)
+		invoke_ffa_fn((ffa_value_t){ .a0 = FFA_RUN, .a1 = ret.a1, },
+			      &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+
+	return 0;
+}
+
 static void ffa_set_up_mem_ops_native_flag(void)
 {
 	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||
@@ -696,10 +713,15 @@ static const struct ffa_mem_ops ffa_drv_mem_ops = {
 	.memory_lend = ffa_memory_lend,
 };
 
+static const struct ffa_cpu_ops ffa_drv_cpu_ops = {
+	.run = ffa_run,
+};
+
 static const struct ffa_ops ffa_drv_ops = {
 	.info_ops = &ffa_drv_info_ops,
 	.msg_ops = &ffa_drv_msg_ops,
 	.mem_ops = &ffa_drv_mem_ops,
+	.cpu_ops = &ffa_drv_cpu_ops,
 };
 
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 2ea1717a0825..12fd134bf670 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -387,10 +387,15 @@ struct ffa_mem_ops {
 	int (*memory_lend)(struct ffa_mem_ops_args *args);
 };
 
+struct ffa_cpu_ops {
+	int (*run)(struct ffa_device *dev, u16 vcpu);
+};
+
 struct ffa_ops {
 	const struct ffa_info_ops *info_ops;
 	const struct ffa_msg_ops *msg_ops;
 	const struct ffa_mem_ops *mem_ops;
+	const struct ffa_cpu_ops *cpu_ops;
 };
 
 #endif /* _LINUX_ARM_FFA_H */

-- 
2.41.0

