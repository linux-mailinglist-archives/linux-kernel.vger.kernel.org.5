Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4D7E77ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjKJDU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKJDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:20:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0071644B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:20:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1324647b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 19:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699586453; x=1700191253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLPVdcdPahvGqeZSn1hBEA6ty5PwVTcz/p3Am2TK/Fk=;
        b=blh59K7sShwPHw1sSxE0DF1FhngWHMUepEgNDa/RefwBrdMU7L+Dpz7DLxObYIFc08
         c4wXhNrp2T1YnqaXbsmu47tckRd7jJPdbfEM3EED7sQEKIOfTAslAeKBA/4F2sofwfxA
         Jxmynf9EKTx6ndeI8StJakR99Mzr+CPdNu9+gS+iTy6BhQF74zvtlER4tCL70YdJGSS9
         D+Mtf+NJ8y+Da56EH0dW90a3Pv3jND+hzrJWkB/qHI4dqSQHsNkqItJR5JK8nJ2L1kdH
         8gi/hekMvcQsz5arc1KCZKCnSDK1GcCzeSQ6nRz0XVk76VS1koW/XTzZhrji4R0Ix8zV
         JEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699586453; x=1700191253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLPVdcdPahvGqeZSn1hBEA6ty5PwVTcz/p3Am2TK/Fk=;
        b=UZAS6uLe8hmiSx7RNUvUWjkyjxzfNOy2n3xPIXiuQyaIJakZ1K5Ovmp24BDEiClM3z
         Z0fBiVR1ilvPkzsf4Nq/slPwUQ70Y9t8yXVnlUiPCO+HVG79NjhXXsJ3JHUiGBYdzgx9
         fYN9RUUXVx1eTshUZkqKRt01Sd2tmfYYAsCDmMn6k/tOLXo2zUwKSZJlRD/5XTSXfOTQ
         1AantoLp5x74eq6Y83iKfWX/sWktoXQCG5YbdZxlDAV/GenbYMK1iXY15g0lSS9ne5kF
         myMxss5eKxLLVUcABlrz+4xRhTEFvfw2BVP4TzndrfPLz9zMx8Zjwxof+TW+o5DVrYGz
         G0ww==
X-Gm-Message-State: AOJu0Yx3Ovc70lAUpN79jUbgAAq445AaTNM2UGxe8kjSYHPlJNww/T+1
        tuJ0ZQB/ZN0kdROLlam+dcs=
X-Google-Smtp-Source: AGHT+IEbiGefrbX9TVYVrDTntaCNttsNHYhV61VlArQP+GAeKY4rEaO/9nBy4qgKfCXGiAMzLbjsog==
X-Received: by 2002:a62:e815:0:b0:6c4:d615:2169 with SMTP id c21-20020a62e815000000b006c4d6152169mr1293438pfi.10.1699586453333;
        Thu, 09 Nov 2023 19:20:53 -0800 (PST)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id du4-20020a056a002b4400b00694ebe2b0d4sm11448590pfb.191.2023.11.09.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:20:53 -0800 (PST)
From:   chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
To:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        npiggin@gmail.com, ebiederm@xmission.com
Cc:     michael.christie@oracle.com, mark.rutland@arm.com,
        jannh@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <qiwu.chen@transsion.com>
Subject: [PATCH v2] exit: dump thread info on global init exit
Date:   Fri, 10 Nov 2023 11:20:43 +0800
Message-Id: <20231110032043.34516-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are various global init exit issues encountered
on Andriod/linux system. It's hard to debug these issues on product
environment without a usable coredump, This patch dump the last
exit thread executable sections and regs to find the exit reason
before panic.

Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
Tested-by: chenqiwu <qiwu.chen@transsion.com>
---
 kernel/exit.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..af2e24bc3ecd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -13,6 +13,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/debug.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/capability.h>
@@ -806,6 +807,76 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	spin_unlock_irq(&sighand->siglock);
 }
 
+/*
+ * This function only dump thread executable sections to reduce maps space,
+ * since an unhandled falut in user mode is likely generated from code section.
+ */
+static void dump_thread_maps_info(struct task_struct *tsk)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = tsk->mm;
+
+	if (!mmap_read_trylock(mm))
+		return;
+
+	VMA_ITERATOR(vmi, mm, 0);
+	pr_info("%s-%d: Dump maps info start\n", tsk->comm, task_pid_nr(tsk));
+	for_each_vma(vmi, vma) {
+		struct file *file = vma->vm_file;
+		int flags = vma->vm_flags;
+		unsigned long long pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
+
+		if (file) {
+			if (flags & VM_EXEC) {
+				char tpath[256] = {0};
+				char *pathname = d_path(&file->f_path, tpath, sizeof(tpath));
+
+				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
+					vma->vm_start, vma->vm_end,
+					flags & VM_READ ? 'r' : '-',
+					flags & VM_WRITE ? 'w' : '-',
+					flags & VM_EXEC ? 'x' : '-',
+					flags & VM_MAYSHARE ? 's' : 'p',
+					pgoff, pathname);
+			}
+		} else {
+			const char *name = arch_vma_name(vma);
+
+			if (!name) {
+				struct mm_struct *mm = vma->vm_mm;
+
+				if (mm) {
+					if (vma_is_initial_heap(vma))
+						name = "[heap]";
+					else if (vma_is_initial_stack(vma))
+						name = "[stack]";
+				} else {
+					name = "[vdso]";
+				}
+			}
+
+			if (name && (flags & VM_EXEC)) {
+				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
+					vma->vm_start, vma->vm_end,
+					flags & VM_READ ? 'r' : '-',
+					flags & VM_WRITE ? 'w' : '-',
+					flags & VM_EXEC ? 'x' : '-',
+					flags & VM_MAYSHARE ? 's' : 'p', pgoff, name);
+			}
+		}
+	}
+	mmap_read_unlock(mm);
+	pr_info("%s-%d: Dump maps info end\n", tsk->comm, task_pid_nr(tsk));
+}
+
+static void dump_thread_info(struct task_struct *tsk)
+{
+	struct pt_regs *regs = task_pt_regs(tsk);
+
+	dump_thread_maps_info(tsk);
+	show_regs(regs);
+}
+
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -833,12 +904,14 @@ void __noreturn do_exit(long code)
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
 		/*
-		 * If the last thread of global init has exited, panic
-		 * immediately to get a useable coredump.
+		 * If the last thread of global init has exited, dump
+		 * some usable information before panic.
 		 */
-		if (unlikely(is_global_init(tsk)))
+		if (unlikely(is_global_init(tsk))) {
+			dump_thread_info(tsk);
 			panic("Attempted to kill init! exitcode=0x%08x\n",
 				tsk->signal->group_exit_code ?: (int)code);
+		}
 
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
-- 
2.25.1

