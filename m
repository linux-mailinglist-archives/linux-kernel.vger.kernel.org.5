Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181AA7B7167
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjJCS7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJCS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12D9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696359542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g84yvdOkOfK8ImlsVuUfAihWEZ37t2ndqXqg7w/OTXc=;
        b=ZK+CmrSjGG5uerob61NUChbBYzAdeGgEuZFOpE/29CwjWNPxGEHtHHpb7CiBTZ3Sy7/NQS
        Z6/s/LB8NCkkX5L+hdBafoJYDala58urqHsbYQjZ9RhMTMwD7wCKJuOO81jkbst3/gyL98
        CnTtVaV9FHUI1U06hERTZyw2A+hKu+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-MbqZBjz4Ox6XpqSJvysezw-1; Tue, 03 Oct 2023 14:59:00 -0400
X-MC-Unique: MbqZBjz4Ox6XpqSJvysezw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 200AB101A5C5;
        Tue,  3 Oct 2023 18:59:00 +0000 (UTC)
Received: from [10.22.10.176] (unknown [10.22.10.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1F62156701;
        Tue,  3 Oct 2023 18:58:59 +0000 (UTC)
Message-ID: <320f6e2e-c0ae-3cbd-bc43-d2eabcd70cc4@redhat.com>
Date:   Tue, 3 Oct 2023 14:58:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20230804023218.75544-1-longman@redhat.com>
 <20231003100602.GF27267@noisy.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231003100602.GF27267@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/23 06:06, Peter Zijlstra wrote:
> On Thu, Aug 03, 2023 at 10:32:18PM -0400, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
>> perserved even if the task is being moved to a different cpuset. However,
>> that affinity is also being inherited by any subsequently created child
>> processes which may not want or be aware of that affinity.
>>
>> One way to solve this problem is to provide a way to back off from
>> that user provided CPU affinity.  This patch implements such a scheme
>> by using an empty cpumask to signal a reset of the cpumasks to the
>> default as allowed by the current cpuset.
> So I still don't like this much, the normal state is all bits set:
>
>    $ grep allowed /proc/self/status
>    Cpus_allowed:   ff,ffffffff
>
> The all clear bitmask just feels weird for this.

The main reason for using an empty bitmask is the presence of the 
CPU_ZERO() macro that can produce this empty cpumask. It is certainly 
possible to use an all set bitmask for reset purpose. The only problem 
is it is more complicated to generate such a bitmask as there is no 
existing CPU* macros that can be used.

Another possible alternative is to use a cpusetsize of 0 to indicate a 
reset as long as it doesn't cause problem with existing code. Will that 
be acceptable?

Cheers,
Longman

