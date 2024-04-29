Return-Path: <linux-kernel+bounces-161754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587128B50C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E461F21F44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D593BF4EE;
	Mon, 29 Apr 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wcg56/I9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A4DDB2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368853; cv=none; b=rKrd6p89nxEIG+vA++X/cMqKtE5/Kqes962S6TDPZk7xm4RAI7TKnB8Isg22ZBWFVolXKw1XTCWjpD7Gh/PUCjUDzHHD+CNEkFOYzMoQRZyn/J0x1S5k8M7PnObvKm2Q3l0XkZ8EzPvgwxu0ArSY8QkrnCbnpgwzEr6+oEEichw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368853; c=relaxed/simple;
	bh=TIXAj1vDw8yeDkEzbdDF0i7iyfyqhgKy44sw2luvvcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIfBAlqetyLRH+/xMMNBG3XNNGxSLkDhYwCe0p1yLsyVTF9zPeV5IQF4woL5KTPPnp7gu3ys5M4Mzciug4gt9C8N5cH0xOcgjZ2Rp0AShIRwKYiM+X2avKT6XRxBIPMr8uFAdgNsJGBJbzxUrkjwZ0tJh86+huczm8RFKngxY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wcg56/I9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714368850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5HKdktcPTQLHAhy6G4toZcd+wzsJ2LHw+RNWERO240=;
	b=Wcg56/I99/s8oZYRQixQMHKMtjF8QfDh3pqGhGcNyNiSITBqCXReApjOIQOVEjQxCitZSF
	zxUrH5bonU6raZslEaVoOMg0FrSW1g7H1pmMe2qwy0bB79ZeLmVMfAqx/NseU7L7JMZN2B
	VEm4x8YHM3Ol+J37VKflf/5jtAT/3/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-2KXn3Vo4MLu3_IYY6a6lFA-1; Mon, 29 Apr 2024 01:34:06 -0400
X-MC-Unique: 2KXn3Vo4MLu3_IYY6a6lFA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0bad9e756so10818136d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714368846; x=1714973646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5HKdktcPTQLHAhy6G4toZcd+wzsJ2LHw+RNWERO240=;
        b=PAx0XBt81L/j6VVSHDLfVoPNeP8AAK/UqXKYzSmZ0SFMT5lElXW3rWtaB5pFLFnY/2
         bJz4lfdiYQ1nSM8KnnPQUKwqDswLsJBDVZU+SFIpRKU88nhqjpXGQpoYf+dja972uGZ+
         jY6xZfH+9kQFHn0YikC6w8cZtkQFCBWzQMo8mY9u6rJFOuOgZbx4sjtnb0U63qTQwSVn
         KRfe+pI0gEJTwB8DBU8pgsBf/c6B/h3LgN3lGSHTeN3+Y804A6vsyQk4WB0PHZApHb31
         tvGY1sbY47GBM8sWmT5ziM9GlAfi1J/l6SUCBjdmEVhPAFjp2sVTY2X1vAMSs14ClaZ2
         wFPA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBqbW2KCWjkqwpYc1lkAAblEqWXhrYYo3JfqtCsyoF5SeoWxvHOMK9JZxHDvo+ZhrgiezZGjG+L5IUnMBkHn1s148csOcupHqW+Xx
X-Gm-Message-State: AOJu0YyMfomCc/3qnbTrDG0yBsWe73mRwvPWg4j5qVBMj83VhHWnQ/e4
	/HkbdQCQ3tMxmagN6l+FWisLGTOORoUDlHX0RoUG1+Q1itKIpUs9v6bVhIvMQ9a6x0EHfvFEqom
	2MdXZLzaCqAGCUTxp5eaNPx9dAri13E0Gux5NpHkIj2re+mSuDB5dBbOJHPGirg==
X-Received: by 2002:ac8:7f46:0:b0:43a:b531:5e6f with SMTP id g6-20020ac87f46000000b0043ab5315e6fmr4488830qtk.62.1714368845860;
        Sun, 28 Apr 2024 22:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6LEEPrYl843QlnQMyzRQSwoCIlYfYduB6F9TQ4+bZl/wQrAkCS2VBwd1jCVVajJTq6TgRg==
X-Received: by 2002:ac8:7f46:0:b0:43a:b531:5e6f with SMTP id g6-20020ac87f46000000b0043ab5315e6fmr4488816qtk.62.1714368845524;
        Sun, 28 Apr 2024 22:34:05 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b0043a7cb47069sm2655123qtp.9.2024.04.28.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 22:34:05 -0700 (PDT)
Message-ID: <96bd71d6-2978-435f-99f8-c31097487cac@redhat.com>
Date: Mon, 29 Apr 2024 07:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] net: psample: add tracepoint
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-5-amorenoz@redhat.com> <ZioDvluh7ymBI8qF@shredder>
 <542ed8dd-2d9c-4e4f-81dc-e2a9bdaac3b0@redhat.com> <Zip1zKzG5aF1ceom@shredder>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <Zip1zKzG5aF1ceom@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 17:25, Ido Schimmel wrote:
