Return-Path: <linux-kernel+bounces-19447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708AB826D05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2E4282FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2822065;
	Mon,  8 Jan 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEjqpgon"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E351E497
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33753ac460bso1181350f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704713996; x=1705318796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYojaOK4ISq04M658HG0Lc/KZ0ySyiQHYKNYCJoto0c=;
        b=CEjqpgonj8m+5sondGn57GtCVxqwa8qCUkPzP+Z9764GAG5mZba2EE48W+soeOnVyY
         +qN5zpHnB/auGbfWdCuEqdnHGk0ouNdiEUjwsUBd8Hosr+UmQsyjOLA8IG9IAb7m62ps
         U2a/inhAp/dgIit34SN6fM5gBGwincQfUz8qzl+CjjKsu/xjr6ISu2FjcrsXk817MyrJ
         CVwyqXYh0Q6TIj1D4R6J1npigIfSwuzRebFdPa4+eLuTkIXh+sPbeb1IWLuCApg/Fymv
         cZrkJ/G2vSUP6lUlD8GlCR11eYg8mqIe0nSUMUzAbdxlslRVFR4IjInN4jScS3/9xC/f
         4b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713996; x=1705318796;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYojaOK4ISq04M658HG0Lc/KZ0ySyiQHYKNYCJoto0c=;
        b=sEt83iQd7VBKlf3BaZlFmCWE0EuqcHh6aQb34dECdYUXicf3EDVwnAoQ0tIqg/+aLY
         ZUBxj3DHX4foViCSVNBsOKQa4bo6BN7RlUAoGPH83IYiC/CEBChmYwvqDVJS0X1cHdPL
         jd8mQpNUYdcMZz+gqf/uVQghu3LW3XAA7F2Yy3gOQs131I6ZaNbjc1tXFrnKmIh0lFqB
         +mtFut2uEYHFChmqu0T6STbUa19aZOpcN/9HPUmrmrOyWoFSD1iLydf44QWaNkUicP8v
         PfiVKTRz6Sk0eMJWl99ff0Gp9u5BRsFEQvsjDgV7MvBS5TzWMnoh3T9ufvc26LT2ZXvt
         FqBQ==
X-Gm-Message-State: AOJu0Yw+VKOk5fyhBeF4IJjEMRmDt2uoS+eGsKpmxY7ZbgB19j+jEuk4
	Qi/1cv25a68jHCs8c/5mpPMhChCQyOifd7IaLo9h
X-Google-Smtp-Source: AGHT+IHMmf52kGj2P/XSi6kfkFV9ZlexWdM7YQjiOQF59eZwbeswVX/euw77KcuNiNyxDc9oJv2aw7dEqFYP/g==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6000:4007:b0:337:54d0:a99e with SMTP
 id cp7-20020a056000400700b0033754d0a99emr12525wrb.2.1704713995691; Mon, 08
 Jan 2024 03:39:55 -0800 (PST)
Date: Mon,  8 Jan 2024 11:39:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240108113950.360438-1-jackmanb@google.com>
Subject: [PATCH v3 RESEND] x86/entry: Avoid redundant CR3 write on paranoid returns
From: Brendan Jackman <jackmanb@google.com>
To: luto@kernel.org, tglx@linutronix.de, peterz@infradead.org, 
	dave.hansen@linux.intel.com
Cc: mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, laijs@linux.alibaba.com, yosryahmed@google.com, 
	reijiw@google.com, oweisse@google.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Lai Jiangshan <laijs@linux.alibaba.com>

This path gets used called from:

1. #NMI return.
2. paranoid_exit (i.e. #MCE, #VC, #DB and #DF return)

Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
RESTORE_CR3"), the kernel never modifies CR3 in any of these exceptions,
except for switching from user to kernel pagetables under PTI. That
means that most of the time when returning from an exception that
interrupted the kernel no CR3 restore is necessary. Writing CR3 is
expensive on some machines, so this commit avoids redundant writes.

I said "most of the time" because the interrupt might have come during
kernel entry before the user->kernel CR3 switch or the during exit after
the kernel->user switch. In the former case skipping the restore might
actually be be fine, but definitely not the latter. So we do still need
to check the saved CR3 and restore it if it's a user CR3.

Note this code is ONLY used for returning _to kernel code_. So the only
times where the CR3 write is necessary are in those rather special cases
mentioned above where we are in kernel _code_ but a userspace CR3.

While changing this logic the macro is given a new name to clarify its
usage, and a comment that was describing its behaviour at the call site
is removed.  We can also simplify the code around the SET_NOFLUSH_BIT
invocation as we no longer need to branch to it from above.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
[Rewrote commit message; responded to review comments]
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Change-Id: I6e56978c4753fb943a7897ff101f519514fa0827
---

Notes:
    v1: https://lore.kernel.org/lkml/20230817121513.1382800-1-jackmanb@google.com/

    v1->v2: Rewrote some comments, added a proper commit message, cleaned up
        the code per tglx's suggestion.

        I've kept Lai as the Author. If you prefer for the blame to
        record the last person that touched it then that's also fine
        though, I can credit Lai as Co-developed-by.

    v2: https://lore.kernel.org/lkml/20230920150443.1789000-1-jackmanb@google.com/

    v2->v3: Clarified the commit message per Dave's suggestion and renamed the
        macro. I did not carry PeterZ's ack since I have made some changes.

    original v3 (no responses): 
        https://lore.kernel.org/lkml/20231108171656.3444702-1-jackmanb@google.com/

Thanks for the reviews :)

 arch/x86/entry/calling.h  | 26 ++++++++++----------------
 arch/x86/entry/entry_64.S |  7 +++----
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..25cbfba1fe46 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -233,17 +233,19 @@ For 32-bit we have the following conventions - kernel is built with
 .Ldone_\@:
 .endm
 
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+/* Restore CR3 from a kernel context. May restore a user CR3 value. */
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
 	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
+	 * If CR3 contained the kernel page tables at the paranoid exception
+	 * entry, then there is nothing to restore as CR3 is not modified while
+	 * handling the exception.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -251,20 +253,12 @@ For 32-bit we have the following conventions - kernel is built with
 	 */
 	movq	\save_reg, \scratch_reg
 	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
+	jc	.Lwrcr3_\@
 
-.Lnoflush_\@:
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
@@ -279,7 +273,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 .endm
 
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de6469dffe3a..d65182500bfe 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -957,14 +957,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	IBRS_EXIT save_reg=%r15
 
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
+	 * The order of operations is important. PARANOID_RESTORE_CR3 requires
 	 * kernel GSBASE.
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_return instead.
 	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%rax save_reg=%r14
 
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1393,8 +1393,7 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE
-- 
2.42.0.869.gea05f2083d-goog


