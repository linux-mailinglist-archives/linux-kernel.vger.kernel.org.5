Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8B7E344D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjKGDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:49:30 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E3D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:49:27 -0800 (PST)
Message-ID: <585ca8ea-c371-dca4-52ef-0f2d2e019774@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699328965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8H2mvIjp6dWAfy8ApUJkKLe3+aKqzQ0bA2gZK2qOYlg=;
        b=tP9nXKBk6fIkaavRtfywtiNQehl/R9TDQIVe2EWmdwL+VaVAnpHSR3tjck2v1TdQ2PgY3l
        swN0OHPJZcI2b4D36tUkFkAooEH0xNtNScpAkAGDJOp4Uy8Rulh5HvL6JwtCFI4J5x7trD
        ahmgyZZUliZYGncGTybYyX5VgurB2wY=
Date:   Tue, 7 Nov 2023 11:49:15 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH v3 1/3] sched: Don't account execution time for task group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231031125928.235685-1-yajun.deng@linux.dev>
 <20231031125928.235685-2-yajun.deng@linux.dev>
 <20231106124912.GM8262@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20231106124912.GM8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/6 20:49, Peter Zijlstra wrote:
> On Tue, Oct 31, 2023 at 08:59:26PM +0800, Yajun Deng wrote:
>> The rt entity can be a task group. We will account execution time for
>> each task. For consistency, we don't need to account execution time for
>> task group.
>>
>> Pass a parameter to update_current_exec_runtime, let the caller decide
>> whether account execution time.
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 6aaf0a3d6081..79cf80d73822 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1018,7 +1018,8 @@ static void update_curr_rt(struct rq *rq)
>>   
>>   	trace_sched_stat_runtime(curr, delta_exec, 0);
>>   
>> -	update_current_exec_runtime(curr, now, delta_exec);
>> +	update_current_exec_runtime(curr, now, delta_exec,
>> +				    rt_entity_is_task(rt_se));
>>   
>>   	if (!rt_bandwidth_enabled())
>>   		return;
> ok, I think I've managed to confuse myself again.
>
> But at this point rt_se := &rq->curr->rt, which is *always* a task, no?


I think so, but it can be safer to use rt_entity_is_task().

