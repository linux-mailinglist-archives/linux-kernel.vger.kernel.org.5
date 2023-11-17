Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E617EFAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKQVgW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 16:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQVgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:36:21 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB7D5B;
        Fri, 17 Nov 2023 13:36:18 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so2173658b3a.3;
        Fri, 17 Nov 2023 13:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256978; x=1700861778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRmy9y9ac+yTEbZckJJ5+cq8FyHeOZGxr76B8ISJOI0=;
        b=IcgAX2OZYMiY+/sW2+r7gv8i4oOrCQ/47JWw9YbiE/eOmrNj0BQx9JLkHwtGANcXWi
         X9wzh0LZXdE3AOUeHbVQ4KssGTmOZ4EHZ1uJlmNp/O4TmhRGlN1dNmds5MimmdXQDbSk
         iV7vfgE4ZHLfXSra7jMUNRuDEmfrS8PF+L94zufSkImLBIYBik5DujpHZpE3kEYz9sf+
         z+Izm0YrNvktzr/SqQ5Mpc9TGgyw7HgWGLDBt/TQzLREcVNxCt1+JajjauiltYEVUSYY
         ifDlj48fpZjin+nXOjEUCR0FFQUymY7ttrm+k1xgHL7jrs7XeuI7hofUj5puUN/rW7Ja
         8H8Q==
X-Gm-Message-State: AOJu0YwZK8E8MXX//pNpV/+cxRPUioWevWF0txf9Wu0Mgb6sUIaMFt+9
        fKb2XSrTSXwOc3W0LPvDL2JPrf/m3IlsDaxbvgQ=
X-Google-Smtp-Source: AGHT+IF791i5PEi/qtjoA758S6HD6n/qO5eoqKR+q0B45PUt/q8AlBLIt5ZMR1gD6/9nXjiIyyHlMe3oZyiD0AY6m5o=
X-Received: by 2002:a05:6a20:4424:b0:185:a90d:3628 with SMTP id
 ce36-20020a056a20442400b00185a90d3628mr521392pzb.38.1700256977741; Fri, 17
 Nov 2023 13:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20231114211254.3137289-1-irogers@google.com>
In-Reply-To: <20231114211254.3137289-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 17 Nov 2023 13:36:06 -0800
Message-ID: <CAM9d7cj-q8Zxf1hqBYSnTrfCJmbgxs9KhFn5m1TYmFjGbwubCg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf evsel: Fallback to task-clock when not system wide
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Nov 14, 2023 at 1:13 PM Ian Rogers <irogers@google.com> wrote:
>
> When the cycles event isn't available evsel will fallback to the
> cpu-clock software event. task-clock is similar to cpu-clock but only
> runs when the process is running. Falling back to cpu-clock when not
> system wide leads to confusion, by falling back to task-clock it is
> hoped the confusion is less.

I think they are almost the same and no meaningful difference.
The cpu-clock event also runs only when the task is running if
it's a per-task event.

>
> Update a nearby comment and debug string for the change.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a5da74e3a517..e1175313e4bc 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2861,18 +2861,19 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
>             evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
>             evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>                 /*
> -                * If it's cycles then fall back to hrtimer based
> -                * cpu-clock-tick sw counter, which is always available even if
> -                * no PMU support.
> +                * If it's cycles then fall back to hrtimer based cpu-clock sw
> +                * counter, which is always available even if no PMU support.
>                  *
>                  * PPC returns ENXIO until 2.6.37 (behavior changed with commit
>                  * b0a873e).
>                  */
> -               scnprintf(msg, msgsize, "%s",
> -"The cycles event is not supported, trying to fall back to cpu-clock-ticks");
> -
>                 evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
> -               evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
> +               evsel->core.attr.config = evsel->core.system_wide

I'm not sure you can use the system_wide flag for this.
IIUC it's to override the target setting in some cases
(e.g. a dummy event to track sideband events in all CPUs)
and I think you need to check target__has_cpu() instead.

But as I said above, it won't make any difference in the
output.  Conceptually it'd be more natural to use task-clock
event for per-task sessions though.

Thanks,
Namhyung


> +                       ? PERF_COUNT_SW_CPU_CLOCK
> +                       : PERF_COUNT_SW_TASK_CLOCK;
> +               scnprintf(msg, msgsize,
> +                       "The cycles event is not supported, trying to fall back to %s",
> +                       evsel->core.system_wide ? "cpu-clock" : "task-clock");
>
>                 zfree(&evsel->name);
>                 return true;
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
