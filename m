Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8209C7EEB33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKQCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:48:37 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D1A0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:48:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwXyHQg_1700189309;
Received: from 30.97.48.252(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VwXyHQg_1700189309)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 10:48:30 +0800
Message-ID: <6a741eca-6484-b907-8a1d-41f8868bc70c@linux.alibaba.com>
Date:   Fri, 17 Nov 2023 10:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] sched/fair: introduce core_vruntime and
 core_min_vruntime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
References: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
 <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
 <20231115122027.GZ8262@noisy.programming.kicks-ass.net>
 <246dee1f-5e14-e075-13c7-ce876305cb54@linux.alibaba.com>
 <20231115152259.GB8262@noisy.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <20231115152259.GB8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/15 下午11:22, Peter Zijlstra 写道:
> On Wed, Nov 15, 2023 at 09:42:13PM +0800, cruzzhao wrote:
>>
>>
>> 在 2023/11/15 下午8:20, Peter Zijlstra 写道:
>>> On Wed, Nov 15, 2023 at 07:33:40PM +0800, Cruz Zhao wrote:
>>>> To compare the priority of sched_entity from different cpus of a core,
>>>> we introduce core_vruntime to struct sched_entity and core_min_vruntime
>>>> to struct cfs_rq.
>>>>
>>>> cfs_rq->core->core_min_vruntime records the min vruntime of the cfs_rqs
>>>> of the same task_group among the core, and se->core_vruntime is the
>>>> vruntime relative to se->cfs_rq->core->core_min_vruntime.
>>>
>>> But that makes absolutely no sense. vruntime of different RQs can
>>> advance at wildly different rates. Not to mention there's this random
>>> offset between them.
>>>
>>> No, this cannot be.
>>
>> Force idle vruntime snapshot does the same thing, comparing
>> sea->vruntime - cfs_rqa->min_vruntime_fi with seb->vruntime -
>> cfs_rqb->min_vruntime_fi, while sea and seb may have wildly different rates.
> 
> But that subtracts a from a and b from b, it doesn't mix a and b.
> 
> Note that se->vruntime - cfs_rq->min_vruntime is a very poor
> approximation of lag. We have actual lag now.
> 
> Note that:
> 
>   (sea - seb) + (min_fib - min_fia) =
>   (sea - min_fia) + (min_fib - seb) =
>   (sea - min_fia) - (seb - min_fib) =
>   'lag'a - 'lag'b
> 
> It doesn't mix absolute a and b terms anywhere.
> 
>> Actually, cfs_rq->core->core_min_vruntime does the same thing as
>> cfs_rq->min_vruntime_fi, providing a baseline, but
>> cfs_rq->core->core_min_vruntime is more accurate.
> 
> min(cfs_rqa, cfs_rqb) is nonsense. And I can't see how min_vruntime_fi
> would do anything like that.
> 

Introducing core_vruntime and core_min_vruntime is a try to maintain a
single core wide cfs_rq, abstracting vruntime, and core_min_vruntime
doesn't equal to min(cfs_rqa, cfs_rqb).

Note that:
sea->core_vruntime - seb->core_vruntime =
sea->core_vruntime - seb->core_vruntime + core_min_vruntime -
core_min_cruntime =
(sea->core_vruntime - core_min_vruntime) - (seb->core_vruntime -
core_min_vruntime) =
'lag'a - 'lag'b

The problem about wildly different vruntime rates also happens with
vruntime snapshot. Consider the case that a core always force idle some
SMT, and the min_vruntime_fi will never update. In this case, 'lag'a and
'lag'b increase according to their respective weights in cfs, instead of
the core wide weights.

Afaic, there is no perfect solution or mechanism to solve this problem
yet, but I'll try.

Best,
Cruz Zhao
