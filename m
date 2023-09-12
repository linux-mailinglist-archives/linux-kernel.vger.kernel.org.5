Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8079C7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjILHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjILHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:14:56 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF639B9;
        Tue, 12 Sep 2023 00:14:51 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RlFFz0PmrzCh0p;
        Tue, 12 Sep 2023 15:14:47 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4RlFFy253qz5qYcG;
        Tue, 12 Sep 2023 15:14:46 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RlFFq3xpSz8XrRP;
        Tue, 12 Sep 2023 15:14:39 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 38C7EPYt080948;
        Tue, 12 Sep 2023 15:14:25 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 12 Sep 2023 15:14:28 +0800 (CST)
Date:   Tue, 12 Sep 2023 15:14:28 +0800 (CST)
X-Zmail-TransId: 2b0965000fd44f9-59db5
X-Mailer: Zmail v1.0
Message-ID: <202309121514283793475@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <bigeasy@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <stable-rt@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <he.he@windriver.com>,
        <linux-rt-users@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDUuMTAtcnRdIGFybTY0OiBzaWduYWw6IFVzZSBBUkNIX1JUX0RFTEFZU19TSUdOQUxfU0VORA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38C7EPYt080948
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65000FE5.001/4RlFFz0PmrzCh0p
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Yong <wang.yong12@zte.com.cn>

The ltp test prompts the following bug information under the 5.10 kernel:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 796, name: cat
Preemption disabled at:
[<ffffffe40f433980>] do_debug_exception+0x60/0x180
CPU: 3 PID: 796 Comm: cat Not tainted 5.10.59-rt52-KERNEL_VERSION #38
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x20/0x30
 dump_stack+0xf0/0x13c
 ___might_sleep+0x140/0x178
 rt_spin_lock+0x30/0x90
 force_sig_info_to_task+0x30/0xe0
 force_sig_fault_to_task+0x54/0x78
 force_sig_fault+0x1c/0x28
 arm64_force_sig_fault+0x48/0x78
 send_user_sigtrap+0x4c/0x80
 brk_handler+0x3c/0x68
 do_debug_exception+0xac/0x180
 el0_dbg+0x34/0x58
 el0_sync_handler+0x50/0xb8
 el0_sync+0x180/0x1c0

It has been fixed by
0c34700de5e7 ("arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND.") in
higher versions of the kernel. This patch needs to be compatible with 5.10.
5.10 kernel does not have signal.h file, so adding signal.h file to
define ARCH_RT_DELAYS_SIGNAL_SEND.

Signed-off-by: Wang Yong <wang.yong12@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
---
 arch/arm64/include/asm/signal.h | 12 ++++++++++++
 arch/arm64/kernel/signal.c      |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/include/asm/signal.h

diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
new file mode 100644
index 000000000..0fb418cf4
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_ASM_SIGNAL_H
+#define __ARM64_ASM_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+#include <uapi/asm/siginfo.h>
+
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index fe94a3e1f..538d4aadb 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -927,6 +927,15 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		} else {
 			local_daif_restore(DAIF_PROCCTX);

+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+			if (unlikely(current->forced_info.si_signo)) {
+				struct task_struct *t = current;
+
+				force_sig_info(&t->forced_info);
+				t->forced_info.si_signo = 0;
+			}
+#endif
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);

-- 
2.25.1
