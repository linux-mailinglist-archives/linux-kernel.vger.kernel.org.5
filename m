Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009B7A69C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjISRls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjISRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08406A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CAC41FB;
        Tue, 19 Sep 2023 10:42:03 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A583F5A1;
        Tue, 19 Sep 2023 10:41:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:54 +0100
Subject: [PATCH RFT v2 06/18] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-6-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=K2YvsILaFgpr4lZX+pTYFCZTBnlVK2W1JnRsJZazgIA=;
 b=owEBbAKT/ZANAwAIAQBBurwxfuKYAcsmYgBlCd06QXKkqx4Wz2xxAT7OvoEFG10hO4sIVYO1m
 jdo2RZiX+SJAjIEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mIv9D/ibxw1xn1QD9eCMGeI6hx5YcyE9Rq6Jrrcn/9J+GfmOt1/ZLNNIzpcf4cICA7hwBGZCkdW
 td9eOsMYwiYiBR7lnJEKsPpPRMu38uTXQmOOBp5wUR7ap6NYOrV2L1Haik2ip2rjrDEZ1wiYKOf
 FS7P0661KKQJLrJyFnTqisEjL661m7cNVynYDxZBkjQychPMhfjrDu2dhbrSpgFN0BeiGQCepjL
 vYzRqwVeJacXpCeCLxe589xpQdV2+CNtJj/lLIkFHl9/XfqmPve7BBl+nNBonwcXaqaKU4FGt2q
 ETRf1UtD2lcsCfsGmixptpg55Jrkwysxl6zpFVBJwPfOd2vkmeHNwk6yvjeAExKYPQU1SBDFWK/
 1dv49RA/ryCZe7tNDF9ctSNTAWyO4tZ6N41TqUwsiyHsZVG8B+1YxV0FkO5V5Ic5ctrQ49dFWFL
 lpLTcjQtdT2F89djZsac2yU6fUrfZ1s+sUIUIJCdfGLzmhywVByVLkb31bUGuitj7YLFkQeNWTL
 Q25HUnvee5R28bkWi/miPN92q69Q8LR+YMW1z+8OT71Zdc9OAcbaKyAAN4YsdwpeW/P++opehLN
 nUJ42SioPPwCrxPQ7zYQYI4t4hTBsvSMSZzzuhOL3tCFFUhw/JE5mvD7FTg9TsuVw6Bv5PndhXw
 tkaTJzarr4Gd5
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
index 2aae838ba46a..acb58715687c 100644
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
2.42.0

