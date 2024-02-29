Return-Path: <linux-kernel+bounces-86397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0C86C4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B051C219FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5625A7A6;
	Thu, 29 Feb 2024 09:20:25 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAE5A4D4;
	Thu, 29 Feb 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198425; cv=none; b=fvz7QMCerVq6grc+X6NISrKnzjePQjh5i3fe/o51/50MEwqQ0EGuX6eTDcF2KXzVRTJ3ggDbfMW9x9cMrd0WUBVUpGOM3NsBC7MjsCM6eDR/qt7hwWEueh3KbY5XyF5FQqFyrjgkycnDCAielkgA6LjYbRyLf3ymPTT6/0BQtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198425; c=relaxed/simple;
	bh=4F/X5Z6QsULNfoSYXx+VhyVs0V627xYO/1kLOHJm/zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=buCX5YUqJZCIEUy109cdNxk+vF5wFqHllAvu5DEmFGRBGCqM13Gxz0Smc8F2g34MlYS89m2sPtmsV4GaTeb27cvzlIK/XTPPTx28nITGD14VIbSotbDH0KyMrBy7xpZP05P5Goxae/Byjj8WwX6oJUvRwr0HU8vTLauBKF88mXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id AF09C2F2025F; Thu, 29 Feb 2024 09:20:20 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id A8BA72F20251;
	Thu, 29 Feb 2024 09:20:18 +0000 (UTC)
Message-ID: <077c8417-03bf-8d61-5d3a-0aef91b55659@basealt.ru>
Date: Thu, 29 Feb 2024 12:20:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] gtp: fix use-after-free and null-ptr-deref in
 gtp_newlink()
Content-Language: en-US
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240228114703.465107-1-oficerovas@altlinux.org>
 <Zd_HAGqXSE6Nwcag@calendula>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <Zd_HAGqXSE6Nwcag@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

29.02.2024 02:51, Pablo Neira Ayuso wrote:
> On Wed, Feb 28, 2024 at 02:47:03PM +0300, Alexander Ofitserov wrote:
>> The gtp_link_ops operations structure for the subsystem must be
>> registered after registering the gtp_net_ops pernet operations structure.
> 
> A fix for this was already applied, see:
> 
> commit 136cfaca22567a03bbb3bf53a43d8cb5748b80ec
> Author: Vasiliy Kovalev <kovalev@altlinux.org>
> Date:   Wed Feb 14 19:27:33 2024 +0300
> 
>      gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
> 
>> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
>> index 2129ae42c7030..0ddec4cc84093 100644
>> --- a/drivers/net/gtp.c
>> +++ b/drivers/net/gtp.c
>> @@ -1903,26 +1903,26 @@ static int __init gtp_init(void)
>>   
>>   	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
>>   
>> -	err = rtnl_link_register(&gtp_link_ops);
>> +	err = register_pernet_subsys(&gtp_net_ops);
>>   	if (err < 0)
>>   		goto error_out;
> 
> BTW, I like that this calls register_pernet_subsys() before
> rtnl_link_register(), where a rtnetlink request could come before
> pernet is set up.
> 
>> -	err = register_pernet_subsys(&gtp_net_ops);
>> +	err = rtnl_link_register(&gtp_link_ops);
>>   	if (err < 0)
>> -		goto unreg_rtnl_link;
>> +		goto unreg_pernet_subsys;
>>   
>>   	err = genl_register_family(&gtp_genl_family);
>>   	if (err < 0)
>> -		goto unreg_pernet_subsys;
>> +		goto unreg_rtnl_link;
>>   
>>   	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
>>   		sizeof(struct pdp_ctx));
>>   	return 0;
>>   
>> -unreg_pernet_subsys:
>> -	unregister_pernet_subsys(&gtp_net_ops);
>>   unreg_rtnl_link:
>>   	rtnl_link_unregister(&gtp_link_ops);
>> +unreg_pernet_subsys:
>> +	unregister_pernet_subsys(&gtp_net_ops);
>>   error_out:
>>   	pr_err("error loading GTP module loaded\n");
>>   	return err;
>> -- 
>> 2.42.1
>>
>>

This patch fixes another problem, but a similar one, since the sequence 
is incorrect when registering subsystems.

Initially, the registration sequence in the gtp module was as follows:

1) rtnl_link_register();

2) genl_register_family();

3) register_pernet_subsys();

During debugging of the module, when starting the syzkaller reproducer, 
it turned out that after genl_register_family() (2),

without waiting for register_pernet_subsys()(3), the .dumpit  event is 
triggered, in which the data of the unregistered pernet subsystem is 
accessed.

That is, the bug was fixed by the commit

136cfaca2256 ("gtp: fix use-after-free and null-ptr-deref in 
gtp_genl_dump_pdp()") [1]

and the registration sequence became as follows:

1) rtnl_link_register();

2) register_pernet_subsys();

3) genl_register_family();

However, syzkaller has discovered another problem:

after registering rtnl_link_register, the .newlink event is triggered, 
in which the data of the unregistered pernet subsystem is accessed.

This problem is reproducible on current stable kernels and the latest 
upstream kernel 6.8-rc6, in which the patch 136cfaca2256 [1] is applied.

Therefore, the correct sequence should be as follows:

1) register_pernet_subsys();

2) rtnl_link_register();

3) genl_register_family();

The proposed patch is developed on top of the commit changes [1], does 
not conflict with it and fixes the described bug.

[1] 
https://lore.kernel.org/lkml/20240220160434.29bcaf43@kernel.org/T/#mb1f72c2ad57b7ea6d47333e8616beccf8bce0e23

-- 
Regards,
Vasiliy Kovalev

