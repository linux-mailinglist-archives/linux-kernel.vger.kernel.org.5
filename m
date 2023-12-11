Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA480CBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbjLKNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbjLKNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F7410C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EADC433C7;
        Mon, 11 Dec 2023 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302802;
        bh=1EcZc7LK85IRptVlTFpO7CbCNcbwhl3ThtWuK26SezA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMZEiPwKtCGq5xyBLLCNt6t8HdQjmI7sFZkoZwu3vVeAsI2YKOZTUyWo0ZfwmqALl
         AwQwFQZtz1ApGDmxE5TySgx/mayreZUcKjMQfPUt/bPYN552zCSfCc6kHGy6VHExP3
         S5lCo2PKvRfKON2yPItwzSzPHQGEfglt4v0T/IAU4Eua4KoKKH/lQl0SEVFJ+yJQl4
         30Qqcx6oNdF99h7lQAvuJZmD20RhY1XWlF2A5hFH6+hScieLR36XiADMM7GQXqoO61
         kUthYyUqpO65Z29KMyYwVvYM3Oy7LPPm8/zl6Offvc6BO+uw1KYbdGQnrC0eG2LaN2
         vbU0pdYMBDm7A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bitao Hu <yaoma@linux.alibaba.com>,
        Guixin Liu <kanie@linux.alibaba.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 34/47] nvme: fix deadlock between reset and scan
Date:   Mon, 11 Dec 2023 08:50:35 -0500
Message-ID: <20231211135147.380223-34-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bitao Hu <yaoma@linux.alibaba.com>

[ Upstream commit 839a40d1e730977d4448d141fa653517c2959a88 ]

If controller reset occurs when allocating namespace, both
nvme_reset_work and nvme_scan_work will hang, as shown below.

Test Scripts:

    for ((t=1;t<=128;t++))
    do
    nsid=`nvme create-ns /dev/nvme1 -s 14537724 -c 14537724 -f 0 -m 0 \
    -d 0 | awk -F: '{print($NF);}'`
    nvme attach-ns /dev/nvme1 -n $nsid -c 0
    done
    nvme reset /dev/nvme1

We will find that both nvme_reset_work and nvme_scan_work hung:

    INFO: task kworker/u249:4:17848 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:kworker/u249:4  state:D stack:    0 pid:17848 ppid:     2
    flags:0x00000028
    Workqueue: nvme-reset-wq nvme_reset_work [nvme]
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    blk_mq_freeze_queue_wait+0x84/0xc0
    nvme_wait_freeze+0x40/0x64 [nvme_core]
    nvme_reset_work+0x1c0/0x5cc [nvme]
    process_one_work+0x1d8/0x4b0
    worker_thread+0x230/0x440
    kthread+0x114/0x120
    INFO: task kworker/u249:3:22404 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:kworker/u249:3  state:D stack:    0 pid:22404 ppid:     2
    flags:0x00000028
    Workqueue: nvme-wq nvme_scan_work [nvme_core]
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    rwsem_down_write_slowpath+0x32c/0x98c
    down_write+0x70/0x80
    nvme_alloc_ns+0x1ac/0x38c [nvme_core]
    nvme_validate_or_alloc_ns+0xbc/0x150 [nvme_core]
    nvme_scan_ns_list+0xe8/0x2e4 [nvme_core]
    nvme_scan_work+0x60/0x500 [nvme_core]
    process_one_work+0x1d8/0x4b0
    worker_thread+0x260/0x440
    kthread+0x114/0x120
    INFO: task nvme:28428 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:nvme            state:D stack:    0 pid:28428 ppid: 27119
    flags:0x00000000
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    schedule_timeout+0x160/0x194
    do_wait_for_common+0xac/0x1d0
    __wait_for_common+0x78/0x100
    wait_for_completion+0x24/0x30
    __flush_work.isra.0+0x74/0x90
    flush_work+0x14/0x20
    nvme_reset_ctrl_sync+0x50/0x74 [nvme_core]
    nvme_dev_ioctl+0x1b0/0x250 [nvme_core]
    __arm64_sys_ioctl+0xa8/0xf0
    el0_svc_common+0x88/0x234
    do_el0_svc+0x7c/0x90
    el0_svc+0x1c/0x30
    el0_sync_handler+0xa8/0xb0
    el0_sync+0x148/0x180

The reason for the hang is that nvme_reset_work occurs while nvme_scan_work
is still running. nvme_scan_work may add new ns into ctrl->namespaces
list after nvme_reset_work frozen all ns->q in ctrl->namespaces list.
The newly added ns is not frozen, so nvme_wait_freeze will wait forever.
Unfortunately, ctrl->namespaces_rwsem is held by nvme_reset_work, so
nvme_scan_work will also wait forever. Now we are deadlocked!

PROCESS1                         PROCESS2
==============                   ==============
nvme_scan_work
  ...                            nvme_reset_work
  nvme_validate_or_alloc_ns        nvme_dev_disable
    nvme_alloc_ns                    nvme_start_freeze
     down_write                      ...
     nvme_ns_add_to_ctrl_list        ...
     up_write                      nvme_wait_freeze
    ...                              down_read
    nvme_alloc_ns                    blk_mq_freeze_queue_wait
     down_write

Fix by marking the ctrl with say NVME_CTRL_FROZEN flag set in
nvme_start_freeze and cleared in nvme_unfreeze. Then the scan can check
it before adding the new namespace (under the namespaces_rwsem).

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e7bda7749caa..d5bfb6db5a1cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3641,6 +3641,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
+	/*
+	 * Ensure that no namespaces are added to the ctrl list after the queues
+	 * are frozen, thereby avoiding a deadlock between scan and reset.
+	 */
+	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
+		up_write(&ctrl->namespaces_rwsem);
+		goto out_unlink_ns;
+	}
 	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
@@ -4550,6 +4558,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
@@ -4583,6 +4592,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
+	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 68313148e6ed5..bc6d6eabab66b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	NVME_CTRL_FROZEN		= 6,
 };
 
 struct nvme_ctrl {
-- 
2.42.0

