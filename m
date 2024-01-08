Return-Path: <linux-kernel+bounces-20041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D282788E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC14A1F23F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E84645C;
	Mon,  8 Jan 2024 19:28:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9745BEF;
	Mon,  8 Jan 2024 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.87.204) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Jan
 2024 22:28:09 +0300
Subject: Re: [PATCH net-next v3 13/19] net: ravb: Set config mode in ndo_open
 and reset mode in ndo_close
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-14-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <feb1c87e-a84d-4e61-3e58-f61d5402170d@omp.ru>
Date: Mon, 8 Jan 2024 22:28:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105082339.1468817-14-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/08/2024 19:15:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182481 [Jan 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.204 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.204 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	31.173.87.204:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.204
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/08/2024 19:19:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/8/2024 5:12:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 11:23 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> As some IP variants switch to reset mode (and thus registers content is
> lost) when setting clocks (due to module standby functionality) to be able
> to implement runtime PM and save more power, set the IP's operating mode to
> reset at the end of the probe. Along with it, in the ndo_open API the IP
> will be switched to configuration, then operation mode. In the ndo_close
> API, the IP will be switched back to reset mode. This allows implementing
> runtime PM and, along with it, save more power when the IP is not used.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - fixed typos in patch description
> - in ravb_probe() switch the hardware to reset mode just after phy
>   initialization
> 
> Changes in v2:
> - none; this patch is new
> 
> 
>  drivers/net/ethernet/renesas/ravb_main.c | 78 ++++++++++++++----------
>  1 file changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 1cc1ecd8d6a8..434b4777de5e 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -2746,11 +2755,6 @@ static int ravb_probe(struct platform_device *pdev)
>  	ndev->netdev_ops = &ravb_netdev_ops;
>  	ndev->ethtool_ops = &ravb_ethtool_ops;
>  
> -	/* Set AVB config mode */
> -	error = ravb_set_config_mode(ndev);
> -	if (error)
> -		goto out_rpm_put;
> -
>  	error = ravb_compute_gti(ndev);
>  	if (error)
>  		goto out_rpm_put;
> @@ -2785,13 +2789,23 @@ static int ravb_probe(struct platform_device *pdev)
>  		eth_hw_addr_random(ndev);
>  	}
>  
> +	/* Set config mode as this is needed for PHY initialization. */
> +	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);

   Hm... don't you need this at laest before calling ravb_read_mac_address()
just above?

> +	if (error)
> +		goto out_rpm_put;
> +
>  	/* MDIO bus init */
>  	error = ravb_mdio_init(priv);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to initialize MDIO\n");
> -		goto out_dma_free;
> +		goto out_reset_mode;
>  	}
>  
> +	/* Undo previous switch to config opmode. */
> +	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
> +	if (error)
> +		goto out_mdio_release;
> +
>  	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll);
>  	if (info->nc_queues)
>  		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
[...]

MBR, Sergey

