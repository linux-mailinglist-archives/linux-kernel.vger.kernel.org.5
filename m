Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9075453C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGNXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGNXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7F3594;
        Fri, 14 Jul 2023 16:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DC661E15;
        Fri, 14 Jul 2023 23:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAB6C433C8;
        Fri, 14 Jul 2023 23:01:34 +0000 (UTC)
Date:   Fri, 14 Jul 2023 19:01:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mohamed Khalfella <mkhalfella@purestorage.com>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] tracing/histograms: Return an error if we fail to add
 histogram to hist_vars list
Message-ID: <20230714190131.5f8f9126@gandalf.local.home>
In-Reply-To: <20230714192143.3656-1-mkhalfella@purestorage.com>
References: <20230714192143.3656-1-mkhalfella@purestorage.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 19:21:43 +0000
Mohamed Khalfella <mkhalfella@purestorage.com> wrote:

> If the code fails to add histogram to hist_vars list, then ret should
> contain error code before jumping to unregister histogram.

Thanks, but I think I'm going to hold off till rc2 to push this through, to
see what else comes in, before I go back into running tests just to get
another fix as I send my pull request to Linus! ;-)

-- Steve


> 
> Cc: stable@vger.kernel.org
> Fixes: 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if
> they have referenced variables") Signed-off-by: Mohamed Khalfella
> <mkhalfella@purestorage.com> ---
>  kernel/trace/trace_events_hist.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c index c8c61381eba4..d06938ae0717 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6668,7 +6668,8 @@ static int event_hist_trigger_parse(struct
> event_command *cmd_ops, goto out_unreg;
>  
>  	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> -		if (save_hist_vars(hist_data))
> +		ret = save_hist_vars(hist_data);
> +		if (ret)
>  			goto out_unreg;
>  	}
>  

