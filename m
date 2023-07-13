Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1947523E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjGMNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjGMNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB52702;
        Thu, 13 Jul 2023 06:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 461936136A;
        Thu, 13 Jul 2023 13:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DB0C433C7;
        Thu, 13 Jul 2023 13:34:38 +0000 (UTC)
Date:   Thu, 13 Jul 2023 09:34:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] tracing/probes: Fix to update dynamic data
 counter if fetcharg uses it
Message-ID: <20230713093436.0241ed77@gandalf.local.home>
In-Reply-To: <168908494781.123124.8160245359962103684.stgit@devnote2>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
        <168908494781.123124.8160245359962103684.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 23:15:48 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to update dynamic data counter ('dyndata') and max length ('maxlen')
> only if the fetcharg uses the dynamic data. Also get out arg->dynamic
> from unlikely(). This makes dynamic data address wrong if
> process_fetch_insn() returns error on !arg->dynamic case.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Link: https://lore.kernel.org/all/20230710233400.5aaf024e@gandalf.local.home/
> Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_probe_tmpl.h |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index ed9d57c6b041..185da001f4c3 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -267,11 +267,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
>  		if (unlikely(arg->dynamic))
>  			*dl = make_data_loc(maxlen, dyndata - base);
>  		ret = process_fetch_insn(arg->code, rec, dl, base);
> -		if (unlikely(ret < 0 && arg->dynamic)) {
> -			*dl = make_data_loc(0, dyndata - base);
> -		} else {
> -			dyndata += ret;
> -			maxlen -= ret;
> +		if (arg->dynamic) {
> +			if (unlikely(ret < 0)) {
> +				*dl = make_data_loc(0, dyndata - base);
> +			} else {
> +				dyndata += ret;
> +				maxlen -= ret;
> +			}
>  		}
>  	}
>  }

