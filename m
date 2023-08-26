Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED87896A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjHZMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHZMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B72BDE;
        Sat, 26 Aug 2023 05:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F084615C1;
        Sat, 26 Aug 2023 12:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D2C433C8;
        Sat, 26 Aug 2023 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693052461;
        bh=7EXJ1LENbcLPurI5Z9dQe+9Ef/4yp4DqUevs1jxxCUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QXrZon6mgILY3byNR5FdVO14AfRXgGliokWBj7UEH8qMyJK/L4H/fLd/0PGSstUtk
         8AzAaWTrePhSf5jH8OmNMttFBD2vmnuAvdmelceQiZAlcrA6MORPqeCiEkB4aDK9jM
         iSbZj8kB3KW23QR5XfS2zkchwmSvq60aY0LHMDqO6Gr931s/+D07jbYobJfPiLEXuM
         oawV7+GlZWxvnoR6pNFUzLleWtQ/EngVNDVbY+FinkTuR120DUMCpIp3J0FUFlwXOt
         l0/DRPNc2Nxmgg2ItwrXI1m6FR1TdOhWUaPmY3tTicHR9x6hKvylQeAyJjCPIUqlyr
         Cx9r6xEKuuNPQ==
Date:   Sat, 26 Aug 2023 12:38:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230826123838.610b3fe09b9fa1aab75f158d@kernel.org>
In-Reply-To: <CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
        <169280379741.282662.12221517584561036597.stgit@devnote2>
        <CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc: Peter)

On Fri, 25 Aug 2023 18:12:07 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 23, 2023 at 5:16 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index c60d0d9f1a95..90ad28260a9f 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> > +
> > +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stack */
> > +#define PERF_FPROBE_REGS_MAX   4
> > +
> > +struct pt_regs_stack {
> > +       struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> > +       int idx;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> > +
> > +static __always_inline
> > +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> > +{
> > +       struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> > +       struct pt_regs *regs;
> > +
> > +       if (stack->idx < PERF_FPROBE_REGS_MAX) {
> > +               regs = stack->regs[stack->idx++];
> 
> This is missing an &:
> regs = &stack->regs[stack->idx++];

Oops, good point. I'm curious it didin't cause compile error...
(I thought I built it on arm64)

> 
> > +               return ftrace_partial_regs(fregs, regs);
> 
> I think this is incorrect on arm64 and will likely cause very subtle
> failure modes down the line on other architectures too. The problem on
> arm64 is that Perf calls "user_mode(regs)" somewhere down the line,
> that macro tries to read the "pstate" register, which is not populated
> in ftrace_regs, so it's not copied into a "partial" pt_regs either and
> Perf can take wrong decisions based on that.

I think we can assure the ftrace_regs is always !user_mode() so in that case
ftrace_partial_regs() should fill the 'pstate' register as kernel mode.

> 
> I already mentioned this problem in the past:
> - in the third answer block of:
> https://lore.kernel.org/all/CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com/
> - in the fourth answer block of:
> https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com/
> 

Oops, sorry I missed that. And I basically agreed that we need a special
care for perf. Let me reply it.

> It is quite possible that other architectures at some point introduce
> a light ftrace "args" trampoline that misses one of the registers
> expected by Perf because they don't realize that this trampoline calls
> fprobe which calls Perf which has specific registers expectations.

Agreed.

> 
> We got the green light from Alexei to use ftrace_partial_regs for "BPF
> mutli_kprobe" because these BPF programs can gracefully deal with
> sparse pt_regs but I think a similar conversation needs to happen with
> the Perf folks.

Indeed. Who is the best person to involve, Peterz? (but I think
we need arm64 PMU part maintainer to talk)

> 
> ----
> 
> On a side-note, a subtle difference between ftrace_partial_regs with
> and without HAVE_PT_REGS_TO_FTRACE_REGS_CAST is that one does a copy
> and the other does not. If a subsystem receives a partial regs under
> HAVE_PT_REGS_TO_FTRACE_REGS_CAST, it can modify register fields and
> the modified values will be restored by the ftrace trampoline. Without
> HAVE_PT_REGS_TO_FTRACE_REGS_CAST, only the copy will be modified and
> ftrace won't restore them. I think the least we can do is to document
> thoroughly the guarantees of the ftrace_partial_regs API: users
> shouldn't rely on modifying the resulting regs because depending on
> the architecture this could do different things. People shouldn't rely
> on any register that isn't covered by one of the ftrace_regs_get_*
> helpers because it can be unpopulated on some architectures. I believe
> this is the case for BPF multi_kprobe but not for Perf.

I agree with the documentation requirement, but since the fprobe official
interface becomes ftrace_regs, user naturally expects it is not pt_regs.
The problem is that the perf's case. Since the perf is natively only
support pt_regs (and there is no reason to support ftrace_regs, yes).
Hmm, I will recheck how the perf events on trace-event is implementd.

Thank you,

> 
> > +       }
> > +       return NULL;
> > +}
> > +
> > +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs)
> > +{
> > +       struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> > +
> > +       if (WARN_ON_ONCE(regs != stack->regs[stack->idx]))
> 
> This is missing an & too:
> if (WARN_ON_ONCE(regs != &stack->regs[stack->idx]))
> 
> 
> 
> 
> > +               return;
> > +
> > +       --stack->idx;
> > +}
> > +
> > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
