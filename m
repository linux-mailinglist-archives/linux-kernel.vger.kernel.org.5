Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE97F7863
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345908AbjKXP4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjKXP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:56:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06CD53
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:56:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2856cdb4c09so1337786a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700841376; x=1701446176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B3cboSartCpNqBP467JzWOycu78vu4u6V0sVuqE6qUk=;
        b=KQVOPlD92Oc/EbOd61M/iSaYw4eyYY+zsC4bq0GVDppQ4ScXvH2ZjhUTNjDbolyAZJ
         dSlO1OJepBLBE2E85npxxSSRMkrGmmGoNdGUsLFASpGyQZBKJiYwz/sxiGGtXZ7wuECV
         oIgCbT1d4HlMM2YDvhsIp2xQYNqL31FJD7wSFfcth/X2DCGArVVDkVNKyeLi4PXvElpc
         b9pJEQuU2r1fHxiKkIiQL1++axy69ylJs2CtV/DBgEgCD/e27FgrwWiv2YnuocorCQEz
         bNXGlblq+lph5tiP9scF5tCOYK/ZRR/anoLVZaurB1dElZVYc2c8cM9zDBryvaS7icqZ
         RbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700841376; x=1701446176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3cboSartCpNqBP467JzWOycu78vu4u6V0sVuqE6qUk=;
        b=qIashDeB448lWDZ1Zr41aLfjSFS9xeWCVhaV0RPB7/spr7C26Gl5NxY5PMvpHzOt/C
         dmRAEv0Sjh8DbnvOoFa77vpTGBlnKZ0u7LCLV5R31gg1pTgwhAUDNpJxtRUxbKrRIvS2
         4Y+3/EpDVeyRT7dVkGEhSx1nrtX31SS8+aXmHFojfuitDC3x6fvBGky+D7uWxcr+yzVW
         A0ISV4I914iyH6aqjiiml4GDDeRGIsCi0bR1WqToalnyl7emR2ikcUnKpXYZ3o3wiiPr
         Pn7nX1hcAyARVsYyU1EIwwzKJPlLITMN/VVP8wwaVpsNINSJCKNhuWYjqVvraGT3kynV
         ZzeQ==
X-Gm-Message-State: AOJu0YyfdgcCLO8aY9U84j7LpYrMwkFVwy7R+d2u0FwgmjRuCSK0EFDU
        eMuPNeL7TfSfUfW5/gcWCJCeJi0vbOR9QsyvD79gHQ==
X-Google-Smtp-Source: AGHT+IGr7VW4QXdTKrRd6wnh+4HDV0Ip13TDSxMSbU3RIaCK4wWa4OOszqNXz7DmnTyhBUwP4uvg54S1meXdoOKM8Dk=
X-Received: by 2002:a17:90b:4f44:b0:285:8d5b:631f with SMTP id
 pj4-20020a17090b4f4400b002858d5b631fmr2503597pjb.5.1700841376098; Fri, 24 Nov
 2023 07:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20231124153323.3202444-1-pierre.gondois@arm.com>
In-Reply-To: <20231124153323.3202444-1-pierre.gondois@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Nov 2023 16:56:04 +0100
Message-ID: <CAKfTPtDfNMMV=jzmUHkWeEBu2Rkk-BdJ3Oo2tTsT-HR_WOYSjw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Use all little CPUs for CPU-bound workload
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 16:33, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Running n CPU-bound tasks on an n CPUs platform:
> - with asymmetric CPU capacity
> - not having SD_SHARE_PKG_RESOURCES flag set at the DIE
>   sched domain level (i.e. not DynamIQ systems)

Nit:  SD_SHARE_PKG_RESOURCES is never set at the DIE level. In case of
DynamIQ systems, all CPUs are in the same MC level which has
SD_SHARE_PKG_RESOURCES flag

> might result in a task placement where two tasks run on a big CPU
> and none on a little CPU. This placement could be more optimal by
> using all CPUs.
>
> Testing platform:
> Juno-r2:
> - 2 big CPUs (1-2), maximum capacity of 1024
> - 4 little CPUs (0,3-5), maximum capacity of 383
>
> Testing workload ([1]):
> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
> is affine to a CPU, except for:
> - one little CPU which is left idle.
> - one big CPU which has 2 tasks affine.
> After the 100ms (step 2), remove the cpumask affinity.
>
> Before patch:
> During step 2, the load balancer running from the idle CPU tags sched
> domains as:
> - little CPUs: 'group_has_spare'. Indeed, 3 CPU-bound tasks run on a
>   4 CPUs sched-domain, and the idle CPU provides enough spare
>   capacity.
> - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
>   sched-domain, so the following path is used:
>   group_is_overloaded()
>   \-if (sgs->sum_nr_running <= sgs->group_weight) return true;
>
>   The following path which would change the migration type to
>   'migrate_task' is not taken:
>   calculate_imbalance()
>   \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
>   as the local group has some spare capacity, so the imbalance
>   is not 0.
>
> The migration type requested is 'migrate_util' and the busiest
> runqueue is the big CPU's runqueue having 2 tasks (each having a
> utilization of 512). The idle little CPU cannot pull one of these
> task as its capacity is too small for the task. The following path
> is used:
> detach_tasks()
> \-case migrate_util:
>   \-if (util > env->imbalance) goto next;
>
> After patch:
> As the number of failed balancing attempts grows (with
> 'nr_balance_failed'), progressively make it easier to migrate
> a big task to the idling little CPU. A similar mechanism is
> used for the 'migrate_load' migration type.
>
> Improvement:
> Running the testing workload [1] with the step 2 representing
> a ~10s load for a big CPU:
> Before patch: ~19.3s
> After patch: ~18s (-6.7%)
>
> Similar issue reported at:
> https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/
>
> v1:
> https://lore.kernel.org/all/20231110125902.2152380-1-pierre.gondois@arm.com/
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df348aa55d3c..53c18fd23ae7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8907,7 +8907,7 @@ static int detach_tasks(struct lb_env *env)
>                 case migrate_util:
>                         util = task_util_est(p);
>
> -                       if (util > env->imbalance)
> +                       if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
>                                 goto next;
>
>                         env->imbalance -= util;
> --
> 2.25.1
>
