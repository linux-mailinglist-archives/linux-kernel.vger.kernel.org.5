Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04D7EE5A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjKPRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKPRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:03:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 297F2B7;
        Thu, 16 Nov 2023 09:03:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1245E1595;
        Thu, 16 Nov 2023 09:04:28 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.119.36.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8ED33F6C4;
        Thu, 16 Nov 2023 09:03:40 -0800 (PST)
Date:   Thu, 16 Nov 2023 12:03:35 -0500
From:   Mark Rutland <mark.rutland@arm.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
Message-ID: <ZVZLZ4lxJa2hjVWv@FVFF77S0Q05N>
References: <20230917000045.56377-1-puranjay12@gmail.com>
 <20230917000045.56377-2-puranjay12@gmail.com>
 <ZUPVbrMSNNwPw_B-@FVFF77S0Q05N.cambridge.arm.com>
 <CANk7y0g8SOrSAY2jqZ22v6Duu9yhHY-d39g5gJ2vA2j2Y-v53Q@mail.gmail.com>
 <ZUtjyxBheN-dbj84@FVFF77S0Q05N>
 <CANk7y0hvEu3WkYEJ5oRqRHwKGfDnM+fO0=vDen5=zO8-rCvr9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0hvEu3WkYEJ5oRqRHwKGfDnM+fO0=vDen5=zO8-rCvr9Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:53:52PM +0100, Puranjay Mohan wrote:
> Hi Mark,
> 
> On Wed, Nov 8, 2023 at 11:32 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Nov 06, 2023 at 10:04:09AM +0100, Puranjay Mohan wrote:
> > > Hi Mark,
> > >
> > > On Thu, Nov 2, 2023 at 5:59 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Sun, Sep 17, 2023 at 12:00:45AM +0000, Puranjay Mohan wrote:
> > > > > Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
> > > > > by bpf_throw() to unwind till the program marked as exception boundary and
> > > > > run the callback with the stack of the main program.
> > > > >
> > > > > The prologue generation code has been modified to make the callback
> > > > > program use the stack of the program marked as exception boundary where
> > > > > callee-saved registers are already pushed.
> > > > >
> > > > > As the bpf_throw function never returns, if it clobbers any callee-saved
> > > > > registers, they would remain clobbered. So, the prologue of the
> > > > > exception-boundary program is modified to push R23 and R24 as well,
> > > > > which the callback will then recover in its epilogue.
> > > > >
> > > > > The Procedure Call Standard for the Arm 64-bit Architecture[1] states
> > > > > that registers r19 to r28 should be saved by the callee. BPF programs on
> > > > > ARM64 already save all callee-saved registers except r23 and r24. This
> > > > > patch adds an instruction in prologue of the  program to save these
> > > > > two registers and another instruction in the epilogue to recover them.
> > > > >
> > > > > These extra instructions are only added if bpf_throw() used. Otherwise
> > > > > the emitted prologue/epilogue remains unchanged.
> > > > >
> > > > > [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst
> > > > >
> > > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > > ---
> > > >
> > > > [...]
> > > >
> > > > > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> > > > > +{
> > > > > +     struct stack_info stacks[] = {
> > > > > +             stackinfo_get_task(current),
> > > > > +     };
> > > >
> > > > Can bpf_throw() only be used by BPF programs that run in task context, or is it
> > > > possible e.g. for those to run within an IRQ handler (or otherwise on the IRQ
> > > > stack)?
> > >
> > > I will get back on this with more information.
> > >
> > > >
> > > > > +
> > > > > +     struct unwind_state state = {
> > > > > +             .stacks = stacks,
> > > > > +             .nr_stacks = ARRAY_SIZE(stacks),
> > > > > +     };
> > > > > +     unwind_init_common(&state, current);
> > > > > +     state.fp = (unsigned long)__builtin_frame_address(1);
> > > > > +     state.pc = (unsigned long)__builtin_return_address(0);
> > > > > +
> > > > > +     if (unwind_next_frame_record(&state))
> > > > > +             return;
> > > > > +     while (1) {
> > > > > +             /* We only use the fp in the exception callback. Pass 0 for sp as it's unavailable*/
> > > > > +             if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
> > > > > +                     break;
> > > > > +             if (unwind_next_frame_record(&state))
> > > > > +                     break;
> > > > > +     }
> > > > > +}
> > > >
> > > > IIUC you're not using arch_stack_walk() because you need the FP in addition to
> > > > the PC.
> > >
> > > Yes,
> > >
> > > > Is there any other reason you need to open-code this?
> > >
> > > No,
> > >
> > > >
> > > > If not, I'd rather rework the common unwinder so that it's possible to get at
> > > > the FP. I had patches for that a while back:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/stacktrace/metadata
> > > >
> > > > ... and I'm happy to rebase that and pull out the minimum necessary to make
> > > > that possible.
> > >
> > > It would be great if you can rebase and push the code, I can rebase this on
> > > your work and not open code this implementation.
> >
> > I've rebased the core of that atop v6.6, and pushed that out to my
> > arm64/stacktrace/kunwind branch:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/stacktrace/kunwind
> >
> > Once v6.7-rc1 is out, I'll rebase that and post it out (possibly with some of
> > the other patches atop).
> >
> > With that I think you can implement arch_bpf_stack_walk() in stacktrace.c using
> > kunwind_stack_walk() in a similar way to how arch_stack_walk() is implemented
> > in that branch.
> >
> > If BPF only needs a single consume_fn, that can probably be even simpler as you
> > won't need a struct to hold the consume_fn and cookie value.
> 
> Thanks for the help.
> I am planning to do something like the following:
> let me know if this can be done in a better way:
> 
> +struct bpf_unwind_consume_entry_data {
> +       bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
> +       void *cookie;
> +};
> +
> +static bool
> +arch_bpf_unwind_consume_entry (const struct kunwind_state *state, void *cookie)
> +{
> +       struct bpf_unwind_consume_entry_data *data = cookie;
> +       return data->consume_entry(data->cookie, state->common.pc, 0,
> state->common.fp);
> +}
> +
> +noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void
> *cookie, u64 ip, u64 sp,
> +                                         u64 fp), void *cookie)
> +{
> +       struct bpf_unwind_consume_entry_data data = {
> +               .consume_entry = consume_entry,
> +               .cookie = cookie,
> +       };
> +
> +       kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, task, regs);
> +}

That's roughly what I had expected, so that looks good to me.

> I need to get the task and regs here so it can work from all contexts.
> How can I do it?

Are you asking because that's what the kunwind_stack_walk() prototype takes?

If so, I believe you just need:

	kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current, NULL);

Note that we currently *cannot* reliably unwind across an exception boundary,
so if you have non-NULL regs the unwind will be unsafe. IIUC the BPF exceptions
you're adding support for are handled via a branch rather than via an
architectural exception, so there are no regs to pass (and so NULL is correct).

Thanks,
Mark.
