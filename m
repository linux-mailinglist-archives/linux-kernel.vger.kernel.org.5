Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF327E343D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKGDkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:39:59 -0500
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E78F10A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:39:56 -0800 (PST)
Message-ID: <ce0bbb47-3390-e66c-cda8-b475ad50195d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699328394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PKmstvb0ff22Q1AFku56d76MXLLkElKv6tORUPheNs=;
        b=lQeu6/T4HgHZ4KpAD6qdP19dd1xmVw8HL9TO0y5Jl6UFRS09xFKnrxnWKugvw7jxhAnzDo
        jV4XMQ0++B2rJCscZzE6U5mrbZWUy4TdOiPh04dUfFmnZCLPHDZgk7ZWQ1qj0eUNps2c93
        RWYvUWI2VkYvUN9mS0SQtIjIyTpuNO4=
Date:   Tue, 7 Nov 2023 11:39:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Use update_current_exec_runtime simplify code
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231031125928.235685-1-yajun.deng@linux.dev>
 <20231106123539.GL8262@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231106123539.GL8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/6 20:35, Peter Zijlstra wrote:
> On Tue, Oct 31, 2023 at 08:59:25PM +0800, Yajun Deng wrote:
>> update_current_exec_runtime would update execution time for each task,
>> we can use update_current_exec_runtime simplify code.
>>
>> The 1st and 2nd patch update update_current_exec_runtime() applies to all
>> callers.
>> The 3rd patch use update_current_exec_runtime simplify update_curr.
>>
>> Yajun Deng (3):
>>    sched: Don't account execution time for task group
>>    sched: Don't trace stat runtime for task group
>>    sched/fair: Simplify update_curr()
>>
>>   kernel/sched/deadline.c  |  4 +---
>>   kernel/sched/fair.c      | 13 +++----------
>>   kernel/sched/rt.c        |  5 ++---
>>   kernel/sched/sched.h     | 11 +++++++----
>>   kernel/sched/stop_task.c |  2 +-
>>   5 files changed, 14 insertions(+), 21 deletions(-)
>
> Hurmph, so I'm having conflicts against this:
>
>    https://lkml.kernel.org/r/54d148a144f26d9559698c4dd82d8859038a7380.1699095159.git.bristot@kernel.org
>
> (obviously).. I've resolved the first patch, which also mostly includes
> the second patch.
>
> However, your second patch isn't entirely right, it now unconditionally
> traces ->vruntime, which isn't the same. Imagine a regular task getting
> a PI boost to RT, in that case ->vruntime will be non-zero and the RT
> task will now be logging a vruntime.
>
> Anyway, that tracepoint doesn't really make sense to me anyway, that is,
> it logs a delta_exec and an absolute vruntime, that's inconsistent.
> Also, a delta vruntime can be easily computed because the weight should
> be known.
>
> I think I'm going to simply remove the vruntime from that tracepoint and
> avoid the whole problem.
>
> This then also makes resolving patch 3 easier.
>
> Let me go squish all this and then I'll post a link to whatever came
> out.


Got it, thanks!

