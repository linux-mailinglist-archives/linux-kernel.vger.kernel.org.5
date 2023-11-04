Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F227E0D03
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjKDBOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Nov 2023 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:14:46 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF4D54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:14:44 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso2529700a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 18:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699060484; x=1699665284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQTY7jB2XuDR5VNadrU1LVQTS48IqrRjbSad0fqLF/A=;
        b=tAXn6DBXtvt+6a+61JRQQbWXHXjAuUo++vG0JwGdent4+DLa1IDNKGl1lGywft5dx0
         Xos3FXuDSIgDVk591DgBZNFh/NcGVfVKrmM3y/VY51Grg9ODfWZ2S7+7WtM6Ylq0KD2/
         3ukBOEnvnaBnmxkHlq2D23Jn7Upr/rnGIxIRzqxp+SMFUmLsOHzXKpaTurhKwaG3hh3O
         t1Hk+DfcEv2jKdOGokMKivfMRRwSlvr9vCL6O57Tg0fYxY2U4BmRE+aShIl1IXMfochZ
         qQPkYudlOlLKgEQcBSbwFi4FIo7aCAl7a4Z7VAiAzng7GaPnTOCfoSA/MIOZVV32zMS0
         KOww==
X-Gm-Message-State: AOJu0YxPdpX5wjdi/SACWoVhiTD/C5Zw8YLJ+SWc8slnDmqTOaBjJ9BC
        kI/Nfue2M1AAMfORmb0pjQvFRz+N7CwdaZlWhLk=
X-Google-Smtp-Source: AGHT+IFfRPLMb0K+LV8KMkgwGZoP4Hqw2fZRU0OsLHQQn3lCtnP2ym62ARPxOrlOiXQjIXqIubiQuYy84TsqFdk9N+M=
X-Received: by 2002:a17:90b:4004:b0:280:94e8:99f4 with SMTP id
 ie4-20020a17090b400400b0028094e899f4mr13095321pjb.46.1699060483860; Fri, 03
 Nov 2023 18:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231102150919.719936610@infradead.org> <20231102152018.986157891@infradead.org>
In-Reply-To: <20231102152018.986157891@infradead.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Nov 2023 18:14:32 -0700
Message-ID: <CAM9d7cjy-T6VsPE1VSgYFWHOhKOA5dmDXwWExvXSeJXeE1Jt1Q@mail.gmail.com>
Subject: Re: [PATCH 11/13] perf: Simplify perf_adjust_freq_unthr_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 8:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   51 +++++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4090,7 +4090,7 @@ perf_adjust_freq_unthr_context(struct pe
>         if (!(ctx->nr_freq || unthrottle))
>                 return;
>
> -       raw_spin_lock(&ctx->lock);
> +       guard(raw_spinlock)(&ctx->lock);
>
>         list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
>                 if (event->state != PERF_EVENT_STATE_ACTIVE)
> @@ -4100,7 +4100,7 @@ perf_adjust_freq_unthr_context(struct pe
>                 if (!event_filter_match(event))
>                         continue;
>
> -               perf_pmu_disable(event->pmu);
> +               guard(perf_pmu_disable)(event->pmu);
>
>                 hwc = &event->hw;
>
> @@ -4110,34 +4110,29 @@ perf_adjust_freq_unthr_context(struct pe
>                         event->pmu->start(event, 0);
>                 }
>
> -               if (!event->attr.freq || !event->attr.sample_freq)
> -                       goto next;
> +               if (event->attr.freq && event->attr.sample_freq) {

Any reason for this change?  I think we can just change the
'goto next' to 'continue', no?

Also I think this code needs changes to optimize the access.
A similar reason for the cgroup switch, it accesses all the
pmu/events in the context even before checking the sampling
frequency.  This is bad for uncore PMUs (and KVM too).

But this is a different issue..

Thanks,
Namhyung


> +                       /*
> +                        * stop the event and update event->count
> +                        */
> +                       event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +                       now = local64_read(&event->count);
> +                       delta = now - hwc->freq_count_stamp;
> +                       hwc->freq_count_stamp = now;
> +
> +                       /*
> +                        * restart the event
> +                        * reload only if value has changed
> +                        * we have stopped the event so tell that
> +                        * to perf_adjust_period() to avoid stopping it
> +                        * twice.
> +                        */
> +                       if (delta > 0)
> +                               perf_adjust_period(event, period, delta, false);
>
> -               /*
> -                * stop the event and update event->count
> -                */
> -               event->pmu->stop(event, PERF_EF_UPDATE);
> -
> -               now = local64_read(&event->count);
> -               delta = now - hwc->freq_count_stamp;
> -               hwc->freq_count_stamp = now;
> -
> -               /*
> -                * restart the event
> -                * reload only if value has changed
> -                * we have stopped the event so tell that
> -                * to perf_adjust_period() to avoid stopping it
> -                * twice.
> -                */
> -               if (delta > 0)
> -                       perf_adjust_period(event, period, delta, false);
> -
> -               event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> -       next:
> -               perf_pmu_enable(event->pmu);
> +                       event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> +               }
>         }
> -
> -       raw_spin_unlock(&ctx->lock);
>  }
>
>  /*
>
>
