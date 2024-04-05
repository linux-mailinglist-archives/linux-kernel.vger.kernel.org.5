Return-Path: <linux-kernel+bounces-132303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077938992C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0704C1C22C21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEDD26A;
	Fri,  5 Apr 2024 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWghTJZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1A7484;
	Fri,  5 Apr 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280130; cv=none; b=NJ2M24clVjY+4eUKka5WY13RNfTlbTwvb91PSVIi1l3w/A+PKBl3q10ERMdyUCPBLTDyhEJi2JWakQyU7UDLqHordWsAQm1udXTNLduGEXMPArk/IgqGHnrhcbzzG7/+1npm3er0gaU4YuciK1VJwhJXwhB82c7GxdqRtC06ZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280130; c=relaxed/simple;
	bh=szljdTDB94eQ+EkiXsSkkkx9Poh6qFx1veGM9Mfl0+w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oeiiWVwGy2IVqb4hOhaoM9NCq9tf7EUauDslv1ouxgfLP4vcCRVFvhf+QrjBS8yikSuEG4/KcS92meUpETLiVulYio4P8EuJM/BqVnE/nxf3v8tf9/fNau51jPfblzk+9Er95KMXzWE3ks+rfaJ72xwdW8ETE3EJXV+mgS1nTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWghTJZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CEC433C7;
	Fri,  5 Apr 2024 01:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712280129;
	bh=szljdTDB94eQ+EkiXsSkkkx9Poh6qFx1veGM9Mfl0+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWghTJZUHmUJad0KDGhWYm1a9qB9arTjFvpqXMQ7nVDgKzHACTber46um0xQNJNQO
	 4KQDZEG0lw6FGodDUdKkwzX1El///teqLI1cWXh4SNJtGdzWAHThtnSKKdiFlbZ+Rp
	 /3ZpiKOD0MENLm5kf70YSRuzRE34dHbCCzKfJs58yocLrCdbHZ2x5XibvfvpLkl/sf
	 XcssPS5/y0T6Q/xeWmBwbbYLaN4Gb6G94Pc6uglyGHejEF1yxWnthCIg0XYbkyZuYD
	 1jVuQhiowsnC+EbIT9qMm133Af2MTnerT5G4ZMKfIBFufXYBiqUgilNrWE2W0kFlxW
	 ANrVfPjxgeWYQ==
Date: Fri, 5 Apr 2024 10:22:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
In-Reply-To: <20240404161108.GG7153@redhat.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
	<20240402093302.2416467-2-jolsa@kernel.org>
	<20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
	<20240404161108.GG7153@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 18:11:09 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/05, Masami Hiramatsu wrote:
> >
> > Can we make this syscall and uprobe behavior clearer? As you said, if
> > the application use sigreturn or longjump, it may skip returns and
> > shadow stack entries are left in the kernel. In such cases, can uretprobe
> > detect it properly, or just crash the process (or process runs wrongly)?
> 
> Please see the comment in handle_trampoline(), it tries to detect this case.
> This patch should not make any difference.

I think you mean this loop will skip and discard the stacked return_instance
to find the valid one.

----
        do {
                /*
                 * We should throw out the frames invalidated by longjmp().
                 * If this chain is valid, then the next one should be alive
                 * or NULL; the latter case means that nobody but ri->func
                 * could hit this trampoline on return. TODO: sigaltstack().
                 */
                next = find_next_ret_chain(ri);
                valid = !next || arch_uretprobe_is_alive(next, RP_CHECK_RET, regs);

                instruction_pointer_set(regs, ri->orig_ret_vaddr);
                do {
                        if (valid)
                                handle_uretprobe_chain(ri, regs);
                        ri = free_ret_instance(ri);
                        utask->depth--;
                } while (ri != next);
        } while (!valid);
----

I think this expects setjmp/longjmp as below

foo() { <- retprobe1
	setjmp()
	bar() { <- retprobe2
		longjmp()
	}
} <- return to trampoline

In this case, we need to skip retprobe2's instance.
My concern is, if we can not find appropriate return instance, what happen?
e.g.

foo() { <-- retprobe1
   bar() { # sp is decremented
       sys_uretprobe() <-- ??
    }
}

It seems sys_uretprobe() will handle retprobe1 at that point instead of
SIGILL.

Can we avoid this with below strict check?

if (ri->stack != regs->sp + expected_offset)
	goto sigill;

expected_offset should be 16 (push * 3 - ret) on x64 if we ri->stack is the
regs->sp right after call.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

