Return-Path: <linux-kernel+bounces-147152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6F8A7029
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E74E1C21116
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A524131726;
	Tue, 16 Apr 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="cR76Hz4l"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BC53E15;
	Tue, 16 Apr 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282601; cv=none; b=Ri3ZWOS8ZdaMQmpy+uP0XBRlmh0twGVIdB7WXMD7Yv4/TSaKd1wr3WBteznpk75MWfTA4PLgNdLax56iFOnc7r66OosDjZytvMSPrW7ZwjdXbBJI3nhUEg+sskxzUIfMPlNlQEj1NS1RI8/4JGTJ9lwxFuvKlHi2JoZDJ8YA9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282601; c=relaxed/simple;
	bh=DeIGpI4J2s2bhWdutKdlfr6mBJvVRwiz0KjAewxS9Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ErIaq/sqTTYsvjYBYL1keLq3Vi2xw2nz8xDXVL1lYXmiMyVxzFB55EozjELXlNJHW4UeTNeX68VvmdZN7ycAOV9JWIgEURW8IFk0ZN3mVqE7o1+PW7JvlZy38deha3bWsRIJyL60kBSWljAeH4MktE0MipN+jP/oLcXglOnoWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=cR76Hz4l; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713282600; x=1744818600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mntj+fXN5a54sfKhFM7PgZmUZBd4LjjmIWz6DPtP244=;
  b=cR76Hz4lHUXTv4GVGcQCfraJJIYZKfUz8cLSjpuCV1JMKOc2LV1b+8zY
   zDcENoS6Zg3quZr6BJOMTNK5lbh3h3B4lTG9rDHI9UDJUotiVMAynekWl
   PLZ1SiUDiec7JREeGm7qq06lzc3SYJLC3V6lQcDeZPCTfB9JhUWj2ZkaZ
   U=;
X-IronPort-AV: E=Sophos;i="6.07,206,1708387200"; 
   d="scan'208";a="652346720"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:49:58 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:17357]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.180:2525] with esmtp (Farcaster)
 id c30e20ed-742d-4336-9503-02da0bb74705; Tue, 16 Apr 2024 15:49:56 +0000 (UTC)
X-Farcaster-Flow-ID: c30e20ed-742d-4336-9503-02da0bb74705
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 15:49:56 +0000
Received: from [192.168.224.251] (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 15:49:51 +0000
Message-ID: <c4caca2d-8840-4ed5-b580-f984bd0ee5cd@amazon.es>
Date: Tue, 16 Apr 2024 17:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] virt: vmgenid: add support for devicetree bindings
To: Alexander Graf <graf@amazon.de>, Sudan Landge <sudanl@amazon.com>,
	<tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <thomas.lendacky@amd.com>,
	<dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dwmw@amazon.co.uk>, <xmarcalx@amazon.co.uk>
References: <20240409181154.9962-1-sudanl@amazon.com>
 <20240409181154.9962-6-sudanl@amazon.com>
 <1e4fad99-76d4-4c45-a924-b78b597c7cd6@amazon.de>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
Autocrypt: addr=bchalios@amazon.es; keydata=
 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
In-Reply-To: <1e4fad99-76d4-4c45-a924-b78b597c7cd6@amazon.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)



On 16/4/24 12:49, Alexander Graf wrote:
>
> On 09.04.24 20:11, Sudan Landge wrote:
>> Extend the vmgenid platform driver to support devicetree bindings.
>> With this support, hypervisors can send vmgenid notifications to
>> the virtual machine without the need to enable ACPI.
>> The bindings are located at:
>> Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
>>
>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>> ---
>>   drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
>> index 3d93e3fb94c4..e1ad74116c0c 100644
>> --- a/drivers/virt/vmgenid.c
>> +++ b/drivers/virt/vmgenid.c
>> @@ -2,12 +2,13 @@
>>   /*
>>    * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All 
>> Rights Reserved.
>>    *
>> - * The "Virtual Machine Generation ID" is exposed via ACPI and 
>> changes when a
>> + * The "Virtual Machine Generation ID" is exposed via ACPI or DT and 
>> changes when a
>>    * virtual machine forks or is cloned. This driver exists for 
>> shepherding that
>>    * information to random.c.
>>    */
>>     #include <linux/acpi.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> @@ -20,6 +21,7 @@ enum { VMGENID_SIZE = 16 };
>>   struct vmgenid_state {
>>       u8 *next_id;
>>       u8 this_id[VMGENID_SIZE];
>> +    int irq;
>>   };
>>     static void vmgenid_notify(struct device *device)
>> @@ -43,6 +45,14 @@ vmgenid_acpi_handler(acpi_handle __always_unused 
>> handle,
>>       vmgenid_notify(dev);
>>   }
>>   +static __maybe_unused irqreturn_t
>
>
> Why is this maybe_unused? It seems to be always referenced by 
> vmgenid_add_of(), no?

