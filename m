Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2373E780A95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376485AbjHRK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376511AbjHRK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B830C2;
        Fri, 18 Aug 2023 03:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0504860FE6;
        Fri, 18 Aug 2023 10:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC1C433C8;
        Fri, 18 Aug 2023 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356212;
        bh=9oY74fYSA4+vLUvp/0gaPD0ITuj0lxnMOmvhMy0eQTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pq1x3SchFdbhb6fHMNxkIPyR/qmmjI6fy/vPCEtLdNWFF6y9nWXDfGk8CU5qr8IHt
         1xjuYuop2pci3ZzZvr3EjHBEr4iMpJTnkdx0mehDqJgjViacLDv8/6oYuQA7WseGsJ
         ezjRTDFhNFOvv4JMqTnUMmzuCUFQxJw5XngQ5OZMwXaMFlgIbWE0zm6oUuxbUQzmSx
         wyW19yIoibgZT2jMCuNYkLLfA8zOKNfXHV8wsdovf8UBwZMgmsPf+7jH/XN11XHHBs
         N0TqxUbafMBonQtt/VYxh/ut0OQj7iQYFY3TD0maCw1QZ2DyFulN8gqvmNCg9gnWZY
         CyIAjYMgsTdCA==
Date:   Fri, 18 Aug 2023 19:56:45 +0900
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
Subject: Re: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
Message-Id: <20230818195645.6d5b71f339b71c4f217c9a8c@kernel.org>
In-Reply-To: <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
        <169181861911.505132.8322840504168319403.stgit@devnote2>
        <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 10:57:26 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
> >  fs_initcall(bpf_event_init);
> >  #endif /* CONFIG_MODULES */
> >
> > -#ifdef CONFIG_FPROBE
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> 
> Shouldn't this be #if defined(CONFIG_FPROBE) &&
> defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) ?

Oops, that's right!

> 
> I believe one could build a kernel with FTRACE_WITH_REGS and without
> FPROBE and then this code would have undefined references to fprobe
> functions, wouldn't it ?

Yeah, ftrace with regs doesn't mean fprobe is enabled.

> 
> And then patch 7 should be "Enable kprobe_multi feature even if
> FTRACE_WITH_REGS is disabled"

OK.

Thank you!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
