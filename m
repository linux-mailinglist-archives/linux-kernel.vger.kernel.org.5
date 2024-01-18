Return-Path: <linux-kernel+bounces-30128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A88319EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A21F24584
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48FC25102;
	Thu, 18 Jan 2024 13:04:38 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352324B55;
	Thu, 18 Jan 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583078; cv=none; b=M3qscZSFvajs+8/Y/TdVpn1/cJeAD2HpHf3PH0kk9ioJ2IUbR1pXafjqORHiqvQLvJDZ3FL49oeMg0jNIobDXSyOUsXKADnK+qQ7qCWWOmYmsuBnlzuCt14NdidQK/EUGvxIAH+SO2junKV9MGHQkbfeY+5Wl85yFopIKxiM8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583078; c=relaxed/simple;
	bh=A2u/In+Ely0o9qIZsqtSMjnx7pYwOa9eMaospITnmZ8=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=HFeQ3zAhpHfpzPF/xfKt1FWcWtPfGIv8LLARXVs0++M4wNLZHUGInDfIgHyCYzVYys4wS2JRUG0sCeyK4BDke3R43WVgsiEoBRdwr+l+6dJBQ9HWBWFoUqrqwtAKPa8zysT4N89rg2KVA3d7hm49+E7n0AFbQ3CZBSpLok2hGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 18 Jan
 2024 16:04:31 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 18 Jan
 2024 16:04:31 +0300
Message-ID: <549c658e-28a0-4e6c-be09-95ba748410b7@fintech.ru>
Date: Thu, 18 Jan 2024 05:04:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down /
 mld_ifc_work
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo
	<ap420073@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com>
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
 <CANn89iLUxP_YGLD1mrCmAr9qSg7wPWDjWPhJHNa_X4QVyNWqBQ@mail.gmail.com>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <CANn89iLUxP_YGLD1mrCmAr9qSg7wPWDjWPhJHNa_X4QVyNWqBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hello,

On 1/18/24 00:59, Eric Dumazet wrote:
> On Wed, Jan 17, 2024 at 6:21 PM Nikita Zhandarovich
> <n.zhandarovich@fintech.ru> wrote:
>>
>> idev->mc_ifc_count can be written over without proper locking.
>>
>> Originally found by syzbot [1], fix this issue by encapsulating calls
>> to mld_ifc_stop_work() (and mld_gq_stop_work() for good measure) with
>> mutex_lock() and mutex_unlock() accordingly as these functions
>> should only be called with mc_lock per their declarations.
>>
>> [1]
>> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
>>
>> Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
>> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/all/000000000000994e09060ebcdffb@google.com/
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>  net/ipv6/mcast.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
>> index b75d3c9d41bb..bc6e0a0bad3c 100644
>> --- a/net/ipv6/mcast.c
>> +++ b/net/ipv6/mcast.c
>> @@ -2722,8 +2722,12 @@ void ipv6_mc_down(struct inet6_dev *idev)
>>         synchronize_net();
>>         mld_query_stop_work(idev);
>>         mld_report_stop_work(idev);
>> +
>> +       mutex_lock(&idev->mc_lock);
>>         mld_ifc_stop_work(idev);
>>         mld_gq_stop_work(idev);
>> +       mutex_unlock(&idev->mc_lock);
>> +
>>         mld_dad_stop_work(idev);
>>  }
>>
> 
> Thanks for the fix.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> I would also add some lockdep_assert_held() to make sure assumptions are met.
> Trading a comment for a runtime check is better.
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index b75d3c9d41bb5005af2d4e10fab58f157e9ea4fa..b256362d3b5d5111f649ebfee4f1557d8c063d92
> 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -1047,36 +1047,36 @@ bool ipv6_chk_mcast_addr(struct net_device
> *dev, const struct in6_addr *group,
>         return rv;
>  }
> 
> -/* called with mc_lock */
>  static void mld_gq_start_work(struct inet6_dev *idev)
>  {
>         unsigned long tv = get_random_u32_below(idev->mc_maxdelay);
> 
> +       lockdep_assert_held(&idev->mc_lock);
>         idev->mc_gq_running = 1;
>         if (!mod_delayed_work(mld_wq, &idev->mc_gq_work, tv + 2))
>                 in6_dev_hold(idev);
>  }
> 
> -/* called with mc_lock */
>  static void mld_gq_stop_work(struct inet6_dev *idev)
>  {
> +       lockdep_assert_held(&idev->mc_lock);
>         idev->mc_gq_running = 0;
>         if (cancel_delayed_work(&idev->mc_gq_work))
>                 __in6_dev_put(idev);
>  }
> 
> -/* called with mc_lock */
>  static void mld_ifc_start_work(struct inet6_dev *idev, unsigned long delay)
>  {
>         unsigned long tv = get_random_u32_below(delay);
> 
> +       lockdep_assert_held(&idev->mc_lock);
>         if (!mod_delayed_work(mld_wq, &idev->mc_ifc_work, tv + 2))
>                 in6_dev_hold(idev);
>  }
> 
> -/* called with mc_lock */
>  static void mld_ifc_stop_work(struct inet6_dev *idev)
>  {
> +       lockdep_assert_held(&idev->mc_lock);
>         idev->mc_ifc_count = 0;
>         if (cancel_delayed_work(&idev->mc_ifc_work))
>                 __in6_dev_put(idev);

Just to clarify: should I incorporate your change into v2 version of my
original one and attach 'Reviewed-by' tags or should I send a different
patch with your suggestion?

Apologies for the possibly silly question, got a little confused by
signals from multiple maintainers.

With regards,
Nikita

