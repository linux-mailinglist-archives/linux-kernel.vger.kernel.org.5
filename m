Return-Path: <linux-kernel+bounces-118063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D293588B32C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D11C36A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B26F533;
	Mon, 25 Mar 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI/N6eTB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692315D723
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403491; cv=none; b=lTZhTE5jYDcLAfUxkeuQzBf+sptYworUjZv20g743PSkEFs24b+9yZz/TlQTC2qkfZ9C+L4iK6uTB/2ah2FAk6yCpc4lQ0V73t0SRpFX96bltTO1iIGKLLKXJ705bK+SuW82F2HMuL0XYuquhjdnLoXvR+zQxUVs+pnJnF+Rajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403491; c=relaxed/simple;
	bh=VPAchq+M68VV44gVTC6uMYMuUEi605N7vssefb7i2Hs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VJVqSZxGDG/egIxmQVtVWxXxJhdtyrOX4gFr+BVv7lsQTpXFhoLVqHfjCw5iAO/X1OlM8omEQFaAUvnqBtY6KZDy/eeabGh9BeX+vpdgQreDDCpLr/6ca8uPrP+UaYo7pebuhyOTh0PVsML/DsfViNo7dBa+4FhrWcX9YpoDcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WI/N6eTB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso4774660a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711403488; x=1712008288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujd4Kk9YyH7DdW2c6ufFJckPeLpYLG6n2QhNv6VOBTY=;
        b=WI/N6eTBNSbE2KfMuRQbE32PM9kV2JM2vNj28D9M7Kimq2IbYFnoDZ7csWpNIbjFoA
         GtSe6BPApO6622BDPEvH63/HHj6ofiZrFK18YOyY6dRMHV86mOBZtr7ns/rcR0TZAem3
         wzvMWNp4H7Ako4KJT/77uYFtpMrkZKtgCoCf6uXCDNblfS9pwZ1XgwdfBxuomTlebPLk
         uOwBlUq25IE8THxi6EiPCTk/TT3d/LguKfxpjsvOKQXjDRpLc5GPQjv2LGVObVWoDGpb
         bG6yDLUiCFLob3RIcoVlMyHGSE2eXVlEnkd3ANN40jnx7PaRL16ZTlILD4x9WtUEnaC5
         ++Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403488; x=1712008288;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ujd4Kk9YyH7DdW2c6ufFJckPeLpYLG6n2QhNv6VOBTY=;
        b=dRgSzoaiCXQgzuqVeJPbRkWKh/zHBtLPQiQdV9alt9VPK9N1/FdwUHIDW1P+Jq8uMU
         xvIiZV71UvUdmiqVzpYasx7AYIqTb1DecxkNMWy7HFl8Z1p/CHliS7Ahzevr/fgfzB49
         aSQtHo2u8a1Isbq8Sjzr3uJ6o3gJG1huwDWd6sAiqqjDqqL3lkUvHsigoMsIaR03Hvfi
         cDdHxINZj2fJI91weg94bXU49c6aGmZhQrxgURq+Urra+n6Ji5TWeaD4/1mwsHGU01rB
         0XlPsAxR1I5i38kFy4OXIUHqu9sJn8JN4YIRtKg+GlhGdf7GKLJ/C7ASZcgQaHeNuDFy
         fexQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh24uRQnvsvB6i2aDFQdt6gImmSgT4+KUpB39BvJgysG+uIdBTUh7xkcIuhnKPldKN9lNM7WdqakPhe2QP2+3UCSRDpLaw++IskrRw
X-Gm-Message-State: AOJu0YzeYOAQCtEe0rOiPbdrk5+vQwy2AGXJjnEZQFYxMPcjy8K/mRDB
	j4mcqddVJjpWlpxBlY2O3n2TysLhgBoJYWXnhmOfZTMNyqGWGUNd2ef/uwkkJ94=
X-Google-Smtp-Source: AGHT+IF7Yn+qQFw8J7OLV7RNhx43LZ/YIN5hOg5BQ15kqZK4CcfMoK0HsVlRYVinOdWv02s1gwcOwg==
X-Received: by 2002:a50:d6c9:0:b0:56b:d153:8fe0 with SMTP id l9-20020a50d6c9000000b0056bd1538fe0mr5361973edj.2.1711403487746;
        Mon, 25 Mar 2024 14:51:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id ij5-20020a056402158500b0056c09fda4e6sm1987791edb.54.2024.03.25.14.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:51:27 -0700 (PDT)
Message-ID: <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>
Date: Mon, 25 Mar 2024 22:51:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240325195306.13133-1-sudanl@amazon.com>
 <20240325195306.13133-5-sudanl@amazon.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325195306.13133-5-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 20:53, Sudan Landge wrote:
