Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD87E54A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjKHLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKHLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:01:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E0101
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:01:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B40C433C7;
        Wed,  8 Nov 2023 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699441313;
        bh=+R6IRRsGnNFGnMhbq9xit7QVk0XL4ypGTQcZDA737NY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V5Q02HL3IXtlPK9z6kq55ayWhIbUmg2Lv/i6XaoQJwSbbePbFimAkKoZmSSceJrsI
         NxzuAilkBkE6kFjdAcLtlAGvt/Uagh57tEbNCP0pdOQRWAyDXEAw+eEl1rez31z0oH
         trS9HezYVSubeiBPFz8/SnYp/XgaTRJwSIUjFVgINmE0nzCYuekX8BB8nkWQ7qbYvA
         Ao9lgvuJj0hZwrryP2UTVKvgqKWhYbKswHjc+HJXCSDoN17wAFJu6hugaWo5EOOPid
         GIF2H36Ze0gtkikeJLk634XGavud4xt+0YtrZvnrvQhaYaVp3/ojize+ANR+xO+emQ
         cVFAcUjvFt/bw==
Date:   Wed, 8 Nov 2023 20:01:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe-event: Fix to check tracepoint event
 and return
Message-Id: <20231108200150.69541f243099eb6128ba4554@kernel.org>
In-Reply-To: <20231107094045.db1d982c42712b8f26891ec6@kernel.org>
References: <169902753361.313086.6662802092416198593.stgit@devnote2>
        <20231106172811.25066d33@gandalf.local.home>
        <20231107094045.db1d982c42712b8f26891ec6@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 09:40:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 6 Nov 2023 17:28:11 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat,  4 Nov 2023 01:05:34 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Fix to check the tracepoint event is not valid with $retval.
> > > The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
> > > a return event by $retval") introduced automatic return probe
> > > conversion with $retval. But since tracepoint event does not
> > > support return probe, $retval is not acceptable.
> > 
> > Can you add the command that causes this to fail.
> 
> Actually this doesn't command fail but it expected to fail.
> 
> $ echo "t kfree $retval" >> dynamic_events

Wait, with some configuration, this doesn't cause a problem.
Let me try to reproduce the issue...

Thank you,

> 
> This should be rejected because 't' (tracepoint) should not be
> a return probe. Without this fix, this is accepted.
> (But it traces a random return value because the tracepoint function
> will return 'void'.)
> 
> Thank you,
> 
> > 
> > -- Steve
> > 
> > > 
> > > Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  kernel/trace/trace_fprobe.c |    9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > > index 8bfe23af9c73..7d2ddbcfa377 100644
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -927,11 +927,12 @@ static int parse_symbol_and_return(int argc, const char *argv[],
> > >  	for (i = 2; i < argc; i++) {
> > >  		tmp = strstr(argv[i], "$retval");
> > >  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> > > +			if (is_tracepoint) {
> > > +				trace_probe_log_set_index(i);
> > > +				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> > > +				return -EINVAL;
> > > +			}
> > >  			*is_return = true;
> > > -			/*
> > > -			 * NOTE: Don't check is_tracepoint here, because it will
> > > -			 * be checked when the argument is parsed.
> > > -			 */
> > >  			break;
> > >  		}
> > >  	}
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
