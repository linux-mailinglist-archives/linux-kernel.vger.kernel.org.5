Return-Path: <linux-kernel+bounces-151476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE548AAF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA931C22725
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB7128811;
	Fri, 19 Apr 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="f9F5ZjRz"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC934622;
	Fri, 19 Apr 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533476; cv=none; b=CrFsnk7h3T4BK4a8Roxm7lXZwStTCLZW2yOWBhLMkwgzKDnmzhCtdFb+AKDAbt8nD+PL/yXnQADe1VhOIzUwoxWSjWVvtmcnj+JPuJAD/uCl3ppoYq9POEXuFqld63HeHqacqn0fe4j5YUNMcn6PLxCE8RpO4G9ELt/jEZoXauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533476; c=relaxed/simple;
	bh=MKLy1nOKTDFc8dsBKuG3R0ky9Pb5R4lWzuIXYhfRoLY=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=uVym4CRkq5OAapKtdHJf+8OBGdt0XRji1NIB7L24kKJy1JcJAX73XFerjPyhppiPbjUe8EBBBkC/O8oFjA6/Whwv2HuFWvpVJ4FPKkAbvJPi1LZL6Hqw4qD3AXj9hfuZHqXGwF70UdgxFucvl35i524mJ41yXfSTCsomkPfwQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=f9F5ZjRz; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1713533475; x=1745069475;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=jm5k1fRlfOALCTcLiHCS05FCjJqslPETyYkDOKsQeqA=;
  b=f9F5ZjRzlSZduy3VRCaHBez7kcwiUpAgm4YMxOS3KVtBu2MRireZ3ufh
   VTs5HfGeeHQgBWH6E+44W1PRJx8qPoCA3/w6K3vALqAe/4WhRFyZLAq79
   O2p65Z3nUHEnZ4Oi/Reo7Nn9dfqcMgmCiV+Iy9DLstVN+zr1AwRY3BWSR
   A=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708387200"; 
   d="scan'208";a="395803630"
Subject: Re: [PATCH v7 1/3] virt: vmgenid: change implementation to use a platform
 driver
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:31:14 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:32866]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.106:2525] with esmtp (Farcaster)
 id 4a97f6b4-fb2d-4102-ac73-5f32c0f927ac; Fri, 19 Apr 2024 13:31:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4a97f6b4-fb2d-4102-ac73-5f32c0f927ac
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 13:31:12 +0000
Received: from [10.95.129.79] (10.95.129.79) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 19 Apr
 2024 13:31:07 +0000
Message-ID: <3d4aa16f-ba12-4efe-bdfc-4e7ef059e09d@amazon.co.uk>
Date: Fri, 19 Apr 2024 14:31:02 +0100
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
 <20240418121249.42380-2-Jason@zx2c4.com>
Content-Language: en-US
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240418121249.42380-2-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 18/04/2024 13:12, Jason A. Donenfeld wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> From: Sudan Landge <sudanl@amazon.com>
> 
> Re-implement vmgenid as a platform driver in preparation for adding
> devicetree bindings support in next commits.
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> [Jason: - Small style cleanups and refactoring.]
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   drivers/virt/vmgenid.c | 99 +++++++++++++++++++++++++++---------------
>   1 file changed, 65 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index a1c467a0e9f7..aebbd24512c9 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -7,9 +7,10 @@
>    * information to random.c.
>    */
> 
> +#include <linux/acpi.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> -#include <linux/acpi.h>
> +#include <linux/platform_device.h>
>   #include <linux/random.h>
> 
>   ACPI_MODULE_NAME("vmgenid");
> @@ -21,19 +22,41 @@ struct vmgenid_state {
>          u8 this_id[VMGENID_SIZE];
>   };
> 
> -static int vmgenid_add(struct acpi_device *device)
> +static void vmgenid_notify(struct device *device)
> +{
> +       struct vmgenid_state *state = device->driver_data;
> +       u8 old_id[VMGENID_SIZE];
> +
> +       memcpy(old_id, state->this_id, sizeof(old_id));
> +       memcpy(state->this_id, state->next_id, sizeof(state->this_id));
> +       if (!memcmp(old_id, state->this_id, sizeof(old_id)))
> +               return;
> +       add_vmfork_randomness(state->this_id, sizeof(state->this_id));
> +}
> +
> +static void setup_vmgenid_state(struct vmgenid_state *state, void *virt_addr)
>   {
> +       state->next_id = virt_addr;
> +       memcpy(state->this_id, state->next_id, sizeof(state->this_id));
> +       add_device_randomness(state->this_id, sizeof(state->this_id));
> +}
> +
> +static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
> +                                u32 __always_unused event, void *dev)
> +{
> +       vmgenid_notify(dev);
> +}
> +
> +static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
> +{
> +       struct acpi_device *device = ACPI_COMPANION(dev);
>          struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
> -       struct vmgenid_state *state;
>          union acpi_object *obj;
>          phys_addr_t phys_addr;
>          acpi_status status;
> +       void *virt_addr;
>          int ret = 0;
> 
> -       state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
> -       if (!state)
> -               return -ENOMEM;
> -
>          status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
>          if (ACPI_FAILURE(status)) {
>                  ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
> @@ -49,53 +72,61 @@ static int vmgenid_add(struct acpi_device *device)
> 
>          phys_addr = (obj->package.elements[0].integer.value << 0) |
>                      (obj->package.elements[1].integer.value << 32);
> -       state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
> -       if (IS_ERR(state->next_id)) {
> -               ret = PTR_ERR(state->next_id);
> +
> +       virt_addr = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
> +       if (IS_ERR(virt_addr)) {
> +               ret = PTR_ERR(virt_addr);
>                  goto out;
>          }
> +       setup_vmgenid_state(state, virt_addr);
> 
> -       memcpy(state->this_id, state->next_id, sizeof(state->this_id));
> -       add_device_randomness(state->this_id, sizeof(state->this_id));
> -
> -       device->driver_data = state;
> +       status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +                                            vmgenid_acpi_handler, dev);
> +       if (ACPI_FAILURE(status)) {
> +               ret = -ENODEV;
> +               goto out;
> +       }
> 
> +       dev->driver_data = state;
>   out:
>          ACPI_FREE(parsed.pointer);
>          return ret;
>   }
> 
> -static void vmgenid_notify(struct acpi_device *device, u32 event)
> +static int vmgenid_add(struct platform_device *pdev)
>   {
> -       struct vmgenid_state *state = acpi_driver_data(device);
> -       u8 old_id[VMGENID_SIZE];
> +       struct vmgenid_state *state;
> +       struct device *dev = &pdev->dev;
> +       int ret = 0;
> 
> -       memcpy(old_id, state->this_id, sizeof(old_id));
> -       memcpy(state->this_id, state->next_id, sizeof(state->this_id));
> -       if (!memcmp(old_id, state->this_id, sizeof(old_id)))
> -               return;
> -       add_vmfork_randomness(state->this_id, sizeof(state->this_id));
> +       state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
> +       if (!state)
> +               return -ENOMEM;
> +
> +       ret = vmgenid_add_acpi(dev, state);
> +
> +       if (ret)
> +               devm_kfree(dev, state);
> +       return ret;
>   }
> 
> -static const struct acpi_device_id vmgenid_ids[] = {
> +static const struct acpi_device_id vmgenid_acpi_ids[] = {
>          { "VMGENCTR", 0 },
>          { "VM_GEN_COUNTER", 0 },
>          { }
>   };
> -
> -static struct acpi_driver vmgenid_driver = {
> -       .name = "vmgenid",
> -       .ids = vmgenid_ids,
> -       .owner = THIS_MODULE,
> -       .ops = {
> -               .add = vmgenid_add,
> -               .notify = vmgenid_notify
> -       }
> +MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
> +
> +static struct platform_driver vmgenid_plaform_driver = {
> +       .probe      = vmgenid_add,
> +       .driver     = {
> +               .name   = "vmgenid",
> +               .acpi_match_table = vmgenid_acpi_ids,
> +       },
>   };
> 
> -module_acpi_driver(vmgenid_driver);
> +module_platform_driver(vmgenid_plaform_driver)
> 
> -MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
>   MODULE_DESCRIPTION("Virtual Machine Generation ID");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
> --
> 2.44.0
> 
Since I am on leave, looping in Babis to review/verify the patches.

