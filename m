Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15B7E2236
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKFMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjKFMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:47:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0910DD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:47:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29123C433C7;
        Mon,  6 Nov 2023 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699274836;
        bh=ZKPkoYHE+kdPCNAugjno/omWZzc7yMN7RXy8qs3DD5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=giNYOukD28FBmGEenY1xFYwWuBmV8/q/WR0g1ZPiIKOpz2FvZN1YF3y8ncXXdiXru
         ic8wuicePL6JiQY8EkJaNqGFbHqlORc90fpqo9dPUOLx0UsYqvjyZzdRJ3MPwCLFdK
         tcAycTq9JxTcslU3E8TF914Y/Srma8S+f2wajFRD4VoRF+L8YAHXW+j4klmaDZyUuE
         qxpIpfqJ8WwDtmg6D1erTp35IuKdrinzKFXNv87uTto31RmsT+TkamFExYM0eU1sjv
         elo7YvY1YyCkl7bUEGeQRzlMTgxCE3Ff5ivV3bYwZ0FVAGXZU8mFdCghMF3+kyFeXj
         BYiMAISbrqavA==
Date:   Mon, 6 Nov 2023 21:47:08 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20231106214708.d132cfd9984beac55e4b420e@kernel.org>
In-Reply-To: <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231105183409.424bc368@rorschach.local.home>
        <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
        <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 11:19:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> > On Sun, 5 Nov 2023 18:34:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Sun, 5 Nov 2023 18:33:01 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > For x86_64, that would be:
> > > > 
> > > >   rdi, rsi, rdx, r8, r9, rsp
> > > 
> > > I missed rcx.
> > 
> > I would like to add rax to the list so that it can handle the return value too. :)
> 
> So something like so?
> 
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 897cf02c20b1..71bfe27594a5 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  struct ftrace_regs {
> +	/*
> +	 * Partial, filled with:
> +	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp

Don't we need rbp too? (for frame pointer)


> +	 */
>  	struct pt_regs		regs;
>  };


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
