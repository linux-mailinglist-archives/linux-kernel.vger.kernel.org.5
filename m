Return-Path: <linux-kernel+bounces-2238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E03815A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58170285CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB83034C;
	Sat, 16 Dec 2023 15:53:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0530641;
	Sat, 16 Dec 2023 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.82.73) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 16 Dec
 2023 18:53:35 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v2 08/21] net: ravb: Move the IRQs get and
 request in the probe function
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-9-claudiu.beznea.uj@bp.renesas.com>
Organization: Open Mobile Platform
Message-ID: <b3c03bd5-83f2-331e-07c0-eeabca139224@omp.ru>
Date: Sat, 16 Dec 2023 18:53:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214114600.2451162-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/16/2023 15:35:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182146 [Dec 15 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.73 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.73
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/16/2023 15:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/16/2023 1:10:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/14/23 2:45 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Move the IRQs get and request in the driver's probe function. As some IP
> variants switches to reset operation mode as a result of setting module

   s/switches/switch/.
   Also, the manuals call this "operating mode", not to mix with one of
the modes -- "operation mode".

> standby through clock enable/disable APIs, to implement runtime PM the
> resource parsing and requests are moved in the probe function and IP

   Requesting.
   Could you explain in more detail why you need to do this?

> settings are moved in the open functions. This is a preparatory change to

   I don't see you moving anything into ravb_open() here...

> add runtime PM support for all IP variants.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 83691a0f0cc2..d7f6e8ea8e79 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1731,7 +1731,7 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>  	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);

   Ugh, I didn't realize we had the managed device API call in a function
called from ravb_open()... :-/

[...]
> @@ -2616,6 +2536,127 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
>  	}
>  }
>  
> +static int ravb_get_irqs(struct ravb_private *priv)
> +{
> +	const char *err_a_irq_name = NULL, *mgmt_a_irq_name = NULL;

   You don't seem to use these as the pointers. Could be bool instead?
But even that doesn't seem necessary..

> +	const struct ravb_hw_info *info = priv->info;
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +	const char *irq_name, *emac_irq_name;
> +	int i, irq;
> +
> +	if (!info->multi_irqs) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0)
> +			return irq;
> +
> +		ndev->irq = irq;
> +		return 0;
> +	}
> +
> +	if (info->err_mgmt_irqs) {
> +		irq_name = "dia";
> +		emac_irq_name = "line3";
> +		err_a_irq_name = "err_a";
> +		mgmt_a_irq_name = "mgmt_a";
> +	} else {
> +		irq_name = "ch22";
> +		emac_irq_name = "ch24";
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, irq_name);
> +	if (irq < 0)
> +		return irq;
> +	ndev->irq = irq;
> +
> +	irq = platform_get_irq_byname(pdev, emac_irq_name);
> +	if (irq < 0)
> +		return irq;
> +	priv->emac_irq = irq;
> +
> +	if (err_a_irq_name) {

   Why not just ctest info->err_mgmt_irqs here, as it was before
this patch?

> +		irq = platform_get_irq_byname(pdev, "err_a");
> +		if (irq < 0)
> +			return irq;
> +		priv->erra_irq = irq;
> +	}
> +
> +	if (mgmt_a_irq_name) {
> +		irq = platform_get_irq_byname(pdev, "mgmt_a");
> +		if (irq < 0)
> +			return irq;
> +		priv->mgmta_irq = irq;
> +	}
> +
> +	for (i = 0; i < NUM_RX_QUEUE; i++) {
> +		irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
> +		if (irq < 0)
> +			return irq;
> +		priv->rx_irqs[i] = irq;
> +	}
> +	for (i = 0; i < NUM_TX_QUEUE; i++) {
> +		irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
> +		if (irq < 0)
> +			return irq;
> +		priv->tx_irqs[i] = irq;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ravb_request_irqs(struct ravb_private *priv)

   I'm not sure separating getting and requesting IRQs is a good idea.
As you're switching to using the managed device API anyway, you could
save on some IRQ-related fields in the *struct* ravb_private, I think...

[...]

MBR, Sergey

