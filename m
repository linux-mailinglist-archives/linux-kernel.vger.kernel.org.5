Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A0791BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjIDQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjIDQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:34:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF4B9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 09:33:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CA53143D;
        Mon,  4 Sep 2023 09:34:34 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF223F766;
        Mon,  4 Sep 2023 09:33:55 -0700 (PDT)
Message-ID: <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
Date:   Mon, 4 Sep 2023 17:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Language: en-GB
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
 <20230904153403.GB815284@myrica>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230904153403.GB815284@myrica>
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

On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
> On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
>> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
>> dma-iommu deferred flush scheme. This results inn a significant increase
> 
> in
> 
>> in performance in exchange for a window in which devices can still
>> access previously IOMMU mapped memory. To get back to the prior behavior
>> iommu.strict=1 may be set on the kernel command line.
> 
> Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
> well, because I've seen kernel configs that enable either.

Indeed, I'd be inclined phrase it in terms of the driver now actually 
being able to honour lazy mode when requested (which happens to be the 
default on x86), rather than as if it might be some 
potentially-unexpected change in behaviour.

Thanks,
Robin.

>> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index fb73dec5b953..1b7526494490 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>>   	return viommu_sync_req(vdomain->viommu);
>>   }
>>   
>> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
>> +{
>> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +
>> +	if (!vdomain->nr_endpoints)
>> +		return;
> 
> As for patch 1, a NULL check in viommu_sync_req() would allow dropping
> this one
> 
> Thanks,
> Jean
> 
>> +	viommu_sync_req(vdomain->viommu);
>> +}
>> +
>>   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>>   {
>>   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
>> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>>   	switch (cap) {
>>   	case IOMMU_CAP_CACHE_COHERENCY:
>>   		return true;
>> +	case IOMMU_CAP_DEFERRED_FLUSH:
>> +		return true;
>>   	default:
>>   		return false;
>>   	}
>> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>>   		.map_pages		= viommu_map_pages,
>>   		.unmap_pages		= viommu_unmap_pages,
>>   		.iova_to_phys		= viommu_iova_to_phys,
>> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>>   		.iotlb_sync		= viommu_iotlb_sync,
>>   		.iotlb_sync_map		= viommu_iotlb_sync_map,
>>   		.free			= viommu_domain_free,
>>
>> -- 
>> 2.39.2
>>
