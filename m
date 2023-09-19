Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2211A7A69BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjISRll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjISRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DED09F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC70A1474;
        Tue, 19 Sep 2023 10:42:00 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E57A3F5A1;
        Tue, 19 Sep 2023 10:41:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:52 +0100
Subject: [PATCH RFT v2 04/18] firmware: arm_ffa: Implement the FFA_RUN
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-4-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=Ugwvwd8/JIC0seKTsKMUdQtcSkqVhmHWDulozxAowZA=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd060uHK0tRWi3ytD1pZwYtn7oc6ElPw6Hm3x
 XilsdPeefCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mEqBEADXfXTUOzW4/rKDAuRiJCaizNvA5FyQeEgI3XDejJaVgzISgtwM3Sbm4bQSl427o5f1UKJ
 zo8gojg4zEb3+frHxX+dmMdoOmbB2EeOTLymZVW06DWX7FIc/kmdkW7zGEdjejE+8+Z2SgwtB45
 eXUJEswH5rzaqW4i4C3QPlBVOlnwQIzjRm9Ta3woHewEQccF6UJ+6e/zuKWJdzAV1PktE7YscPe
 JoBjjxF4e5m9daXWE3bYr+utk333psiCRd26pFhWelVnEHcKqdENA1XI/B2rDtoQZqEE589krPA
 8UcjGktvfJtusxMeHyhSrM+o07MVqhWtoTLu8uzu0pCoRMFxClMOBxpgiwGsYgDjQpnuZSnYaAm
 SosWo7UNOngwkcx88cNFkbSpY/W0JQ7opvgCko/jAvI6QnkmhMwWzVqfk2A/KB45o/J50/eswyD
 KReynHDoaH6184X1/doxcFrdWs68IaW1f8b300i8Wk15fYIyEeTPGt/79rfWSbn4mCmN6MRwJS8
 KObB0gjkgNv7+a7wyU9oegFcVRy33uAXtIcEDO1BpJ3b1qw7slWbJYnJyt4xXiIUtxns8eX6x9h
 MQAfjBPSkypkkwNjyC4/9Gr/CLehU927SulLy7flxUNvXT7ct3cSQ9yZUV/nr4+GrWFvajrjtmw
 t1hH9YNv4iLdD1w==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index ab67cb22a206..ebe1ecc57099 100644
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
2.42.0

