Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3517E87DD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjKKBoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbjKKBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:44:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FC44B5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:44:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1ADC433C7;
        Sat, 11 Nov 2023 01:44:16 +0000 (UTC)
Date:   Fri, 10 Nov 2023 20:44:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 26/31] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20231110204422.05ac4581@gandalf.local.home>
In-Reply-To: <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945376173.55307.5892275268096520409.stgit@devnote2>
        <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 16:17:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	used = 0;
> > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > +		if (node->addr != func)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (!fp || fprobe_disabled(fp))
> > +			continue;
> > +
> > +		if (fprobe_shared_with_kprobes(fp))
> > +			ret = __fprobe_kprobe_handler(func, ret_ip,
> > +					fp, fregs, fgraph_data + used);
> > +		else
> > +			ret = __fprobe_handler(func, ret_ip, fp,
> > +					fregs, fgraph_data + used);  
> 
> 
> Since the fgraph callback is under rcu-locked but not preempt-disabled,

rcu-locked? The only rcu-locked is task rcu.

> fprobe unittest fails. I need to add preempt_disable_notrace() and
> preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
> also access to per-cpu variable, so it requires to disable preemption.


Just around the __fprobe_*handler()? Or the loop?

-- Steve
