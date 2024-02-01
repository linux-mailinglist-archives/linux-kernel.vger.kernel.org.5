Return-Path: <linux-kernel+bounces-47693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C72845165
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC81F282EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330121386A1;
	Thu,  1 Feb 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pjhXywCe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FD132C1E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769098; cv=none; b=hgApy/XFs+vL2Pn4PJD5XQvbhitAe1eEAHunrh1DkQnf6C9cPwOE11KoIHI6IVKhm6KvC5Fpyt4HydUcYfhDu1c2/HOeL3z4OmnP6KweclSw/GuTeUSl3cEI/s68019NOyaK1BccT9PSoo2nQXCOD5i/1b7oPg92Jhz0wruncGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769098; c=relaxed/simple;
	bh=rhkKqXYx2bfqJ3XZQo1ZFPXeQt4Ok4Ahotcdhk9yTjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx7fHoGjadlbpPRdno0vZthw0USUpxYDHAVxBSXMVIbhfCHhofySMCnWMSnvIeCyHwT8it3oyMhzzqYEVICkhcXQ0NNQRMRkaHI0+C16CcI/IGjyEKObH5+MB8NCY99ih2Pw7L4u4X65MWSq870gvThas6iwjskiv1WFFMZDhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pjhXywCe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso3192421a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706769094; x=1707373894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ILH3iVCOAXF1BayqkdoSoFZAWJWdaJcxQN309+oN/4=;
        b=pjhXywCezFnTggORZ+MdQ5ZyxrYhnPfmBxEWd4S02cFLxmg9lthti1xGMzQr9mvvMC
         SJS6xUj7d9p7FN/q/uwfs2CqnBxrVLbEzOHseAo1NGu2n8FSJSIqlWgiJqfnxHezE0ie
         r0vs98mlA0Z+DU18ZXQIKngQ9LnnJFh9raEO+fvjmo4rT9bO61IbZL3XDp2wPgQGw5EO
         H9p/zntYIfM+qPBzGX3eJYAInuqsPOs2KRMhZFrSzz9j/A2FXOxeJB7nGt7DEidRab1a
         iFqwKCVfQ+70qrBahdGOe2RDwG6uiL38Yc8W8dUUTldem8sJcv24fpNIgI/PhJWJjdtb
         8OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769094; x=1707373894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ILH3iVCOAXF1BayqkdoSoFZAWJWdaJcxQN309+oN/4=;
        b=DPe6T3H9AJTwrN3GpZ7Cy+ZoleO8ts5URjwGd1Mg53sdivCIsKXENmu3HCN4oE6ud+
         vIWrtGbWx8C81U+0UiD4OIOO8O2KR3uJrSpeyIaW/jQD4GXRXcUFjdgjnHABPds8otYo
         peK5vbgAux/ayUsd+Mge6v7XzsBPiqiVvZ4NiC99m9b88kohmBKXm281XDbfXys8T8DW
         mGRZVLKnYpdUXRFcK8ur7aBilZDWWVqlb219HlozIf7pePVOPUjZi7DEoiUhPCONOCGv
         cPCiOi9Zj0rhshTvPNbdgmtKlWu8Q0Hh6xoO1Kuz30lyFPD+erVkEuTNj4Dr3/GIH7TW
         6fjA==
X-Gm-Message-State: AOJu0Ywm2tH8pprKgMq39jEX0fRazEsLwnlXi67IrWXBeebRmgxxFp0e
	si0QtdaSYzx6dS+r1IMXkT89TpbPWZH4nlQNPV7Xd3ViYlOokQY3fvHnWxrWNDs=
X-Google-Smtp-Source: AGHT+IFJuMt/iAwHv85KWXo5SEc8zjmjsTXgILaTRKPTGHLtJ10gxSybs1Zm87LeDlgqRJYYa0918w==
X-Received: by 2002:a50:fa93:0:b0:55f:b5a5:9f6c with SMTP id w19-20020a50fa93000000b0055fb5a59f6cmr633497edr.4.1706769094226;
        Wed, 31 Jan 2024 22:31:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0SQhONyb9M3xPhhEr8ZR2V2hwQXJE5ofoOfBa77A0czh8LozpdpefPWdxHGioIGOVwJvrfwd9ZPR2K1cEYHt2TJ588lUoerWDaMNpnWZJ16PEP+jeSiVmMotdJ75Xy8AixWp/1W2ID6MIjkdcvFazy+Dkh4fQGWptDY/CCqZDygxY3sYfiWYZ/AHwo8faWH/6k44kBh4BSsdzj2cRSik0PNolL4YywDb7ESMa+Or48u6rhoCJekqmAPZRtG2ZTC4uB3+HIDRCnPb8sMl1A6xtqNzhV9qOHfsoml5+lFGjN/rmVgSfRyD/sLiiMXfiWiaQhO5Ndo2pzbZZPcHzobqTNun7mELQdPm2CuW2wkgKvEJytvs8k9Y725OTkrI6Gs5FgusODpJlkhDhgw8phVhgNfujg0YScjijdbdmezMNdeobWC4=
Received: from [192.168.50.4] ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402500e00b0055c67e6454asm6573565eda.70.2024.01.31.22.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 22:31:33 -0800 (PST)
Message-ID: <9321b515-b4da-4d18-9d87-3470caf28b6d@tuxon.dev>
Date: Thu, 1 Feb 2024 08:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 08/15] net: ravb: Move the IRQs
 getting/requesting in the probe() method
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131084133.1671440-9-claudiu.beznea.uj@bp.renesas.com>
 <5536e607-e03b-f38e-2909-a6f6a126ff0d@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <5536e607-e03b-f38e-2909-a6f6a126ff0d@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31.01.2024 21:51, Sergey Shtylyov wrote:
>    I said the subject needs to be changed to "net: ravb: Move getting/requesting IRQs in
> the probe() method", not "net: ravb: Move IRQs getting/requesting in the probe() method".
> That's not very proper English, AFAIK! =)

It seems I messed this up.

> 
> On 1/31/24 11:41 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The runtime PM implementation will disable clocks at the end of
>> ravb_probe(). As some IP variants switch to reset mode as a result of
>> setting module standby through clock disable APIs, to implement runtime PM
>> the resource parsing and requesting are moved in the probe function and IP
>> settings are moved in the open function. This is done because at the end of
>> the probe some IP variants will switch anyway to reset mode and the
>> registers content is lost. Also keeping only register settings operations
>> in the ravb_open()/ravb_close() functions will make them faster.
>>
>> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
>> the interface is open. As now IRQs getting/requesting are in a single place
> 
>    Again, "getting/requesting IRQs is done"...
> 
>> there is no need to keep intermediary data (like ravb_rx_irqs[] and
>> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
>>
>> In order to avoid accessing the IP registers while the IP is runtime
>> suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
>> IP clocks are enabled) in the interrupt handlers were introduced
> 
>    But can't we just request our IRQs after we call pm_runtime_resume_and_get()?
> We proaobly can... but then again, we call pm_runtime_put_sync() in the remove()
> method before the IRQs are freed...  So, it still seems OK that we're adding
> pm_runtime_active() calls to the IRQ handlers in this very patch, not when we'll
> start calling the RPM APIs in the ndo_{open|close}() methods, correct? :-)

Yes, it should be safe.

> 
>> pm_runtime_active() checks. The device runtime PM usage counter has been
>> incremented to avoid disabling the device's clocks while the check is in
>> progress (if any).
>>
>> This is a preparatory change to add runtime PM support for all IP variants.
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index e70c930840ce..f9297224e527 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -1092,11 +1082,23 @@ static irqreturn_t ravb_emac_interrupt(int irq, void *dev_id)
>>  {
>>  	struct net_device *ndev = dev_id;
>>  	struct ravb_private *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>> +	irqreturn_t result = IRQ_HANDLED;
>> +
>> +	pm_runtime_get_noresume(dev);
>> +
> 
>    Not sure we need en empty line here...

That's a personal taste... more like to emphasize that this is PM runtime
"protected"... Same for the rest of occurrences you signaled below.

> 
>> +	if (unlikely(!pm_runtime_active(dev))) {
>> +		result = IRQ_NONE;
>> +		goto out_rpm_put;
>> +	}
>>  
>>  	spin_lock(&priv->lock);
>>  	ravb_emac_interrupt_unlocked(ndev);
>>  	spin_unlock(&priv->lock);
>> -	return IRQ_HANDLED;
>> +
>> +out_rpm_put:
>> +	pm_runtime_put_noidle(dev);
>> +	return result;
>>  }
>>  
>>  /* Error interrupt handler */
>> @@ -1176,9 +1178,15 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
>>  	struct net_device *ndev = dev_id;
>>  	struct ravb_private *priv = netdev_priv(ndev);
>>  	const struct ravb_hw_info *info = priv->info;
>> +	struct device *dev = &priv->pdev->dev;
>>  	irqreturn_t result = IRQ_NONE;
>>  	u32 iss;
>>  
>> +	pm_runtime_get_noresume(dev);
>> +
> 
>    And here...
> 
>> +	if (unlikely(!pm_runtime_active(dev)))
>> +		goto out_rpm_put;
>> +
>>  	spin_lock(&priv->lock);
>>  	/* Get interrupt status */
>>  	iss = ravb_read(ndev, ISS);
> [...]
>> @@ -1230,9 +1241,15 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
>>  {
>>  	struct net_device *ndev = dev_id;
>>  	struct ravb_private *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>>  	irqreturn_t result = IRQ_NONE;
>>  	u32 iss;
>>  
>> +	pm_runtime_get_noresume(dev);
>> +
> 
>    Here too...
> 
>> +	if (unlikely(!pm_runtime_active(dev)))
>> +		goto out_rpm_put;
>> +
>>  	spin_lock(&priv->lock);
>>  	/* Get interrupt status */
>>  	iss = ravb_read(ndev, ISS);
> [...]
>> @@ -1261,8 +1281,14 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
>>  {
>>  	struct net_device *ndev = dev_id;
>>  	struct ravb_private *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>>  	irqreturn_t result = IRQ_NONE;
>>  
>> +	pm_runtime_get_noresume(dev);
>> +
> 
>    Here as well...
> 
>> +	if (unlikely(!pm_runtime_active(dev)))
>> +		goto out_rpm_put;
>> +
>>  	spin_lock(&priv->lock);
>>  
>>  	/* Network control/Best effort queue RX/TX */
> [...]
>> @@ -2616,6 +2548,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
>>  	}
>>  }
>>  
>> +static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
>> +			  const char *ch, int *irq, irq_handler_t handler)
>> +{
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +	struct device *dev = &pdev->dev;
>> +	const char *dev_name;
>> +	unsigned long flags;
>> +	int error;
>> +
>> +	if (irq_name) {
>> +		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
>> +		if (!dev_name)
>> +			return -ENOMEM;
>> +
>> +		*irq = platform_get_irq_byname(pdev, irq_name);
>> +		flags = 0;
>> +	} else {
>> +		dev_name = ndev->name;
>> +		*irq = platform_get_irq(pdev, 0);
>> +		flags = IRQF_SHARED;
> 
>    Perhaps it's worth passing flags as a parameter here instead?

I don't see it like this. We need this flag for a single call of
ravb_setup_irq(), we can determine for which call we need to set this flag
so I think it is redundant to have an extra argument for it.

> 
>> +	}
>> +	if (*irq < 0)
>> +		return *irq;
>> +
>> +	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
>> +	if (error)
>> +		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
>> +
>> +	return error;
>> +}
> [...]
> 
> MBR, Sergey

