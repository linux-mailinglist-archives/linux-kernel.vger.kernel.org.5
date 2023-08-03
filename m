Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD276EDAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjHCPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjHCPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFD330EA;
        Thu,  3 Aug 2023 08:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0806361DF1;
        Thu,  3 Aug 2023 15:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F2C433C8;
        Thu,  3 Aug 2023 15:10:32 +0000 (UTC)
Date:   Thu, 3 Aug 2023 11:10:31 -0400
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
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the
 kernel
Message-ID: <20230803111031.056b3446@gandalf.local.home>
In-Reply-To: <20230803083352.1585-2-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-2-zegao@tencent.com>
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

On Thu,  3 Aug 2023 04:33:48 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Update state char array and then remove unused and stale
> macros, which are kernel internal representations and not
> encouraged to use anymore.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  tools/perf/builtin-sched.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 9ab300b6f131..8dc8f071721c 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -92,23 +92,12 @@ struct sched_atom {
>  	struct task_desc	*wakee;
>  };
>  
> -#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
> +#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"

Thinking about this more, this will always be wrong. Changing it just works
for the kernel you made the change for, but if it is run on another kernel,
it's broken again.

I actually wrote code once that basically just did a:

	struct trace_seq s;

	trace_seq_init(&s);
	tep_print_event(tep, &s, record, "%s", TEP_PRINT_INFO);

then searched s.buffer for "prev_state=%s ", to find the state character.

That's because the kernel should always be up to date (and why I said I
needed that string in the print_fmt).

As perf has a tep handle, this could be a helper function to extract the
state if needed, and get rind of relying on the above character array.

-- Steve


>  
>  /* task state bitmask, copied from include/linux/sched.h */
>  #define TASK_RUNNING		0
>  #define TASK_INTERRUPTIBLE	1
>  #define TASK_UNINTERRUPTIBLE	2
> -#define __TASK_STOPPED		4
> -#define __TASK_TRACED		8
> -/* in tsk->exit_state */
> -#define EXIT_DEAD		16
> -#define EXIT_ZOMBIE		32
> -#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
> -/* in tsk->state again */
> -#define TASK_DEAD		64
> -#define TASK_WAKEKILL		128
> -#define TASK_WAKING		256
> -#define TASK_PARKED		512
>  
>  enum thread_state {
>  	THREAD_SLEEPING = 0,

