Return-Path: <linux-kernel+bounces-107720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A158800BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5161C21D90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D57657DE;
	Tue, 19 Mar 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbzButig"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10562657AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862262; cv=none; b=idvGH0qMwOKKs1g9H/4VLSMBQolAuIJ8jvfCs16F/D03QpY7OYXGyRLossNvMGtgjviwzgLIxWIPcjOpZugTITPM1lKxLZlS4yTFXg4Kr20a9pytva/37kqIEV8w50IAKQpmFhi7tJoxqD21fMxfHGznTNybwRqGlZZZ01CllJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862262; c=relaxed/simple;
	bh=ktqOiIf2vX6ms3x4Pb84rEKpunt+i2pLnkE/N4THCu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A09OTqIvBED8brZ1XJLvfISUJhWed2Lgp1TRmzMJqUotqIQ6pOHytaIP0ezUVA23OuU70y5sBD0mNOdJOEM5xnLQIhyq6Eo98H2A9k1YagTJC1b6pjR8/jrk2Cgx3b2P8C1It4t4f7kcj58lk5sfzwJ7pW8ypMh8EL8hyn1PXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbzButig; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46d0a8399aso281823166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710862258; x=1711467058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/c+2ErpgcfGcdm4HJ1BrOUXZszU/fAz1jd3932XKH9M=;
        b=sbzButiguYawX/PTnfz6JzZWmojO86YfWtWyKr+HJsoqMExzAp+Dq6Tm1+gxGaDxpP
         UW/jbyahAb1uyHeLi4HGCFa5JKUVLeg5y9BxUFZl4zWM7BtzpbjzXCthqpkcbYDApBpK
         +2GXp9q3wZGVWgxT0HK6tMRueDKKTAdp5DF3idbKly6gK2S3nwG8AvrJ3/g6mvTt1Kgi
         ssIKOX7DkCw1fV6KPz8ThfJa0YcErIlXWb8zDN9pW2+J3mtw5zX8Lm4ZnwLoTwZTnE39
         s6jYuNqmQnH/GhghpEyzuYa3gQn7HZ+cKA1FCXevOhfXunJ5V0G0BXgDos42OjO/3XsZ
         jA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862258; x=1711467058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c+2ErpgcfGcdm4HJ1BrOUXZszU/fAz1jd3932XKH9M=;
        b=ZfRwquCD0UYZ7b3gd+aEgrsP5SjN8FZ5pEVmdpD+pVvHqPPZil5pP4SUA8ZkGnvYLE
         zvFaevwhYytEjaDungAMN6bEPWfpGf4wUXM10+eW/Uooshun0qYUpZ8F30DMEY6QJBIl
         KDi/BW1L9Dh4qOgZujxMkxzzyIUtTdTPs2K3csgMx5glsDiAb9yTm/goRj45eIXeVSKc
         I7fWtXz9ooeZLCFHbs9oJG1Y6jVXI6jSrb5mXEYLWRuDNpSNS//4JBjDuNfDo7ej6mPn
         D0bpm8w/xVm5k0aU2bE6y0LHnBxTlk1HZ+DnB11z3SIIESgj1zaj6TsazeCyENKSC8DO
         8w0w==
X-Forwarded-Encrypted: i=1; AJvYcCXWL7frBbpiyb8eS7zDIqlTxUtTp8/TufE1z81LhLzpxXKHE4WPzcQacp/473s3o6Jxm2u/7gtqfeOUHHk+CZ+3P77D1Vjk6o29f59Z
X-Gm-Message-State: AOJu0YzOPmxwcD9RALOFCKLhtFZ4fztCpY0aAmIt1+021Fj2A6WqXVHv
	0w/ovU5buP6+MN9hk9e5n/lgFLa+N1+qi+gi208HEzgcJW/k5dRo+U/h5fxcwqM=
X-Google-Smtp-Source: AGHT+IGXNcwSwUCmjrj9NAfH9bf4h4u9nRzXsue9aZLoDTWOVyDlKNhDdR9ropC3DTcDOCMGv8FZPw==
X-Received: by 2002:a17:906:80c4:b0:a46:a8b8:f4cf with SMTP id a4-20020a17090680c400b00a46a8b8f4cfmr2462482ejx.35.1710862258326;
        Tue, 19 Mar 2024 08:30:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id rf22-20020a1709076a1600b00a450b817705sm6221135ejc.154.2024.03.19.08.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 08:30:57 -0700 (PDT)
Message-ID: <002f34fc-8d79-4915-be42-03c72b3ae4a4@linaro.org>
Date: Tue, 19 Mar 2024 16:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240319143253.22317-1-sudanl@amazon.com>
 <20240319143253.22317-5-sudanl@amazon.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319143253.22317-5-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:32, Sudan Landge wrote:
