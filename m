Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC17B3EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjI3IEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjI3IEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFAEB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE6C433C8;
        Sat, 30 Sep 2023 08:04:03 +0000 (UTC)
Date:   Sat, 30 Sep 2023 04:03:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicholas Lowell <nicholas.lowell@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Subject: Re: [PATCH] trace: tracing_event_filter: fast path when no
 subsystem filters
Message-ID: <20230930040357.14fcbdf4@rorschach.local.home>
In-Reply-To: <20230926142058.1370-1-Nicholas.Lowell@gmail.com>
References: <20230926142058.1370-1-Nicholas.Lowell@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 10:20:58 -0400
Nicholas Lowell <nicholas.lowell@gmail.com> wrote:

> From: Nicholas Lowell <nlowell@lexmark.com>
> 
> If there are no filters in the event subsystem, then there's no
> reason to continue and hit the potentially time consuming
> tracepoint_synchronize_unregister function.  This should give
> a speed up for initial disabling/configuring
> 
> Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
> ---
>  kernel/trace/trace_events_filter.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 33264e510d16..93653d37a132 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1317,22 +1317,29 @@ void free_event_filter(struct event_filter *filter)
>  	__free_filter(filter);
>  }
>  
> -static inline void __remove_filter(struct trace_event_file *file)
> +static inline int __remove_filter(struct trace_event_file *file)
>  {
>  	filter_disable(file);
> -	remove_filter_string(file->filter);
> +	if (file->filter)
> +		remove_filter_string(file->filter);
> +	else
> +		return 0;
> +
> +	return 1;

The above looks awkward. What about:

	if (!file->filter)
		return 0;

	remove_filter_string(file->filter);
	return 1;

?

Or better yet:

	if (!file->filter)
		return false;

	remove_filter_string(file->filter);
	return true;

and ...

>  }
>  
> -static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
> +static int filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
>  					struct trace_array *tr)
>  {
>  	struct trace_event_file *file;
> +	int i = 0;

We don't really need a counter. It's either do the synchronization or
we don't.

	bool do_sync = false;

>  
>  	list_for_each_entry(file, &tr->events, list) {
>  		if (file->system != dir)
>  			continue;
> -		__remove_filter(file);
> +		i += __remove_filter(file);

		if (remove_filter(file))
			do_sync = true;

>  	}

	return do_sync;

> +	return i;
>  }
>  
>  static inline void __free_subsystem_filter(struct trace_event_file *file)
> @@ -2411,7 +2418,9 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  	}
>  
>  	if (!strcmp(strstrip(filter_string), "0")) {
> -		filter_free_subsystem_preds(dir, tr);
> +		if (filter_free_subsystem_preds(dir, tr) == 0)
> +			goto out_unlock;
> +

		/* If nothing was freed, we do not need to sync */
		if (!filter_free_subsystem_preds(dir, tr))
			goto out_unlock;

And yes, add the comment.

And actually, in that block with the goto out_unlock, we should have:

		if (!filter_free_subsystem_preds(dir, tr)) {
			if (!(WARN_ON_ONCE(system->filter))
				goto out_unlock;
		}

If there were no preds, ideally there would be no subsystem filter. But
if that's not the case, we need to warn about that and then continue.

-- Steve

>  		remove_filter_string(system->filter);
>  		filter = system->filter;
>  		system->filter = NULL;

