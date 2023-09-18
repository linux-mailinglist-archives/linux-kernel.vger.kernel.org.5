Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B897A4F65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjIRQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjIRQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:41:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B8E349E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:37:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BDF1FB;
        Mon, 18 Sep 2023 09:38:31 -0700 (PDT)
Received: from [10.57.94.165] (unknown [10.57.94.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DBE53F59C;
        Mon, 18 Sep 2023 09:37:53 -0700 (PDT)
Message-ID: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
Date:   Mon, 18 Sep 2023 17:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-18 12:51, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.

Is it really a requirement? Deferred flush only deals with unmapping. Or 
are you just trying to say that it's not too worthwhile to try doing 
more for unmapping performance while obvious mapping performance is 
still left on the table?

> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..3649586f0e5c 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>   	int ret;
>   	unsigned long flags;
>   
> +	/*
> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> +	 */
> +	if (!viommu)
> +		return 0;

Minor nit: I'd be inclined to make that check explicitly in the places 
where it definitely is expected, rather than allowing *any* sync to 
silently do nothing if called incorrectly. Plus then they could use 
vdomain->nr_endpoints for consistency with the equivalent checks 
elsewhere (it did take me a moment to figure out how we could get to 
.iotlb_sync_map with a NULL viommu without viommu_map_pages() blowing up 
first...)

Thanks,
Robin.

>   	spin_lock_irqsave(&viommu->request_lock, flags);
>   	ret = __viommu_sync_req(viommu);
>   	if (ret)
> @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>   			.flags		= cpu_to_le32(flags),
>   		};
>   
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>   		if (ret) {
>   			viommu_del_mappings(vdomain, iova, end);
>   			return ret;
> @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>   	viommu_sync_req(vdomain->viommu);
>   }
>   
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>   {
>   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
>   		.unmap_pages		= viommu_unmap_pages,
>   		.iova_to_phys		= viommu_iova_to_phys,
>   		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>   		.free			= viommu_domain_free,
>   	}
>   };
> 
