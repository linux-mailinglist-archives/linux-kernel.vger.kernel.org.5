Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC77E3252
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjKGAnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:43:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67089D73
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:43:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D448C433C7;
        Tue,  7 Nov 2023 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699317785;
        bh=ZDSZrTPjdbQ1tzVXs6DT67Wg83zVrMpSIvmICGi3DDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QTDWS6yId+pWs8EyAV7mggdfaXC2dOCCM7NJJmavNb8580+6kNUX37Nai376HiCgV
         xis7aOGWkVhB8qT/ya1PMnsmjm+CDFZrJVO+v6OV+Gf893/BD+vyqRovbVElgu5sNb
         O7JjVtE8VJpMZXbDh70Z0ro4gM0lIXU79ZFLFOSqqAbIaVX8w7Ux0fS/XJHClThXF+
         6HxdZzRB+jVcEHvmuzezJZ4HguhT7I34Pfg9+1FtF5rgJ8SRS7pB6Gd+dUzvvfP4jX
         Te8mAtiJOcgnJnNDevGfm8CK/jITfnB33qWoBHCuec5uc43IfVDv9KI6KOC0TKJzei
         cnOMazeqSMxag==
Date:   Tue, 7 Nov 2023 09:42:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-Id: <20231107094258.d41a46c202197e92bc6d9656@kernel.org>
In-Reply-To: <20231106113710.3bf69211@gandalf.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231106100549.33f6ce30d968906979ca3954@kernel.org>
        <20231106113710.3bf69211@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 11:37:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 6 Nov 2023 10:05:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So for x86-64,
> > 
> >  - rdi, rsi, rcx, rdx, r8, r9, and rsp
> >  - rax and rdx
> >  - rbp
> > 
> > (BTW, why orig_rax is cleared?)
> 
> You mean from ftrace_caller?
> 
> That's a "hack" to determine if we need to call the direct trampoline or
> not. When you have both a direct trampoline and ftrace functions on the
> same function, it will call ftrace_ops_list_func() to iterate all the
> registered ftrace callbacks. The direct callback helper will set "orig_rax"
> to let the return of the ftrace trampoline call the direct callback.

Got it. So does ftrace_regs need a placeholder for direct trampoline?
(Or, can we use a register to pass it?)
I think we don't need to clear it for return_to_handler() but if
`ftrace_regs` spec requires it, it is better to do so.

Thank you,

> 
> Remember if a direct callback is by itself, the fentry will call that
> direct trampoline without going through the ftrace trampoline. This is used
> to tell the ftrace trampoline that it's attached to a direct caller and
> needs to call that and not return back to the function it is tracing.
> 
> See later down in that file we have:
> 
> 	/*
> 	 * If ORIG_RAX is anything but zero, make this a call to that.
> 	 * See arch_ftrace_set_direct_caller().
> 	 */
> 	testq	%rax, %rax
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
