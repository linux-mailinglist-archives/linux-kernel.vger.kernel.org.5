Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C47BA424
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjJEQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjJEQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:03:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44EFA9ED2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B101516;
        Thu,  5 Oct 2023 07:45:53 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0B8D3F641;
        Thu,  5 Oct 2023 07:45:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:58 +0100
Subject: [PATCH v4 05/17] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_SET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-5-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=4q7IiagFj1+jcbEerM+tVmHVjhNoYEy9g+TfTOniWJY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvxU+OC43JQZl2rh/aQ5hxCbL/2rnY6mISRn
 pGTv/huwB2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8QAKCRAAQbq8MX7i
 mONFD/91SNwLzgvbqoev7AcemtwFwEIcUq5ymafJb0GYsSNhSIHyE2Fc0QDnD5JgTQvF8Ww7bCa
 MyrtPbAxmPj+VkfD75JZmgXC7v0nVPjZ69uR+7D2kP2PxNOFiz2q0HCYkpTe6MumZGA4a+xWlrW
 il9Rc3Ylp2GYlRp/k4nA+JIhTSoqlqo4p+2Mzr52ESdNQrMyqiPIXM+qjcL13Tlb922K0ZfoNJd
 ElfDaqGRnnn/6yMZGzItAbsp3BnOXpjZtv4s1ogVe9+P+5RCwTGSrx4J1LM2lD71mQKB2ibjp2R
 OmErG7UrdKtHSNkfII9fiAffYeIJ++KnBX/1KWzpoRS7ssxnSy42bsi1DxKYUrbuTKLHC3brOxw
 1hU8XanUC/u+SxI4ciJ+xpVxxBfdGP0aQQ65qwfgyTAKFNka9IYXK2mDCHjVg51VqEV0Mr8IlK1
 VoggYkLvIFjuDM4mdGSf3Hi40v2Jvw2vNmCc05bXgg8re0mkLkdb9QgPbnmtE7y1cQeMiz8PxgL
 iuvKwiuOc0AFBXYA/pJlKmV3mGH47ffFqhOvSxDGcdYqIG/uh41kL6g+S381gOSz7VPfG/S4ZXS
 W3YPGIu6toky30eaLCxxby8VqYvn2IRsTMMcrh/6BZmuSXm27BykzpyPoIA9iDds6LVrS+okCZK
 +vJMXWVolUaXsHw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 82e54d231074..4edb3cb48014 100644
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

