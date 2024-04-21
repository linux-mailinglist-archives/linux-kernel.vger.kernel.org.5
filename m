Return-Path: <linux-kernel+bounces-152620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41F8AC144
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562EA1C208C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F644502B;
	Sun, 21 Apr 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ5FZX3x"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11118175AB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713736056; cv=none; b=Mo/9ONsxMui3dpdGSpv6gSgDXrBJvgLP19aRhQz3+QjTKQA2sntL9fV07GdULI0QvKlMONq+wv9JQoHKgrn9QMYkHdQ4A80cgM7V+v5FCuAkRSZkAcwL+nyRqpu0rg8aA9IhkpFi5/6PYz5j++d5tEFV5VW4eYGxj+H97A57kSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713736056; c=relaxed/simple;
	bh=55cFyowPRQcAuZCAm74mGcZqV3pGFOh7nlaogycghl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oua62nlgCuAMiuHvXMxHpJwJn3gN85LJBx4tqEdRlNt+ldjhMMej/alh8wPVJXnK/FJMf+Z4QbO7e268TMCOYhXHTB0HDOxM425RUMqpnrZP+yDNARbglOgPgGT/Olc+OyPa65DX5rjcUOX1VjPDU9k1IiCCfYw8CzgNHdmgxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ5FZX3x; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4018777a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713736052; x=1714340852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dPrlMR2LlSXorqsYbQUia1JGWWuxkhaFr+ccGJDJnT0=;
        b=lJ5FZX3xv8zr3amfwUGSLUywzFjd6CeiowMVw138PcEHhjSG02QdJaM2RaPwjpJMru
         JxBi9XrjV/UEX5v1lPsJ9KcrSTiVrl0+PGeFKwBvxpZyIXQ9z6zlp77aEbcjrk5MixC3
         7rtdzx8cREgFxLArZfWcr/0XLKmud4bWbsyrmv7bdwNIzcFB/O4TDlot1J0O2MGlqoZD
         LLpUXfxRgVVd3daOa+jfF9kIjjy/eOw5/n6Zaf0lNy67ccHG4XAanlFInHCeJuqCmiLG
         tkLQrllJdlyaoEfBoFUwOuoaGRTXDIVDmnQXps3ORtYWFa6fNS4csESYsz2LisIvNQGF
         LNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713736052; x=1714340852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPrlMR2LlSXorqsYbQUia1JGWWuxkhaFr+ccGJDJnT0=;
        b=KkWv9DHahi5XtahsvKt7heRp8qhzBLo6c2076UEHGcLzXTXnYSHa/SvqAujd023t7c
         P0bN2hSo9Se2dTaG535it3JTTOhwz99k0vCDEzNo87hJwmGpPQMtW9V/oCCwBQ/DMINE
         mqTZ/KFrL9Fzlhr/wRpVGdfinVJs6x9IjgfCKasRiacUuAfmeKMvsN7AaaRrlC4EFSsX
         ksUzJUexTmynWgmcg1xUweTPmdCRK4aR5vBRiL1hBDQnFbfrSRhcyMCR/ytfeH9CZHqG
         FQt32+wvP5zXpXaY2NJoK9DxAPq/So5Rx9c6mQ3LMngqQlY8I6sHumzplOaC5qa6e9Fu
         Vg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUutYmFFfMt4xdF7VWWOQzORJZmZNKJQg7+GeNt+2JKZLHGRZsLy8/jv8YAaHAj2U4qifYU9XhTSJSNo/yjjzXjbsbLQ8Y8yN9TY40a
X-Gm-Message-State: AOJu0YxCBRfgn9rtCNcU2Uxrpg24xEV8etiIWgwn68Jag+2JZttCzscU
	t94uFH0vBy0/Z8Eig+QHtt/9GchkXQhK1zEC3Gzz7L5vJASwVcRuy+VhB01GTNnD6rz9+aY+dWu
	2KRweuR/B7g985IAasct3D3bxWf8=
X-Google-Smtp-Source: AGHT+IGfr3LCBeo6+/EqCBaw3gTVoyojA5/kaFILs8XIS0FDNloXGktBbRyKNm/5z0Wt7AIZXJ6o8CuD+zQRMIZFU4Q=
X-Received: by 2002:a50:ab51:0:b0:56d:ee61:6874 with SMTP id
 t17-20020a50ab51000000b0056dee616874mr5604787edc.20.1713736051940; Sun, 21
 Apr 2024 14:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713559768.git.jpoimboe@kernel.org> <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop> <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
In-Reply-To: <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
From: Paul McKenney <paulmckrcu@gmail.com>
Date: Sun, 21 Apr 2024 14:47:20 -0700
Message-ID: <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers __noreturn
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>, 
	Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009d80140616a24482"

--0000000000009d80140616a24482
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And this definitely helped, thank you!

However, this one still remains:

vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
__ia32_sys_exit_group() is missing a __noreturn annotation

Please see below for my diffs against next-20240419, in case I messed
something up.

I attached a copy as well, given that I am away from mutt, hence using
gmail directly.

                                                Thanx, Paul

-----------------------------------------------------

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e6..9810ba2857a5c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,7 +49,10 @@ static __always_inline bool do_syscall_x64(struct
pt_regs *regs, int nr)

  if (likely(unr < NR_syscalls)) {
  unr =3D array_index_nospec(unr, NR_syscalls);
- regs->ax =3D x64_sys_call(regs, unr);
+ if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+ regs->ax =3D sys_call_table[unr](regs);
+ else
+ regs->ax =3D x64_sys_call(regs, unr);
  return true;
  }
  return false;
@@ -66,7 +69,10 @@ static __always_inline bool do_syscall_x32(struct
pt_regs *regs, int nr)

  if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
  xnr =3D array_index_nospec(xnr, X32_NR_syscalls);
- regs->ax =3D x32_sys_call(regs, xnr);
+ if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+ regs->ax =3D x32_sys_call_table[xnr](regs);
+ else
+ regs->ax =3D x32_sys_call(regs, xnr);
  return true;
  }
  return false;
