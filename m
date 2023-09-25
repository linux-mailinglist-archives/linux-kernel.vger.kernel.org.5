Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F57AD7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjIYMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIYMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D8FE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695644521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MNhm+1XFFpfJQTCT/N4z0tkrQ5TUIHd0V4r09cSckw=;
        b=H6R+RRQ41w56WGAPBOaIOc052rKtRFr8FWdocc08AHblW0FeDzN+y3KXP+DKKSSjK7rUFr
        OBCckzMrwQyTzPuRKM9x4HST/bPYjb2LBKKohDckihH3nmm0BlIq1x2Q5rMNSSumjXhtQX
        NhNsO+R+/KocThsIhCTmjBO1K/ZawHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-6sKqz4EhNEqVrHjYZ0S70w-1; Mon, 25 Sep 2023 08:22:00 -0400
X-MC-Unique: 6sKqz4EhNEqVrHjYZ0S70w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31f79595669so3805241f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644518; x=1696249318;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MNhm+1XFFpfJQTCT/N4z0tkrQ5TUIHd0V4r09cSckw=;
        b=OPfxaspQEu7RIIrz+hsBYsxTC+oMnxUjeAJX+MzB3jFQ5Bf50135R2HHHMCgRuRPO9
         r7uK1nCviroQC/eP9qA6J759YuSWq0w3quLN40GnWZEj1aWrqVQSnSxA7oLm8ELwe+cQ
         4FS3gWaTGyi/lcDWaN/090fvxBbszizTFrGV5vWpqM9xObCK9k0x8xu+IGPq6KHQPCbb
         s38xxS4zk9ciA8wY09cyVuBYi1SiQaz98hkaWHxS1gH+eT+pdjf8aeKNmcbh7TpKTSKO
         9bING/MZ4L6qC0ZL/DRq3pNcw8fO6QcDOIHnJRjZbwg2Sq2fVQ4laa7yfbBRBm+omHAC
         gQ7Q==
X-Gm-Message-State: AOJu0Yz7NppMsRBFrOpcXt/5+6CFDmKzonLZylhcD882rOcuFGLA/C2M
        X7p4uvtjGQ++a/A1nBSLmTP6GYr40QsNp74ScXrwTaX0bCJPwKz9iFqaEfOqF4GR+g05MkVtwWJ
        Ewi3tqOONFyuzalvladyQwmjpJ6YNIxDn
X-Received: by 2002:adf:e3ce:0:b0:317:dadc:4a63 with SMTP id k14-20020adfe3ce000000b00317dadc4a63mr6997874wrm.8.1695644518710;
        Mon, 25 Sep 2023 05:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAm4ifKXpzDtyUPhGIDZDGdGBDvG3dNyF9RNLXRMXlOTPyatpeH0NuSCukQ0AYeGIPawefuA==
X-Received: by 2002:adf:e3ce:0:b0:317:dadc:4a63 with SMTP id k14-20020adfe3ce000000b00317dadc4a63mr6997860wrm.8.1695644518330;
        Mon, 25 Sep 2023 05:21:58 -0700 (PDT)
Received: from vschneid.remote.csb ([80.214.159.242])
        by smtp.gmail.com with ESMTPSA id bw10-20020a0560001f8a00b0032326908972sm3230747wrb.17.2023.09.25.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:21:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/rt: Make rt_rq->pushable_tasks updates
 drive rto_mask
In-Reply-To: <20230925101127.GB31921@noisy.programming.kicks-ass.net>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <169563211069.27769.17070510461354463740.tip-bot2@tip-bot2>
 <20230925101127.GB31921@noisy.programming.kicks-ass.net>
