Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00008015E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441823AbjLAWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441818AbjLAWJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:09:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675110D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:09:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc79f73e58so13375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701468586; x=1702073386; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zf6pqupbIe+fO+VPEeN59lUPlZ+0JUCn5Zq7zLY8rPA=;
        b=y3mL1KW47saAW2cWOsKpj6YLIi5ohLcu8SsY7+qPsq9ruYTUUUPtxrTKmCa4l5+ur7
         f+9C6nBmqInJJnEg5YT4BpXCWFdSUfK1puPQqCjFLNOwE8WwRa/ODZu8A3118BMc3jYT
         ieys3pnQbTcpyny6KbJUO7Hz4prP1EdVh28QUkbN9hbq9iaU229zvlY5sNoCpxP/dQoc
         x9ZIPc4mqzgyZxGJEVGDMUMdVrU+sK2d9rUV8OBL3QWoX/9ymyzFA98hgxTUvx3Ftf57
         84FqDqpmitdSufzrcu3I4uUWwJDDkQlh87bTyb0gjhW0t4MOOshi02lpj/Ca35FAI4xs
         KG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468586; x=1702073386;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf6pqupbIe+fO+VPEeN59lUPlZ+0JUCn5Zq7zLY8rPA=;
        b=sarf9zFvNGMQfz3bS6q7tWA0FTthq+z2CFnrB8o9Bxip3KmeSCfXZMXBK17o1AUbHc
         LTVhGjSPezp0kegBnHu6A/4TxEKXGNJA34cKP2oKUM8nbYbNT+9R7odatH9nx90976rT
         IxTrqE+pNG68w2UgGqiC9opX17pnxz0XYlU1S6/7d/PUFzcdngophLR5ylfUx2zLZPZg
         GXQkqbT+Uq400WDMEKTrXOx6SWEyzE0zk+gvCh6CaCvM+k+IbEkvSVm05A0oDEpxDcVi
         E0g7csaqLNRrVMB6R3dkzr/kXnn285ETBpnVDLwgi1WRYwb5MvLgRe4I+2sKO9OI0s67
         aP8A==
X-Gm-Message-State: AOJu0YxaH/hrN5jRQZXncA/munlyFQTAcezOLzsVf0/Mu0EglpbUXGDI
        6Q7TjVYMJf+aATmJFOCblY1Jjw==
X-Google-Smtp-Source: AGHT+IEpQPoqRS2n5kgEc7poBOJajiuDgEEwUvsw74Ur/tUoKWGSyQHMfD+27vcX9SHMccdsHL0eVw==
X-Received: by 2002:a17:902:f681:b0:1cf:dbef:79c9 with SMTP id l1-20020a170902f68100b001cfdbef79c9mr326306plg.2.1701468586144;
        Fri, 01 Dec 2023 14:09:46 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id a34-20020a630b62000000b005b9083b81f0sm3548809pgl.36.2023.12.01.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:09:45 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
        (Valentin Schneider's message of "Fri, 01 Dec 2023 14:30:14 +0100")
References: <20231130161245.3894682-1-vschneid@redhat.com>
        <20231130161245.3894682-2-vschneid@redhat.com>
        <xm26sf4n2ar6.fsf@google.com>
        <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date:   Fri, 01 Dec 2023 14:09:43 -0800
Message-ID: <xm26o7f93788.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> On 30/11/23 13:26, Benjamin Segall wrote:
>> Valentin Schneider <vschneid@redhat.com> writes:
>>
>> The alternative we've been experimenting with (and still running into
>> other issues that have made it hard to tell if they work) is to still
>> leave the tasks on their cfs_rqs, but instead have two task_timelines or
>> similar per cfs_rq, one of which only has unthrottleable tasks (or
>> partially-throttled child cgroups) on it. Then when picking into a
>> partially-unthrottled cfs_rq you only look at that alternate task_timeline.
>>
>
> IIUC then you don't dequeue the cfs_rq's se, but instead rely on the RB
> tree switch to only have unthrottable tasks running.

Correct.

>
>> This means that we get to skip this per-actually-throttled-task loop:
>>
>>> @@ -5548,7 +5548,61 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>>>  {
>>>      struct rq *rq = data;
>>>      struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>> +	struct sched_entity *se = tg->se[cpu_of(rq)];
>>> +	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
>>> +	long task_delta = 0, idle_task_delta = 0;
>>> +	struct task_struct *p, *tmp;
>>>
>>> +	/*
>>> +	 * Re-enqueue the tasks that have been throttled at this level.
>>> +	 *
>>> +	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
>>> +	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
>>> +	 * might happen when a cfs_rq still has some tasks enqueued, either still
>>> +	 * making their way to userspace, or freshly migrated to it.
>>> +	 */
>>> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
>>> +		struct sched_entity *pse = &p->se;
>>> +
>>> +		list_del_init(&p->throttle_node);
>>> +		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
>>> +		task_delta++;
>>> +		idle_task_delta += task_has_idle_policy(p);
>>> +	}
>>
>> The downsides are that you instead have extra operations per
>> enqueue/dequeue/pick (but just an extra list/rbtree operation or check),
>> and that it doesn't do *any* accounting change for a partially dequeued
>> cfs_rq.
>>
>
> I would assume we want to keep the *nr_running as close to reality as
> possible, given their impact on pick_next_task_fair() & load_balance().
>

Yeah, and while it's maybe ok for the longer-period load_balance, it's
definitely sketchy for the shorter term things like select_idle_sibling.
In theory we could duplicate more and more of the accounting... (though
that also then becomes questionable amounts of increased overhead on
enqueue/dequeue).

>> I'm going to try putting together a cleaner variant of our version that
>> works via task_work instead of bracketing every relevant entry point.
>> (That design came from when we were trying instead to only do it for
>> tasks holding actual locks)
>
> Interesting, thank you for sharing! I assume then the motivation for this
> is to reduce latencies caused by throttling lock holders?

Yeah, and then we ran into things like percpu-rwsem where lock/unlock
accounting doesn't work as well, but kept the basic design.
