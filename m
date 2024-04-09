Return-Path: <linux-kernel+bounces-137437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3082E89E223
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE01C22027
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9A156973;
	Tue,  9 Apr 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="vIvdrfsn"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998B156883;
	Tue,  9 Apr 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686057; cv=none; b=s19h2XwKNTjyq2UTBYaCGV7L5ztRpSp8dCytiIKsIDbgZ9osBOdoS70CqGpRIWqPstsAGXschaOHYcemsP+LWrJEsaSHtkiuJc9nId/ZQW5EuDTAKpDu6AaLupj9DnfTK5lnhj9Id+LhGVqhS44bZ4NFJ/64QBIxB0Q1VdknQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686057; c=relaxed/simple;
	bh=wDHMOgkIcX9zNBekPyozvORWu7pLCVlon2Jq1iysZkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hVEkvrwNCHM2hNnd2/TzXsqMDglkTXW1Ubem8aS2zjd2PVocwnrkap1MPoGe+FR0LK+4StBYXNaVHQxoLxa0pqm4OSF9bT1S9GDpfdzTfRfDClWzOyjq4OiKHMgXcu2JNLTcA7oEgIPc/Z9kE9Y4GDQBT2eprmRC0voJK5HcWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=vIvdrfsn; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1712686056; x=1744222056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LUnxFMCJbP/TXFkTWkhYoNXpbsm6oQaeQbjA1rI+i1E=;
  b=vIvdrfsnSroOU3ZodmZB+hR2FYNr+pfm0C2/faWruG0HNxyDJgjR6eyu
   YxRngf3g48/RDHWg7yfKRhESbZ9A7Xxj30tFkWGtS+irY/r8sLVPv6w+g
   ocwxHIlwO4Bqwaybo4fCq+sieMzxBz5ZpnpMTFGYvllhI4bOHkyuJ747x
   I=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="650816447"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:07:32 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:41501]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.48:2525] with esmtp (Farcaster)
 id 04d050b4-5579-4172-8b50-2a9616ef79f9; Tue, 9 Apr 2024 18:07:30 +0000 (UTC)
X-Farcaster-Flow-ID: 04d050b4-5579-4172-8b50-2a9616ef79f9
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:07:30 +0000
Received: from [10.95.97.144] (10.95.97.144) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 9 Apr
 2024 18:07:25 +0000
Message-ID: <8eb80918-f3e8-4c02-837d-8950ac14b654@amazon.co.uk>
Date: Tue, 9 Apr 2024 19:07:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] virt: vmgenid: add support for devicetree bindings
Content-Language: en-US
To: Sudan Landge <sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240409170722.81738-1-sudanl@amazon.com>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240409170722.81738-1-sudanl@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 09/04/2024 18:07, Sudan Landge wrote:
> Extend the vmgenid platform driver to support devicetree bindings.
> With this support, hypervisors can send vmgenid notifications to
> the virtual machine without the need to enable ACPI.
> The bindings are located at:
> Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>   drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index 3d93e3fb94c4..e1ad74116c0c 100644
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
> @@ -20,6 +21,7 @@ enum { VMGENID_SIZE = 16 };
>   struct vmgenid_state {
>   	u8 *next_id;
>   	u8 this_id[VMGENID_SIZE];
> +	int irq;
>   };
>   
>   static void vmgenid_notify(struct device *device)
> @@ -43,6 +45,14 @@ vmgenid_acpi_handler(acpi_handle __always_unused handle,
>   	vmgenid_notify(dev);
>   }
>   
> +static __maybe_unused irqreturn_t
> +vmgenid_of_irq_handler(int __always_unused irq, void *dev)
> +{
> +	vmgenid_notify(dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int __maybe_unused
>   setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
>   {
> @@ -106,6 +116,35 @@ static int vmgenid_add_acpi(struct device __maybe_unused *dev,
>   #endif
>   }
>   
> +static int vmgenid_add_of(struct platform_device *pdev,
> +			  struct vmgenid_state *state)
> +{
> +	u8 *virt_addr;
> +	int ret = 0;
> +
> +	virt_addr = (u8 *)devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(virt_addr))
> +		return PTR_ERR(virt_addr);
> +
> +	ret = setup_vmgenid_state(state, virt_addr);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	state->irq = ret;
> +	pdev->dev.driver_data = state;
> +
> +	ret = devm_request_irq(&pdev->dev, state->irq, vmgenid_of_irq_handler,
> +			       IRQF_SHARED, "vmgenid", &pdev->dev);
> +	if (ret)
> +		pdev->dev.driver_data = NULL;
> +
> +	return ret;
> +}
> +
>   static int vmgenid_add(struct platform_device *pdev)
>   {
>   	struct vmgenid_state *state;
> @@ -116,7 +155,10 @@ static int vmgenid_add(struct platform_device *pdev)
>   	if (!state)
>   		return -ENOMEM;
>   
> -	ret = vmgenid_add_acpi(dev, state);
> +	if (dev->of_node)
> +		ret = vmgenid_add_of(pdev, state);
> +	else
> +		ret = vmgenid_add_acpi(dev, state);
>   
>   	if (ret)
>   		devm_kfree(dev, state);
> @@ -124,6 +166,12 @@ static int vmgenid_add(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static const struct of_device_id vmgenid_of_ids[] = {
> +	{ .compatible = "microsoft,vmgenid", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
> +
>   static const struct acpi_device_id vmgenid_acpi_ids[] = {
>   	{ "VMGENCTR", 0 },
>   	{ "VM_GEN_COUNTER", 0 },
> @@ -136,6 +184,7 @@ static struct platform_driver vmgenid_plaform_driver = {
>   	.driver     = {
>   		.name   = "vmgenid",
>   		.acpi_match_table = vmgenid_acpi_ids,
> +		.of_match_table = vmgenid_of_ids,
>   	},
>   };
>   
Due to a mail server error this last patch of the vmgenid series, 
"[PATCH v4 0/5] virt: vmgenid: Add devicetree bindings support", got 
sent separately. Apologies for this. I will resend the patches to 
correct this issue so, I request reviewers to please ignore this patch.