> - Extend the vmgenid platform driver to support devicetree bindings.
>   With this support, hypervisors can send vmgenid notifications to
>   the virtual machine without the need to enable ACPI. The bindings
>   are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml
> 
> - Use proper FLAGS to compile with and without ACPI and/or devicetree.

I do not see any flags. You use if/ifdefs which is a NAK.

Do not mix independent changes within one commit. Please follow
guidelines in submitting-patches for this.

> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  drivers/virt/Kconfig   |  1 -
>  drivers/virt/vmgenid.c | 85 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 80 insertions(+), 6 deletions(-)
> 

..

> +
> +#if IS_ENABLED(CONFIG_OF)
> +static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
> +{
> +	(void)irq;
> +	vmgenid_notify(dev);
> +
> +	return IRQ_HANDLED;
> +}
> +#endif
>  
>  static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>  {
> @@ -55,6 +70,7 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>  
>  static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>  {
> +#if IS_ENABLED(CONFIG_ACPI)

Why do you create all this ifdeffery in the code? You already got
comments to get rid of all this #if.

>  	struct acpi_device *device = ACPI_COMPANION(dev);
>  	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
>  	union acpi_object *obj;
> @@ -96,6 +112,49 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>  out:
>  	ACPI_FREE(parsed.pointer);
>  	return ret;
> +#else
> +	(void)dev;
> +	(void)state;
> +	return -EINVAL;
> +#endif
> +}
> +
> +static int vmgenid_add_of(struct platform_device *pdev, struct vmgenid_state *state)
> +{
> +#if IS_ENABLED(CONFIG_OF)
> +	void __iomem *remapped_ptr;
> +	int ret = 0;
> +
> +	remapped_ptr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(remapped_ptr)) {
> +		ret = PTR_ERR(remapped_ptr);
> +		goto out;
> +	}
> +
> +	ret = setup_vmgenid_state(state, remapped_ptr);
> +	if (ret)
> +		goto out;
> +
> +	state->irq = platform_get_irq(pdev, 0);
> +	if (state->irq < 0) {
> +		ret = state->irq;
> +		goto out;
> +	}
> +	pdev->dev.driver_data = state;
> +
> +	ret =  devm_request_irq(&pdev->dev, state->irq,
> +				vmgenid_of_irq_handler,
> +				IRQF_SHARED, "vmgenid", &pdev->dev);
> +	if (ret)
> +		pdev->dev.driver_data = NULL;
> +
> +out:
> +	return ret;
> +#else


That's neither readable code nor matching Linux coding style. Driver
don't do such magic. Please open some recent drivers for ACPI and OF and
look there. Old drivers had stubs for !CONFIG_XXX, but new drivers don't
have even that.

> +	(void)dev;
> +	(void)state;
> +	return -EINVAL;
> +#endif
>  }
>  
>  static int vmgenid_add(struct platform_device *pdev)
> @@ -108,7 +167,10 @@ static int vmgenid_add(struct platform_device *pdev)
>  	if (!state)
>  		return -ENOMEM;
>  
> -	ret = vmgenid_add_acpi(dev, state);
> +	if (dev->of_node)
> +		ret = vmgenid_add_of(pdev, state);
> +	else
> +		ret = vmgenid_add_acpi(dev, state);
>  
>  	if (ret)
>  		devm_kfree(dev, state);
> @@ -116,18 +178,31 @@ static int vmgenid_add(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static const struct acpi_device_id vmgenid_ids[] = {
> +#if IS_ENABLED(CONFIG_OF)

No, drop.

> +static const struct of_device_id vmgenid_of_ids[] = {
> +	{ .compatible = "linux,vmgenctr", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
> +#endif
> +
> +#if IS_ENABLED(CONFIG_ACPI)


> +static const struct acpi_device_id vmgenid_acpi_ids[] = {
>  	{ "VMGENCTR", 0 },
>  	{ "VM_GEN_COUNTER", 0 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
> +#endif
>  
>  static struct platform_driver vmgenid_plaform_driver = {
>  	.probe      = vmgenid_add,
>  	.driver     = {
>  		.name   = "vmgenid",
> -		.acpi_match_table = ACPI_PTR(vmgenid_ids),
> +		.acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
> +#if IS_ENABLED(CONFIG_OF)

No, really, this is some ancient code.

Please point me to single driver doing such ifdef.

> +		.of_match_table = vmgenid_of_ids,
> +#endif
>  		.owner = THIS_MODULE,

This is clearly some abandoned driver... sigh... I thought we get rid of
all this owner crap. Many years ago. How could it appear back if
automated tools report it?

Considering how many failures LKP reported for your patchsets, I have
real doubts that anyone actually tests this code.

Please confirm:
Did you build W=1, run smatch, sparse and coccinelle on the driver after
your changes?

Best regards,
Krzysztof