You are right, Alex. I removed the attribute and build the kernel 
without `CONFIG_OF`
without any warnings. I will remove it in the next version.

>
>
>> +vmgenid_of_irq_handler(int __always_unused irq, void *dev)
>> +{
>> +    vmgenid_notify(dev);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>>   static int __maybe_unused
>>   setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>>   {
>> @@ -106,6 +116,35 @@ static int vmgenid_add_acpi(struct device 
>> __maybe_unused *dev,
>>   #endif
>>   }
>>   +static int vmgenid_add_of(struct platform_device *pdev,
>> +              struct vmgenid_state *state)
>> +{
>> +    u8 *virt_addr;
>> +    int ret = 0;
>> +
>> +    virt_addr = (u8 *)devm_platform_get_and_ioremap_resource(pdev, 
>> 0, NULL);
>> +    if (IS_ERR(virt_addr))
>> +        return PTR_ERR(virt_addr);
>> +
>> +    ret = setup_vmgenid_state(state, virt_addr);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = platform_get_irq(pdev, 0);
>> +    if (ret < 0)
>> +        return ret;
>
>
> Doesn't this error path need to do something about the ioremap'ed 
> resource? Or does devm do that automatically for you?

devm should be doing this automatically according to this:
https://docs.kernel.org/driver-api/driver-model/devres.html#devres

Also, I took a quick look in other drivers and it looks like the virtio-mmio
probe callback follows the same pattern:
https://elixir.bootlin.com/linux/latest/source/drivers/virtio/virtio_mmio.c#L636

Cheers,
Babis

>
> Alex
>
>
>> +
>> +    state->irq = ret;
>> +    pdev->dev.driver_data = state;
>> +
>> +    ret = devm_request_irq(&pdev->dev, state->irq, 
>> vmgenid_of_irq_handler,
>> +                   IRQF_SHARED, "vmgenid", &pdev->dev);
>> +    if (ret)
>> +        pdev->dev.driver_data = NULL;
>> +
>> +    return ret;
>> +}
>> +
>>   static int vmgenid_add(struct platform_device *pdev)
>>   {
>>       struct vmgenid_state *state;
>> @@ -116,7 +155,10 @@ static int vmgenid_add(struct platform_device 
>> *pdev)
>>       if (!state)
>>           return -ENOMEM;
>>   -    ret = vmgenid_add_acpi(dev, state);
>> +    if (dev->of_node)
>> +        ret = vmgenid_add_of(pdev, state);
>> +    else
>> +        ret = vmgenid_add_acpi(dev, state);
>>         if (ret)
>>           devm_kfree(dev, state);
>> @@ -124,6 +166,12 @@ static int vmgenid_add(struct platform_device 
>> *pdev)
>>       return ret;
>>   }
>>   +static const struct of_device_id vmgenid_of_ids[] = {
>> +    { .compatible = "microsoft,vmgenid", },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
>> +
>>   static const struct acpi_device_id vmgenid_acpi_ids[] = {
>>       { "VMGENCTR", 0 },
>>       { "VM_GEN_COUNTER", 0 },
>> @@ -136,6 +184,7 @@ static struct platform_driver 
>> vmgenid_plaform_driver = {
>>       .driver     = {
>>           .name   = "vmgenid",
>>           .acpi_match_table = vmgenid_acpi_ids,
>> +        .of_match_table = vmgenid_of_ids,
>>       },
>>   };


