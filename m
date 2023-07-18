Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFF7570B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGRAAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGRAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD506EC;
        Mon, 17 Jul 2023 17:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732D16135C;
        Tue, 18 Jul 2023 00:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D72C433C8;
        Tue, 18 Jul 2023 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689638435;
        bh=qcUEcDK6AXqP07t5ytqWFHjiJgDcpFUrQBIZzSKb7T8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TUIFBBNxwYgVURjg535s2o1fErHH/q+Ig56Bb9E+GJ8H8bPrCtcvtFIDe/M9dU2mg
         6ITNePUfFTvCVJL0UmOE6hX3kF0LUR2iiveh7H/mE0/crh/4Y3zzhBCSGVUGl/V8Xb
         dseXrP5zHr7HMpQbJ/D4Aw4yg5ElIZjX2ckhQm46+nuI6t6Q9fBhv0ZA+uSaJ6NRhD
         2R9YyEP2xiq3K6CPV9Ks+UIFgt/w3pHxJ17rNHSYbECUf4y2REFFrqlmBZxTxNyq7O
         76hvgC6I7Yzvy/3PXsemqk/gUUA8Rkl31AtGwsZt1inZ3o/DeCYQcnk9GszZcyYtT3
         kXtSLEFqTY0qQ==
Date:   Tue, 18 Jul 2023 09:00:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing/probes: Differentiate BTF support from start of
 function
Message-Id: <20230718090033.5f4d0a7df2657b0cc71f9219@kernel.org>
In-Reply-To: <20230717163947.4969316a@gandalf.local.home>
References: <20230717163947.4969316a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 16:39:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Having a typo in the function name to trace one of the arguments using
> BTF, gave me an error message that BTF was not supported by this kernel:
> 
> ~# echo 'p:lock __raw_spin_lock lock=lock' > /sys/kernel/tracing/kprobe_events
> -bash: echo: write error: Invalid argument
> ~# cat /sys/kernel/tracing/error_log
> [   34.382149] trace_kprobe: error: BTF is not available or not supported
>   Command: p:lock __raw_spin_lock lock=lock
>                                        ^
> 
> I added two underscores instead of one underscore for the function
> _raw_spin_lock(). But I spent too much time trying to figure out why BTF
> was not supported, because in reality it was! The problem was that the
> function wasn't found (this could happen if a function offset is used as
> well).

Thanks for reporting!

> 
> Instead, add a new error message that gives a better description of the
> problem.
> 
> ~# echo 'p:lock __raw_spin_lock lock=lock' > /sys/kernel/tracing/kprobe_events
> -bash: echo: write error: Invalid argument
> ~# cat /sys/kernel/tracing/error_log
> [   45.922742] trace_kprobe: error: BTF arg can be used only on function entry
>   Command: p:lock __raw_spin_lock lock=lock
>                                        ^

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!


> Fixes: b576e09701c7d ("tracing/probes: Support function parameters if BTF is available")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  kernel/trace/trace_probe.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cf504efd0694..328a51b1d068 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1023,7 +1023,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  	default:
>  		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
>  			if (!tparg_is_function_entry(ctx->flags)) {
> -				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +				trace_probe_log_err(ctx->offset, NOFENTRY_BTFARG);
>  				return -EINVAL;
>  			}
>  			ret = parse_btf_arg(arg, pcode, end, ctx);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 604d6fb9c5ff..554fe2995ca1 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -493,6 +493,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
>  	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
>  	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
> +	C(NOFENTRY_BTFARG,	"BTF arg can be used only on function entry"),	\
>  	C(NO_BTFARG,		"This variable is not found at this probe point"),\
>  	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
>  	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
