Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBF7C6C88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbjJLLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjJLLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:40:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF07594
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:40:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ECE913D5;
        Thu, 12 Oct 2023 04:40:44 -0700 (PDT)
Received: from [10.57.69.22] (unknown [10.57.69.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DBF23F762;
        Thu, 12 Oct 2023 04:40:02 -0700 (PDT)
Message-ID: <42bbeab4-84f3-470e-bd42-2dae31b5775c@arm.com>
Date:   Thu, 12 Oct 2023 12:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
 <43ca2a88-942e-4d65-87f1-30a7cf537edd@linux.intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <43ca2a88-942e-4d65-87f1-30a7cf537edd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 07:05, Baolu Lu wrote:
> On 10/12/23 2:14 AM, Robin Murphy wrote:
>> Much as I'd like to remove iommu_present(), the final remaining users
>> are proving stubbornly difficult to clean up, so kick that can down the
>> road and just rework it to preserve the current behaviour without
>> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
> 
> The iommu_present() is only used in below two drivers.
> 
> $ git grep iommu_present
> drivers/gpu/drm/mediatek/mtk_drm_drv.c: if 
> (!iommu_present(&platform_bus_type))
> drivers/gpu/drm/tegra/drm.c:    if (host1x_drm_wants_iommu(dev) && 
> iommu_present(&platform_bus_type)) {
> 
> Both are platform drivers and have the device pointer passed in. Just
> out of curiosity, why not replacing them with device_iommu_mapped()
> instead? Sorry if I overlooked previous discussion.

Yes, we've already gone round in circles on this several times, that's 
why it's explicitly called out as "stubbornly difficult" in the commit 
message. The Mediatek one is entirely redundant, but it seems I have yet 
to figure out the right CC list to get anyone to care about that 
patch[1]. The Tegra one is making some non-obvious assumptions to 
actually check on behalf of some *other* devices, even when the one to 
hand may not be using the IOMMU itself[2]. That case is what the new 
kerneldoc alludes to.

My hope is to eventually punt this into the Tegra driver itself 
(probably at the point when it needs something similar for 
iommu_domain_alloc() as well), however previous experience has taught me 
that trying to coordinate cross-subsystem work with drm-misc is an 
ordeal best avoided until there is no possible alternative.

Thanks,
Robin.

[1] https://patchwork.freedesktop.org/patch/536273/
[2] 
https://lore.kernel.org/linux-iommu/a0c7e954-ee3f-74fd-cfea-9b6dbce924dc@collabora.com/

> 
> Best regards,
> baolu
> 
>> to IOMMU device registration"), any registered IOMMU instance is already
>> considered "present" for every entry in iommu_buses, so it's simply a
>> case of validating the bus and checking we have at least once IOMMU.
>>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>>
>> v3: Tweak to use the ops-based check rather than group-based, to
>>      properly match the existing behaviour
>> v4: Just look for IOMMU instances instead of managed devices
>> ---
>>   drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 5a3ce293a5de..7bb92e8b7a49 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2000,9 +2000,28 @@ int bus_iommu_probe(const struct bus_type *bus)
>>       return 0;
>>   }
>> +/**
>> + * iommu_present() - make platform-specific assumptions about an IOMMU
>> + * @bus: bus to check
>> + *
>> + * Do not use this function. You want device_iommu_mapped() instead.
>> + *
>> + * Return: true if some IOMMU is present and aware of devices on the 
>> given bus;
>> + * in general it may not be the only IOMMU, and it may not have 
>> anything to do
>> + * with whatever device you are ultimately interested in.
>> + */
>>   bool iommu_present(const struct bus_type *bus)
>>   {
>> -    return bus->iommu_ops != NULL;
>> +    bool ret = false;
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +        if (iommu_buses[i] == bus) {
>> +            spin_lock(&iommu_device_lock);
>> +            ret = !list_empty(&iommu_device_list);
>> +            spin_unlock(&iommu_device_lock);
>> +        }
>> +    }
>> +    return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_present);
