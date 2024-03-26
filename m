Return-Path: <linux-kernel+bounces-119113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CA88C457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D30292F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697F7690E;
	Tue, 26 Mar 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="ewvPuf3l"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E87581E;
	Tue, 26 Mar 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461716; cv=none; b=NdikTxnqaWCzKXUUddKONidD0vKR0pZVawsq/SvyravbKXZmksRhsEmMc6bNx9OzbyFykLBzCUjYc001490VONGUgjPxehDQbt1jQwQwXYJkxG3qxsxCy+i0ZUxgMt6pNrwD3/oC3OKNSHlU1/bvEUnbgo1Eqi91w1nTMdmHyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461716; c=relaxed/simple;
	bh=hMHItk2m311pSWCkPOIhJ5JOratlunprHzBxqNSXMpA=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fCSNZII9RH4oPjqyu5c1pHrGC4oGz75267cYyzfSNF958rJVNsXB4NKdwtxeMPaEd448sgcGfclskwPXwAsEJXh2lpjtgxIzxu6obADKZp4J63PMGkQUiyTzaqpe+Wfb5fPG6KVJg2ng3MZF8kCtTwHPIqMGLnNm+RkZlXKOPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ewvPuf3l; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1711461715; x=1742997715;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=JSHRkHBz+jp0fhqdOTOdAOyvdd0jMcmTPtrugcnjr68=;
  b=ewvPuf3lp/M6Juh4eM4s9Nh/Bb3ZaEBWJZT2nw6AF7UM1QTb0yCBSotd
   GV4UopgL126k3vyvcBJpAwl2jvDXNrnryt4B1c3XDVM5fhAOSHaXepuDU
   OeSDcq0kXUC5v4fcKpfU0AqQ1+/4tNsjMMA6oElm2i34rTV8a59nYwow3
   w=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="713870598"
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:01:43 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:16580]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.17:2525] with esmtp (Farcaster)
 id 78a112dd-3dfb-4990-8b23-24be94370d6e; Tue, 26 Mar 2024 14:01:42 +0000 (UTC)
X-Farcaster-Flow-ID: 78a112dd-3dfb-4990-8b23-24be94370d6e
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 14:01:39 +0000
Received: from [192.168.18.216] (10.106.83.18) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 14:01:34 +0000
Message-ID: <7932459d-4dae-4a29-b702-5103d853dbdd@amazon.co.uk>
Date: Tue, 26 Mar 2024 14:01:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sudan Landge
	<sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240325195306.13133-1-sudanl@amazon.com>
 <20240325195306.13133-5-sudanl@amazon.com>
 <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 25/03/2024 21:51, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 25/03/2024 20:53, Sudan Landge wrote:
>> - Extend the vmgenid platform driver to support devicetree bindings.
>>    With this support, hypervisors can send vmgenid notifications to
>>    the virtual machine without the need to enable ACPI. The bindings
>>    are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml
>>
>> - Use proper FLAGS to compile with and without ACPI and/or devicetree.
> 
> I do not see any flags. You use if/ifdefs which is a NAK.
> 
> Do not mix independent changes within one commit. Please follow
> guidelines in submitting-patches for this.
> 
By flags, I was referring to "#if IS_ENABLED(CONFIG_ACPI)". I will 
remove the comment if its incorrect.


