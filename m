Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6B7BBDE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjJFRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:38:03 -0400
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB001C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:38:01 -0700 (PDT)
Message-ID: <57c35480-983d-2056-1d72-f6e555069b83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696613876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpXKuzg71AgBMcaKo6kzSKg7OXzsFHX5EQqRaIUxIhA=;
        b=WfD9FbXP+XfaMTekiCdxwIA2Ul/LvowsY4QBrZ5BWJNt6IM4YA16uruGqTq54eIe4xeXf6
        pPDH/1uRgfEVVr24mekBmZ544XqEhwaPL+soaK/g99hIBxGcRgu0DCFI6WceegYvhmfhzv
        rtE8yomic9cJM1uYaQGbmi3/EfQMvfM=
Date:   Fri, 6 Oct 2023 10:37:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
        syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
        bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net
References: <20231005193548.515-1-andrew.kanner@gmail.com>
 <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
 <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 12:09 AM, Andrew Kanner wrote:
> On Thu, Oct 05, 2023 at 06:00:46PM -0700, Martin KaFai Lau wrote:
> [...]
>>> diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
>>> index f8905400ee07..c7e8bbb12752 100644
>>> --- a/net/xdp/xsk_queue.c
>>> +++ b/net/xdp/xsk_queue.c
>>> @@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
>>>    	q->ring_mask = nentries - 1;
>>>    	size = xskq_get_ring_size(q, umem_queue);
>>> +	if (unlikely(size == SIZE_MAX)) {
>>
>> What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?
>>
>>> +		kfree(q);
>>> +		return NULL;
>>> +	}
>>> +
>>>    	size = PAGE_ALIGN(size);
>>>    	q->ring = vmalloc_user(size);
>>
> 
> I asked myself the same question before v1. E.g. thinking about the
> check: (size > SIZE_MAX - PAGE_SIZE + 1)
> 
> But xskq_create() is called after the check for
> !is_power_of_2(entries) in xsk_init_queue(). So I tried the same
> reproducer and divided the (nentries) value by 2 in a loop - it hits
> either SIZE_MAX case or the normal cases without overflow (sometimes
> throwing vmalloc error complaining about size which exceed total pages
> in my arm setup).
> 
> So I can't see a way size will be SIZE_MAX-1, etc. Correct me if I'm
> wrong, please.
> 
> PS: In the output below the first 2 values of (nentries) hit SIZE_MAX

Thanks for the explanation, so iiuc it means it will overflow the struct_size() 
first because of the is_power_of_2(nentries) requirement? Could you help adding 
some comment to explain? Thanks.

> case, the rest hit the normal case, vmalloc_user() is complaining
> about 1 allocation:
> 
> 0x20000000
> 0x10000000
> 0x8000000
> [   41.759195][ T2807] pre PAGE_ALIGN size = 2147483968 (0x80000140), PAGE_SIZE = 4096 (0x1000)
> [   41.759621][ T2807] repro-iter: vmalloc error: size 2147487744, exceeds total pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> [...]
> 0x4000000
> 0x2000000
> 0x1000000
> 0x800000
> 0x400000
> 0x200000
> 0x100000
> 0x80000
> 0x40000
> 0x20000
> 0x10000
> 0x8000
> 0x4000
> 0x2000
> 0x1000
> 0x800
> 0x400
> 0x200
> 0x100
> 0x80
> 0x40
> 0x20
> 0x10
> 0x8
> 0x4
> 0x2
> 

