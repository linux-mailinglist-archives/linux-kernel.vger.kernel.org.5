Return-Path: <linux-kernel+bounces-12312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB781F346
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F5028252E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72B38C;
	Thu, 28 Dec 2023 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dnzJmLie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCD160
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BRNoZcL858559
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 27 Dec 2023 15:50:35 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BRNoZcL858559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1703721036;
	bh=xoySbFg4cib1NCEl/lEeSxfsizd5Cmz69MoRK5o8XPc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dnzJmLieJiYGlPCm0ZETLbyPUDhQ8p6gP2pKxpTAUX96q5x+/lkUFxGo4HrXnTKZu
	 CXisl+jgWKcjL/kxtqJst4hzyfWJubtK9I21LTgizDwTBL/BaoASqxPl72o8R99f3W
	 SN3l8BjdwKxG1j7AfShN2gqgrFzzSdMVgYtJ04hWnmNVBgKDILSahlbhJ2KGPbtI+U
	 FPzLS7iCxnxKkgNXsg2XH8TkEQVW2Su7NCKjxAbjWFpub/lcNcpnIccTNKSiJp7722
	 le2ENsnb5P0GKdfHpKJqFdefDXNsbjYJOaj/xGp3O6Y/yssXW58ZR3hPEkJ5LOW9Nx
	 AMx9y9zUmfmyQ==
Date: Wed, 27 Dec 2023 15:50:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
User-Agent: K-9 Mail for Android
In-Reply-To: <20231227233444.GH1674809@ZenIV>
References: <20231227-syscall32-v1-1-9621140d33bd@google.com> <20231227233444.GH1674809@ZenIV>
Message-ID: <8B198413-0C9B-40A2-8478-F22206AAE6FA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 27, 2023 3:34:44 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk=
> wrote:
>On Wed, Dec 27, 2023 at 10:38:41PM +0000, Tanzir Hasan wrote:
>> This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
>> the include list, changing indirect includes to direct includes=2E IWYU=
 is
