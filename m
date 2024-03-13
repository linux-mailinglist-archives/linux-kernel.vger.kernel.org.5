Return-Path: <linux-kernel+bounces-102579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019F87B42D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39291C21A10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953659B43;
	Wed, 13 Mar 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdYC+z/I"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D659170
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367731; cv=none; b=V4E3eXxaXRte6+MFVrlzcZSIywpfSkT5lQf2Z26f0yLI9dCasWrZTkC4JbP1n4UnxkDaCZifgNFGrM97yO3c2Gg6S1nn+i4Lbw4heSAXp0Xek1DrutMbQrkI8lZ5ojUsCMlCamWLsjddpVPjIYCve4ip8EGE9GfVwiQNqebf18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367731; c=relaxed/simple;
	bh=3RMd42OKBnTs8lFwFkyQxqdyYrBfVYzAW6T1Ssc1euo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmLBy1Cdkeh0BqSXw2XSOxG6OdJNRaeDnyhHDwemubSHlM0y9/PyCqCHaq2NV5SDKmKLiUqXMRLLdCOnWy1+y1M2hUsP1HFnSbopr5UMnefyOCjY4E+rS7hTHZCC3BZW7oH2KOiK1QfClvSg2YHjCahrXR708WqCKwqbn5kFT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdYC+z/I; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710367727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2HdPiIovJbdghrRlh4PL9g0ZeAvHwquMNTuldIiGxE=;
	b=WdYC+z/IPaY9REsIKGH/tFpEPnuZ1hY0fPoLRhWgWlpN0Lb7E5SCQCD+Qb7CzHIZs5KdtO
	+VWjXaBMqK4WBfc7/Z6tvKdE842RRqohxR2z3he9VrKrmkVCBb11p5rKrJPh5KLHmeILgX
	xuUjP0Imr9In+iCFyphO4fNirIwKlEk=
