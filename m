Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958567D6C20
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjJYMkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjJYMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:40:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFFAC13D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:39:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53E72F4;
        Wed, 25 Oct 2023 05:40:39 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B84A3F738;
        Wed, 25 Oct 2023 05:39:57 -0700 (PDT)
Message-ID: <ec86712a-0c46-4b27-9736-e34b02168e19@arm.com>
Date:   Wed, 25 Oct 2023 13:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
 <20231024185213.GA1061115@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231024185213.GA1061115@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 7:52 pm, Jason Gunthorpe wrote:
> On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
> 
>> @@ -2279,10 +2280,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>   				struct iommu_group *group)
>>   {
>> +	struct device *dev;
>> +
>>   	if (group->domain && group->domain != group->default_domain &&
>>   	    group->domain != group->blocking_domain)
>>   		return -EBUSY;
>>   
>> +	dev = iommu_group_first_dev(group);
>> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>> +		return -EINVAL;
> 
> I was thinking about this later, how does this work for the global
> static domains? domain->owner will not be set?
> 
> 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
> 		return ops->identity_domain;
> 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
> 		return ops->blocked_domain;
> 
> Seems like it will break everything?

I don't believe it makes any significant difference - as the commit 
message points out, this validation is only applied at the public 
interface boundaries of iommu_attach_group(), iommu_attach_device(), and 
iommu_attach_device_pasid(), which are only expected to be operating on 
explicitly-allocated unmanaged domains. For internal default domain 
attachment, the domain is initially derived from the device/group itself 
so we know it's appropriate by construction.

I guess this *would* now prevent some external caller reaching in and 
trying to attach something to some other group's identity default 
domain, but frankly it feels like making that fail would be no bad thing 
anyway.

Thanks,
Robin.
