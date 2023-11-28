Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D257FC34F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbjK1SdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjK1Scw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAE112
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701196378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLioCArnr0IJqhFqguaq4z/iJ7qIOy5O8bw1FPJnvLM=;
        b=BLLZ++Ap4imUlg+uy3DNJ7u8Q1xffYbra6P5B4+hnJb2jOs6au0Ll2hSfXigOHPheQ+P+O
        hI0QXAnDCcUnmHk1AuB2SSJ91zx+9jcJ17LdfezzcVoYYN9lEYvyBEqe3jHAUaZtBB2iHb
        xI4eqpDwj/m5VYNSGaxoDmZ1wT67DWU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Tle2EXXqM5CbNcW1fP27HA-1; Tue,
 28 Nov 2023 13:32:54 -0500
X-MC-Unique: Tle2EXXqM5CbNcW1fP27HA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3067F1C05135;
        Tue, 28 Nov 2023 18:32:54 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FDE40C6EB9;
        Tue, 28 Nov 2023 18:32:53 +0000 (UTC)
Message-ID: <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
Date:   Tue, 28 Nov 2023 13:32:53 -0500
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYbqNnnt6gQOssK@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/23 11:56, Tejun Heo wrote:
> Hello,
>
> On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
>> +bool cpuset_cpu_is_isolated(int cpu)
>> +{
>> +	unsigned int seq;
>> +	bool ret;
>> +
>> +	do {
>> +		seq = read_seqcount_begin(&isolcpus_seq);
>> +		ret = cpumask_test_cpu(cpu, isolated_cpus);
>> +	} while (read_seqcount_retry(&isolcpus_seq, seq));
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
> We're testing a bit in a bitmask. I don't think we need to worry about value
> integrity from RMW updates being broken up. ie. We can just test the bit
> without seqlock and drop the first patch?

My concern is that if we have an isolated partition with a set of 
isolated CPUs (say 2-4), I don't want any addition, deletion of changes 
made to another isolated partition affects the test of the pre-existing 
one. Testing result of the partition being change is fair game.

Depending on how the cpumask operators are implemented, we may not have 
a guarantee that testing CPU 2, for instance, will always return true. 
That is why I am adding some synchronization primitive to prevent 
racing. My original plan was to take the callback_lock. However, that 
can be somewhat costly if this API is used rather frequently, especially 
on systems with large # of CPUs. So I change it to use seqcount for read 
protection which has a much lower cost.

Regarding patch 1 on converting callback_lock to raw_spinlock_t, I can 
drop it if you have concern about that change. I just need to surround 
the write_seqcount_begin()/write_seqcount_end() calls with 
preempt_disabled()/preempt_enabled().

Cheers,
Longman

