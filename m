Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA977C4F93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbjJKKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjJKKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EBB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:26 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S57c23VcxzkY3B;
        Wed, 11 Oct 2023 18:02:26 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:06:23 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yuzenghui@huawei.com>, <anshuman.khandual@arm.com>,
        <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <youngmin.nam@samsung.com>,
        <ardb@kernel.org>, <f.fainelli@gmail.com>, <james.morse@arm.com>,
        <sashal@kernel.org>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 RESEND 00/15] arm64: Fix a concurrency issue in emulation_proc_handler()
Date:   Wed, 11 Oct 2023 10:05:30 +0000
Message-ID: <20231011100545.979577-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-6.1, the related code is refactored in commit 124c49b1b5d9
("arm64: armv8_deprecated: rework deprected instruction handling") and this
issue was incidentally fixed. This patch set try to adapt the refactoring
patches to stable 5.10 to solve the problem of repeated addition of linked
lists described below.

How to reproduce:
CONFIG_ARMV8_DEPRECATED=y, CONFIG_SWP_EMULATION=y, and CONFIG_DEBUG_LIST=y,
then launch two shell executions:
       #!/bin/bash
       while [ 1 ];
       do
           echo 1 > /proc/sys/abi/swp
       done

or "echo 1 > /proc/sys/abi/swp" and then launch two shell executions:
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

commit 124c49b1b5d9 ("arm64: armv8_deprecated: rework deprected instruction
handling") remove the dynamic registration and unregistration so remove the
register_undef_hook() function, so the below problem was incidentally
fixed.

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

The first 5 patches is a patch set which provides context for subsequent
refactoring 9 patches, especially commit 0f2cb928a154 ("arm64:
consistently pass ESR_ELx to die()") which modify do_undefinstr() to add a
ESR_ELx value arg, and then commit 61d64a376ea8 ("arm64: split EL0/EL1
UNDEF handlers") splits do_undefinstr() handler into separate
do_el0_undef() and do_el1_undef() handlers.

The 9 patches after that is another refactoring patch set, which is in
preparation for the main rework commit 124c49b1b5d9 ("arm64:
armv8_deprecated: rework deprected instruction handling"). To remove struct
undef_hook, commit bff8f413c71f ("arm64: factor out EL1 SSBS emulation
hook") factor out EL1 SSBS emulation hook, which also avoid call
call_undef_hook() in do_el1_undef(), commit f5962add74b6 ("arm64: rework
EL0 MRS emulation") factor out EL0 MRS emulation hook, which also prepare
for replacing call_undef_hook() in do_el0_undef(). To replace
call_undef_hook() function, commit 61d64a376ea8 ("arm64: split EL0/EL1
UNDEF handlers") split the do_undefinstr() into do_el0_undef() and
do_el1_undef() functions, and commit dbfbd87efa79 ("arm64: factor insn
read out of call_undef_hook()") factor user_insn_read() from
call_undef_hook() so the main rework patch can replace the
call_undef_hook() in do_el0_undef().

The last patch is a bugfix for the main rework patch.

I've tested this with userspace programs which use each of the
deprecated instructions on Raspberry Pi 4B KVM/Qemu, and I've concurrently
modified the support level for each of the features back-and-forth between
HW and emulated to check that there are no oops or above repeated addition
or deletion call trace.

Fixes: af483947d472 ("arm64: fix oops in concurrently setting insn_emulation sysctls")
Cc: stable@vger.kernel.org#5.10.x
Cc: gregkh@linuxfoundation.org
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Mark Rutland (14):
  arm64: report EL1 UNDEFs better
  arm64: die(): pass 'err' as long
  arm64: consistently pass ESR_ELx to die()
  arm64: rework FPAC exception handling
  arm64: rework BTI exception handling
  arm64: allow kprobes on EL0 handlers
  arm64: split EL0/EL1 UNDEF handlers
  arm64: factor out EL1 SSBS emulation hook
  arm64: factor insn read out of call_undef_hook()
  arm64: rework EL0 MRS emulation
  arm64: armv8_deprecated: fold ops into insn_emulation
  arm64: armv8_deprecated move emulation functions
  arm64: armv8_deprecated: move aarch32 helper earlier
  arm64: armv8_deprecated: rework deprected instruction handling

Ren Zhijie (1):
  arm64: armv8_deprecated: fix unused-function error

 arch/arm64/include/asm/cpufeature.h  |   3 +-
 arch/arm64/include/asm/exception.h   |  13 +-
 arch/arm64/include/asm/spectre.h     |   2 +
 arch/arm64/include/asm/system_misc.h |   2 +-
 arch/arm64/include/asm/traps.h       |  19 +-
 arch/arm64/kernel/armv8_deprecated.c | 572 +++++++++++++--------------
 arch/arm64/kernel/cpufeature.c       |  23 +-
 arch/arm64/kernel/entry-common.c     |  36 +-
 arch/arm64/kernel/proton-pack.c      |  26 +-
 arch/arm64/kernel/traps.c            | 125 +++---
 10 files changed, 396 insertions(+), 425 deletions(-)

-- 
2.34.1

