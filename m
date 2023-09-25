Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9347AD7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjIYMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIYMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2713A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695643746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMv39o9lijlSjESvhBhV0+AG780iiHA17nAzBVo3xpc=;
        b=YXG4h1OF/kbT83bahAE5MRlzf164h4fmgWfdvXZ4qAjR2UPvNyqb1MK2jV6zYQaCs+gvbt
        8ImxG3Qm4p/cIfSfcHjOtXcINTysu1X6y5ci/ndWlOESNN9IYrAYA4UnuuxSYLN8OrZVXm
        B2eU/kPEYCp7UIOAw4Uxbjnb9eEcn/M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-BVc3j_W-NviDriw3qRD5gA-1; Mon, 25 Sep 2023 08:09:04 -0400
X-MC-Unique: BVc3j_W-NviDriw3qRD5gA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4052d1b19f8so54203585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643743; x=1696248543;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMv39o9lijlSjESvhBhV0+AG780iiHA17nAzBVo3xpc=;
        b=KnahZbn2aD+Q/aUYZn0PN3L0A5H8juGpYTCMw86cZ/wufseS5D0B2DXIYWiVxMldr1
         tNODr7o0bK3/wyEPq8PnS40SqWmhjsq+QQzl1htLqIUEzFqGWctK7LFShSnyoeW4HMfv
         maAG14ng6gkQQfHhZM68MzgcG5BnFRJ27Y4ApZCDdePIxicE+QAMjaRqgwwgDUYgkPbX
         exX0tm19PRhFtqhGla3UJoo/wzTJM5Ha89AwDusN7NjWA+P8BDW5YKBh5qRkXycTgVbR
         Wj/4458L8KhUSmcwfK3aIL2X+67b/Q4PytZr3QA5neFUChg2Vpd0LXH8L24e6qaWrkiw
         FfSw==
X-Gm-Message-State: AOJu0YyzpSCmNibksuwkCTRbuo0hx2d58ex5uN1/pYnrEcUV67WXvmfA
        4dt48FIcVs0pBfMK2e49lmfwS/UP/E09XZmISAO+Fd41JntPWeq+SqN2j6ikQzaaivrAR3nE1uA
        ROP+7quVAvR5es8TUW0zvtHg9
X-Received: by 2002:a7b:ca56:0:b0:3fb:df34:176e with SMTP id m22-20020a7bca56000000b003fbdf34176emr5482636wml.31.1695643743657;
        Mon, 25 Sep 2023 05:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaPxKWEoCxold6XlTzBOsCN82J51qmdRy6r+1BpX0egmvh8NmdO7MvDkxZwcnvpdZcJiOcOA==
X-Received: by 2002:a7b:ca56:0:b0:3fb:df34:176e with SMTP id m22-20020a7bca56000000b003fbdf34176emr5482615wml.31.1695643743304;
        Mon, 25 Sep 2023 05:09:03 -0700 (PDT)
Received: from vschneid.remote.csb ([80.214.159.242])
        by smtp.gmail.com with ESMTPSA id n6-20020a1c7206000000b003fe4ca8decdsm14943110wmc.31.2023.09.25.05.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:09:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
In-Reply-To: <ZRFEeGKGzE+dY6n6@gmail.com>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <20230815142121.MoZplZUr@linutronix.de> <ZRFEeGKGzE+dY6n6@gmail.com>
Date:   Mon, 25 Sep 2023 14:09:00 +0200
Message-ID: <xhsmh4jjiv4ir.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/23 10:27, Ingo Molnar wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> On 2023-08-11 12:20:44 [+0100], Valentin Schneider wrote:
>> > Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
>> > that has an empty pushable_tasks list, which means nothing useful will=
 be
>> > done in the IPI other than queue the work for the next CPU on the rto_=
mask.
>> >=20
>> > rto_push_irq_work_func() only operates on tasks in the pushable_tasks =
list,
>> > but the conditions for that irq_work to be queued (and for a CPU to be
>> > added to the rto_mask) rely on rq_rt->nr_migratory instead.
>> >=20
>> > nr_migratory is increased whenever an RT task entity is enqueued and i=
t has
>> > nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory incl=
udes a
>> > rt_rq's current task. This means a rt_rq can have a migratible current=
, N
>> > non-migratible queued tasks, and be flagged as overloaded / have its C=
PU
>> > set in the rto_mask, despite having an empty pushable_tasks list.
>> >=20
>> > Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable=
_task().
>> > Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.
>> >=20
>> > Note that the case where the current task is pushed away to make way f=
or a
>> > migration-disabled task remains unchanged: the migration-disabled task=
 has
>> > to be in the pushable_tasks list in the first place, which means it has
>> > nr_cpus_allowed > 1.
>> >=20
>> > Link: http://lore.kernel.org/r/20230801152648._y603AS_@linutronix.de
>> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> > ---
>> > This is lightly tested, this looks to be working OK but I don't have n=
or am
>> > I aware of a test case for RT balancing, I suppose we want something t=
hat
>> > asserts we always run the N highest prio tasks for N CPUs, with a small
>> > margin for migrations?
>>=20
>> I don't see the storm of IPIs I saw before. So as far that goes:
>>    Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> I've applied Valentin's initial fix to tip:sched/core, for an eventual
> v6.7 merge, as it addresses the IPI storm bug. Let me know if merging
> this is not desirable for some reason.
>
>> What I still observe is:
>> - CPU0 is idle. CPU0 gets a task assigned from CPU1. That task receives
>>   a wakeup. CPU0 returns from idle and schedules the task.
>>   pull_rt_task() on CPU1 and sometimes on other CPU observe this, too.
>>   CPU1 sends irq_work to CPU0 while at the time rto_next_cpu() sees that
>>   has_pushable_tasks() return 0. That bit was cleared earlier (as per
>>   tracing).
>>=20
>> - CPU0 is idle. CPU0 gets a task assigned from CPU1. The task on CPU0 is
>>   woken up without an IPI (yay). But then pull_rt_task() decides that
>>   send irq_work and has_pushable_tasks() said that is has tasks left
>>   so=E2=80=A6.
>>   Now: rto_push_irq_work_func() run once once on CPU0, does nothing,
>>   rto_next_cpu() return CPU0 again and enqueues itself again on CPU0.
>>   Usually after the second or third round the scheduler on CPU0 makes
>>   enough progress to remove the task/ clear the CPU from mask.
>
> Just curious, any progress on solving this?
>

On my side not really, I need to stop getting distracted and probably get
this to reproduce on a system so I can understand-by-tracing

> Thanks,
>
> 	Ingo

