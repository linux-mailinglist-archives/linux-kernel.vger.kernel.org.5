Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82A808ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443629AbjLGRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443502AbjLGRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:22:38 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE56173C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:22:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c25973988so13001995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701969755; x=1702574555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gL+iuAl9736+TvxQ8c5EEr5L0k9HFVSI65Y+bF9DK+4=;
        b=QZsH83K21U7WM0sf8jDYmBQDw/Guiu6w2xIJlRFfzIQCfONf2WFuetYQ4kPA9cvl6n
         YoK44KkRrep+CXdkrNJC+ZSeCAg3ZzgSpffGMtOGVl4zDw9H8PTZPUCLhfkZHyTrFpjy
         JjMsej1PVjuDCUUmBdQhfC/wYHkORCv7FGlP2HdGGE8Fi7extRk/DGy6atD087YA/MFH
         ZRZ8J68voN1FnEAkTRtp2+JlSejHTGgUeY98Si+crJGYyGUsVkHxiZjrfYUlE6f5sJ+L
         1NBsRvZncFjWIxXEW+wxUaupHINuiUHi2cvWM7zJlgv/EPwQxXVYijcdzNNxjE+szcU1
         GLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969755; x=1702574555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL+iuAl9736+TvxQ8c5EEr5L0k9HFVSI65Y+bF9DK+4=;
        b=xUj2kkxaYq0lyCpXWzCJY7UVKqJDYxkUkPyS8S0J1+8SBx0tUfrm272zb9ox5RAJkH
         /4AgvUKVK7uonSZbezI5GxQspOQBtpz4XhPQvvsuxVHd2xWzQOjoEUDxfsz9+w+9Qs6/
         gz1odO/RtBeTXufxdRFbHaEDq6jpdEBHOW2hi4MjzldX3KgYnnCxUmvtvd3DIDELWK+3
         c/RVTOSg80+cpfUSIdGNCzSfvielnpuyKfTkcMh0PZaqjCc8mJ/SowAMI9Y/CKGag7DH
         ona+I1I67VyMWDVtoBZQ5amSvbQgra/X0CWmHbnix2s7htQS3mOIX4Wiv3bkvinF8F+0
         EShQ==
X-Gm-Message-State: AOJu0Yy7X8CQ8AnV/kbDf6QCFUtTYIiRgSL1txcF2XadwfZAuODH5k+A
        tq0unbFMofLGKanoioZpW3IweKD/siwf9ZVDjto=
X-Google-Smtp-Source: AGHT+IHTsSp+5odReKkPs9OwYSxu7ZGMyfeXpuIlB6UdCOP3zmNtV1WOmpOE0sNKIZ1lyLSSL6sl5w==
X-Received: by 2002:a05:600c:354f:b0:40c:f4d:60a6 with SMTP id i15-20020a05600c354f00b0040c0f4d60a6mr1827016wmq.44.1701969754846;
        Thu, 07 Dec 2023 09:22:34 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm146390wra.12.2023.12.07.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:22:34 -0800 (PST)
Date:   Thu, 7 Dec 2023 17:22:33 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] sched/fair: Use all little CPUs for CPU-bound workload
Message-ID: <20231207172233.r6gx4tffcmzai2pf@airbuntu>
References: <20231206090043.634697-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206090043.634697-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/23 10:00, Pierre Gondois wrote:
> Running n CPU-bound tasks on an n CPUs platform:
> - with asymmetric CPU capacity
> - not being a DynamIq system (i.e. having a PKG level sched domain
>   without the SD_SHARE_PKG_RESOURCES flag set)
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
> - little CPUs: 'group_has_spare'. Cf. group_has_capacity() and
>   group_is_overloaded(), 3 CPU-bound tasks run on a 4 CPUs
>   sched-domain, and the idle CPU provides enough spare capacity
>   regarding the imbalance_pct
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
> v2:
> https://lore.kernel.org/all/20231124153323.3202444-1-pierre.gondois@arm.com/
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---

Thanks Pierre! I think this is a good candidate to stable. It is likely to help
some folks shipping with phantom domains on impacted stable kernels.


Cheers

--
Qais Yousef
