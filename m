Return-Path: <linux-kernel+bounces-59898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7084FD14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22141F2385C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560384A55;
	Fri,  9 Feb 2024 19:43:27 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051694174A;
	Fri,  9 Feb 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507807; cv=none; b=I45tdj98Zbv2U44A8dMGGKM+71OkH9J1FIbSzrMb+aAH5vSEpDnXz6Y5KfKC3BIzaVnvYAM83HYPOIvfHxPI2oHoffWANjGy1B3xBIX2xM80yXFEfL9plfR5Po1v4LPfK8mvttx71TYs5Vh8K8+tSa6sHN/cgSfZedLo3JrU4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507807; c=relaxed/simple;
	bh=IqNbKB16b5Fmo2Rw2QQSGSIYN2RBEGdrNWQ+l0bGlfQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GRXdacqvLWyhnoztqPkhbG7ADZtrZzc3PN86ddovqtQ0oihKIu/TfwbmgIgzP4T9LMiT5uticGs4AfKTiEKKqJUI5IV/jjMD4UFdiU4AMD9aijgihZyvmbqvmhQk4L4gTN7xHUyWRFJ8OCuegDJt6iS/fA4QU/lE5mj5zTOxU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.169) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 9 Feb
 2024 22:43:16 +0300
Subject: Re: [PATCH net-next 1/5] net: ravb: Get rid of the temporary variable
 irq
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-2-claudiu.beznea.uj@bp.renesas.com>
 <c284aab3-faf0-969c-7256-5bc72afe7e3e@omp.ru>
 <13956279-3ab1-4eb8-b361-a0c79135cb56@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <38ed2c42-4077-7ee2-5cd0-9d38e217c944@omp.ru>
Date: Fri, 9 Feb 2024 22:43:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <13956279-3ab1-4eb8-b361-a0c79135cb56@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/09/2024 19:07:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183341 [Feb 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.169
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/09/2024 19:19:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/9/2024 5:01:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/9/24 8:48 AM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The 4th argument of ravb_setup_irq() is used to save the IRQ number that
>>> will be further used by the driver code. Not all ravb_setup_irqs() calls
>>> need to save the IRQ number. The previous code used to pass a dummy
>>> variable as the 4th argument in case the IRQ is not needed for further
>>> usage. That is not necessary as the code from ravb_setup_irq() can detect
>>> by itself if the IRQ needs to be saved. Thus, get rid of the code that is
>>> not needed.
>>>
>>> Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> [...]
>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 9521cd054274..e235342e0827 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -2611,17 +2611,20 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
>>>  		if (!dev_name)
>>>  			return -ENOMEM;
>>>  
>>> -		*irq = platform_get_irq_byname(pdev, irq_name);
>>> +		error = platform_get_irq_byname(pdev, irq_name);
>>>  		flags = 0;
>>>  	} else {
>>>  		dev_name = ndev->name;
>>> -		*irq = platform_get_irq(pdev, 0);
>>> +		error = platform_get_irq(pdev, 0);
>>>  		flags = IRQF_SHARED;
>>>  	}
>>> -	if (*irq < 0)
>>> -		return *irq;
>>> +	if (error < 0)
>>> +		return error;
>>>  
>>> -	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
>>> +	if (irq)
>>> +		*irq = error;
>>> +
>>> +	error = devm_request_irq(dev, error, handler, flags, dev_name, ndev);
>>>  	if (error)
>>>  		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
>>>  
>>
>>    Thanks for addressing my IRC comment! Tho the naming seems awful. :-)

	if (error < 0)
		return error;
 
	if (irq)
		*irq = error;

	error = devm_request_irq(dev, error, handler, flags, dev_name, ndev);

   These just don't look right...

>>    I'd suggest to add a local variable (named e.g, irq_num) and use it to
> 
> I tried to avoid that...

   Why? :-)

>> store the result of platform_get_irq[_byname]().
>>
>> [...]

MBR, Sergey

