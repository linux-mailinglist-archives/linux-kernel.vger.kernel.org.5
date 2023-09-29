Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27A7B363F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjI2PDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjI2PDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B36C71A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3831106F;
        Fri, 29 Sep 2023 08:03:57 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBCE3F5A1;
        Fri, 29 Sep 2023 08:03:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:53 +0100
Subject: [PATCH v3 04/17] firmware: arm_ffa: Implement the FFA_RUN
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-4-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3/hdIfSwI04CJ8YoVOAM5D8uyI/IOxahGfihf3h43bU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucuyb+IhwHkIr8NkHq2LIo7vVzNfZRZsmBWR
 4z6tmAq9BKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLgAKCRAAQbq8MX7i
 mG9sD/908ogrCGeAYlAX2T65/u61ZJ7us0nLl5Uheh/+02XbBaRhe5MTBlWCuxDsgwR+evhSYU3
 NwZ+qXzILP+4auBk2iAlAxfSh9tGliHl2UOOCsb8ovJaLgagrw0zXJyYJkwz5OPshhY5EkfMnt3
 ffwMTulCVOv6iLyGnghUQsyxGZOff5IMuGouns2vqnmEW4CmLqDkBo1X/vnXefbZlt2Lz9eSAjO
 RuVdrdEZoB90GM2q/FCns3FFtmg/pb59uh4paZ8+kaoyQ+sB5GoZXg+Q17bbTlar9Ypm9Sp5Rui
 R8wcjmq7I58eIXNWwCbz6jVY1nw3X46H5JOEPXZElh57O7PajQLrJLV4pQwgXQH6PMaNwmd4d3l
 iJf+UbzPbDEo7JkBz+43MWhMEXGZwsQDAmOUXF0n/TQUBsqpLHHGZqbr42FJqoXo6qrjXO5fnNV
 m5rk4WRCOgmCzRZnE1ewRI1Oxdg+3QoUplO43iTFP3tZjUADnTQl8mQ8mpP0byodrXWaRIRSI0A
 P0Zl2+qvKUG9qZjgnrBGdRVJ7HoFU821Z2ZQ+KqxQNbHF3Xe5Y4yHN9gYn3sNukQx0PWQ8tSQuI
 BukTyIlcNQBrrUg3Loqo+XFukGt5Nlcco2QOziTsxJfSh8kWllWq4qle1u1bIHS2p6Gxbeg38LN
 W/D92epURHxVZ2g==
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
index 26bf9c4e3b5f..b265063e76ea 100644
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
@@ -708,10 +725,15 @@ static const struct ffa_mem_ops ffa_drv_mem_ops = {
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