>> implemented using the IWYUScripts github repository which is a tool tha=
t
>> is currently undergoing development=2E These changes seek to improve bu=
ild
>> times=2E
>>=20
>> This change to entry/syscall_32=2Ec resulted in a preprocessed size of
>> entry/syscall_32=2Ei from 64002 lines to 47986 lines (-25%) for the x86
>> defconfig=2E
>>
>> Signed-off-by: Tanzir Hasan <tanzirh@google=2Ecom>
>> ---
>>  arch/x86/entry/syscall_32=2Ec | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/entry/syscall_32=2Ec b/arch/x86/entry/syscall_32=
=2Ec
>> index 8cfc9bc73e7f=2E=2E66db11fe8a1c 100644
>> --- a/arch/x86/entry/syscall_32=2Ec
>> +++ b/arch/x86/entry/syscall_32=2Ec
>> @@ -4,7 +4,7 @@
>>  #include <linux/linkage=2Eh>
>>  #include <linux/sys=2Eh>
>>  #include <linux/cache=2Eh>
>> -#include <linux/syscalls=2Eh>
>> +#include <linux/ptrace=2Eh>
>>  #include <asm/syscall=2Eh>
>
>Really?  What do we need linux/ptrace=2Eh for?  Because if it's
>struct pt_regs for the generated externs, we might as well have
>just said
>struct pt_regs;
>and that would be it=2E
>
><digs around a bit>
>
>As the matter of fact, all you need out of those includes is this:
>
>struct pt_regs;
>typedef long (*sys_call_ptr_t)(const struct pt_regs *);
>extern const sys_call_ptr_t sys_call_table[];
>#if defined(CONFIG_X86_32)
>#define ia32_sys_call_table sys_call_table
>#else
>/*
> * These may not exist, but still put the prototypes in so we
> * can use IS_ENABLED()=2E
> */
>extern const sys_call_ptr_t ia32_sys_call_table[];
>extern const sys_call_ptr_t x32_sys_call_table[];
>#endif
>
>That's _it_=2E  The same goes for syscall_64=2Ec and syscall_x32=2Ec=2E
>Oh, and lose the __visible/asmlinkage junk in there - none of that
>stuff is used from asm these days=2E  See the patch below -
>Untested But Should Work(tm):
>
>diff --git a/arch/x86/entry/common=2Ec b/arch/x86/entry/common=2Ec
>index d813160b14d8=2E=2E5c470806dd08 100644
>--- a/arch/x86/entry/common=2Ec
>+++ b/arch/x86/entry/common=2Ec
>@@ -36,6 +36,8 @@
> #include <asm/syscall=2Eh>
> #include <asm/irq_stack=2Eh>
>=20
>+#include "syscall=2Eh"
>+
> #ifdef CONFIG_X86_64
>=20
> static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>diff --git a/arch/x86/entry/syscall=2Eh b/arch/x86/entry/syscall=2Eh
>new file mode 100644
>index 000000000000=2E=2E7c52df000ae0
>--- /dev/null
>+++ b/arch/x86/entry/syscall=2Eh
>@@ -0,0 +1,13 @@
>+struct pt_regs;
>+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
>+extern const sys_call_ptr_t sys_call_table[];
>+#if defined(CONFIG_X86_32)
>+#define ia32_sys_call_table sys_call_table
>+#else
>+/*
>+ * These may not exist, but still put the prototypes in so we
>+ * can use IS_ENABLED()=2E
>+ */
>+extern const sys_call_ptr_t ia32_sys_call_table[];
>+extern const sys_call_ptr_t x32_sys_call_table[];
>+#endif
>diff --git a/arch/x86/entry/syscall_32=2Ec b/arch/x86/entry/syscall_32=2E=
c
>index 8cfc9bc73e7f=2E=2Ea24a8922692f 100644
>--- a/arch/x86/entry/syscall_32=2Ec
>+++ b/arch/x86/entry/syscall_32=2Ec
>@@ -1,11 +1,7 @@
> // SPDX-License-Identifier: GPL-2=2E0
> /* System call table for i386=2E */
>=20
>-#include <linux/linkage=2Eh>
>-#include <linux/sys=2Eh>
>-#include <linux/cache=2Eh>
>-#include <linux/syscalls=2Eh>
>-#include <asm/syscall=2Eh>
>+#include "syscall=2Eh"
>=20
> #ifdef CONFIG_IA32_EMULATION
> #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
>@@ -20,6 +16,6 @@
>=20
> #define __SYSCALL(nr, sym) __ia32_##sym,
>=20
>-__visible const sys_call_ptr_t ia32_sys_call_table[] =3D {
>+const sys_call_ptr_t ia32_sys_call_table[] =3D {
> #include <asm/syscalls_32=2Eh>
> };
>diff --git a/arch/x86/entry/syscall_64=2Ec b/arch/x86/entry/syscall_64=2E=
c
>index be120eec1fc9=2E=2E81bde061037b 100644
>--- a/arch/x86/entry/syscall_64=2Ec
>+++ b/arch/x86/entry/syscall_64=2Ec
>@@ -1,11 +1,7 @@
> // SPDX-License-Identifier: GPL-2=2E0
> /* System call table for x86-64=2E */
>=20
>-#include <linux/linkage=2Eh>
>-#include <linux/sys=2Eh>
>-#include <linux/cache=2Eh>
>-#include <linux/syscalls=2Eh>
>-#include <asm/syscall=2Eh>
>+#include "syscall=2Eh"
>=20
> #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs =
*);
> #include <asm/syscalls_64=2Eh>
>@@ -13,6 +9,6 @@
>=20
> #define __SYSCALL(nr, sym) __x64_##sym,
>=20
>-asmlinkage const sys_call_ptr_t sys_call_table[] =3D {
>+const sys_call_ptr_t sys_call_table[] =3D {
> #include <asm/syscalls_64=2Eh>
> };
>diff --git a/arch/x86/entry/syscall_x32=2Ec b/arch/x86/entry/syscall_x32=
=2Ec
>index bdd0e03a1265=2E=2E7b5170a99b9a 100644
>--- a/arch/x86/entry/syscall_x32=2Ec
>+++ b/arch/x86/entry/syscall_x32=2Ec
>@@ -1,11 +1,7 @@
> // SPDX-License-Identifier: GPL-2=2E0
> /* System call table for x32 ABI=2E */
>=20
>-#include <linux/linkage=2Eh>
>-#include <linux/sys=2Eh>
>-#include <linux/cache=2Eh>
>-#include <linux/syscalls=2Eh>
>-#include <asm/syscall=2Eh>
>+#include "syscall=2Eh"
>=20
> #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs =
*);
> #include <asm/syscalls_x32=2Eh>
>@@ -13,6 +9,6 @@
>=20
> #define __SYSCALL(nr, sym) __x64_##sym,
>=20
>-asmlinkage const sys_call_ptr_t x32_sys_call_table[] =3D {
>+const sys_call_ptr_t x32_sys_call_table[] =3D {
> #include <asm/syscalls_x32=2Eh>
> };
>diff --git a/arch/x86/include/asm/syscall=2Eh b/arch/x86/include/asm/sysc=
all=2Eh
>index f44e2f9ab65d=2E=2Ef301919b9187 100644
>--- a/arch/x86/include/asm/syscall=2Eh
>+++ b/arch/x86/include/asm/syscall=2Eh
>@@ -16,20 +16,6 @@
> #include <asm/thread_info=2Eh>	/* for TS_COMPAT */
> #include <asm/unistd=2Eh>
>=20
>-typedef long (*sys_call_ptr_t)(const struct pt_regs *);
>-extern const sys_call_ptr_t sys_call_table[];
>-
>-#if defined(CONFIG_X86_32)
>-#define ia32_sys_call_table sys_call_table
>-#else
>-/*
>- * These may not exist, but still put the prototypes in so we
>- * can use IS_ENABLED()=2E
>- */
>-extern const sys_call_ptr_t ia32_sys_call_table[];
>-extern const sys_call_ptr_t x32_sys_call_table[];
>-#endif
>-
> /*
>  * Only the low 32 bits of orig_ax are meaningful, so we return int=2E
>  * This importantly ignores the high bits on 64-bit, so comparisons

__visible is for LTO, no?

