Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA47F4A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjKVPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjKVPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:50 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711012A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:33:21 -0800 (PST)
Message-ID: <7e3d3ff6-b453-404b-beaf-cdd23fb3e1a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700667199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHIfzJtlqXfq2TWLtmGo3k1rJttIf/XhAniLKFtYdwE=;
        b=UDaSKShgQKcYx/B7S56JiFK/4D+nhiZ7wFbbEp1dd7f7WkqqkO2uJgUVLHwVG4+SI15qo/
        Rhy2/d0t7y1k6xI9p7hDueR2D+94dsjULH3MeT8D+HfqSIGaNS6fEi377SCGwmZTUEH/Wu
        UTuPvqKI/Fl6+rkwqkiPiCy2cO4bRz4=
Date:   Wed, 22 Nov 2023 23:32:50 +0800
MIME-Version: 1.0
Subject: Re: Question: memcg dirty throttle caused by low per-memcg dirty
 thresh
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io,
        neilb@suse.de, Michal Hocko <mhocko@suse.com>
References: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
 <20231122144932.m44oiw5lufwkc5pw@quack3>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231122144932.m44oiw5lufwkc5pw@quack3>
Content-Type: text/plain; charset=UTF-8
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

On 2023/11/22 22:49, Jan Kara wrote:
> Hello!
> 
> On Wed 22-11-23 17:38:25, Chengming Zhou wrote:
>> Sorry to bother you, we encountered a problem related to the memcg dirty
>> throttle after migrating from cgroup v1 to v2, so want to ask for some
>> comments or suggestions.
>>
>> 1. Problem
>>
>> We have the "containerd" service running under system.slice, with
>> its memory.max set to 5GB. It will be constantly throttled in the
>> balance_dirty_pages() since the memcg has dirty memory more than
>> the memcg dirty thresh.
>>
>> We haven't this problem on cgroup v1, because cgroup v1 doesn't have
>> the per-memcg writeback and per-memcg dirty thresh. Only the global
>> dirty thresh will be checked in balance_dirty_pages().
> 
> As Michal writes, if you allow too many memcg pages to become dirty, you
> might be facing issues with page reclaim so there are actually good reasons
> why you want amount of dirty pages in each memcg reasonably limited. Also

Yes, the memcg dirty limit (20%) is good for the memcg reclaim path.
But for some workloads (like burst dirtier) which may only create many dirty
pages in a short time, we want its memory.max 60% can be dirtied without
being throttled. And this is not much harmful for its memcg reclaim path.

> generally increasing number of available dirty pages beyond say 1GB is not
> going to bring any benefit in the overall writeback performance. It may
> still be useful in case you generate a lot of (or large) temporary files
> which get quickly deleted and thus with high enough dirty limit they don't
> have to be written to the disk at all. Similarly if the generation of dirty
> data is very bursty (i.e. you generate a lot of dirty data in a short while
> and then don't dirty anything for a long time), having higher dirty limit
> may be useful. What is your usecase that you think you'll benefit from
> higher dirty limit?

I think it's the burst dirtier in our case, and we have good performance
improvement if we change the global dirty_ratio to 60 just for testing.

> 
>> 2. Thinking
>>
>> So we wonder if we can support the per-memcg dirty thresh interface?
>> Now the memcg dirty thresh is just calculated from memcg max * ratio,
>> which can be set from /proc/sys/vm/dirty_ratio.
>>
>> We have to set it to 60 instead of the default 20 to workaround now,
>> but worry about the potential side effects.
>>
>> If we can support the per-memcg dirty thresh interface, we can set
>> some containers to a much higher dirty_ratio, especially for hungry
>> dirtier workloads like "containerd".
> 
> As Michal wrote, if this ought to be configurable per memcg, then
> configuring dirty amount directly in bytes may be more sensible.
> 

Yes, "memory.dirty_limit" should be more sensible than "memory.dirty_ratio".

>> 3. Solution?
>>
>> But we could't think of a good solution to support this. The current
>> memcg dirty thresh is calculated from a complex rule:
>>
>> 	memcg dirty thresh = memcg avail * dirty_ratio
>>
>> memcg avail is from combination of: memcg max/high, memcg files
>> and capped by system-wide clean memory excluding the amount being used
>> in the memcg.
>>
>> Although we may find a way to calculate the per-memcg dirty thresh,
>> we can't use it directly, since we still need to calculate/distribute
>> dirty thresh to the per-wb dirty thresh share.
>>
>> R - A - B
>>     \-- C
>>
>> For example, if we know the dirty thresh of A, but wb is in C, we
>> have no way to distribute the dirty thresh shares to the wb in C.
>>
>> But we have to get the dirty thresh of the wb in C, since we need it
>> to control throttling process of the wb in balance_dirty_pages().
>>
>> I may have missed something above, but the problem seems clear IMHO.
>> Looking forward to any comment or suggestion.
> 
> I'm not sure I follow what is the problem here. In balance_dirty_pages() we
> have global dirty threshold (tracked in gdtc) and memcg dirty threshold
> (tracked in mdtc). This can get further scaled down based on the device
> throughput (that is the difference between 'thresh' and 'wb_thresh') but
> that is independent of the way mdtc->thresh is calculated. So if we provide
> a different way of calculating mdtc->thresh, technically everything should
> keep working as is.
> 

Sorry for the confusion. The problem is exactly how to calculate mdtc->thresh.

R - A - B
    \-- C

Case 1:

Suppose the C has "memory.dirty_limit" set, should we just use it as mdtc->thresh?
I see the current code also consider the system clean memory in mdtc_calc_avail(),
should we also need to consider it when "memory.dirty_limit" set?

Case 2:

Suppose the C hasn't "memory.dirty_limit" set, but A has "memory.dirty_limit" set,
how do we calculate the C mdtc->thresh ?

Obviously we can't directly use the A "memory.dirty_limit", since it should be
distributed to B and C ?

So the problem is that I don't know how to reasonably calculate the mdtc->thresh,
even given a memcg tree with some memcgs have "memory.dirty_limit" set. :\

Thanks!