@@ -162,7 +168,10 @@ static __always_inline void
do_syscall_32_irqs_on(struct pt_regs *regs, int nr)

  if (likely(unr < IA32_NR_syscalls)) {
  unr =3D array_index_nospec(unr, IA32_NR_syscalls);
- regs->ax =3D ia32_sys_call(regs, unr);
+ if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
+ regs->ax =3D ia32_sys_call_table[unr](regs);
+ else
+ regs->ax =3D ia32_sys_call(regs, unr);
  } else if (nr !=3D -1) {
  regs->ax =3D __ia32_sys_ni_syscall(regs);
  }
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index c2235bae17ef6..aab31760b4e3e 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -14,25 +14,16 @@
 #endif

 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *=
);
-
 #include <asm/syscalls_32.h>
 #undef __SYSCALL

-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
-#ifdef CONFIG_X86_32
 #define __SYSCALL(nr, sym) __ia32_##sym,
-const sys_call_ptr_t sys_call_table[] =3D {
+const sys_call_ptr_t ia32_sys_call_table[] =3D {
 #include <asm/syscalls_32.h>
 };
 #undef __SYSCALL
-#endif

 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-
 long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
  switch (nr) {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 33b3f09e6f151..ff36a993a07e0 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,13 @@
 #include <asm/syscall.h>

 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *)=
;
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
__x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL

-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
+#undef __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
+
 #define __SYSCALL(nr, sym) __x64_##sym,
 const sys_call_ptr_t sys_call_table[] =3D {
 #include <asm/syscalls_64.h>
@@ -23,7 +22,6 @@ const sys_call_ptr_t sys_call_table[] =3D {
 #undef __SYSCALL

 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-
 long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
  switch (nr) {
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 03de4a9321318..4221ecce6e689 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,11 +8,20 @@
 #include <asm/syscall.h>

 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *)=
;
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
__x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL

-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+#undef __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
+
+#define __SYSCALL(nr, sym) __x64_##sym,
+const sys_call_ptr_t x32_sys_call_table[] =3D {
+#include <asm/syscalls_x32.h>
+};
+#undef __SYSCALL

+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
  switch (nr) {
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e6ab5bf..7ec68d94eb593 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -2,7 +2,7 @@
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [0 noreturn]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +68,7 @@
 57 common fork sys_fork
 58 common vfork sys_vfork
 59 64 execve sys_execve
-60 common exit sys_exit
+60 common exit sys_exit 0 noreturn
 61 common wait4 sys_wait4
 62 common kill sys_kill
 63 common uname sys_newuname
@@ -239,7 +239,7 @@
 228 common clock_gettime sys_clock_gettime
 229 common clock_getres sys_clock_getres
 230 common clock_nanosleep sys_clock_nanosleep
-231 common exit_group sys_exit_group
+231 common exit_group sys_exit_group 0 noreturn
 232 common epoll_wait sys_epoll_wait
 233 common epoll_ctl sys_epoll_ctl
 234 common tgkill sys_tgkill
diff --git a/arch/x86/include/asm/cpufeatures.h
b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661c..d64b0a5291f10 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL (21*32+ 2) /* "" BHI_DIS_S HW control availab=
le */
 #define X86_FEATURE_CLEAR_BHB_HW (21*32+ 3) /* "" BHI_DIS_S HW
control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear
branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_BRANCH_OK (21*32+ 5) /* "" It's OK to
use indirect branches */

 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.=
h
index 2fc7bc3863ff6..dfb59521244c2 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,14 +16,20 @@
 #include <asm/thread_info.h> /* for TS_COMPAT */
 #include <asm/unistd.h>

-/* This is used purely for kernel/trace/trace_syscalls.c */
 typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];

+#if defined(CONFIG_X86_32)
+#define ia32_sys_call_table sys_call_table
+#else
 /*
  * These may not exist, but still put the prototypes in so we
  * can use IS_ENABLED().
  */
+extern const sys_call_ptr_t ia32_sys_call_table[];
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
+
 extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab18185894dfd..5fca46c78daf2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1665,6 +1665,12 @@ static void __init bhi_select_mitigation(void)
  if (!IS_ENABLED(CONFIG_X86_64))
  return;

+ /*
+ * There's no HW mitigation in place.  Mark indirect branches as
+ * "not OK".
+ */
+ setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+
  /* Mitigate KVM by default */
  setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
  pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
@@ -1679,6 +1685,28 @@ static void __init spectre_v2_select_mitigation(void=
)
  enum spectre_v2_mitigation_cmd cmd =3D spectre_v2_parse_cmdline();
  enum spectre_v2_mitigation mode =3D SPECTRE_V2_NONE;

+ /*
+ * X86_FEATURE_INDIRECT_BRANCH_OK indicates that indirect calls are
+ * "OK" to use due to (at least) one of the following being true:
+ *
+ *   - the CPU isn't vulnerable to Spectre v2, BHI, etc;
+ *
+ *   - a HW mitigation is in place (e.g., IBRS, eIBRS+BHI_DIS_S); or
+ *
+ *   - the user disabled mitigations.
+ *
+ * Clearing the bit enables certain indirect branch "easy targets" [*]
+ * to be converted to a series of direct branches.
+ *
+ * Assume innocence until proven guilty: set it now and clear it later
+ * if/when needed.
+ *
+ * [*] The closer the indirect branch is to kernel entry, and the more
+ *     user-controlled registers there are, the easier target it may be
+ *     for future Spectre v2 variants.
+ */
+ setup_force_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+
  /*
  * If the CPU is not affected and the command line mode is NONE or AUTO
  * then nothing to do.
@@ -1765,11 +1793,16 @@ static void __init spectre_v2_select_mitigation(voi=
d)
  break;

  case SPECTRE_V2_LFENCE:
+ setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+ fallthrough;
  case SPECTRE_V2_EIBRS_LFENCE:
  setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
- fallthrough;
+ setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+ break;

  case SPECTRE_V2_RETPOLINE:
+ setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
+ fallthrough;
  case SPECTRE_V2_EIBRS_RETPOLINE:
  setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
  break;
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_3=
2.c
index 89df5d89d6640..c7d4bf955d2ba 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -24,6 +24,7 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)

 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
unsigned long, unsigned long, unsigned long, unsigned long, unsigned
long);
+#define __SYSCALL_NORETURN __SYSCALL
 #include <asm/syscalls_32.h>

 #undef __SYSCALL
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_6=
4.c
index b0b4cfd2308c8..4760c40ae5cd0 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -19,6 +19,7 @@
 #define sys_ioperm sys_ni_syscall

 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
unsigned long, unsigned long, unsigned long, unsigned long, unsigned
long);
+#define __SYSCALL_NORETURN __SYSCALL
 #include <asm/syscalls_64.h>

 #undef __SYSCALL
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6abe143889ef6..16487d47e06a3 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -54,7 +54,7 @@ nxt=3D0

 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {

- while read nr abi name native compat ; do
+ while read nr abi name native compat noreturn; do

  if [ $nxt -gt $nr ]; then
  echo "error: $infile: syscall table is not sorted or duplicates the
same syscall number" >&2
@@ -66,7 +66,9 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
  nxt=3D$((nxt + 1))
  done

- if [ -n "$compat" ]; then
+ if [ -n "$noreturn" ]; then
+ echo "__SYSCALL_NORETURN($nr, $native)"
+ elif [ -n "$compat" ]; then
  echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
  elif [ -n "$native" ]; then
  echo "__SYSCALL($nr, $native)"
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 7ebf29c911849..1e8141ef1b15d 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -7,12 +7,16 @@
  * Yes, this is unfortunate.  A better solution is in the works.
  */
 NORETURN(__fortify_panic)
+NORETURN(__ia32_sys_exit)
+NORETURN(__ia32_sys_exit_group)
 NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
 NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(__x64_sys_exit)
+NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)

On Sun, Apr 21, 2024 at 1:40=E2=80=AFPM Paul McKenney <paulmckrcu@gmail.com=
> wrote:
>
> They apply fine as is, so I have started tests with that pair of patches.
>
>                                               Thanx, Paul
>
> On Sat, Apr 20, 2024 at 10:25=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> >
> > On Sat, Apr 20, 2024 at 06:58:58AM -0700, Paul E. McKenney wrote:
> > > On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> > > > The direct-call syscall dispatch functions don't know that the exit=
()
> > > > and exit_group() syscall handlers don't return.  As a result the ca=
ll
> > > > sites aren't optimized accordingly.
> > > >
> > > > Fix that by marking those exit syscall declarations as __noreturn.
> > > >
> > > > Fixes the following warnings:
> > > >
> > > >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit(=
) is missing a __noreturn annotation
> > > >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exi=
t_group() is missing a __noreturn annotation
> > > >
> > > > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch hist=
ory at syscall entry")
> > > > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a0885=
2f17a3@paulmck-laptop
> > > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > >
> > > Looks good, but it does not apply on top of current -next and I don't
> > > trust myself to hand-apply it (something about having just got off of
> > > a flight across the big pond).
> > >
> > > Could you please let me know what else do I need to pull in to be abl=
e
> > > to cleanly apply this one?
> >
> > This patch has a dependency on an earlier patch in the set:
> >
> >   https://lkml.kernel.org/lkml/982d05a2f669140f26500bee643011896d661094=
1713559768.git.jpoimboe@kernel.org
> >
> > Though I think it's not a hard dependency and I could reverse the order
> > of the patches if needed.
> >
> > --
> > Josh

--0000000000009d80140616a24482
Content-Type: application/octet-stream; name=diffs
Content-Disposition: attachment; filename=diffs
Content-Transfer-Encoding: base64
Content-ID: <f_lva26ptk0>
X-Attachment-Id: f_lva26ptk0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jIGIvYXJjaC94ODYvZW50cnkvY29t
bW9uLmMKaW5kZXggNmRlNTBiODA3MDJlNi4uOTgxMGJhMjg1N2E1YyAxMDA2NDQKLS0tIGEvYXJj
aC94ODYvZW50cnkvY29tbW9uLmMKKysrIGIvYXJjaC94ODYvZW50cnkvY29tbW9uLmMKQEAgLTQ5
LDcgKzQ5LDEwIEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBkb19zeXNjYWxsX3g2NChz
dHJ1Y3QgcHRfcmVncyAqcmVncywgaW50IG5yKQogCiAJaWYgKGxpa2VseSh1bnIgPCBOUl9zeXNj
YWxscykpIHsKIAkJdW5yID0gYXJyYXlfaW5kZXhfbm9zcGVjKHVuciwgTlJfc3lzY2FsbHMpOwot
CQlyZWdzLT5heCA9IHg2NF9zeXNfY2FsbChyZWdzLCB1bnIpOworCQlpZiAobGlrZWx5KGNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSU5ESVJFQ1RfQlJBTkNIX09LKSkpCisJCQlyZWdz
LT5heCA9IHN5c19jYWxsX3RhYmxlW3Vucl0ocmVncyk7CisJCWVsc2UKKwkJCXJlZ3MtPmF4ID0g
eDY0X3N5c19jYWxsKHJlZ3MsIHVucik7CiAJCXJldHVybiB0cnVlOwogCX0KIAlyZXR1cm4gZmFs
c2U7CkBAIC02Niw3ICs2OSwxMCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgZG9fc3lz
Y2FsbF94MzIoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGludCBucikKIAogCWlmIChJU19FTkFCTEVE
KENPTkZJR19YODZfWDMyX0FCSSkgJiYgbGlrZWx5KHhuciA8IFgzMl9OUl9zeXNjYWxscykpIHsK
IAkJeG5yID0gYXJyYXlfaW5kZXhfbm9zcGVjKHhuciwgWDMyX05SX3N5c2NhbGxzKTsKLQkJcmVn
cy0+YXggPSB4MzJfc3lzX2NhbGwocmVncywgeG5yKTsKKwkJaWYgKGxpa2VseShjcHVfZmVhdHVy
ZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lORElSRUNUX0JSQU5DSF9PSykpKQorCQkJcmVncy0+YXgg
PSB4MzJfc3lzX2NhbGxfdGFibGVbeG5yXShyZWdzKTsKKwkJZWxzZQorCQkJcmVncy0+YXggPSB4
MzJfc3lzX2NhbGwocmVncywgeG5yKTsKIAkJcmV0dXJuIHRydWU7CiAJfQogCXJldHVybiBmYWxz
ZTsKQEAgLTE2Miw3ICsxNjgsMTAgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGRvX3N5
c2NhbGxfMzJfaXJxc19vbihzdHJ1Y3QgcHRfcmVncyAqcmVncywgaW50IG5yKQogCiAJaWYgKGxp
a2VseSh1bnIgPCBJQTMyX05SX3N5c2NhbGxzKSkgewogCQl1bnIgPSBhcnJheV9pbmRleF9ub3Nw
ZWModW5yLCBJQTMyX05SX3N5c2NhbGxzKTsKLQkJcmVncy0+YXggPSBpYTMyX3N5c19jYWxsKHJl
Z3MsIHVucik7CisJCWlmIChsaWtlbHkoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9J
TkRJUkVDVF9CUkFOQ0hfT0spKSkKKwkJCXJlZ3MtPmF4ID0gaWEzMl9zeXNfY2FsbF90YWJsZVt1
bnJdKHJlZ3MpOworCQllbHNlCisJCQlyZWdzLT5heCA9IGlhMzJfc3lzX2NhbGwocmVncywgdW5y
KTsKIAl9IGVsc2UgaWYgKG5yICE9IC0xKSB7CiAJCXJlZ3MtPmF4ID0gX19pYTMyX3N5c19uaV9z
eXNjYWxsKHJlZ3MpOwogCX0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxfMzIu
YyBiL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxfMzIuYwppbmRleCBjMjIzNWJhZTE3ZWY2Li5hYWIz
MTc2MGI0ZTNlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzMyLmMKKysrIGIv
YXJjaC94ODYvZW50cnkvc3lzY2FsbF8zMi5jCkBAIC0xNCwyNSArMTQsMTYgQEAKICNlbmRpZgog
CiAjZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBleHRlcm4gbG9uZyBfX2lhMzJfIyNzeW0oY29u
c3Qgc3RydWN0IHB0X3JlZ3MgKik7Ci0KICNpbmNsdWRlIDxhc20vc3lzY2FsbHNfMzIuaD4KICN1
bmRlZiBfX1NZU0NBTEwKIAotLyoKLSAqIFRoZSBzeXNfY2FsbF90YWJsZVtdIGlzIG5vIGxvbmdl
ciB1c2VkIGZvciBzeXN0ZW0gY2FsbHMsIGJ1dAotICoga2VybmVsL3RyYWNlL3RyYWNlX3N5c2Nh
bGxzLmMgc3RpbGwgd2FudHMgdG8ga25vdyB0aGUgc3lzdGVtCi0gKiBjYWxsIGFkZHJlc3MuCi0g
Ki8KLSNpZmRlZiBDT05GSUdfWDg2XzMyCiAjZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBfX2lh
MzJfIyNzeW0sCi1jb25zdCBzeXNfY2FsbF9wdHJfdCBzeXNfY2FsbF90YWJsZVtdID0geworY29u
c3Qgc3lzX2NhbGxfcHRyX3QgaWEzMl9zeXNfY2FsbF90YWJsZVtdID0gewogI2luY2x1ZGUgPGFz
bS9zeXNjYWxsc18zMi5oPgogfTsKICN1bmRlZiBfX1NZU0NBTEwKLSNlbmRpZgogCiAjZGVmaW5l
IF9fU1lTQ0FMTChuciwgc3ltKSBjYXNlIG5yOiByZXR1cm4gX19pYTMyXyMjc3ltKHJlZ3MpOwot
CiBsb25nIGlhMzJfc3lzX2NhbGwoY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVk
IGludCBucikKIHsKIAlzd2l0Y2ggKG5yKSB7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9z
eXNjYWxsXzY0LmMgYi9hcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmMKaW5kZXggMzNiM2YwOWU2
ZjE1MS4uZmYzNmE5OTNhMDdlMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvc3lzY2FsbF82
NC5jCisrKyBiL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYwpAQCAtOCwxNCArOCwxMyBAQAog
I2luY2x1ZGUgPGFzbS9zeXNjYWxsLmg+CiAKICNkZWZpbmUgX19TWVNDQUxMKG5yLCBzeW0pIGV4
dGVybiBsb25nIF9feDY0XyMjc3ltKGNvbnN0IHN0cnVjdCBwdF9yZWdzICopOworI2RlZmluZSBf
X1NZU0NBTExfTk9SRVRVUk4obnIsIHN5bSkgZXh0ZXJuIGxvbmcgX19ub3JldHVybiBfX3g2NF8j
I3N5bShjb25zdCBzdHJ1Y3QgcHRfcmVncyAqKTsKICNpbmNsdWRlIDxhc20vc3lzY2FsbHNfNjQu
aD4KICN1bmRlZiBfX1NZU0NBTEwKIAotLyoKLSAqIFRoZSBzeXNfY2FsbF90YWJsZVtdIGlzIG5v
IGxvbmdlciB1c2VkIGZvciBzeXN0ZW0gY2FsbHMsIGJ1dAotICoga2VybmVsL3RyYWNlL3RyYWNl
X3N5c2NhbGxzLmMgc3RpbGwgd2FudHMgdG8ga25vdyB0aGUgc3lzdGVtCi0gKiBjYWxsIGFkZHJl
c3MuCi0gKi8KKyN1bmRlZiBfX1NZU0NBTExfTk9SRVRVUk4KKyNkZWZpbmUgX19TWVNDQUxMX05P
UkVUVVJOIF9fU1lTQ0FMTAorCiAjZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBfX3g2NF8jI3N5
bSwKIGNvbnN0IHN5c19jYWxsX3B0cl90IHN5c19jYWxsX3RhYmxlW10gPSB7CiAjaW5jbHVkZSA8
YXNtL3N5c2NhbGxzXzY0Lmg+CkBAIC0yMyw3ICsyMiw2IEBAIGNvbnN0IHN5c19jYWxsX3B0cl90
IHN5c19jYWxsX3RhYmxlW10gPSB7CiAjdW5kZWYgX19TWVNDQUxMCiAKICNkZWZpbmUgX19TWVND
QUxMKG5yLCBzeW0pIGNhc2UgbnI6IHJldHVybiBfX3g2NF8jI3N5bShyZWdzKTsKLQogbG9uZyB4
NjRfc3lzX2NhbGwoY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGludCBucikK
IHsKIAlzd2l0Y2ggKG5yKSB7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9zeXNjYWxsX3gz
Mi5jIGIvYXJjaC94ODYvZW50cnkvc3lzY2FsbF94MzIuYwppbmRleCAwM2RlNGE5MzIxMzE4Li40
MjIxZWNjZTZlNjg5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS9zeXNjYWxsX3gzMi5jCisr
KyBiL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxfeDMyLmMKQEAgLTgsMTEgKzgsMjAgQEAKICNpbmNs
dWRlIDxhc20vc3lzY2FsbC5oPgogCiAjZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBleHRlcm4g
bG9uZyBfX3g2NF8jI3N5bShjb25zdCBzdHJ1Y3QgcHRfcmVncyAqKTsKKyNkZWZpbmUgX19TWVND
QUxMX05PUkVUVVJOKG5yLCBzeW0pIGV4dGVybiBsb25nIF9fbm9yZXR1cm4gX194NjRfIyNzeW0o
Y29uc3Qgc3RydWN0IHB0X3JlZ3MgKik7CiAjaW5jbHVkZSA8YXNtL3N5c2NhbGxzX3gzMi5oPgog
I3VuZGVmIF9fU1lTQ0FMTAogCi0jZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBjYXNlIG5yOiBy
ZXR1cm4gX194NjRfIyNzeW0ocmVncyk7CisjdW5kZWYgX19TWVNDQUxMX05PUkVUVVJOCisjZGVm
aW5lIF9fU1lTQ0FMTF9OT1JFVFVSTiBfX1NZU0NBTEwKKworI2RlZmluZSBfX1NZU0NBTEwobnIs
IHN5bSkgX194NjRfIyNzeW0sCitjb25zdCBzeXNfY2FsbF9wdHJfdCB4MzJfc3lzX2NhbGxfdGFi
bGVbXSA9IHsKKyNpbmNsdWRlIDxhc20vc3lzY2FsbHNfeDMyLmg+Cit9OworI3VuZGVmIF9fU1lT
Q0FMTAogCisjZGVmaW5lIF9fU1lTQ0FMTChuciwgc3ltKSBjYXNlIG5yOiByZXR1cm4gX194NjRf
IyNzeW0ocmVncyk7CiBsb25nIHgzMl9zeXNfY2FsbChjb25zdCBzdHJ1Y3QgcHRfcmVncyAqcmVn
cywgdW5zaWduZWQgaW50IG5yKQogewogCXN3aXRjaCAobnIpIHsKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsIGIvYXJjaC94ODYvZW50cnkvc3lzY2Fs
bHMvc3lzY2FsbF82NC50YmwKaW5kZXggYTM5NmY2ZTZhYjViZi4uN2VjNjhkOTRlYjU5MyAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvc3lzY2FsbHMvc3lzY2FsbF82NC50YmwKKysrIGIvYXJj
aC94ODYvZW50cnkvc3lzY2FsbHMvc3lzY2FsbF82NC50YmwKQEAgLTIsNyArMiw3IEBACiAjIDY0
LWJpdCBzeXN0ZW0gY2FsbCBudW1iZXJzIGFuZCBlbnRyeSB2ZWN0b3JzCiAjCiAjIFRoZSBmb3Jt
YXQgaXM6Ci0jIDxudW1iZXI+IDxhYmk+IDxuYW1lPiA8ZW50cnkgcG9pbnQ+CisjIDxudW1iZXI+
IDxhYmk+IDxuYW1lPiA8ZW50cnkgcG9pbnQ+IFswIG5vcmV0dXJuXQogIwogIyBUaGUgX194NjRf
c3lzXyooKSBzdHVicyBhcmUgY3JlYXRlZCBvbi10aGUtZmx5IGZvciBzeXNfKigpIHN5c3RlbSBj
YWxscwogIwpAQCAtNjgsNyArNjgsNyBAQAogNTcJY29tbW9uCWZvcmsJCQlzeXNfZm9yawogNTgJ
Y29tbW9uCXZmb3JrCQkJc3lzX3Zmb3JrCiA1OQk2NAlleGVjdmUJCQlzeXNfZXhlY3ZlCi02MAlj
b21tb24JZXhpdAkJCXN5c19leGl0Cis2MAljb21tb24JZXhpdAkJCXN5c19leGl0CQkwCW5vcmV0
dXJuCiA2MQljb21tb24Jd2FpdDQJCQlzeXNfd2FpdDQKIDYyCWNvbW1vbglraWxsCQkJc3lzX2tp
bGwKIDYzCWNvbW1vbgl1bmFtZQkJCXN5c19uZXd1bmFtZQpAQCAtMjM5LDcgKzIzOSw3IEBACiAy
MjgJY29tbW9uCWNsb2NrX2dldHRpbWUJCXN5c19jbG9ja19nZXR0aW1lCiAyMjkJY29tbW9uCWNs
b2NrX2dldHJlcwkJc3lzX2Nsb2NrX2dldHJlcwogMjMwCWNvbW1vbgljbG9ja19uYW5vc2xlZXAJ
CXN5c19jbG9ja19uYW5vc2xlZXAKLTIzMQljb21tb24JZXhpdF9ncm91cAkJc3lzX2V4aXRfZ3Jv
dXAKKzIzMQljb21tb24JZXhpdF9ncm91cAkJc3lzX2V4aXRfZ3JvdXAJCTAJbm9yZXR1cm4KIDIz
Mgljb21tb24JZXBvbGxfd2FpdAkJc3lzX2Vwb2xsX3dhaXQKIDIzMwljb21tb24JZXBvbGxfY3Rs
CQlzeXNfZXBvbGxfY3RsCiAyMzQJY29tbW9uCXRna2lsbAkJCXN5c190Z2tpbGwKZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9jcHVmZWF0dXJlcy5oCmluZGV4IDNjNzQzNDMyOTY2MWMuLmQ2NGIwYTUyOTFmMTAgMTAw
NjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgKKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaApAQCAtNDcwLDYgKzQ3MCw3IEBACiAjZGVmaW5l
IFg4Nl9GRUFUVVJFX0JISV9DVFJMCQkoMjEqMzIrIDIpIC8qICIiIEJISV9ESVNfUyBIVyBjb250
cm9sIGF2YWlsYWJsZSAqLwogI2RlZmluZSBYODZfRkVBVFVSRV9DTEVBUl9CSEJfSFcJKDIxKjMy
KyAzKSAvKiAiIiBCSElfRElTX1MgSFcgY29udHJvbCBlbmFibGVkICovCiAjZGVmaW5lIFg4Nl9G
RUFUVVJFX0NMRUFSX0JIQl9MT09QX09OX1ZNRVhJVCAoMjEqMzIrIDQpIC8qICIiIENsZWFyIGJy
YW5jaCBoaXN0b3J5IGF0IHZtZXhpdCB1c2luZyBTVyBsb29wICovCisjZGVmaW5lIFg4Nl9GRUFU
VVJFX0lORElSRUNUX0JSQU5DSF9PSwkoMjEqMzIrIDUpIC8qICIiIEl0J3MgT0sgdG8gdXNlIGlu
ZGlyZWN0IGJyYW5jaGVzICovCiAKIC8qCiAgKiBCVUcgd29yZChzKQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vc3lzY2FsbC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc3lzY2Fs
bC5oCmluZGV4IDJmYzdiYzM4NjNmZjYuLmRmYjU5NTIxMjQ0YzIgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3N5c2NhbGwuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zeXNj
YWxsLmgKQEAgLTE2LDE0ICsxNiwyMCBAQAogI2luY2x1ZGUgPGFzbS90aHJlYWRfaW5mby5oPgkv
KiBmb3IgVFNfQ09NUEFUICovCiAjaW5jbHVkZSA8YXNtL3VuaXN0ZC5oPgogCi0vKiBUaGlzIGlz
IHVzZWQgcHVyZWx5IGZvciBrZXJuZWwvdHJhY2UvdHJhY2Vfc3lzY2FsbHMuYyAqLwogdHlwZWRl
ZiBsb25nICgqc3lzX2NhbGxfcHRyX3QpKGNvbnN0IHN0cnVjdCBwdF9yZWdzICopOwogZXh0ZXJu
IGNvbnN0IHN5c19jYWxsX3B0cl90IHN5c19jYWxsX3RhYmxlW107CiAKKyNpZiBkZWZpbmVkKENP
TkZJR19YODZfMzIpCisjZGVmaW5lIGlhMzJfc3lzX2NhbGxfdGFibGUgc3lzX2NhbGxfdGFibGUK
KyNlbHNlCiAvKgogICogVGhlc2UgbWF5IG5vdCBleGlzdCwgYnV0IHN0aWxsIHB1dCB0aGUgcHJv
dG90eXBlcyBpbiBzbyB3ZQogICogY2FuIHVzZSBJU19FTkFCTEVEKCkuCiAgKi8KK2V4dGVybiBj
b25zdCBzeXNfY2FsbF9wdHJfdCBpYTMyX3N5c19jYWxsX3RhYmxlW107CitleHRlcm4gY29uc3Qg
c3lzX2NhbGxfcHRyX3QgeDMyX3N5c19jYWxsX3RhYmxlW107CisjZW5kaWYKKwogZXh0ZXJuIGxv
bmcgaWEzMl9zeXNfY2FsbChjb25zdCBzdHJ1Y3QgcHRfcmVncyAqLCB1bnNpZ25lZCBpbnQgbnIp
OwogZXh0ZXJuIGxvbmcgeDMyX3N5c19jYWxsKGNvbnN0IHN0cnVjdCBwdF9yZWdzICosIHVuc2ln
bmVkIGludCBucik7CiBleHRlcm4gbG9uZyB4NjRfc3lzX2NhbGwoY29uc3Qgc3RydWN0IHB0X3Jl
Z3MgKiwgdW5zaWduZWQgaW50IG5yKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
YnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMKaW5kZXggYWIxODE4NTg5NGRmZC4u
NWZjYTQ2Yzc4ZGFmMiAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMKKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMKQEAgLTE2NjUsNiArMTY2NSwxMiBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgYmhpX3NlbGVjdF9taXRpZ2F0aW9uKHZvaWQpCiAJaWYgKCFJU19FTkFC
TEVEKENPTkZJR19YODZfNjQpKQogCQlyZXR1cm47CiAKKwkvKgorCSAqIFRoZXJlJ3Mgbm8gSFcg
bWl0aWdhdGlvbiBpbiBwbGFjZS4gIE1hcmsgaW5kaXJlY3QgYnJhbmNoZXMgYXMKKwkgKiAibm90
IE9LIi4KKwkgKi8KKwlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0lORElSRUNUX0JS
QU5DSF9PSyk7CisKIAkvKiBNaXRpZ2F0ZSBLVk0gYnkgZGVmYXVsdCAqLwogCXNldHVwX2ZvcmNl
X2NwdV9jYXAoWDg2X0ZFQVRVUkVfQ0xFQVJfQkhCX0xPT1BfT05fVk1FWElUKTsKIAlwcl9pbmZv
KCJTcGVjdHJlIEJISSBtaXRpZ2F0aW9uOiBTVyBCSEIgY2xlYXJpbmcgb24gdm0gZXhpdFxuIik7
CkBAIC0xNjc5LDYgKzE2ODUsMjggQEAgc3RhdGljIHZvaWQgX19pbml0IHNwZWN0cmVfdjJfc2Vs
ZWN0X21pdGlnYXRpb24odm9pZCkKIAllbnVtIHNwZWN0cmVfdjJfbWl0aWdhdGlvbl9jbWQgY21k
ID0gc3BlY3RyZV92Ml9wYXJzZV9jbWRsaW5lKCk7CiAJZW51bSBzcGVjdHJlX3YyX21pdGlnYXRp
b24gbW9kZSA9IFNQRUNUUkVfVjJfTk9ORTsKIAorCS8qCisJICogWDg2X0ZFQVRVUkVfSU5ESVJF
Q1RfQlJBTkNIX09LIGluZGljYXRlcyB0aGF0IGluZGlyZWN0IGNhbGxzIGFyZQorCSAqICJPSyIg
dG8gdXNlIGR1ZSB0byAoYXQgbGVhc3QpIG9uZSBvZiB0aGUgZm9sbG93aW5nIGJlaW5nIHRydWU6
CisJICoKKwkgKiAgIC0gdGhlIENQVSBpc24ndCB2dWxuZXJhYmxlIHRvIFNwZWN0cmUgdjIsIEJI
SSwgZXRjOworCSAqCisJICogICAtIGEgSFcgbWl0aWdhdGlvbiBpcyBpbiBwbGFjZSAoZS5nLiwg
SUJSUywgZUlCUlMrQkhJX0RJU19TKTsgb3IKKwkgKgorCSAqICAgLSB0aGUgdXNlciBkaXNhYmxl
ZCBtaXRpZ2F0aW9ucy4KKwkgKgorCSAqIENsZWFyaW5nIHRoZSBiaXQgZW5hYmxlcyBjZXJ0YWlu
IGluZGlyZWN0IGJyYW5jaCAiZWFzeSB0YXJnZXRzIiBbKl0KKwkgKiB0byBiZSBjb252ZXJ0ZWQg
dG8gYSBzZXJpZXMgb2YgZGlyZWN0IGJyYW5jaGVzLgorCSAqCisJICogQXNzdW1lIGlubm9jZW5j
ZSB1bnRpbCBwcm92ZW4gZ3VpbHR5OiBzZXQgaXQgbm93IGFuZCBjbGVhciBpdCBsYXRlcgorCSAq
IGlmL3doZW4gbmVlZGVkLgorCSAqCisJICogWypdIFRoZSBjbG9zZXIgdGhlIGluZGlyZWN0IGJy
YW5jaCBpcyB0byBrZXJuZWwgZW50cnksIGFuZCB0aGUgbW9yZQorCSAqICAgICB1c2VyLWNvbnRy
b2xsZWQgcmVnaXN0ZXJzIHRoZXJlIGFyZSwgdGhlIGVhc2llciB0YXJnZXQgaXQgbWF5IGJlCisJ
ICogICAgIGZvciBmdXR1cmUgU3BlY3RyZSB2MiB2YXJpYW50cy4KKwkgKi8KKwlzZXR1cF9mb3Jj
ZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX0lORElSRUNUX0JSQU5DSF9PSyk7CisKIAkvKgogCSAqIElm
IHRoZSBDUFUgaXMgbm90IGFmZmVjdGVkIGFuZCB0aGUgY29tbWFuZCBsaW5lIG1vZGUgaXMgTk9O
RSBvciBBVVRPCiAJICogdGhlbiBub3RoaW5nIHRvIGRvLgpAQCAtMTc2NSwxMSArMTc5MywxNiBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgc3BlY3RyZV92Ml9zZWxlY3RfbWl0aWdhdGlvbih2b2lkKQog
CQlicmVhazsKIAogCWNhc2UgU1BFQ1RSRV9WMl9MRkVOQ0U6CisJCXNldHVwX2NsZWFyX2NwdV9j
YXAoWDg2X0ZFQVRVUkVfSU5ESVJFQ1RfQlJBTkNIX09LKTsKKwkJZmFsbHRocm91Z2g7CiAJY2Fz
ZSBTUEVDVFJFX1YyX0VJQlJTX0xGRU5DRToKIAkJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVB
VFVSRV9SRVRQT0xJTkVfTEZFTkNFKTsKLQkJZmFsbHRocm91Z2g7CisJCXNldHVwX2ZvcmNlX2Nw
dV9jYXAoWDg2X0ZFQVRVUkVfUkVUUE9MSU5FKTsKKwkJYnJlYWs7CiAKIAljYXNlIFNQRUNUUkVf
VjJfUkVUUE9MSU5FOgorCQlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0lORElSRUNU
X0JSQU5DSF9PSyk7CisJCWZhbGx0aHJvdWdoOwogCWNhc2UgU1BFQ1RSRV9WMl9FSUJSU19SRVRQ
T0xJTkU6CiAJCXNldHVwX2ZvcmNlX2NwdV9jYXAoWDg2X0ZFQVRVUkVfUkVUUE9MSU5FKTsKIAkJ
YnJlYWs7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni91bS9zeXNfY2FsbF90YWJsZV8zMi5jIGIvYXJj
aC94ODYvdW0vc3lzX2NhbGxfdGFibGVfMzIuYwppbmRleCA4OWRmNWQ4OWQ2NjQwLi5jN2Q0YmY5
NTVkMmJhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni91bS9zeXNfY2FsbF90YWJsZV8zMi5jCisrKyBi
L2FyY2gveDg2L3VtL3N5c19jYWxsX3RhYmxlXzMyLmMKQEAgLTI0LDYgKzI0LDcgQEAKICNkZWZp
bmUgX19TWVNDQUxMX1dJVEhfQ09NUEFUKG5yLCBuYXRpdmUsIGNvbXBhdCkJX19TWVNDQUxMKG5y
LCBuYXRpdmUpCiAKICNkZWZpbmUgX19TWVNDQUxMKG5yLCBzeW0pIGV4dGVybiBhc21saW5rYWdl
IGxvbmcgc3ltKHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVu
c2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcpOworI2RlZmluZSBfX1NZ
U0NBTExfTk9SRVRVUk4gX19TWVNDQUxMCiAjaW5jbHVkZSA8YXNtL3N5c2NhbGxzXzMyLmg+CiAK
ICN1bmRlZiBfX1NZU0NBTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L3VtL3N5c19jYWxsX3RhYmxl
XzY0LmMgYi9hcmNoL3g4Ni91bS9zeXNfY2FsbF90YWJsZV82NC5jCmluZGV4IGIwYjRjZmQyMzA4
YzguLjQ3NjBjNDBhZTVjZDAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3VtL3N5c19jYWxsX3RhYmxl
XzY0LmMKKysrIGIvYXJjaC94ODYvdW0vc3lzX2NhbGxfdGFibGVfNjQuYwpAQCAtMTksNiArMTks
NyBAQAogI2RlZmluZSBzeXNfaW9wZXJtIHN5c19uaV9zeXNjYWxsCiAKICNkZWZpbmUgX19TWVND
QUxMKG5yLCBzeW0pIGV4dGVybiBhc21saW5rYWdlIGxvbmcgc3ltKHVuc2lnbmVkIGxvbmcsIHVu
c2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcs
IHVuc2lnbmVkIGxvbmcpOworI2RlZmluZSBfX1NZU0NBTExfTk9SRVRVUk4gX19TWVNDQUxMCiAj
aW5jbHVkZSA8YXNtL3N5c2NhbGxzXzY0Lmg+CiAKICN1bmRlZiBfX1NZU0NBTEwKZGlmZiAtLWdp
dCBhL3NjcmlwdHMvc3lzY2FsbHRibC5zaCBiL3NjcmlwdHMvc3lzY2FsbHRibC5zaAppbmRleCA2
YWJlMTQzODg5ZWY2Li4xNjQ4N2Q0N2UwNmEzIDEwMDc1NQotLS0gYS9zY3JpcHRzL3N5c2NhbGx0
Ymwuc2gKKysrIGIvc2NyaXB0cy9zeXNjYWxsdGJsLnNoCkBAIC01NCw3ICs1NCw3IEBAIG54dD0w
CiAKIGdyZXAgLUUgIl5bMC05XStbWzpzcGFjZTpdXSskYWJpcyIgIiRpbmZpbGUiIHwgewogCi0J
d2hpbGUgcmVhZCBuciBhYmkgbmFtZSBuYXRpdmUgY29tcGF0IDsgZG8KKwl3aGlsZSByZWFkIG5y
IGFiaSBuYW1lIG5hdGl2ZSBjb21wYXQgbm9yZXR1cm47IGRvCiAKIAkJaWYgWyAkbnh0IC1ndCAk
bnIgXTsgdGhlbgogCQkJZWNobyAiZXJyb3I6ICRpbmZpbGU6IHN5c2NhbGwgdGFibGUgaXMgbm90
IHNvcnRlZCBvciBkdXBsaWNhdGVzIHRoZSBzYW1lIHN5c2NhbGwgbnVtYmVyIiA+JjIKQEAgLTY2
LDcgKzY2LDkgQEAgZ3JlcCAtRSAiXlswLTldK1tbOnNwYWNlOl1dKyRhYmlzIiAiJGluZmlsZSIg
fCB7CiAJCQlueHQ9JCgobnh0ICsgMSkpCiAJCWRvbmUKIAotCQlpZiBbIC1uICIkY29tcGF0IiBd
OyB0aGVuCisJCWlmIFsgLW4gIiRub3JldHVybiIgXTsgdGhlbgorCQkJZWNobyAiX19TWVNDQUxM
X05PUkVUVVJOKCRuciwgJG5hdGl2ZSkiCisJCWVsaWYgWyAtbiAiJGNvbXBhdCIgXTsgdGhlbgog
CQkJZWNobyAiX19TWVNDQUxMX1dJVEhfQ09NUEFUKCRuciwgJG5hdGl2ZSwgJGNvbXBhdCkiCiAJ
CWVsaWYgWyAtbiAiJG5hdGl2ZSIgXTsgdGhlbgogCQkJZWNobyAiX19TWVNDQUxMKCRuciwgJG5h
dGl2ZSkiCmRpZmYgLS1naXQgYS90b29scy9vYmp0b29sL25vcmV0dXJucy5oIGIvdG9vbHMvb2Jq
dG9vbC9ub3JldHVybnMuaAppbmRleCA3ZWJmMjljOTExODQ5Li4xZTgxNDFlZjFiMTVkIDEwMDY0
NAotLS0gYS90b29scy9vYmp0b29sL25vcmV0dXJucy5oCisrKyBiL3Rvb2xzL29ianRvb2wvbm9y
ZXR1cm5zLmgKQEAgLTcsMTIgKzcsMTYgQEAKICAqIFllcywgdGhpcyBpcyB1bmZvcnR1bmF0ZS4g
IEEgYmV0dGVyIHNvbHV0aW9uIGlzIGluIHRoZSB3b3Jrcy4KICAqLwogTk9SRVRVUk4oX19mb3J0
aWZ5X3BhbmljKQorTk9SRVRVUk4oX19pYTMyX3N5c19leGl0KQorTk9SRVRVUk4oX19pYTMyX3N5
c19leGl0X2dyb3VwKQogTk9SRVRVUk4oX19rdW5pdF9hYm9ydCkKIE5PUkVUVVJOKF9fbW9kdWxl
X3B1dF9hbmRfa3RocmVhZF9leGl0KQogTk9SRVRVUk4oX19yZWlzZXJmc19wYW5pYykKIE5PUkVU
VVJOKF9fc3RhY2tfY2hrX2ZhaWwpCiBOT1JFVFVSTihfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKQog
Tk9SRVRVUk4oX191YnNhbl9oYW5kbGVfYnVpbHRpbl91bnJlYWNoYWJsZSkKK05PUkVUVVJOKF9f
eDY0X3N5c19leGl0KQorTk9SRVRVUk4oX194NjRfc3lzX2V4aXRfZ3JvdXApCiBOT1JFVFVSTihh
cmNoX2NwdV9pZGxlX2RlYWQpCiBOT1JFVFVSTihiY2gyX3RyYW5zX2luX3Jlc3RhcnRfZXJyb3Ip
CiBOT1JFVFVSTihiY2gyX3RyYW5zX3Jlc3RhcnRfZXJyb3IpCg==
--0000000000009d80140616a24482--

