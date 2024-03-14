Return-Path: <linux-kernel+bounces-103813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797D87C4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74C3B22192
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2F76900;
	Thu, 14 Mar 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BzvnEIZg"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9721376412
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452948; cv=none; b=Lf6aSwt0Wvj8GuMWqgRqFaV2Sa8w6zsR0PJekItp3Pt5BnuyPecb4rq6DmkxP81QWZ+dnVvzmfn0RJkZOMra7Qc17DaX2KCZvCOttRBHxy+XH8EP7syGblYLpSMbJgg8g4OOEFk1DIzfkCSqd+cSc9iM3a6zKf1jB1bQCjwQDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452948; c=relaxed/simple;
	bh=FeBtDwOwx7bWu5qqepAggjxF5zHLaj9k63HtMHOYRCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3qcXEP3Ma4u2yOf8pufUyityO21zh6f4HYr3No4u3gHjP14RdNyxoSr6HGqmCStql4asOky/V6iYnyFbTA9IC0nbOGMOVprdAK0q2sG5nB1fXWygJR6My/elLIG/JTkQ/Pcex3PUdKmLuwZ1ispRTtquzD6ywH4INMlFWQBKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BzvnEIZg; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710452944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiN7/QrqzPkJR7UExDk5VS/K0g1YOEpPfbnDYYLfHKA=;
	b=BzvnEIZguvRsFkfCMDSsqBRA0YDLTewPY+PyvE54orrRY00M8cT+U55PL+AIx5KowPs0Zi
	PyblWOHzvDbfeLcaGRyHiqxCT/8AF4WvCkDUufefzIHP466E85+N7i3IVlPQHygwlaW1MD
	uMZfBzmTV/FSHjTOodeLuBMkonw/c94=
Date: Thu, 14 Mar 2024 14:48:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kernel@quicinc.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
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
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
 <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
 <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/14/24 1:53 PM, Abhishek Chauhan (ABC) wrote:
>>> The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be
>>> changed to handle the new "user_delivery_time" bit anyway, e.g.
>>> bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the
>>> "user_delivery_time" bit.
>>>
>>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time"
>>> field. "mono_delivery_time" is already in there.

[ ... ]

I would think the first step is to revert this patch. I don't think much of the 
current patch can be reused.

> 1. I will raise one patch to introduce rename mono_delivery_time to
> tstamp_type

Right, I expect something like this:

struct sk_buff {
		/* ... */
-	        __u8                    mono_delivery_time:1;
+		__u8			tstamp_type:1;
		/* ... */
};

> 2. I will introduce setting of userspace timestamp type as the second bit
> whem transmit_time is set.

I expect the second patch should be introducing the enum first

enum skb_tstamp_type {
	SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
	SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */
};

and start doing "skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;" instead of
"skb->tstamp_type = 1;"

and the same for "skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;" instead of
"skb->tstamp_type = 0;"


This one I am not sure but probably need to change the skb_set_delivery_time() 
function signature also:

static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
-                                        bool mono)
+					 enum skb_tstamp_type tstamp_type)

The third patch is to change tstamp_type from 1 bit to 2 bits and add 
SKB_TSTAMP_TYPE_TX_USER.

struct sk_buff {
		/* ... */
-		__u8			tstamp_type:1;
+		__u8			tstamp_type:2;
		/* ... */
};

enum skb_tstamp_type {
	SKB_TSTAMP_TYPE_RX_REAL = 0,	/* A RX (receive) time in real */
	SKB_TSTAMP_TYPE_TX_MONO = 1,	/* A TX (delivery) time in mono */
+	SKB_TSTAMP_TYPE_TX_USER = 2,	/* A TX (delivery) time and its clock
					 * is in skb->sk->sk_clockid.
					 */
				
};

This will shift a bit out of the byte where tstamp_type lives. It should be the 
"inner_protocol_type" bit by my hand count. Please check if it is directly used 
in bpf instruction (filter.c). As far as I look, it is not, so should be fine. 
Some details about bpf instruction accessible skb bit field here: 
https://lore.kernel.org/all/20230321014115.997841-1-kuba@kernel.org/


> 3. This will be a first step to make the design scalable.
> 4. Tomorrow if we have more timestamp to support, upstream community has to do is
> update the enum and increase the bitfield from 2=>3 and so on.
> 
> I need help from Martin to test the patch which renames the mono_delivery_time
> to tstamp_type (Which i feel should be straight forward as the value of the bit is 1)

The bpf change is not a no-op rename of mono_delivery_time. It needs to take 
care of the new bit added to the tstamp_type. Please see the previous email (and 
I also left it in the beginning of this email).

Thus, you need to compile the selftests/bpf/ and run it to verify the changes 
when handling the new bit. The Documentation/bpf/bpf_devel_QA.rst has the howto 
details. You probably only need the newer llvm (newer gcc should work also as 
bpf CI has been using it) and the newer pahole. I can definitely help if there 
is issue in running the test_progs in selftests/bpf or you have question on 
making the changes in filter.c. To run the test: "./test_progs -t 
tc_redirect/tc_redirect_dtime"


