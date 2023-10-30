Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A467DB384
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjJ3GiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJ3GiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:38:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437DAB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:37:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SJk3X2WFqzvQJ0;
        Mon, 30 Oct 2023 14:32:56 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 30 Oct
 2023 14:37:53 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v4.19] arm64: fix a concurrency issue in emulation_proc_handler()
Date:   Mon, 30 Oct 2023 06:37:09 +0000
Message-ID: <20231030063709.2443546-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-6.1, the related code is refactored in commit 124c49b1b5d9
("arm64: armv8_deprecated: rework deprected instruction handling") and this
issue was incidentally fixed. I have adapted the patch set to linux stable
5.10. However, 4.19 and 5.10 are too different and the patch set is
hard to adapt to 4.19.

This patch is to solve the problem of repeated addition of linked lists
described below with few changes.

How to reproduce:
CONFIG_ARMV8_DEPRECATED=y, CONFIG_SWP_EMULATION=y, and CONFIG_DEBUG_LIST=y,
then launch two shell executions:
       #!/bin/bash
       while [ 1 ];
       do
           echo 1 > /proc/sys/abi/swp
       done

or "echo 1 > /proc/sys/abi/swp" and then aunch two shell executions:
       #!/bin/bash
       while [ 1 ];
       do
           echo 0 > /proc/sys/abi/swp
       done

In emulation_proc_handler(), read and write operations are performed on
insn->current_mode. In the concurrency scenario, mutex only protects
writing insn->current_mode, and not protects the read. Suppose there are
two concurrent tasks, task1 updates insn->current_mode to INSN_EMULATE
in the critical section, the prev_mode of task2 is still the old data
INSN_UNDEF of insn->current_mode. As a result, two tasks call
update_insn_emulation_mode twice with prev_mode = INSN_UNDEF and
current_mode = INSN_EMULATE, then call register_emulation_hooks twice,
resulting in a list_add double problem.

After applying this patch, the following list add or list del double
warnings never occur.

Call trace:
 __list_add_valid+0xd8/0xe4
 register_undef_hook+0x94/0x13c
 update_insn_emulation_mode+0xd0/0x12c
 emulation_proc_handler+0xd8/0xf4
 proc_sys_call_handler+0x140/0x250
 proc_sys_write+0x1c/0x2c
 new_sync_write+0xec/0x18c
 vfs_write+0x214/0x2ac
 ksys_write+0x70/0xfc
 __arm64_sys_write+0x24/0x30
 el0_svc_common.constprop.0+0x7c/0x1bc
 do_el0_svc+0x2c/0x94
 el0_svc+0x20/0x30
 el0_sync_handler+0xb0/0xb4
 el0_sync+0x160/0x180

Call trace:
 __list_del_entry_valid+0xac/0x110
 unregister_undef_hook+0x34/0x80
 update_insn_emulation_mode+0xf0/0x180
 emulation_proc_handler+0x8c/0xd8
 proc_sys_call_handler+0x1d8/0x208
 proc_sys_write+0x14/0x20
 new_sync_write+0xf0/0x190
 vfs_write+0x304/0x388
 ksys_write+0x6c/0x100
 __arm64_sys_write+0x1c/0x28
 el0_svc_common.constprop.4+0x68/0x188
 do_el0_svc+0x24/0xa0
 el0_svc+0x14/0x20
 el0_sync_handler+0x90/0xb8
 el0_sync+0x160/0x180

Fixes: af483947d472 ("arm64: fix oops in concurrently setting insn_emulation sysctls")
Cc: stable@vger.kernel.org#4.19.x
Cc: gregkh@linuxfoundation.org
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 7c69a203cdf8..b8d481c3e26d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -211,10 +211,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 				  loff_t *ppos)
 {
 	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
+	struct insn_emulation *insn;
+	enum insn_emulation_mode prev_mode;
 
 	mutex_lock(&insn_emulation_mutex);
+	insn = container_of(table->data, struct insn_emulation, current_mode);
+	prev_mode = insn->current_mode;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || prev_mode == insn->current_mode)
-- 
2.34.1

