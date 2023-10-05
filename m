Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157727BA464
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjJEQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjJEQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:03:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448519B7D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8444152B;
        Thu,  5 Oct 2023 07:45:54 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E3F83F641;
        Thu,  5 Oct 2023 07:45:14 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:59 +0100
Subject: [PATCH v4 06/17] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-6-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=JcT3Ibz8prcH4LEIf0QXidGEqQ8ig8451gBfq+wr8D4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvxvFGznmnDBqCTWy0NqxVWxtJHCRuDBexLt
 2bYjTzDE3OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8QAKCRAAQbq8MX7i
 mERnD/4qCvT3/HHxEq/b26JmL747hInAIaYIfi/Td6/7hwAKc2U4VIbtgn31Q0N7BZqt6uPqV1Z
 MsN/KoXXC80NrC7hIewgMZvSbz6Qyqd6iM1O87L/9YHjWM2tqsFAu2BP7eQqhvkJROEUYtvNeSK
 JVYdpJo9CwznRP91qloacnqHJlWhIT0ijwEN3zJzsRiQ5f9jPHAml3B4j6SokSNdhmqrnJqNMK5
 t9/gwH2aAMbB6bOI6+fdizycB2HOu9/YLMW6JgsjhGitHgNj7q+7mZzeQ24F+vdGcvS/rAHJvTW
 fNFQlvLo927ZLqLRzBeSFHAv28cDK59Y2l5+2QmsDukXZwDbcf478OAqxWq6SnRTJzLvZwx9Rbx
 cMkupybn+cuV/Y5eOG4bh0t7txXL4ElvmELHOZrg+HlBuEwNoc6SiEi3/T2baSKSkEWpbMRBb72
 hy9VECbyvs+IcizjiQopX19+J0OEMkTpkL+WFOiyJEBrnHDACfdSuGlZf44KePvCTTUyDGWKttd
 OTIvugwJSoRNpyLayc6QLbQWDDgl0bYO9dTeNNUZOx4HQAJldZ1dBlHF66Apewk91pfo7oQ9EAx
 AhnfDhPYiczjb22X6q6NU9BNIBLKQomgJuqqZaA4fXfUVSHOPP+oWsZJGPl8q0iJy5pXDrxd0ZY
 I+vqGuQmy4LPt+w==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 4edb3cb48014..7a0ac4f496bb 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -593,6 +593,14 @@ static int ffa_notification_bitmap_destroy(void)
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
@@ -636,6 +644,35 @@ int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
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
2.42.0

