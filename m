Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAD79BE93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjIKWVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjIKKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BEFFF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694429695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBDznZ1NcY+7kTzOq5QgicLpSsWwk7CW2AB2TmBxpc8=;
        b=Ov+WphyOECTU3yWjfXgiit/bYRRbkStobLFqg0FP0sJ7bhk28ClHdEwNETkEnHoRmDOmUn
        MsT5LRKjLThBzGLQmxDDR5pAQqUntk73W0mg8OrEQBZqKmUSHcPNSE/OwYY53tRBP8DqWT
        v+y7+uu0ttJlSiMBwqti4vNRaoBzIeM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-hYHPLJaKPSWdZzjZhVJEgQ-1; Mon, 11 Sep 2023 06:54:53 -0400
X-MC-Unique: hYHPLJaKPSWdZzjZhVJEgQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so32211345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694429692; x=1695034492;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBDznZ1NcY+7kTzOq5QgicLpSsWwk7CW2AB2TmBxpc8=;
        b=msXr3aEShmzfRuGMtK97EixAftLSLIEZ7t2yclcdmJc4iIfkVNlVQ8cmx55TiWdeZN
         m3wWKXtCTfqMlRoL8e/C1envhE96BChDgmdoKq21lq8hH/ccHIu9JPv92jykaId4ay82
         I3TMO+NNYMUvT9HvmNf66kA4TUaKefphXQqJc1iDjMeYQkbRfmmnq5olB8Pw0BFS6ME7
         QCFKTO+nbbopUbbL8F+hHyPLItU9jgRMDhm/WwHOBvGXON0RPbqri++D1ieqLfi8aOG8
         ojsfUvSoVTpAVXWxDrIhRn2eZaCUicY8aw0gKHB8zBlKSG2fTdOEQngfdR4iuK1on5gN
         0u2w==
X-Gm-Message-State: AOJu0Yz6zlhymCXhkuSfY0q8d+av+dY8UbkUPhcxHQXSt0wa8tJ6NG3T
        QqAvvX9vFDSJQGivJeVIsyq4wMinougt6ohlsq4nw4bHnkLDCwaPHl2ND29SxshFke89hLphIjI
        zoaHGNtlsdmYwTZ5Q3463CyCg
X-Received: by 2002:a05:600c:249:b0:3fe:d630:f568 with SMTP id 9-20020a05600c024900b003fed630f568mr7717355wmj.39.1694429692722;
        Mon, 11 Sep 2023 03:54:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50YB7Ue7xxaZk2iNmJa1z42Fnq+Igzt0pM0794Ssr0+h60H9NLHrzlrwiAa8iMSfy1Kc54w==
X-Received: by 2002:a05:600c:249:b0:3fe:d630:f568 with SMTP id 9-20020a05600c024900b003fed630f568mr7717347wmj.39.1694429692425;
        Mon, 11 Sep 2023 03:54:52 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c230900b003fe1a092925sm9598521wmo.19.2023.09.11.03.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:54:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Make rt_rq->pushable_tasks updates drive
 rto_mask
In-Reply-To: <20230815142121.MoZplZUr@linutronix.de>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <20230815142121.MoZplZUr@linutronix.de>
Date:   Mon, 11 Sep 2023 12:54:50 +0200
Message-ID: <xhsmhpm2prnd1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, back to this :)

On 15/08/23 16:21, Sebastian Andrzej Siewior wrote:
> What I still observe is:
> - CPU0 is idle. CPU0 gets a task assigned from CPU1. That task receives
>   a wakeup. CPU0 returns from idle and schedules the task.
>   pull_rt_task() on CPU1 and sometimes on other CPU observe this, too.
>   CPU1 sends irq_work to CPU0 while at the time rto_next_cpu() sees that
>   has_pushable_tasks() return 0. That bit was cleared earlier (as per
>   tracing).
>
> - CPU0 is idle. CPU0 gets a task assigned from CPU1. The task on CPU0 is
>   woken up without an IPI (yay). But then pull_rt_task() decides that
>   send irq_work and has_pushable_tasks() said that is has tasks left
>   so=E2=80=A6.
>   Now: rto_push_irq_work_func() run once once on CPU0, does nothing,
>   rto_next_cpu() return CPU0 again and enqueues itself again on CPU0.
>   Usually after the second or third round the scheduler on CPU0 makes
>   enough progress to remove the task/ clear the CPU from mask.
>

If CPU0 is selected for the push IPI, then we should have

  rd->rto_cpu =3D=3D CPU0

So per the

  cpumask_next(rd->rto_cpu, rd->rto_mask);

in rto_next_cpu(), it shouldn't be able to re-select itself.

Do you have a simple enough reproducer I could use to poke at this?

> I understand that there is a race and the CPU is cleared from rto_mask
> shortly after checking. Therefore I would suggest to look at
> has_pushable_tasks() before returning a CPU in rto_next_cpu() as I did
> just to avoid the interruption which does nothing.
>
> For the second case the irq_work seems to make no progress. I don't see
> any trace_events in hardirq, the mask is cleared outside hardirq (idle
> code). The NEED_RESCHED bit is set for current therefore it doesn't make
> sense to send irq_work to reschedule if the current already has this on
> its agenda.
>
> So what about something like:
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e50741153..d963408855e25 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2247,8 +2247,23 @@ static int rto_next_cpu(struct root_domain *rd)
>
>               rd->rto_cpu =3D cpu;
>
> -		if (cpu < nr_cpu_ids)
> +		if (cpu < nr_cpu_ids) {
> +			struct task_struct *t;
> +
> +			if (!has_pushable_tasks(cpu_rq(cpu)))
> +				continue;
> +

IIUC that's just to plug the race between the CPU emptying its
pushable_tasks list and it removing itself from the rto_mask - that looks
fine to me.

> +			rcu_read_lock();
> +			t =3D rcu_dereference(rq->curr);
> +			/* if (test_preempt_need_resched_cpu(cpu_rq(cpu))) */
> +			if (test_tsk_need_resched(t)) {

We need to make sure this doesn't cause us to loose IPIs we actually need.

We do have a call to put_prev_task_balance() through entering __schedule()
if the previous task is RT/DL, and balance_rt() can issue a push
IPI, but AFAICT only if the previous task was the last DL task. So I don't
think we can do this.

> +				rcu_read_unlock();
> +				continue;
> +			}
> +			rcu_read_unlock();
> +
>                       return cpu;
> +		}
>
>               rd->rto_cpu =3D -1;
>
> Sebastian

