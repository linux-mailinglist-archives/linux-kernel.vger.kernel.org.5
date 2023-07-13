Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF575253B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGMOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGMOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41426AF;
        Thu, 13 Jul 2023 07:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E89612FB;
        Thu, 13 Jul 2023 14:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48387C433C7;
        Thu, 13 Jul 2023 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689258857;
        bh=VvRbrk8bzF6109xHYWtz9ezHyRLP7zONTWaQbd9M5+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qAzSsJGWCo8M/UTeczkxEqABOWcuExVLij5rg1JFd9aP9lB0oCPJzGsXxxVIFD9av
         uqHktUuAgnhr2cor/YRx1JQv2qGC4yOvZqDXRgcpuyizI2MA/aB4oRIdEZKzeEy0cU
         K702mrMtLVHXbZ0MBFJ8tEACV34J1WxImIqk43MCcKG7ISZ0WPsP0xUPRuqUYh80Su
         /H9SAQmLM1K/8s+M7c6/hI1+41xRMAcfxe7ziFKOmWvCuTM4LGTOgVPTUABuwqhdAY
         LrvRe39QX3dH9HzuYEQObeacvZR+e+x4uSIXCar+BcBe22I0RdwuCf2omav3EtUYNT
         +5F1fmMtgtIUg==
Date:   Thu, 13 Jul 2023 23:34:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] tracing/probes: Fix to update dynamic data
 counter if fetcharg uses it
Message-Id: <20230713233413.2a54de15175527e12984ff6e@kernel.org>
In-Reply-To: <20230713093436.0241ed77@gandalf.local.home>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
        <168908494781.123124.8160245359962103684.stgit@devnote2>
        <20230713093436.0241ed77@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

On Thu, 13 Jul 2023 09:34:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jul 2023 23:15:48 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to update dynamic data counter ('dyndata') and max length ('maxlen')
> > only if the fetcharg uses the dynamic data. Also get out arg->dynamic
> > from unlikely(). This makes dynamic data address wrong if
> > process_fetch_insn() returns error on !arg->dynamic case.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Link: https://lore.kernel.org/all/20230710233400.5aaf024e@gandalf.local.home/
> > Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you! I'll pull this series. 

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_probe_tmpl.h |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > index ed9d57c6b041..185da001f4c3 100644
> > --- a/kernel/trace/trace_probe_tmpl.h
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -267,11 +267,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
> >  		if (unlikely(arg->dynamic))
> >  			*dl = make_data_loc(maxlen, dyndata - base);
> >  		ret = process_fetch_insn(arg->code, rec, dl, base);
> > -		if (unlikely(ret < 0 && arg->dynamic)) {
> > -			*dl = make_data_loc(0, dyndata - base);
> > -		} else {
> > -			dyndata += ret;
> > -			maxlen -= ret;
> > +		if (arg->dynamic) {
> > +			if (unlikely(ret < 0)) {
> > +				*dl = make_data_loc(0, dyndata - base);
> > +			} else {
> > +				dyndata += ret;
> > +				maxlen -= ret;
> > +			}
> >  		}
> >  	}
> >  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
