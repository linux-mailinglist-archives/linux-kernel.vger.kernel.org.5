Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF97A4745
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjIRKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbjIRKho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:37:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FEE0CDF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:36:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4BD1FB;
        Mon, 18 Sep 2023 03:37:01 -0700 (PDT)
Received: from [10.57.94.165] (unknown [10.57.94.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862883F67D;
        Mon, 18 Sep 2023 03:36:22 -0700 (PDT)
Message-ID: <5c2746a3-ef3a-2747-c600-395159f668ba@arm.com>
Date:   Mon, 18 Sep 2023 11:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com
References: <cover.1694693889.git.robin.murphy@arm.com>
 <404d8395cf4252c6fe6d98f317f3570127451778.1694693889.git.robin.murphy@arm.com>
 <e0a7969a-60e3-6b3c-4f74-592654d4407f@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e0a7969a-60e3-6b3c-4f74-592654d4407f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-18 07:10, Baolu Lu wrote:
> On 9/16/23 12:58 AM, Robin Murphy wrote:
>> @@ -1997,16 +1995,13 @@ void iommu_set_fault_handler(struct 
>> iommu_domain *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
>> -static struct iommu_domain *__iommu_domain_alloc(const struct 
>> bus_type *bus,
>> +static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
>>                            unsigned type)
>>   {
>> -    const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
>> +    const struct iommu_ops *ops = dev_iommu_ops(dev);
>>       struct iommu_domain *domain;
>>       unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
>> -    if (!ops)
>> -        return NULL;
>> -
>>       domain = ops->domain_alloc(alloc_type);
>>       if (!domain)
>>           return NULL;
>> @@ -2030,9 +2025,28 @@ static struct iommu_domain 
>> *__iommu_domain_alloc(const struct bus_type *bus,
>>       return domain;
>>   }
>> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>> +{
>> +    struct device **alloc_dev = data;
>> +
>> +    if (!dev_has_iommu(dev))
>> +        return 0;
>> +
>> +    WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != 
>> dev_iommu_ops(*alloc_dev),
>> +          "Multiple IOMMU drivers present, which the public IOMMU API 
>> can't fully support yet. You may still need to disable one or more to 
>> get the expected result here, sorry!\n");
>> +
>> +    *alloc_dev = dev;
>> +    return 0;
>> +}
>> +
>>   struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>>   {
>> -    return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
>> +    struct device *dev = NULL;
>> +
>> +    if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
>> +        return NULL;
> 
> __iommu_domain_alloc_dev() always returns 0. Hence above if condition
> will never be true. Perhaps, in __iommu_domain_alloc_dev(),

Oh bugger, seems I screwed up the unnecessarily overcomplicated rebase 
that I made for myself, and managed to put this back to the v1 code, so 
it's just wrong (bus_for_each_dev() can return an error itself if the 
bus isn't properly initialised, but it also returns success if the bus 
has no devices, which was handled properly in v2 that you actually R-b'd).

> 
>      if (WARN_ON(*alloc_dev && dev_iommu_ops(dev) !=
>              dev_iommu_ops(*alloc_dev))
>          return -EPERM;

I went back and forth on this initially, but in the end I figured since 
the other patches are meant to be making the rest of the public API 
sufficiently robust, then if someone does try it with multiple drivers 
before full support can be finished, they can at least have some chance 
of getting the desired result, rather than a guarantee of not. I am 
still open to being convinced otherwise, though.

Thanks,
Robin.

> 
> ?
> 
>> +
>> +    return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
> 
> Is it possible that all devices on this bus have dev_has_iommu() to be
> false? If so, we probably need something like below:
> 
>      if (!dev_has_iommu(dev))
>          return -ENODEV;
> 
> ?
> 
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>> @@ -3228,13 +3242,17 @@ static int 
>> __iommu_group_alloc_blocking_domain(struct iommu_group *group)
>>       if (group->blocking_domain)
>>           return 0;
>> -    group->blocking_domain = __iommu_domain_alloc(dev->bus, 
>> IOMMU_DOMAIN_BLOCKED);
>> +    /* noiommu groups should never be here */
>> +    if (WARN_ON(!dev_has_iommu(dev)))
>> +        return -ENODEV;
>> +
>> +    group->blocking_domain = __iommu_domain_alloc(dev, 
>> IOMMU_DOMAIN_BLOCKED);
>>       if (!group->blocking_domain) {
>>           /*
>>            * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
>>            * create an empty domain instead.
>>            */
>> -        group->blocking_domain = __iommu_domain_alloc(dev->bus, 
>> IOMMU_DOMAIN_UNMANAGED);
>> +        group->blocking_domain = __iommu_domain_alloc(dev, 
>> IOMMU_DOMAIN_UNMANAGED);
>>           if (!group->blocking_domain)
>>               return -EINVAL;
>>       }
> 
> Best regards,
> baolu
