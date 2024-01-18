Return-Path: <linux-kernel+bounces-30125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697D8319D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E91C255F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F925106;
	Thu, 18 Jan 2024 13:00:25 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE124B57;
	Thu, 18 Jan 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582824; cv=none; b=gQKSqCsSw6+QyVx5lId7pmtHMhdBxa4Q3UC5AgWVPUQA7F6vcnEsJyh8qX5WzwAQMJRKS65IfOtsJcoN92zQ9Z+BpPZl6rasTN5Z4jRu9bByK/9UIknbtmhHC5FMpiruxzokDZibqGy69NlUBH39S97W2J/6CQnGye1C147+JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582824; c=relaxed/simple;
	bh=IRMtTjgdzFC8VQtQ4Cw3iyDgsSe5SHauaHyFtAzCph4=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=LRaX02CK3op606j4ouiZl3ouu186m7rnCYw40ePRavfimgKWY8Ml4E8qpybChyNf1UlXnywpY0OHILmEwBZIit13MQ0CanUXei+1PO7zGJOnBQlZwI1lqcYNGNvvpJ5eh59S4cRtq/cgKPrPF8pqwjwsC4YklNhfB2ctSrq8n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 18 Jan
 2024 16:00:16 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 18 Jan
 2024 16:00:16 +0300
Message-ID: <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
Date: Thu, 18 Jan 2024 05:00:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in
 ieee802154_hdr_push_sechdr
To: Alexander Aring <aahringo@redhat.com>
CC: Zhang Shurong <zhang_shurong@foxmail.com>, <alex.aring@gmail.com>,
	<stefan@datenfreihafen.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<harperchen1110@gmail.com>
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru>
 <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
 <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com>
Content-Language: en-US
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hello,

On 1/17/24 17:42, Alexander Aring wrote:
> Hi,
> 
> On Sun, Jan 14, 2024 at 10:32 PM Alexander Aring <aahringo@redhat.com> wrote:
>>
>> Hi,
>>
>> On Fri, Jan 12, 2024 at 8:16 AM Nikita Zhandarovich
>> <n.zhandarovich@fintech.ru> wrote:
>>>
>>>>>>>
>>>>>>> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154=
>>>> /header_ops.c:54 [inline]
>>>>>>> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee8=
>>>> 02154/header_ops.c:108
>>>>>>>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>>>>>>>  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
>>>>>>>  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
>>>>>>>  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
>>>>>>>  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
>>>>>>>  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>>>>>>>  sock_sendmsg_nosec net/socket.c:725 [inline]
>>>>>>>  sock_sendmsg net/socket.c:748 [inline]
>>>>>>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
>>>>>>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
>>>>>>>  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
>>>>>>>  __compat_sys_sendmsg net/compat.c:346 [inline]
>>>>>>>  __do_compat_sys_sendmsg net/compat.c:353 [inline]
>>>>>>>  __se_compat_sys_sendmsg net/compat.c:350 [inline]
>>>>>>>
>>>>>>> We found hdr->key_id_mode is uninitialized in mac802154_set_header_se=
>>>> curity()
>>>>>>> which indicates hdr.fc.security_enabled should be 0. However, it is s=
>>>> et to be cb->secen before.
>>>>>>> Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains=
>>>>  uninit-value issue.
>>>>>>
>>>>>> I am not too deeply involved in the security header but for me it feels
>>>>>> like your patch does the opposite of what's needed. We should maybe
>>>>>> initialize hdr->key_id_mode based on the value in cb->secen, no? (maybe
>>>>>> Alexander will have a better understanding than I have).
>>>>>
>>>>> I can't help yet with a better answer why syzkaller reports it but it
>>>>> will break things as we using skb->cb to pass additional parameters
>>>>> through header_ops->create()... in this case it is some sockopts of
>>>>> af802154, I guess.
>>>>>
>>>>
>>>> Maybe we just need to init some "more" defaults in [0]
>>>>
>>>> - Alex
>>>>
>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
>>>> /net/ieee802154/socket.c?h=3Dv6.7-rc5#n474
>>>
>>> Hello,
>>>
>>> I was looking into the same issue (now present in syzbot [1]) and since it has a
>>> C-repro, the error is easy to recreate. Apparently, despite cb->secen (and
>>> hdr.fc.security_enabled accordingly) being equal 1, mac802154_set_header_security()
>>> finishes with 0 in:
>>>
>>>         if (!params.enabled ||
>>>             (cb->secen_override && !cb->secen) ||
>>>             !params.out_level)
>>>             return 0;
>>>
>>> Not presuming to understand the issue fully but if we do end up leaving
>>> mac802154_set_header_security() early, should we init hdr->key_id_mode
>>> with IEEE802154_SCF_KEY_IMPLICIT before returning with 0?
>>> I imagine that reseting hdr.fc.security_enabled to 0 ourselves in this
>>> case is a wrong way to go too.
>>>
>>
>> I think here are two problems:
>>
>> 1.
>> When (in any way) secen path is hit then we should make sure some
>> other security parameters are set, if not return with an error. This
>> needs to be done somewhere in the 802.15.4 socket code. [0]
>>
> 
> This would require that we init them with some invalid value defaults
> but I think because we are using bit fields, we need to change the
> whole struct to make some invalid number range available.
> I am happy to init those values to some value at [0] to at least get
> rid of the uninit value warning. We can change it so that it fails at
> send() afterwards, I think it should fail in some later path of the
> implementation that ends in a kernel log message.
> 
> - Alex
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ieee802154/socket.c#n474
> 

I was curious whether a smaller change would suffice since I might be
too green to see the full picture here.

In all honesty I am failing to see how exactly it happens that cb->secen
== 1 and cb->secen_override == 0 (which is exactly what occurs during
this error repro) at the start of mac802154_set_header_security().
Since there is a check in mac802154_set_header_security()

	if (!params.enabled && cb->secen_override && cb->secen)

maybe we take off 'cb->secen_override' part of the condition? That way
we catch the case when security is supposedly enabled without parameters
being available (not enabled) and return with error. Or is this approach
too lazy?

With regards,
Nikita


