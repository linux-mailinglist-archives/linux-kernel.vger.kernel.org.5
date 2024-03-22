Return-Path: <linux-kernel+bounces-111837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB4887181
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1FA1C22236
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC565E3AF;
	Fri, 22 Mar 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="RKc3bki9"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E435B693;
	Fri, 22 Mar 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126990; cv=none; b=uFPPGmZmmJ9QTWx/f4zJxV8FomxBfsYWnugsXoIBK9YqvSjnlDlc7B3+YYvjtRRg5wUuvTAU/9EPwMf+YCKmu2H6gKMRkJw4KQ5/L3KNAqths4Lu17oJ2v/Cl4jo0hBrgBn+df3xNs9tkTBWYSmANZTqls7CqbD4ai1Vest4+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126990; c=relaxed/simple;
	bh=whO5xlE9l9VrxhZ+zhVXYaY5wUhRvmESHPyAmOeuVNs=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lt3kARiMoZASKB7Jk9mHtOv6nIJkWk74Kmob9Db4MFrydBVvueo2r+cEtVS+xRL/b0iJoHgKDP7NC5zdqbfCf5Vz+epFNKfRQivfC8W5DVnUXuaeOQ8i2l7htwZpruL/sEFKD94wSLrM2bqPwLavlrCTIf1VM9IX32gXoCQ718k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=RKc3bki9; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711126989; x=1742662989;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=igXfILxGuZIf/qoxGj8P4xdJtdqBLE5YgRa9kN3CN24=;
  b=RKc3bki9CHNNqp+mFa1nRznMQezLKpbltlrJ7trU/KX3a5Yo1Ujb+fTO
   /s2KHqQvd6tHtzH/g23HdpF/b8OSvI4J1CiqPI0qock8kWJbZMa+W+UC4
   EqeZdWnJL/3CeVMV5Fv4q4DUsGZowIAuaW6mVFitgIJ/qvsVcNjENZbBY
   I=;
X-IronPort-AV: E=Sophos;i="6.07,146,1708387200"; 
   d="scan'208";a="283104278"
Subject: Re: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 17:03:06 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:14926]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.234:2525] with esmtp (Farcaster)
 id fe5178a3-8f2e-473e-acdf-9586c70fba1d; Fri, 22 Mar 2024 17:03:05 +0000 (UTC)
