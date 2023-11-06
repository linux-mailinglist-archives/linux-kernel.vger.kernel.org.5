Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910C7E2257
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjKFMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjKFMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:53:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3CBD;
        Mon,  6 Nov 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d7JIE/1D3Ga6c+JTVVNZxpCgazNnMt6mFtB/dDS9GUM=; b=myycUMlvg6YWS07kbUyVxY8NEg
        i6GijSiiQz1Q5ipUKSaw6uxW520hXeuSRQZdQRO9EPC0b5+SCC0AEyRVI6kKQvSy+f+ISJ9ZKpm72
        NeOTPm+A4VGovEsIZktwGet2L4ZyZ9Lkcf7k4oT2a07cWH6bUKILpi3GLREmlDa3bnfqzotYv0nOD
        wW4ovbA9V6lJKrhHkCOthsv4dE0JKe0tXq0FXGgtDj1wa1MMXF9aTEe5CbOt7OUG+TbG0hW//MqBV
        1euoqAqA2LhsyycPvIjcakbEGzyQhZKXMi3xmcV8TnnEN+D48GAFPkD2Vj+zaErLhPQA0KDbhOEvl
        1zRJlpbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzz5u-0060hL-Mm; Mon, 06 Nov 2023 12:52:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FCF430049D; Mon,  6 Nov 2023 13:52:43 +0100 (CET)
Date:   Mon, 6 Nov 2023 13:52:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20231106125243.GN8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
 <20231105172536.GA7124@noisy.programming.kicks-ass.net>
 <20231105141130.6ef7d8bd@rorschach.local.home>
 <20231105231734.GE3818@noisy.programming.kicks-ass.net>
 <20231105183301.38be5598@rorschach.local.home>
 <20231105183409.424bc368@rorschach.local.home>
 <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
 <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
 <20231106214708.d132cfd9984beac55e4b420e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106214708.d132cfd9984beac55e4b420e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:47:08PM +0900, Masami Hiramatsu wrote:
> On Mon, 6 Nov 2023 11:19:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> > > On Sun, 5 Nov 2023 18:34:09 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Sun, 5 Nov 2023 18:33:01 -0500
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > 
> > > > > For x86_64, that would be:
> > > > > 
> > > > >   rdi, rsi, rdx, r8, r9, rsp
> > > > 
> > > > I missed rcx.
> > > 
> > > I would like to add rax to the list so that it can handle the return value too. :)
> > 
> > So something like so?
> > 
> > 
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 897cf02c20b1..71bfe27594a5 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  
> >  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  struct ftrace_regs {
> > +	/*
> > +	 * Partial, filled with:
> > +	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp
> 
> Don't we need rbp too? (for frame pointer)

/me goes stare at ftrace_64.S, and yes it appears it fills out rbp too.


