Return-Path: <linux-kernel+bounces-151474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F648AAF57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6051C22723
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C1129A8E;
	Fri, 19 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Fw78A8BB"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00085943;
	Fri, 19 Apr 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533401; cv=none; b=XkM8i7q4hT3s1DgEyTSv6iOAM1EkuYF+uknfu4kCircrhk+owyyBstRRVco5NWVTBRN+MYHuvxKadQFnLUs4KPdq0ybPyelRLuO/a7EoeHewspUl+/VSAD2/Ht6Sf48hazS+xQ5U+HETFX9QlezMI/qUGrZVPKbjfKYKO73VAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533401; c=relaxed/simple;
	bh=AnAKiky0E4gckzRxx4ZmwEsYrVI2yt9Uyhop1O8glSg=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=WlRQu8qeiYHjJiTp0EatdCBuPUu7tU1U+GbrdpTuge/RTguvfZwHe7zWdcNeZn2jwHyQaAf7swc71IAwElUC+6GU/VCTxcQ7K0uG7zOwIyoZ92qBL13N8wWtx0A4JaTfc9OOJUCIq71keq3WVLB/E0k39iAJWxCm6JQlWfGBvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Fw78A8BB; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1713533400; x=1745069400;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=UmEBNCwEIS+XYV2c/JK9vsiDR55X/8OJx+hvdUZXHHw=;
  b=Fw78A8BB+TtWKIWFGmLso9RTq+O4uvmiDm2FxC0PYa351gO9lMgLqf9B
   MrpL/AYp1q/pT3bfkHllInhlsY4t2aGMI/Ra5AEUzb2ycCOQMyIznwRTC
   6mKTA5AUhF3WhUDUEczAtg3hYmouCnlPkyfSGMSAm4NAX/o3IM6oSRhjA
   8=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708387200"; 
   d="scan'208";a="395803418"
Subject: Re: [PATCH v7 3/3] virt: vmgenid: add support for devicetree bindings
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:29:57 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:29195]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.106:2525] with esmtp (Farcaster)
 id d6b4dc4e-ffee-486c-9b8f-eaba52ee8581; Fri, 19 Apr 2024 13:29:55 +0000 (UTC)
X-Farcaster-Flow-ID: d6b4dc4e-ffee-486c-9b8f-eaba52ee8581
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 13:29:53 +0000
Received: from [10.95.129.79] (10.95.129.79) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 19 Apr
 2024 13:29:49 +0000
Message-ID: <e4cbb6ab-975a-4d91-9bde-6976b4d84eba@amazon.co.uk>
Date: Fri, 19 Apr 2024 14:29:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <tytso@mit.edu>,
	<robh@kernel.org>, <krzk@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sudanl@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
	<krzysztof.kozlowski@linaro.org>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240418121249.42380-1-Jason@zx2c4.com>
 <20240418121249.42380-4-Jason@zx2c4.com>
Content-Language: en-US
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240418121249.42380-4-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 18/04/2024 13:12, Jason A. Donenfeld wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> From: Sudan Landge <sudanl@amazon.com>
> 
> Extend the vmgenid platform driver to support devicetree bindings. With
> this support, hypervisors can send vmgenid notifications to the virtual
> machine without the need to enable ACPI. The bindings are located at:
> Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 
> Since this makes the driver work for both ACPI and devicetree, adjust
> the Kconfig to include `|| OF`, which in turn means accounting for
> !CONFIG_ACPI in the code with a short ifdef.
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> [Jason: - Small style cleanups and refactoring.
>          - Fold in Kconfig OF dependency and ACPI conditionalization. ]
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   drivers/virt/Kconfig   |  2 +-
>   drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 40129b6f0eca..017d6c38c3ba 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -16,7 +16,7 @@ if VIRT_DRIVERS
>   config VMGENID
>          tristate "Virtual Machine Generation ID driver"
>          default y
> -       depends on ACPI
> +       depends on ACPI || OF

Version 2 of the patches had these flag but were removed in version3 
following the below review comment from Rob:
"One of those is pretty much always enabled, so it can probably be dropped."
reference : 
https://lore.kernel.org/lkml/CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com/


>          help
>            Say Y here to use the hypervisor-provided Virtual Machine Generation ID
>            to reseed the RNG when the VM is cloned. This is highly recommended if
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index aebbd24512c9..7f2d1e5656df 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -2,12 +2,13 @@
>   /*
>    * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>    *
> - * The "Virtual Machine Generation ID" is exposed via ACPI and changes when a
> + * The "Virtual Machine Generation ID" is exposed via ACPI or DT and changes when a
>    * virtual machine forks or is cloned. This driver exists for shepherding that
>    * information to random.c.
>    */
> 
>   #include <linux/acpi.h>
> +#include <linux/interrupt.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -41,6 +42,7 @@ static void setup_vmgenid_state(struct vmgenid_state *state, void *virt_addr)
>          add_device_randomness(state->this_id, sizeof(state->this_id));
>   }
> 
> +#ifdef CONFIG_ACPI
>   static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
>                                   u32 __always_unused event, void *dev)
>   {
> @@ -92,6 +94,43 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>          ACPI_FREE(parsed.pointer);
>          return ret;
>   }
> +#else
> +static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
> +{
> +       return -EINVAL;
> +}
> +#endif
> +
> +static irqreturn_t vmgenid_of_irq_handler(int __always_unused irq, void *dev)
> +{
> +       vmgenid_notify(dev);
> +       return IRQ_HANDLED;
> +}
> +
> +static int vmgenid_add_of(struct platform_device *pdev,
> +                         struct vmgenid_state *state)
> +{
> +       void *virt_addr;
> +       int ret;
> +
> +       virt_addr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +       if (IS_ERR(virt_addr))
> +               return PTR_ERR(virt_addr);
> +
> +       setup_vmgenid_state(state, virt_addr);
> +
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_request_irq(&pdev->dev, ret, vmgenid_of_irq_handler,
> +                              IRQF_SHARED, "vmgenid", &pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       pdev->dev.driver_data = state;
> +       return 0;
> +}
> 
>   static int vmgenid_add(struct platform_device *pdev)
>   {
> @@ -103,13 +142,22 @@ static int vmgenid_add(struct platform_device *pdev)
>          if (!state)
>                  return -ENOMEM;
> 
> -       ret = vmgenid_add_acpi(dev, state);
> +       if (dev->of_node)
> +               ret = vmgenid_add_of(pdev, state);
> +       else
> +               ret = vmgenid_add_acpi(dev, state);
> 
>          if (ret)
>                  devm_kfree(dev, state);
>          return ret;
>   }
> 
> +static const struct of_device_id vmgenid_of_ids[] = {
> +       { .compatible = "microsoft,vmgenid", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
> +
>   static const struct acpi_device_id vmgenid_acpi_ids[] = {
>          { "VMGENCTR", 0 },
>          { "VM_GEN_COUNTER", 0 },
> @@ -122,6 +170,7 @@ static struct platform_driver vmgenid_plaform_driver = {
>          .driver     = {
>                  .name   = "vmgenid",
>                  .acpi_match_table = vmgenid_acpi_ids,
> +               .of_match_table = vmgenid_of_ids,
>          },
>   };
> 
> --
> 2.44.0
> 
Since I am on leave, looping in Babis to review/verify the patches.

