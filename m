Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEF7BA232
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjJEPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJEPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:19:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C6B386F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E351515;
        Thu,  5 Oct 2023 07:45:52 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF643F641;
        Thu,  5 Oct 2023 07:45:12 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:57 +0100
Subject: [PATCH v4 04/17] firmware: arm_ffa: Implement the FFA_RUN
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-4-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=PdtsxMbWHMsPxE3UREG0cqF5vyZGskCvDY/GrQFa0NE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvw8PoKVnG2NHbjO9VKHIkzUeI3tmEoRMZG4
 CcZ3zhBb9iJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8AAKCRAAQbq8MX7i
 mJGAD/9T3ada0rAJvvmdm4qPS7qlrINgtkmqLi3Kf2JYBUErUpdZ9bQfUD1yvZquHAA5O5ATiRu
 GDBcpn+mkMSOAOjQ5bmbwwSKb37jWU8zyryDMzbqUAF4bt72WWsr2nJqBeYO+gBvgNX6/A21j0V
 txxuE1Eai5zxYoAntxc3ND/8iEZDkHyL4lrz6KzJP6+Uny/NJngaFfCt+dFVAIot5azBIDqOSsm
 S5+Ae70YY1Fsh9XmTsSdlBCkgNuZZ2luTyhtDyhnZQpMlAbDh1TksFq3MshGvnWl5g6diNEx3EF
 BaYASOCTcWO/I2Pck5cMDkd2F+kYCUrc1c5gVa5GkMlRmFW1y9sUMXz08M98VAxyso4ADG23epZ
 s+5WMm+x4p2KfMXSba5EDeucauhkjWSwOZTtmz8h68H/YiveyVJv3b13GyDAUWOuaOvqyFrOeWy
 ca5z0JUUTmHEP5v8Jw7E6OFhsie/0uSByFsm99bjEdMAKiTBef41nweztaesSB9xvHpF2eLYjdv
 rUYKP0EVnUFhT7Tcj+R5PaZ1Gyj6HD+SIGGrDjVsw26gnZDLolIqu0b5lFtc2OjrC8LRd3ndkcc
 Z/lFQk6x8A+rsiOk0Jgp8mYUu+GE6+bAp/cJgi9H5jMtmmkDVc0UKICHlTxtH5azRoGSmRwyzrd
 AvR/xApIzrT8qFw==
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
index 20f8f4ca8e89..82e54d231074 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -616,6 +616,23 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
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
@@ -700,10 +717,15 @@ static const struct ffa_mem_ops ffa_drv_mem_ops = {
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

