Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3947762D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjHIOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHIOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D90EE;
        Wed,  9 Aug 2023 07:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCB663C91;
        Wed,  9 Aug 2023 14:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC02EC433C7;
        Wed,  9 Aug 2023 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592318;
        bh=sShinOtzr9XlCmMRvGYtsdQ5gUdUATOYQTlYZKdx5mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2lERAp4Hbea8CPPgjMsfeTLG4XKmDhLbhWuj5VbtEZZaYEeO8sNkjIWDh+7HKwl9
         Nr1JgTNvSmhD3fGtoEzckQw2NXAo4FB9ZuodqH01Aem3ZwABSJL3gquLlERpXAL0bj
         mgPKLtJMAMdvtAkoMPM7n4cewj3HmFgxTcTqojawcQQwSAfcx2Q3bXqqHLRTv5q+1g
         UoUrQWxBoezN9PtxqIK9wnGX6gPskozHP/G5SLL9vUPT1THqYgljpHNZrcES6qZ2/3
         YaJ6BJDubOlHwzFMKYM4tPtHQ80CjObT8kl8vLX2nGk8MoXuw4SUC7SP59yaIaom6A
         ZL7X2sLs5n4Ug==
Date:   Wed, 9 Aug 2023 23:45:12 +0900
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
In-Reply-To: <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139095066.324433.15514499924371317690.stgit@devnote2>
        <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 12:31:00 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:49 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Allow fprobe events to be enabled with CONFIG_DYNAMIC_FTRACE_WITH_ARGS.
> > With this change, fprobe events mostly use ftrace_regs instead of pt_regs.
> > Note that if the arch doesn't enable HAVE_PT_REGS_COMPAT_FTRACE_REGS,
> > fprobe events will not be able to use from perf.
> 
> nit: "to be used from perf" ?

OK.

> 
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -132,25 +132,30 @@ static int
> >  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> >                    void *base)
> >  {
> > -       struct pt_regs *regs = rec;
> > -       unsigned long val;
> > +       struct ftrace_regs *fregs = rec;
> > +       unsigned long val, *stackp;
> >         int ret;
> >
> >  retry:
> >         /* 1st stage: get value from context */
> >         switch (code->op) {
> >         case FETCH_OP_STACK:
> > -               val = regs_get_kernel_stack_nth(regs, code->param);
> > +               stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
> > +               if (((unsigned long)(stackp + code->param) & ~(THREAD_SIZE - 1)) ==
> > +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> 
> Maybe it'd be worth extracting a local
> "ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
> "ftrace_regs_within_kernel_stack" ?

Yeah, maybe we can make it a generic inline function in linux/ftrace.h.

Thank you!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
