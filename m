Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905797EB06B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjKNM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjKNM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:59:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B18019B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:59:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FC75C15;
        Tue, 14 Nov 2023 04:59:51 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799A33F6C4;
        Tue, 14 Nov 2023 04:59:04 -0800 (PST)
Message-ID: <7790c176-6af3-458c-9995-8bceb73b64bc@arm.com>
Date:   Tue, 14 Nov 2023 13:59:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in
 sched_avg
Content-Language: en-US
To:     Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
 <d1b613d5-2207-45dd-8aa2-a276502ccaa1@arm.com>
 <cda9bff0-1fcb-4736-93e7-19659cac9a01@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <cda9bff0-1fcb-4736-93e7-19659cac9a01@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 17:05, Hongyan Xia wrote:
> On 31/10/2023 15:52, Dietmar Eggemann wrote:
>> On 04/10/2023 11:04, Hongyan Xia wrote:
>>> From: Hongyan Xia <hongyan.xia2@arm.com>
>>
>> [...]
>>
>>> @@ -6445,6 +6450,21 @@ static int sched_idle_cpu(int cpu)
>>>   }
>>>   #endif
>>>   +void ___update_util_avg_uclamp(struct sched_avg *avg, struct
>>> sched_entity *se);
>>
>> IMHO, `struct sched_avg *avg` can only be the one of a cfs_rq. So
>> passing a cfs_rq would eliminate the question whether this can be from
>> another se.
> 
> At the moment, yes, the avg can only come from cfs_rq. The reason why I
> kept sched_avg is that once we have sum aggregation for RT tasks, it's
> very likely we will end up calling this function on rt_rq->avg, so
> having just sched_avg here will work for RT in the future.

Ah, OK. IMHO would be better to use cfs_rq for now and widen this
interface once RT is covered.

[...]

>> Question for me is why can't you integrate the util_avg_uclamp signals
>> for se's and cfs_rq's/rq's much closer into existing PELT functions?
> 
> So the problem is that when we enqueue the task (say UCLAMP_MIN of 200),
> at that exact moment se->on_rq is false, so we only decay and not
> enforce UCLAMP_MIN. Further up in the hierarchy we do update_load_avg(),
> but the se of the task has already been processed so UCLAMP_MIN has not
> taken any effect. To make sure UCLAMP_MIN is immediately effective, I
> just re-evaluate the whole hierarchy from bottom to top.
> 
> I probably didn't quite catch what you said here. Could you elaborate a
> bit on what 'much closer' means?

I see. But can we not use DO_ATTACH (and DO_DETACH) for this?

(flags & DO_ATTACH) characterizes the enqueuing of the task. So with
DO_ATTACH (and so !se->on_rq (and cfs_rq->curr != se)) we could (a)
decay the task and (b) add it to the cfs_rq in enqueue_entity() ->
update_load_avg(..., | DO_ATTACH).

Like we do for PELT and a wakeup migration enqueuing (a)

update_load_avg()

  __update_load_avg_se()

    if (___update_load_sum(..., cfs_rq->curr == se)
                                ^^^^^^^^^^^^^^^^^^
                                'int running' for utilization

      ___update_load_avg()

  if (!se->avg.last_update_time && (flags & DO_ATTACH))
      ^^^^^^^^^^^^^^^^^^^^^^^^^
      wakeup migration

    attach_entity_load_avg()

Notice, for PELT we attach/detach to/from the cfs_rq which gives us
blocked contribution. For util_avg_clamped we do enqueue/dequeue, so
only runnable contribution.
