Return-Path: <linux-kernel+bounces-123424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EB89086F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31268B228C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B6137909;
	Thu, 28 Mar 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WILdEATH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713E1311B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651234; cv=none; b=Qox2/u4WXZzeNZSz1nuI6so557vYSEv+kDQsXm4O0ySLG4HyBYLcPAFspFjKOTPV2BcICSYjtG1FwS3im6uqwsiYsQdVdC24Ag+yUpXSNmhkmIXqFaA0PsjY0FXxTFGV1y//rHWsdWRlHS6GzXZl+B3zgWk4yqMjYcgz3CKED7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651234; c=relaxed/simple;
	bh=3+HcpEDIUv/U/MagIYqae6hh8rleCf2Nx6qrx0rT13k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaMXw4cZLWqUTio4tegWTQBBq2bM+9pS8VqnaPGkwA9U1hVZWD4kxWLkagwPEKD8QCuFwJNnacNYqnPetr1V6XbPo1vUGgdxQ7e7vl24/mHoFvQ7ViQiSxVuC56USkjJXhXGt1J8zjjbWn6W/0QweRg38ZuSkHEPrTLVz8A8+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WILdEATH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415482308f8so4776595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711651231; x=1712256031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAOQkTdKXTaBL7Qciv0ydA9PkCnbK+OLuX0dvpnwkyo=;
        b=WILdEATHHZqKt1Le6MVto91P81m7DtnuCBij48tHUrSW/IDrmg8IaCzYfxlwcbtc6n
         mvHL21nQMWvUWkrgb8iyT5UxE4BoAKylmCXRoOaTiV5J3w2MOuW7AbiPLlLB1xsCku93
         tKCDUMlzTPxBd7nFzy1u0UbikXKfkX1aAuYxyin8ykVxGEO9Zx625jsFpEIVUu+3A10S
         q+1rOpT2RdFXHyif1JtUaA+JtEfiXMhmxylzLHrDm508D2HZlKHkoi/2Zmmp+AW8crX5
         VoIAyYR3bvmKvSwyFZi97s/UoVXaPWvueaZOnGQEmo0kviMYm1cXNHK0X1JsYb1x2zyU
         0q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651231; x=1712256031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAOQkTdKXTaBL7Qciv0ydA9PkCnbK+OLuX0dvpnwkyo=;
        b=IR51g4DZdAQ718Mpd34r1g3Bj55XZ1oC4OeoJvL2IH4DC7zt+go7YEEh54RKiDUP0B
         Kx+Gj4DM3hUWwdtyJzNzsbVdiO93WwZLg6pC/0nUKO1YOKmulSFCFnJzKlr4Myg/2NMC
         61G3Ey9QgQKUFz0o8M1qhbk+Qo3/GKm1GZFA91R3cwxu//koPevlSjdb6VDg8OivV7G7
         RZUBoK6Bt8/q8hy5evnl/3GradB86AlSeRNAGtNf50Ye71UqzZv5+UgiUgynxtX55ky7
         GghOQrauP53jN139Ogk+JDPg91ZTPO6zHYolLQqJ9ggouiSjViRqCyNo30RY+RfzlSqF
         y7ug==
X-Forwarded-Encrypted: i=1; AJvYcCWeMdpWlDVefcDtc3xoX5Zg43lvd3AgUkbticQ8edX8WIgJGhbzkxCHg0YlEo7HOZHCVlLdm3Y9k49j8HGxWA+GscqyqshSPWtsaqCh
X-Gm-Message-State: AOJu0Yyg6+Z3VP/USKzvTLeQdJC9i/VqqSxlRY8bBmflr/VfmTvzQIAS
	o+FP6UPBSRk7NUhG2rYirFgomrUD2s82kxnjnOjeKXWAvyhMUn52SV9YJACmsfk=
X-Google-Smtp-Source: AGHT+IGkeYHwiRZkr52SSP8OsgcXPmyzoOnpkNo7qZq10LSJmGPGKaRRqPv8tAL/pYZXos9qB/4zPw==
X-Received: by 2002:a05:600c:3c8c:b0:414:a69:f0b1 with SMTP id bg12-20020a05600c3c8c00b004140a69f0b1mr140663wmb.13.1711651231344;
        Thu, 28 Mar 2024 11:40:31 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0041493009a8bsm6272490wmq.11.2024.03.28.11.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:40:31 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: [PATCH 2/2] riscv: stacktrace: make walk_stackframe() more robust
