Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDA7B3640
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjI2PDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjI2PDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D77C71B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CAAD1FB;
        Fri, 29 Sep 2023 08:03:59 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9E713F5A1;
        Fri, 29 Sep 2023 08:03:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:54 +0100
Subject: [PATCH v3 05/17] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_SET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-5-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=NVitlqlRV6z20CY5oo4iFS9EKuyldYrTV9XNc0cCWyc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucvy4pQu2saUIRdI36LiwoHG6ULgL6RfFRQi
 fMkLTenBjiJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLwAKCRAAQbq8MX7i
 mITrEACmc38jc6FrQ9DZH7qAj0dD8/GukHrMcd5qq5SLIcbmUX61YipNeM7Kd2ppRcbWZ/xGm2Q
 AulqjS6eYgOY2h27Rp5bcyYpVlxp23XO9No+SELhluA0oG9uwlJXihjfG2/RbtQxbV5d0gQ59d8
 Ttd797Cq5/SSIQzAl98HZfRFnTBPv/gGN7yyIA92eJis8mpuW1jJcj4vPlooG9cqkE4Eb2aoraM
 agoNF6JPVw+qDCNyJKNq6igaw0zHlQzrT2Hv0OFuX88eHjZb9dtGaTRJ0saCtj/GC3G4LcD89qG
 ekKeFQL8jxcZQHCbSbcZ4CSUsFBe+NRTiNi7bvObHMlQgjPiF7Ucy9rX36ReR7iLh5suRXBd59g
 iMzZK2zKs3EKXnM5W31d2iT4pKgVgvSBhkF/diAH01uAXX9x4/cVVQ8n2Ji4tPajh/R9eNOSPIy
 c3NAvTm09R7x6E6YYE8b1gthZ9fiCiueKuyk7Dk8NhPHzyGVJn3ECcGVgO94aiH4rQmkZhrSORs
 vEsxUZiHHw+rYa1UOp0hmp12I2QBFv6nfY6nDdyWKnOmR0dAPVffO2OjvAPk0Z+xTRkZtK931JS
 gfZwD0xyCQPB6XHe9G52fWY6Dqr5puzKz5qDATddMmVtAx1Q6kM3/10UMRYla3G6kO623MzgD3r
 I/j4tJUpRtZIDAg==
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

The framework provides an interface to the sender to specify the
notification to signal to the receiver. A sender signals a notification
by requesting its partition manager to set the corresponding bit in the
notifications bitmap of the receiver invoking FFA_NOTIFICATION_SET.

Implement the FFA_NOTIFICATION_SET to enable the caller(sender) to send
the notifications for any other partitions in the system.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b265063e76ea..b0d1ddfe0230 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -616,6 +616,26 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 	return 0;
 }
 
+static
+int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
+{
+	ffa_value_t ret;
+	u32 src_dst_ids = PACK_TARGET_INFO(dst_id, src_id);
+
+	invoke_ffa_fn((ffa_value_t) {
+		  .a0 = FFA_NOTIFICATION_SET, .a1 = src_dst_ids, .a2 = flags,
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
 static int ffa_run(struct ffa_device *dev, u16 vcpu)
 {
 	ffa_value_t ret;

-- 
2.42.0

