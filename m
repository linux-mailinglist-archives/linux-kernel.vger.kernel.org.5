Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D487FDC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjK2QBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjK2QBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA279D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701273672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tNd18nd+bxJ1BZqHDEg4dU9YjfOiYLR5XBMfKbMPiU=;
        b=GPvIzOjCAuZ/tXt2/skzU+WTeQ+mdCBM8sWxAWfUXUPdrNy8tGLo+5NQUOwBGICfMSzmRK
        clB8K+5tPtYEDz3U1AzTX0/pYYdbZ+JGD0QlkPaWLto20q3wDYstyPB7zSWmo7Da0FVYyE
        7sTuLaH3TFaCVKW/S1J7zJQABuNScYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-3O6M-KuyMKW4NpqGVr1ctA-1; Wed,
 29 Nov 2023 11:01:06 -0500
X-MC-Unique: 3O6M-KuyMKW4NpqGVr1ctA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCDBA3C0C119;
        Wed, 29 Nov 2023 16:01:05 +0000 (UTC)
Received: from [10.22.34.102] (unknown [10.22.34.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 145FAC1596F;
        Wed, 29 Nov 2023 16:01:05 +0000 (UTC)
Message-ID: <b6f88157-cf5e-4c7b-99f3-1944b4e7ebde@redhat.com>
Date:   Wed, 29 Nov 2023 11:01:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
 <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
 <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/23 17:12, Tejun Heo wrote:
> Hello,
>
> On Tue, Nov 28, 2023 at 01:32:53PM -0500, Waiman Long wrote:
>> On 11/28/23 11:56, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
>>>> +bool cpuset_cpu_is_isolated(int cpu)
>>>> +{
>>>> +	unsigned int seq;
>>>> +	bool ret;
>>>> +
>>>> +	do {
>>>> +		seq = read_seqcount_begin(&isolcpus_seq);
>>>> +		ret = cpumask_test_cpu(cpu, isolated_cpus);
>>>> +	} while (read_seqcount_retry(&isolcpus_seq, seq));
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
>>> We're testing a bit in a bitmask. I don't think we need to worry about value
>>> integrity from RMW updates being broken up. ie. We can just test the bit
>>> without seqlock and drop the first patch?
>> My concern is that if we have an isolated partition with a set of isolated
>> CPUs (say 2-4), I don't want any addition, deletion of changes made to
>> another isolated partition affects the test of the pre-existing one. Testing
>> result of the partition being change is fair game.
>>
>> Depending on how the cpumask operators are implemented, we may not have a
>> guarantee that testing CPU 2, for instance, will always return true. That is
> Can you please elaborate this part a bit? I'm having a difficult time
> imagining the sequence of operations where this would matter but that could
> easily be me not being familiar with the details.

I may be a bit paranoid about incorrect result due to racing as I had 
been burned before. Just testing a bit in the bitmask may probably be 
OK. I don't think it will be a problem for x86, but I am less certain 
about other more exotic architectures like arm64 or PPC which I am less 
familiar about. I add a seqcount for synchronization just for the peace 
of mind. I can take the seqcount out if you don't it is necessary.

I have also been thinking about an alternative helper that returns the 
whole isolated cpumask since in both cases where cpu_is_isolated() is 
used, we will have to iterate all the possible CPUs anyway, it will be 
more efficient to have the whole cpumask available. In that case, we may 
want to have a seqcount to avoid returning an intermediate result. 
Anyway, this is just a thought for now, I am not planning to do that at 
the moment.

Cheers,
Longman

