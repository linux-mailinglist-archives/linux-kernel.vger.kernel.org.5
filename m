Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECB769AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjGaPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGaPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E041198B;
        Mon, 31 Jul 2023 08:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149D9611B9;
        Mon, 31 Jul 2023 15:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B8AC433C7;
        Mon, 31 Jul 2023 15:40:05 +0000 (UTC)
Date:   Mon, 31 Jul 2023 11:40:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v2 3/3] libtraceevent: use the new prev_state_char
 instead in tracepoint sched_switch
Message-ID: <20230731114003.43842c8e@gandalf.local.home>
In-Reply-To: <20230726121618.19198-4-zegao@tencent.com>
References: <20230726121618.19198-1-zegao@tencent.com>
        <20230726121618.19198-4-zegao@tencent.com>
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

On Wed, 26 Jul 2023 20:16:18 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Since the sched_switch tracepoint introduces a new variable to
> report sched-out task state in symbolic char, we switch to use
> that instead to spare from knowing internal implementations
> in kernel.

This needs to be changed to check if the "prev_state_char" field exists,
and if not, then it must use the old method. Same for perf. The tools must
work with older kernels.

-- Steve

> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  plugins/plugin_sched_switch.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
> index 8752cae..5dbdc28 100644
> --- a/plugins/plugin_sched_switch.c
> +++ b/plugins/plugin_sched_switch.c
> @@ -9,27 +9,6 @@
>  #include "event-parse.h"
>  #include "trace-seq.h"
>  
> -static void write_state(struct trace_seq *s, int val)
> -{
> -	const char states[] = "SDTtZXxW";
> -	int found = 0;
> -	int i;
> -
> -	for (i = 0; i < (sizeof(states) - 1); i++) {
> -		if (!(val & (1 << i)))
> -			continue;
> -
> -		if (found)
> -			trace_seq_putc(s, '|');
> -
> -		found = 1;
> -		trace_seq_putc(s, states[i]);
> -	}
> -
> -	if (!found)
> -		trace_seq_putc(s, 'R');
> -}
> -
>  static void write_and_save_comm(struct tep_format_field *field,
>  				struct tep_record *record,
>  				struct trace_seq *s, int pid)
> @@ -97,10 +76,10 @@ static int sched_switch_handler(struct trace_seq *s,
>  	trace_seq_printf(s, "%lld ", val);
>  
>  	if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) ==
> 0)
> -		trace_seq_printf(s, "[%d] ", (int) val);
> +		trace_seq_printf(s, "[%d] ", (short) val);
>  
> -	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1)
> == 0)
> -		write_state(s, val);
> +	if (tep_get_field_val(s,  event, "prev_state_char", record,
> &val, 1) == 0)
> +		trace_seq_putc(s, (char) val);
>  
>  	trace_seq_puts(s, " ==> ");
>  
> @@ -115,7 +94,7 @@ static int sched_switch_handler(struct trace_seq *s,
>  	trace_seq_printf(s, "%lld", val);
>  
>  	if (tep_get_field_val(s, event, "next_prio", record, &val, 1) ==
> 0)
> -		trace_seq_printf(s, " [%d]", (int) val);
> +		trace_seq_printf(s, " [%d]", (short) val);
>  
>  	return 0;
>  }

