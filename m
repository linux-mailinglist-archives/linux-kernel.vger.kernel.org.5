Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2E7A69BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjISRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjISRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A871C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4857FC15;
        Tue, 19 Sep 2023 10:42:04 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F141F3F5A1;
        Tue, 19 Sep 2023 10:41:25 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:55 +0100
Subject: [PATCH RFT v2 07/18] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230919-ffa_v1-1_notif-v2-7-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=M4lP+tc3FjAbYZf7s9A0uNcF+W8wy+ah17rMKCRmgS4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd07RVRasohWgmkneYDdBAwnm+z0VZdrL+/Lz
 k4lzOccqHGJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOwAKCRAAQbq8MX7i
 mHAMD/9WY6poq8i83+jU1+lc6BWslG93GKwWMvPwVYNEOCaBKgCPNauGeG6LwAqFvTB7WXZPQ5o
 eP1S18P5wshVJYGCmGxRaB1nYKXqt1ps858Kwp4bYcen7NkFgflWclHiTIGx2Nm1oAZ5Wd78HrU
 vA+GUt38o06lZQLizCe36Jaxx9EXB8kMTK6rn6OnAUZ/F37I5VDw5YTwELrnQY2qRmaPBzXAdXF
 kXPuZEmLv+/3eRqhyBMah4v2RlUmUsZdWbdEjJsOLgsS+cBRLEUXocpzOCekeu4T9uiZAXdrUL8
 XC9IHQAxHSUVLkAulX3vT+tbgmFAJ74KqlbJXPtJzDdx981YiD0Lk5xDbb6emgz4kcjMHMj+dBh
 04PPAgXfU1e2gTLy1+8Q90WnUJAQ5i9syPMLpGXDGeMNaeM+8G9XB2JVhvJvIe3/QgJeDktreE7
 ZkaN6vAYBOl+2qZ6B4gpvKc5or5HIZ6j6dyK25nTcd6nUY9BtfIIvLKPt0A7kfF5iIUJTpnpkTI
 uqyIiCURilh3GkzQsuad8lMTBthHytCyapdUojxk4+NnlFoP4ipRC7YtTuluvUK8oQ2eAi20R0F
 LKw+KQHwzWWHzQZhObbT9snbeG/WeByPxkR0crPlBkQ4hPBwba7USNuoIV64wpgAunF2pZVZ22o
 7gAvfKR1eo+dMig==
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
 drivers/firmware/arm_ffa/driver.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index acb58715687c..e097e894b433 100644
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
2.42.0