Date: Thu, 28 Mar 2024 18:40:20 +0000
Message-Id: <20240328184020.34278-3-puranjay12@gmail.com>
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

Currently walk_stackframe() provides only a cookie and the PC to the
consume_entry function. This doesn't allow the implementation of
advanced stack walkers that need access to SP and FP as well.

Change walk_stackframe to provide a struct unwind_state to the
consume_entry function. This unwind_state has all information that is
available to walk_stackframe. The information provided to the callback
will not always be live/useful, the callback would be aware of the
different configurations the information in unwind_state can be.

For example: if CONFIG_FRAME_POINTER is not available, unwind_state->fp
will always be zero.

This commit doesn't make any functional changes.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 55 ++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index e28f7b2e4b6a6..92c41c87b267b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -14,15 +14,26 @@
 
 #include <asm/stacktrace.h>
 
+struct unwind_state {
+	unsigned long fp;
+	unsigned long sp;
+	unsigned long pc;
+	struct pt_regs *regs;
+	struct task_struct *task;
+};
+
+typedef bool (*unwind_consume_fn)(void *cookie, const struct unwind_state *state);
+
 #ifdef CONFIG_FRAME_POINTER
 
 extern asmlinkage void ret_from_exception(void);
 
 static __always_inline void
 walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-		bool (*fn)(void *, unsigned long), void *arg)
+		unwind_consume_fn fn, void *arg)
 {
 	unsigned long fp, sp, pc;
+	struct unwind_state state;
 	int level = 0;
 
 	if (regs) {
@@ -40,12 +51,17 @@ walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		sp = task->thread.sp;
 		pc = task->thread.ra;
 	}
+	state.task = task;
+	state.regs = regs;
 
 	for (;;) {
 		unsigned long low, high;
 		struct stackframe *frame;
 
-		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
+		state.sp = sp;
+		state.fp = fp;
+		state.pc = pc;
+		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, &state))))
 			break;
 
 		/* Validate frame pointer */
@@ -64,7 +80,10 @@ walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
 			if (pc == (unsigned long)ret_from_exception) {
-				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
+				state.sp = sp;
+				state.fp = fp;
+				state.pc = pc;
+				if (unlikely(!__kernel_text_address(pc) || !fn(arg, &state)))
 					break;
 
 				pc = ((struct pt_regs *)sp)->epc;
@@ -79,9 +98,10 @@ walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 static __always_inline void
 walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-		bool (*fn)(void *, unsigned long), void *arg)
+		unwind_consume_fn fn, void *arg)
 {
 	unsigned long sp, pc;
+	struct unwind_state state;
 	unsigned long *ksp;
 
 	if (regs) {
@@ -99,9 +119,14 @@ walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	if (unlikely(sp & 0x7))
 		return;
 
+	state.task = task;
+	state.regs = regs;
+	state.sp = sp;
+	state.fp = 0;
 	ksp = (unsigned long *)sp;
 	while (!kstack_end(ksp)) {
-		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
+		state.pc = pc;
+		if (__kernel_text_address(pc) && unlikely(!fn(arg, &state)))
 			break;
 		pc = READ_ONCE_NOCHECK(*ksp++) - 0x4;
 	}
@@ -109,10 +134,28 @@ walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 #endif /* CONFIG_FRAME_POINTER */
 
+struct unwind_consume_entry_data {
+	stack_trace_consume_fn consume_entry;
+	void *cookie;
+};
+
+static __always_inline bool
+arch_unwind_consume_entry(void *cookie, const struct unwind_state *state)
+{
+	struct unwind_consume_entry_data *data = cookie;
+
+	return data->consume_entry(data->cookie, state->pc);
+}
+
 noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 				      struct task_struct *task, struct pt_regs *regs)
 {
-	walk_stackframe(task, regs, consume_entry, cookie);
+	struct unwind_consume_entry_data data = {
+		.consume_entry = consume_entry,
+		.cookie = cookie,
+	};
+
+	walk_stackframe(task, regs, arch_unwind_consume_entry, &data);
 }
 
 static bool print_trace_address(void *arg, unsigned long pc)
-- 
2.40.1