Date: Wed, 13 Mar 2024 15:08:39 -0700
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
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
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
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/13/24 2:40 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 3/13/2024 2:01 PM, Martin KaFai Lau wrote:
>>> On 3/13/24 12:36 PM, Willem de Bruijn wrote:
>>>> Martin KaFai Lau wrote:
>>>>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
>>>>>> Martin KaFai Lau wrote:
>>>>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>>>>>>> Bridge driver today has no support to forward the userspace timestamp
>>>>>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>>>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>>>>>> time sensitive packets. These changes will allow userspace timestamps
>>>>>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>>>>>
>>>>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>>>>>>> userspace tstamp packets in the forwarding path.
>>>>>>>>
>>>>>>>> Existing functionality of mono_delivery_time remains unaltered here,
>>>>>>>> instead just extended with userspace tstamp support for bridge
>>>>>>>> forwarding path.
>>>>>>>
>>>>>>> The patch currently broke the bpf selftest test_tc_dtime:
>>>>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>>>>>>
>>>>>>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
>>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
>>>>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
>>>>>>> ingress or a delivery time set by user space).
>>>>>>>
>>>>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
>>>>>>> necessarily mean mono after this patch. I thought about fixing it on the bpf
>>>>>>> side such that reading __sk_buff->tstamp_type only returns
>>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
>>>>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>>>>>>
>>>>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
>>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
>>>>>>> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
>>>>>>> ingress skb and redirect to egress sch_fq. It could also set a mono time to
>>>>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
>>>>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
>>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
>>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>>>>>>
>>>>>>> I ran out of idea to solve this uapi breakage.
>>>>>>>
>>>>>>> I am afraid it may need to go back to v1 idea and use another bit
>>>>>>> (user_delivery_time) in the skb.
>>>>>>
>>>>>> Is the only conflict when bpf_skb_set_tstamp is called for an skb from
>>>>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
>>>>>
>>>>> Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and
>>>>> its interpretation depends on skb->sk->sk_clockid.
>>>>>
>>>>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
>>>>>> skb->sk is NULL is fine. This is the ingress to egress redirect case.
>>>>>
>>>>> skb->sk == NULL is fine. I tried something like this in
>>>>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
>>>>>
>>>>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
>>>>>
>>>>>      skb->mono_delivery_time == 1 &&
>>>>>      (!skb->sk ||
>>>>>       !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
>>>>>       skb->sk->sk_protocol == IPPROTO_TCP)
>>>>>
>>>>> Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.
>>>>>
>>>>>>
>>>>>> I don't see an immediate use for this BPF function on egress where it
>>>>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
>>>>>> but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.
>>>>>
>>>>> The bpf prog may act as a traffic shaper that limits the bandwidth usage of all
>>>>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before
>>>>> sending to the sch_fq.
>>>>>
>>>>> I currently also don't have a use case for skb->sk->sk_clockid !=
>>>>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now
>>>>> before queuing to sch_fq.
>>>>>
>>>>> The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf)
>>>>> setup and the non mono skb->tstamp is not cleared now during dev_forward_skb()
>>>>> between the veth pair.
>>>>>
>>>>>>
>>>>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
>>>>>> already explicitly programmed?
>>>>>
>>>>> This will change the existing bpf_skb_set_tstamp() behavior, so probably not
>>>>> acceptable.
>>>>>
>>>>>>
>>>>>>        skb->sk &&
>>>>>>        sock_flag(sk, SOCK_TXTIME) &&
>>>>>>        skb->sk->sk_clockid != CLOCK_MONOTONIC
>>>>>
>>>>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
>>>>>> fall back on interpreting as monotonic.
>>>>>
>>>>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.
>>>>>
>>>>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The
>>>>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only
>>>>> changes skb and does not change skb->sk.
>>>>>
>>>>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space
>>>>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing
>>>>> from looking at __sock_cmsg_send().
>>>>>
>>>>> There may be a short period of disconnect between what is in sk->sk_flags and
>>>>> what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME)
>>>>> again after skb->tstamp is set by bpf. This could be considered a small glitch
>>>>> for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).
>>>>>
>>>>> I think all this is crying for another bit in skb to mean user_delivery_time
>>>>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the
>>>>> mono time either set by kernel-tcp or bpf.
>>>>
>>>> It does sound like the approach with least side effects.
>>>>
>>>> If we're going to increase to two bits per skb, it's perhaps
>>>> better to just encode the (selected supported) CLOCK_ type, rather
>>>> than only supporting clockid through skb->sk->sk_clockid.
>>>
>>> Good idea. May be starting with mono and tai (Abishek's use case?), only forward these two clocks and reset the skb->tstamp for others.
>>>
>>>>
>>>> This BPF function is the analogue to SO_TXTIME. It is clearly
>>>> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
>>>> work with sch_etf, say.
>>>
>>> Yes, if there are bits in skb to describe the clock in the skb->tstamp, BPF_SKB_TSTAMP_DELIVERY_ can be extended to match it. It will be easier if the values in the skb bits is the same as the BPF_SKB_TSTAMP_DELIVERY_*.
>>>
>>> The bpf_convert_tstamp_*() and the bpf_skb_set_tstamp helper will need changes to include the consideration of these two bits. I think we have mostly settled with the approach (thanks for the discussion!). Abhishek, not sure how much can be reused from this patch for the two bits apporach, do you want to revert the current patch first and then start from clean?
>>>
>> Yes , I think since we have concluded the two bit .(Thanks for discussion again, Martin and Willem)
>>
>> Here is what i will do from myside
>> 1. Revert the v4 patch :-  net: Re-use and set mono_delivery_time bit for userspace tstamp packets
>> 2. Keep mono_delivery_time as ease
>> 3. Add user_delivery_time as a new bitfield
>> 4. Add BPF_SKB_TSTAMP_DELIVERY_TAI in the bpf.h for etf support
>> 5. do not reset the time if either mono_delivery_time or user_delivery_time is set.
>>
>> Let me know if i have covered all the design details or add if i missed anything.
> 
> Thanks for revising this.
> 
> No need to add the BPF part here.
> 
> I was mistaken that we can encode the clock_id in two skb bits.
> SO_TXTIME allows essentially all CLOCK_...

The two bits could potentially only encode the delivery time that is allowed to 
be forwarded without reset. 0 could mean refering back to sk_clockid and don't 
forward. The final consumer of the forwarded skb->tstamp is the qdisc which 
currently only has mono and tai. The concern is more on future extension to 
allow more clock type to be forwarded?

I don't have a use case for having BPF_SKB_TSTAMP_DELIVERY_TAI but curious on 
how other clock types are used now.

Thanks.

> 
> So indeed we will need a user_delivery_time bit and use that to look
> at sk_clockid.


