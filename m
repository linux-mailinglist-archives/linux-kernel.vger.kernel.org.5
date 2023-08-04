Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CC76FBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjHDIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHDIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDCD1702;
        Fri,  4 Aug 2023 01:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8922361F64;
        Fri,  4 Aug 2023 08:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD05C433CA;
        Fri,  4 Aug 2023 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691136329;
        bh=ubyMoECeBeUr7s+plEuVMhjJe7aLqEzb0m//FsbiETU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNK7cIGD+7ZnRIYjoXmILMpbaDeYInXNBKa4o19rVM6uQZ9Na8BfKluJY6o8Dwwjp
         na7Cfa0qfGhgpEAsYxvrOdZMEmw60EH/HdsCta6FXWGIecWrguZnri0rJnP9gaYJiX
         1wfTGcjDsQ2wcOmhL7+PZNG0C69+DkWW24DrWzeJikWUF2ID4orY7JWkKq7RcaZneC
         Wqfm0CVgFmz1kOuNXtzfSKPFwd+hIXDmMJTxz0niQtmWF7NO1gjltK63nV/ICoXMzv
         HW5PgvwKevQ57biUN++JYm666XhAcpa9YvJpUuMP+BLJqsv4oEEnreT7+jEKG5ThAL
         /L2jPgMRx8ciQ==
Date:   Fri, 4 Aug 2023 17:05:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Show correct error about @symbol for uprobe
Message-Id: <20230804170526.592ac8b2d2e53e37bc513c7f@kernel.org>
In-Reply-To: <20230803173106.GA15866@redhat.com>
References: <169055397023.67089.12693645664676964310.stgit@devnote2>
        <ZMkAq5yx3+EiQNkF@kernel.org>
        <20230801225618.06cb86992ae30564e5b87554@kernel.org>
        <20230803173106.GA15866@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 19:31:06 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Hi Masami,
> 
> On 08/01, Masami Hiramatsu wrote:
> >
> > Oleg, what do you think about accessing symbols in data section from
> > uprobes? Can we access it from user-land IP-relative address?
> 
> Sorry, I don't I understand... I don't even understand the context, can't
> find the whole thread on lore.kernel.org/lkml. Plus I forgot EVERYTHING
> I knew about tracing/uprobes anyway ;)

Oh, but thank you for replying :)

> 
> but when I look at traceprobe_parse_probe_arg() paths it seems to me that
> uprobe can fetch the IP-relative address, not sure about the syntax but
> perhaps something like xxx=+OFFSET(%ip). The question is how tools/perf
> can calculate this OFFSET. But I am sure you understand this all much
> better than me.

Yes, var=@+offset is the syntax. That will access the data in same file
(and maybe in the same section?)

> 
> > > > --- a/tools/perf/util/probe-event.c
> > > > +++ b/tools/perf/util/probe-event.c
> > > > @@ -2800,13 +2800,18 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
> > > >  	if (!tev->uprobes || tev->nargs == 0 || !buf)
> > > >  		goto out;
> > > >
> > > > -	for (i = 0; i < tev->nargs; i++)
> > > > -		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
> > > > -			pr_warning("Please upgrade your kernel to at least "
> > > > -				   "3.14 to have access to feature %s\n",
> > > > +	for (i = 0; i < tev->nargs; i++) {
> > > > +		if (strchr(tev->args[i].value, '@')) {
> > > > +			pr_warning("%s accesses a variable by symbol name, but that is not supported for user application probe.\n",
> > > > +				   tev->args[i].value);
> > > > +			break;
> 
> IIUC without this change @symbol will trigger the
> 
> 			/* uprobes don't support symbols */
> 			if (!(ctx->flags & TPARG_FL_KERNEL)) {
> 				trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
> 				return -EINVAL;
> 			}
> 
> in parse_probe_arg(), right?

Yes, that's right.

> 
> So FWIW the patch looks fine to me, but as you have mentioned tools/perf
> could probably (try to) turn @symbol into @+symbol_offset_in_file...

Yeah, that's a good point. Maybe I should try to find the data symbol
and find the offset. One thing I'm not sure is the address in the data section
maybe different from the address in the code section, and @+addr seems to
point the data in the code section because it calculate the offset from
the ip address.

> 
> In short, sorry for spam, I can't help ;)

No problem and thanks for your reply.

> 
> And just in case, I am on PTO till Aug 14, won't be able to read emails
> till then.
> 
> Oleg.
> 

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
