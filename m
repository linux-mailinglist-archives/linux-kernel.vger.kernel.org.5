Return-Path: <linux-kernel+bounces-58672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D284E9CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0971F2D1D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF14B5A7;
	Thu,  8 Feb 2024 20:44:17 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726148794;
	Thu,  8 Feb 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425056; cv=none; b=o2Xrsw2rSsT/e+rRMuz7idR7I4xDVKHp/CoTuVhfWY+i7oeetpJFZ7ahZzK1It5MBFyA3TB6EWrtqNI/WSp/NrXWe8YY6mUeMTtoDmoKOaseofHKF7PARSJX1G6OTF8e/GcE+ci0bkUoVcnO153jYZ5iUTXvbh2VX/ZPMcvtaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425056; c=relaxed/simple;
	bh=0xnupxFj9c0DgQKxN89wXQQQe9ADhY3zOQTEun0xfX4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c+QAmHSrFIBYVupHGY+lHTncNH3JQxHEQ9pn6ZZ8HCWrwa2sU+A+PQ4eW/HsI/13CgrT+IflJUlJ46oE/HsBCKDoq7xfC6Mbd4dB/MX1eF6dOBa8dATwKDvoagLRKiHAQ+5Lp64UoN7gkEcW39dlN7GR+XamgyIpknPyy0f0Aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.49) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 8 Feb
 2024 23:43:58 +0300
Subject: Re: [PATCH net-next 1/5] net: ravb: Get rid of the temporary variable
 irq
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-2-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c284aab3-faf0-969c-7256-5bc72afe7e3e@omp.ru>
Date: Thu, 8 Feb 2024 23:43:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207120733.1746920-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/08/2024 20:24:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183308 [Feb 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.49 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.49 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.49
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/08/2024 20:30:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/8/2024 4:38:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/7/24 3:07 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The 4th argument of ravb_setup_irq() is used to save the IRQ number that
> will be further used by the driver code. Not all ravb_setup_irqs() calls
> need to save the IRQ number. The previous code used to pass a dummy
> variable as the 4th argument in case the IRQ is not needed for further
> usage. That is not necessary as the code from ravb_setup_irq() can detect
> by itself if the IRQ needs to be saved. Thus, get rid of the code that is
> not needed.
> 
> Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 9521cd054274..e235342e0827 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2611,17 +2611,20 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
>  		if (!dev_name)
>  			return -ENOMEM;
>  
> -		*irq = platform_get_irq_byname(pdev, irq_name);
> +		error = platform_get_irq_byname(pdev, irq_name);
>  		flags = 0;
>  	} else {
>  		dev_name = ndev->name;
> -		*irq = platform_get_irq(pdev, 0);
> +		error = platform_get_irq(pdev, 0);
>  		flags = IRQF_SHARED;
>  	}
> -	if (*irq < 0)
> -		return *irq;
> +	if (error < 0)
> +		return error;
>  
> -	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
> +	if (irq)
> +		*irq = error;
> +
> +	error = devm_request_irq(dev, error, handler, flags, dev_name, ndev);
>  	if (error)
>  		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
>  

   Thanks for addressing my IRC comment! Tho the naming seems awful. :-)
   I'd suggest to add a local variable (named e.g, irq_num) and use it to
store the result of platform_get_irq[_byname]().

[...]

MBR, Sergey

