Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E7788903
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbjHYNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbjHYNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:50:15 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA392139
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692971410;
        bh=k4ApRPcb3uFXjZq7xQJFLsKEalB1OpbRNodnToai53g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qLvK8+qLN7pfc0V1yW/6h7Hil5K3s0hetyxeeAYGo+UbqdIm/MIe9q67JzdC3sWJW
         zOyPpWk+ByWxInohhGrQ5XSTisjrZa8xbD2tCPvh5kb4JCgBsU+0SiP7ONwlN5cdNq
         eWeSrtnv2huXs6n7ixDGqBUUah+pnvrIoJeuAG4X2IFIFiLDuYZY/Hrosg8LUhOLn8
         w9kr7YIUxByoSHU3tnexBsobSX623GghyKIeNsbcwyHVasPsTjN9IrxyIW0Cxb2844
         3Bw3ZzixPmHRCADVoNgXrpUskFOU0KryOy8gEY8Jqq4MWJuLu45gqM8b/HU+goKEKH
         rdto+vv9MjeaQ==
Received: from [172.24.0.4] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RXLtT6J0Lz1MQd;
        Fri, 25 Aug 2023 09:50:09 -0400 (EDT)
Message-ID: <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
Date:   Fri, 25 Aug 2023 09:51:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230825064929.GC464990@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 02:49, Aaron Lu wrote:
> On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
[...]
>>> - task migrations dropped with this series for nr_group=20 and 32
>>>     according to 'perf stat'. migration number didn't drop for nr_group=10
>>>     but the two update functions' cost dropped which means fewer access to
>>>     tg->load_avg and thus, fewer task migrations. This is contradictory
>>>     and I can not explain yet;
>>
>> Neither can I.
>>

[...]

>>
>>> It's not clear to me why this series can reduce task migrations. I doubt
>>> it has something to do with more wakelist style wakeup becasue for this
>>> test machine, only a single core with two SMT threads share L2 so more
>>> wakeups are through wakelist. In wakelist style wakeup, the target rq's
>>> ttwu_pending is set and that will make the target cpu as !idle_cpu();
>>> This is faster than grabbing the target rq's lock and then increase
>>> target rq's nr_running or set target rq's curr to something else than
>>> idle. So wakelist style wakeup can make target cpu appear as non idle
>>> faster, but I can't connect this with reduced migration yet, I just feel
>>> this might be the reason why task migration reduced.
>>
> 
[...]
>> I've tried adding checks for rq->ttwu_pending in those code paths on top of
>> my patch and I'm still observing the reduction in number of migrations, so
>> it's unclear to me how doing more queued wakeups can reduce migrations the
>> way it does.
> 
> An interesting puzzle.

One metric that can help understand the impact of my patch: comparing
hackbench from a baseline where only your load_avg patch is applied
to a kernel with my l2c patch applied, I notice that the goidle
schedstat is cut in half. For a given CPU (they are pretty much alike),
it goes from 650456 to 353487.

So could it be that by doing queued wakeups, we end up batching
execution of the woken up tasks for a given CPU, rather than going
back and forth between idle and non-idle ? One important thing that
this changes is to reduce the number of newidle balance triggered.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

