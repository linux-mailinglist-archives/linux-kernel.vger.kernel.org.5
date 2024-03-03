Return-Path: <linux-kernel+bounces-89731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7486F4D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DB4B232F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813CC121;
	Sun,  3 Mar 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fMDUwWOq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DAF9CD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468514; cv=none; b=eDAExFSN7wTL9046VeBlFyqEW79be6t7W2ZpDmKiPRCKy7Yg9wLpkjQCM1ur+ViJ8em0i1mUYwaEuJsd2j8uwu/hjj/U9Qx1h0NQPl7ARVu3rZTlK1Omgvfk09VUP/5dPwZffJXH8D4V+5Kzycfynfi9io7n8UvXaFsnzSWkyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468514; c=relaxed/simple;
	bh=CZZXtdt1IZjDHp5whHyiFRaG/76yuvSfTFvAoAv+j9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tMltR7+uMMPFCpQOBNFzdi0xNUBvi4iI2sz+EUeeC83SyR+K7ptz35+bO1G4tuiFc42DtBgHDRZX3eZGuwTH0Vi4FGjZfKxJ7RuuCHUlCTQgpibiGkpX/U+0rTymiQP5iqjegMXQA82H5bDTgCIv9VkxCdYQ7yT/KXdP1/Uakl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fMDUwWOq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e1d327595so1231213f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468511; x=1710073311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqQVtMCteF6vcIB8GNjsI4lJiOVGsEEIhmJjprsB3tk=;
        b=fMDUwWOq9vWOUE6rZbWFwrgM/VTwF3iel/b8tGHuCxjcEaKeQRxUrtcSHQLrNv2CxS
         x1aSVToZW3JryEfmo8kt9UTaT11vIc1DN3byAOrjPWmOMzYLKeyGJ2WNxetkkDi6Bjcv
         crKmLENyMX9LQMI0C6blQmd7rcOuN2AaDtoqUjReoML+pegH7m1byml/JZso7/g0YbmT
         QC+iayUbHlGjk2qYuAWYBiyEvEphONw/wnSL82uIXpts2vgr/IxTLI/lBl8z0t3DTxEn
         bt4j9e2HUx0MbPPylHRDClXaFB/etEbMv+38JYWzmCn9DeU9ygeNfDz1gDbyxlwBoi+R
         a0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468511; x=1710073311;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqQVtMCteF6vcIB8GNjsI4lJiOVGsEEIhmJjprsB3tk=;
        b=k45jdEZYwh9GZoMnO9bhwnPfwa+rt/T1Mhrom6IIXtc4utS+5O5XTikuszztqkO5EH
         AaQcLYN+s4n6ivo4m/qyzdB4CvCdRhvANgdpSBJC1LsEAko+4R33f34vER5V9fSfeWtc
         oYVEy4KZpJIggaQG+H7qVtYgGeQbKzLjZqdVxSM1RsCha/9DXVvoTTGtNzQVWiLw7vi6
         JjHBhO184UOBTmxfS6AVutwrkH77b+cPuG/J0qwS9lgFH/ac0r6BuBmPcfNNxgDvQ3Sv
         rXEj6KgRD9+JDXy0/lji25oyz6jMnSh+dJQZYpnA2Z3G4KySjZRitOvrdgBzXBwkduh7
         1Ung==
X-Forwarded-Encrypted: i=1; AJvYcCUyidgb5i3ckEDceHr67OTCLHUTRU8yNH8/D4dkF3h5UyEpGGqBmtgTCtGR4YnkGo/35ATpMYoY9tPqScKAfQAYPaa8tim2Fd4nySN5
X-Gm-Message-State: AOJu0YwoPUXfRKCsxYjpCFM5kNizco7rTqZoPZ97Ekf9KFEbj1sdP/GU
	1iISKrS9hxojtAL3Qm/MyC5xYjul1jGgXEz3jS9ubFprc3afQxlnW1xY4MnU9CY=
X-Google-Smtp-Source: AGHT+IEu5lNzZcOQMvaj3aD3ucAe4AnZoeQHEj7SRA/srmJnV1u3ip0F9kF0Dy0Mtto3LEWcBAh9tQ==
X-Received: by 2002:a5d:5950:0:b0:33d:2899:3a8a with SMTP id e16-20020a5d5950000000b0033d28993a8amr4240620wri.39.1709468511266;
        Sun, 03 Mar 2024 04:21:51 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:21:50 -0800 (PST)
Message-ID: <f1f9c53f-b11a-4fe1-9541-356ea75e883c@tuxon.dev>
Date: Sun, 3 Mar 2024 14:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/39] irqchip/atmel-aic5: Add support to get nirqs
 from DT for sam9x60 & sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 tglx@linutronix.de, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, andre.przywara@arm.com, mani@kernel.org,
 shawnguo@kernel.org, durai.manickamkr@microchip.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172905.673053-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172905.673053-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:29, Varshini Rajendran wrote:
> Add support to get number of IRQs from the respective DT node for sam9x60
> and sam9x7 devices. Since only this factor differs between the two SoCs,
> this patch adds support for the same. Adapt the sam9x60 dtsi
> accordingly.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Changed the implementation to fetch the NIRQs from DT as per the
>   comment to avoid introducing a new compatible when this is the only
>   difference between the SoCs related to this IP.
> ---
>  arch/arm/boot/dts/microchip/sam9x60.dtsi |  1 +
>  drivers/irqchip/irq-atmel-aic5.c         | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 73d570a17269..e405f68c9f54 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -1201,6 +1201,7 @@ aic: interrupt-controller@fffff100 {
>  				interrupt-controller;
>  				reg = <0xfffff100 0x100>;
>  				atmel,external-irqs = <31>;
> +				microchip,nr-irqs = <50>;
>  			};
>  
>  			dbgu: serial@fffff200 {
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 145535bd7560..5d96ad8860d3 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -398,11 +398,16 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
>  }
>  IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
>  
> -#define NR_SAM9X60_IRQS		50
> -
>  static int __init sam9x60_aic5_of_init(struct device_node *node,
>  				       struct device_node *parent)
>  {
> -	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
> +	int ret, nr_irqs;
> +
> +	ret = of_property_read_u32(node, "microchip,nr-irqs", &nr_irqs);
> +	if (ret) {
> +		pr_err("Not found microchip,nr-irqs property\n");

This breaks the ABI. You should ensure old device trees are still working
with this patch.

> +		return ret;
> +	}
> +	return aic5_of_init(node, parent, nr_irqs);
>  }
>  IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);