> On Thu, Apr 25, 2024 at 10:06:20AM +0200, Adrian Moreno wrote:
>>
>>
>> On 4/25/24 09:18, Ido Schimmel wrote:
>>> On Wed, Apr 24, 2024 at 03:50:51PM +0200, Adrian Moreno wrote:
>>>> Currently there are no widely-available tools to dump the metadata and
>>>> group information when a packet is sampled, making it difficult to
>>>> troubleshoot related issues.
>>>>
>>>> This makes psample use the event tracing framework to log the sampling
>>>> of a packet so that it's easier to quickly identify the source
>>>> (i.e: group) and context (i.e: metadata) of a packet being sampled.
>>>>
>>>> This patch creates some checkpatch splats, but the style of the
>>>> tracepoint definition mimics that of other modules so it seems
>>>> acceptable.
>>>
>>> I don't see a good reason to add this tracepoint (which we won't be able
>>> to remove) when you can easily do that with bpftrace which by now should
>>> be widely available:
>>>
>>> #!/usr/bin/bpftrace
>>>
>>> kfunc:psample_sample_packet
>>> {
>>>           $ts_us = nsecs() / 1000;
>>>           $secs = $ts_us / 1000000;
>>>           $us = $ts_us % 1000000;
>>>           $group = args.group;
>>>           $skb = args.skb;
>>>           $md = args.md;
>>>
>>>           printf("%-16s %-6d %6llu.%6llu group_num = %u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%rx\n",
>>>                  comm, pid, $secs, $us, $group->group_num, $group->refcount, $group->seq,
>>>                  $skb, $skb->len, $skb->data_len, args.sample_rate,
>>>                  $md->in_ifindex, $md->out_ifindex,
>>>                  buf($md->user_cookie, $md->user_cookie_len));
>>> }
>>>
>>> Example output:
>>>
>>> mausezahn        984      3299.200626 group_num = 1 refcount=1 seq=13775 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
>>> \xde\xad\xbe\xef
>>> mausezahn        984      3299.281424 group_num = 1 refcount=1 seq=13776 skbaddr=0xffffa21143fd4000 len=42 data_len=0 sample_rate=10 in_ifindex=0 out_ifindex=20 user_cookie=
>>> \xde\xad\xbe\xef
>>>
>>> Note that it prints the cookie itself unlike the tracepoint which only
>>> prints the hashed pointer.
>>>
>>
>> I agree that bpftrace can do the work relying on kfuncs/kprobes. But I guess
>> that also true for many other tracepoints out there, right?
> 
> Maybe, but this particular tracepoint is not buried deep inside some
> complex function with manipulated data being passed as arguments.
> Instead, this tracepoint is placed at the very beginning of the function
> and takes the function arguments as its own arguments. The tracepoint
> can be easily replaced with fentry/kprobes like I've shown with the
> example above.
> 
>> For development and labs bpftrace is perfectly fine, but using kfuncs and
>> requiring recompilation is harder in production systems compared with using
>> smaller CO-RE tools.
> 
> I used bpftrace because it is very easy to write, but I could have done
> the same with libbpf. I have a bunch of such tools that I wrote over the
> years that I compiled once on my laptop and which I copy to various
> machines where I need them.
>

My worry is that if tools are built around a particular kprobe/kfunc they will 
break if the function name or its arguments change, where as a tracepoint give 
them a bit more stability across kernel versions. This breakage might not be a 
huge problem for bpftrace since the user can change the script at runtime, but 
libbpf programs will need recompilation or some kind of version-detection mechanism.

Given the observability-oriented nature of psample I can very much see tools 
like this being built (I myself plan to write one for OVS repo) and my concern 
is having their stability depend on a function name or arguments not changing 
across versions.


>> If OVS starts using psample heavily and users need to troubleshoot or merely
>> observe packets as they are sampled in a more efficient way, they are likely
>> to use ebpf for that. I think making it a bit easier (as in, providing a
>> sligthly more stable tracepoint) is worth considering.
> 
> I'm not saying that it's not worth considering, I'm simply saying that
> it should be done after gathering operational experience with existing
> mechanisms. It's possible you will conclude that this tracepoint is not
> actually needed.
> 
> Also, there are some disadvantages in using tracepoints compared to
> fentry:
> 
> https://github.com/Mellanox/mlxsw/commit/e996fd583eff1c43aacb9c79e55f5add12402d7d
> https://lore.kernel.org/all/CAEf4BzbhvD_f=y3SDAiFqNvuErcnXt4fErMRSfanjYQg5=7GJg@mail.gmail.com/#t
> 
> Not saying that's the case here, but worth considering / being aware.
> 
>> Can you please expand on your concerns about the tracepoint? It's on the
>> main internal function of the module so, even though the function name or
>> its arguments might change, it doesn't seem probable that it'll disappear
>> altogether. Why else would we want to remove the tracepoint?
> 
> It's not really concerns, but dissatisfaction. It's my impression (might
> be wrong) that this series commits to adding new interfaces without
> first seriously evaluating existing ones. This is true for this patch
> and patch #2 that adds a new netlink command instead of using
> SO_ATTACH_FILTER like existing applications are doing to achieve the
> same goal.
> 
> I guess some will disagree, but wanted to voice my opinion nonetheless.
> 

That's a fair point and I appreciate the feedback.

For patch #2, I can concede that it's just making applications slightly simpler 
without providing any further stability guarantees. I'm OK removing it.

And, I fail to convince you of the usefulness of the tracepoint, I can remove it 
as well.

Thanks.


