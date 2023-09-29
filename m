Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73787B363D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjI2PD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjI2PDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AB141AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A80311063;
        Fri, 29 Sep 2023 08:03:56 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9973F5A1;
        Fri, 29 Sep 2023 08:03:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:52 +0100
Subject: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=6dM7t7UcezChOGHUwYllL2LxWCmWJi8qtz0lRrVzNQ8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucuri2NvMBd2IjxYNO/D03XgYBmvOLA9YjLc
 idNzqIiTE+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLgAKCRAAQbq8MX7i
 mNOuD/4+jcPMdjdx5iTpJDFKJIU+T08pss3uCcdy0GEF9cddo335kSH2rAbXlNk4XHH150kw9K6
 NInTCOWpnCVvD+Wk6I7pKYDd/tzKh1KVjCDpRtRLx7g1B8ihjnxthRTCrPfW59G3VnS/QSV9KJG
 GlGLfx9VBDIazIYaHrHEkvvKEla+rLU/MkLR8tsFSFssXmpA/GflTEHkhO0oqLgst4InUYFW7Rw
 aTBrbwjOWCFmuqr7xV8IaoLNaNAzZV6bh1pFziLwX+yLxZCUBQV/zo/ptQGaVLTj110JE6GCv/h
 +QUPZrnjOClVOffWhXtHa1mwQ7a0Pt+sMymCaSszK4xddfnOuHwm0/DavXf2qMHMiovdQYf5yro
 K7NqxivFAX+2WLsp4vLXyqXhIlq71OuQrVlxv5NVzrw3tgAGJQPxmKV4i1pqrq3QII8mDYYHLj3
 a/nDOfABp7AhYVGZBAUQq5njecxdmJl+k3V2W1jAS5+TahyPrgEQG+U/aJVQf2h6YXnFaEig7Ar
 zFLcB4iIldYmZT6ZY4bLawjD5CKPEsbKa7ya9kYh8EM/4oU9WsCMawjgAgO9EL4i6j7pRRj5aAR
 NXnyPYf3dTdYpQTGzZxstOj6dAf/08kehdTyFTkQM80QG4peBrh9Azl8ldq6hTjmO4joZS7G0Ig
 qiCKLrfOcFW9VFQ==
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
index efa4e7fb15e3..26bf9c4e3b5f 100644
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

