Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8776B717
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjHAOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjHAOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83E5BF;
        Tue,  1 Aug 2023 07:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45935615CD;
        Tue,  1 Aug 2023 14:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01565C433C9;
        Tue,  1 Aug 2023 14:19:09 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:19:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v3 6/6] libtraceevent: prefer to use prev_state_char
 introduced in sched_switch
Message-ID: <20230801101908.4ccc81c8@gandalf.local.home>
In-Reply-To: <20230801090124.8050-7-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
        <20230801090124.8050-7-zegao@tencent.com>
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

On Tue,  1 Aug 2023 17:01:24 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Since the sched_switch tracepoint introduces a new variable to
> report sched-out task state in symbolic char, we prefer to use
> it to spare from knowing internal implementations in kernel.
> 
> Also we keep the old parsing logic intact but sync the state char
> array with the latest kernel.

This should be two patches. First sync the state char array and then add
your state_char change. The two changes are agnostic to each other, and
should be separate commits. Same goes for the perf changes.

-- Steve


> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  plugins/plugin_sched_switch.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
> index 8752cae..4c57322 100644
> --- a/plugins/plugin_sched_switch.c
> +++ b/plugins/plugin_sched_switch.c
> @@ -11,7 +11,7 @@
>  
>  static void write_state(struct trace_seq *s, int val)
>  {
> -	const char states[] = "SDTtZXxW";
> +	const char states[] = "SDTtXZPIp";
>  	int found = 0;
>  	int i;
>  
> @@ -99,7 +99,12 @@ static int sched_switch_handler(struct trace_seq *s,
>  	if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) == 0)
>  		trace_seq_printf(s, "[%d] ", (int) val);
>  
> -	if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
> +	//find if has prev_state_char, otherwise fallback to prev_state
> +	if (tep_find_field(event, "prev_state_char")) {
> +		if (tep_get_field_val(s,  event, "prev_state_char", record, &val, 1) == 0)
> +			trace_seq_putc(s, (char) val);
> +	}
> +	else if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) == 0)
>  		write_state(s, val);
>  
>  	trace_seq_puts(s, " ==> ");

