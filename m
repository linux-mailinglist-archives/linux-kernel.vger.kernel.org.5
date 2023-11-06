Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9657E183E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKFBGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:05:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D6D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 17:05:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C293EC433C8;
        Mon,  6 Nov 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699232755;
        bh=UfrmHYAckoHJxYOMbqXLSDZEhJ9cF93AOlJeMYEmPL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqRAjlrapexsBNLg2I7qk9HJjN1c2zT5goRAXh1xs7eXKs0n9mCGDZJcnbwLPlWJF
         EhVlgvNtUtAhaOpqM5zvORosLRikHp4YhIXtNet8pa3YMFyZZ+oFuN4eq+MxZlx4QF
         pwGsImIXU6O+DeLJHtP7xbYZtJqsvCMa7WXZbEmipSsZ742F2n6xMNgdR5jY1Mx8lh
         w0owf4MDhPLaHBquwObmUi7ZXGL5UDbGTGfQsMBA6fLa3EI4uR1hTUqXlUp+X1EOvz
         IrHC7oHxDu9M7ZJeKr6Z+3nVtGSJN3vFn4M01TENhyUWvQiCaIR8MZUNpbruMdoQDK
         GwGH92zFAxyEg==
Date:   Mon, 6 Nov 2023 10:05:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231106100549.33f6ce30d968906979ca3954@kernel.org>
In-Reply-To: <20231105183301.38be5598@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2023 18:33:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 6 Nov 2023 00:17:34 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Changelog nor code made it clear this was partial anything. So this is
> > still the partial thing?
> > 
> > Can we then pretty clear clarify all that, and make it clear which regs
> > are in there? Because when I do 'vim -t ftrace_regs' it just gets me a
> > seemingly pointless wrapper struct, no elucidating comments nothingses.
> 
> I agree it should be better documented (like everything else). The
> ftrace_regs must have all the registers needed to produce a function's
> arguments. For x86_64, that would be:
> 
>   rdi, rsi, rdx, r8, r9, rsp
> 
> Basically anything that is needed to call mcount/fentry.

Oops, I found I missed to save rsp. let me update it.

Anyway, this will be defined clearly. ftrace_regs needs to be a partial
set of registers related to the (kernel) function call.

 - registers which is used for passing the function parameters in
   integer registers and stack pointer (for parameters on memory).

 - registers which is used for passing the return values.

 - call-frame-pointer register if exists.

So for x86-64,

 - rdi, rsi, rcx, rdx, r8, r9, and rsp
 - rax and rdx
 - rbp

(BTW, why orig_rax is cleared?)

> But yes, it's still partial registers but for archs that support
> FTRACE_WITH_REGS, it can also hold all pt_regs which can be retrieved
> by the arch_ftrace_get_regs(), which is why there's a pt_regs struct in
> the x86 version. But that's not the case for arm64, as
> arch_ftrace_get_regs() will always return NULL.

The major reason of the DYNAMIC_FTRACE_WITH_REGS is livepatch and
kprobe on ftrace (if kprobe puts probe on the ftrace address, it uses
ftrace instead of breakpoint).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
