Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D784F80CF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjLKPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjLKPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:23:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB287DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:24:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so3851071a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702308244; x=1702913044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWUV51STMN0VgL/zumYMl796XbfCKLjzTV15/TIMxFc=;
        b=OaDxGuWt2M6ux348sqeA5EEori9DTiYjpCE6vofQh7TP06+BLsDDrfWRqps/l1rRlA
         tjCOVnBFCpVxCxfg6jAL6dTcs8TUMpWjdVlamqgRynbH1edCMWtKmrHxpriM/yliBF8S
         VSFTa57vOZ4p4tUp3N+d4H3uQsHuiexxmCrVFzIjO3g3+eUN1mA/qxaylArISSXOiDxy
         WBKfUhuowJsbTLRFlUeQAeb4ycs4vQdvTfLqDOo7He5chRXDpP6W9gi9qPz8/ExL+ww2
         ibDpNQgzzC0CToIlOxQolr6C463WZqD2TkFzDpyobSbudGFT4OdiBkVdTpnbk33M1sVv
         j4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308244; x=1702913044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWUV51STMN0VgL/zumYMl796XbfCKLjzTV15/TIMxFc=;
        b=SXS8H6JE0A2VobRAczOS8Q/84xWktLkPXUHjhRQloRCMZ5+PzAtMwQdOQMe2/V3EQp
         TmAjsubo55nOJ3iCTi+0YO+UUFPwJieuJOVgRh6P1LSF5v0msl/3W7SPjqmlF1X8U4iX
         8mwB7CsUdRN81uXsdSrGTSvyNKICcjtQ+mD39WGPFiIZJU9ZeN+30QAk29g+zx/6iiEF
         O81T+gT+7RY6MVwoXGVduluBWBkGMPm6yp4qCTmL0v+vI043r3wDdtigKs+Svs39M4hd
         ySXG41KkVCuiWVwf55H6RoL8FbGWB8qCLuWLCxo48GEdCw5wwdKUIY4Z0ROoSXWFKiyB
         sGJQ==
X-Gm-Message-State: AOJu0YyEvakVitGZbDCJImHpiFc8tazK/Ton2mmna1xoNIB03Jy81bx9
        ONkBC/X2cIfPMgxRFvzTD8YdklOn/YgjeWeBSOl/mw==
X-Google-Smtp-Source: AGHT+IGUtayhIpWLJiLhiSMxDhVNzBpxfuIdsijKeP2UMDS67wo5Ue3DSQ5EuOS7E+5p+jZlIezV4PaVm727wxGEVXk=
X-Received: by 2002:a05:6a20:8f1e:b0:18f:97c:9768 with SMTP id
 b30-20020a056a208f1e00b0018f097c9768mr5443169pzk.80.1702308244327; Mon, 11
 Dec 2023 07:24:04 -0800 (PST)
MIME-Version: 1.0
References: <202312101719+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312101719+0800-wangjinchao@xfusion.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Dec 2023 16:23:52 +0100
Message-ID: <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
To:     WangJinchao <wangjinchao@xfusion.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 at 10:22, WangJinchao <wangjinchao@xfusion.com> wrote:
>
> 1. The code below is duplicated in two for loops and need to be
>    consolidated
> 2. Fix the bug where a se's on_rq is true but its parent is not

Could you clarify which bug you want to fix ?




>
> ```c
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running += idle_h_nr_running;
>
>                 if (cfs_rq_is_idle(cfs_rq))
>                         idle_h_nr_running = 1;
>
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> ```
>
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>  kernel/sched/fair.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..e1373bfd4f2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6681,30 +6681,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>
>         for_each_sched_entity(se) {
> -               if (se->on_rq)
> -                       break;
>                 cfs_rq = cfs_rq_of(se);
> -               enqueue_entity(cfs_rq, se, flags);
> -
> -               cfs_rq->h_nr_running++;
> -               cfs_rq->idle_h_nr_running += idle_h_nr_running;
> -
> -               if (cfs_rq_is_idle(cfs_rq))
> -                       idle_h_nr_running = 1;
> -
> -               /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> -                       goto enqueue_throttle;
> -
> -               flags = ENQUEUE_WAKEUP;
> -       }
> -
> -       for_each_sched_entity(se) {
> -               cfs_rq = cfs_rq_of(se);
> -
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> -               se_update_runnable(se);
> -               update_cfs_group(se);
> +               if (se->on_rq) {
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
> +                       se_update_runnable(se);
> +                       update_cfs_group(se);
> +               } else {
> +                       enqueue_entity(cfs_rq, se, flags);
> +                       flags = ENQUEUE_WAKEUP;
> +               }
>
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running += idle_h_nr_running;
> --
> 2.40.0
>
