Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C17C8843
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJMPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjJMPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:04:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC0BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27ce05a23e5so2614535a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697209484; x=1697814284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrvZd09AGvkjj6qNe7BrYdhu10Aho9VVq5h2SvH27BU=;
        b=TUAGCeKpL85jIxofdrKiyoOWi0V4pKnIao3UkQFmwhpao58DZImUj0t2YQXt+4qS+R
         9xfm0rKiqsdt3R/yRabHS+o20IgcunLmXTG9iAeLfuO8rRroia2FIn867ajm4SgdlTEG
         iYZZudRXSw4ybdmn9x5IVm6WLpheenR3omtdqKoH7v/Qhj7Oa1y/N6C0nqOdw6/rXNMn
         7t13oOKjI4n7XqMZ0F71pqlmGO9k9W32HMdJ8DghrwriPj2Se3DuC+ag9uEi5uRd16rx
         H/t7TO9DhDO671y5e4nLsrah4NO0VPZZCVmK10lwiNvrsDfQFgzIVjOOAwUPd6PJOq3y
         RMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209484; x=1697814284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrvZd09AGvkjj6qNe7BrYdhu10Aho9VVq5h2SvH27BU=;
        b=E0+yFFaFbl1ZlplVRjmzyL5zrPkocevMQduVDSh131QAtYH3HHe0xfkrNuZXolHJ6e
         IHb7cU1FWhX26bf8379FA94K5WfhQQyjLNQySUE+LgN7epXNmVh3p9mRDVZrV7RKTRN6
         ot3DNA5SjrL11drv0ilXmtyVIlWbakdHStxJ2etV9oLTIxq86kXnyAP9uwkfe/AwUq2K
         hvwM1ulpfli6uCN7VmVB15yKWlu0J10fjhhw+gfnMExKZ0P9F98Mo1I//KETUetLKH8m
         17jzIhQAJU6pdlSOuqsv7vk7PgIVBrHVVFiydqJFzEQlb08iRmKhVQCCmlWXV4L6yuQ8
         KMTQ==
X-Gm-Message-State: AOJu0YyIGRAxC4+JQ8alOnbGKEC6s4CVaCoVp8knZWFMyTZVwF+o6b/t
        OW1Rlz77RMa3QgiQj/fqxQVcoLxSmfrsu2WQG6GmYA==
X-Google-Smtp-Source: AGHT+IFPvB9jkBSwEEc+ebSPMWLIR1i+Mq0Q4UO+LJHn8J7xYBEhRSrff4eXeV0QVkz8JPXDmi050wLVjvriK9rKQwE=
X-Received: by 2002:a17:90a:f995:b0:27c:df02:88b3 with SMTP id
 cq21-20020a17090af99500b0027cdf0288b3mr560897pjb.8.1697209483941; Fri, 13 Oct
 2023 08:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121707.51368-1-yangyicong@huawei.com> <20231012121707.51368-4-yangyicong@huawei.com>
In-Reply-To: <20231012121707.51368-4-yangyicong@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Oct 2023 17:04:32 +0200
Message-ID: <CAKfTPtAdtjZobtrf846kDzscAZTrFxw21SQJbbHU0Cw35vggEQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] sched/fair: Use candidate prev/recent_used CPU if
 scanning failed for cluster wakeup
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, tim.c.chen@linux.intel.com,
        yu.c.chen@intel.com, gautham.shenoy@amd.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 14:19, Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Chen Yu reports a hackbench regression of cluster wakeup when
> hackbench threads equal to the CPU number [1]. Analysis shows
> it's because we wake up more on the target CPU even if the
> prev_cpu is a good wakeup candidate and leads to the decrease
> of the CPU utilization.
>
> Generally if the task's prev_cpu is idle we'll wake up the task
> on it without scanning. On cluster machines we'll try to wake up
> the task in the same cluster of the target for better cache
> affinity, so if the prev_cpu is idle but not sharing the same
> cluster with the target we'll still try to find an idle CPU within
> the cluster. This will improve the performance at low loads on
> cluster machines. But in the issue above, if the prev_cpu is idle
> but not in the cluster with the target CPU, we'll try to scan an
> idle one in the cluster. But since the system is busy, we're
> likely to fail the scanning and use target instead, even if
> the prev_cpu is idle. Then leads to the regression.
>
> This patch solves this in 2 steps:
> o record the prev_cpu/recent_used_cpu if they're good wakeup
>   candidates but not sharing the cluster with the target.
> o on scanning failure use the prev_cpu/recent_used_cpu if
>   they're still idle
>
> [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
> Reported-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/sched/fair.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4039f9b348ec..f1d94668bd71 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7392,7 +7392,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         bool has_idle_core = false;
>         struct sched_domain *sd;
>         unsigned long task_util, util_min, util_max;
> -       int i, recent_used_cpu;
> +       int i, recent_used_cpu, prev_aff = -1;
>
>         /*
>          * On asymmetric system, update task utilization because we will check
> @@ -7425,6 +7425,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>
>                 if (cpus_share_resources(prev, target))
>                         return prev;
> +
> +               prev_aff = prev;
>         }
>
>         /*
> @@ -7457,6 +7459,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>
>                 if (cpus_share_resources(recent_used_cpu, target))
>                         return recent_used_cpu;
> +       } else {
> +               recent_used_cpu = -1;
>         }
>
>         /*
> @@ -7497,6 +7501,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> +       /*
> +        * For cluster machines which have lower sharing cache like L2 or
> +        * LLC Tag, we tend to find an idle CPU in the target's cluster
> +        * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> +        * use them if possible when no idle CPU found in select_idle_cpu().
> +        */
> +       if ((unsigned int)prev_aff < nr_cpumask_bits &&
> +           (available_idle_cpu(prev_aff) || sched_idle_cpu(prev_aff)))

Hasn't prev_aff (i.e. prev) been already tested as idle ?

> +               return prev_aff;
> +       if ((unsigned int)recent_used_cpu < nr_cpumask_bits &&
> +           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
> +               return recent_used_cpu;

same here


> +
>         return target;
>  }
>
> --
> 2.24.0
>
