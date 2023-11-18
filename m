Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4257EFFF8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjKRNpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKRNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:45:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE9192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 05:45:27 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b5ff072fc4so1870835b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700315127; x=1700919927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7iK7bEpkGiPmor6VhkMwseju9UQrWFwx9RTOevn724=;
        b=fOEshL0jx3m6gODp8nmfwUqSTwFfsPxnkkQ0a3KrFtsJBlBLUUEMPI4s6Qh1EA3CvW
         zm5Aafp2rb5e2BMSzuyBA92RJVLW0Yeen3dHKgQcEq1LutbfqBhkm/dd7B60tpiRCDOL
         0bZmikn4Fn75gdvzGwwo7A7UtDgdmugD9gV+ILaW1X8YlGpiSnKkvLYqiuPoOXoQzqL6
         6R5PccNqaQpgDcDyaRTSa2T4xQ7IWk5OpG84UAIAVbCRH1QM1N3BSM427uQtAO2uOl9U
         9WU0Y7TNHsOScD8kvMu0CTqj4myjHjyyi+qGxp4+X9dauSaWcLmyMBl3Tt0PZALfLE8q
         yz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700315127; x=1700919927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7iK7bEpkGiPmor6VhkMwseju9UQrWFwx9RTOevn724=;
        b=mnMQUdrgPRHkhuD0C2blca3NEndnG/66eJC5akhHVWvFdk9NQetUTWSBqr4c188EOv
         6FT9sfK8lIOSdIZZ9UCC5PtFS/O2eijDRtORs3dEMatNcEJINXrGl2wrwtmRsap83UJr
         bzolckkvY6EU+6exn6yp5Nhn/rgAKPJWtrKs6mlYiIRX1mEUUVhP7Xvguo0SfjZuhgNA
         5IbDzceiIwRusyj+nkD3KXtHCCwPrP0wqJGDYqF6fCeUHXefqKG2K71rKswmwBMLGG0o
         oEzxX0YdfG0dVNK9Z3B/jbc57K/BHW2bUCPQom+Or+68r7o8+qUeZf5o6KCcqgeXBaHP
         TjUw==
X-Gm-Message-State: AOJu0YysSe81ug0XNMIQyDUuoe5OU8eph5wbDrBNzS/SrElE4v5WEaxP
        pp/jlolzI969UvBdicaE+u0=
X-Google-Smtp-Source: AGHT+IGYGfXjfj9YBQX6md19pjtGLUvhpy/Eyn3JQ4lALh3jD1tTT1srXB39fJcVNCplEfoE7G9pvA==
X-Received: by 2002:a05:6808:140e:b0:3ae:4cad:91a0 with SMTP id w14-20020a056808140e00b003ae4cad91a0mr2990242oiv.6.1700315126893;
        Sat, 18 Nov 2023 05:45:26 -0800 (PST)
Received: from localhost ([112.21.165.177])
        by smtp.gmail.com with ESMTPSA id b19-20020a631b13000000b005c21943d571sm1550834pgb.55.2023.11.18.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 05:45:23 -0800 (PST)
From:   qiwuchen55@gmail.com
X-Google-Original-From: qiwu.chen@transsion.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <qiwu.chen@transsion.com>
Subject: [PATCH] arm64: Add user stacktrace support
Date:   Sat, 18 Nov 2023 21:45:04 +0800
Message-Id: <20231118134504.154842-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <qiwu.chen@transsion.com>

1. Introduce and export arch_dump_user_stacktrace() API to support
user stacktrace dump for a user task (both current and non-current task).
A example test about the log format of user stacktrace as shown below:
[test-515] Dump user backtrace:
<0xffffb0c1a750> in /lib/aarch64-linux-gnu/libc-2.32.so[ffffb0b53000-ffffb0cb1000]
<0xaaaacbf8097c> in /mnt/test[aaaacbf80000-aaaacbf81000]
<0xffffb0b778b8> in /lib/aarch64-linux-gnu/libc-2.32.so[ffffb0b53000-ffffb0cb1000]
<0xaaaacbf80834> in /mnt/test[aaaacbf80000-aaaacbf81000]

