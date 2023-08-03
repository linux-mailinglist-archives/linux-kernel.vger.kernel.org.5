Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5876F328
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjHCTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjHCTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFD412D45
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F7B14BF;
        Thu,  3 Aug 2023 12:03:11 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DB2C3F6C4;
        Thu,  3 Aug 2023 12:02:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 05/12] firmware: arm_ffa: Implement the FFA_NOTIFICATION_SET interface
Date:   Thu,  3 Aug 2023 20:02:09 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-5-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=gIcrWaE8JjUgJBbBV1coOUsOSzQnr17FTAXR0ZVKxfU=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iNKfnamF9bQ6t4TFfYJFZV5REuiS1Xy3AD1 vlZ5aBZZsGJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jQAKCRAAQbq8MX7i mH0iEAC6zQT+zR4ZBTgQfPzkLYDo+kli3u41l6gxWq9DroxO21dHwyuoxTNebt9LONyflU9080T 3C8Esz2fATBbZepXXtLymI/w5eqABbzsqEyhNbkO5tvJEFuzlfpWjdI0pH7a87uqhDwNU+SfmGi ds4bySxPNCTe3VCYZtLKwXpHkys63ide10vyGav0i0PHiFVTa662IKduPD++3ilsRcsVauaQaSq 8zx2Eg+MbDxSizAnii878HgO68JWasJ16Oedm2sCdS5nBAZ9ngasItOSBduaDAc+Vl5VkQyiYE+ hMOHtvdsRLSQVc0GTDuus+MKboxaSwqxjvjUOyRNHne/MQshMCdg8nr3I9WmrWyXlhMDxC7HbEo 7EjHYevbXwvbZtb+HjyDreSBl7lCR0p1Vr5xL0NNMQY/UHHgz1mJSknxpTgTJnTemOUOORVWisv 6Zvcpg4zJt1ve7v4NnspCL/jdD7l2hfGQULukUBDAOm6lxOzfyX7gBp7cQFbafhheMTez/qTUqF cVuh0MlSTCisXkaOPA7vMeJlc+MiQWqRyWE5qBN4h2seBZQ26M1POhMtzpgxPKLwi8VWQE7ReN8 EARC93Fc/nWtWxn8fw72W5j2peB82WNDTyOSLgDT9y/7/Qi7KfWOde4AS0PEc8cXutdqfcL3Rim HxtYrY/f
 gkkqNLQ==
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
index 41171ae7f63a..492f5bfa3751 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -604,6 +604,26 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
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
2.41.0

