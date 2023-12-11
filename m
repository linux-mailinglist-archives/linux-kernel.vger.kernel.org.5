Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951BB80BFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjLKCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjLKCwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:52:36 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F5172A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:51:44 -0800 (PST)
X-QQ-mid: bizesmtp64t1702263093txwc5r18
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Dec 2023 10:51:30 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: l3A5VUsUnUlcsmarVtr1L2MyOzd1tHeCEh7Lba7DnyL7XM6lBjjwpWggANvlj
        37vbA2o6jXMMSVExU4hOP923LNECzG2mlYCsrEbEER10kpMLd1ytTJRAIkQMo/DuMHtbIq4
        y7fJQxL4aAsCJeZVhKdXRgPujuV96APRS6oMgV7j95XrdcP1Lt7xOBkczU19oMf2JlCRWUI
        2i+ILVZ4gDfP7RyUPHDErBcMfhs59sqmk8UESE/ptvWETVMLOy3gUMLpsfja5FudKa+tMpM
        j30u0h0S/JI0R4dHOKGgVStzn6hC5bwesVf243JoatAujmU6Xn1YuJTs5CsPSNSx+AusESV
        Ns98AtgEeIccij1Lya9L3/jc15C/ZrmM9K8k7SpfwczAOSjEfCdLCpSjan8rfPvrkHQxBlY
        pHhEmqIBhuU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9599634464750526515
From:   Luming Yu <luming.yu@shingroup.cn>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 1/1] powerpc/debug: implement HAVE_USER_RETURN_NOTIFIER
Date:   Mon, 11 Dec 2023 10:50:54 +0800
Message-ID: <475A60AEEAA99F6C+20231211025054.885-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for user return notifier infrastructure
is hooked into powerpc architecture.
---
 arch/powerpc/Kconfig                    |  1 +
 arch/powerpc/include/asm/entry-common.h | 16 ++++++++++++++++
 arch/powerpc/include/asm/thread_info.h  |  2 ++
 arch/powerpc/kernel/process.c           |  2 ++
 4 files changed, 21 insertions(+)
 create mode 100644 arch/powerpc/include/asm/entry-common.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c10229c0243c..b968068cc04a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -277,6 +277,7 @@ config PPC
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
 	select HAVE_STATIC_CALL			if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HOTPLUG_SMT			if HOTPLUG_CPU
diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
new file mode 100644
index 000000000000..51f1eb767696
--- /dev/null
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_POWERPC_ENTRY_COMMON_H
+#define ARCH_POWERPC_ENTRY_COMMON_H
+
+#include <linux/user-return-notifier.h>
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (ti_work & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
+#endif
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index bf5dde1a4114..47e226032f9c 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -117,6 +117,7 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_USER_RETURN_NOTIFY	21	/* notify kernel of userspace return */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -125,6 +126,7 @@ void arch_setup_new_exec(void);
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
+#define _TIF_USER_RETURN_NOTIFY	(1<<TIF_USER_RETURN_NOTIFY)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
 #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 392404688cec..70a9ea949798 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
 #include <linux/seq_buf.h>
+#include <linux/user-return-notifier.h>
 
 #include <asm/interrupt.h>
 #include <asm/io.h>
@@ -1386,6 +1387,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	if (current->thread.regs)
 		restore_math(current->thread.regs);
 #endif /* CONFIG_PPC_BOOK3S_64 */
+	propagate_user_return_notify(prev, new);
 
 	return last;
 }
-- 
2.42.0.windows.2

