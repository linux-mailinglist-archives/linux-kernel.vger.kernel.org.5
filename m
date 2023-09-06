Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA2794571
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjIFVyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjIFVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:54:05 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7DDCFD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694037238;
        bh=G5b1ZiEouWXtelHmJRdYj6k9w+4imdkEkkLJLYw/1Jg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UBwp6g/9YK7qIUFTyKTIq/7a4FH8XaA4f4RVpkGk7KcKGPrLjQl2g5XWEcyTdYcHw
         2RsTovdzQ5Qs84PpJp5mb+28CfqU9BvhrEwp1GfFSzAdAU1WnnnZnl6U2qic+E5kzO
         E0td9MWBqSv4v9jKt+urho/y1wQM1R+bj9mnYLYPfK64rz5QzxLJdltAYM9HxpsGHE
         UgX90hx2Af+8B8MqvCx84MACJ9hMtb4InnCatw1IXT2GoJwu66dYYFJX8ZjnezeL2I
         puUqS1h0wPSIp215LmhMla3imJi0GIP6DU+zqNeKd/cabOdn8K4b/toBJ6ERrcP4MK
         +vlCP/qwVQqrA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rgx396lCkz1Nr1;
        Wed,  6 Sep 2023 17:53:57 -0400 (EDT)
Message-ID: <245448a2-6d2c-4c4c-51b3-c610e7e7a68d@efficios.com>
Date:   Wed, 6 Sep 2023 17:55:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
 <ae4b342c424b76dc3f8adafcc2da7c02b9755b10.camel@linux.intel.com>
 <20230906094744.GE38741@noisy.programming.kicks-ass.net>
 <ae216efc3a71c624fb70c071de4b5e3c096756b4.camel@linux.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ae216efc3a71c624fb70c071de4b5e3c096756b4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 16:51, Tim Chen wrote:
> On Wed, 2023-09-06 at 11:47 +0200, Peter Zijlstra wrote:
>> On Tue, Sep 05, 2023 at 03:44:57PM -0700, Tim Chen wrote:
>>
>>> Reading up on sched_clock() documentation and seems like it should
>>> indeed be monotonic.
>>
>> It tries very hard to be monotonic but cannot guarantee. The moment TSC
>> is found unstable it's too late to fix up everything.
>>
> 
> Yes, if TSC becomes unstable and could cause sched_clock to reset and go way backward.
> Perhaps we can add the following check in Mathieu's original
> patch to fix things up:
> 
> +static bool should_migrate_task(struct task_struct *p, int prev_cpu)
>> +{
> 	/* sched_clock reset causing next migration time to be too far ahead */
> 	if (p->se.next_migration_time > sched_clock_cpu(prev_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW)
> 		p->se.next_migration_time = sched_clock_cpu(prev_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW;
> 
>> +	/* Rate limit task migration. */
>> +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
>> +	       return false;
>> +	return true;
>> +}
>> +
> 

Along those lines I think something like this should work:

static bool should_migrate_task(struct task_struct *p, int prev_cpu)
{
         u64 now = sched_clock_cpu(prev_cpu);

         /* sched_clock reset causing next migration time to be too far ahead. */
         if (now + SCHED_MIGRATION_RATELIMIT_WINDOW < p->se.next_migration_time)
                 return true;
         /* Rate limit task migration. */
         if (now >= p->se.next_migration_time)
                return true;
         return false;
}

It will let migrate_task_rq_fair() update se->next_migration_time.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

