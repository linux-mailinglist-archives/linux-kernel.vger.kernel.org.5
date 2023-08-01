Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FB76C0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHAXJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 19:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHAXJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D8E61;
        Tue,  1 Aug 2023 16:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285936176C;
        Tue,  1 Aug 2023 23:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47EEC433C7;
        Tue,  1 Aug 2023 23:09:22 +0000 (UTC)
Date:   Tue, 1 Aug 2023 19:09:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
        Florent Revest <revest@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801190920.7a1abfd5@gandalf.local.home>
In-Reply-To: <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
        <20230802000228.158f1bd605e497351611739e@kernel.org>
        <20230801112036.0d4ee60d@gandalf.local.home>
        <20230801113240.4e625020@gandalf.local.home>
        <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 15:18:56 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 8:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 1 Aug 2023 11:20:36 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > The solution was to come up with ftrace_regs, which just means it has all
> > > the registers to extract the arguments of a function and nothing more. Most  
> >
> > This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. As
> > the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. They
> > will do:
> >
> >         void callback(..., struct ftrace_regs *fregs) {
> >                 struct pt_regs *regs = ftrace_get_regs(fregs);
> >
> >
> > Where ftrace_get_regs() will return the pt_regs only if it is fully filled.
> > If it is not, then it returns NULL. This was what the x86 maintainers
> > agreed with.  
> 
> arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) NULL
> 
> Ouch. That's very bad.
> We care a lot about bpf running well on arm64.

[ Adding Mark and Florent ]

That's because arm64 doesn't support FTRACE_WITH_REGS anymore. Their
function handlers only care about the arguments. If you want full regs at
function entry, then you need to take a breakpoint hit for a full kprobe.

In fact, fprobes isn't even supported on arm64 because it it doesn't have
DYNAMIC_FTRACE_WITH_REGS. I believe that was the reason Masami was trying
to get it to work with ftrace_regs. To get it to work on arm64.

Again, ftrace_get_regs(fregs) is only suppose to return something if the
pt_regs is fully supplied. If they are not, then it must not be used. Are
you not using a fully filled pt_regs? Because that's what both Thomas and
Peter (also added) told me not to do!

Otherwise, ftrace_regs() has support on arm64 for getting to the argument
registers and the stack. Even live kernel patching now uses ftrace_regs().

> 
> If you guys decide to convert fprobe to ftrace_regs please
> make it depend on kconfig or something.
> bpf side needs full pt_regs.

Then use kprobes. When I asked Masami what the difference between fprobes
and kprobes was, he told me that it would be that it would no longer rely
on the slower FTRACE_WITH_REGS. But currently, it still does.

The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
the first place, was because of the overhead you reported to me with
ftrace_regs_caller and why you wanted to go the direct trampoline approach.
That's when I realized I could use a subset because those registers were
already being saved. The only reason FTRACE_WITH_REGS was created was it
had to supply full pt_regs (including flags) and emulate a breakpoint for
the kprobes interface. But in reality, nothing really needs all that.

> It's not about access to args.
> pt_regs is passed from bpf prog further into all kinds of perf event
> functions including stack walking.

ftrace_regs gives you the stack pointer. Basically, it gives you access to
anything that is required to be saved to do a function call from fentry.

> I think ORC unwinder might depend on availability of all registers.
> Other perf helpers might need it too. Like perf_event_output.
> bpf progs need to access arguments, no doubt about that.
> If ftrace_regs have them exactly in the same offsets as in pt_regs
> that might work transparently for bpf progs, but, I'm afraid,
> it's not the case on all archs.
> So we need full pt_regs to make sure all paths are still working.
> 
> Adding Jiri and others.

Then I recommend that you give up using fprobes and just stick with kprobes
as that's guaranteed to give you full pt_regs (at the overhead of doing
things like filing in flags and such). And currently for arm64, fprobes can
only work with ftrace_regs, without the full pt_regs.

-- Steve
