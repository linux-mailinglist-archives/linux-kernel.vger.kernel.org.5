Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F807B3FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjI3JTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3JTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:19:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5FB4;
        Sat, 30 Sep 2023 02:19:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539E7C433C8;
        Sat, 30 Sep 2023 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696065546;
        bh=CVvQtHQSyndyWy/FagrIZcZBd171yHX/jAjEOxkaFf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fcQPwglQGQcQUubS/I9/SDHwTgwAtWcUJE/A/+7/Apn5w/5MSfMm+yUXs0mGXrpcO
         UZvuFt3yb/qYJmKf8dOOkp1eIBGyTUQokCOp+JHlURL5jZWdi7VLTRrrYuNL2bP5PU
         AxsMcFnAA9B//ObS3Chbf437dPquqf9tF66fq4KZcwfaHfMSXRvgcKiIpF3KD69iAW
         oBx4eKq9Fpizt0UmpjIXBC4ycRKhyS3cowb1PbvufahsVkrTxnXlp9HkKaL8fTmaA6
         NqoSVSuLDXgJNKqYIZWlLRG8oniRZUNHxvl2StD3JL6YxvzdBNbhyJh5j3X9yPZIzF
         ELobq111PNfRg==
Date:   Sat, 30 Sep 2023 18:19:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
Message-Id: <20230930181902.eb1d089243deca0017046437@kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2309291336260.3137@hadrien>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr>
        <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
        <alpine.DEB.2.22.394.2309291336260.3137@hadrien>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 13:37:08 +0200 (CEST)
Julia Lawall <julia.lawall@inria.fr> wrote:

> 
> 
> On Fri, 29 Sep 2023, Masami Hiramatsu  wrote:
> 
> > On Thu, 28 Sep 2023 12:43:34 +0200
> > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > > Drop break after return.
> > >
> >
> > Good catch! This looks good to me.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > And
> >
> > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> 
> Thanks.  I didn't include that because it's not a bug.  But it does break
> Coccinelle, which is how I noticed it.

OK, I got it. I thought it may cause a compiler warning because the
'break' never be executed. (maybe it is just a flow-control word,
so it may not need to be warned, but a bit storange.)

> 
> julia
> 
> >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > >
> > > ---
> > >  kernel/trace/trace_eprobe.c |    5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > > index 72714cbf475c..03c851f57969 100644
> > > --- a/kernel/trace/trace_eprobe.c
> > > +++ b/kernel/trace/trace_eprobe.c
> > > @@ -788,12 +788,9 @@ find_and_get_event(const char *system, const char *event_name)
> > >  		name = trace_event_name(tp_event);
> > >  		if (!name || strcmp(event_name, name))
> > >  			continue;
> > > -		if (!trace_event_try_get_ref(tp_event)) {
> > > +		if (!trace_event_try_get_ref(tp_event))
> > >  			return NULL;
> > > -			break;
> > > -		}
> > >  		return tp_event;
> > > -		break;
> > >  	}
> > >  	return NULL;
> > >  }
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
