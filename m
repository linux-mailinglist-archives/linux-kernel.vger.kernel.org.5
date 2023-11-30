Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97667FFD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376906AbjK3V0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376915AbjK3V0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:26:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201D1711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:26:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfd76c5f03so49435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701379602; x=1701984402; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qalC3SiJ6wXULCn53TlUf+ob37V8woQJoeziFX6t7A=;
        b=TB/P6rB1gdg1BbYMIJqyC61Z0np86GdTBLX1CvsmYr6N5eF/+imasOXt2F0zUinl9j
         73b0RymhIVqDsgRPP3JIBv//lQDLjyZVJ5yTlv4YA6sAnnUqKhOsuRD31t8W3wCKh9DI
         WQrPhwItrLzJENKTWX6ZTjVLg5pVqKBOinCI1cATJHD5gvNtoGjSE3LtmxtDlplpBGtA
         hpZcjDUbxlVh20zveGTED04e3EWDcNqR4o6Fln7+X5NLrmON50LCN6dbfUxfa/Ye91I7
         AO/z2QQQiBgdV9PI5FSwJDerCtCPbf+M8jdaYvvUgP/dP5AGXam9Y1CEn6JNsj1jTAIL
         g4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379602; x=1701984402;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qalC3SiJ6wXULCn53TlUf+ob37V8woQJoeziFX6t7A=;
        b=rzkSw6Qx7biCVSeCykNCXdVeNivQx5DmxJBJ7i/lik6XkBUqxgLScsXK3qIVkDOLET
         vT/3N+UgKCYtgCeLjXqN5aJGA1YszlzZVRgcXefyTWPIZJuKk/l/nInjWK3Rgbu9U7Pg
         vgu8V6BjeNWRfjSasSDlhFXqqxRDBmkzJkEIs3iLabeW2Qhpdzet6+6xssEyXmOT4Fon
         6R5NufW6yU4qva7gypB9ufZgsUtr2zeijhuD1b0Mdg7H1UVG7dVbCiVc3B7duRKRgE/l
         gkYjEII76xN+9CF3vvRX9mPN0Mc/5xrFt9NOgaFhG3ihZGal9zGarVz+xs+Qqfrnrb/f
         Dneg==
X-Gm-Message-State: AOJu0YxUjfr0MaLqpQHVzBv8giO57gIpbh4YTlCCfdUMk4enZIYzWLgI
        nlZkWuSKUtiUykZBnvGA7yBSuw==
X-Google-Smtp-Source: AGHT+IEzYGDcS2ZASf2vXDx/HgYuqZXNxGA/l0F8/7Rpu9FZcYP6LvKkqzrzYulFAizD8HBAVkl7BA==
X-Received: by 2002:a17:902:f681:b0:1cf:dbef:79c9 with SMTP id l1-20020a170902f68100b001cfdbef79c9mr29311plg.2.1701379601916;
        Thu, 30 Nov 2023 13:26:41 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902a9c700b001cfc618d76csm1877863plr.70.2023.11.30.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:26:41 -0800 (PST)
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
In-Reply-To: <20231130161245.3894682-2-vschneid@redhat.com> (Valentin
        Schneider's message of "Thu, 30 Nov 2023 17:12:43 +0100")
References: <20231130161245.3894682-1-vschneid@redhat.com>
        <20231130161245.3894682-2-vschneid@redhat.com>
Date:   Thu, 30 Nov 2023 13:26:37 -0800
Message-ID: <xm26sf4n2ar6.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> As reported in [1], CFS bandwidth throttling is a source of headaches in
> PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
> prevent ksoftirqd from running, which prevents replenishing & unthrottling
> the cfs_rq of said CFS task.
>
> Peter mentioned that there have been discussions on changing /when/ the
> throttling happens: rather than have it be done immediately upon updating
> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
> for the task to be about to return to userspace.
>
> I'm not aware of the arguments in favour of this for !PREEMPT_RT, but given [1]
> I had a look into it. Using this approach means no task can be throttled while
> holding a kernel lock, which solves the locking dependency issue.

The alternative we've been experimenting with (and still running into
other issues that have made it hard to tell if they work) is to still
leave the tasks on their cfs_rqs, but instead have two task_timelines or
similar per cfs_rq, one of which only has unthrottleable tasks (or
partially-throttled child cgroups) on it. Then when picking into a
partially-unthrottled cfs_rq you only look at that alternate task_timeline.

This means that we get to skip this per-actually-throttled-task loop:

> @@ -5548,7 +5548,61 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>  {
>  	struct rq *rq = data;
>  	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +	struct sched_entity *se = tg->se[cpu_of(rq)];
> +	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
> +	long task_delta = 0, idle_task_delta = 0;
> +	struct task_struct *p, *tmp;
>  
> +	/*
> +	 * Re-enqueue the tasks that have been throttled at this level.
> +	 *
> +	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
> +	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
> +	 * might happen when a cfs_rq still has some tasks enqueued, either still
> +	 * making their way to userspace, or freshly migrated to it.
> +	 */
> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
> +		struct sched_entity *pse = &p->se;
> +
> +		list_del_init(&p->throttle_node);
> +		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
> +		task_delta++;
> +		idle_task_delta += task_has_idle_policy(p);
> +	}

The downsides are that you instead have extra operations per
enqueue/dequeue/pick (but just an extra list/rbtree operation or check),
and that it doesn't do *any* accounting change for a partially dequeued
cfs_rq.

I'm going to try putting together a cleaner variant of our version that
works via task_work instead of bracketing every relevant entry point.
(That design came from when we were trying instead to only do it for
tasks holding actual locks)