Date:   Mon, 25 Sep 2023 14:21:56 +0200
Message-ID: <xhsmh1qemv3x7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/23 12:11, Peter Zijlstra wrote:
> On Mon, Sep 25, 2023 at 08:55:10AM -0000, tip-bot2 for Valentin Schneider wrote:
>> The following commit has been merged into the sched/core branch of tip:
>> 
>> Commit-ID:     612f769edd06a6e42f7cd72425488e68ddaeef0a
>> Gitweb:        https://git.kernel.org/tip/612f769edd06a6e42f7cd72425488e68ddaeef0a
>> Author:        Valentin Schneider <vschneid@redhat.com>
>> AuthorDate:    Fri, 11 Aug 2023 12:20:44 +01:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Mon, 25 Sep 2023 10:25:29 +02:00
>> 
>> sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask
>> 
>> Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
>> that has an empty pushable_tasks list, which means nothing useful will be
>> done in the IPI other than queue the work for the next CPU on the rto_mask.
>> 
>> rto_push_irq_work_func() only operates on tasks in the pushable_tasks list,
>> but the conditions for that irq_work to be queued (and for a CPU to be
>> added to the rto_mask) rely on rq_rt->nr_migratory instead.
>> 
>> nr_migratory is increased whenever an RT task entity is enqueued and it has
>> nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory includes a
>> rt_rq's current task. This means a rt_rq can have a migratible current, N
>> non-migratible queued tasks, and be flagged as overloaded / have its CPU
>> set in the rto_mask, despite having an empty pushable_tasks list.
>> 
>> Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable_task().
>> Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.
>> 
>> Note that the case where the current task is pushed away to make way for a
>> migration-disabled task remains unchanged: the migration-disabled task has
>> to be in the pushable_tasks list in the first place, which means it has
>> nr_cpus_allowed > 1.
>> 
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Link: https://lore.kernel.org/r/20230811112044.3302588-1-vschneid@redhat.com
>> ---
>>  kernel/sched/debug.c |  3 +--
>>  kernel/sched/rt.c    | 70 ++++++-------------------------------------
>>  kernel/sched/sched.h |  2 +-
>>  3 files changed, 10 insertions(+), 65 deletions(-)
>> 
>
>> @@ -358,53 +357,6 @@ static inline void rt_clear_overload(struct rq *rq)
>>  	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
>>  }
>>  
>> -static void update_rt_migration(struct rt_rq *rt_rq)
>> -{
>> -	if (rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1) {
>> -		if (!rt_rq->overloaded) {
>> -			rt_set_overload(rq_of_rt_rq(rt_rq));
>> -			rt_rq->overloaded = 1;
>> -		}
>> -	} else if (rt_rq->overloaded) {
>> -		rt_clear_overload(rq_of_rt_rq(rt_rq));
>> -		rt_rq->overloaded = 0;
>> -	}
>> -}
>> -
>> -static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>> -{
>> -	struct task_struct *p;
>> -
>> -	if (!rt_entity_is_task(rt_se))
>> -		return;
>> -
>> -	p = rt_task_of(rt_se);
>> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
>> -
>> -	rt_rq->rt_nr_total++;
>> -	if (p->nr_cpus_allowed > 1)
>> -		rt_rq->rt_nr_migratory++;
>> -
>> -	update_rt_migration(rt_rq);
>> -}
>> -
>> -static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>> -{
>> -	struct task_struct *p;
>> -
>> -	if (!rt_entity_is_task(rt_se))
>> -		return;
>> -
>> -	p = rt_task_of(rt_se);
>> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
>> -
>> -	rt_rq->rt_nr_total--;
>> -	if (p->nr_cpus_allowed > 1)
>> -		rt_rq->rt_nr_migratory--;
>> -
>> -	update_rt_migration(rt_rq);
>> -}
>
> sched/deadline.c has something very similar, does that need updating
> too?

Hm I think so yes:
- push_dl_task() is an obvious noop if the pushable tree is empty
- pull_dl_task() can be kicked if !rq->dl.overloaded, which similarly to rt
  is driven by nr_migratory but could be boiled down to having pushable
  tasks (due to the nr_cpus_allowed > 1 constraint).

Lemme poke at it.

