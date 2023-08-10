Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603B7775DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjHJKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA4F11F;
        Thu, 10 Aug 2023 03:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B2B657F0;
        Thu, 10 Aug 2023 10:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E153EC433C8;
        Thu, 10 Aug 2023 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691663529;
        bh=mBnH1ljhCKtjqP0kUG+czmxlui4aCbzEBcASnfKtVPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UCraXSTNlun0L1qNvECmnDjhtYodjVvsIUe9xTUJuEbwMUnIr7P5NVuQXLt92Ithm
         1qZYSdinNFh4UoLu6AXogHqXSr4LML0zmGqqNIAzB+qxOUt05dZzRYSpLktA7NLQKR
         UzxRLsP1xVZi9sw7NDuarPL5QZUeJiumwA7rMA2RQexsFUejKsTCxBEYPmsYW6YLhe
         PeWy5V78m5fHdoTsJI8tdUhevak3ueZXWDeJ/qgKS2ppURp9hp0YoYgXwSNVFGti70
         DJL/fl60cuOR1RKTWz+ejFidWHZQWg3WZtXrjoMUrtn6Kl5/6RGic9fChBvX88mF4V
         LZ1sYzGA4dfKQ==
Date:   Thu, 10 Aug 2023 19:32:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Iterate trace_eprobe directly
Message-Id: <20230810193204.cae5808af79bbcc80b88ff77@kernel.org>
In-Reply-To: <20230810082523.244397-1-nashuiliang@gmail.com>
References: <20230810082523.244397-1-nashuiliang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:25:23 +0800
Chuang Wang <nashuiliang@gmail.com> wrote:

> Refer to the description in [1], we can skip "container_of()" following
> "list_for_each_entry()" by using "list_for_each_entry()" with
> "struct trace_eprobe" and "tp.list".
> 
> [1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/
> 

Good point. BTW, it is better to have 'for_each_eprobe(ep)' if it repeats 3 times.


> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")

This is not a bug, so no need Fixes tag.

Thank you,

> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  kernel/trace/trace_eprobe.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index a0a704ba27db..d68d660dff7c 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -640,7 +640,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  static int enable_trace_eprobe(struct trace_event_call *call,
>  			       struct trace_event_file *file)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
>  	bool enabled;
>  	int ret = 0;
> @@ -662,8 +662,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  	if (enabled)
>  		return 0;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		ep = container_of(pos, struct trace_eprobe, tp);
> +	list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
>  		ret = enable_eprobe(ep, file);
>  		if (ret)
>  			break;
> @@ -680,8 +679,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  			 */
>  			WARN_ON_ONCE(ret != -ENOMEM);
>  
> -			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -				ep = container_of(pos, struct trace_eprobe, tp);
> +			list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
>  				disable_eprobe(ep, file->tr);
>  				if (!--cnt)
>  					break;
> @@ -699,7 +697,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  static int disable_trace_eprobe(struct trace_event_call *call,
>  				struct trace_event_file *file)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
>  
>  	tp = trace_probe_primary_from_call(call);
> @@ -716,8 +714,7 @@ static int disable_trace_eprobe(struct trace_event_call *call,
>  		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
>  
>  	if (!trace_probe_is_enabled(tp)) {
> -		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -			ep = container_of(pos, struct trace_eprobe, tp);
> +		list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
>  			disable_eprobe(ep, file->tr);
>  		}
>  	}
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
