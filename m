Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2BA791AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjIDPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIDPeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:34:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F08CC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:34:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso16995205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693841638; x=1694446438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
        b=e3bUSFwg6DSPbEBA8Y5Wc7SQsIUgL+iu6iK1XKxG2+vTQPodz6PmwfJY/WomkE2eNl
         obhhZEfR6g8cE9IL0gU7SYBQUuA+nsVSl12a1grYQC72PDk4iWZKW5iT4ARkVFvff4Zd
         dcFn/zyntmlmd/u4yXGnsnNy6tcuCNMXXb0PQwMdYpHlmGm4aSdR7Kh9pA6MRFMojHcw
         WVgLwwrK2FcgHiXcEunE/l53zlz3Br8LQPTTf7MPsmh7aMkJa9gPDcvN98yML9j3L6qL
         JvF8oX4M5nIN3jRVr7kMMpgflibjhJqtAcP+SeAx8gWqd6TmG2Sk4qcLNqWIqb0qFub2
         fdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841638; x=1694446438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
        b=egYMkhnFcVIg6zJT4QCDbFZ8mUpZMgdZoTS9pVxAvSS7W6CKtJSjlAehqo9+Ub6+53
         Ns/75AekaEXOw7FzbwTJdO0+Whoni7+eMLreQlF6CBFIs6ZVl9aSIOQn9pt4nwfu/JP9
         dzyiYSbdYumHVp8dOu9EWgB9cmZL+yCyG7ScY4h3YUq1gc74vztY0nlcGnwWHCwai/Vi
         QmQu5823P/jrkD+6tlgvViq+qd9r/nfKHHaYOhiX1ph/hsI7Itc2O/I1hHb615fVh2Ta
         USURKoZ1LJed48pvdA/6xSBzy/Ise2gbL4ITCg8aD2KwFp//oO5ZMrAZRGn5pUvNOrq5
         64Qw==
X-Gm-Message-State: AOJu0Yx0Hf2BXaQqkoN6OHeBFwFmA5LGCUA8yk2BgAADBJ/Fokjqu1pj
        ztFp3w8LisP2Lw5ZIODs0fHXIA==
X-Google-Smtp-Source: AGHT+IGhYh7h7UosmsP+axnCskrqTn/m5wl+B+KT+YE2nQBzRYMTV/Fur6gSkA0GnBJj6rv+rEUuzA==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7728851wmd.22.1693841638575;
        Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c379800b003fed70fb09dsm14379467wmr.26.2023.09.04.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Date:   Mon, 4 Sep 2023 16:34:03 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230904153403.GB815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results inn a significant increase

in

> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory. To get back to the prior behavior
> iommu.strict=1 may be set on the kernel command line.

Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
well, because I've seen kernel configs that enable either.

> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index fb73dec5b953..1b7526494490 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return;

As for patch 1, a NULL check in viommu_sync_req() would allow dropping
this one

Thanks,
Jean

> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
> 
> -- 
> 2.39.2
> 
