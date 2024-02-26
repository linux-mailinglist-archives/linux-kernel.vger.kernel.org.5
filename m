Return-Path: <linux-kernel+bounces-81150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC1867125
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B57228871D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35721CFA9;
	Mon, 26 Feb 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8LsbQBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA11CABF;
	Mon, 26 Feb 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942700; cv=none; b=u9HYPPnXy6QLSSnDPqhdZ3ejMLs8Pz4faflqmnDyL+b3SK7fWwF8wQ/tAQ7JezAFNQdwiv6xvcleohuShuYkt4Wjn/GRcdUAqLNtcgiKg7DJOzY/jH6fAYOXO0Z/G3W6yUvBLZC0LgmF6KhfTqBl+ZBLPVlaOsvjQJQwqVCrgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942700; c=relaxed/simple;
	bh=mFO7+G0tEjbg4M4mUtn7+xGTlT36Az3/BD2MVuIpse4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSmFmrt5vSoZ8+UG4bOj9dZt0x28zLJ1G6HKT4mlm5btpR5Om7X/xNVR20Vk8vcUIXhri8lUSeOQjRcPRyMGEKQdMPWK69f3Kd4tFA1yZvNf496ApGiN4JA8pxQQ+5szA49JmDI5xzLSxN247ReN3jUBMNTu3AxZBbhQmox94J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8LsbQBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25517C433F1;
	Mon, 26 Feb 2024 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708942699;
	bh=mFO7+G0tEjbg4M4mUtn7+xGTlT36Az3/BD2MVuIpse4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S8LsbQBTdYmj8SyRiLaflK/cml3rC77ADNJ482G2pHTuRPtkjhrFBNXWd9NGaZSUF
	 r57kf12lEEYkR/9I4ZvHLw1XjeEZh0kpmxSWThvUVo/FhXQoF2IuHdK8oVBXPV/Eai
	 vfplAvuhy44dLK5zFZ/rdi8cLtC0U6aSO8XAeH/B3wzdHQeXo3V1Zb3PW/lWQXeCeC
	 4s6L2JfXYzwZ/Hugf2dg+NlyeUiUYQjXpbWdL8DbC7YmUDjJ4Fi/t9vd4bRuZL4CK4
	 9hncXE8VDdk+n5YIWXkyYeDetHIBrT+gc1vSZ29l0SACkRoqPvlXiKwv1Cg2vJHYzi
	 wC7D0PmK2uWlg==
Message-ID: <bd0a9d66-783d-4936-a5b0-cd4082704137@kernel.org>
Date: Mon, 26 Feb 2024 11:18:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, aleksander.lobakin@intel.com,
 Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org,
 patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org,
 ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 cl@os.amperecomputing.com
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
 <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
 <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
 <CANn89i+Cr1Tbdxqy6fB-sOLca+AHFc-3-0xGktVUsQFFMVsC0A@mail.gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CANn89i+Cr1Tbdxqy6fB-sOLca+AHFc-3-0xGktVUsQFFMVsC0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2024 20.07, Eric Dumazet wrote:
> On Tue, Feb 20, 2024 at 9:37 AM Shijie Huang
> <shijie@amperemail.onmicrosoft.com> wrote:
>>
>>
>> 在 2024/2/20 16:17, Eric Dumazet 写道:
>>> On Tue, Feb 20, 2024 at 7:26 AM Shijie Huang
>>> <shijie@amperemail.onmicrosoft.com> wrote:
>>>>
>>>> 在 2024/2/20 13:32, Eric Dumazet 写道:
>>>>> On Tue, Feb 20, 2024 at 3:18 AM Huang Shijie
>>>>> <shijie@os.amperecomputing.com> wrote:
>>>>>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
>>>>>> it may creates fclone SKB in remote NUMA node.
>>>>> This is intended (WAI)
>>>> Okay. thanks a lot.
>>>>
>>>> It seems I should fix the issue in other code, not the networking.
>>>>
>>>>> What about the NUMA policies of the current thread ?
>>>> We use "numactl -m 0" for memcached, the NUMA policy should allocate
>>>> fclone in
>>>>
>>>> node 0, but we can see many fclones were allocated in node 1.
>>>>
>>>> We have enough memory to allocate these fclones in node 0.
>>>>
>>>>> Has NUMA_NO_NODE behavior changed recently?
>>>> I guess not.
>>>>> What means : "it may creates" ? Please be more specific.
>>>> When we use the memcached for testing in NUMA, there are maybe 20% ~ 30%
>>>> fclones were allocated in
>>>>
>>>> remote NUMA node.
>>> Interesting, how was it measured exactly ?
>>
>> I created a private patch to record the status for each fclone allocation.
>>
>>
>>> Are you using SLUB or SLAB ?
>>
>> I think I use SLUB. (CONFIG_SLUB=y,
>> CONFIG_SLAB_MERGE_DEFAULT=y,CONFIG_SLUB_CPU_PARTIAL=y)
>>
> 
> A similar issue comes from tx_action() calling __napi_kfree_skb() on
> arbitrary skbs
> including ones that were allocated on a different NUMA node.
> 
> This pollutes per-cpu caches with not optimally placed sk_buff :/
> 
> Although this should not impact fclones, __napi_kfree_skb() only ?
> 
> commit 15fad714be86eab13e7568fecaf475b2a9730d3e
> Author: Jesper Dangaard Brouer <brouer@redhat.com>
> Date:   Mon Feb 8 13:15:04 2016 +0100
> 
>      net: bulk free SKBs that were delay free'ed due to IRQ context
> 
> What about :
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c588808be77f563c429eb4a2eaee5c8062d99582..63165138c6f690e14520f11e32dc16f2845abad4
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5162,11 +5162,7 @@ static __latent_entropy void
> net_tx_action(struct softirq_action *h)
>                                  trace_kfree_skb(skb, net_tx_action,
>                                                  get_kfree_skb_cb(skb)->reason);
> 
> -                       if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
> -                               __kfree_skb(skb);
> -                       else
> -                               __napi_kfree_skb(skb,
> -                                                get_kfree_skb_cb(skb)->reason);

Yes, I think it makes sense to avoid calling __napi_kfree_skb here.
The __napi_kfree_skb call will cache SKB slub-allocation (but "release"
data) on a per CPU napi_alloc_cache (see code napi_skb_cache_put()).
In net_tx_action() there is a chance this could originate from another
CPU or even NUMA node.  I notice this is only for SKBs on the
softnet_data->completion_queue, which have a high chance of being cache
cold.  My patch 15fad714be86e only made sense when we bulk freed these
SKBs, but after Olek's changes to cache freed SKBs, then this shouldn't
be calling __napi_kfree_skb() (previously named __kfree_skb_defer).

I support this RFC patch from Eric.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> +                       __kfree_skb(skb);
>                  }
>          }

