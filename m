Return-Path: <linux-kernel+bounces-99362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE38878754
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F7BB2166D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979003FE3D;
	Mon, 11 Mar 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFJyZfd0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvHG3UG0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB544369
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181807; cv=none; b=Y6ukme0vgq5QC95H2NtRO1NOZbUy+Gs+oPc9puzkk/35YkcWWaI3gGxfkgs0cf7ZL4SDFtKF6GW8fq8lEsg1oIxcnl7hRGWHDZs8TsRsOc9Ynhv2LqdtpC6bMhOK8fSYOM4KfgJ5Ejwu5wnohjb1WvpYlwubNKs4n9ZNQ8eJcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181807; c=relaxed/simple;
	bh=fm2FLIn4odaNf0q5SvsoGlXD6pl80rwBwDhDtso44N4=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=YUb/4xucuP6IxuY+03NGvUKEW/rI2oIG9wz3OKkNE5s9dKyD/x5yxs/gFuKcXWH1fjOSMMlM5Y/6hxGWVp9jZ7MyCju9vg52KC7gWLUDNy0HpMSGWxOuuioRXWciUv4L+cD0cWit300gOXr6C3GZhqDq3sHsD6CDnqRE5aw9O8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFJyZfd0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvHG3UG0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710181804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TN1h7UcZuxgZJN+Vb5I8KhxG408EZJVitRElkFq1lnc=;
	b=bFJyZfd0dvX6XBzSQyCwYYyp4gH+G+3PpatS5T6uPGcJFiBVWOoYiOWDe8Z04iluViPJEn
	I7TBhLLkXOuXAjOW6gSRvK8Ho03vz63waeWjDHrybEkavFk+8yFtz9LDF/CxrL47C9pmK+
	bpDjkidFn2Tmc2SkqdrvLZMfxJLUU9Q1WQIn6FNrptAWHyy6q9HKwxzyboyFASMNvjYCjv
	h7vMj7YWhI3Fe6Zdx/DgylwjxZxwo2l0M8dhPhNcL+VigVaSB/IoNH58rz0PWYuIgyES19
	bUDFh/0RoQ7oyfF8GmS7+kT9XAIQ8FQn3f4U5DYK+zdDwQNnNJ2zi7hi220OWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710181804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TN1h7UcZuxgZJN+Vb5I8KhxG408EZJVitRElkFq1lnc=;
	b=YvHG3UG0xPs02rHNFdfz0e7Eg3x+l3oOLUKogVVluGtSIR4xAwor0kOEfkZN5YxKR6VcAe
	GRi3CX4Xqr+jqSDA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for v6.9-rc1
Message-ID: 
 <171018178863.2492473.12231985539041412452.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 19:30:03 +0100 (CET)

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-0=
3-11

up to:  bb998361999e: x86/entry: Avoid redundant CR3 write on paranoid returns


A single update for the x86 entry code:

  The current CR3 handling for kernel page table isolation in the paranoid
  return paths which are relevant for #NMI, #MCE, #VC, #DB and #DF is
  unconditionally writing CR3 with the value retrieved on exception entry.

  In the vast majority of cases when returning to the kernel this is a
  pointless exercise because CR3 was not modified on exception entry. The
  only situation where this is necessary is when the exception interrupts a
  entry from user before switching to kernel CR3 or interrupts an exit to
  user after switching back to user CR3.

  As CR3 writes can be expensive on some systems this becomes measurable
  overhead with high frequency #NMIs such as perf.

  Avoid this overhead by checking the CR3 value, which was saved on entry,
  and write it back to CR3 only when it us a user CR3.

Thanks,

	tglx

------------------>
Lai Jiangshan (1):
      x86/entry: Avoid redundant CR3 write on paranoid returns


 arch/x86/entry/calling.h  | 26 ++++++++++----------------
 arch/x86/entry/entry_64.S |  7 +++----
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1d94790a54..92dca4a4a15c 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -239,17 +239,19 @@ For 32-bit we have the following conventions - kernel i=
s built with
 .Ldone_\@:
 .endm
=20
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+/* Restore CR3 from a kernel context. May restore a user CR3 value. */
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
=20
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
=20
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -257,20 +259,12 @@ For 32-bit we have the following conventions - kernel i=
s built with
 	 */
 	movq	\save_reg, \scratch_reg
 	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
+	jc	.Lwrcr3_\@
=20
-.Lnoflush_\@:
 	SET_NOFLUSH_BIT \save_reg
=20
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
@@ -285,7 +279,7 @@ For 32-bit we have the following conventions - kernel is =
built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 .endm
=20
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89ab1b4c..aedd169c46c9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -968,14 +968,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	IBRS_EXIT save_reg=3D%r15
=20
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
+	 * The order of operations is important. PARANOID_RESTORE_CR3 requires
 	 * kernel GSBASE.
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_return instead.
 	 */
-	RESTORE_CR3	scratch_reg=3D%rax save_reg=3D%r14
+	PARANOID_RESTORE_CR3 scratch_reg=3D%rax save_reg=3D%r14
=20
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1404,8 +1404,7 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=3D%r15
=20
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=3D%r15 save_reg=3D%r14
+	PARANOID_RESTORE_CR3 scratch_reg=3D%r15 save_reg=3D%r14
=20
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE


