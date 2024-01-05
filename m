Return-Path: <linux-kernel+bounces-18356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BA825C00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3365B285179
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88B21A11;
	Fri,  5 Jan 2024 20:57:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599935887;
	Fri,  5 Jan 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.81.170) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jan
 2024 23:57:24 +0300
Subject: Re: [PATCH net-next v3 08/19] net: ravb: Move the IRQs get and
 request in the probe function
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fa9c8db4-ed80-f64d-aae2-8b95281f302e@omp.ru>
Date: Fri, 5 Jan 2024 23:57:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/05/2024 20:40:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182466 [Jan 05 2024]
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
	31.173.81.170:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 01/05/2024 20:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/5/2024 6:26:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 11:23 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM implementation will disable clocks at the end of
> ravb_probe(). As some IP variants switch to reset mode as a result of
> setting module standby through clock disable APIs, to implement runtime PM
> the resource parsing and requesting are moved in the probe function and IP
> settings are moved in the open function. This is done because at the end of
> the probe some IP variants will switch anyway to reset mode and the
> registers content is lost. Also keeping only register specific operations
> in the ravb_open()/ravb_close() functions will make them faster.
> 
> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
> the interface is open. As now IRQs gets and requests are in a single place
> there is no need to keep intermediary data (like ravb_rx_irqs[] and
> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
> 
> This is a preparatory change to add runtime PM support for all IP variants.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]
> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index e0f8276cffed..e3506888cca6 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1089,10 +1089,6 @@ struct ravb_private {
>  	int msg_enable;
>  	int speed;
>  	int emac_irq;
> -	int erra_irq;
> -	int mgmta_irq;
> -	int rx_irqs[NUM_RX_QUEUE];
> -	int tx_irqs[NUM_TX_QUEUE];

   Good! :-)

[...]
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 4673cc2faec0..ac6488ffa29a 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -1727,85 +1717,21 @@ static const struct ethtool_ops ravb_ethtool_ops = {
>  	.set_wol		= ravb_set_wol,
>  };
>  
> -static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
> -				struct net_device *ndev, struct device *dev,
> -				const char *ch)
> -{
> -	char *name;
> -	int error;
> -
> -	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);

   Ugh! Should've fixed this outrage... :-/

[...]
> @@ -2616,6 +2509,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
>  	}
>  }
>  
> +static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
> +			  const char *ch, int *irq, irq_handler_t handler)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +	struct device *dev = &pdev->dev;
> +	const char *dev_name;
> +	unsigned long flags;
> +	int error;
> +
> +	if (irq_name) {
> +		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
> +		if (!dev_name)
> +			return -ENOMEM;
> +
> +		*irq = platform_get_irq_byname(pdev, irq_name);
> +		flags = 0;
> +	} else {
> +		dev_name = ndev->name;
> +		*irq = platform_get_irq(pdev, 0);
> +		flags = IRQF_SHARED;
> +	}
> +	if (*irq < 0)
> +		return *irq;
> +
> +	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
> +	if (error)
> +		netdev_err(ndev, "cannot request IRQ %s\n", irq_name);

   What will be printed when irq_name is NULL? Shouldn't this be dev_name
instead?

> +
> +	return error;
> +}
> +
> +static int ravb_setup_irqs(struct ravb_private *priv)
> +{
> +	const struct ravb_hw_info *info = priv->info;
> +	struct net_device *ndev = priv->ndev;
> +	const char *irq_name, *emac_irq_name;
> +	int error, irq;
> +
> +	if (!info->multi_irqs)
> +		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
> +
> +	if (info->err_mgmt_irqs) {
> +		irq_name = "dia";
> +		emac_irq_name = "line3";
> +	} else {
> +		irq_name = "ch22";
> +		emac_irq_name = "ch24";
> +	}
> +
> +	error = ravb_setup_irq(priv, irq_name, "ch22:multi", &ndev->irq, ravb_multi_interrupt);
> +	if (error)
> +		return error;
> +
> +	error = ravb_setup_irq(priv, emac_irq_name, "ch24:emac", &priv->emac_irq,
> +			       ravb_emac_interrupt);
> +	if (error)
> +		return error;
> +
> +	if (info->err_mgmt_irqs) {
> +		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);

   Hm, why pass 2 identical names?

> +		if (error)
> +			return error;
> +
> +		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);

   Here as well?

> +		if (error)
> +			return error;
> +	}
> +
> +	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);

   Hm, won't this result in "ch0:ch0:rx_be" as IRQ name?

> +	if (error)
> +		return error;
> +
> +	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);

   Same question...

> +	if (error)
> +		return error;
> +
> +	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);

   And here as well...

> +	if (error)
> +		return error;
> +
> +	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);

   Here too...

[...]

MBR, Sergey

