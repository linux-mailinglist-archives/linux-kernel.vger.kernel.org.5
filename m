Return-Path: <linux-kernel+bounces-2962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF0816542
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D30281F90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E813D64;
	Mon, 18 Dec 2023 03:13:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753823C0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1702869194tia5c1x9
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Dec 2023 11:13:10 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: CbHyMb8VrI0YrUNQgdv8Fc3WpubobuDr6zh6jswt2V4GvALaE86ztRNRl/OBQ
	DeMfd71HgSxRURWE7Q6u1XYIrbN9RtZKGmKw3ju1RT241YPw4vaUaYemOwzPY9XSuj6gHTc
	deNbw8RFi2AAV1aK8RJMRuAbDl53AmNZS9h7Y26fL64+/Vj8mP/f9Ah0BYm3CtmJ95EDuwK
	WM8OrPwATcSV8nhAeczWn7fTYW0KFXljmNTxIMv68Nf79XIBXZRnaPFceirh86MLJB9a/fX
	9T/2qvlG4rbSWpdmpnkh7kNYC+lRzodPsoY3sHsKJApQ9lpJpY4x0NaUqw4D0+giJa/IBHE
	+WNpD0/Z/Ho7sgw14r8Hi99OUP3CLPwpOLo/PggfDzGU8tUdu1E7u5fT8ftredu6M0N0A7E
	Ads/GtkisX0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16065116552740346806
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Cc: luming.yu@gmail.com,
	ke.zhao@shingroup.cn,
	dawei.li@shingroup.cn,
	shenghui.qu@shingroup.cn,
	Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v1 1/2] powerpc/debug: implement HAVE_USER_RETURN_NOTIFIER
Date: Mon, 18 Dec 2023 11:13:08 +0800
Message-ID: <1FD36D52828D2506+20231218031309.2063-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

The support for user return notifier infrastructure
is manually hooked into powerpc architecture.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
v0->v1: add user return notifier arch hook manually.
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


