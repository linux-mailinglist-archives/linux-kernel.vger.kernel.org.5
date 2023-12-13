Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6868081083D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378313AbjLMC2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjLMC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC7A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702434488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7ogPeVXGwrtgOAoSCz/LwV9L8KL6rZODfc0Bz4jg5I=;
        b=MaTpY4hWQVDu012XjFagR7j3NRuJR7Us8PGRA89qj37v4KSFCZ913lIsb0YpMxgyAO4VMI
        aVPlcjcFdb6Ho8qZeL1LYgJRzeUuFBrb1MQTywX1yEQpIQzWTVesEmny2pVSrqPl6T07Hj
        JUbzeiypVFHUkSRWirWnwYOtofD9bhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-XpbZrWEdMHG6dIbEnA-3Kw-1; Tue, 12 Dec 2023 21:28:06 -0500
X-MC-Unique: XpbZrWEdMHG6dIbEnA-3Kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1D9D87B2A1;
        Wed, 13 Dec 2023 02:28:05 +0000 (UTC)
Received: from [10.22.16.51] (unknown [10.22.16.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81AB51C060AF;
        Wed, 13 Dec 2023 02:28:04 +0000 (UTC)
Message-ID: <ef9fa80e-f586-4c44-b2b1-309830dccaa4@redhat.com>
Date:   Tue, 12 Dec 2023 21:28:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Gianfranco Dutka <gianfranco.dutka@arista.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Phil Auld <pauld@redhat.com>,
        Cestmir Kalina <ckalina@redhat.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
 <ZXhf3A0FNjFZaZGK@lothringen>
 <7e3bf653-d3ea-48b0-b808-d92a3c5f2c5b@redhat.com>
 <ZXjzVKAM7Xt3eeAQ@lothringen>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZXjzVKAM7Xt3eeAQ@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


On 12/12/23 18:57, Frederic Weisbecker wrote:
> On Tue, Dec 12, 2023 at 03:18:43PM -0500, Waiman Long wrote:
>> On 12/12/23 08:27, Frederic Weisbecker wrote:
>>> On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
>>>>> The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. I am in the process of improving dynamic CPU isolation at runtime. Right now, we are able to do isolcpus=domain with the isolated cpuset partition functionality. Other aspects of CPU isolation are being looked at with the goal of reducing the gap of what one can do at boot time versus what can be done at run time. It will certain take time to reach that goal.
>>>>>
>>>>> Cheers,
>>>>> Longman
>>>>>
>>>> Thank you Waiman for the response. It would seem that getting similar
>>>> functionality through cgroups/cpusets is the only option at the moment. Is it
>>>> completely out of the question to possibly patch the kernel to modify these
>>>> parameters at runtime? Or would that entail a significant change that might
>>>> not be so trivial to accomplish? For instance, the solution wouldn’t be as
>>>> simple as patching the kernel to make these writeable and then calling the
>>>> same functions which run at boot-time when these parameters are originally
>>>> written?
>>> As for nohz_full (which implies rcu_nocb), it's certainly possible to make it
>>> tunable at runtime via cpusets. If people really want it, I'm willing to help.
>> As said by Phil, your help in in enabling dynamic rcu_nocb will be greatly
>> appreciated.
> rcu_nocb is already ready for that. The not yet ready part is nohz_full and its
> several components (tick, remote tick, [hr-]timers affinity, workqueues affinity, kthreads
> affinity, vmstat, buffer head, etc...). Last debate on plumbers suggested that
> nohz_full should be dynamically turned on/off only on offline CPUs. That will
> indeed simplify the problem.

So rcu_nocb is ready for dynamically changing it without too much 
additional work. That is good to know as I haven't looked into that myself.

The other pieces will still need additional work. I already have a patch 
in the cgroup tree that updates the unbound workqueue affinity to 
exclude isolated cpuset CPUs, though there may still be some further 
fine tuning that can be done.

>
>> My current thought is to have a root level
>> cpuset.cpus.isolation_control file to enable additional CPU isolation like
>> rcu_nocb to be applied to CPUs in isolated partitions.
> Last time I tried that, Peter Zijlstra was more in favour of an isolate all or nothing
> switch by default for nohz_full that would include rcu_nocb. And then if people
> are interested in something more finegrained, introduce such a file to control
> individual features (see
> https://lore.kernel.org/lkml/YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net/ )
>
> But so far I never heard about the need for such a finegrained isolation. Users of
> nohz_full= seem to want to isolate everything out.

Yes, I recall some of the discussion now. I am fine with a single on/off 
switch. That will likely simplify the process as we can add additional 
isolation features over time once the code is ready, may be a 
cpuset.cpus.isolation_full boolean flag.

Cheers,
Longman


>
> Thanks.
>

