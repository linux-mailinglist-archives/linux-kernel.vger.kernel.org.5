Return-Path: <linux-kernel+bounces-136697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AB89D732
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF3328405D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B17823A8;
	Tue,  9 Apr 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/BRlO5h"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946B80BFC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659403; cv=none; b=tU++HCOGhksJyJi70x9ILlI0qnmbyv/3UGrfRYQVxcyxZjzM8D3lGneoPLcM6sDI0DMo3LzXqnEVVhbo04IR//Zf4UwR8oqbl/3z/u+ijLvf4KoJs42qSDx2WNipwQVi2BZh1z/olUPBjN8Mm+twvOtWk6D69evX6S0RS6iFVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659403; c=relaxed/simple;
	bh=P1drV4PVyYjqV1TiHKD9r5Q92b00wwuRopyWCFjwIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lORnn9cKADdwHYxLsJBR8F5QtyLJJu81EQjqIDnNSg1/+2ONfmr33lWYbTJBi5R13IxEl9WtP/e/cJ0m0FvVggG05EHK5v2JlS1U5Hgxiry30sIlnXSTghSNI0EjEB1KHIr7mLf/9P+GlrzFsAzN7PPT0lVY2v1ZkN+KPcziWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/BRlO5h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so66955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712659400; x=1713264200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ikQVwwVGg1QRlqcNnHhwQAmZ6t6nRddh161TyahHqsI=;
        b=U/BRlO5hEpqG4GyvUQJxezZmHpJvwbb8HoHlp1OvH0IVWL3bGz8cxvLyW7yZWo/3/e
         kf4kNbvfWcKE+8BSJP/rE59UNmOIvjxqK+QFXXu8Muy7CWcXwpM/o6Ps7jGXyu4jtIJx
         wqmfqoiU+jeKXrjtPDzG7CW8EWpbE+cKBk/piAErS3LixqDnP/OZik4XdAAo7iVg5o3N
         ZKjFbjCtWVVpywSPSCVOJ1FxLVfI+bI+2irv2/oWwHxNNXxnac71fZ3JyAsKGvf0C+go
         3vbM0Np7y/wh44q43I4IViS5G9S0dJBQOMkOYLqmsz8257GUxWdVPFbnsepqUa26ym5l
         x/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712659400; x=1713264200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikQVwwVGg1QRlqcNnHhwQAmZ6t6nRddh161TyahHqsI=;
        b=YfyxbBHKMjilNmx2JA/0C3vx2VOxiNYnI7Uu0J/Bpexo6UPR2nAWp7Ni07vYmBKr2N
         gWDx9Lk3KF/MT59qPtbX6ID+wYwdtJT+3nYazvoqOcmwMj/u/hG53zyzlRmy7cGbvAAc
         wdj0iUfT3a0tK4wMldABptZSLw4T3QV1WovvgjdAnYnJwswnV47KsUoBri+CYHfq881r
         pylDJ7W+5gJFjGU6imKF/ralzt5Tv+z+1bH8jH+MmTyxGDNqhCXsKQHZAbroUtKG/huT
         ID4AMV/OfHEx49gsHcCZu7QlO5hf/8thgrXjmn9tK1+l4m05Z1g1o2AfZt0XRpVoav7v
         s10g==
X-Forwarded-Encrypted: i=1; AJvYcCUYpM+ceVqhmNm61y1sD9QRKKbVzLzvxFqI+J0s4kbTn+ZCgI3Ss+f2XO00AI1Ou2tyKkyDnrDTWO8ejJUePlpriGQyeu+Mk669qPCO
X-Gm-Message-State: AOJu0Yzy5MPGkCO92RjdWeZJplWy/xbds1Ba+N6FCb3Zk26EMMCnR4j5
	jimASbnrUpuu1OghpGnjerLAlAc/bnvfLzWAOARbgIYHVjjANYSbBwNmc3y0cQ==
X-Google-Smtp-Source: AGHT+IEmRPrla3hhCrDIRObyh+HMBsdD+xkXu0Qn4yIa7MpXx8XpCnlB5sSXyw9+afvoI4IVfrqHbg==
X-Received: by 2002:a05:600c:3b21:b0:416:6b86:852 with SMTP id m33-20020a05600c3b2100b004166b860852mr150180wms.2.1712659399532;
        Tue, 09 Apr 2024 03:43:19 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00343d6c7240fsm11098732wrp.35.2024.04.09.03.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:43:19 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:43:15 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Message-ID: <ZhUbw6gAeBjpFz5C@google.com>
References: <20240403053759.643164-1-aaprelkov@usergate.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403053759.643164-1-aaprelkov@usergate.com>

Hi Aleksandr,

On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
> If devm_add_action() returns ENOMEM, then MSIs allocated but
> not freed on teardown.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> ---
> v2: Use appropriate function for registration failure as 
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 41f93c3ab160..8800af041e5f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>  
>  	/* Add callback to free MSIs on teardown */
> -	devm_add_action(dev, arm_smmu_free_msis, dev);
> +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
> +	if (ret)
> +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");

I am not sure that is the right fix, as allowing the driver to probe
without MSIs, seems worse than leaking MSI memory.

IMHO, we can just add something like:
    dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;

Also, we can’t unconditionally fallback to wired irqs if MSI exists,
according to the user manual:
    An implementation must support one of, or optionally both of,
    wired interrupts and MSIs
    ...
    The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.

We can add some logic, to check dt/acpi irqs and to choose to fallback
or not based on that, but, if we get -ENOMEM, (especially early at
probe) something really went wrong, so I am not sure it’s worth
the complexity.

>  }
>  
>  static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
> -- 
> 2.34.1
> 
Thanks,
Mostafa

