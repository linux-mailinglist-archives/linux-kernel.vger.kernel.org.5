Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9357CF86B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbjJSMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjJSMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:10:23 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CDD6D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:08:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789aed0e46so60158185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697717339; x=1698322139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4tv7L3CKLORBtaOIWt8KkvkWsJtfoDrj0UfoXf86F8=;
        b=BkAPGqUJblQAKDCwVFa825TZxHuBYXl9QIqdqq6jNhKkZ2CmHCAvfVGBKk+NHkzvQC
         ggUoQYzDPB9XHNkL3fe/04kKY5Cv0b06Nzdho84PDR2qUyHllTxF/p6pVfMI2GjilJRq
         92PsTqJBrUUnAfQBSbRX97fC26TOqbEkw4DK5kegiVixZyXVhky1S1k4EnKlfwA9i+KL
         LDMMK6T0YMZtu0D1sKOea9JDozRyIcaOR04q7HWsdMvIUcnZzcV21ZPWS5Kr4Wkg7uD2
         ggU9YB4jG+f892VFn8auTk+NEzGiAU5OKQcYzuozPA+6jiszvhTyGzynS+nrMotg+gmd
         ZpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717339; x=1698322139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4tv7L3CKLORBtaOIWt8KkvkWsJtfoDrj0UfoXf86F8=;
        b=ige0CE045SuvxmNd++3DG5ybNHynBKaWKBh7m9LL7s3nDKwbrHXYo0p6kSwedPD4lX
         SEgio6XcMgPMwFV6dKnYd9FfBxJVqJoW+lzZBc7Q/IEOpj6oaKBf8z75fQIhlkw9iIxt
         aklWoX8VTfg40y0FOUOIvpZhq5PpiXruY/i3TAzib50RM3WZAtzVk+Z8KNnKSmwpIkzS
         ZBqVIhnINreEGXTB31MCcsi+KUz6oEP6tAJca67l4M6ZO1WJXNbsgb0jTn5jj6Owzd7P
         n7W0u51XAwcxCQTKeRRtUIK5SUz1yRZ1oyda02LchcTaS/P5B+iQuSuqCpVY9KfvrdZa
         a+kg==
X-Gm-Message-State: AOJu0YxkAZEc8wZzWpxJGu3zoXMxcjdpMNspzzVfE+2Qz7gUU+SYAB/R
        gcCziFrpOo0PHDQ0F3HlBbkNQpEUjrRtj/DV0U+bEw==
X-Google-Smtp-Source: AGHT+IE6nPZ+FwMi91zTNGiipFcUGE5Guuu+1fDcHDRmGu2d1FMXCM6mJWAB9xtMkB7aVk4pZm/DegNqaMuCLAQX2lA=
X-Received: by 2002:a05:6214:248e:b0:656:51b9:990e with SMTP id
 gi14-20020a056214248e00b0065651b9990emr2378325qvb.57.1697717338910; Thu, 19
 Oct 2023 05:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231019033323.54147-1-yangyicong@huawei.com> <20231019033323.54147-4-yangyicong@huawei.com>
In-Reply-To: <20231019033323.54147-4-yangyicong@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Oct 2023 14:08:47 +0200
Message-ID: <CAKfTPtDji=JQPCTuQEn7RSe2ga4m4Am20nSh_Qyj4kVz+9UGNA@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] sched/fair: Use candidate prev/recent_used CPU if
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 05:36, Yicong Yang <yangyicong@huawei.com> wrote:
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
>   they're recorded as idle
>
> [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
>
> Reported-by: Chen Yu <yu.c.chen@intel.com>
> Closes: https://lore.kernel.org/all/ZGsLy83wPIpamy6x@chenyu5-mobl1/
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02d842df5294..d508d1999ecc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7346,7 +7346,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         bool has_idle_core = false;
>         struct sched_domain *sd;
>         unsigned long task_util, util_min, util_max;
> -       int i, recent_used_cpu;
> +       int i, recent_used_cpu, prev_aff = -1;
>
>         /*
>          * On asymmetric system, update task utilization because we will check
> @@ -7379,6 +7379,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>
>                 if (cpus_share_resources(prev, target))
>                         return prev;
> +
> +               prev_aff = prev;
>         }
>
>         /*
> @@ -7411,6 +7413,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>
>                 if (cpus_share_resources(recent_used_cpu, target))
>                         return recent_used_cpu;
> +       } else {
> +               recent_used_cpu = -1;
>         }
>
>         /*
> @@ -7451,6 +7455,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> +       /*
> +        * For cluster machines which have lower sharing cache like L2 or
> +        * LLC Tag, we tend to find an idle CPU in the target's cluster
> +        * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> +        * use them if possible when no idle CPU found in select_idle_cpu().
> +        */
> +       if ((unsigned int)prev_aff < nr_cpumask_bits)
> +               return prev_aff;
> +       if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
> +               return recent_used_cpu;
> +
>         return target;
>  }
>
> --
> 2.24.0
>