> Extend the vmgenid platform driver to support devicetree bindings.
> With this support, hypervisors can send vmgenid notifications to
> the virtual machine without the need to enable ACPI.
> 
> The bindings are located at:
> - Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  drivers/virt/Kconfig   |  2 +-
>  drivers/virt/vmgenid.c | 90 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 86 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 40129b6f0eca..4f33ee2f0372 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -16,7 +16,7 @@ if VIRT_DRIVERS
>  config VMGENID
>  	tristate "Virtual Machine Generation ID driver"
>  	default y
> -	depends on ACPI
> +	depends on (ACPI || OF)
>  	help
>  	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
>  	  to reseed the RNG when the VM is cloned. This is highly recommended if
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index e82b344a9d61..96a3ff8ec05a 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   *
> - * The "Virtual Machine Generation ID" is exposed via ACPI and changes when a
> + * The "Virtual Machine Generation ID" is exposed via ACPI or DT and changes when a
>   * virtual machine forks or is cloned. This driver exists for shepherding that
>   * information to random.c.
>   */
> @@ -12,6 +12,12 @@
>  #include <linux/acpi.h>
>  #include <linux/random.h>
>  #include <acpi/actypes.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
>  ACPI_MODULE_NAME("vmgenid");
> @@ -21,6 +27,7 @@ enum { VMGENID_SIZE = 16 };
>  struct vmgenid_state {
>  	u8 *next_id;
>  	u8 this_id[VMGENID_SIZE];
> +	unsigned int irq;
>  };
>  
>  static void vmgenid_notify(struct device *device)
> @@ -42,6 +49,13 @@ static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
>  	vmgenid_notify(dev);
>  }
>  
> +static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
> +{
> +	vmgenid_notify(dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>  {
>  	if (IS_ERR(next_id))
> @@ -98,6 +112,43 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>  	return ret;
>  }
>  
> +static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
> +{
> +	struct resource res;
> +	int ret = 0;
> +
> +	if (of_address_to_resource(dev->of_node, 0, &res)) {
> +		dev_err(dev, "Failed to get resources from device tree");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!__request_mem_region(res.start, resource_size(&res),
> +				  "vmgenid", IORESOURCE_EXCLUSIVE)) {
> +		dev_err(dev, "Failed to request mem region");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = setup_vmgenid_state(state, of_iomap(dev->of_node, 0));
> +	if (ret)
> +		goto out;
> +
> +	state->irq = irq_of_parse_and_map(dev->of_node, 0);
> +	dev->driver_data = state;
> +
> +	if (request_irq(state->irq, vmgenid_of_irq_handler,
> +			IRQF_SHARED, "vmgenid", dev) < 0) {
> +		dev_err(dev, "request_irq failed");
> +		dev->driver_data = NULL;
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>  static int vmgenid_add(struct platform_device *pdev)
>  {
>  	struct vmgenid_state *state;
> @@ -108,7 +159,10 @@ static int vmgenid_add(struct platform_device *pdev)
>  	if (!state)
>  		return -ENOMEM;
>  
> -	ret = vmgenid_add_acpi(dev, state);
> +	if (dev->of_node)
> +		ret = vmgenid_add_of(dev, state);
> +	else
> +		ret = vmgenid_add_acpi(dev, state);
>  
>  	if (ret)
>  		devm_kfree(dev, state);
> @@ -116,7 +170,30 @@ static int vmgenid_add(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static const struct acpi_device_id vmgenid_ids[] = {
> +static int vmgenid_remove(struct platform_device *pdev)
> +{
> +	struct vmgenid_state *state = NULL;
> +

How is this related to the patch? Removal is valid (or invalid)
regardless your bind method.

> +	if (!pdev)
> +		return -EINVAL;
> +
> +	state = pdev->dev.driver_data;
> +
> +	if (state && pdev->dev.of_node)
> +		free_irq(state->irq, &pdev->dev);
> +
> +	if (state)
> +		devm_kfree(&pdev->dev, state);

Why do you free devm memory? Which driver callback allocated it?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id vmgenid_of_ids[] = {
> +	{ .compatible = "linux,vmgenctr", },
> +	{},
> +};
> +
> +static const struct acpi_device_id vmgenid_acpi_ids[] = {
>  	{ "VMGENCTR", 0 },
>  	{ "VM_GEN_COUNTER", 0 },
>  	{ }
> @@ -124,9 +201,11 @@ static const struct acpi_device_id vmgenid_ids[] = {
>  
>  static struct platform_driver vmgenid_plaform_driver = {
>  	.probe      = vmgenid_add,
> +	.remove     = vmgenid_remove,
>  	.driver     = {
>  		.name   = "vmgenid",
> -		.acpi_match_table = ACPI_PTR(vmgenid_ids),
> +		.acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
> +		.of_match_table = vmgenid_of_ids,
>  		.owner = THIS_MODULE,
>  	},
>  };
> @@ -144,7 +223,8 @@ static void vmgenid_platform_device_exit(void)
>  module_init(vmgenid_platform_device_init)
>  module_exit(vmgenid_platform_device_exit)
>  
> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);

MODULE_DEVICE_TABLE goes immediately after the table.


Best regards,
Krzysztof


