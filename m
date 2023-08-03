Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A125076EE60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjHCPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHCPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8510C1;
        Thu,  3 Aug 2023 08:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D241E61DF5;
        Thu,  3 Aug 2023 15:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76969C433C8;
        Thu,  3 Aug 2023 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691077333;
        bh=VlZwVQjlwLiyKoNjTvZskhtYJ+9c4rsp87+ndIKilUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TDTKV4Ye3zV77kDzd5QSd87HpK2qWNIrMCGzkqW2AGnzmC2uVLWlt+7wZ52l9dzaq
         8yemnhfR52CknvhOn1/o2cUqeiycY/lOjcOpjlBEexmGWj7Z7Zvp/7vWl4hZ9D8sYW
         U6k+aFGRw7DxWDZwmhSIHFV84eoZQRKdSrs3x+QPwOy/y5iDznuBQLkWKoHuxSvmZ3
         9LTZI+ckVWE8sTcaEpolWwNFZCsRs6x8hGL8Q8MTXfrQgPWszfOfTPnhi/h5lAz80I
         AaYtDEdnAw9lyK1U2F6cK3NWTDuS6weRH8MqQ/mU6r4nUjjB/OoqjiwfvM+zeizz/2
         C+lbEm3SSuIwg==
Date:   Fri, 4 Aug 2023 00:42:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
In-Reply-To: <CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
        <20230802000228.158f1bd605e497351611739e@kernel.org>
        <20230801112036.0d4ee60d@gandalf.local.home>
        <20230801113240.4e625020@gandalf.local.home>
        <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
        <20230801190920.7a1abfd5@gandalf.local.home>
        <CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 16:44:09 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 2, 2023 at 1:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 1 Aug 2023 15:18:56 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Tue, Aug 1, 2023 at 8:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Tue, 1 Aug 2023 11:20:36 -0400
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > > The solution was to come up with ftrace_regs, which just means it has all
> > > > > the registers to extract the arguments of a function and nothing more. Most
> > > >
> > > > This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. As
> > > > the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. They
> > > > will do:
> > > >
> > > >         void callback(..., struct ftrace_regs *fregs) {
> > > >                 struct pt_regs *regs = ftrace_get_regs(fregs);
> > > >
> > > >
> > > > Where ftrace_get_regs() will return the pt_regs only if it is fully filled.
> > > > If it is not, then it returns NULL. This was what the x86 maintainers
> > > > agreed with.
> > >
> > > arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) NULL
> > >
> > > Ouch. That's very bad.
> > > We care a lot about bpf running well on arm64.
> >
> > [ Adding Mark and Florent ]
> 
> Ah, thanks Steve! That's my favorite can of worms :) I actually
> consider sending a talk proposal to the tracing MC at LPC "pt_regs -
> the good the bad and the ugly" on this very topic because I care about
> unblocking BPF "multi_kprobe" (which really is fprobe) on arm64, maybe
> it would be interesting.

Ah, it is almost same as my talk :)

> 
> > That's because arm64 doesn't support FTRACE_WITH_REGS anymore. Their
> > function handlers only care about the arguments. If you want full regs at
> > function entry, then you need to take a breakpoint hit for a full kprobe.
> 
> The main reason why arm64 dropped FTRACE_WITH_REGS is because some
> registers (like pstate) can not be saved outside of an exception entry
> (they are just wrong), so trampolines either have to make a pstate up
> or not populate it.
> 
> The other reasons are: simplicity (for architectural reasons, it's a
> lot easier to have only one type of ftrace trampoline on arm64, the
> "with_args" one) and performance (as you said, why bother saving a
> pt_regs when most ftrace users don't need it anyway). If you need an
> actual full pt_regs, then your use case is debugging rather than
> tracing and you should be able to deal with the slowness and go
> through an exception (a kprobe).

Agreed. Both reasons are reasonable. Especially function entry and
exit tracing API, we don't need full pt_regs because there is 
established ABI.

> 
> > In fact, fprobes isn't even supported on arm64 because it it doesn't have
> > DYNAMIC_FTRACE_WITH_REGS. I believe that was the reason Masami was trying
> > to get it to work with ftrace_regs. To get it to work on arm64.
> >
> > Again, ftrace_get_regs(fregs) is only suppose to return something if the
> > pt_regs is fully supplied. If they are not, then it must not be used. Are
> > you not using a fully filled pt_regs? Because that's what both Thomas and
> > Peter (also added) told me not to do!
> 
> Funnily enough, there's another use of sparse pt_regs in the kernel, in Perf:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/tree/arch/arm64/include/asm/perf_event.h#n20
> Notice how Perf on arm64 implicitly expects the "pstate" register to
> be set (the very register which we try so hard not to fake in
> ftrace_regs) because Perf happens to call the "user_mode()" macro
> somewhere which reads this field:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/tree/arch/arm64/include/asm/ptrace.h#n227

I think interrupt/exception based API like kprobes and perf (PMU) may need
to use pt_regs. 

> 
> I pointed this out in
> https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com/#t
> when Masami proposed adding calls from fprobe to perf. If every
> subsystem makes different assumptions about "how sparse" their pt_regs
> is and they call into one another, this could lead to... interesting
> bugs. (eg: currently, we don't populate a fake pstate in ftrace_regs.
> so we'd need to fake it when creating a sparse pt_regs _for Perf_,
> knowing that Perf specifically expects this reg to be set. this would
> require a struct copy anyway and some knowledge about how the data
> will be consumed, in an arch- and subsystem- specific way)

yeah, sorry I missed that point. I should remove it until we can fix it.

I think we can add another kernel event only perf_trace_buf_submit()
which doesn't have the user_mode() check.

> 
> On the other hand, untangling all code paths that come from
> trampolines (with a light regs structure) from those that come from an
> exception (with a pt_regs) could lead to a lot of duplicated code, and
> converting between each subsystem's idea of a light regs structure
> (what if perf introduces a perf_regs now ?) would be tedious and slow
> (lots of copies ?).

This is one discussion point I think. Actually, using pt_regs in kretprobe
(and rethook) is histrical accident. Originally, it had put a kprobe on
the function return trampoline to hook it. So keep the API compatiblity
I made the hand assembled code to save the pt_regs on the stack.

My another question is if we have the fprobe to trace (hook) the function
return, why we still need the kretprobe itself. I think we can remove
kretprobe and use fprobe exit handler, because "function" probing will
be done by fprobe, not kprobe. And then, we can simplify the kprobe
interface and clarify what it is -- "kprobe is a wrapper of software
breakpoint". And we don't need to think about duplicated code anymore :)

>  
> > Otherwise, ftrace_regs() has support on arm64 for getting to the argument
> > registers and the stack. Even live kernel patching now uses ftrace_regs().
> >
> > >
> > > If you guys decide to convert fprobe to ftrace_regs please
> > > make it depend on kconfig or something.
> > > bpf side needs full pt_regs.
> 
> Some wild ideas that I brought up once in a BPF office hour: BPF
> "multi_kprobe" could provide a fake pt_regs (either by constructing a
> sparse one on the stack or by JIT-ing different offset accesses and/or
> by having the verifier deny access to unpopulated fields) or break the
> current API (is it conceivable to phase out BPF "multi_kprobe"
> programs in favor of BPF "fprobe" programs that don't lie about their
> API and guarantees and just provide a ftrace_regs ?)

+1 :)

