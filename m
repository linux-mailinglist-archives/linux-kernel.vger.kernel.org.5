Return-Path: <linux-kernel+bounces-98038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6C8773F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425C5281BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2850243;
	Sat,  9 Mar 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgdnfULV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F820B22;
	Sat,  9 Mar 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017772; cv=none; b=NteMNwpw6kLUOjML1GPxyf/lfG8OsmkBAv1+ScqvQ3OAf/r2RQRJujJTc9urqSn77yMlTlF9NF+i9SEd6haZkJjiStr+lAbmB6zBMXHIOOdiFT7n/Ni/f06NNNMHwTZhpG90d5gIggoJoIYRWVU04iJRa9IadsYW6pGNa50FKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017772; c=relaxed/simple;
	bh=Ge91vCXg12ja9uivjnl8xwkuCY8wS7ldRFzB9lJWMrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2m+iDGC6mczWjzERLoLDrWk2gBX323gbrm8iqIMA4790gL6PSpAu/Wg01cRTOxlyaN/EEY4cpo4wrnoCX/x5vi0WcAo51w/wy23D3+gKyeRS+GRKyewoaHaQomXe9lzSPozwfNe40ih4TTNScbLe/mSW+wMy7jBgATLo2hp5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgdnfULV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07364C433F1;
	Sat,  9 Mar 2024 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710017771;
	bh=Ge91vCXg12ja9uivjnl8xwkuCY8wS7ldRFzB9lJWMrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dgdnfULVyGoT895Kfcmba2oOsvElcvvqQq+o1bOw6wZNV1B8VNPwT3K4nNjc5WBPE
	 DBb8LQ/6i/2k7ppcE1uhp6sVvVHXIILelpBbVno+rYv2qMnuqVOgBCx//Ja0As8YTX
	 uCV52rfcIM/Fk0THtk/D+CxK6gNyab7UPBVMrmQohkeeGBAhvT1dkTwlznmXNG9H9n
	 xeoGkDJJ6U973XOXTtiljEled/qLu3QGtSY3IzRuAaF0/1hHPuUjMlZjDbJ0nRTwbn
	 u+7SPhpdbcjaW+B2qbUjSLtxdQCC/6D0y84+12FzVwj2OW6/X4LfMixrmF3+mFTXr2
	 j7YQa6Pfc1W8w==
Message-ID: <0b17a2f1-76aa-488f-a94a-b9d07f0459f9@kernel.org>
Date: Sat, 9 Mar 2024 13:56:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] kernel BUG in __nla_validate_parse
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>,
 Petr Machata <petrm@nvidia.com>, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <00000000000088981b06133bc07b@google.com>
 <CANn89iKLAOJ+HG_y7M27-tx+9HSLUyDaf_NtrJMjs2bZ52KZbA@mail.gmail.com>
 <20240309104054.5f058be3@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240309104054.5f058be3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/9/24 11:40 AM, Jakub Kicinski wrote:
> On Sat, 9 Mar 2024 16:25:18 +0100 Eric Dumazet wrote:
>> On Sat, Mar 9, 2024 at 4:13 PM syzbot
>>> ..
>> Petr, can you take a look ?
>>
>> Thanks !
>>
>>
>> commit 2118f9390d83cf942de8b34faf3d35b54f9f4eee
>> Author: Petr Machata <petrm@nvidia.com>
>> Date:   Wed Mar 6 13:49:15 2024 +0100
>>
>>     net: nexthop: Adjust netlink policy parsing for a new attribute
> 
> Yeah
> 
> +static const struct nla_policy rtm_nh_policy_del[] = {
> +       [NHA_ID]                = { .type = NLA_U32 },
> +};
> 
> +       err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
> +                         rtm_nh_policy_del, extack);
> 
> The policy size must be >= max_attr (NHA_MAX).

ARRAY_SIZE is sufficient for both tb and parse. That is what the rest of
the file uses.

