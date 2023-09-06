Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BB793E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjIFN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:57:04 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3900D7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694008618;
        bh=OWF3xVbOqFNgF44I31j40/eaWsS8GSA4McwyAw9Afxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zpxk+3tGr5hxFBT3uCCjS+JigfYEnw2cyXVZY/IGO56GEFFxvfSIE/jXvmafp4PSz
         zmt1cK87rqYtGgYvIi1pJ5LVHVA0YRJ/nmzoxDlV+jxz4qhYtyhu6KlZRG1waREg6R
         SdztysVHP6TMZTtDpjYtKkK51tm8+2R5uB+TXIdPxRsUtOA/yOKz1+UDGPLsmYf96Q
         cFwtPtwxIBdSou3zAWAFB+Aqm/fL1Uts3q66GKPfOb7NMDH6/Qlk8nGUchsbznGx2u
         2AcsDxD6v55LJafVKG9USh/ICEZpBwwtJZOum6jK9/cZQJpJXm5oISGs8YjV7bpBgE
         yEGN5IScgc20w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgkSp3pc2z1NYK;
        Wed,  6 Sep 2023 09:56:58 -0400 (EDT)
Message-ID: <4488da0c-bd02-f3f5-24ed-ee5984c4be2e@efficios.com>
Date:   Wed, 6 Sep 2023 09:58:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
 <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
 <20230906084455.GD38741@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230906084455.GD38741@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 04:44, Peter Zijlstra wrote:
> On Tue, Sep 05, 2023 at 05:16:25PM -0400, Mathieu Desnoyers wrote:
>> On 9/5/23 16:28, Tim Chen wrote:
>>> On Tue, 2023-09-05 at 13:11 -0400, Mathieu Desnoyers wrote:
>>>> Rate limit migrations to 1 migration per 2 milliseconds per task. On a
>>>> kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
>>>> this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2 sockets).
>>>>
>>>>
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 479db611f46e..0d294fce261d 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>>>    	p->se.vruntime			= 0;
>>>>    	p->se.vlag			= 0;
>>>>    	p->se.slice			= sysctl_sched_base_slice;
>>>> +	p->se.next_migration_time	= 0;
>>>
>>> It seems like the next_migration_time should be initialized to the current time,
>>> in case the system run for a long time and clock wrap around could cause problem.
>>
>> next_migration_time is a u64, which should "never" overflow. Other scheduler
>> code comparing with sched_clock() don't appear to care about u64 overflow.
> 
> Much code actually considers overflow. We also have monotonicity filters
> where it really matters.

OK, I'll update the patch to consider overflow if we end up going that
route, but for now I'll try an approach based on idle timestamps
instead.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

