Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165087E88BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjKKDBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjKKDBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:01:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5113C0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:01:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607F4C433C7;
        Sat, 11 Nov 2023 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699671665;
        bh=2LhQYw/i4O/j2ctPROiuf3u6PzGIF0+bsBDBydGMZnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tWAMWOx4vhvFMzdCZw6QmWxI/wokCMAA5N6nkHSFK3FCHvTa950ut+pR4uCTztS4M
         groOXHFxJtReonezDIWs77kjY534etk4wnryxh7YD5hfiG5GEQgj/tYFXsHtgr+Uej
         dgzm4euuJqb46sr/ZEDFz8XekUc0FhUQQaog+FGt+p9/g9Y2A94DrNJNvenDUl/PTv
         TNfueI8VSr+gMjn4reVKUZkcGHV8n4OyihM0OGEqyb57TTZ5CoqK0fQRKXBkherQPA
         fG5OjsKU7ZlxkQEB43zEQL465PC/eZC3C2N8uxn14zV18VZMNfyhG6dn1MdVnuY/Ny
         WOZz1Tay24Z0A==
Date:   Sat, 11 Nov 2023 12:01:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20231111120100.a3cb8ffadd274bbe6f79bac9@kernel.org>
In-Reply-To: <20231110204422.05ac4581@gandalf.local.home>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945376173.55307.5892275268096520409.stgit@devnote2>
        <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
        <20231110204422.05ac4581@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 20:44:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Nov 2023 16:17:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > +	used = 0;
> > > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > > +		if (node->addr != func)
> > > +			break;
> > > +		fp = READ_ONCE(node->fp);
> > > +		if (!fp || fprobe_disabled(fp))
> > > +			continue;
> > > +
> > > +		if (fprobe_shared_with_kprobes(fp))
> > > +			ret = __fprobe_kprobe_handler(func, ret_ip,
> > > +					fp, fregs, fgraph_data + used);
> > > +		else
> > > +			ret = __fprobe_handler(func, ret_ip, fp,
> > > +					fregs, fgraph_data + used);  
> > 
> > 
> > Since the fgraph callback is under rcu-locked but not preempt-disabled,
> 
> rcu-locked? The only rcu-locked is task rcu.

Hmm, it might be my misread. But I don't get any warning from
find_first_fprobe_node(), which uses hlist_for_each_entry_rcu()
so isn't it rcu locked?

> 
> > fprobe unittest fails. I need to add preempt_disable_notrace() and
> > preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
> > also access to per-cpu variable, so it requires to disable preemption.
> 
> 
> Just around the __fprobe_*handler()? Or the loop?

Just around the __fprobe*handler().

Thank you,


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
