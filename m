Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409C78043C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjLEBIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:08:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAECBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:08:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A21C433C8;
        Tue,  5 Dec 2023 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701738520;
        bh=UgcL2R9C0bhYJdJ2rSepl0vFYdW6GWqKcBPVUBMjf20=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aPgdtvmcipZ5lh98Nr929Of0FRtC+TqZqj5ZKTO9Wrj4sME5iA/e0tWB9+5JqAy+0
         rUh1kJiOrQDngq6i0pFM3fMZobyCYxKsTNziDR0tJFlueNKw9cz4xUBSZpvaDsxorF
         6xGAamazrJs9Ao5bv/+pF/jTxxXLT4pDiLC8nO8b/5dt/7u4grf41OzhjP4oSKWUsZ
         +1ZHh6zriZW+zFLUw921wy1FtdOulgrhfcWFb+LWgzYfIu6zVmxmHlRgsrw8rPspHG
         4O0wRM0b/HsV2Y4IJshcHuOAunhv+Gtn6Ld0BrlJp6Ft70AjDmcYr0/SHZrNhu3wIk
         G/OQODMgc+A/w==
Message-ID: <4b095b1c-9fa8-4df9-846b-c33c01e15d97@kernel.org>
Date:   Mon, 4 Dec 2023 18:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 4:40 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Dec 1, 2023 at 1:10 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Dec 1, 2023 at 9:39 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>>>
>>> We are seeing cases where neigh_cleanup_and_release() is called by
>>> neigh_forced_gc() many times in a row with preemption turned off.
>>> When running on a low powered CPU at a low CPU frequency, this has
>>> been measured to keep preemption off for ~10 ms. That's not great on a
>>> system with HZ=1000 which expects tasks to be able to schedule in
>>> with ~1ms latency.
>>
>> This will not work in general, because this code runs with BH blocked.
>>
>> jiffies will stay untouched for many more ms on systems with only one CPU.
>>
>> I would rather not rely on jiffies here but ktime_get_ns() [1]
>>
>> Also if we break the loop based on time, we might be unable to purge
>> the last elements in gc_list.
>> We might need to use a second list to make sure to cycle over all
>> elements eventually.
>>
>>
>> [1]
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23ef09bb4b0db53b4
>> 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>  {
>>         int max_clean = atomic_read(&tbl->gc_entries) -
>>                         READ_ONCE(tbl->gc_thresh2);
>> +       u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>>         unsigned long tref = jiffies - 5 * HZ;
>>         struct neighbour *n, *tmp;
>>         int shrunk = 0;
>> +       int loop = 0;
>>
>>         NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>>
>> @@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>                         if (shrunk >= max_clean)
>>                                 break;
>>                 }
>> +               if (++loop == 16) {
>> +                       if (ktime_get_ns() > tmax)
>> +                               goto unlock;
>> +                       loop = 0;
>> +               }
>>         }
>>
>>         WRITE_ONCE(tbl->last_flush, jiffies);
>>
>> +unlock:
>>         write_unlock_bh(&tbl->lock);
> 
> I'm curious what the plan here is. Your patch looks OK to me and I
> could give it a weak Reviewed-by, but I don't know the code well
> enough to know if we also need to address your second comment that we
> need to "use a second list to make sure to cycle over all elements
> eventually". Is that something you'd expect to get resolved before
> landing?
> 
> Thanks! :-)

entries are added to the gc_list at the tail, so it should be ok to take
a break. It will pickup at the head on the next trip through.

