Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700775A23F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGSWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGSWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9031FF3;
        Wed, 19 Jul 2023 15:47:30 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hw9k3BkaSMk5Tr7HMKcTEbnrFd0HUEwbFShXMmHpOJk=;
        b=ptPY3n3q3c5SH9uHty8YVbqC9vYbuIi/K5a2CmaWP8M2atMeBNtz6FA+b1y9QvBJ64pqK2
        8lVjUX65TNnCMTHMy9nIG/xCJzAWjQP++/EatKMN1HDg5rWdqC0whHCLhsufW031k8OhYS
        AXLG5U6Vw7Y6Ok+hbjwKGSo4/HZmabdgLTrYCt4xchyF/FSLzK7TC1lWMpcLDmHwmddhiQ
        2r0fNS5G1MMlR9WU4OyppnKQg/7mAR6viSfn2x7OU5D6uSpMwRCmzzW8YnFFziRgiXA5uq
        6TuBxQabDE0qxajFHbpE5cOa6K5p3GhyBOfVzyQqrtU8TtRpmcggCdeUaPBKww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hw9k3BkaSMk5Tr7HMKcTEbnrFd0HUEwbFShXMmHpOJk=;
        b=VwFtFNsWz/R7kOUEIPQMzBNcLJHwS9PGbDFQerskpPdwZXe50yvEm+FoEsjzo70Sau5nm/
        pLlLBUQZJ1coLWCA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86: Expose thread features in /proc/$PID/status
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684838.28540.5951746894815513835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     d21da223567ebdcd7c3ba53e77eddcf95082d218
Gitweb:        https://git.kernel.org/tip/d21da223567ebdcd7c3ba53e77eddcf95082d218
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:02 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:13:43 -07:00

x86: Expose thread features in /proc/$PID/status

Applications and loaders can have logic to decide whether to enable
shadow stack. They usually don't report whether shadow stack has been
enabled or not, so there is no way to verify whether an application
actually is protected by shadow stack.

Add two lines in /proc/$PID/status to report enabled and locked features.

Since, this involves referring to arch specific defines in asm/prctl.h,
implement an arch breakout to emit the feature lines.

[Switched to CET, added to commit log]

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-37-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/cpu/proc.c | 23 +++++++++++++++++++++++
 fs/proc/array.c            |  6 ++++++
 include/linux/proc_fs.h    |  1 +
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0..31c0e68 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -4,6 +4,8 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/cpufreq.h>
+#include <asm/prctl.h>
+#include <linux/proc_fs.h>
 
 #include "cpu.h"
 
@@ -175,3 +177,24 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+static void dump_x86_features(struct seq_file *m, unsigned long features)
+{
+	if (features & ARCH_SHSTK_SHSTK)
+		seq_puts(m, "shstk ");
+	if (features & ARCH_SHSTK_WRSS)
+		seq_puts(m, "wrss ");
+}
+
+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task)
+{
+	seq_puts(m, "x86_Thread_features:\t");
+	dump_x86_features(m, task->thread.features);
+	seq_putc(m, '\n');
+
+	seq_puts(m, "x86_Thread_features_locked:\t");
+	dump_x86_features(m, task->thread.features_locked);
+	seq_putc(m, '\n');
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
diff --git a/fs/proc/array.c b/fs/proc/array.c
index d35bbf3..2c2efbe 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -431,6 +431,11 @@ static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
 }
 
+__weak void arch_proc_pid_thread_features(struct seq_file *m,
+					  struct task_struct *task)
+{
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -455,6 +460,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_thread_features(m, task);
 	return 0;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 253f267..de407e7 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -159,6 +159,7 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
 
 void arch_report_meminfo(struct seq_file *m);
+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task);
 
 #else /* CONFIG_PROC_FS */
 
