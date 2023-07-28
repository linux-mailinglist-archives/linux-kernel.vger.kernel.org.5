Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60177672EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjG1RHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjG1RHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:07:17 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2143ABF;
        Fri, 28 Jul 2023 10:07:14 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-565ac1880a2so283032eaf.0;
        Fri, 28 Jul 2023 10:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690564034; x=1691168834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x2DK32HW6E78QP/OGgMb05vDkdF/n1clsh4+A/MUYQ=;
        b=BsICRcEqauxrBiUtM6cT5QSSdFO9GObdAor5JdHezFQ2tbRmm+voNBzuR9cMssl4Wr
         TgUpDo3Tl+eDfjvI1vQZBhLG23No8XiVmAdQYXYmA4vh5xfEx8S+M7/t1wx1/jfnDRjZ
         ozh8dbX5QXpzjmMtPjYpfVmb8SteuCj72gAlf+ES5uq+b3yDHo+uWGe9ZHTXNlPZlu35
         UWFCwLIniW3aIl9IdUmhFwTMewNwfY+rhiAHsOrVPO55Nw7gD9a3gu8y8AFIXmEEzhcf
         OKCl+PtHh2+ng0beqooBexDVTkQc06PfBdHHR4gmKnon2lCzEd/e0EQxSRLsWQbqYiBg
         OdTw==
X-Gm-Message-State: ABy/qLYq1TuKVj9gbKchMtMAV9H0sZKa013WQP6lUb6pBpbla8QYUQpP
        d5gIYV94waGypLg7qHY6bcthinDIllcT/ozlAOc=
X-Google-Smtp-Source: APBJJlGqc/7VLwisSIzvHmUguYHl3r+WBYBjqzWU4KCLoJ6gkMeM7RwHVt8L5g6jfZKI7Jhe6VVHtDZ9VdEwXr6as3w=
X-Received: by 2002:a4a:dec7:0:b0:565:a7bd:3927 with SMTP id
 w7-20020a4adec7000000b00565a7bd3927mr2649031oou.0.1690564034157; Fri, 28 Jul
 2023 10:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.970594909@infradead.org>
In-Reply-To: <20230728145808.970594909@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 19:07:02 +0200
Message-ID: <CAJZ5v0jk9DApNSo7Nq3ZMJh93NT89u310eHtkDwoS2mRj5N+=Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] cpuidle,teo: Improve state selection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
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

On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> When selecting a state, stop when history tells us 66% of recent idles
> were at or below our current state.

This is not really about "recent idles" AFAICS.  It stops the
selection when 66% of the total sum of the "hits" and "intercepts"
signals comes from the current state and the states below it.  This
covers the entire history, while the "recent" ones are counted
separately.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/governors/teo.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -363,6 +363,7 @@ static int teo_select(struct cpuidle_dri
>         unsigned int idx_hit_sum = 0;
>         unsigned int hit_sum = 0;
>         unsigned int tick_sum = 0;
> +       unsigned int thresh_sum = 0;
>         int constraint_idx = 0;
>         int idx0 = 0, idx = -1;
>         bool alt_intercepts, alt_recent;
> @@ -397,6 +398,8 @@ static int teo_select(struct cpuidle_dri
>                 duration_ns = tick_nohz_get_sleep_length(&delta_tick);
>         cpu_data->sleep_length_ns = duration_ns;
>
> +       thresh_sum = 2 * cpu_data->total / 3; /* 66% */
> +
>         /*
>          * Find the deepest idle state whose target residency does not exceed
>          * the current sleep length and the deepest idle state not deeper than
> @@ -427,6 +430,9 @@ static int teo_select(struct cpuidle_dri
>                 if (s->target_residency_ns > duration_ns)
>                         break;
>
> +               if (intercept_sum + hit_sum > thresh_sum)
> +                       break;
> +
>                 idx = i;
>
>                 if (s->exit_latency_ns <= latency_req)
>
>
