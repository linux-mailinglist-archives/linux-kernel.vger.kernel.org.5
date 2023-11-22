Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5837F527C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKVVU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjKVVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:20:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D5CD47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:20:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7866AC433C7;
        Wed, 22 Nov 2023 21:20:35 +0000 (UTC)
Date:   Wed, 22 Nov 2023 16:20:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Lowell <nicholas.lowell@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Subject: Re: [PATCH v2] trace: tracing_event_filter: fast path when no
 subsystem filters
Message-ID: <20231122162051.661981fe@gandalf.local.home>
In-Reply-To: <CAFEqNJ3PE6_u-q41Jw=-p7PrNBLT0Lr_n87WiY_2UctOJrDmZA@mail.gmail.com>
References: <20231002144149.1325-1-Nicholas.Lowell@gmail.com>
        <20231003223003.675bd888@gandalf.local.home>
        <CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
        <20231004105339.5f948a96@gandalf.local.home>
        <CAFEqNJ3PE6_u-q41Jw=-p7PrNBLT0Lr_n87WiY_2UctOJrDmZA@mail.gmail.com>
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

On Thu, 12 Oct 2023 16:37:35 -0400
Nick Lowell <nicholas.lowell@gmail.com> wrote:

Sorry, I was traveling when this was sent, and I missed it.


> I really appreciate the continued feedback.  I was able to reproduce.
> I think I'm understanding better but still need some help.
> I am actually wondering if remove_filter_string(system->filter) should

You mean to return true if filter->filter_string was not NULL?

> also return bool as an OR'd input for sync.
> Should it be something like this?
> 
>         if (!strcmp(strstrip(filter_string), "0")) {
> -               filter_free_subsystem_preds(dir, tr);
> -               remove_filter_string(system->filter);
> +              bool sync;

I would just make this an int;

> +
> +              sync = filter_free_subsystem_preds(dir, tr);
> +              sync = sync || remove_filter_string(system->filter);

And then just have:

		sync |= remove_filter_string(system->filter);

>                 filter = system->filter;
>                 system->filter = NULL;
> -               /* Ensure all filters are no longer used */
> -               tracepoint_synchronize_unregister();
> +              /* If nothing was freed, we do not need to sync */
> +              if(sync) {
> +                      /* Ensure all filters are no longer used */
> +                      tracepoint_synchronize_unregister();
> +              }
>                 filter_free_subsystem_filters(dir, tr);
>                 __free_filter(filter);
>                 goto out_unlock;
> 
> > Maybe even pass in "sync" to the filter_free_subsystem_filters() to make
> > sure there were nothing to be freed, and do the WARN_ON_ONCE() then.
> >
> >                 __free_filter(filter);
> >                 goto out_unlock;
> >         }
> >
> > -- Steve  
> 
> I'm not sure if I see the reasoning for the WARN_ON_ONCE() in
> filter_free_subsystem_filters()
> because it ends up checking the same if(!filter) just like
> filter_free_subsystem_preds() did earlier. It doesn't
> seem to do anything with system->filter.  I actually wonder if !sync,
> could filter_free_subsystem_filters()
> be skipped altogether.  Help me if I'm missing something.

The point is, code always changes. It's a bug if one of the filters had
content in filter_free_subsystem_filters() and sync is 0, hence the
WARN_ON_ONCE() if it does.

WARN_ON*()s are added to make sure the code is acting the way it is expected
to act. Yes, it should never trigger, but if it does, we know there's a bug
somewhere.

-- Steve
