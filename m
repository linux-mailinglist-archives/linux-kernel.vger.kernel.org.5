Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D976F32A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjHCTCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHCTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927E03A87
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44B2C1474;
        Thu,  3 Aug 2023 12:03:14 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2965F3F6C4;
        Thu,  3 Aug 2023 12:02:30 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 07/12] firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface
Date:   Thu,  3 Aug 2023 20:02:11 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-7-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=vUn1QvDYVuAhz5nSv8RI4UWRh34UK5ah39o6Vq2iky0=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iNZpp/pP0MmrPVLW0ACWS8Vn6AitaczmJGu e5T+SQ/VKiJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jQAKCRAAQbq8MX7i mJW2EAC38Vo5Z1tQ4bEfw6f7VUZSfT0cHcJGkGSwlYQb3U5Gteiznl0Y6uFmwbzXyIIsQqe/o2C zVbod+Az8Id9lXe/reAqYZVMArZpcrpyWvI1CHYDLISP6T2RZVAyF9kfK5oEic5ClHE4z1wADYW 6b0Iklk3kxzZ4oUyGAMZQQ7TKyXeYsetslCQfwtgqbSfmyPB1r1EvmVaI1161M5hGoIp3so8aCj EUQvAZJF9gYU1Oz6geRVpCzz5TO2d4yHrMJGehIi8V+OvgJojtOVlTJOCrexja/lgjobNitIZAH 4hxiDhKH3n3Y4+Zz7M2njj4wVYXF1uLf9li9UkDWkQZCyb1htfUIuvOmGN/HJU+Fmc90IMI8wUI Y1RX9pAIXALtYm7sb5AP6lIr3enUlzhPSSO/iD9YKOot5fEdKMySvIWhrTHrzJCiqrc4C0BnnhR isPXyZCXyKeCsNzOtlLqkly7Ubd1u+Q03oQZMpwylUPJOnYoDcu1jKIOs1WWrcrIy3WqNd1PHjt C8TtyS+MmmOCPdHXIpuINrbVngxpS3X220B8uDbWqQqNtWLstuG/d9fJqOrOhb6bJOJR+4/QzJd HoDljVhBbCGHtgVkgpm/dKzLVEmjLoWMO1J9M/iXhT0UqItOpI+JtLNf9MAJZDpvOwZo1tZssXt agPiLtT+
 NEDYTcA==
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
index 6cad91ee57eb..77ca9753e3f0 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -590,6 +590,13 @@ static int ffa_notification_bitmap_destroy(void)
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
@@ -661,6 +668,69 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
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
2.41.0

