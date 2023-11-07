Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279C47E34F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjKGFno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjKGFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:43:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570B124
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:43:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F43C433C7;
        Tue,  7 Nov 2023 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699335812;
        bh=ZjCW8mn+WzSc8W2ku8xQ1P6bpGEosFP1Q+Pzo/jsu2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjyH0wDe0oDtiIOwS9+037THfI23Qg7eC47ZeuyigIfTzrLjZxQ5f2yufpj+EKPmZ
         /VpX+Iy2mgxC9km1jhBFskyZdf3W3rT7JRrbrOdrQDiQz54cEvPpFs8pOIswNtG0Fh
         CPLdbFB/M42woObZYUAIPrHAp3VFA5UA2T58ShaZyl7HdtX6z2rokmMLOGf3guySwX
         Kq8jCffiYPrixWIZBGmeGeYM8gPEa3+beLteCGByQ1VX9OH+37rqdEkF+8xlSeLQD/
         F4xsD16R7Pzw1hMF+b/IeI7AZUbIH0y8kL/MAiW0yRH4SXqewg2Ggw/zdwfr+7ffCI
         G+d5s0PC8CsGA==
Date:   Tue, 7 Nov 2023 14:43:28 +0900
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
Message-Id: <20231107144328.cc763a2a137391ceb105e9db@kernel.org>
In-Reply-To: <20231106220617.5eb73f2f@gandalf.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231106100549.33f6ce30d968906979ca3954@kernel.org>
        <20231106113710.3bf69211@gandalf.local.home>
        <20231107094258.d41a46c202197e92bc6d9656@kernel.org>
        <20231106220617.5eb73f2f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 6 Nov 2023 22:06:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 7 Nov 2023 09:42:58 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Got it. So does ftrace_regs need a placeholder for direct trampoline?
> > (Or, can we use a register to pass it?)
> > I think we don't need to clear it for return_to_handler() but if
> > `ftrace_regs` spec requires it, it is better to do so.
> 
> It's per arch defined. I think I wrote somewhere that it just needs to pass
> back something that can tell if the handler is to return to a direct
> trampoline or not. It could be a unused register, or something else.

Oh, I meant the flag (address) for "return" trampoline. If we have
direct "return" trampoline we may use it, but currently not.

> 
> It's only needed if an architecture supports direct trampolines.

I see, and x86_64 needs it.
OK, maybe better to keep it clear on x86-64 even on the
return handler.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
