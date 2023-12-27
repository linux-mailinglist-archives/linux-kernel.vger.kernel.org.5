Return-Path: <linux-kernel+bounces-12309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3781F30A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5095E1C2266F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC3498B1;
	Wed, 27 Dec 2023 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N/lB4t3D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F8498A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P/2xlLk/rkxOjS/FUbmY9OBM2TAcAbIfDH0oLalnqbs=; b=N/lB4t3DzWifLOissbAn3MCKby
	ZhVTvZwh7sualHCiikumlSmpzF8ly91xU+pQQf96wvcviLFKE2O+d8yo//VoPG0sRbzaUFTuOj0V8
	f6wwox0teBA0BpHTzWDznzZXoOScevnj2RwfWMqaRsIw4FMJmuc8czWVcnWVbjaaa2u16iy3WxRvV
	cz4pzG/U2q4xtznJRpB8GLlN5L94+tq29CFYqLRMH6p3BYq8Hc/9D0uTivjjANI6VJGICnSdsU1/p
	rJUMIUb+Q5Y0sEG7T+q9izY9Oian6JJi77g5ZWfjsHb3T46+qY1kAjY2XuTNfFRW6IHqwUZEum2Pa
	54x2LuMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIdQC-00Bm9I-1P;
	Wed, 27 Dec 2023 23:34:44 +0000
Date: Wed, 27 Dec 2023 23:34:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
Message-ID: <20231227233444.GH1674809@ZenIV>
References: <20231227-syscall32-v1-1-9621140d33bd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-syscall32-v1-1-9621140d33bd@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 27, 2023 at 10:38:41PM +0000, Tanzir Hasan wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
> 
> This change to entry/syscall_32.c resulted in a preprocessed size of
> entry/syscall_32.i from 64002 lines to 47986 lines (-25%) for the x86
> defconfig.
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  arch/x86/entry/syscall_32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 8cfc9bc73e7f..66db11fe8a1c 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -4,7 +4,7 @@
>  #include <linux/linkage.h>
>  #include <linux/sys.h>
>  #include <linux/cache.h>
> -#include <linux/syscalls.h>
> +#include <linux/ptrace.h>
>  #include <asm/syscall.h>

Really?  What do we need linux/ptrace.h for?  Because if it's
struct pt_regs for the generated externs, we might as well have
just said
struct pt_regs;
and that would be it.

<digs around a bit>

As the matter of fact, all you need out of those includes is this:

struct pt_regs;
typedef long (*sys_call_ptr_t)(const struct pt_regs *);
extern const sys_call_ptr_t sys_call_table[];
#if defined(CONFIG_X86_32)
#define ia32_sys_call_table sys_call_table
#else
/*
 * These may not exist, but still put the prototypes in so we
 * can use IS_ENABLED().
 */
extern const sys_call_ptr_t ia32_sys_call_table[];
extern const sys_call_ptr_t x32_sys_call_table[];
#endif

That's _it_.  The same goes for syscall_64.c and syscall_x32.c.
Oh, and lose the __visible/asmlinkage junk in there - none of that
stuff is used from asm these days.  See the patch below -
Untested But Should Work(tm):

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d813160b14d8..5c470806dd08 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,6 +36,8 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
+#include "syscall.h"
+
 #ifdef CONFIG_X86_64
 
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
diff --git a/arch/x86/entry/syscall.h b/arch/x86/entry/syscall.h
new file mode 100644
index 000000000000..7c52df000ae0
--- /dev/null
+++ b/arch/x86/entry/syscall.h
@@ -0,0 +1,13 @@
+struct pt_regs;
+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
+extern const sys_call_ptr_t sys_call_table[];
+#if defined(CONFIG_X86_32)
+#define ia32_sys_call_table sys_call_table
+#else
+/*
+ * These may not exist, but still put the prototypes in so we
+ * can use IS_ENABLED().
+ */
+extern const sys_call_ptr_t ia32_sys_call_table[];
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cfc9bc73e7f..a24a8922692f 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* System call table for i386. */
 
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
+#include "syscall.h"
 
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
@@ -20,6 +16,6 @@
 
 #define __SYSCALL(nr, sym) __ia32_##sym,
 
-__visible const sys_call_ptr_t ia32_sys_call_table[] = {
+const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index be120eec1fc9..81bde061037b 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* System call table for x86-64. */
 
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
+#include "syscall.h"
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
@@ -13,6 +9,6 @@
 
 #define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t sys_call_table[] = {
+const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index bdd0e03a1265..7b5170a99b9a 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* System call table for x32 ABI. */
 
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
+#include "syscall.h"
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
@@ -13,6 +9,6 @@
 
 #define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
+const sys_call_ptr_t x32_sys_call_table[] = {
 #include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f44e2f9ab65d..f301919b9187 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,20 +16,6 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-typedef long (*sys_call_ptr_t)(const struct pt_regs *);
-extern const sys_call_ptr_t sys_call_table[];
-
-#if defined(CONFIG_X86_32)
-#define ia32_sys_call_table sys_call_table
-#else
-/*
- * These may not exist, but still put the prototypes in so we
- * can use IS_ENABLED().
- */
-extern const sys_call_ptr_t ia32_sys_call_table[];
-extern const sys_call_ptr_t x32_sys_call_table[];
-#endif
-
 /*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons

