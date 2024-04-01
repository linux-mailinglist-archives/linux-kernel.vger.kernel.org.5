Return-Path: <linux-kernel+bounces-126881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF888942E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1EA283772
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A99482E4;
	Mon,  1 Apr 2024 16:57:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04529481B8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990639; cv=none; b=NX1WiwgXl89AwTw4dnyyM/KjHR5TzCCxrayVaC6Q3muxDsljzzdc3QFEBt1oJMJPiEM4LnPiHmqZ5GkrMOb70YP51n+u67HRgrZvvB+92xSLVIhnKDPx+5DiA8POXuOzeimpKDinEMJIjjUHbMni5M/mqAcfR3FMxLt/K8zL47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990639; c=relaxed/simple;
	bh=Q1GiDPsmOA9yFoE9UumeRh3CLhd1FXbZpuCn264ms8c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOoUBsECQ4Gjv02QKr0Y4flJvBFfhoc5fsytV4rXDlHAQkWnMQCPCo+KSJZCunARxLv6PUWDx9fm2m5+mWkEVbSf0eEHw3sCkA7NavGJNCB0d1/xe50IZCUhd4YdCG8BKp6r6I78hMRyTJmwb8D7YYN3sd2eWkZ4M+zFAtBBO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7cCp0fbxz6K5t9;
	Tue,  2 Apr 2024 00:39:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 92DB71400D1;
	Tue,  2 Apr 2024 00:40:12 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:40:11 +0100
Date: Mon, 1 Apr 2024 17:40:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen"
	<nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Marc Zyngier <maz@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Message-ID: <20240401174009.00003644@Huawei.com>
In-Reply-To: <20240329095133.576605-1-aaprelkov@usergate.com>
References: <20240329095133.576605-1-aaprelkov@usergate.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 29 Mar 2024 16:51:33 +0700
Aleksandr Aprelkov <aaprelkov@usergate.com> wrote:

> If devm_add_action() returns ENOMEM, then MSIs allocated but
> not freed on teardown.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>

I've not checked this is an actual bug (though it looks like one from
the context of the patch - the comment below is just about
how you fix it.

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 41f93c3ab160..136d0cdce6a9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3402,7 +3402,12 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>  
>  	/* Add callback to free MSIs on teardown */
> -	devm_add_action(dev, arm_smmu_free_msis, dev);
> +	ret = devm_add_action(dev, arm_smmu_free_msis, dev);

Use devm_add_action_or_reset() which exists to solve the case of devm registration failing.


> +	if (ret) {
> +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
> +		arm_smmu_free_msis(dev);
> +		return;
> +	}
>  }
>  
>  static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)


