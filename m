Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8E7AD34B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjIYI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:27:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE22A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:27:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adca291f99so716360966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695630460; x=1696235260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JLzJEEtCTsx2ytyqcpgNQTyqzlBd0CFplvaB4DOG0o=;
        b=Q3paE99ZlpkNhvAelrP1/lOGJnh1xjU7eaNJ4E/VWyaVONZiH7OJ6SKV549ELYOO37
         5D77S8kEFlUHTb1yusnc4RcvUZcFkY4UL7km5BnLhGkQPl/tSnC3RwD6pLRbMcuMY+aO
         iENtrXQXfF1st9muQtAhdbX2qQe7INEDeg6PAlu46Qu/MCFLU3rxWuWsCXvUsyy24Q6q
         UHeJXn2C+UAjSZmifKTwAl7dlAsdFw5287JJ87tSQKcBFEhUS+EGEhCbdOMIR77imrlG
         UFp9Daa9FvNU8fH3g0loZ7qq1va2OUEylM+EUDDoyN52JT16JVY88yw2LcUDFsqXQwHV
         uhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630460; x=1696235260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JLzJEEtCTsx2ytyqcpgNQTyqzlBd0CFplvaB4DOG0o=;
        b=IzWA+IXWwqvmCNpPJKlk3ev0SJlMgJVBRHjYxQEzTnh8wmdpsBhBbWAUtUtp3HQ+Ci
         ZDmvizkOdPhWahsievhkNwAtaxq95wZvBuiSkL263/PacRzpXRR44+ta0rWo2+NqjhfC
         CsXJzneu3vXURDsZ8f+mCX1Z7Pr2U/ZObNUM4ClXo8YQB8lm4U0jDVEUs71uZhFtB+4l
         2t2eX7DVO59pIrhvfRJYROYgGs3i52ZBEF5DVMxMirpLY3rbYqiMLEJRLAeEGbh60bkV
         VB5mjlE4WwwsAnOqwxCok7I3Qq5ZKyhPGBUxaFyaqGfezALYylXv1GO3o+gQEovDIE8/
         YL0A==
X-Gm-Message-State: AOJu0YxGKrdnXVBKx47v5oEGCRqd+m+g5wBOjNxaTYdS9iIV/DEkQxZz
        pciuyj5rFZgolwAuATKMyCU=
X-Google-Smtp-Source: AGHT+IFh+TVlkqcS0O/lodW9E+1sdnFkbIasPXR+XiBPis0qvM4nsNnjhL3J7ejp2jny/ctr8CgZvQ==
X-Received: by 2002:a17:907:3da8:b0:9ae:420e:73a0 with SMTP id he40-20020a1709073da800b009ae420e73a0mr7544575ejc.69.1695630459561;
        Mon, 25 Sep 2023 01:27:39 -0700 (PDT)
Received: from gmail.com (195-38-113-94.pool.digikabel.hu. [195.38.113.94])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099df2ddfc37sm5980616ejc.165.2023.09.25.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:27:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 25 Sep 2023 10:27:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <ZRFEeGKGzE+dY6n6@gmail.com>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <20230815142121.MoZplZUr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815142121.MoZplZUr@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2023-08-11 12:20:44 [+0100], Valentin Schneider wrote:
> > Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
> > that has an empty pushable_tasks list, which means nothing useful will be
> > done in the IPI other than queue the work for the next CPU on the rto_mask.
> > 
> > rto_push_irq_work_func() only operates on tasks in the pushable_tasks list,
> > but the conditions for that irq_work to be queued (and for a CPU to be
> > added to the rto_mask) rely on rq_rt->nr_migratory instead.
> > 
> > nr_migratory is increased whenever an RT task entity is enqueued and it has
> > nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory includes a
> > rt_rq's current task. This means a rt_rq can have a migratible current, N
> > non-migratible queued tasks, and be flagged as overloaded / have its CPU
> > set in the rto_mask, despite having an empty pushable_tasks list.
> > 
> > Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable_task().
> > Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.
> > 
> > Note that the case where the current task is pushed away to make way for a
> > migration-disabled task remains unchanged: the migration-disabled task has
> > to be in the pushable_tasks list in the first place, which means it has
> > nr_cpus_allowed > 1.
> > 
> > Link: http://lore.kernel.org/r/20230801152648._y603AS_@linutronix.de
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> > This is lightly tested, this looks to be working OK but I don't have nor am
> > I aware of a test case for RT balancing, I suppose we want something that
> > asserts we always run the N highest prio tasks for N CPUs, with a small
> > margin for migrations?
> 
> I don't see the storm of IPIs I saw before. So as far that goes:
>    Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've applied Valentin's initial fix to tip:sched/core, for an eventual
v6.7 merge, as it addresses the IPI storm bug. Let me know if merging
this is not desirable for some reason.

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
>   so….
>   Now: rto_push_irq_work_func() run once once on CPU0, does nothing,
>   rto_next_cpu() return CPU0 again and enqueues itself again on CPU0.
>   Usually after the second or third round the scheduler on CPU0 makes
>   enough progress to remove the task/ clear the CPU from mask.

Just curious, any progress on solving this?

Thanks,

	Ingo
