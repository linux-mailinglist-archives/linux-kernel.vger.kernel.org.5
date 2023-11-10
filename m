Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC47E77DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbjKJDJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:09:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C5D44B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:09:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E6FC433C7;
        Fri, 10 Nov 2023 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699585791;
        bh=T5JFCl6pmHxnPp19gCV70nzGUuLkfaMSJI9G9sJJ8RE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kgyhaT0qs0lzlsqe+KNr9Xx965v8ny0bpvbcDRvKzPFEjJUVERxIVB61e4tlKnM3p
         on+ySaG2yFlyBK5VLpRc0fBzFjL7Zpe7+STCn5W9fJyK/7R6TKmr2n2YqysqxjpERE
         tHsDk9EyelY6zp7gWmRHO2iNczkUGAuxHAXTrxguie3RJP6U1EaemZRyjcsu/y0oTP
         AQnM5qWOyfmxmOB/jVFvd0MBO63uLHoOtqlYJ4BQ3t2kMEsJJHVTSaAVpTYEz7XFzw
         Am96XC45QSCv0Ors/JcPlr8Eo7MuYBX/a13MmP98xiZDpvvB7IX54ubTr9gqrjcWwo
         xIEi07Gh3nabw==
Date:   Fri, 10 Nov 2023 12:09:45 +0900
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
Subject: Re: [RFC PATCH v2 12/31] function_graph: Have the instances use
 their own ftrace_ops for filtering
Message-Id: <20231110120945.749393c36bdee5fe9bd2d257@kernel.org>
In-Reply-To: <20231109211848.10a5e224@gandalf.local.home>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945360154.55307.2938894711228282149.stgit@devnote2>
        <20231110105154.df937bf9f200a0c16806c522@kernel.org>
        <20231109211848.10a5e224@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 21:18:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Nov 2023 10:51:54 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So this patch registers ftrace_ops for each fgraph_ops to ftrace.
> > This means that the ftrace_graph_func() will be called twice or more
> > on the same function.
> > Thus should I call ftrace_startup() once when the first fgraph_ops
> > is registered? 
> > No, it's not enough. Actually each fgraph_ops can have different filters.
> > We need to define a shared filter and combine new filters to one and
> > use it. We also need to do it when a fgraph is unregistered.
> > 
> > Is there any function which makes a new filter from two (or more) filters?
> 
> So I'm guessing that we need to have a fgraph_set_filter*() operations?
> 
> When one gets added, it needs to update the ftrace_ops to include the added
> functions. Or we need to have a way to create a new hash from all the
> registered fgraph_ops, and have that for the ftrace_ops. Then when it gets
> called, if it has more than one registered function, it needs to iterate
> over the list?

Yes, that is one option, update a global common hash and introduce a new
common ftrace function to run function_graph_enter().

Or, I think keep the current one but iterate ftrace_ops to callback the
function_graph_enter() with ftrace_ops. Then we can get appropriate
fgraph_ops. Ftrace push return trace can skip pushing if ret == return_to_handler.
(maybe this is better to reuse ftrace)

Thank you,

> 
> -- Steve
> 
> 
> > 
> > Or, maybe we can make the common callback to find the previous ret entry on
> > the ret_stack and reuse it. (In this case we don't need loop on each
> > fgraph_array entry)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
