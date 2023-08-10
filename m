Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645667773CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjHJJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjHJJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688972694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSFGqycHh49+Z88x3ftzV9NKc5I098/nCUSm/1FRe3w=;
        b=TvpAhmPsMK4eI0S8TsxlqsGPHZsUxZRrtvGpH+I6w8SLB2CxVFupDUDic1K6hlz/H56DWb
        prga66CNMHYxkesIn/na/1rz5L/VQTWmXe3uCGafJmthaRrw8xG3TEpLFxkfDud4eoATUW
        1MvMjMkf35X4DRBDs1HntyCm0tcBUiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-yTSuzr0WMjujAn2eoJWsZQ-1; Thu, 10 Aug 2023 05:09:26 -0400
X-MC-Unique: yTSuzr0WMjujAn2eoJWsZQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe13f529f5so4806355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658565; x=1692263365;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSFGqycHh49+Z88x3ftzV9NKc5I098/nCUSm/1FRe3w=;
        b=KeG6oUtblccqt3mQ8Dp3IROq9F8NcF3sFDw2DZoE98damOa08r/WgIDpYHdYTqm5m5
         OfHi+YiW5HurK1ekA8RlP4kICNQzQU3CnaAV+HDp6wqR9J0X+cdvEa+4QpB3iPfrqo4X
         L+/8fPAbK9KlBhN/MmO/L10JSsxkab/bhaqwaDflEN+N3Ttv52+0B97lS3t3i0s06zz1
         7gSKBLK7xyIsZ3kTXgkEd9GX54VBJrPBIGev+wYYa0AVCMqzzbsM2P2+tXbZNkmaJAVx
         JDBXAn8bU8J9dq+96KFcfhe95w4FGPXOATkHcBKas6AxHXSCK5ZMGQkt6/tAkXR5Q6jP
         l6lg==
X-Gm-Message-State: AOJu0YwaROuWP0vfTbHr1UAYJm0/YHypv94m1LtOiqSIg8YgaGfnf4vw
        9Q/mY3Yu7GMwSs1aakaHSuSBSFFxqkTkb+bEqAQyHWHgYHNSd0M0w2kA0b/UkcjqbC5uRTaGHni
        9awRkQB5/V7IYx0VBgibDS0dz
X-Received: by 2002:a1c:7c1a:0:b0:3fe:f45:774c with SMTP id x26-20020a1c7c1a000000b003fe0f45774cmr1365356wmc.41.1691658565213;
        Thu, 10 Aug 2023 02:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVImji8eqj+phT1SuUFBVseGZpYWcQ3Euzn2HIufZ766fpm95lwp0DJqdc1uJGkJWq05ir+Q==
X-Received: by 2002:a1c:7c1a:0:b0:3fe:f45:774c with SMTP id x26-20020a1c7c1a000000b003fe0f45774cmr1365339wmc.41.1691658564940;
        Thu, 10 Aug 2023 02:09:24 -0700 (PDT)
Received: from vschneid.remote.csb ([93.186.150.163])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b003142c85fbcdsm1495432wrv.11.2023.08.10.02.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:09:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Don't try push tasks if there are none.
In-Reply-To: <20230810080708.L4nV_aKI@linutronix.de>
References: <20230801152648._y603AS_@linutronix.de>
 <xhsmhv8dob13r.mognet@vschneid.remote.csb>
 <20230810080708.L4nV_aKI@linutronix.de>
Date:   Thu, 10 Aug 2023 10:09:23 +0100
Message-ID: <xhsmhpm3vb6ws.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/23 10:07, Sebastian Andrzej Siewior wrote:
> On 2023-08-09 18:02:32 [+0100], Valentin Schneider wrote:
>> On 01/08/23 17:26, Sebastian Andrzej Siewior wrote:
>> > I have a RT task X at a high priority and cyclictest on each CPU with
>> > lower priority than X's. If X is active and each CPU wakes their own
>> > cylictest thread then it ends in a longer rto_push storm.
>> > A random CPU determines via balance_rt() that the CPU on which X is
>> > running needs to push tasks. X has the highest priority, cyclictest is
>> > next in line so there is nothing that can be done since the task with
>> > the higher priority is not touched.
>> >
>> > tell_cpu_to_push() increments rto_loop_next and schedules
>> > rto_push_irq_work_func() on X's CPU. The other CPUs also increment the
>> > loop counter and do the same. Once rto_push_irq_work_func() is active it
>> > does nothing because it has _no_ pushable tasks on its runqueue. Then
>> > checks rto_next_cpu() and decides to queue irq_work on the local CPU
>> > because another CPU requested a push by incrementing the counter.
>> >
>>
>> For a CPU to be in the rto_mask, it needs:
>>
>>   rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1
>>
>> But if that CPU has no pushable tasks, then that means only the current
>> task has p->nr_cpus_allowed > 1.
>>
>> Should we change it so a CPU is only in the rto_mask iff it has pushable
>> tasks? AFAICT that should not break the case where we push the current task
>> away due to migration_disabled, as that still relies on the
>> migration_disabled task to be in the pushable list.
>
> Sounds good. The task with the highest priority becomes pushable if it
> gets preempted (by a task with higher priority). This gets considered,
> right?
>

Yeah, when we switch the current task in put_prev_task_rt() we add the
previously-running (IOW preempted) task to the pushable list (if isn't
affined to just one CPU).

Now it looks like if we change update_rt_migration() to look at the
pushable list instead of rt_nr_migratory, we could get rid of
rt_nr_migratory itself - let me poke at this a little, I might just be
about to figure out why that isn't already the case...

> Sebastian

