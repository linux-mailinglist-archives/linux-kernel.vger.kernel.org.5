Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22C7BA432
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjJEQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjJEQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:03:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11C03869
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23273150C;
        Thu,  5 Oct 2023 07:45:51 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3DD3F641;
        Thu,  5 Oct 2023 07:45:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:56 +0100
Subject: [PATCH v4 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-3-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=tCh7LbKeNAevFd5uQSx03qEkiVl/aQEeXvD/r/UF4UU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvwFDa1dLaZiLdaBoo+tK3/uFpNRlVXwQfJU
 v79YnQB7lKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8AAKCRAAQbq8MX7i
 mLWQD/wLXEyJRAXmNV7481V9rRrEOHvJ36UfKSIWMkvKASOA5tN91M1Orlf6679gmfJJDBvv8SP
 X8CpzgeqIgLndGOcvlgUc6sKgXdT2QHLzGMqSlp1zh6NNBzuH0CCY9YjZ+CGIHBB+vWPPL47OQR
 VcuIKfuU9VXpea+xynjlRpwkoqgjz/YGTSL19m3GOfUW6GSzopPt0aAVibxZK7PQBGRnqYbKMcO
 NkgOexysE6f9G4lhGDOJfhErVsR4D3jNpMh5UZfLxCi1Jd7Ehjxo8qT2SmQQ9Kf79rwsRbGakpv
 j/sU7v5lEMsDfKRyJPc9QT+mGcVv4FpPNySXQDWLWk35gS7Vk1hZxkkocYP1z/6HYsJMkhCSsyJ
 4mGhqnGr9KiRwMhuUNBBi4vJjI4tXqCP+QahymeH4WfnlAt4P70SMXy4TTadgIPeoloJYQQa298
 TG0iIjeHhIsvuVombabM1TmrG5EGsfhwomwXxhzl6KAojYWradn5YXCbOWOfoTJXeueuxfvASH6
 p/YqWegmTZ7RtKxys24QRT1RvxOnCj5phnY8nqFHrkicnZL8uiHewpV4UN6yNvPdSdEwEIP96mC
 jXGiYEKjH2d9OYaTf779pGMbGf6ha1eNRMyOeoa/Vq6iilHIcNcBSoqvxabFOqVMo9FFGz2/BYJ
 eN6H/Li3w/s+KLw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A receiver endpoint must bind a notification to any sender endpoint
before the latter can signal the notification to the former. The receiver
assigns one or more doorbells to a specific sender. Only the sender can
ring these doorbells.

A receiver uses the FFA_NOTIFICATION_BIND interface to bind one or more
notifications to the sender. A receiver un-binds a notification from a
sender endpoint to stop the notification from being signaled. It uses
the FFA_NOTIFICATION_UNBIND interface to do this.

Allow the FF-A driver to be able to bind and unbind a given notification
ID to a specific partition ID. This will be used to register and
unregister notification callbacks from the FF-A client drivers.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c2ab6f4cf296..20f8f4ca8e89 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -587,6 +587,35 @@ static int ffa_notification_bitmap_destroy(void)
 	return 0;
 }
 
+#define NOTIFICATION_LOW_MASK		GENMASK(31, 0)
+#define NOTIFICATION_HIGH_MASK		GENMASK(63, 32)
+#define NOTIFICATION_BITMAP_HIGH(x)	\
+		((u32)(FIELD_GET(NOTIFICATION_HIGH_MASK, (x))))
+#define NOTIFICATION_BITMAP_LOW(x)	\
+		((u32)(FIELD_GET(NOTIFICATION_LOW_MASK, (x))))
+
+static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
+					u32 flags, bool is_bind)
+{
+	ffa_value_t ret;
+	u32 func, src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
+
+	func = is_bind ? FFA_NOTIFICATION_BIND : FFA_NOTIFICATION_UNBIND;
+
+	invoke_ffa_fn((ffa_value_t){
+		  .a0 = func, .a1 = src_dst_ids, .a2 = flags,
+		  .a3 = NOTIFICATION_BITMAP_LOW(bitmap),
+		  .a4 = NOTIFICATION_BITMAP_HIGH(bitmap),
+		  }, &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+	else if (ret.a0 != FFA_SUCCESS)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ffa_set_up_mem_ops_native_flag(void)
 {
 	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||

-- 
2.42.0

