Return-Path: <linux-kernel+bounces-123423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF789086E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D3D1C23542
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B80137776;
	Thu, 28 Mar 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REUcZt/N"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B0137753
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651233; cv=none; b=c1fGOGi/ye7vxagDWLD1BQa+MYBiepQRBkBM759liZHRpnsqnocIFbixFuIqhvhSiwgAyz+zqZ+NMKaM+ASS4m8f5oV0ryRTmhjh/+G8t8ipdOHLEfJwrIL69+1Y0G41lvEVGnp2CSEb+EEu+BNQZ9OnupD8wzclkcbUdfjXGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651233; c=relaxed/simple;
	bh=oKniR+mhAMy9mcMHVMjZaxDpp+nhmO80IsnuPqWrh4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2oouFS9DpuPgyM/dSGZ6mDVGIBjCGmY42cACglrJK07dRRQmhpMXybOJSmxPzvSwsHc719pHPcmwXKlbal0BAQAAdmvKukqe8EbD8YSXg7MWOp33NZ3ba12Rlp+Ya0u8mKmV65NIKsH1ljFI4P+JmkVqwAGxQuyXrk68xKZB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REUcZt/N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso8041035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711651229; x=1712256029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5HiuWpEGn7cY1cM9xGgQQ/PHhgGCf83PSLXysQQN/k=;
        b=REUcZt/N4/21w90untAA2BlhYhnh9JSz/ncwRZdrv4w3tB3P1ubi/WcNoEZXIoXWbF
         cH1FS8LOPMbPVzBEbq+ZSfTeB9oKPak+TFY6dvOZrGzu5O3/Y8GuBdIUCNEGHeN+c/hJ
         uIpPG9nqTmXWWjJoVnIE6w8JRIYMPq/c2LIrcu28J57Htq9cqENtCLMUE1jOJ9TfwDxE
         SEiAGbFkuq4DCHxpgrSzAaoHVMWs+cDWofX1rc92u8tzSifzLePEHSdpkcSZKvCHFnbl
         5ImLFVMxGhYCtJlbQrDn2rvBqWgus+RByh9x14kgdIeW0UymOMEOP2I5NwWwvGCx3Vch
         AvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651229; x=1712256029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5HiuWpEGn7cY1cM9xGgQQ/PHhgGCf83PSLXysQQN/k=;
        b=URDqPjnxG1ZupMcJ0cxBDiY7viLk6NNb6Hj8GnJTuWYTNAN3G9uQ7PI5R6eAMJO8UC
         AAelf/2sGW51TbQJgfmhf1ELeBDUoAez0WuwcLS37GvDqNxq35sAVf/48fxatSs29YrN
         nZs55BHWlnHeOqYTOQS5OIOEbwE3p5ODcAEig+AH1YwLbnXDXuPSavq1woJgGhO0jZKO
         uqdE7xeDbHEQQSFFG9WWNZmBOFzvwTMOcG76Vxde3EFY14gfDmASmOUijgR5jSxNglep
         y+dNMqN4+pt5Rh2LR0Kpv+qwOWZ2rcB+Dml3KoPBvuG+vCsXOesRp3Qc3x3e0Zv87xEb
         F5lw==
X-Forwarded-Encrypted: i=1; AJvYcCWStEIGPnlrFQG6Qb0XHDPBTeH5JCIuzoiZv7bHj1t8UYnSs5KInrX05hnpd7Whnuv38m/MvB5jbsYIhA3DL/7AB9FiO3MllneAxcL4
X-Gm-Message-State: AOJu0Yy6btdqOcZXrxGgKKyNDrUyX78J0o5SDsJiCxd3DLMJooaPuVyx
	Z7kj9O9ZX5bsmSJlUHIWupVwyqP8+/65F63dX882w/y89euzwRXE
X-Google-Smtp-Source: AGHT+IEhP9iRRtULEumOWwr08ZL9lifFDb1imTRVTFD6498BJOclfcgjhfx8rAmWuu2GenkUlyrkTQ==
X-Received: by 2002:a05:600c:3b17:b0:414:1325:e8a8 with SMTP id m23-20020a05600c3b1700b004141325e8a8mr124213wms.39.1711651229193;
        Thu, 28 Mar 2024 11:40:29 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600c3d0800b004132ae838absm3045508wmb.43.2024.03.28.11.40.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:40:29 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: [PATCH 1/2] riscv: stacktrace: use arch_stack_walk() in place of walk_stackframe
Date: Thu, 28 Mar 2024 18:40:19 +0000
Message-Id: <20240328184020.34278-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240328184020.34278-1-puranjay12@gmail.com>
References: <20240328184020.34278-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, dump_backtrace(), __get_wchan(), and perf_callchain_kernel()
directly call walk_stackframe(). Make then call arch_stack_walk() which
is a wrapper around walk_stackframe() and make walk_stackframe() static.

This allows making changes to walk_stackframe() without disturbing the
users of arch_stack_walk() which is the exposed function.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/include/asm/stacktrace.h |  2 --
 arch/riscv/kernel/perf_callchain.c  |  2 +-
 arch/riscv/kernel/stacktrace.c      | 26 ++++++++++++++------------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index b1495a7e06ce6..32213e37c379f 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -11,8 +11,6 @@ struct stackframe {
 	unsigned long ra;
 };
 
-extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-				    bool (*fn)(void *, unsigned long), void *arg);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 3348a61de7d99..c023e0b1eb814 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -74,5 +74,5 @@ static bool fill_callchain(void *entry, unsigned long pc)
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
-	walk_stackframe(NULL, regs, fill_callchain, entry);
+	arch_stack_walk(fill_callchain, entry, NULL, regs);
 }
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef93..e28f7b2e4b6a6 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,8 +18,9 @@
 
 extern asmlinkage void ret_from_exception(void);
 
-void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-			     bool (*fn)(void *, unsigned long), void *arg)
+static __always_inline void
+walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+		bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
 	int level = 0;
@@ -76,8 +77,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 #else /* !CONFIG_FRAME_POINTER */
 
-void notrace walk_stackframe(struct task_struct *task,
-	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
+static __always_inline void
+walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+		bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long sp, pc;
 	unsigned long *ksp;
@@ -107,6 +109,12 @@ void notrace walk_stackframe(struct task_struct *task,
 
 #endif /* CONFIG_FRAME_POINTER */
 
+noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+				      struct task_struct *task, struct pt_regs *regs)
+{
+	walk_stackframe(task, regs, consume_entry, cookie);
+}
+
 static bool print_trace_address(void *arg, unsigned long pc)
 {
 	const char *loglvl = arg;
@@ -118,7 +126,7 @@ static bool print_trace_address(void *arg, unsigned long pc)
 noinline void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 		    const char *loglvl)
 {
-	walk_stackframe(task, regs, print_trace_address, (void *)loglvl);
+	arch_stack_walk(print_trace_address, (void *)loglvl, task, regs);
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
@@ -143,13 +151,7 @@ unsigned long __get_wchan(struct task_struct *task)
 
 	if (!try_get_task_stack(task))
 		return 0;
-	walk_stackframe(task, NULL, save_wchan, &pc);
+	arch_stack_walk(save_wchan, &pc, task, NULL);
 	put_task_stack(task);
 	return pc;
 }
-
-noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
-		     struct task_struct *task, struct pt_regs *regs)
-{
-	walk_stackframe(task, regs, consume_entry, cookie);
-}
-- 
2.40.1


