Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93E76E3F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjHCJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjHCJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F1E7;
        Thu,  3 Aug 2023 02:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9627E61CFF;
        Thu,  3 Aug 2023 09:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4D9C433C7;
        Thu,  3 Aug 2023 09:09:04 +0000 (UTC)
Date:   Thu, 3 Aug 2023 05:09:00 -0400
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
Message-ID: <20230803050900.5007d2f5@gandalf.local.home>
In-Reply-To: <20230803083352.1585-2-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
        <20230803083352.1585-2-zegao@tencent.com>
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

On Thu,  3 Aug 2023 04:33:48 -0400
Ze Gao <zegao2021@gmail.com> wrote:

Hi Ze,

> Update state char array and then remove unused and stale
> macros, which are kernel internal representations and not
> encouraged to use anymore.
> 

A couple of things.

First, the change logs of every commit need to specify the "why". The
subject can say "what", but the change log really needs to explain why this
patch is important. For example, this patch is really two changes (and thus
should actually be two patches). (I'll also comment on the other patches)

1. The update of the state char array. You should explain why it's being
updated. If it was wrong, it needs to state the commit that changed to make
that happen.

2. For the removing the stale macros, the change log can simply state that
the macros are unused in the code and are being removed.

Finally, I know you're eager to get this patch set in, but please hold off
sending a new version immediately after a comment or two. Some maintainers
prefer submitters to wait a week or so, otherwise you will tend to "spam"
their inboxes. There's more than one maintainer Cc'd on this series, and you
need to be courteous not to send too many emails in a short period of time.

-- Steve


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

