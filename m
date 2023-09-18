Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600297A52E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjIRTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:22:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 150D210E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:21:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA14A1FB;
        Mon, 18 Sep 2023 12:22:28 -0700 (PDT)
Received: from [10.57.94.165] (unknown [10.57.94.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526413F5A1;
        Mon, 18 Sep 2023 12:21:50 -0700 (PDT)
Message-ID: <982143de-ec1e-aff4-e65f-77a38e48cf20@arm.com>
Date:   Mon, 18 Sep 2023 20:21:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/7] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        baolu.lu@linux.intel.com
References: <cover.1694693889.git.robin.murphy@arm.com>
 <b7cd933aa7774ad687c695ebe5e00c17178a7542.1694693889.git.robin.murphy@arm.com>
 <20230918171216.GK13733@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230918171216.GK13733@nvidia.com>
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

On 2023-09-18 18:12, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 05:58:06PM +0100, Robin Murphy wrote:
>> Much as I'd like to remove iommu_present(), the final remaining users
>> are proving stubbornly difficult to clean up, so kick that can down
>> the road and just rework it to preserve the current behaviour without
>> depending on bus ops.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>>
>> v3: Tweak to use the ops-based check rather than group-based, to
>>      properly match the existing behaviour
>> ---
>>   drivers/iommu/iommu.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4566d0001cd3..2f29ee9dea64 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1907,9 +1907,24 @@ int bus_iommu_probe(const struct bus_type *bus)
>>   	return 0;
>>   }
>>   
>> +static int __iommu_present(struct device *dev, void *unused)
>> +{
>> +	return dev_has_iommu(dev);
>> +}
> 
> This is not locked right..

Urgh, yes, I suppose technically this walk could run in parallel with 
the bus_iommu_probe() of another IOMMU instance that our caller here 
doesn't depend on. I agree that's suboptimal, even if it shouldn't 
happen in practice for the remaining in-tree callers.

> Rather than perpetuate that, can we fix the two callers instead?
> 
> Maybe this for mtk:
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 93552d76b6e778..e7fe0e6f27de85 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -500,6 +500,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>                  dev_err(drm->dev, "Need at least one OVL device\n");
>                  goto err_component_unbind;
>          }
> +       if (!device_iommu_mapped(dma_dev))
> +               return -EPROBE_DEFER;
>   
>          for (i = 0; i < private->data->mmsys_dev_num; i++)
>                  private->all_drm_private[i]->dma_dev = dma_dev;
> @@ -583,9 +585,6 @@ static int mtk_drm_bind(struct device *dev)
>          struct drm_device *drm;
>          int ret, i;
>   
> -       if (!iommu_present(&platform_bus_type))
> -               return -EPROBE_DEFER;
> -
>          pdev = of_find_device_by_node(private->mutex_node);
>          if (!pdev) {
>                  dev_err(dev, "Waiting for disp-mutex device %pOF\n",
> 
> 
> ? It doesn't seem to use the iommu API so I guess all it is doing is
> trying to fix some kind of probe ordering issue? Maybe the probe
> ordering issue is already gone and we can just delete the check?

As I've said before, the correct fix for this one is [1]. I've sent it 
twice now, it just gets ignored :(

> And tegra:
> 
> 	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
> 		tegra->domain = iommu_domain_alloc(&platform_bus_type);
> 		if (!tegra->domain) {
> 
> Lets do the same:
> 
> 	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dev->dev.parent)) {
> 
> ?

IIRC the problem here is that the Host1x (or GPU?) wants to allocate a 
domain for the GPU (or Host1x) to use, even if the former isn't itself 
associated with the IOMMU, and at this point it doesn't actually have a 
suitable handle to the latter device.

> Alternatively how about:
> 
> bool iommu_present(void)
> {
> 	bool ret;
> 
> 	spin_lock(&iommu_device_lock);
> 	ret = !list_empty(&iommu_device_list);
> 	spin_unlock(&iommu_device_lock);
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(iommu_present);
> 
> Since neither of the two users is really needing anything more than that?

Hmm, I guess maybe I did get a bit hung up on the bus notion... Indeed I 
think this wouldn't really be any more inaccurate than the current 
behaviour, and might be arguably truer to the intent of the function 
(whatever that is) since in the new design any instance is effectively 
present for all relevant buses anyway. I've respun along these lines 
(but retaining the argument with some token validation) and I don't hate 
it, so I'll send that as v4.

Thanks,
Robin.

[1] 
https://lore.kernel.org/dri-devel/49bafdabd2263cfc543bb22fb7f1bf32ea6bfd22.1683735862.git.robin.murphy@arm.com/
