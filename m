Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C037BCCD2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJHHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbjJHHAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:00:08 -0400
Received: from out-205.mta1.migadu.com (out-205.mta1.migadu.com [IPv6:2001:41d0:203:375::cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4523B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:00:03 -0700 (PDT)
Message-ID: <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696748400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e25EP2ncrPSMlf32zqS7Wc/g1NCrwz+m8kkJ9qdekrg=;
        b=xrWK+LdEl2hRTbZDkexP8QRgcvJWeD02ZLYipPNoDD+p+oN+Z64LJuK42N+W4puYmW0sD7
        w9E1pzUlmlcuZ9RnipcvL84Mm08PZQM+rkuheeziH6q6TVxAsuITNfYYXZahKV+OlNlLOS
        E8/6Myzi1dmQ9BL+gMKHkIeyrScDQf0=
Date:   Sun, 8 Oct 2023 14:59:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
 <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/8 14:45, Eric Dumazet wrote:
> On Sat, Oct 7, 2023 at 8:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> On 2023/10/7 13:29, Eric Dumazet wrote:
>>> On Sat, Oct 7, 2023 at 7:06 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>> Although there is a kfree_skb_reason() helper function that can be used to
>>>> find the reason why this skb is dropped, but most callers didn't increase
>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>>>
>>> ...
>>>
>>>> +
>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>>>> +{
>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>> +       unsigned long *field;
>>>> +
>>>> +       if (unlikely(!p))
>>>> +               p = netdev_core_stats_alloc(dev);
>>>> +
>>>> +       if (p) {
>>>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>>>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>>> This is broken...
>>>
>>> As I explained earlier, dev_core_stats_xxxx(dev) can be called from
>>> many different contexts:
>>>
>>> 1) process contexts, where preemption and migration are allowed.
>>> 2) interrupt contexts.
>>>
>>> Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
>>>
>>> I _think_ I already gave you how to deal with this ?
>>
>> Yes, I replied in v6.
>>
>> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux.dev/
>>
>>> Please try instead:
>>>
>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>>> +{
>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>> +       unsigned long __percpu *field;
>>> +
>>> +       if (unlikely(!p)) {
>>> +               p = netdev_core_stats_alloc(dev);
>>> +               if (!p)
>>> +                       return;
>>> +       }
>>> +       field = (__force unsigned long __percpu *)((__force void *)p + offset);
>>> +       this_cpu_inc(*field);
>>> +}
>>
>> This wouldn't trace anything even the rx_dropped is in increasing. It
>> needs to add an extra operation, such as:
> I honestly do not know what you are talking about.
>
> Have you even tried to change your patch to use
>
> field = (__force unsigned long __percpu *)((__force void *)p + offset);
> this_cpu_inc(*field);


Yes, I tested this code. But the following couldn't show anything even 
if the rx_dropped is increasing.

'sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc'

It needs to add anything else. The above command will show correctly.

>
> Instead of the clearly buggy code you had instead :
>
>      field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>       WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>
> If your v7 submission was ok for tracing what you wanted,
> I fail to see why a v8 with 3 lines changed would not work.


Me too.

If I add a pr_info in your code, the kprobe will be ok.

