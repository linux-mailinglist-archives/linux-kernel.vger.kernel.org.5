Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9B7B3642
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjI2PDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjI2PD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F509CC4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FB11FB;
        Fri, 29 Sep 2023 08:04:01 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103C33F5A1;
        Fri, 29 Sep 2023 08:03:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:56 +0100
Subject: [PATCH v3 07/17] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-ffa_v1-1_notif-v3-7-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=dQUQF6aKVXxeLM41f9K20i0Yq+P0jCynjIfIlm9Bp8g=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucve2qtLbbccIMHbNg0cUf8hiyVYCCGIRU/s
 AUdAu0DaQyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLwAKCRAAQbq8MX7i
 mL5mEACznJSiwoQJn1cxlk6mI1vNela97vgqL1j821bBPau8I9q9uEkahsMEkK8ZMejEntkD1c2
 JgdvOhL3f13iNoysjiebYplIRPJF36hgRQ9fdwsv+bVL95NtRcoliH8dNvPY1ftgpuk7m/cfZbT
 /Yb1wzb4hklyhzCb4XW144DqTaElVUsaeTRoIIKZCWPnwXNuWgVmB2/xHfBm91m0SDz9o6w3ZD6
 8IHsknrXCp5Y1ETDm9EvfTVzHgx3N8MWbBx4ijgUrIHhpLpMtpw+ooJa4Jnl2/Dnq01WUODNcVS
 ZjTLOkkE1gEBGjZAlrgXm8woWgAMdyjlXMlYaOl2LUmHmSGx6xKigCLvtdQoJ8cVobgY5PzlyTo
 VXaoLW5r6mIzMe1mOcbcJIddUTm0+a+GFyASb1ob+fCnjemXUlmMx+re2lIzi0La+Z1WLSQlgTj
 fpXAdk74k0xCEjY7oVPlB4Kbn4hgRatx7Fr6QGuif6dNdZq9B91nK4dJxjwQUXP6ylWlPJ35/6Y
 W+FopXFpC9zYyOPxlCPPTWu3bTrAad4gbFUFWjg5i7LZqcQeRUmMZYDY/CAATfRwHwfy9ncUvPP
 wjAcBOYAbLC4+vNjcV08PNxX9UH8ExHo6oYxxvsppBx5xWaVUfiCl8FZ1cHfiZ94R8/zX9pnI9b
 oqr4LayRyO3Zs6g==
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

The receiver’s scheduler uses the FFA_NOTIFICATION_INFO_GET interface
to retrieve the list of endpoints that have pending notifications and
must be run. A notification could be signaled by a sender in the secure
world to a VM. The Hypervisor needs to determine which VM and vCPU
(in case a per-vCPU notification is signaled) has a pending notification
in this scenario. It must obtain this information through an invocation
of the FFA_NOTIFICATION_INFO_GET.

Add the implementation of the NOTIFICATION_INFO_GET interface
and prepare to use this to handle the schedule receiver interrupt.
Implementation of handling notifications will be added later.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 02eedb7bc171..dfeeb751bebe 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -602,6 +602,13 @@ static int ffa_notification_bitmap_destroy(void)
 	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
 	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
 
+#define NOTIFICATION_INFO_GET_MORE_PEND_MASK	BIT(0)
+#define NOTIFICATION_INFO_GET_ID_COUNT		GENMASK(11, 7)
+#define ID_LIST_MASK_64				GENMASK(51, 12)
+#define ID_LIST_MASK_32				GENMASK(31, 12)
+#define MAX_IDS_64				20
+#define MAX_IDS_32				10
+
 static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
 {
@@ -673,6 +680,69 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
 	return 0;
 }
 
+static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_per_vcpu)
+{
+	pr_err("Callback for partition 0x%x failed.\n", partition_id);
+}
+
+static void ffa_notification_info_get(bool is_64b)
+{
+	int idx, list, max_ids, lists_cnt, ids_processed, ids_count[MAX_IDS_64];
+	ffa_value_t ret;
+	u64 id_list;
+
+	do {
+		invoke_ffa_fn((ffa_value_t){
+			  .a0 = FFA_FN_NATIVE(NOTIFICATION_INFO_GET),
+			  }, &ret);
+
+		if (ret.a0 != FFA_FN_NATIVE(SUCCESS)) {
+			if (ret.a2 != FFA_RET_NO_DATA)
+				pr_err("Notification Info fetch failed: 0x%lx (0x%lx)",
+				       ret.a0, ret.a2);
+			return;
+		}
+
+		ids_processed = 0;
+		lists_cnt = FIELD_GET(NOTIFICATION_INFO_GET_ID_COUNT, ret.a2);
+		if (is_64b) {
+			max_ids = MAX_IDS_64;
+			id_list = FIELD_GET(ID_LIST_MASK_64, ret.a2);
+		} else {
+			max_ids = MAX_IDS_32;
+			id_list = FIELD_GET(ID_LIST_MASK_32, ret.a2);
+		}
+
+		for (idx = 0; idx < lists_cnt; idx++, id_list >>= 2)
+			ids_count[idx] = (id_list & 0x3) + 1;
+
+		/* Process IDs */
+		for (list = 0; list < lists_cnt; list++) {
+			u16 vcpu_id, part_id, *packed_id_list = (u16 *)&ret.a3;
+
+			if (ids_processed >= max_ids - 1)
+				break;
+
+			part_id = packed_id_list[++ids_processed];
+
+			if (!ids_count[list]) { /* Global Notification */
+				__do_sched_recv_cb(part_id, 0, false);
+				continue;
+			}
+
+			/* Per vCPU Notification */
+			for (idx = 0; idx < ids_count[list]; idx++) {
+				if (ids_processed >= max_ids - 1)
+					break;
+
+				vcpu_id = packed_id_list[++ids_processed];
+
+				__do_sched_recv_cb(part_id, vcpu_id, true);
+			}
+		}
+	} while (ret.a2 & NOTIFICATION_INFO_GET_MORE_PEND_MASK);
+}
+
 static int ffa_run(struct ffa_device *dev, u16 vcpu)
 {
 	ffa_value_t ret;

-- 
2.42.0

