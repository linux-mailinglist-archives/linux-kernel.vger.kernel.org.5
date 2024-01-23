Return-Path: <linux-kernel+bounces-36005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B862B8399FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD71F237FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B182D98;
	Tue, 23 Jan 2024 20:07:19 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A48823AF;
	Tue, 23 Jan 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040438; cv=none; b=kFHtrSMy9dbwGCYggcNXiJu+GQTRULSZ2e/sCi9wUDE8EmIbsffly2UH6qka24i1q+aixWJBtRhyK0jrYfzyW+jp51GPC7sZw+JKYGWxaImh+cFhd6RDHe3GRb2BqLlu9ZVPDX1TiZVSMvRR2A4a1DpRIvRA4EXNOnFe7c2dFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040438; c=relaxed/simple;
	bh=KhzYZEpq/SwWKNc90K35ycdH0fzUhA7Rf9ol9UpQrQU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BQlssHUBrmrgNbyUW6yC3OT7rPj2KeYvz+a8KBgePtEAYBfrx33/ZiMbjeokvMiyd+r+oAnvtS7OWJNvRvTxRbkYoaCFKb+dIdJeJL2Lg0LQAun4gv2UslbLtx7lVQ+M88+LtiPLB45GGwpkpFvx5YanUBggYCHn0DTQZ1rmgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.84.3) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 23 Jan
 2024 23:06:57 +0300
Subject: Re: [PATCH net-next v3 07/19] net: ravb: Move reference clock
 enable/disable on runtime PM APIs
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-8-claudiu.beznea.uj@bp.renesas.com>
 <80b7337b-5fc2-07bc-a05f-b583ccaac3da@omp.ru>
 <488abcaa-6f1c-4524-8cd4-375caa5bdf42@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a836b47d-55a3-4a06-93c8-5af75f1f00f6@omp.ru>
Date: Tue, 23 Jan 2024 23:06:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <488abcaa-6f1c-4524-8cd4-375caa5bdf42@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/23/2024 19:55:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182874 [Jan 23 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.3 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;elixir.bootlin.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.3
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2024 19:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/23/2024 5:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/8/24 11:03 AM, claudiu beznea wrote:

   Oops, looks like I forgot to reply to this one...

[...]
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Reference clock could be or not part of the power domain. If it is part of
>>> the power domain, the power domain takes care of propertly setting it. In
>>> case it is not part of the power domain and full runtime PM support is
>>> available in driver the clock will not be propertly disabled/enabled at
>>> runtime. For this, keep the prepare/unprepare operations in the driver's
>>> probe()/remove() functions and move the enable/disable in runtime PM
>>> functions.
>>>
>>> Along with it, the other clock request operations were moved close to
>>> reference clock request and prepare to have all the clock requests
>>> specific code grouped together.
>>>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 844ac3306e93..4673cc2faec0 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	error = pm_runtime_resume_and_get(&pdev->dev);
>>> +	if (error < 0)
>>> +		goto out_rpm_disable;
>>> +
>>>  	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>>  	if (IS_ERR(priv->addr)) {
>>>  		error = PTR_ERR(priv->addr);
>>> -		goto out_release;
>>> +		goto out_rpm_put;
>>>  	}
>>>  
>>>  	/* The Ether-specific entries in the device structure. */
[...]
>>> @@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
>>>  	return ret;
>>>  }
>>>  
>>> -static int ravb_runtime_nop(struct device *dev)
>>> +static int ravb_runtime_suspend(struct device *dev)
>>>  {
>>> -	/* Runtime PM callback shared between ->runtime_suspend()
>>> -	 * and ->runtime_resume(). Simply returns success.
>>> -	 *
>>> -	 * This driver re-initializes all registers after
>>> -	 * pm_runtime_get_sync() anyway so there is no need
>>> -	 * to save and restore registers here.
>>> -	 */
>>
>>    Perhaps even worth a separate patch to completely remove this function
>> which doesn't seem to make sense?
> 
> Why? With that the refclk will not be properly enabled/disabled when it
> will not be part of the power domain. Take

   That's what you are adding in this patch, right? Before this patch
this was ravb_runtime_nop(), always returning 0. Did it make any sense?

> https://elixir.bootlin.com/linux/v6.7/source/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi#L57
> as an example. Here refclk is from an external source (not part of power
> domain).
> 
> Thank you,
> Claudiu Beznea

[...]

MBR, Sergey

