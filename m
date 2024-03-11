Return-Path: <linux-kernel+bounces-98819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BDE877FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D109C28329F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729743CF7E;
	Mon, 11 Mar 2024 12:21:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFD3D566;
	Mon, 11 Mar 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159703; cv=none; b=Smqh1yPln8Vp9ze4JKcA54UTo/sAobHZBHZbm1UgH2n2ASnXqTwOJxhTqTOE8lTEr20wSF8Np0FzPWY8dJLswBqhO54rmVSGlwnwfr3PGQNASe+7YVUeHnYRPnvOjVuvdRv56L01FLbNAnO+P/xMANs145BSNYjEN+BBusQmt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159703; c=relaxed/simple;
	bh=YWXmoG22Kj2qyiViztAEHNEe7bmLj3dtO38tSp891P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIgyRDviSJ99H4gCCuUX02l03fXY/OEEmj1y7QvGdUGk3BxAS6NkUV3Ugo7ZqDAdNTFiROMVsRsV//R9+TjTdRXzhUO//gJopV4lXUASu5zxNTMqbhhfz073wtxGM0dQdvUrdW+ykGpcnv00riHZJ97G4BrqrwBsYaN2Ub1XTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66175FEC;
	Mon, 11 Mar 2024 05:22:16 -0700 (PDT)
Received: from [10.57.49.244] (unknown [10.57.49.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4C773F64C;
	Mon, 11 Mar 2024 05:21:36 -0700 (PDT)
Message-ID: <2195bcc4-e5e5-44de-93c7-667da1409de3@arm.com>
Date: Mon, 11 Mar 2024 12:21:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] usb: host: xhci-plat: add support for multi memory
 regions
To: Howard Yen <howardyen@google.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, mathias.nyman@intel.com, hch@lst.de,
 m.szyprowski@samsung.com, andriy.shevchenko@linux.intel.com,
 petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
 james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240311094947.3738200-1-howardyen@google.com>
 <20240311094947.3738200-3-howardyen@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240311094947.3738200-3-howardyen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-11 9:49 am, Howard Yen wrote:
> The reason why it needs multiple regions is that in my system there is
> an always-on subsystem which includes a small size memory, and several
> functions need to run and occupy the memory from the small memory if
> they need to run on the always-on subsystem. These functions must
> allocate the memory from the small memory region, so that they can get
> benefit from the always-on subsystem. So the small memory is split for
> multiple functions which are satisfied with their generic use cases.
> But in specific use cases, like USB3 devices which support the stream
> trasnsfer or multiple devices connect to the host, they required more
> memory than their pre-allocated memory region, so I tried to propose
> this patch to give it the ability to get the memory from the other
> larger memory to solve the issue.

Once again this still fails to make sense - The USB controller has a 
special always-on pool from which it "must allocate", yet it's fine if 
it also allocates from elsewhere? How on Earth is that supposed to work?

As I said before, if it's actually the case that only certain specific 
allocations (based on driver-level knowledge) must come from the special 
pool, then this is not something which can realistically be abstracted 
by the generic dma-coherent API as it stands (and if so, do the 
non-special allocations even need a dedicated second reserved region, or 
is that in fact just a massive hack around the dma_coherent_mem design 
intentionally not falling back to the regular allocator?)

Thanks,
Robin.

> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
>   drivers/usb/host/xhci-plat.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 3d071b875308..7892d3eb26d2 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -14,6 +14,7 @@
>   #include <linux/pci.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/usb/phy.h>
>   #include <linux/slab.h>
> @@ -149,7 +150,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>   	struct xhci_hcd		*xhci;
>   	struct resource         *res;
>   	struct usb_hcd		*hcd, *usb3_hcd;
> -	int			ret;
> +	int			i, count, ret;
>   	int			irq;
>   	struct xhci_plat_priv	*priv = NULL;
>   	bool			of_match;
> @@ -194,6 +195,19 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>   
>   	xhci->allow_single_roothub = 1;
>   
> +	count = of_property_count_u32_elems(sysdev->of_node, "memory-region");
> +
> +	for (i = 0; i < count; i++) {
> +		ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
> +		if (ret) {
> +			dev_err(sysdev, "Could not get reserved memory\n");
> +			if (i > 0)
> +				of_reserved_mem_device_release(sysdev);
> +
> +			return ret;
> +		}
> +	}
> +
>   	/*
>   	 * Not all platforms have clks so it is not an error if the
>   	 * clock do not exist.
> @@ -431,6 +445,9 @@ void xhci_plat_remove(struct platform_device *dev)
>   	clk_disable_unprepare(clk);
>   	clk_disable_unprepare(reg_clk);
>   	reset_control_assert(xhci->reset);
> +
> +	of_reserved_mem_device_release(hcd->self.sysdev);
> +
>   	usb_put_hcd(hcd);
>   
>   	pm_runtime_disable(&dev->dev);

