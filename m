Return-Path: <linux-kernel+bounces-43983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4588C841BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BE11C2155C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A655E6B;
	Tue, 30 Jan 2024 06:17:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEA524AC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595464; cv=none; b=s0MqtXj2WUFUC5Ed2h7kJzmifli/W6iyWWIW56m0l1e8V/4LQa+ATmPg8cwQAXSKzeqyHdW19nvCdLachK6PElg/OU1QSsByCdB0o1jOKBDYyLhTy/fknD0dwDwWfKfQY7KhXH/wz1pl/PM/WNmqFSQKbsytQ94zsSS7a+taOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595464; c=relaxed/simple;
	bh=Im8sg4sg0+MkTbsC0WSX5gry32M+Ugq4I0b6kEVX5D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vu2Ip1E0NDIQyLtagVcGPNJT/e+kw3xr9FnTexAD2i5Jd71sVYhMKYAuwpXPPTvfqul7DK14vcy31ajEUjbVWwdSD3Hy7V8Iz85TenbuEG8oc9ikGd2Dn7dUUA6SO1hj9r6izsiQYoS6iRpqj6zj083apYfrhvXgrrDpQtrOAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxTOmElLhlHjYIAA--.15174S3;
	Tue, 30 Jan 2024 14:17:40 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S10;
	Tue, 30 Jan 2024 14:17:38 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] LoongArch: Add kernel livepatching support
Date: Tue, 30 Jan 2024 14:17:30 +0800
Message-ID: <20240130061730.21118-9-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240130061730.21118-1-yangtiezhu@loongson.cn>
References: <20240130061730.21118-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S10
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4rGFWxZFWfAw1ktr4rCrX_yoW7Jr17pr
	sxAFnxtr4UWF4Iqr9FkFyFgr98Xw1kurWagF9xKa4rCF9rZ340gr1kuFyDZFWUZ395C34x
	Wr1rKa4DWa15A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0E38UUUUUU==

The arch-specified function ftrace_regs_set_instruction_pointer() has been
implemented in arch/loongarch/include/asm/ftrace.h, so here only implement
arch_stack_walk_reliable() function.

Here are the test logs:

[root@linux fedora]# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.8.0-rc2 root=/dev/sda3
[root@linux fedora]# modprobe livepatch-sample
[root@linux fedora]# cat /proc/cmdline
this has been live patched

[root@linux fedora]# echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled
[root@linux fedora]# rmmod livepatch_sample
[root@linux fedora]# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.8.0-rc2 root=/dev/sda3

[root@linux fedora]# dmesg -t | tail -5
livepatch: enabling patch 'livepatch_sample'
livepatch: 'livepatch_sample': starting patching transition
livepatch: 'livepatch_sample': patching complete
livepatch: 'livepatch_sample': starting unpatching transition
livepatch: 'livepatch_sample': unpatching complete

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                   |  4 +++
 arch/loongarch/include/asm/thread_info.h |  2 ++
 arch/loongarch/kernel/stacktrace.c       | 41 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 17be0bff0f40..ecdc685daeea 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -132,6 +132,7 @@ config LOONGARCH
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_KVM
+	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS
@@ -141,6 +142,7 @@ config LOONGARCH
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE if UNWINDER_ORC
 	select HAVE_RETHOOK
 	select HAVE_RSEQ
 	select HAVE_RUST
@@ -695,6 +697,8 @@ config KASAN_SHADOW_OFFSET
 	default 0x0
 	depends on KASAN
 
+source "kernel/livepatch/Kconfig"
+
 menu "Power management options"
 
 config ARCH_SUSPEND_POSSIBLE
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 8cb653d49a54..8bf0e6f51546 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -86,6 +86,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define TIF_LASX_CTX_LIVE	18	/* LASX context must be preserved */
 #define TIF_USEDLBT		19	/* LBT was used by this task this quantum (SMP) */
 #define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
+#define TIF_PATCH_PENDING	21	/* pending live patching update */
 
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
@@ -105,6 +106,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
 #define _TIF_USEDLBT		(1<<TIF_USEDLBT)
 #define _TIF_LBT_CTX_LIVE	(1<<TIF_LBT_CTX_LIVE)
+#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index eaec82e02c92..8f4b217c9114 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -40,6 +40,47 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
+int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
+			     void *cookie, struct task_struct *task)
+{
+	unsigned long addr;
+	struct pt_regs dummyregs;
+	struct pt_regs *regs = &dummyregs;
+	struct unwind_state state;
+
+	if (task == current) {
+		regs->regs[3] = (unsigned long)__builtin_frame_address(0);
+		regs->csr_era = (unsigned long)__builtin_return_address(0);
+	} else {
+		regs->regs[3] = thread_saved_fp(task);
+		regs->csr_era = thread_saved_ra(task);
+	}
+	regs->regs[1] = 0;
+	regs->regs[22] = 0;
+
+	for (unwind_start(&state, task, regs);
+	     !unwind_done(&state) && !unwind_error(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+
+		/*
+		 * A NULL or invalid return address probably means there's some
+		 * generated code which __kernel_text_address() doesn't know about.
+		 */
+		if (!addr)
+			return -EINVAL;
+
+		if (!consume_entry(cookie, addr))
+			return -EINVAL;
+	}
+
+	/* Check for stack corruption */
+	if (unwind_error(&state))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 copy_stack_frame(unsigned long fp, struct stack_frame *frame)
 {
-- 
2.42.0


