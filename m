Return-Path: <linux-kernel+bounces-52464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB9849884
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C3F1F2361E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572351865A;
	Mon,  5 Feb 2024 11:11:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC82182C3;
	Mon,  5 Feb 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131468; cv=none; b=Lmwg3Dwn961enCp6WbNFRkP2p/oRiaya8Xtpg9wilQNx0Ao5dPEWXTCFDGMk+1QNOnKXdBn6WoH4huWKv9A5/HhXG8Gv1+2tK+C2o9zRtVmiXsVWkn3FgHXlphkyTGC6Jk43o2unoj9oHF1G3A9VFEi9GMt788VnAXSMUVLgidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131468; c=relaxed/simple;
	bh=ZFaytGRgNj8t8uPt+74n42X1oiQsxT+xSsddTDC6SW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/vatPRXsl2mDurNOJqLup+FqaLAedoDIko+qd6A8OIziatgSNwhM2gcacx8cnG3MgOI8JKHPvc7tAps6ORmLdTD49UsuKhCPg4lL9y5qDrYqngHvaBVgHC0fO9YBLLPBpY09KH7toMNiUmbzlCr5MgnaJFhYJJksi0zt7+qfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42ED61FB;
	Mon,  5 Feb 2024 03:11:48 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC063F762;
	Mon,  5 Feb 2024 03:11:04 -0800 (PST)
Message-ID: <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Date: Mon, 5 Feb 2024 11:11:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Use
 devm_platform_get_and_ioremap_resource() in ipmmu_probe()
Content-Language: en-GB
To: Markus Elfring <Markus.Elfring@web.de>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 10:42 am, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 11:36:51 +0100
> 
> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source code.

Much as I detest the get_and_ioremap_resource obfuscator, it's not even 
appropriate here since nothing else is using "res".

> This issue was detected by using the Coccinelle software.

Please improve your script, or at least manually review your patches to 
ensure they actually make sense in context. If you want to do cleanup, 
do thorough, meaningful cleanup - leaving weird dangling local variables 
does not make the code clearer, if anything it makes it subtly worse 
since now the reader's wondering why we've gone out of our way to make 
this unused assignment, so maybe something's missing and there's a bug?

Thanks,
Robin.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ace1fc4bd34b..12685dd2dd31 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1025,8 +1025,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>   		return ret;
> 
>   	/* Map I/O memory and request IRQ. */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmu->base = devm_ioremap_resource(&pdev->dev, res);
> +	mmu->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(mmu->base))
>   		return PTR_ERR(mmu->base);
> 
> --
> 2.43.0
> 

