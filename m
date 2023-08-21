Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F1782450
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjHUHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjHUHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:20:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9789BB;
        Mon, 21 Aug 2023 00:20:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee600dce6so14426115e9.1;
        Mon, 21 Aug 2023 00:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602433; x=1693207233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn6oyyCNhNwMLsIiGDbJPsQUMGXp0+1PeXxr+VvT0wg=;
        b=UQv88YtoE5sZPF6mUNw8frc6qtwL7r5qdB2m4k0j6gVJBK6uIiGHsoOoEJzI85//fE
         +AiXhuVLdu8/Gb6Goh19g9XZv00FJmA/R0O/PRDHqrN8KxH7bJgte9VvXlOnyU06Aijp
         Qi/y8kWMiv9LKEiucyko+86WGXosU43rt0euHFwM/24GmKuY2ffgZGKIQMFdTZMMlwSc
         Fhntcc75HYB/9JrhcFQLLPkievfyioaDSPbTojeYEolR+9S9IGiTS4UdRPnQo+Vly8jc
         CyyaGxiDaaJtiOG2gKAkx0zvZ1Rha7GHBE4vAi1kmL5kZ9tRvKu4/+NaJL7a4A0DrgZC
         HQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602433; x=1693207233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn6oyyCNhNwMLsIiGDbJPsQUMGXp0+1PeXxr+VvT0wg=;
        b=ZrntiW3xPUly0auGKkk+2R/hSR3OpMCF6Woxsga2hQ0BJNzKzJj5o25dTKPjpAgdbZ
         cvluQd/JDKC9voWAS9uq0VBQ40jKXy4pZob0P+btCR2yN8n7TI4JKjFSPxVGyiv1cv2v
         rx18Lv9jXhCpH2WqSYyGOWVw8PvFofMrwDquLM8evKYHaKA7DGNmDGFr88RP/FH+WKk1
         58aIe+3tciq+cyykm83EvxrIKGBAgGb9dhz6ITs0vk77/IKcmaJReRJAwsdbF424uDUh
         taaRohCohUhVX6/x39e5nQ+ujoIqjw1Z2Orh9hH6WpPfGstb+9hFU46ToEdwdMnmk/Pe
         8o7w==
X-Gm-Message-State: AOJu0YyfZCQRNy0al9+ydyowIUdu1xMv7NPrq74PBpcKa+wYtsIukH43
        nta9DrcEo8U4b5Jooq4B/IIcKYDBieI=
X-Google-Smtp-Source: AGHT+IGfwEWw/dmLKC8P4KXr5T4HWzc5kIigxZAXEOnHT5IN4LRxXgvlmNKMcB9AARYAI1JYvKml4Q==
X-Received: by 2002:a05:6000:12d2:b0:319:8af0:824a with SMTP id l18-20020a05600012d200b003198af0824amr4483523wrx.69.1692602432637;
        Mon, 21 Aug 2023 00:20:32 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4b02000000b0031aca6cc69csm11518048wrq.2.2023.08.21.00.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:32 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 1/8] openrisc: Add missing prototypes for assembly called fnctions
Date:   Mon, 21 Aug 2023 08:20:00 +0100
Message-Id: <20230821072007.2698186-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are all called from assembly files so there is no need
for a prototype in a header file, but when compiling with W=1 enabling
-Wmissing-prototypes the compiler warns:

arch/openrisc/kernel/ptrace.c:191:17: error: no previous prototype for 'do_syscall_trace_enter' [-Werror=missing-prototypes]
arch/openrisc/kernel/ptrace.c:210:17: error: no previous prototype for 'do_syscall_trace_leave' [-Werror=missing-prototypes]
arch/openrisc/kernel/signal.c:293:1: error: no previous prototype for 'do_work_pending' [-Werror=missing-prototypes]
arch/openrisc/kernel/signal.c:68:17: error: no previous prototype for '_sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/openrisc/kernel/time.c:111:25: error: no previous prototype for 'timer_interrupt' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:239:17: error: no previous prototype for 'unhandled_exception' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:246:17: error: no previous prototype for 'do_fpe_trap' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:268:17: error: no previous prototype for 'do_trap' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:273:17: error: no previous prototype for 'do_unaligned_access' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:286:17: error: no previous prototype for 'do_bus_fault' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:462:17: error: no previous prototype for 'do_illegal_instruction' [-Werror=missing-prototypes]
arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]

Since these are not needed in header files, fix these by adding
prototypes to the top of the respective C files.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/ptrace.c | 4 ++++
 arch/openrisc/kernel/signal.c | 5 +++++
 arch/openrisc/kernel/smp.c    | 2 ++
 arch/openrisc/kernel/time.c   | 2 ++
 arch/openrisc/kernel/traps.c  | 8 ++++++++
 arch/openrisc/mm/fault.c      | 3 +++
 6 files changed, 24 insertions(+)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 0b7d2ca6ba3b..1eeac3b62e9d 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -27,6 +27,10 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
+asmlinkage long do_syscall_trace_enter(struct pt_regs *regs);
+
+asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
+
 /*
  * Copy the thread state to a regset that can be interpreted by userspace.
  *
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 2e7257a433ff..3fbf00330043 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -34,6 +34,11 @@ struct rt_sigframe {
 	unsigned char retcode[16];	/* trampoline code */
 };
 
+asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs);
+
+asmlinkage int do_work_pending(struct pt_regs *regs, unsigned int thread_flags,
+			       int syscall);
+
 static int restore_sigcontext(struct pt_regs *regs,
 			      struct sigcontext __user *sc)
 {
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 0a7a059e2dff..1c5a2d71d675 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -23,6 +23,8 @@
 #include <asm/cacheflush.h>
 #include <asm/time.h>
 
+asmlinkage __init void secondary_start_kernel(void);
+
 static void (*smp_cross_call)(const struct cpumask *, unsigned int);
 
 unsigned long secondary_release = -1;
diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 8e26c1af5441..764c7bfb5df3 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -25,6 +25,8 @@
 #include <asm/cpuinfo.h>
 #include <asm/time.h>
 
+irqreturn_t __irq_entry timer_interrupt(struct pt_regs *regs);
+
 /* Test the timer ticks to count, used in sync routine */
 inline void openrisc_timer_set(unsigned long count)
 {
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 0aa6b07efda1..afa47501118f 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -38,6 +38,14 @@ static int kstack_depth_to_print = 0x180;
 int lwa_flag;
 static unsigned long __user *lwa_addr;
 
+asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector);
+asmlinkage void do_trap(struct pt_regs *regs, unsigned long address);
+asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address);
+asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address);
+asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address);
+asmlinkage void do_illegal_instruction(struct pt_regs *regs,
+				       unsigned long address);
+
 static void print_trace(void *data, unsigned long addr, int reliable)
 {
 	const char *loglvl = data;
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index a9dcd4381d1a..01dc18aa8410 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -32,6 +32,9 @@ volatile pgd_t *current_pgd[NR_CPUS];
 
 extern void __noreturn die(char *, struct pt_regs *, long);
 
+asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
+			      unsigned long vector, int write_acc);
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
-- 
2.39.1

