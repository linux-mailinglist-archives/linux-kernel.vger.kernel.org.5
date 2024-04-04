Return-Path: <linux-kernel+bounces-131770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E5898B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2661C1F2B4F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5C12BEBF;
	Thu,  4 Apr 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUinPikT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04434129A78;
	Thu,  4 Apr 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246051; cv=none; b=oC3g0+74GafLphR/9ZXh+cQzYbBST2sSYs8jTh5h6hyiVCTS7bOnq33oEzig9xWDo1P8DWpuIlSkKXk4YLyq3aSM+2au4uhWWUfuJKNJgwNA1oJhV7bFBIZdPNYueKYbL8VlnsMyLFJWJHtcmSSzCVfKzuM2xEXDhnDRqiyBkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246051; c=relaxed/simple;
	bh=79ADrVhcyZsn5BtjxBXjLe/o8W9zuvef1sVQ6eYd+bk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mOdUG5XsUSL3++ioqQpuIKloRJEvWkVXvPVQ5rtam5jflobdqSU6LU82FO72hNfNr3wfourppcfOFwRkRiUFazwLYDDFYrbisrdWUOQ4fMGoHlBIUd4p1JsBroE1BS9I2rlYhQAP+w+m4gtuLwkZRmUwDgVd36Lp4rPE5vGym+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUinPikT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F3FC433F1;
	Thu,  4 Apr 2024 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246050;
	bh=79ADrVhcyZsn5BtjxBXjLe/o8W9zuvef1sVQ6eYd+bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUinPikTbT5qj1M9MEq/EqXVmb2ZuYGe821X/7FKCtYZDD0JodFKhS6BD5v0rUt39
	 I6K67Qr0TrgY+v7f8DS+krDkJ6HC13etqWlGfj+q4h0dwNznngMI5X7Pzt0MTlXRSX
	 t/X611h1bkT9cT6LtL+JNohXDrzPjpSa270sFqIslUZPZTOzZS+DxrL/Ky4k7OhyOx
	 Efbo319mgmZxN8/oWoB3xTp3QvlJgtVjiVaUvMWOjfFX5k+2aFV9/uzz0Exl8Tt2ZN
	 0L0ZFGA+67gA31wdhDn5b2sc5JpVmQUz9ZP3ABzKNgV3GEvLJ7/RisoWkZP3e9EQQ0
	 TXsm+zV+dru/g==
Date: Fri, 5 Apr 2024 00:54:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
In-Reply-To: <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
	<20240402093302.2416467-2-jolsa@kernel.org>
	<20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Apr 2024 19:00:07 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Apr 3, 2024 at 5:58 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 3 Apr 2024 09:58:12 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Wed, Apr 3, 2024 at 7:09 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Wed, 3 Apr 2024 11:47:41 +0200
> > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > > On Wed, Apr 03, 2024 at 10:07:08AM +0900, Masami Hiramatsu wrote:
> > > > > > Hi Jiri,
> > > > > >
> > > > > > On Tue,  2 Apr 2024 11:33:00 +0200
> > > > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > >
> > > > > > > Adding uretprobe syscall instead of trap to speed up return probe.
> > > > > >
> > > > > > This is interesting approach. But I doubt we need to add additional
> > > > > > syscall just for this purpose. Can't we use another syscall or ioctl?
> > > > >
> > > > > so the plan is to optimize entry uprobe in a similar way and given
> > > > > the syscall is not a scarce resource I wanted to add another syscall
> > > > > for that one as well
> > > > >
> > > > > tbh I'm not sure sure which syscall or ioctl to reuse for this, it's
> > > > > possible to do that, the trampoline will just have to save one or
> > > > > more additional registers, but adding new syscall seems cleaner to me
> > > >
> > > > Hmm, I think a similar syscall is ptrace? prctl may also be a candidate.
> > >
> > > I think both ptrace and prctl are for completely different use cases
> > > and it would be an abuse of existing API to reuse them for uretprobe
> > > tracing. Also, keep in mind, that any extra argument that has to be
> > > passed into this syscall means that we need to complicate and slow
> > > generated assembly code that is injected into user process (to
> > > save/restore registers) and also kernel-side (again, to deal with all
> > > the extra registers that would be stored/restored on stack).
> > >
> > > Given syscalls are not some kind of scarce resources, what's the
> > > downside to have a dedicated and simple syscall?
> >
> > Syscalls are explicitly exposed to user space, thus, even if it is used
> > ONLY for a very specific situation, it is an official kernel interface,
> > and need to care about the compatibility. (If it causes SIGILL unless
> > a specific use case, I don't know there is a "compatibility".)
> 
> Check rt_sigreturn syscall (manpage at [0], for example).
> 
>        sigreturn() exists only to allow the implementation of signal
>        handlers.  It should never be called directly.  (Indeed, a simple
>        sigreturn() wrapper in the GNU C library simply returns -1, with
>        errno set to ENOSYS.)  Details of the arguments (if any) passed
>        to sigreturn() vary depending on the architecture.  (On some
>        architectures, such as x86-64, sigreturn() takes no arguments,
>        since all of the information that it requires is available in the
>        stack frame that was previously created by the kernel on the
>        user-space stack.)
> 
> This is a very similar use case. Also, check its source code in
> arch/x86/kernel/signal_64.c. It sends SIGSEGV to the calling process
> on any sign of something not being right. It's exactly the same with
> sys_uretprobe.
> 
>   [0] https://man7.org/linux/man-pages/man2/sigreturn.2.html

Thanks for a good example.
Hm, in the case of rt_sigreturn, it has no other way to do it so it
needs to use syscall. OTOH, sys_uretprobe is only for performance
optimization, and the performance may depend on the architecture.

> > And the number of syscalls are limited resource.
> 
> We have almost 500 of them, it didn't seems like adding 1-2 for good
> reasons would be a problem. Can you please point to where the limits
> on syscalls as a resource are described? I'm curious to learn.

Syscall table is compiled as a fixed array, so if we increase
the number, we need more tables. Of course this just increase 1 entry
and at least for x86 we already allocated bigger table, so it is OK.
But I'm just afraid if we can add more syscalls without any clear
rules, we may fill the tables with more specific syscalls.

Ah, we also should follow this document.

https://docs.kernel.org/process/adding-syscalls.html

Let me Cc linux-api@vger.kernel.org.

> >
> > I'm actually not sure how much we need to care of it, but adding a new
> > syscall is worth to be discussed carefully because all of them are
> > user-space compatibility.
> 
> Absolutely, it's a good discussion to have.

Thanks, if this is discussed enough and agreed from other maintainers,
I can safely pick this on my tree.

> 
> >
> > > > > > Also, we should run syzkaller on this syscall. And if uretprobe is
> > > > >
> > > > > right, I'll check on syzkaller
> > > > >
> > > > > > set in the user function, what happen if the user function directly
> > > > > > calls this syscall? (maybe it consumes shadow stack?)
> > > > >
> > > > > the process should receive SIGILL if there's no pending uretprobe for
> > > > > the current task, or it will trigger uretprobe if there's one pending
> > > >
> > > > No, that is too aggressive and not safe. Since the syscall is exposed to
> > > > user program, it should return appropriate error code instead of SIGILL.
> > > >
> > >
> > > This is the way it is today with uretprobes even through interrupt.
> >
> > I doubt that the interrupt (exception) and syscall should be handled
> > differently. Especially, this exception is injected by uprobes but
> > syscall will be caused by itself. But syscall can be called from user
> > program (of couse this works as sys_kill(self, SIGILL)).
> 
> Yep, I'd keep the behavior the same between uretprobes implemented
> through int3 and sys_uretprobe.

OK, so this syscall is something like coding int3 without debugger.

> >
> > > E.g., it could happen that user process is using fibers and is
> > > replacing stack pointer without kernel realizing this, which will
> > > trigger some defensive checks in uretprobe handling code and kernel
> > > will send SIGILL because it can't support such cases. This is
> > > happening today already, and it works fine in practice (except for
> > > applications that manually change stack pointer, too bad, you can't
> > > trace them with uretprobes, unfortunately).
> >
> > OK, we at least need to document it.
> 
> +1, yep

Can we make this syscall and uprobe behavior clearer? As you said, if
the application use sigreturn or longjump, it may skip returns and
shadow stack entries are left in the kernel. In such cases, can uretprobe
detect it properly, or just crash the process (or process runs wrongly)?

> 
> >
> > >
> > > So I think it's absolutely adequate to have this behavior if the user
> > > process is *intentionally* abusing this API.
> >
> > Of course user expected that it is abusing. So at least we need to
> > add a document that this syscall number is reserved to uprobes and
> > user program must not use it.
> >
> 
> Totally agree about documenting this.
> 
> > >
> > > > >
> > > > > but we could limit the syscall to be executed just from the trampoline,
> > > > > that should prevent all the user space use cases, I'll do that in next
> > > > > version and add more tests for that
> > > >
> > > > Why not limit? :) The uprobe_handle_trampoline() expects it is called
> > > > only from the trampoline, so it is natural to check the caller address.
> > > > (and uprobe should know where is the trampoline)
> > > >
> > > > Since the syscall is always exposed to the user program, it should
> > > > - Do nothing and return an error unless it is properly called.
> > > > - check the prerequisites for operation strictly.
> > > > I concern that new system calls introduce vulnerabilities.
> > > >
> > >
> > > As Oleg and Jiri mentioned, this syscall can't harm kernel or other
> > > processes, only the process that is abusing the API. So any extra
> > > checks that would slow down this approach is an unnecessary overhead
> > > and complication that will never be useful in practice.
> >
> > I think at least it should check the caller address to ensure the
> > address is in the trampoline.
> > But anyway, uprobes itself can break the target process, so no one
> > might care if this system call breaks the process now.
> 
> If we already have an expected range of addresses, then I think it's
> fine to do a quick unlikely() check. I'd be more concerned if we need
> to do another lookup or search to just validate this. I'm sure Jiri
> will figure it out.

Good.

> 
> >
> > >
> > > Also note that sys_uretprobe is a kind of internal and unstable API
> > > and it is explicitly called out that its contract can change at any
> > > time and user space shouldn't rely on it. It's purely for the kernel's
> > > own usage.
> >
> > Is that OK to use a syscall as "internal" and "unstable" API?
> 
> See above about rt_sigreturn. It seems like yes, for some highly
> specialized syscalls it is the case already.

OK, but as I said it is just for performance optimization, that is
a bit different from rt_sigreturn case.

Thank you,

> >
> > >
> > > So let's please keep it fast and simple.
> > >
> > >
> > > > Thank you,
> > > >
> > > >
> > > > >
> > > > > thanks,
> > > > > jirka
> > > > >
> > > > >
> > > > > >
> > >
> > > [...]
> >
> >
> > ([OT] If we can add syscall so casually, I would like to add sys_traceevent
> > for recording user space events :-) .)
> 
> Have you proposed this upstream? :) I have no clue and no opinion about it...
> 
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

