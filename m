Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B17B3641
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjI2PDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjI2PDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475A41BB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3996CDA7;
        Fri, 29 Sep 2023 08:04:00 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75F33F5A1;
        Fri, 29 Sep 2023 08:03:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:55 +0100
Subject: [PATCH v3 06/17] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-6-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=WcMcF7+EWspNtIEKv7vhK+PdYzYtK3Hl6T1/APp/RSo=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucv9DdfP5qDeC0S7ZKdLh/2EacPtt+fAel+o
 gzGvF/3OYaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLwAKCRAAQbq8MX7i
 mGymD/9pOqUOteL/bKSdzoY3NQCakLGj4XiCROjEievu5tUdHy0Zb3ttZk2FNhwO0U4GTs+zN7q
 JMY1pBn0Whe/TMy9uoR6QMHY6DydUrmxF8i/Xbg7acJwrYzP/EKGbHrD6nHsIzaw0fbVrZTqC5W
 LrCV8D0042hPxLhPqFuOrSa8Wi2xtDsE9HI0rV41qzg28H6SKgJnGLwavnGvlpsiAb9hjeNrrBC
 eO2ZS/vJ+VoZ10DcHBJrmOCXPVkzVM1KSd9nkazpTsP4Gg4NxFIQLNiCA24RT29pJm1F6Mz+1cZ
 qxPRFroeIabsRziknlj+JG2p/ezP4ZysriTfCWnUeZUIQAqxn5d1Xop+gz2dWqS5sg8ZkdHy9wa
 Waq9Ys3Mn/bEwq+JCFTqrN0bDJsdtsddVA/rahCLcpDrl0WoLDP1zmJlhf0JfD+JVEia/yhQ8Rn
 9mWF/AJvGd8/xdy+e/iL76A+H34ZXxNZ5rP2/QmxJC3Ph2encmrjrISyXwXhuAzNwk9084Fa9ES
 2rgkFA6HujhRSgn1MhgUDkGDnUJmLF57TS0LBZvuWspwiK7WEqM2G/sl2VN6ihtJIvaKqDfVSf5
 dZm5IZsQJyr2LqWGDrPh+MiyyQMfHZ5qsHsD1tF2uccVe9AukepEBy0x29Bi6VSTfwjyt1PkpTd
 9T/z+j/ZK2XvPBQ==
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
index b0d1ddfe0230..02eedb7bc171 100644
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

