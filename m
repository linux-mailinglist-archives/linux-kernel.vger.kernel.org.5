Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696E76F329
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjHCTCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjHCTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7B02D45
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0ED3113E;
        Thu,  3 Aug 2023 12:03:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C59D03F6C4;
        Thu,  3 Aug 2023 12:02:28 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 06/12] firmware: arm_ffa: Implement the FFA_NOTIFICATION_GET interface
Date:   Thu,  3 Aug 2023 20:02:10 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-6-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=QiYypOJbkBWHgSGa313TRfX1qAeCKQxgXXJlIzrlCb4=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iN718+JjDcXSIQ5FtP9ojxFvsvrNBlWnUpj ykv/F2Jav+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jQAKCRAAQbq8MX7i mOMhEAC9njZpnCHhAp9dXLNaxwkN9GRPwSNRxSfrqdGGB9ELXYXKVYNdQxjLCs9w+HQBeMhu3PO GdqB1/IzaHrq9C+U/fPTREEVy+QdGVjEOorcp3FgFIm5EL+FKuIYXY4qnK1yblPbngl9iC/WPbn MpJisF4XHUZ0E1fi6XXRtt0oQe5iYr1Z65OKtl/Jeojt9Ig/A/RJm9/M7+wwE4/yYmdjlrQSwNF 1G06QJK98gSfDahUTnyxov3diHEGnAOLtus/cMttRcvMcvBI/UcAAEOyPWsVsba/IsGLPmM+9Kp hArXdwdwG+DGXXuOT7l2U1jZcNl3dXL92Eij/1sGNBUTRIaU3SgldzC7J7+9kFRi4kfWXnAuQzH PHwy/tctFZHYBPMILmo/QNKd3w6xG9UJFPhEE4UVJeJy3IANEgomJXA0nhWR+zvEPSZRyP5yGUx PHUjqNTOWxQFaTKNPJ8eI3ZS53D4jGsIapfFgzK9nRQ/jMjkZC4JExsSviXn/FvMc1mhz6d1P6k 6dI7YNjSji1B5+eKJx5BdiWWGegwt93hZX49FR5S4g6CqG5bGi3tKwL0/df4Fk0j1tTn4PsiW1/ lni5aa845TzS/3Ha//Thaa6gvfvIvMnNlICi5R04J0GtP6THy3GZSIQSSZlaMg8D3mPE4XJSaP7 Bkva6i1a
 nJmYebA==
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

The framework provides an interface to the receiver to determine the
identity of the notification. A receiver endpoint must use the
FFA_NOTIFICATION_GET interface to retrieve its pending notifications
and handle them.

Add the support for FFA_NOTIFICATION_GET to allow the caller(receiver)
to fetch its pending notifications from other partitions in the system.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 492f5bfa3751..6cad91ee57eb 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -581,6 +581,14 @@ static int ffa_notification_bitmap_destroy(void)
 		((u32)(FIELD_GET(NOTIFICATION_HIGH_MASK, (x))))
 #define NOTIFICATION_BITMAP_LOW(x)	\
 		((u32)(FIELD_GET(NOTIFICATION_LOW_MASK, (x))))
+#define PACK_NOTIFICATION_BITMAP(low, high)	\
+	(FIELD_PREP(NOTIFICATION_LOW_MASK, (low)) | \
+	 FIELD_PREP(NOTIFICATION_HIGH_MASK, (high)))
+
+#define RECEIVER_VCPU_MASK		GENMASK(31, 16)
+#define PACK_NOTIFICATION_GET_RECEIVER_INFO(vcpu_r, r) \
+	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
+	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
 
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
@@ -624,6 +632,35 @@ int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
 	return 0;
 }
 
+struct ffa_notify_bitmaps {
+	u64 sp_map;
+	u64 vm_map;
+	u64 arch_map;
+};
+
+static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
+{
+	ffa_value_t ret;
+	u16 src_id = drv_info->vm_id;
+	u16 cpu_id = smp_processor_id();
+	u32 rec_vcpu_ids = PACK_NOTIFICATION_GET_RECEIVER_INFO(cpu_id, src_id);
+
+	invoke_ffa_fn((ffa_value_t){
+		  .a0 = FFA_NOTIFICATION_GET, .a1 = rec_vcpu_ids, .a2 = flags,
+		  }, &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+	else if (ret.a0 != FFA_SUCCESS)
+		return -EINVAL; /* Something else went wrong. */
+
+	notify->sp_map = PACK_NOTIFICATION_BITMAP(ret.a2, ret.a3);
+	notify->vm_map = PACK_NOTIFICATION_BITMAP(ret.a4, ret.a5);
+	notify->arch_map = PACK_NOTIFICATION_BITMAP(ret.a6, ret.a7);
+
+	return 0;
+}
+
 static int ffa_run(struct ffa_device *dev, u16 vcpu)
 {
 	ffa_value_t ret;

-- 
2.41.0

