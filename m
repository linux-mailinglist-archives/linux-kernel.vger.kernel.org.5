Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574397E2FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjKFW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:28:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE94D51
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:28:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8908C433C7;
        Mon,  6 Nov 2023 22:28:10 +0000 (UTC)
Date:   Mon, 6 Nov 2023 17:28:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe-event: Fix to check tracepoint event
 and return
Message-ID: <20231106172811.25066d33@gandalf.local.home>
In-Reply-To: <169902753361.313086.6662802092416198593.stgit@devnote2>
References: <169902753361.313086.6662802092416198593.stgit@devnote2>
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

On Sat,  4 Nov 2023 01:05:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to check the tracepoint event is not valid with $retval.
> The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
> a return event by $retval") introduced automatic return probe
> conversion with $retval. But since tracepoint event does not
> support return probe, $retval is not acceptable.

Can you add the command that causes this to fail.

-- Steve

> 
> Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_fprobe.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 8bfe23af9c73..7d2ddbcfa377 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -927,11 +927,12 @@ static int parse_symbol_and_return(int argc, const char *argv[],
>  	for (i = 2; i < argc; i++) {
>  		tmp = strstr(argv[i], "$retval");
>  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> +			if (is_tracepoint) {
> +				trace_probe_log_set_index(i);
> +				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> +				return -EINVAL;
> +			}
>  			*is_return = true;
> -			/*
> -			 * NOTE: Don't check is_tracepoint here, because it will
> -			 * be checked when the argument is parsed.
> -			 */
>  			break;
>  		}
>  	}

