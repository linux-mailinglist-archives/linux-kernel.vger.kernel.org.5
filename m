Return-Path: <linux-kernel+bounces-168415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA98BB84E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807E91C213F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE784A51;
	Fri,  3 May 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZss8cj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62A290F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779181; cv=none; b=V14d857ayHO+zq3TIZIAeb6zQQOQqSIj0UTfUXwkEjoo65gclIStbI59w4Ek4ZzAjRBfLuWmO3tSji4sP+KhgsPugAsQN/NhMPLP8XWJvFMy7zGDaBu1H8WS6Mus+sXuY2xeL3hoP06AesiSRhUdTzeYKEC0l4yZWMjOi9M3uxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779181; c=relaxed/simple;
	bh=x8LZJZ7jb1i2Txy3QmdM8XXkwYbt0Z6rxMeu6n1bMnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9GL42LlzqOC3pgozqyDBd5z3nj2CCbcEJd85u9VXUpDJUcVRVZ3sK26IC35BNLwMBgJ+WQvr7KAKvLf05vgRUuiU1jlbO2Z13vxcqTc/3gEc3U5FimIqq7uHEuxty5h/V/JceY7T0WgAv5riycnadQUYAxGJOccRM3LTlNdeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZss8cj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD1C116B1;
	Fri,  3 May 2024 23:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714779181;
	bh=x8LZJZ7jb1i2Txy3QmdM8XXkwYbt0Z6rxMeu6n1bMnw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SZss8cj9Mth2EF4uVp0EVTRJzsXPyDHRpiAYfPge5Ot0bLsaRQP4rQhWta4wkwma+
	 xx8pyQg0A9PDBSoCb+gTdAW0ztRIsEPp7Htns0UYYoG26+c078nM5ea6cPPfwaBWJs
	 Up20pj8csDZmGWtX/q48rj96f1amoODWnoEyW2rntrNDZf76m0BW+fAbGfgltUrZV7
	 UiKGLMz3zI9CphAwcqz5gueoZmUlF6ldpsSYIMY3+xxVJzbaw0z0M6aOuBRWe7VL3T
	 C8t/psnTrgojZ8d5iqqOessmMQbrtT9luQzlR1EA80ZudxsotJ1Fz4/mS5PztupDCw
	 aZfk4LP+QZjkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BCE88CE0DEC; Fri,  3 May 2024 16:33:00 -0700 (PDT)
Date: Fri, 3 May 2024 16:33:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <a8d0a893-25ec-4119-abb5-c65adda51b49@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
 <20240503195653.5wkdfwno7nybepqc@treble>
 <20240503204417.2kxp2i3xjdmtapxq@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503204417.2kxp2i3xjdmtapxq@treble>

On Fri, May 03, 2024 at 01:44:17PM -0700, Josh Poimboeuf wrote:
> On Fri, May 03, 2024 at 12:57:00PM -0700, Josh Poimboeuf wrote:
> > On Thu, May 02, 2024 at 04:48:13PM -0700, Paul McKenney wrote:
> > > On Sun, Apr 21, 2024 at 2:47 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> > > >
> > > > And this definitely helped, thank you!
> > > >
> > > > However, this one still remains:
> > > >
> > > > vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
> > > > __ia32_sys_exit_group() is missing a __noreturn annotation
> > > 
> > > And looking at the patched code, this function looks to me to be
> > > correctly marked.
> > > 
> > > No idea...  :-/
> > 
> > Ah, I think I missed fixing syscall_32.tbl.  Lemme see how to do that...
> 
> Can you try adding this on top?
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 5f8591ce7f25..f30b608d14dc 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -12,7 +12,7 @@
>  # The abi is always "i386" for this file.
>  #
>  0	i386	restart_syscall		sys_restart_syscall
> -1	i386	exit			sys_exit
> +1	i386	exit			sys_exit			0 noreturn
>  2	i386	fork			sys_fork
>  3	i386	read			sys_read
>  4	i386	write			sys_write
> @@ -263,7 +263,7 @@
>  249	i386	io_cancel		sys_io_cancel
>  250	i386	fadvise64		sys_ia32_fadvise64
>  # 251 is available for reuse (was briefly sys_set_zone_reclaim)
> -252	i386	exit_group		sys_exit_group
> +252	i386	exit_group		sys_exit_group			0 noreturn
>  253	i386	lookup_dcookie
>  254	i386	epoll_create		sys_epoll_create
>  255	i386	epoll_ctl		sys_epoll_ctl

Thank you!

But for non-KCSAN builds, I get the following diagnostics:

In file included from arch/x86/entry/syscall_32.c:17:
/arch/x86/include/generated/asm/syscalls_32.h:2:20: error: expected declaration specifiers or ‘...’ before numeric constant
    2 | __SYSCALL_NORETURN(1, sys_exit)

For KCSAN builds, I instead get the following diagnostics:

In file included from arch/x86/entry/syscall_32.c:17:
/arch/x86/include/generated/asm/syscalls_32.h:2:20: error: expected parameter declarator
__SYSCALL_NORETURN(1, sys_exit)

Does arch/x86/entry/syscall_32.c need the following additional patch?

A quick smoke test passes, but perhaps I am just getting lucky...

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index aab31760b4e3e..d9ae910ea6f33 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -14,9 +14,13 @@
 #endif
 
 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
+#undef __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
+
 #define __SYSCALL(nr, sym) __ia32_##sym,
 const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>

