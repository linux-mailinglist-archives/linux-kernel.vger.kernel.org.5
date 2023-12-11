Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D280CE40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbjLKOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjLKOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:22:01 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3935B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:20:46 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1faea6773c9so3282614fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702304445; x=1702909245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b7rlHaKQWXujUJWBukOmFO3U6X3+0Q326b+lP9WNi7o=;
        b=OneVFLLwm5ISbB3UeBCiQfBfizvB07+GHl1CP4ToDmvTwWInWx0eRQ2HT4xjkiUW4U
         /QwvRIks95q4yESEtbu6iM1YP0C7J8LkjXlhnNoP0zJo9xVzb2XLYTNAIOE5OuwpEa2A
         WWvgkLVIEBuDnYEcwegYYNrfdfKk9isuNYBVjyZNKoO1tpL9KsE8B1hJEEaxJSmoB3yp
         wtgsKYkK5pnaM5QnWGpS7FL9VqtDTmmQkRJ60BGYYwCgV6xTHtrzh20f+WcFUXlcPu1E
         on5BzuK/IdgwlJVGKk12c/EWZAn/DiYrQOy/I2fnXF/1nNMFk3j/9EidE4lxsbrFvBdN
         LJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304445; x=1702909245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7rlHaKQWXujUJWBukOmFO3U6X3+0Q326b+lP9WNi7o=;
        b=j3Sdc0LkN2yBYNDgtjs0bVWq7l+4SkBgxXZ3XH75X5VgAiUnPTptwgkVJkO4IgUZz0
         HnI1nNkWZQZgrDt3nyN25mCeKHt+BofOp/2FrALRRTns1C4q28uyREElCeOgggKFvJj9
         Mz0Wnb5xof+bkg1fpLDZw8TOiNJV3FDvL4WbNNR498S1EKnvSyfTrLqTU46OhEwcduJ4
         7IbSYiNAHM84EW/VfCh1EF8SSM/6eJ4vIIWyoA6axYpM9WwqhHmyaD6ZG83ETyJRSc0L
         tFDTNs3BnFZ/6gHu4WpcWt50Dc8l8omc4iyIGh/xWWp7BTYF95Liw8MI3x4aZt8VLtuL
         vwIQ==
X-Gm-Message-State: AOJu0YxDLtUxYEuFbqFI7T+aTlNBFu57YKL8MHxp68zTUcRNjKxaX4O2
        2xyZH2qe+pE8BgxFYVVU83/7ojMRJ6LWVvVWLlu0LQ==
X-Google-Smtp-Source: AGHT+IH5sir+QHLUZSjR236YJEi+mk4L/A4SMauTvkuuWPhpch7FibrTpRcY7a9kuBELNV5WVBRkKorL015slNGOXvo=
X-Received: by 2002:a05:6871:7a02:b0:1fa:ede6:4691 with SMTP id
 pc2-20020a0568717a0200b001faede64691mr5487118oac.27.1702304445002; Mon, 11
 Dec 2023 06:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-2-khuey@kylehuey.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Dec 2023 15:20:05 +0100
Message-ID: <CANpmjNPvZ=S5Afn9DR7nG2UFstqz5t1gBznTh4yezVv7k1+m9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 05:55, Kyle Huey <me@kylehuey.com> wrote:
>
> To ultimately allow bpf programs attached to perf events to completely
> suppress all of the effects of a perf event overflow (rather than just the
> sample output, as they do today), call bpf_overflow_handler() from
> __perf_event_overflow() directly rather than modifying struct perf_event's
> overflow_handler. Return the bpf program's return value from
> bpf_overflow_handler() so that __perf_event_overflow() knows how to
> proceed. Remove the now unnecessary orig_overflow_handler from struct
> perf_event.
>
> This patch is solely a refactoring and results in no behavior change.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h |  6 +-----
>  kernel/events/core.c       | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5547ba68e6e4..312b9f31442c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -810,7 +810,6 @@ struct perf_event {
>         perf_overflow_handler_t         overflow_handler;
>         void                            *overflow_handler_context;
>  #ifdef CONFIG_BPF_SYSCALL
> -       perf_overflow_handler_t         orig_overflow_handler;
>         struct bpf_prog                 *prog;
>         u64                             bpf_cookie;
>  #endif
> @@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
>  #ifdef CONFIG_BPF_SYSCALL
>  static inline bool uses_default_overflow_handler(struct perf_event *event)
>  {
> -       if (likely(is_default_overflow_handler(event)))
> -               return true;
> -
> -       return __is_default_overflow_handler(event->orig_overflow_handler);
> +       return is_default_overflow_handler(event);
>  }
>  #else
>  #define uses_default_overflow_handler(event) \
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..54f6372d2634 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
>         return true;
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs);
> +#endif

To avoid more #ifdefs we usually add a stub, something like:

#ifdef ...
static int bpf_overflow_handler(...);
#else
static inline int bpf_overflow_handler(...) { return 0; }
#endif

Then you can avoid more #ifdefs below, esp. when it surrounds an
if-statement it easily leads to confusion or subtle bugs in future
changes. The compiler will optimize out the constants and the
generated code will be the same.

>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_event *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -       READ_ONCE(event->overflow_handler)(event, data, regs);
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> +#endif
> +               READ_ONCE(event->overflow_handler)(event, data, regs);
>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup = 1;
> @@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_event *event)
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> -static void bpf_overflow_handler(struct perf_event *event,
> -                                struct perf_sample_data *data,
> -                                struct pt_regs *regs)
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs)
>  {
>         struct bpf_perf_event_data_kern ctx = {
>                 .data = data,
> @@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_event *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> -               return;
>
> -       event->orig_overflow_handler(event, data, regs);
> +       return ret;
>  }
>
>  static int perf_event_set_bpf_handler(struct perf_event *event,
> @@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
>
>         event->prog = prog;
>         event->bpf_cookie = bpf_cookie;
> -       event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
> -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>         return 0;
>  }
>
> @@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
>         if (!prog)
>                 return;
>
> -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
>         event->prog = NULL;
>         bpf_prog_put(prog);
>  }
> @@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>                 overflow_handler = parent_event->overflow_handler;
>                 context = parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (overflow_handler == bpf_overflow_handler) {
> +               if (parent_event->prog) {
>                         struct bpf_prog *prog = parent_event->prog;
>
>                         bpf_prog_inc(prog);
>                         event->prog = prog;
> -                       event->orig_overflow_handler =
> -                               parent_event->orig_overflow_handler;
>                 }
>  #endif
>         }
> --
> 2.34.1
>
