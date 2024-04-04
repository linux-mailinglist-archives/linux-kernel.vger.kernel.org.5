Return-Path: <linux-kernel+bounces-130796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE2897D32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E80928839E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C07610D;
	Thu,  4 Apr 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Tfg6vb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F4320E;
	Thu,  4 Apr 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192316; cv=none; b=qBfUyt/+fOqOqFHRJtwcAb7Ppx4VxUltb/qQku2cVEvm78lzem7DSZMaBRKW0RILYZZ3U00dCXjJ0rlW27Frxj9TWwkeKYdaQepIfx0RqKeigDghY9Kkbxv+6/soUoBocxSF+0N1chB77cIz6OMof4mu0Gp8/xKZC9Nohci6MDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192316; c=relaxed/simple;
	bh=0v3/tkPIhOlbZq3qqBqdt1rjzWlv5jgNo+JgIQke65k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QZ1zWUuIWq5Fg53PpUppGoYTNa2ZHCLYlTrieffYgeDeyZhwoB/UWDwMYNKjQ4bCoPGUTQ4UNep01ee0i9GdgpXVTN/nMj1sIvQwlLG4hedR1IJL8tUG5GWVSpNlV27oTfz53mcwnmF+EbqTeLEZMpjw+Pu92EbyTZkZoAiTncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Tfg6vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A828C433F1;
	Thu,  4 Apr 2024 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712192316;
	bh=0v3/tkPIhOlbZq3qqBqdt1rjzWlv5jgNo+JgIQke65k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+Tfg6vbqA1WP/dOid2LffkkWAfpx04DhnUs69FU9BoR9F7h6Jfh3rnu7SgJj59RT
	 ysiBS0xAAh+g2oFS+cb86NGnXequD5RBUONA3VUbLR0DKR9RJQIetqX67YmqIoXc0P
	 Y9Hm7tsDST6PWs5xq8yz1l/TPKGM97Wx9DRhIv5Aqrj6WsQ9jbmZO6qaFfKCyVJ/+L
	 iZSCRmuJBwtDtkrTUpWM0BXKW1rm5j4xG97rFnJ+FPOfPQaBat+0aHUJPlgvM/4zrZ
	 F4bFf09p1ji8Oupaz1wovIzT16l+bf11UEc+oIc8vp3IAVV9spa65cjgNlnhdz2j4r
	 8kfEAUqsEj3uw==
Date: Thu, 4 Apr 2024 09:58:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-kernel@web.codeaurora.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
In-Reply-To: <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
	<20240402093302.2416467-2-jolsa@kernel.org>
	<20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Apr 2024 09:58:12 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Apr 3, 2024 at 7:09 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 3 Apr 2024 11:47:41 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > On Wed, Apr 03, 2024 at 10:07:08AM +0900, Masami Hiramatsu wrote:
> > > > Hi Jiri,
> > > >
> > > > On Tue,  2 Apr 2024 11:33:00 +0200
> > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > > Adding uretprobe syscall instead of trap to speed up return probe.
> > > >
> > > > This is interesting approach. But I doubt we need to add additional
> > > > syscall just for this purpose. Can't we use another syscall or ioctl?
> > >
> > > so the plan is to optimize entry uprobe in a similar way and given
> > > the syscall is not a scarce resource I wanted to add another syscall
> > > for that one as well
> > >
> > > tbh I'm not sure sure which syscall or ioctl to reuse for this, it's
> > > possible to do that, the trampoline will just have to save one or
> > > more additional registers, but adding new syscall seems cleaner to me
> >
> > Hmm, I think a similar syscall is ptrace? prctl may also be a candidate.
> 
> I think both ptrace and prctl are for completely different use cases
> and it would be an abuse of existing API to reuse them for uretprobe
> tracing. Also, keep in mind, that any extra argument that has to be
> passed into this syscall means that we need to complicate and slow
> generated assembly code that is injected into user process (to
> save/restore registers) and also kernel-side (again, to deal with all
> the extra registers that would be stored/restored on stack).
> 
> Given syscalls are not some kind of scarce resources, what's the
> downside to have a dedicated and simple syscall?

Syscalls are explicitly exposed to user space, thus, even if it is used
ONLY for a very specific situation, it is an official kernel interface,
and need to care about the compatibility. (If it causes SIGILL unless
a specific use case, I don't know there is a "compatibility".)
And the number of syscalls are limited resource.

I'm actually not sure how much we need to care of it, but adding a new
syscall is worth to be discussed carefully because all of them are
user-space compatibility.

> > > > Also, we should run syzkaller on this syscall. And if uretprobe is
> > >
> > > right, I'll check on syzkaller
> > >
> > > > set in the user function, what happen if the user function directly
> > > > calls this syscall? (maybe it consumes shadow stack?)
> > >
> > > the process should receive SIGILL if there's no pending uretprobe for
> > > the current task, or it will trigger uretprobe if there's one pending
> >
> > No, that is too aggressive and not safe. Since the syscall is exposed to
> > user program, it should return appropriate error code instead of SIGILL.
> >
> 
> This is the way it is today with uretprobes even through interrupt.

I doubt that the interrupt (exception) and syscall should be handled
differently. Especially, this exception is injected by uprobes but
syscall will be caused by itself. But syscall can be called from user
program (of couse this works as sys_kill(self, SIGILL)).

> E.g., it could happen that user process is using fibers and is
> replacing stack pointer without kernel realizing this, which will
> trigger some defensive checks in uretprobe handling code and kernel
> will send SIGILL because it can't support such cases. This is
> happening today already, and it works fine in practice (except for
> applications that manually change stack pointer, too bad, you can't
> trace them with uretprobes, unfortunately).

OK, we at least need to document it.

> 
> So I think it's absolutely adequate to have this behavior if the user
> process is *intentionally* abusing this API.

Of course user expected that it is abusing. So at least we need to
add a document that this syscall number is reserved to uprobes and
user program must not use it.

> 
> > >
> > > but we could limit the syscall to be executed just from the trampoline,
> > > that should prevent all the user space use cases, I'll do that in next
> > > version and add more tests for that
> >
> > Why not limit? :) The uprobe_handle_trampoline() expects it is called
> > only from the trampoline, so it is natural to check the caller address.
> > (and uprobe should know where is the trampoline)
> >
> > Since the syscall is always exposed to the user program, it should
> > - Do nothing and return an error unless it is properly called.
> > - check the prerequisites for operation strictly.
> > I concern that new system calls introduce vulnerabilities.
> >
> 
> As Oleg and Jiri mentioned, this syscall can't harm kernel or other
> processes, only the process that is abusing the API. So any extra
> checks that would slow down this approach is an unnecessary overhead
> and complication that will never be useful in practice.

I think at least it should check the caller address to ensure the
address is in the trampoline.
But anyway, uprobes itself can break the target process, so no one
might care if this system call breaks the process now.

> 
> Also note that sys_uretprobe is a kind of internal and unstable API
> and it is explicitly called out that its contract can change at any
> time and user space shouldn't rely on it. It's purely for the kernel's
> own usage.

Is that OK to use a syscall as "internal" and "unstable" API?

> 
> So let's please keep it fast and simple.
> 
> 
> > Thank you,
> >
> >
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > >
> 
> [...]


([OT] If we can add syscall so casually, I would like to add sys_traceevent
for recording user space events :-) .)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

