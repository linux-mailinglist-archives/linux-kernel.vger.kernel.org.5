Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC87A69C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjISRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjISRl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DA12C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DA5E1042;
        Tue, 19 Sep 2023 10:41:59 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422033F5A1;
        Tue, 19 Sep 2023 10:41:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:51 +0100
Subject: [PATCH RFT v2 03/18] firmware: arm_ffa: Implement the notification
 bind and unbind interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-3-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ET5oJlM5G7gOdj/dFHjwPTU08+J7ULwiBffB/kiZbxY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd06hqwaMTYfPjR5qE4M4Yy7h0Ft1HHqLok5k
 23GPg9+dH2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mJ0qD/4tbaCgUPxoghPMR9Kw2eY8cOAR4cve4ySgZIvcsthhY8X+avKefW8wZg+UwbhviQeZ9zM
 DjuYLnO0t0lgr63EVwa+LENFZQYZDLXyJsZViehXTw2mKTbuN21pWx1FC0u0N2c7WuTziabTzvs
 To5DEmMTRwWf3HaV9JxL25jHTn11eS7F9kjxT0Fxx7Dv1kt1xdITlTqyHvDh8h3ydauuJSf4jRe
 EcAV7Ss0uQs1ppFOTCQNq1RN/OUg22duopQQ0cBi+x3Fq5Wj0vm7SAo7XyiIqS51W69JwJ9CnEC
 AfYX64FXl4SvPFZP8CEL7jJUFMxi+0KjOYn+4SNXgSmUAsSj1wxVPNa2swVpYuLzNJXbZVonVdt
 aknp6w3RqTCcK4MHQw/RrI5P7LeW4V43MUsAEuaMhxrwfVjwmI2dlXwuTfCMmltQWLzb8bP7N5h
 pQv5AJyxyEaThIawRKbCoK7N8NYkQiduVNK6BjT2GVWRKiM9JWjdTY7upzDArGfirGm10rJvDhh
 YecHn6F1XoC+CUzQBvTCDVcPkL6cKIdckCl/VTlUiD+lVds08VG1uZJ8+Bbd94RnqKDwxa9qDdA
 xUQ/9Vnka8EPOZdUPfEeCROP6zqvEUsNr3LPXn9UnC1dqW2yqkYr8jVID/tO7r+2UnHYD/gD40e
 UuECNfBYDi9XNbA==
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
index 5522523afefe..ab67cb22a206 100644
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
+	u32 func, src_dst_ids = PACK_TARGET_INFO(drv_info->vm_id, dst_id);
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

