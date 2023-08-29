Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0778BF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjH2HSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjH2HSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:18:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD7AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:18:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68becf931d0so2927241b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293515; x=1693898315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BqRNYCZJMuqwkS8J5nzIgac+oB4fmHjlDLUfYUepvCQ=;
        b=NDD0Dt882+3jNhDEszRXtGrWmYCInTBY9tR000JbtDWiflv88r6RawwSSQxSgZfUaq
         oynoAdi+vcnCKAx2+AiL1zqedRlQCmwwuHAnSCwZC7S74m769Jgy0Jbz7RtfkQbU/+qB
         FXJ6939xz53jpjNgfUtkC5/DwkdT9djk+lkhUOYHaMZeyPfAlFQGj9LJCB0HMGuttgrY
         w7J2RLfuIJrVSPCZrjmqDCZvcykSUUxHofH/QSs3b84LuOrJUUNlFrP2dcAfjudVak/H
         vOi+/1gks+IcB+Ccf8fEc+jtqVBCssG4KRRPPGpamrzH766KCNJmmQ3kKrOx/QXt6QHu
         sWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293515; x=1693898315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqRNYCZJMuqwkS8J5nzIgac+oB4fmHjlDLUfYUepvCQ=;
        b=mCWw1ZE8ZoYW/GLgHmJpM7iTkpNI2ZdpoDh7sesfHa+/Wvkcq+kj+Zyu9/NPHARsPX
         xCOED2HC+1tKJiqCN5TTZqkKQ60zsM4gJSxAjKSsphzJQrT45ZLHSSQzH8PBYxjdfXpr
         +0VK4a8dlaM1WaYIU3hOjHDYqS+txWISraO4i43lF6WzH0HbJMI8p4Iia6aMo/E3JWVE
         OKhSnL/432aRMTsbNemog9s0LGCSgnjgedwRnYOY28s3deiTi69YOkFxPgKBn4JHcOWw
         v2hgyMIL+BQv1dZj4BFk9Am7H31wHhu324XjtGL0J+cJbUtF4o746BiQfzyEdNyaKxSA
         24YQ==
X-Gm-Message-State: AOJu0Ywl6K9pU9WlxtIQwmpYDnqhMDowZ9MctbOwPi9wloz881guCpav
        6i9GdxMSbF+xLxE724Vw4nc3q60+QEsUwGpiZqjm2w==
X-Google-Smtp-Source: AGHT+IF6tTJk3blU2C4zjMQL9PZRJOU9YNYo+rsDtHMIxWGN45pIZMc/UJhMBkEXisMLgZWBmD533lZXSie1zBmEt84=
X-Received: by 2002:a05:6a00:174c:b0:68a:45a1:c0f2 with SMTP id
 j12-20020a056a00174c00b0068a45a1c0f2mr23667793pfc.34.1693293515068; Tue, 29
 Aug 2023 00:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtBSx7h1caR9g8wEK5GG2JMfSBRqSzLgjRUjrnp1Zc-ssg@mail.gmail.com>
 <87h6oqdq0i.ffs@tglx>
In-Reply-To: <87h6oqdq0i.ffs@tglx>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Aug 2023 09:18:23 +0200
Message-ID: <CAKfTPtDaN8ytQ2FHXkRXHk4AWz0xSi+pz_SseaDp=6JssRzWyg@mail.gmail.com>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 12:14, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Jun 29 2023 at 10:30, Vincent Guittot wrote:
> > On Thu, 29 Jun 2023 at 00:01, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>  int cpu_device_down(struct device *dev)
> >>  {
> >> -       return cpu_down(dev->id, CPUHP_OFFLINE);
> >> +       unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
> >> +
> >> +       if (cpu >= nr_cpu_ids)
> >> +               return -EBUSY;
> >> +
> >> +       return work_on_cpu(cpu, __cpu_device_down, dev);
> >
> > The comment for work_on_cpu :
> >
> >  * It is up to the caller to ensure that the cpu doesn't go offline.
> >  * The caller must not hold any locks which would prevent @fn from completing.
> >
> > make me wonder if this should be done only once the hotplug lock is
> > taken so the selected cpu will not go offline
>
> That makes sense. Updated and again untested patch below.
>
> Thanks,
>
>         tglx
> ---
> Subject: cpu/hotplug: Prevent self deadlock on CPU hot-unplug
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 23 Aug 2023 10:47:02 +0200
>
> Xiongfeng reported and debugged a self deadlock of the task which initiates
> and controls a CPU hot-unplug operation vs. the CFS bandwidth timer.
>
>     CPU1                                                 CPU2
>
> T1 sets cfs_quota
>    starts hrtimer cfs_bandwidth 'period_timer'
> T1 is migrated to CPU2
>                                                 T1 initiates offlining of CPU1
> Hotplug operation starts
>   ...
> 'period_timer' expires and is re-enqueued on CPU1
>   ...
> take_cpu_down()
>   CPU1 shuts down and does not handle timers
>   anymore. They have to be migrated in the
>   post dead hotplug steps by the control task.
>
>                                                 T1 runs the post dead offline operation
>                                                 T1 is scheduled out
>                                                 T1 waits for 'period_timer' to expire
>
> T1 waits there forever if it is scheduled out before it can execute the hrtimer
> offline callback hrtimers_dead_cpu().
>
> Cure this by delegating the hotplug control operation to a worker thread on
> an online CPU. This takes the initiating user space task, which might be
> affected by the bandwidth timer, completely out of the picture.
>
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/cpu.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1467,8 +1467,22 @@ static int __ref _cpu_down(unsigned int
>         return ret;
>  }
>
> +struct cpu_down_work {
> +       unsigned int            cpu;
> +       enum cpuhp_state        target;
> +};
> +
> +static long __cpu_down_maps_locked(void *arg)
> +{
> +       struct cpu_down_work *work = arg;
> +
> +       return _cpu_down(work->cpu, 0, work->target);
> +}
> +
>  static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  {
> +       struct cpu_down_work work = { .cpu = cpu, .target = target, };
> +
>         /*
>          * If the platform does not support hotplug, report it explicitly to
>          * differentiate it from a transient offlining failure.
> @@ -1477,7 +1491,15 @@ static int cpu_down_maps_locked(unsigned
>                 return -EOPNOTSUPP;
>         if (cpu_hotplug_disabled)
>                 return -EBUSY;
> -       return _cpu_down(cpu, 0, target);
> +
> +       /*
> +        * Ensure that the control task does not run on the to be offlined
> +        * CPU to prevent a deadlock against cfs_b->period_timer.
> +        */
> +       cpu = cpumask_any_but(cpu_online_mask, cpu);
> +       if (cpu >= nr_cpu_ids)
> +               return -EBUSY;
> +       return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
>  }
>
>  static int cpu_down(unsigned int cpu, enum cpuhp_state target)
