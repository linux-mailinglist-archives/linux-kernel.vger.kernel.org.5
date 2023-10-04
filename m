Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A967B7EED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJDMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjJDMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81770C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696422002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCki2r9Bn0BuFn05o7Il1NR+6SHO0CDb++6+9dm7szM=;
        b=YkMHm7iN/f7EWjHqDR2EqRDVAhyB5DXVN39FYCIc5GNjjdTJOxqxpFVqmUuFb4L6NMzrJc
        aCANj65FdLPmGUN5OJ+6FnjE6DS+SbsokfOJCqvn5R31/cSXMLUNsjVisnmxan+4hF5QQ9
        /byMPT1egxTsc9UzynXXu170/BEPuIw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-CxTm9tFtPCqpzMCnO1N7AQ-1; Wed, 04 Oct 2023 08:20:00 -0400
X-MC-Unique: CxTm9tFtPCqpzMCnO1N7AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 501E23806739;
        Wed,  4 Oct 2023 12:19:59 +0000 (UTC)
Received: from [10.22.32.136] (unknown [10.22.32.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78670C15BB8;
        Wed,  4 Oct 2023 12:19:58 +0000 (UTC)
Message-ID: <7a7bc23f-be01-d06a-42d2-a2a121577b09@redhat.com>
Date:   Wed, 4 Oct 2023 08:19:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <ZR0vHXDeGi+iVogR@gmail.com>
 <20231004094330.GL1539@noisy.programming.kicks-ass.net>
 <ZR05JXPgOXb4kuHl@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZR05JXPgOXb4kuHl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 06:06, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Wed, Oct 04, 2023 at 11:23:41AM +0200, Ingo Molnar wrote:
>>
>>>>   	if (user_mask) {
>>>> -		cpumask_copy(user_mask, in_mask);
>>>> +		/*
>>>> +		 * All-set user cpumask resets affinity and drops the explicit
>>>> +		 * user mask.
>>>> +		 */
>>>> +		cpumask_and(user_mask, in_mask, cpu_possible_mask);
>>>> +		if (cpumask_equal(user_mask, cpu_possible_mask)) {
>>>> +			kfree(user_mask);
>>>> +			user_mask = NULL;
>>>> +		}
>>> Question: is there any observable behavioral difference between current
>>> (old) all-set cpumask calls and the patched (new) one?
>> Very little I think -- the main difference is that we no longer carry
>> the ->user_cpus_ptr mask around, and that saves a little masking.
> So calling with a full mask would actually work fine on 'old' kernels too,
> as it's a 'reset' event in essence. (With a bit of allocation & masking
> overhead.)
>
> This pretty unambiguously marks the full-mask solution as the superior ABI ...

I am fine with that one too. I do have a little bit concern about that 
the difference in behavior when the full mask is passed in, but that is 
reverting to the old behavior before commit 8f9ea86fdf99 ("sched: Always 
preserve the user requested cpumask").

BTW, we can probably check the in_mask directly earlier to skip an 
unnecessary cpumask allocation and free in this particular case.

Cheers,
Longman

