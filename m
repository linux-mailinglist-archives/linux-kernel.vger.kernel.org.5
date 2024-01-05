Return-Path: <linux-kernel+bounces-18308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D431825B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E69285AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6063608B;
	Fri,  5 Jan 2024 19:52:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71C35F00;
	Fri,  5 Jan 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.81.170) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jan
 2024 22:52:21 +0300
Subject: Re: [PATCH net-next v3 07/19] net: ravb: Move reference clock
 enable/disable on runtime PM APIs
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-8-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <80b7337b-5fc2-07bc-a05f-b583ccaac3da@omp.ru>
Date: Fri, 5 Jan 2024 22:52:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105082339.1468817-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/05/2024 19:40:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182465 [Jan 05 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.170 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.170 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;31.173.81.170:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.170
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/05/2024 19:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/5/2024 3:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 11:23 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reference clock could be or not part of the power domain. If it is part of
> the power domain, the power domain takes care of propertly setting it. In
> case it is not part of the power domain and full runtime PM support is
> available in driver the clock will not be propertly disabled/enabled at
> runtime. For this, keep the prepare/unprepare operations in the driver's
> probe()/remove() functions and move the enable/disable in runtime PM
> functions.
> 
> Along with it, the other clock request operations were moved close to
> reference clock request and prepare to have all the clock requests
> specific code grouped together.
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   It's not that I reviewed the squashed version of this patch...

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - squashed with patch 17/21 ("net: ravb: Keep clock request operations grouped
>   together") from v2
> - collected tags
> 
> Changes in v2:
> - this patch is new and follows the recommendations proposed in the
>   discussion of patch 08/13 ("net: ravb: Rely on PM domain to enable refclk")
>   from v2
> 
>  drivers/net/ethernet/renesas/ravb_main.c | 110 ++++++++++++-----------
>  1 file changed, 57 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 844ac3306e93..4673cc2faec0 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -2697,10 +2692,37 @@ static int ravb_probe(struct platform_device *pdev)
>  		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
>  	}
>  
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		error = PTR_ERR(priv->clk);
> +		goto out_reset_assert;
> +	}
> +
> +	if (info->gptp_ref_clk) {
> +		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
> +		if (IS_ERR(priv->gptp_clk)) {
> +			error = PTR_ERR(priv->gptp_clk);
> +			goto out_reset_assert;
> +		}
> +	}
> +
> +	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
> +	if (IS_ERR(priv->refclk)) {
> +		error = PTR_ERR(priv->refclk);
> +		goto out_reset_assert;
> +	}
> +	clk_prepare(priv->refclk);
> +
> +	platform_set_drvdata(pdev, ndev);

   Why exactly you had to move this line?

> +	pm_runtime_enable(&pdev->dev);
> +	error = pm_runtime_resume_and_get(&pdev->dev);
> +	if (error < 0)
> +		goto out_rpm_disable;
> +
>  	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(priv->addr)) {
>  		error = PTR_ERR(priv->addr);
> -		goto out_release;
> +		goto out_rpm_put;
>  	}
>  
>  	/* The Ether-specific entries in the device structure. */
[...]
> @@ -2871,8 +2872,6 @@ static int ravb_probe(struct platform_device *pdev)
>  	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
>  		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
>  
> -	platform_set_drvdata(pdev, ndev);

   Hm, wasn't calling it here racy?

> -
>  	return 0;
>  
>  out_napi_del:
[...]
> @@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static int ravb_runtime_nop(struct device *dev)
> +static int ravb_runtime_suspend(struct device *dev)
>  {
> -	/* Runtime PM callback shared between ->runtime_suspend()
> -	 * and ->runtime_resume(). Simply returns success.
> -	 *
> -	 * This driver re-initializes all registers after
> -	 * pm_runtime_get_sync() anyway so there is no need
> -	 * to save and restore registers here.
> -	 */

   Perhaps even worth a separate patch to completely remove this function
which doesn't seem to make sense?

[...]

MBR, Sergey

