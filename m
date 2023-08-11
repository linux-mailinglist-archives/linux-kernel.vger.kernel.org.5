Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33F778E30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjHKLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHKLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E267F2712;
        Fri, 11 Aug 2023 04:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF97670AF;
        Fri, 11 Aug 2023 11:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4DFC433C7;
        Fri, 11 Aug 2023 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754543;
        bh=Sh2u7clSQIbTDqnn2ogtFOReg9glVuFYPd4lIEDRU7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KaFkes0YPmSf0y2pTdQQQ0kGp8h7OS+WWOq9NUlNa3MQgSyF5xhNj29Oa+jTZAzPf
         5170QuUL8qsuwbiNMjy9PeluBOk5aeUO/9xF40SeKxCqQxeiIqyXKGTzPtw0UFwc5X
         DCykqa+VGhPNJ6nmUtMpcjg2za/qMeqedcifVo1biKeSzIe3Y3kA55x3+dUrQelj3D
         LCkdj/Na+JqMP0Bq0IhPS9ydd66oNfUO3jyZjrgq+j42w6yTG/avUtjhBJZr8pSv7j
         Z13VJoRvSGyrANaEtMmqj0PoCyz5ngBThnwXIoC7l879/Vou2A3ejQ0LYmCNqqzJ3j
         Su1kWfrUbpYnA==
Date:   Fri, 11 Aug 2023 20:48:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Message-Id: <20230811204859.1e6df6a6c5aa42f8200a6017@kernel.org>
In-Reply-To: <20230811081239.246365-1-nashuiliang@gmail.com>
References: <20230811081239.246365-1-nashuiliang@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 16:12:39 +0800
Chuang Wang <nashuiliang@gmail.com> wrote:

> Refer to the description in [1], we can skip "container_of()" following
> "list_for_each_entry()" by using "list_for_each_entry()" with
> "struct trace_eprobe" and "tp.list".
> 
> Also, this patch defines "for_each_trace_eprobe_on_trace_probe" to
> simplify the code of the same logic.
> 
> [1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/
> 

This looks good to me.

Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
> v1 -> v2:
> - add "for_each_trace_eprobe_on_trace_probe" as suggested by Masami
> 
> v0 -> v1:
> - remove "Fixes" in the commit information.
> 
>  kernel/trace/trace_eprobe.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index a0a704ba27db..b7c6179f8b7f 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -41,6 +41,10 @@ struct eprobe_data {
>  	struct trace_eprobe	*ep;
>  };
>  
> +
> +#define for_each_trace_eprobe_on_trace_probe(ep, _tp) \
> +	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
> +
>  static int __trace_eprobe_create(int argc, const char *argv[]);
>  
>  static void trace_event_probe_cleanup(struct trace_eprobe *ep)
> @@ -640,7 +644,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  static int enable_trace_eprobe(struct trace_event_call *call,
>  			       struct trace_event_file *file)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
>  	bool enabled;
>  	int ret = 0;
> @@ -662,8 +666,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  	if (enabled)
>  		return 0;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		ep = container_of(pos, struct trace_eprobe, tp);
> +	for_each_trace_eprobe_on_trace_probe(ep, tp) {
>  		ret = enable_eprobe(ep, file);
>  		if (ret)
>  			break;
> @@ -680,8 +683,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  			 */
>  			WARN_ON_ONCE(ret != -ENOMEM);
>  
> -			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -				ep = container_of(pos, struct trace_eprobe, tp);
> +			for_each_trace_eprobe_on_trace_probe(ep, tp) {
>  				disable_eprobe(ep, file->tr);
>  				if (!--cnt)
>  					break;
> @@ -699,7 +701,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  static int disable_trace_eprobe(struct trace_event_call *call,
>  				struct trace_event_file *file)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
>  
>  	tp = trace_probe_primary_from_call(call);
> @@ -716,10 +718,8 @@ static int disable_trace_eprobe(struct trace_event_call *call,
>  		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
>  
>  	if (!trace_probe_is_enabled(tp)) {
> -		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -			ep = container_of(pos, struct trace_eprobe, tp);
> +		for_each_trace_eprobe_on_trace_probe(ep, tp)
>  			disable_eprobe(ep, file->tr);
> -		}
>  	}
>  
>   out:
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
