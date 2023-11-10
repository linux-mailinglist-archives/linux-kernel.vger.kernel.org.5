Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E807E84AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbjKJUvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjKJUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C40472D4C9;
        Fri, 10 Nov 2023 03:11:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C32106F;
        Fri, 10 Nov 2023 03:12:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23BD3F7C5;
        Fri, 10 Nov 2023 03:11:36 -0800 (PST)
Date:   Fri, 10 Nov 2023 11:11:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs
 definition
Message-ID: <ZU4P45t-mDoyItg3@FVFF77S0Q05N>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
 <169945347160.55307.1488323435914144870.stgit@devnote2>
 <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 08:14:52AM +0900, Masami Hiramatsu wrote:
> On Wed,  8 Nov 2023 23:24:32 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > To clarify what will be expected on ftrace_regs, add a comment to the
> > architecture independent definition of the ftrace_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - newly added.
> > ---
> >  include/linux/ftrace.h |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index e8921871ef9a..b174af91d8be 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -118,6 +118,31 @@ extern int ftrace_enabled;
> >  
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  
> > +/**
> > + * ftrace_regs - ftrace partial/optimal register set
> > + *
> > + * ftrace_regs represents a group of registers which is used at the
> > + * function entry and exit. There are three types of registers.
> > + *
> > + * - Registers for passing the parameters to callee, including the stack
> > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > + * - Registers for passing the return values to caller.
> > + *   (e.g. rax and rdx on x86_64)
> > + * - Registers for hooking the function return including the frame pointer
> > + *   (the frame pointer is architecture/config dependent)
> > + *   (e.g. rbp and rsp for x86_64)
> 
> Oops, I found the program counter/instruction pointer must be saved too.
> This is used for live patching. One question is that if the IP is modified
> at the return handler, what should we do? Return to the specified address?

I'm a bit confused here; currently we use fgraph_ret_regs for function returns,
are we going to replace that with ftrace_regs?

I think it makes sense for the PC/IP to be the address the return handler will
eventually return to (and hence allowing it to be overridden), but that does
mean we'll need to go recover the return address *before* we invoke any return
handlers.

Thanks,
Mark.
