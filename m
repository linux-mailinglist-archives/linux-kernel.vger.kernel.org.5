Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2A791A97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjIDP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIDP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:26:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B624CC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:26:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so16004085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693841187; x=1694445987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
        b=LstVGvZIfgllAPp1vUZpzde0qoJeHYpyzOi7DVb7HxkLNHtfDsM7tigqBQIXcH7/ts
         XenFCp1ugiQKWnUBrdV7X7e1ieNZakX4XZlE7mXKRtqbrup+cZk2wVy8tkcLOiTl2Dhr
         OMi+AslicQNgIYeeiOqXtz1TwXjemtug2AJNvYpXbcFbOrrSQKFaNAXHLzrEyiKD5LD9
         NWXgG+/ip5bOJfwcaT094SRtGkRwd8abJ0DtxNK/5V27rvxEI+voa28Me1v+4iHikRN0
         YfqFD87obsdUnWP+tiaYVHQgor+F0+B8VscbxKsadFhk6VEGC+e9nlqbCTPsA0R9q7By
         ymzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841187; x=1694445987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
        b=UX33KHkk0MgDhPqKbraQ8PbeKVukoC3riv94aAoHyx5WZb9hIYl2UErlmW9y+u02cH
         jQN0RckK4Jvfpll93EkEl1of0pecFDUr6a0TQtqFVWCxO3eNDwSn5GyNj68Bs5HjZHbl
         e5PTfht+JYZQZJ/c7wUQNjN+mg56aHsr+QPU18HPXM5QyuzwAjK3OaIC9tMa+XLVk+rG
         YTRLRiyIyXytUFVs4P2BiITT0i/xVCw+uGiI99qdsY7dULW9btrJApz0ufmL2+Tfxobg
         tyHYrCjsvlmxlUufKxzakSEmiKIFphS/8ZabliqJ6B9A5ntlBqCkYdvEre5/j4ih9ror
         VaoA==
X-Gm-Message-State: AOJu0YzT94MzsSxtOHvQeNmynvjLv7xOuFRGM1J73uFOqWHCZfeNuy2g
        QUp8iTn6SOKVUD/pCMTSfLxJHg==
X-Google-Smtp-Source: AGHT+IHWxHR1EFAYshcTB7RB95vh4F3SsbWMVSXXFSxXBH5grbtimj3wW7/bF5tK15QkRFCPr/KWYg==
X-Received: by 2002:a5d:66ce:0:b0:317:d048:8d87 with SMTP id k14-20020a5d66ce000000b00317d0488d87mr6659141wrw.61.1693841187508;
        Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b00401d8181f8bsm17377650wmf.25.2023.09.04.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Date:   Mon, 4 Sep 2023 16:26:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230904152632.GA815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Thanks for following up with these patches

On Fri, Aug 25, 2023 at 05:21:25PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3551ed057774..fb73dec5b953 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -909,9 +909,21 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> +	if (!vdomain->nr_endpoints)
> +		return;

I was wondering about these nr_endpoints checks, which seemed unnecessary:
if map()/unmap() were called with no attached endpoints, then no requests
were added to the queue, and viommu_sync_req() below is a nop.

But at least viommu_iotlb_sync_map() and viommu_flush_iotlb_all() need to
handle being called before the domain is finalized (for example by
iommu_create_device_direct_mappings()). In that case vdomain->viommu is
NULL so if you add a NULL check in viommu_sync_req() then you should be
able to drop the nr_endpoints checks in both patches.

Thanks,
Jean

>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return 0;
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
>  	}
>  };
> 
> -- 
> 2.39.2
> 
