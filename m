Return-Path: <linux-kernel+bounces-47035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C0984484C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F8928D875
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C0364D5;
	Wed, 31 Jan 2024 19:51:45 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8903EA7B;
	Wed, 31 Jan 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730704; cv=none; b=dYJ1fJDWwy33sAb/PB8YWZHYm+X7tBpZ+GCSyybHObh6/URdyzIp3+z1E0qkTZuuiHxBqDcZrrxf1eQW7MeJO8y6mxdFxaL9exQXYl8pktZsjmrjCMuKC+UU13lYuchM7jObZ66qWUQLzuCQWOjUieZPM41tne71JXDV1s0+KJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730704; c=relaxed/simple;
	bh=M6wSqmB0Z4qDqXRKTry7u9uVyCw99+NA5tEi+4ltQBU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QRGU4hM5vn2UuOf06Q0xpWAf7BLZsGuMy7KObnWcY15bueDiz7IExhFcFKNDUOHOWGlcU1EM+BZwhTklm9RT+a4C6Cj8iMU+abOqNJa+z/fs5uvm/YaX9KeY1Wj6nsf1mFTfNkIOAoRfxvtvS3CQLGyX48FudRFt1ZP/ekOSZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.81.146) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 31 Jan
 2024 22:51:29 +0300
Subject: Re: [PATCH net-next v5 08/15] net: ravb: Move the IRQs
 getting/requesting in the probe() method
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131084133.1671440-9-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5536e607-e03b-f38e-2909-a6f6a126ff0d@omp.ru>
Date: Wed, 31 Jan 2024 22:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240131084133.1671440-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/31/2024 19:37:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183090 [Jan 31 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.146 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.146
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/31/2024 19:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/31/2024 10:54:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

   I said the subject needs to be changed to "net: ravb: Move getting/requesting IRQs in
the probe() method", not "net: ravb: Move IRQs getting/requesting in the probe() method".
That's not very proper English, AFAIK! =)

On 1/31/24 11:41 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM implementation will disable clocks at the end of
> ravb_probe(). As some IP variants switch to reset mode as a result of
> setting module standby through clock disable APIs, to implement runtime PM
> the resource parsing and requesting are moved in the probe function and IP
> settings are moved in the open function. This is done because at the end of
> the probe some IP variants will switch anyway to reset mode and the
> registers content is lost. Also keeping only register settings operations
> in the ravb_open()/ravb_close() functions will make them faster.
> 
> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
> the interface is open. As now IRQs getting/requesting are in a single place

   Again, "getting/requesting IRQs is done"...

> there is no need to keep intermediary data (like ravb_rx_irqs[] and
> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
> 
> In order to avoid accessing the IP registers while the IP is runtime
> suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
> IP clocks are enabled) in the interrupt handlers were introduced

   But can't we just request our IRQs after we call pm_runtime_resume_and_get()?
We proaobly can... but then again, we call pm_runtime_put_sync() in the remove()
method before the IRQs are freed...  So, it still seems OK that we're adding
pm_runtime_active() calls to the IRQ handlers in this very patch, not when we'll
start calling the RPM APIs in the ndo_{open|close}() methods, correct? :-)

> pm_runtime_active() checks. The device runtime PM usage counter has been
> incremented to avoid disabling the device's clocks while the check is in
> progress (if any).
> 
> This is a preparatory change to add runtime PM support for all IP variants.
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index e70c930840ce..f9297224e527 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -1092,11 +1082,23 @@ static irqreturn_t ravb_emac_interrupt(int irq, void *dev_id)
>  {
>  	struct net_device *ndev = dev_id;
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
> +	irqreturn_t result = IRQ_HANDLED;
> +
> +	pm_runtime_get_noresume(dev);
> +

   Not sure we need en empty line here...

> +	if (unlikely(!pm_runtime_active(dev))) {
> +		result = IRQ_NONE;
> +		goto out_rpm_put;
> +	}
>  
>  	spin_lock(&priv->lock);
>  	ravb_emac_interrupt_unlocked(ndev);
>  	spin_unlock(&priv->lock);
> -	return IRQ_HANDLED;
> +
> +out_rpm_put:
> +	pm_runtime_put_noidle(dev);
> +	return result;
>  }
>  
>  /* Error interrupt handler */
> @@ -1176,9 +1178,15 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
>  	struct net_device *ndev = dev_id;
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	struct device *dev = &priv->pdev->dev;
>  	irqreturn_t result = IRQ_NONE;
>  	u32 iss;
>  
> +	pm_runtime_get_noresume(dev);
> +

   And here...

> +	if (unlikely(!pm_runtime_active(dev)))
> +		goto out_rpm_put;
> +
>  	spin_lock(&priv->lock);
>  	/* Get interrupt status */
>  	iss = ravb_read(ndev, ISS);
[...]
> @@ -1230,9 +1241,15 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
>  {
>  	struct net_device *ndev = dev_id;
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
>  	irqreturn_t result = IRQ_NONE;
>  	u32 iss;
>  
> +	pm_runtime_get_noresume(dev);
> +

   Here too...

> +	if (unlikely(!pm_runtime_active(dev)))
> +		goto out_rpm_put;
> +
>  	spin_lock(&priv->lock);
>  	/* Get interrupt status */
>  	iss = ravb_read(ndev, ISS);
[...]
> @@ -1261,8 +1281,14 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
>  {
>  	struct net_device *ndev = dev_id;
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
>  	irqreturn_t result = IRQ_NONE;
>  
> +	pm_runtime_get_noresume(dev);
> +

   Here as well...

> +	if (unlikely(!pm_runtime_active(dev)))
> +		goto out_rpm_put;
> +
>  	spin_lock(&priv->lock);
>  
>  	/* Network control/Best effort queue RX/TX */
[...]
> @@ -2616,6 +2548,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
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

   Perhaps it's worth passing flags as a parameter here instead?

> +	}
> +	if (*irq < 0)
> +		return *irq;
> +
> +	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
> +	if (error)
> +		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
> +
> +	return error;
> +}
[...]

MBR, Sergey