X-Farcaster-Flow-ID: fe5178a3-8f2e-473e-acdf-9586c70fba1d
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 17:03:05 +0000
Received: from [192.168.15.170] (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 17:03:00 +0000
Message-ID: <2920d0d6-30a2-4e07-87c5-7b403dce269b@amazon.co.uk>
Date: Fri, 22 Mar 2024 17:02:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Sudan Landge <sudanl@amazon.com>
CC: <tytso@mit.edu>, <Jason@zx2c4.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240321025105.53210-1-sudanl@amazon.com>
 <20240321025105.53210-5-sudanl@amazon.com>
 <CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 22/03/2024 13:33, Rob Herring wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Mar 20, 2024 at 9:51 PM Sudan Landge <sudanl@amazon.com> wrote:
>>
>> - Extend the vmgenid platform driver to support devicetree bindings.
>>    With this support, hypervisors can send vmgenid notifications to
>>    the virtual machine without the need to enable ACPI. The bindings
>>    are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml
>>
>> - Use proper FLAGS to compile with and without ACPI and/or devicetree.
>>
>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>> ---
>>   drivers/virt/Kconfig   |   2 +-
>>   drivers/virt/vmgenid.c | 106 ++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 101 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 40129b6f0eca..4f33ee2f0372 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -16,7 +16,7 @@ if VIRT_DRIVERS
>>   config VMGENID
>>          tristate "Virtual Machine Generation ID driver"
>>          default y
>> -       depends on ACPI
>> +       depends on (ACPI || OF)
> 
> One of those is pretty much always enabled, so it can probably be dropped.
> 
>>          help
>>            Say Y here to use the hypervisor-provided Virtual Machine Generation ID
>>            to reseed the RNG when the VM is cloned. This is highly recommended if
>> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
>> index d5394c706bd9..ec378c37a2a2 100644
>> --- a/drivers/virt/vmgenid.c
>> +++ b/drivers/virt/vmgenid.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>>    *
>> - * The "Virtual Machine Generation ID" is exposed via ACPI and changes when a
>> + * The "Virtual Machine Generation ID" is exposed via ACPI or DT and changes when a
>>    * virtual machine forks or is cloned. This driver exists for shepherding that
>>    * information to random.c.
>>    */
>> @@ -13,14 +13,27 @@
>>   #include <linux/random.h>
>>   #include <acpi/actypes.h>
>>   #include <linux/platform_device.h>
>> -
>> +#ifdef CONFIG_OF
> 
> You don't need nor want ifdefs around includes.
> 
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
> 
> Doubtful you need this header.
> 
>> +#include <linux/of_irq.h>
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
> 
> Probably don't need this.
> 
>>   ACPI_MODULE_NAME("vmgenid");
>> +#endif
>>
>>   enum { VMGENID_SIZE = 16 };
>>
>>   struct vmgenid_state {
>>          u8 *next_id;
>>          u8 this_id[VMGENID_SIZE];
>> +#ifdef CONFIG_OF
> 
> Really worth saving 1 int on ACPI systems?
> 
>> +       unsigned int irq;
>> +#endif
>>   };
>>
>>   static void vmgenid_notify(struct device *device)
>> @@ -37,10 +50,24 @@ static void vmgenid_notify(struct device *device)
>>          kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
>>   }
>>
>> +#ifdef CONFIG_ACPI
> 
> Avoid ifdefs. Use "IS_ENABLED(CONFIG_ACPI)" instead if you must.
> 
>>   static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
>>   {
>> +       (void)handle;
>> +       (void)event;
> 
> I don't think these are ever needed.
> 
>>          vmgenid_notify(dev);
>>   }
>> +#endif
>> +
>> +#ifdef CONFIG_OF
>> +static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
>> +{
>> +       (void)irq;
>> +       vmgenid_notify(dev);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +#endif
>>
>>   static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>>   {
>> @@ -55,6 +82,7 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>>
>>   static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>>   {
>> +#ifdef CONFIG_ACPI
>>          struct acpi_device *device = ACPI_COMPANION(dev);
>>          struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
>>          union acpi_object *obj;
>> @@ -96,6 +124,54 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>>   out:
>>          ACPI_FREE(parsed.pointer);
>>          return ret;
>> +#else
>> +       (void)dev;
>> +       (void)state;
>> +       return -EINVAL;
>> +#endif
>> +}
>> +
>> +static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
>> +{
>> +#ifdef CONFIG_OF
>> +       struct resource res;
>> +       int ret = 0;
>> +
>> +       if (of_address_to_resource(dev->of_node, 0, &res)) {
> 
> No, use the platform_ APIs which work for both ACPI and DT.
> 
>> +               dev_err(dev, "Failed to get resources from device tree");
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       if (!__request_mem_region(res.start, resource_size(&res),
> 
> There's a single API to do this and ioremap. Use it.
> 
>> +                                 "vmgenid", IORESOURCE_EXCLUSIVE)) {
>> +               dev_err(dev, "Failed to request mem region");
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       ret = setup_vmgenid_state(state, (u8 *)of_iomap(dev->of_node, 0));
>> +       if (ret)
>> +               goto out;
>> +
>> +       state->irq = irq_of_parse_and_map(dev->of_node, 0);
> 
> platform_get_irq()
> 
>> +       dev->driver_data = state;
>> +
>> +       if (request_irq(state->irq, vmgenid_of_irq_handler,
>> +                       IRQF_SHARED, "vmgenid", dev) < 0) {
>> +               dev_err(dev, "request_irq failed");
>> +               dev->driver_data = NULL;
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +out:
>> +       return ret;
>> +#else
>> +       (void)dev;
>> +       (void)state;
>> +       return -EINVAL;
>> +#endif
>>   }
>>
>>   static int vmgenid_add(struct platform_device *pdev)
>> @@ -108,7 +184,10 @@ static int vmgenid_add(struct platform_device *pdev)
>>          if (!state)
>>                  return -ENOMEM;
>>
>> -       ret = vmgenid_add_acpi(dev, state);
>> +       if (dev->of_node)
>> +               ret = vmgenid_add_of(dev, state);
>> +       else
>> +               ret = vmgenid_add_acpi(dev, state);
>>
>>          if (ret)
>>                  devm_kfree(dev, state);
>> @@ -116,18 +195,33 @@ static int vmgenid_add(struct platform_device *pdev)
>>          return ret;
>>   }
>>
>> -static const struct acpi_device_id vmgenid_ids[] = {
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id vmgenid_of_ids[] = {
>> +       { .compatible = "linux,vmgenctr", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id vmgenid_acpi_ids[] = {
>>          { "VMGENCTR", 0 },
>>          { "VM_GEN_COUNTER", 0 },
>>          { }
>>   };
>> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
>> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
>> +#endif
>>
>>   static struct platform_driver vmgenid_plaform_driver = {
>>          .probe      = vmgenid_add,
>>          .driver     = {
>>                  .name   = "vmgenid",
>> -               .acpi_match_table = ACPI_PTR(vmgenid_ids),
>> +#ifdef CONFIG_ACPI
>> +               .acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
> 
> Pretty sure you don't need the ifdef AND ACPI_PTR.
> 
>> +#endif
>> +#ifdef CONFIG_OF
>> +               .of_match_table = vmgenid_of_ids,
>> +#endif
>>                  .owner = THIS_MODULE,
>>          },
>>   };
>> --
>> 2.40.1
>>
>>
Thank you for the feedback and sorry for my lack of experience regarding 
the APIs. I will use the alternatives APIs suggested for devicetree and 
revert after thorough testing.