>>
>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>> ---
>>   drivers/virt/Kconfig   |  1 -
>>   drivers/virt/vmgenid.c | 85 +++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 80 insertions(+), 6 deletions(-)
>>
> 
> ...
> 
>> +
>> +#if IS_ENABLED(CONFIG_OF)
>> +static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
>> +{
>> +     (void)irq;
>> +     vmgenid_notify(dev);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +#endif
>>
>>   static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>>   {
>> @@ -55,6 +70,7 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>>
>>   static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>>   {
>> +#if IS_ENABLED(CONFIG_ACPI)
> 
> Why do you create all this ifdeffery in the code? You already got
> comments to get rid of all this #if.
> 
This was added to avoid errors if CONFIG_ACPI or CONFIG_OF was not 
enabled. I will refer to other drivers again to see how they handle this.


>>        struct acpi_device *device = ACPI_COMPANION(dev);
>>        struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
>>        union acpi_object *obj;
>> @@ -96,6 +112,49 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
>>   out:
>>        ACPI_FREE(parsed.pointer);
>>        return ret;
>> +#else
>> +     (void)dev;
>> +     (void)state;
>> +     return -EINVAL;
>> +#endif
>> +}
>> +
>> +static int vmgenid_add_of(struct platform_device *pdev, struct vmgenid_state *state)
>> +{
>> +#if IS_ENABLED(CONFIG_OF)
>> +     void __iomem *remapped_ptr;
>> +     int ret = 0;
>> +
>> +     remapped_ptr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>> +     if (IS_ERR(remapped_ptr)) {
>> +             ret = PTR_ERR(remapped_ptr);
>> +             goto out;
>> +     }
>> +
>> +     ret = setup_vmgenid_state(state, remapped_ptr);
>> +     if (ret)
>> +             goto out;
>> +
>> +     state->irq = platform_get_irq(pdev, 0);
>> +     if (state->irq < 0) {
>> +             ret = state->irq;
>> +             goto out;
>> +     }
>> +     pdev->dev.driver_data = state;
>> +
>> +     ret =  devm_request_irq(&pdev->dev, state->irq,
>> +                             vmgenid_of_irq_handler,
>> +                             IRQF_SHARED, "vmgenid", &pdev->dev);
>> +     if (ret)
>> +             pdev->dev.driver_data = NULL;
>> +
>> +out:
>> +     return ret;
>> +#else
> 
> 
> That's neither readable code nor matching Linux coding style. Driver
> don't do such magic. Please open some recent drivers for ACPI and OF and
> look there. Old drivers had stubs for !CONFIG_XXX, but new drivers don't
> have even that.
> 
Sorry about that, I will refer to a new driver and correct this.


>> +     (void)dev;
>> +     (void)state;
>> +     return -EINVAL;
>> +#endif
>>   }
>>
>>   static int vmgenid_add(struct platform_device *pdev)
>> @@ -108,7 +167,10 @@ static int vmgenid_add(struct platform_device *pdev)
>>        if (!state)
>>                return -ENOMEM;
>>
>> -     ret = vmgenid_add_acpi(dev, state);
>> +     if (dev->of_node)
>> +             ret = vmgenid_add_of(pdev, state);
>> +     else
>> +             ret = vmgenid_add_acpi(dev, state);
>>
>>        if (ret)
>>                devm_kfree(dev, state);
>> @@ -116,18 +178,31 @@ static int vmgenid_add(struct platform_device *pdev)
>>        return ret;
>>   }
>>
>> -static const struct acpi_device_id vmgenid_ids[] = {
>> +#if IS_ENABLED(CONFIG_OF)
> 
> No, drop.
> 
>> +static const struct of_device_id vmgenid_of_ids[] = {
>> +     { .compatible = "linux,vmgenctr", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
>> +#endif
>> +
>> +#if IS_ENABLED(CONFIG_ACPI)
> 
> 
>> +static const struct acpi_device_id vmgenid_acpi_ids[] = {
>>        { "VMGENCTR", 0 },
>>        { "VM_GEN_COUNTER", 0 },
>>        { }
>>   };
>> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
>> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
>> +#endif
>>
>>   static struct platform_driver vmgenid_plaform_driver = {
>>        .probe      = vmgenid_add,
>>        .driver     = {
>>                .name   = "vmgenid",
>> -             .acpi_match_table = ACPI_PTR(vmgenid_ids),
>> +             .acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
>> +#if IS_ENABLED(CONFIG_OF)
> 
> No, really, this is some ancient code.
> 
> Please point me to single driver doing such ifdef.
> 
>> +             .of_match_table = vmgenid_of_ids,
>> +#endif
>>                .owner = THIS_MODULE,
> 
> This is clearly some abandoned driver... sigh... I thought we get rid of
> all this owner crap. Many years ago. How could it appear back if
> automated tools report it?
> 
> Considering how many failures LKP reported for your patchsets, I have
> real doubts that anyone actually tests this code.
> 
> Please confirm:
> Did you build W=1, run smatch, sparse and coccinelle on the driver after
> your changes?
> 
> Best regards,
> Krzysztof
> 

I built with W=1 but wasn't aware of the other tools. I will make sure 
to run all the above before submitting any future patches.

