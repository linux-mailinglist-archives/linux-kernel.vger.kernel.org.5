Return-Path: <linux-kernel+bounces-159371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B28B2DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D061F224A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D88156C7C;
	Thu, 25 Apr 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kVSiM8dT"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770B15533B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714089052; cv=none; b=LBpjqq/IA9lprdc9EUjuD/EltIKCUIeGZfN8SCKkG8bOrbOLwF/i4r4dK1W0i0GdtkaW5pQ/dnVWSWeFEEDCRPP2Nqoa/q/AK/Kq8W/gdN8BzcMriyV6L0WWXJ6a2fqbOmZq8p08NQesTonNW2N+wFxsFk+Ful7Pm5SObu8J7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714089052; c=relaxed/simple;
	bh=OS6pp0gMWtmBK9RLfOvHFjAv8kO/PRmUpAyYohUkgUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZnyw8P4/OMFs4vR7oiTWPn0E6m0y45nTc4Gi3tEuQ4178R4kvNCE+UjctpNyjZFo4UmGlNpbp0oZOuXNWiQKLdfPTWiFuPxKnJ2n1c/Ruy+zs2jPqnDc0dN0iVeRqvxZJscH1SVO+lZvjUtSw8+TZJOV8aOyb3C5t+lpBuIRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kVSiM8dT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cebfd92-7ad0-496a-9f31-f4c696fb5cb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714089049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9GImcDZJ1T3zd/p2AjMxBvWvdh595wzGLC3mDjc/3w=;
	b=kVSiM8dTzBoY4x/UZrCB3I6uzU4vkL/NPT8OcWzedjF2FGFGfB7M2ey1Y58wxfqy+ydDul
	2p16+ghDU3MlG6+M7+owRn8ajp8F81P/GbdZV/IMSK7080yg9D+H4DpH2C1CnWAqvHy3Bp
	p9sj5JKmvRYJEitTyCvWQ5Sgaaa9an4=
Date: Thu, 25 Apr 2024 16:50:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v5 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-2-quic_abchauha@quicinc.com>
 <662a69475869_1de39b29415@willemb.c.googlers.com.notmuch>
 <a84d314a-fca4-4317-9d33-0c7d3213c612@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a84d314a-fca4-4317-9d33-0c7d3213c612@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/25/24 12:02 PM, Abhishek Chauhan (ABC) wrote:
>>>> @@ -9444,7 +9444,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>   					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>>   		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>>   					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>> -		/* skb->tc_at_ingress && skb->mono_delivery_time,
>>> +		/* skb->tc_at_ingress && skb->tstamp_type:1,
>> Is the :1 a stale comment after we discussed how to handle the 2-bit
> This is first patch which does not add tstamp_type:2 at the moment.
> This series is divided into two patches
> 1. One patchset => Just rename (So the comment is still skb->tstamp_type:1)
> 2. Second patchset => add another bit (comment is changed to skb->tstamp_type:2)

I would suggest to completely avoid the ":1" or ":2" part in patch 1. Just use 
"... && skb->tstamp_type". The number of bits does not matter. The tstamp_type 
will still be considered as a whole even if it would become 3 bits (unlikely) in 
the future.