2. Add arch_stack_walk_user() implementation to support userstacktrace trace option.
A example test about the output format of ftrace userstacktrace as shown below:
    bash-489     [000] .....  2167.660775: sched_process_fork: comm=bash pid=489 child_comm=bash child_pid=596
    bash-489     [000] .....  2167.660787: <user stack trace>
 => /lib/aarch64-linux-gnu/libc-2.32.so[+0xa76d8]
 => /bin/bash[+0x5f354]
 => /bin/bash[+0x4876c]
 => /bin/bash[+0x4aec4]
 => /bin/bash[+0x4da48]
 => /bin/bash[+0x4b710]
 => /bin/bash[+0x4c31c]
 => /bin/bash[+0x339b0]

Tested-by-by: chenqiwu <qiwu.chen@transsion.com>
Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
---
 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/stacktrace.c | 208 +++++++++++++++++++++++++++++++++
 include/linux/stacktrace.h     |  10 ++
 3 files changed, 219 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a004..4c5066f88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -255,6 +255,7 @@ config ARM64
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select USER_STACKTRACE_SUPPORT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 17f66a74c..4e7bf2922 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -215,6 +215,214 @@ static bool dump_backtrace_entry(void *arg, unsigned long where)
 	return true;
 }
 
+/* The struct defined for AArch64 userspace stack frame */
+struct stack_frame_user {
+	unsigned long fp;
+	unsigned long sp;
+	unsigned long pc;
+};
+
+/*
+ * The function of AArch64 userspace stack frame unwind method.
+ * Note: If the caller is not current task, it's supposed to call
+ * access_process_vm() to access another task' address space.
+ */
+static int arch_unwind_user_frame(struct task_struct *tsk, unsigned long high,
+				struct stack_frame_user *frame)
+{
+	int ret = 0;
+	unsigned long fp = frame->fp;
+	unsigned long low = frame->sp;
+
+	if (fp < low || fp > high || fp & 0xf)
+		return -EFAULT;
+
+	frame->sp = fp + 0x10;
+	/* Disable page fault to make sure get_user going on wheels */
+	pagefault_disable();
+	if (tsk == current) {
+		if (get_user(frame->fp, (unsigned long __user *)fp) ||
+			get_user(frame->pc, (unsigned long __user *)(fp + 8)))
+			ret = -EFAULT;
+	} else {
+		if (access_process_vm(tsk, fp, &frame->fp,
+			sizeof(unsigned long), 0) != sizeof(unsigned long) ||
+			access_process_vm(tsk, fp + 0x08, &frame->pc,
+			sizeof(unsigned long), 0) != sizeof(unsigned long))
+			ret = -EFAULT;
+	}
+	pagefault_enable();
+
+	return ret;
+}
+
+/*
+ * Print the executable address and corresponding VMA info.
+ */
+static void print_vma_addr_info(char *prefix, struct task_struct *task,
+				unsigned long ip, const char *loglvl)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+
+	if (task != current)
+		mm = get_task_mm(task);
+	else
+		mm = task->mm;
+
+	if (!mm)
+		return;
+	/*
+	 * we might be running from an atomic context so we cannot sleep
+	 */
+	if (!mmap_read_trylock(mm)) {
+		mmput(mm);
+		return;
+	}
+
+	vma = find_vma(mm, ip);
+	if (vma && vma->vm_file) {
+		struct file *f = vma->vm_file;
+		char *buf = (char *)__get_free_page(GFP_NOWAIT);
+
+		if (buf) {
+			char *p;
+
+			p = file_path(f, buf, PAGE_SIZE);
+			if (IS_ERR(p))
+				p = "?";
+			printk("%s%s%s[%lx-%lx]\n", loglvl, prefix, p,
+					vma->vm_start,
+					vma->vm_end);
+			free_page((unsigned long)buf);
+		}
+	}
+	mmap_read_unlock(mm);
+	if (task != current)
+		mmput(mm);
+}
+
+static struct vm_area_struct *find_user_stack_vma(struct task_struct *task, unsigned long sp)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+
+	if (task != current)
+		mm = get_task_mm(task);
+	else
+		mm = task->mm;
+
+	if (!mm)
+		return NULL;
+	/*
+	 * we might be running from an atomic context so we cannot sleep
+	 */
+	if (!mmap_read_trylock(mm)) {
+		mmput(mm);
+		return NULL;
+	}
+	vma = find_vma(mm, sp);
+	mmap_read_unlock(mm);
+	if (task != current)
+		mmput(mm);
+
+	return vma;
+}
+
+static void dump_user_backtrace_entry(struct task_struct *tsk,
+				unsigned long where, const char *loglvl)
+{
+	char prefix[64];
+
+	snprintf(prefix, sizeof(prefix), "<0x%lx> in ", where);
+	print_vma_addr_info(prefix, tsk, where, loglvl);
+}
+
+void arch_dump_user_stacktrace(struct pt_regs *regs, struct task_struct *tsk,
+								const char *loglvl)
+{
+	struct stack_frame_user frame;
+	struct vm_area_struct *vma;
+	unsigned long userstack_start, userstack_end;
+
+	if (!tsk)
+		tsk = current;
+
+	/*
+	 * If @regs is not specified or caller is not current task,.
+	 * @regs is supposed to get from @tsk.
+	 */
+	if (!regs || tsk != current)
+		regs = task_pt_regs(tsk);
+
+	/* TODO: support stack unwind for compat user mode */
+	if (compat_user_mode(regs))
+		return;
+
+	userstack_start = regs->user_regs.sp;
+	vma = find_user_stack_vma(tsk, userstack_start);
+	if (!vma)
+		return;
+
+	userstack_end = vma->vm_end;
+	frame.fp = regs->user_regs.regs[29];
+	frame.sp = userstack_start;
+	frame.pc = regs->user_regs.pc;
+
+	printk("%s[%s-%d] Dump user backtrace:\n", loglvl, tsk->comm, tsk->pid);
+	while (1) {
+		unsigned long where = frame.pc;
+
+		if (!where || where & 0x3)
+			break;
+		dump_user_backtrace_entry(tsk, where, loglvl);
+		if (arch_unwind_user_frame(tsk, userstack_end, &frame) < 0)
+			break;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_dump_user_stacktrace);
+
+/**
+ * stack_trace_save_user - Save user space stack traces into a storage array
+ * @consume_entry: Callback for save a user space stack trace
+ * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
+ * @regs: The pt_regs pointer of current task
+ */
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	struct stack_frame_user frame;
+	struct vm_area_struct *vma;
+	unsigned long userstack_start, userstack_end;
+	struct task_struct *tsk = current;
+
+	/* TODO: support stack unwind for compat user mode */
+	if (!regs || !user_mode(regs) || compat_user_mode(regs))
+		return;
+
+	userstack_start = regs->user_regs.sp;
+	vma = find_user_stack_vma(tsk, userstack_start);
+	if (!vma)
+		return;
+
+	userstack_end = vma->vm_end;
+	frame.fp = regs->user_regs.regs[29];
+	frame.sp = userstack_start;
+	frame.pc = regs->user_regs.pc;
+
+	while (1) {
+		unsigned long where = frame.pc;
+
+		/* Sanity check: ABI requires pc to be aligned 4 bytes. */
+		if (!where || where & 0x3)
+			break;
+		if (!consume_entry(cookie, where))
+			break;
+		if (arch_unwind_user_frame(tsk, userstack_end, &frame) < 0)
+			break;
+	}
+}
+
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		    const char *loglvl)
 {
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 97455880a..bc5a7bf56 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -60,6 +60,16 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
+
+/**
+ * arch_dump_user_stacktrace - Architecture specific function to dump the
+ *			       stack trace for user process
+ * @regs: Pointer to the pt_regs of user process
+ * @tsk: Pointer to the task_struct of user process
+ * @loglvl: Log level
+ */
+void arch_dump_user_stacktrace(struct pt_regs *regs, struct task_struct *tsk,
+			       const char *loglvl);
 #endif /* CONFIG_ARCH_STACKWALK */
 
 #ifdef CONFIG_STACKTRACE
-- 
2.25.1

