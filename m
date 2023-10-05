Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B97BA23A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjJEPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjJEPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:21:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 508AA9EE0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B60153B;
        Thu,  5 Oct 2023 07:45:55 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FEBB3F641;
        Thu,  5 Oct 2023 07:45:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:00 +0100
Subject: [PATCH v4 07/17] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231005-ffa_v1-1_notif-v4-7-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=CxdxAVY/MTl/iCsvKjrPq0pC+5xP2GJmZN5U5PgPO4U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvxEQ3Lxe6D8SGBgmlxd7WIweA9a2k9e1/F8
 qW6cSsYxT+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8QAKCRAAQbq8MX7i
 mCVBD/9Xn3XgDDApkwxp7KVKVIg7rGT1Sq9ths7IIjgjpfYaRJ6zeZFgdeS58z8U1QkcvWwU7Vf
 3x6ZaO4qOQvFBclszikt9H58PtlFYKbt2PcYJDKCduZizKD/nOsjZvSOQJYzj4LHVJgkaSP9q5h
 X7dt7grFJgUOYHQYANvQ+/Ime/WfxFqvGOUppRjF43r8ULCJFm7YB+WnGvWhaKFkHDeHuSDK29o
 rzd1XL3DcZgRwPjyBDqxfTPyzhQkBJL9syVxjaiWDkeFvtO43kugc0S7UzvbhghsQyhvyBCZQKu
 SwlHDORZbwvv5kguLGz7iVG4hoatsia+GSRo+w5idN6w8BpcOqYV9E8zTs3KY13hNM7dw6dCl2s
 cYVjNGdJyE/8NVGbBmOaaD7LWm01HgmiA5PjRuIq1UiauwSrjr3HRXCf6oOfemPCp2psr+vH/8d
 cl/A3fLYh3QX+KneRzUrbahJ4KW5bTaQ99XhbLxkZH22a7zYZl+IV8MrXXTaTZ18TeXr9p3s7kx
 CIOnftd/qbT9XiQyB+9Tf/+0gwUWPvHNwA/oe0wT0EBzQOWggsmiQp5VoJ1mpzud8O+mIvNbSbM
 R4P7GNVFn7yD76gDTZk8/RD39Pqyu/qCIjyrla8bogW+DUYW7wkb2wW1tza5b0zbwNzie2vZl89
 6IaQKwjmzuV/+SA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/arm_ffa/driver.c | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 7a0ac4f496bb..b1dd8539ab0d 100644
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
@@ -673,6 +680,72 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
 	return 0;
 }
 
+static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_per_vcpu)
+{
+	pr_err("Callback for partition 0x%x failed.\n", partition_id);
+}
+
+static void ffa_notification_info_get(void)
+{
+	int idx, list, max_ids, lists_cnt, ids_processed, ids_count[MAX_IDS_64];
+	bool is_64b_resp;
+	ffa_value_t ret;
+	u64 id_list;
+
+	do {
+		invoke_ffa_fn((ffa_value_t){
+			  .a0 = FFA_FN_NATIVE(NOTIFICATION_INFO_GET),
+			  }, &ret);
+
+		if (ret.a0 != FFA_FN_NATIVE(SUCCESS) && ret.a0 != FFA_SUCCESS) {
+			if (ret.a2 != FFA_RET_NO_DATA)
+				pr_err("Notification Info fetch failed: 0x%lx (0x%lx)",
+				       ret.a0, ret.a2);
+			return;
+		}
+
+		is_64b_resp = (ret.a0 == FFA_FN64_SUCCESS);
+
+		ids_processed = 0;
+		lists_cnt = FIELD_GET(NOTIFICATION_INFO_GET_ID_COUNT, ret.a2);
+		if (is_64b_resp) {
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