> 
> > Then use kprobes. When I asked Masami what the difference between fprobes
> > and kprobes was, he told me that it would be that it would no longer rely
> > on the slower FTRACE_WITH_REGS. But currently, it still does.
> 
> Actually... Moving fprobe to ftrace_regs should get even more spicy!
> :) Fprobe also wraps "rethook" which is basically the same thing as
> kretprobe: a return trampoline that saves a pt_regs, to the point that
> on x86 kretprobe's trampoline got dropped in favor of rethook's
> trampoline. But for the same reasons that we don't want ftrace to save
> pt_regs on arm64, rethook should probably also just save a ftrace_regs
> ? (also, to keep the fprobe callback signatures consistent between
> pre- and post- handlers). But if we want fprobe "post" callbacks to
> save a ftrace_regs now, either we need to re-introduce the kretprobe
> trampoline or also change the API of kretprobe (and break its symmetry
> with kprobe and we'd have the same problem all over again with BPF
> kretprobe program types...). All of this is "beautifully" entangled...
> :)

As I said, I would like to phase out the kretprobe itself because it
provides the same feature of fprobe, which is confusing. jprobe was
removed a while ago, and now kretprobe is. But we can not phase out
it at once. So I think we will keep current kretprobe trampoline on
arm64 and just add new ftrace_regs based rethook. Then remove the
API next release. (after all users including systemtap is moved) 

> 
> > The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
> > the first place, was because of the overhead you reported to me with
> > ftrace_regs_caller and why you wanted to go the direct trampoline approach.
> > That's when I realized I could use a subset because those registers were
> > already being saved. The only reason FTRACE_WITH_REGS was created was it
> > had to supply full pt_regs (including flags) and emulate a breakpoint for
> > the kprobes interface. But in reality, nothing really needs all that.
> >
> > > It's not about access to args.
> > > pt_regs is passed from bpf prog further into all kinds of perf event
> > > functions including stack walking.
> 
> If all accesses are done in BPF bytecode, we could (theoretically)
> have the verifier and JIT work together to deny accesses to
> unpopulated fields, or relocate pt_regs accesses to ftrace_regs
> accesses to keep backward compatibility with existing multi_kprobe BPF
> programs.

Yeah, that is what I would like to suggest, and what my patch does.
(let me update rethook too, it'll be a bit tricky since I don't want
break anything) 

Thanks,

> 
> Is there a risk that a "multi_kprobe" program could call into a BPF
> helper or kfunc that reads this pt_regs pointer and expect certain
> fields to be set ? I suppose we could also deny giving that "pt_regs"
> pointer to a helper... :/
> 
> > ftrace_regs gives you the stack pointer. Basically, it gives you access to
> > anything that is required to be saved to do a function call from fentry.
> >
> > > I think ORC unwinder might depend on availability of all registers.
> > > Other perf helpers might need it too. Like perf_event_output.
> > > bpf progs need to access arguments, no doubt about that.
> > > If ftrace_regs have them exactly in the same offsets as in pt_regs
> > > that might work transparently for bpf progs, but, I'm afraid,
> > > it's not the case on all archs.
> > > So we need full pt_regs to make sure all paths are still working.
> > >
> > > Adding Jiri and others.
> >
> > Then I recommend that you give up using fprobes and just stick with kprobes
> > as that's guaranteed to give you full pt_regs (at the overhead of doing
> > things like filing in flags and such). And currently for arm64, fprobes can
> > only work with ftrace_regs, without the full pt_regs.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
