Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB97F498D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjKVO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbjKVO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:59:40 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342912A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:59:33 -0800 (PST)
Message-ID: <aca14cf3-28d3-4c5a-82ab-a4607173dbee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700665171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgrzwASWV6zynTbEcn2oewbIX2hBgKEQF1Qpo7wjIC4=;
        b=EPdUiR23cuFLP8XxMU7jXFrSTw9d2qBBQl+DXukgVUww2xN6ENTDkVK9CnysrH5LqLvNTs
        4dMcI7DSBe91PiyUU9IgOfR+1WKX0gh33yey7KoFQ/1C3KTcPXVsX5/rNwbR5So+r2X81g
        XUh1WqRRdUsFLHW09PEHacj0puONvNc=
Date:   Wed, 22 Nov 2023 22:59:02 +0800
MIME-Version: 1.0
Subject: Re: Question: memcg dirty throttle caused by low per-memcg dirty
 thresh
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        jack@suse.cz, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io, neilb@suse.de
References: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
 <ZV3Ru1BmHaU_uW7b@tiehlicka>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZV3Ru1BmHaU_uW7b@tiehlicka>
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

On 2023/11/22 18:02, Michal Hocko wrote:
> On Wed 22-11-23 17:38:25, Chengming Zhou wrote:
>> Hello all,
>>
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
> Yes, v1 didn't have any sensible IO throttling and so we had to rely on
> ugly hack to wait for writeback to finish from the memcg memory reclaim
> path.  This is really suboptimal because it makes memcg reclaim stalls
> hard to predict. So it is essentially only a poor's man OOM prevention.
> 
> V2 on the other hand has memcg aware dirty memory throttling which is a
> much better solution as it throttles at the moment when the memory is
> being dirtied.
> 
> Why do you consider that to be a problem? Constant throttling as you
> suggest might be a result of the limit being too small?

Right, v2 is better at limiting the dirty memory in one memcg, which is
better for the memcg reclaim path.

The problem we encountered is the global dirty_ratio is too small (20%)
for some cgroup workloads, like "containerd" preparing a big image file,
we want its memory.max (5GB in our case) can be most dirtied, to speed up
the process.

And yes, this may backup more dirty pages in that memcg, then the longer
writeback IO may interfere other memcgs' writeback IO. But we also have
the per-blkcg IO throttling, so it's not that bad ?

Now we have to adjust up the global dirty_ratio to achieve this result,
but it's not good for every memcg workload, and could be bad for some
memcg reclaim path as you noted.

> 
>>
>> 2. Thinking
>>
>> So we wonder if we can support the per-memcg dirty thresh interface?
>> Now the memcg dirty thresh is just calculated from memcg max * ratio,
>> which can be set from /proc/sys/vm/dirty_ratio.
> 
> In general I would recommend using dirty_bytes instead as the ratio
> doesn't scall all that great on larger systems.
>  
>> We have to set it to 60 instead of the default 20 to workaround now,
>> but worry about the potential side effects.
>>
>> If we can support the per-memcg dirty thresh interface, we can set
>> some containers to a much higher dirty_ratio, especially for hungry
>> dirtier workloads like "containerd".
> 
> But why would you want that? If you allow heavy writers to dirty a lot
> of memory then flushing that to the backing store will take more time.
> That could starve small writers as well because they could end up queued
> behind huge amount of data to be flushed.
> 

Yes, we also need per-blkcg IO throttling to distribute writeback IO bandwidth.

> I am no expert on the writeback so others could give you a better
> arguments but from my POV the dirty data flushing and throttling is
> mostly a global mechanism to optmize the IO pattern and is a function of
> storage much more than workload specific. If you heavy writer hits

Maybe the per-bdi ratio is worth trying instead of the global dirty_ratio,
which could affect all devices.

> throttling too much then either the limit is too low or you should stard
> background flushing earlier.
> 

The global dirty_ratio is too low for "containerd" in this case, so we
want more control over the memcg dirty_ratio.

Thanks!
