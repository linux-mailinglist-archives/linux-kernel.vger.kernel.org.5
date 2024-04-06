Return-Path: <linux-kernel+bounces-133779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534689A88F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17008B21812
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39F17BAA;
	Sat,  6 Apr 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaxSmVJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2F210D;
	Sat,  6 Apr 2024 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712372743; cv=none; b=j8ojzDr+0nVhuPUqDBb4pcJfwbNd0yOs0e4CTQDy8xoRXVrNCvDw+dtb+UKrRnnY+hmcfPXFX5xOQrqfii818vlmXTUrZQbvxRFFPBacZrCOoKA24HIocYIxPG2GVpjYu/jv7yluWv4hcpslQEGyg5joMcLLbIgD+i4VZrgiA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712372743; c=relaxed/simple;
	bh=2KFhInhhfukaheFX1xisg0V1WCHpL1YhtplN9+nge3g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VdxbbTmIp/lVRBUiTXkLNQqjQmgQJHuKRGdLNbWUXlVgdLVV2LOvvKqps+Odc9ly2jzgwddK7hAxl8aEKLWxnnBBwqexT4Imi1+o+6hqT0Ee4MgvZs4cf3924vkU+x06OFLl16GS5cTTTP8cMlPrYhzz6F27JWdpE0hN8E9WS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaxSmVJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C015C433F1;
	Sat,  6 Apr 2024 03:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712372743;
	bh=2KFhInhhfukaheFX1xisg0V1WCHpL1YhtplN9+nge3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaxSmVJPMEHzpPvyIyAYWPQUNc9O7LjVUiMMQCCsGCJBO80Cfpy1qvQ7RU3OsrlEa
	 RVXuDiqtHGjTLv//bddj5xSTFpKnLeawEYH2f9ICdljXgEnX03lHYBatILy4++5nUz
	 j6qgQ5kuM11w4j+p331lvRSuwQuZf6LWUJJqvZjPiZsBsHC5aCCmxLD6eqBnRPDNCL
	 1n6qLzwbe5GTnhEQJfCnovVCJjGbLJ3+o2TknKbpY/cDKraVJAS54YAIOG23cXtNSL
	 7+afOHuahWekRBp8L5RWAtbaq8n0sk224OVLCYjNC8t9hiPUGPiIa5E6xCQ6tu1SyV
	 /TFv0xWP+vSeQ==
Date: Sat, 6 Apr 2024 12:05:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240406120536.57374198f3f45e809d7e4efa@kernel.org>
In-Reply-To: <20240405110230.GA22839@redhat.com>
References: <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
	<20240404161108.GG7153@redhat.com>
	<20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
	<Zg-8r63tPSkuhN7p@krava>
	<20240405110230.GA22839@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 13:02:30 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/05, Jiri Olsa wrote:
> >
> > On Fri, Apr 05, 2024 at 10:22:03AM +0900, Masami Hiramatsu wrote:
> > >
> > > I think this expects setjmp/longjmp as below
> > >
> > > foo() { <- retprobe1
> > > 	setjmp()
> > > 	bar() { <- retprobe2
> > > 		longjmp()
> > > 	}
> > > } <- return to trampoline
> > >
> > > In this case, we need to skip retprobe2's instance.
> 
> Yes,
> 
> > > My concern is, if we can not find appropriate return instance, what happen?
> > > e.g.
> > >
> > > foo() { <-- retprobe1
> > >    bar() { # sp is decremented
> > >        sys_uretprobe() <-- ??
> > >     }
> > > }
> > >
> > > It seems sys_uretprobe() will handle retprobe1 at that point instead of
> > > SIGILL.
> >
> > yes, and I think it's fine, you get the consumer called in wrong place,
> > but it's your fault and kernel won't crash
> 
> Agreed.
> 
> With or without this patch userpace can also do
> 
> 	foo() { <-- retprobe1
> 		bar() {
> 			jump to xol_area
> 		}
> 	}
> 
> handle_trampoline() will handle retprobe1.

This is OK because the execution path has been changed to trampoline, but
the above will continue running bar() after sys_uretprobe().

> 
> > this can be fixed by checking the syscall is called from the trampoline
> > and prevent handle_trampoline call if it's not
> 
> Yes, but I still do not think this makes a lot of sense. But I won't argue.
> 
> And what should sys_uretprobe() do if it is not called from the trampoline?
> I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.
> 
> I agree very much with Andrii,
> 
>        sigreturn()  exists only to allow the implementation of signal handlers.  It should never be
>        called directly.  Details of the arguments (if any) passed to sigreturn() vary depending  on
>        the architecture.
> 
> this is how sys_uretprobe() should be treated/documented.

OK.

> 
> sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
> and return -EINVAL if this addr is not valid. But why?

Because sigreturn() never returns, but sys_uretprobe() will return.
If it changes the regs->ip and directly returns to the original return address,
I think it is natural to send SIGILL.


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

