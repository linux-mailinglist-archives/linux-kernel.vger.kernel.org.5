Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA894752B75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjGMUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjGMUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:12:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380F1720
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:12:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b9ed206018so11385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689279126; x=1691871126;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCbyQDFiXgp3czjaCN0LZJhyRPoDhTEyRb41OL4Vb5k=;
        b=6soCqQ3PQtWloijWJSLom2UhPzjnKQykn+yvtGsjJTX7/3RKSoO/WaqNq6llQ6I0GU
         oXuvHOGy0nOlCb54f3eoGBIGhZg4xpaSo3Mc0NkjATaPn+C8bIevlX/tHaWUi27Wpon9
         /rjRzZJxuujTMScHueAo3gPCTL3IxkhW3ha5pvM6gNEqaJM1Lcgjz3e0FSNg401wWq5s
         RHr2FiknbmmzIS7AirqfX2lAcauOI8Xa4Wu9G2RqFw8BiW2jLJsmPEncO/3LK2NOgiqf
         Rthss3Npyg8+AlhEiLZUVgdOiqufcYQHwFVJG+U7ijkH+yLhfLTsMHxdBfwh48pLLZOV
         QZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279126; x=1691871126;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCbyQDFiXgp3czjaCN0LZJhyRPoDhTEyRb41OL4Vb5k=;
        b=XZ0f+oy5DLxmqav4ZIoVFKRj6ebjHvXWTJjo9c+WxJiwOCc9iBBYwE7IQF8+FOcoCN
         ZHxZoPbL47eOJ6UP4D1bLzopS8VhFli+Ri4nJcOafWh2GU4ObOwNG64Zq+t5SA/DxSsf
         YSnAjzCHskTfsbhkcFzqVtyUQlTqsKT4R7iZRI9svXSUTl+j9pfsNp4rqkXA9wtWMMpu
         lppNRfmqENYwbD6GjtWVDPydaBmYp3MZq1fO9njC3lN6jxQYS+bskJ9QDURfrFaOYqcR
         BrtZsOMjUBSr+sMcZTNYuciusLeAK3Mq6lcpXhrVF0UrBGGRTrcCetRwz0Th2Q1pBLws
         J6oQ==
X-Gm-Message-State: ABy/qLZWOb52MunUW/wO/dl0bRKXlCcVg4F1VDUQesH5TAydUu5ZgHj3
        Fv2oPpEQGWfIzQemsiPUdrZPnA==
X-Google-Smtp-Source: APBJJlFvUK/urcGJljHMhiHTiPoSih0M93gjIbwrmSooqPK1b1eU1oLjKATc664VgtBjM2QZNydEOQ==
X-Received: by 2002:a17:902:e810:b0:1b9:d34c:c47c with SMTP id u16-20020a170902e81000b001b9d34cc47cmr568828plg.8.1689279126500;
        Thu, 13 Jul 2023 13:12:06 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0064d681c753csm5836265pfb.40.2023.07.13.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:12:06 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
References: <20230712133357.381137-1-pauld@redhat.com>
        <20230712133357.381137-2-pauld@redhat.com>
        <xm268rbkg4tg.fsf@google.com>
        <20230713132306.GA13342@lorien.usersys.redhat.com>
Date:   Thu, 13 Jul 2023 13:12:04 -0700
In-Reply-To: <20230713132306.GA13342@lorien.usersys.redhat.com> (Phil Auld's
        message of "Thu, 13 Jul 2023 09:23:06 -0400")
Message-ID: <xm26zg3zefl7.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Phil Auld <pauld@redhat.com> writes:

> On Wed, Jul 12, 2023 at 03:09:31PM -0700 Benjamin Segall wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> > In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
>> > groups due to the previous fix simply taking the min.  It should
>> > reflect a limit imposed at that level or by an ancestor. Even
>> > though cgroupv2 does not require child quota to be less than or
>> > equal to that of its ancestors the task group will still be
>> > constrained by such a quota so this should be shown here. Cgroupv1
>> > continues to set this correctly.
>> >
>> > In both cases, add initialization when a new task group is created
>> > based on the current parent's value (or RUNTIME_INF in the case of
>> > root_task_group). Otherwise, the field is wrong until a quota is
>> > changed after creation and __cfs_schedulable() is called.
>> >
>> > Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
>> > Signed-off-by: Phil Auld <pauld@redhat.com>
>> > Reviewed-by: Ben Segall <bsegall@google.com>
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > Cc: Juri Lelli <juri.lelli@redhat.com>
>> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > Cc: Valentin Schneider <vschneid@redhat.com>
>> > Cc: Ben Segall <bsegall@google.com>
>> > Cc: Frederic Weisbecker <frederic@kernel.org>
>> > Cc: Tejun Heo <tj@kernel.org>
>> > ---
>> >
>> > v2: Improve comment about how setting hierarchical_quota correctly
>> >
>> > helps the scheduler. Remove extra parens.
>> >  kernel/sched/core.c  | 13 +++++++++----
>> >  kernel/sched/fair.c  |  7 ++++---
>> >  kernel/sched/sched.h |  2 +-
>> >  3 files changed, 14 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index a68d1276bab0..f80697a79baf 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -9904,7 +9904,7 @@ void __init sched_init(void)
>> >  		ptr += nr_cpu_ids * sizeof(void **);
>> >  
>> >  		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
>> > -		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
>> > +		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
>> >  #endif /* CONFIG_FAIR_GROUP_SCHED */
>> >  #ifdef CONFIG_RT_GROUP_SCHED
>> >  		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
>> > @@ -11038,11 +11038,16 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
>> >  
>> >  		/*
>> >  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
>> > -		 * always take the min.  On cgroup1, only inherit when no
>> > -		 * limit is set:
>> > +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
>> > +		 * inherit when no limit is set. In cgroup2 this is used
>> > +		 * by the scheduler to determine if a given CFS task has a
>> > +		 * bandwidth constraint at some higher level.
>> >  		 */
>> 
>> It's still used for determining this on cgroup1 (and the cgroup1 code
>> still works for that), right?
>>
>
> It would, except that the enforcement of child quota <= parent quota
> means that cfs_rq->runtime_enabled will be set and we'll hit that first
> on cgroup1.  So we don't really use it for this determination in
> cgroup1.

cgroup1 tg_cfs_schedulable_down only constricts child quota when it's
set. You can set quota=RUNTIME_INF on any cgroup, no matter what its
parent is. (The schedulable constraint is a little silly)
