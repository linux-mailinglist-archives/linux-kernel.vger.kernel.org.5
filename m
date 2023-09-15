Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAE7A20A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjIOOQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIOOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:16:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AD273A;
        Fri, 15 Sep 2023 07:16:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E48C433CA;
        Fri, 15 Sep 2023 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787377;
        bh=ru8tGJUMG8yYiEDFTkvWeohG0fXAiA5ifieOx/juvSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LTyhGJTl74L4dnnRMIcnpe2zU4OBFkM/FjRbjzCJG+llEOnFGKu4Zh1dQEiUdre5G
         pTWah8V3sT2Fzk92srjN9nTHAz383Pgy06d7VxtT1A8IQE4ucRptGb11ObdsDXnzoY
         +0eu/l0RVcP6wBxTCrMhAP7BDPxxQUdPdvjurTS97bquQayvhuTzFIIUJliTaNfyZl
         EW3UxFNmLB3xV0+uN+KIZviuWyKt60/jznSmVr07wvXYG/tHyNVy2m6ob9dFR2OBX4
         Bfe6jlOSijvNBa6ONrnzHgnRAvbFbwwUGIwf/ZGRisiz7hUHKBjUB/Jd7IA5rOTjyg
         r8R6i1EHgZ9Bg==
Date:   Fri, 15 Sep 2023 23:16:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: Print out u64 values properly
Message-Id: <20230915231613.6cb9372d9304c313dab462ea@kernel.org>
In-Reply-To: <11672c6d-e021-eeda-5907-3fefb307ce9d@linux.intel.com>
References: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
        <20230915150101.ef50c4774ab85aa2ff7431ec@kernel.org>
        <11672c6d-e021-eeda-5907-3fefb307ce9d@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Fri, 15 Sep 2023 13:46:45 +0300
Tero Kristo <tero.kristo@linux.intel.com> wrote:

> Hi Masami,
> 
> On 15/09/2023 09:01, Masami Hiramatsu (Google) wrote:
> > Hi Tero,
> >
> > On Mon, 11 Sep 2023 17:17:04 +0300
> > Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >
> >> The synth traces incorrectly print pointer to the synthetic event values
> >> instead of the actual value when using u64 type. Fix by addressing the
> >> contents of the union properly.
> > Thanks for pointing it out.
> > But I would like to see a new "case 8:" print code instead of changing
> > "default". Can you keep the default as it is and add "case 8:" case there?
> 
> Are you sure about that? I think keeping the default as is would just 
> print out a useless pointer value to the synth event itself (which is 
> what happened with u64 type.)

Yeah, I think the "default" here means no correct way to show the value
in it. So anyway, if we know the size is 8 and there is val->as_u64,
there should be "case 8:".

> 
> Anyways, that requires a new patch to be created on top as this has hit 
> the mainline as a fix already.

Oops, I missed that.

Thank you!

> 
> -Tero
> 
> 
> >
> > Thanks,
> >
> >> Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> >> ---
> >>   kernel/trace/trace_events_synth.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> >> index 7fff8235075f..070365959c0a 100644
> >> --- a/kernel/trace/trace_events_synth.c
> >> +++ b/kernel/trace/trace_events_synth.c
> >> @@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
> >>   		break;
> >>   
> >>   	default:
> >> -		trace_seq_printf(s, print_fmt, name, val, space);
> >> +		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
> >>   		break;
> >>   	}
> >>   }
> >> -- 
> >> 2.40.1
> >>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
