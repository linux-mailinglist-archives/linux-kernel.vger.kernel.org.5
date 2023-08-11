Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7C77851E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjHKBvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKBvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE56211D;
        Thu, 10 Aug 2023 18:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CFB64AAA;
        Fri, 11 Aug 2023 01:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F9AC433C8;
        Fri, 11 Aug 2023 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691718666;
        bh=7T2vtY0MAQ/ZtD7sCbaGX/zfnPEIzR5MK5HyuSqAI74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qzFBlB+i83ceRP2EFfvqch3LkjxmSUzDF4eTqNCTpLTn5olwbhd90hTyO1uLALrXH
         nPXGEsMFrdVtleftSAKk4C6luXEt+apjheuSNggIfkAFlVY1Au2SETAmigidzvEObL
         GMs6QUTrenzjiyoA/z45Bey/uQVgsTNart5joDnFplVHm1qm82ZeHI92En8ar6K16b
         20ceTaF4Xbn537xCAcMI3p/i9x3Uzdz1rJoYX62TT1lrLmbYm3RZHWaFMgZYa6b9Zt
         EN0PEo4PAMBWOiWg/B1p7bsk361A357kZN+jchWxrEO1ybRjg4O3VRbnveZO1q21l6
         JpsnLJsPFuQig==
Date:   Fri, 11 Aug 2023 10:51:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Iterate trace_eprobe directly
Message-Id: <20230811105102.f7c1a2d08700df1c226f096f@kernel.org>
In-Reply-To: <20230810193204.cae5808af79bbcc80b88ff77@kernel.org>
References: <20230810082523.244397-1-nashuiliang@gmail.com>
        <20230810193204.cae5808af79bbcc80b88ff77@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 19:32:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 10 Aug 2023 16:25:23 +0800
> Chuang Wang <nashuiliang@gmail.com> wrote:
> 
> > Refer to the description in [1], we can skip "container_of()" following
> > "list_for_each_entry()" by using "list_for_each_entry()" with
> > "struct trace_eprobe" and "tp.list".
> > 
> > [1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/
> > 
> 
> Good point. BTW, it is better to have 'for_each_eprobe(ep)' if it repeats 3 times.

Wait, it is for each trace_eprobe on the trace_probe.

#define for_each_trace_eprobe_on_trace_probe(ep, _tp)
	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)

Thank you,

> 
> 
> > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> 
> This is not a bug, so no need Fixes tag.
> 
> Thank you,
> 
> > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > ---
> >  kernel/trace/trace_eprobe.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index a0a704ba27db..d68d660dff7c 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -640,7 +640,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
> >  static int enable_trace_eprobe(struct trace_event_call *call,
> >  			       struct trace_event_file *file)
> >  {
> > -	struct trace_probe *pos, *tp;
> > +	struct trace_probe *tp;
> >  	struct trace_eprobe *ep;
> >  	bool enabled;
> >  	int ret = 0;
> > @@ -662,8 +662,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
> >  	if (enabled)
> >  		return 0;
> >  
> > -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > -		ep = container_of(pos, struct trace_eprobe, tp);
> > +	list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
> >  		ret = enable_eprobe(ep, file);
> >  		if (ret)
> >  			break;
> > @@ -680,8 +679,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
> >  			 */
> >  			WARN_ON_ONCE(ret != -ENOMEM);
> >  
> > -			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > -				ep = container_of(pos, struct trace_eprobe, tp);
> > +			list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
> >  				disable_eprobe(ep, file->tr);
> >  				if (!--cnt)
> >  					break;
> > @@ -699,7 +697,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
> >  static int disable_trace_eprobe(struct trace_event_call *call,
> >  				struct trace_event_file *file)
> >  {
> > -	struct trace_probe *pos, *tp;
> > +	struct trace_probe *tp;
> >  	struct trace_eprobe *ep;
> >  
> >  	tp = trace_probe_primary_from_call(call);
> > @@ -716,8 +714,7 @@ static int disable_trace_eprobe(struct trace_event_call *call,
> >  		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
> >  
> >  	if (!trace_probe_is_enabled(tp)) {
> > -		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > -			ep = container_of(pos, struct trace_eprobe, tp);
> > +		list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
> >  			disable_eprobe(ep, file->tr);
> >  		}
> >  	}
> > -- 
> > 2.39.2
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
