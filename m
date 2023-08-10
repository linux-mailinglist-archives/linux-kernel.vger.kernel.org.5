Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC17776D27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHJAjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJAjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66E26A0;
        Wed,  9 Aug 2023 17:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E9C64CA9;
        Thu, 10 Aug 2023 00:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA7C433C7;
        Thu, 10 Aug 2023 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691627931;
        bh=WrUTXC6uZjIJQaROzuUF9MIOrS/vce2evjZsylCt4wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icx7BuejGWgQgdLOejuiVvwevfHp410W6RFZHWf6b76nLjgPpuwce3UJ3nKshFNej
         D0kuuMcogJ/IR91m2pOGC+D4ILV2jdYk4SX3pNEcDYrBxU0ktSD4p7Ft/ROwAMobOy
         j1F+duGqMm4TaR0My8lIgRmcaIShJZv9T4zjtsN6OrP776fHTDWlLJFKn8bK9gMTgk
         b17i9kv5vuYgcxaVdOBQubAqarBTny43Uy6ehQOmWSnqmyKLwHa11gIkzFanmww4xE
         rEx4iH+RE0Enkh0PbDaZtsS+j1FjKJbqep4xSTcwFt5Sr4bVrX3DOHUSmGmAczfm7q
         UFbENRY1hm5xg==
Date:   Thu, 10 Aug 2023 09:38:45 +0900
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
Message-Id: <20230810093845.7ebbe1ada897a4afe861e331@kernel.org>
In-Reply-To: <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139095066.324433.15514499924371317690.stgit@devnote2>
        <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
        <20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
        <CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 17:38:00 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 9, 2023 at 4:45 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > --- a/kernel/trace/trace_fprobe.c
> > > > +++ b/kernel/trace/trace_fprobe.c
> > > > @@ -132,25 +132,30 @@ static int
> > > >  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > > >                    void *base)
> > > >  {
> > > > -       struct pt_regs *regs = rec;
> > > > -       unsigned long val;
> > > > +       struct ftrace_regs *fregs = rec;
> > > > +       unsigned long val, *stackp;
> > > >         int ret;
> > > >
> > > >  retry:
> > > >         /* 1st stage: get value from context */
> > > >         switch (code->op) {
> > > >         case FETCH_OP_STACK:
> > > > -               val = regs_get_kernel_stack_nth(regs, code->param);
> > > > +               stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
> > > > +               if (((unsigned long)(stackp + code->param) & ~(THREAD_SIZE - 1)) ==
> > > > +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> > >
> > > Maybe it'd be worth extracting a local
> > > "ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
> > > "ftrace_regs_within_kernel_stack" ?
> >
> > Yeah, maybe we can make it a generic inline function in linux/ftrace.h.
> 
> Or even just above this function if there are low chances it would get
> used elsewhere :)

Thanks, but since regs_get_kernel_stack_nth() is defined in asm/ptrace.h,
I think ftrace_regs_get_kernel_stack_nth() is better defined in
linux/ftrace.h. :)

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
