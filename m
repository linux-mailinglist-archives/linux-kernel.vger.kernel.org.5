Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A876F325
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHCTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjHCTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 184B61713
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD5111477;
        Thu,  3 Aug 2023 12:03:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B17223F6C4;
        Thu,  3 Aug 2023 12:02:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 03/12] firmware: arm_ffa: Implement the notification bind and unbind interface
Date:   Thu,  3 Aug 2023 20:02:07 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-3-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=3OYEZ9E7vpg3yPFg1J667JzF5mZtHS9nU/hUd6LN5Ks=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iMR7qOL9Zi5z8RhAxhVfjJVsHMbQnTx3Ufe 4oIltWTY5yJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jAAKCRAAQbq8MX7i mM0jD/9XM2IgcxuAMRlGOA0NjXZYJLOQhVTzf5TLKjbmRV5nA06MK3WxFLrNfdT1gjWqNVSRnni Nc5eASG2Wd4vb8GG9tKcrr3R5/KIuIRXe4VTlX8y8vUpteSeGKdJc9uRq0ZTrZ+xY2iG4tQDNg4 cW8ORBHJ59Aw9K6GYa4nUm6rqo2oMUOqLtY2C037F+fdB4bVUve5abIP0Ztadp/PiRDmzE+RiDY 4hChusP2o+dYakJz9uQPBhnd0MqLw48I/hypdQhEz62FYc/bnhI/TRE0RlwVPFynsRgGFv98m9Q HMOxgJEqE9tW+nXAIn8+Ak75ueajWk2lVTLeTdRIZy/TWhmXMONqxY0OPEIRKK5932viifLPumB uIx6VvwugAnD5m2s5fRObNOxXb7H3b1eMhLBUX/FK9qwltkSON0B39dI7n9mCwvtNPq5KmMZiH+ 3iUp4H0RQfL5PL1Y0kYhv10bYoYZhogcjVoMuXNyzZ9rfqxjeJnO5qKSmNw5P+/Ybl0drjYx1lU kGYpHoP2Gu8Cc9evLhfeZlbthzIxRZ3Mm7cW1i9D084bh2vIAX5O9pJN6thnWwuLTQam5sjr4I9 88PgMAjGkpyfu9tXxApQQV8Oct3Xp3OvisM9Gb52J8zk/CNCOzf7k8x67yYS+48qyViu0OQ0v+N Ko1L7Vlc
 vChz1UA==
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
index 022c893c9e06..a76e5d3a2422 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -575,6 +575,35 @@ static int ffa_notification_bitmap_destroy(void)
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
2.41.0

