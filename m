Return-Path: <linux-kernel+bounces-102516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621887B326
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950601F2859D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31051C4B;
	Wed, 13 Mar 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E3vG0i3s"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68244176C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363683; cv=none; b=kRym/uV+EHOjhQcamLMxuFQJoXd8Oi12V0xsNxjKxojxhWmAOjZnFDYz2fGgusT/79BpmW4P0eKmx/YFAeCHZY/HmGIthqW2I3AIr0bAvYzKuomhF7Cd9G3PQgFc959x46sinR2Xzu0oVZUoDYCUM2yDa8hNW4s4LFlzUNxL+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363683; c=relaxed/simple;
	bh=FtMFaGCWX/IIgqeePVzOqhXZdKAonuX6N+DPgyPNtJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfBJfGg0sj6g9izP9GW85KX4yzFUi1e/obGMzIGLi9TMta88Q+JQehZugJQJBRdKN49nSrML7s1qO6pKDRN/GbtXdNutM1fZJOTs8tvo/BUGJZVNCB4FWHLt1K62/wSrRhQ9UyFAR+5GeetfAZLoVMBHaBj4lpjy+rg6t60OSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E3vG0i3s; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710363678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDvEFHw9onLk72OR89fNPceBtz3o0jeeuGwgKPgczZ8=;
	b=E3vG0i3stzEWxa9uOf7XvRBB3P0uncJpQ9qahetr/fMLx44Vr2Zudu5x03VByuTlRDo3ca
	YI70JqCZ+VI0TbTF9p8RwUyMzbKYnIDHgnQkzGeJnB8Ke2zi3M2XoO++cymFtX22QaETcx
	hHDByj4IGVCZJ0FIDx5l4zRnBC56QFw=
Date: Wed, 13 Mar 2024 14:01:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/13/24 12:36 PM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
>>> Martin KaFai Lau wrote:
>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>>>> Bridge driver today has no support to forward the userspace timestamp
>>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>>> time sensitive packets. These changes will allow userspace timestamps
>>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>>
>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>>>> userspace tstamp packets in the forwarding path.
>>>>>
>>>>> Existing functionality of mono_delivery_time remains unaltered here,
>>>>> instead just extended with userspace tstamp support for bridge
>>>>> forwarding path.
>>>>
>>>> The patch currently broke the bpf selftest test_tc_dtime:
>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>>>
>>>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
>>>> ingress or a delivery time set by user space).
>>>>
>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
>>>> necessarily mean mono after this patch. I thought about fixing it on the bpf
>>>> side such that reading __sk_buff->tstamp_type only returns
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>>>
>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
>>>> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
>>>> ingress skb and redirect to egress sch_fq. It could also set a mono time to
>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>>>
>>>> I ran out of idea to solve this uapi breakage.
>>>>
>>>> I am afraid it may need to go back to v1 idea and use another bit
>>>> (user_delivery_time) in the skb.
>>>
>>> Is the only conflict when bpf_skb_set_tstamp is called for an skb from
>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
>>
>> Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and
>> its interpretation depends on skb->sk->sk_clockid.
>>
>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
>>> skb->sk is NULL is fine. This is the ingress to egress redirect case.
>>
>> skb->sk == NULL is fine. I tried something like this in
>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
>>
>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
>>
>> 	skb->mono_delivery_time == 1 &&
>> 	(!skb->sk ||
>> 	 !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
>> 	 skb->sk->sk_protocol == IPPROTO_TCP)
>>
>> Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.
>>
>>>
>>> I don't see an immediate use for this BPF function on egress where it
>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
>>> but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.
>>
>> The bpf prog may act as a traffic shaper that limits the bandwidth usage of all
>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before
>> sending to the sch_fq.
>>
>> I currently also don't have a use case for skb->sk->sk_clockid !=
>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now
>> before queuing to sch_fq.
>>
>> The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf)
>> setup and the non mono skb->tstamp is not cleared now during dev_forward_skb()
>> between the veth pair.
>>
>>>
>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
>>> already explicitly programmed?
>>
>> This will change the existing bpf_skb_set_tstamp() behavior, so probably not
>> acceptable.
>>
>>>
>>>       skb->sk &&
>>>       sock_flag(sk, SOCK_TXTIME) &&
>>>       skb->sk->sk_clockid != CLOCK_MONOTONIC
>>
>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
>>> fall back on interpreting as monotonic.
>>
>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.
>>
>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The
>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only
>> changes skb and does not change skb->sk.
>>
>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space
>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing
>> from looking at __sock_cmsg_send().
>>
>> There may be a short period of disconnect between what is in sk->sk_flags and
>> what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME)
>> again after skb->tstamp is set by bpf. This could be considered a small glitch
>> for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).
>>
>> I think all this is crying for another bit in skb to mean user_delivery_time
>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the
>> mono time either set by kernel-tcp or bpf.
> 
> It does sound like the approach with least side effects.
> 
> If we're going to increase to two bits per skb, it's perhaps
> better to just encode the (selected supported) CLOCK_ type, rather
> than only supporting clockid through skb->sk->sk_clockid.

Good idea. May be starting with mono and tai (Abishek's use case?), only forward 
these two clocks and reset the skb->tstamp for others.

> 
> This BPF function is the analogue to SO_TXTIME. It is clearly
> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
> work with sch_etf, say.

Yes, if there are bits in skb to describe the clock in the skb->tstamp, 
BPF_SKB_TSTAMP_DELIVERY_ can be extended to match it. It will be easier if the 
values in the skb bits is the same as the BPF_SKB_TSTAMP_DELIVERY_*.

The bpf_convert_tstamp_*() and the bpf_skb_set_tstamp helper will need changes 
to include the consideration of these two bits. I think we have mostly settled 
with the approach (thanks for the discussion!). Abhishek, not sure how much can 
be reused from this patch for the two bits apporach, do you want to revert the 
current patch first and then start from clean?

> 
>> If we need to revert the
>> mono_delivery_time reuse patch later, we will need to revert the netdev patch
>> and the (to-be-made) bpf patch.
> 
> 
>   
> 
> 


