Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A076B672
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHAN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHAN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B009EC;
        Tue,  1 Aug 2023 06:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97E7615B3;
        Tue,  1 Aug 2023 13:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C7C433C7;
        Tue,  1 Aug 2023 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690898182;
        bh=I1Ij8BnJcW1tW2XqkFNyuQvGHApl5ATLxgJtVhkT/RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5UkqO1j+YNAkk8BaP6R0JIJM6lQ6RsuTaRSDKst877eWmclYtS9Y7u0ounhOGwEM
         bwMGFP+sEgdW8U+TEqMWFVumshxJ8tNULHuTjxLslr83TzlQuBUFfoIhtX/b8Iz8nA
         faspREvIXl2/5lLqiunpmKc/uqo4nCh37P1YpIvZfSrfIpXto5XxcSE8OftbJUjDdz
         t30WuHEDDCYionvd/rwZf9lySlO/67/M7TRgv90MwZjvOHxZaUFNFIMWxIliZfYeS9
         yFyS2HC2oqHGpN1j22kbWhSEMBItHQgn3MPM4eLZ6ZUNL23t44+mo1cvoPMNYA7G8V
         qGdZa1rN+eBTA==
Date:   Tue, 1 Aug 2023 22:56:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Show correct error about @symbol for uprobe
Message-Id: <20230801225618.06cb86992ae30564e5b87554@kernel.org>
In-Reply-To: <ZMkAq5yx3+EiQNkF@kernel.org>
References: <169055397023.67089.12693645664676964310.stgit@devnote2>
        <ZMkAq5yx3+EiQNkF@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(To: Oleg)

On Tue, 1 Aug 2023 09:55:07 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Jul 28, 2023 at 11:19:30PM +0900, Masami Hiramatsu (Google) escreveu:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since @symbol variable access is not supported by uprobe event, it must be
> > correctly warn user instead of kernel version update.
> 
> Thanks, less cryptic now, applied.
> 
> But is that just a matter of writing code to support reading global
> variables from an uprobe?

Hm, maybe we can use "@+offset" for accessing symboled data, as far as
it is loaded with the text section.
Oleg, what do you think about accessing symbols in data section from
uprobes? Can we access it from user-land IP-relative address?

Thank you,

> 
> - Arnaldo
> 
>  
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Closes: https://lore.kernel.org/all/ZLWDEjvFjrrEJODp@kernel.org/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |   13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 6e2110d605fb..c1ded85fe859 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2800,13 +2800,18 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
> >  	if (!tev->uprobes || tev->nargs == 0 || !buf)
> >  		goto out;
> >  
> > -	for (i = 0; i < tev->nargs; i++)
> > -		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
> > -			pr_warning("Please upgrade your kernel to at least "
> > -				   "3.14 to have access to feature %s\n",
> > +	for (i = 0; i < tev->nargs; i++) {
> > +		if (strchr(tev->args[i].value, '@')) {
> > +			pr_warning("%s accesses a variable by symbol name, but that is not supported for user application probe.\n",
> > +				   tev->args[i].value);
> > +			break;
> > +		}
> > +		if (strglobmatch(tev->args[i].value, "[$+-]*")) {
> > +			pr_warning("Please upgrade your kernel to at least 3.14 to have access to feature %s\n",
> >  				   tev->args[i].value);
> >  			break;
> >  		}
> > +	}
> >  out:
> >  	free(buf);
> >  }
> > 
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
