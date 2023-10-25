Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391DA7D716B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjJYQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJYQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:05:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E0A132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:05:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83AAD1FB;
        Wed, 25 Oct 2023 09:05:53 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A253F64C;
        Wed, 25 Oct 2023 09:05:10 -0700 (PDT)
Message-ID: <6da52dd4-b3fe-46f8-9a38-c4315b989139@arm.com>
Date:   Wed, 25 Oct 2023 17:05:08 +0100
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
 <ec86712a-0c46-4b27-9736-e34b02168e19@arm.com>
 <20231025125528.GG3952@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231025125528.GG3952@nvidia.com>
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

On 25/10/2023 1:55 pm, Jason Gunthorpe wrote:
> On Wed, Oct 25, 2023 at 01:39:56PM +0100, Robin Murphy wrote:
>> On 24/10/2023 7:52 pm, Jason Gunthorpe wrote:
>>> On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
>>>
>>>> @@ -2279,10 +2280,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>>>    static int __iommu_attach_group(struct iommu_domain *domain,
>>>>    				struct iommu_group *group)
>>>>    {
>>>> +	struct device *dev;
>>>> +
>>>>    	if (group->domain && group->domain != group->default_domain &&
>>>>    	    group->domain != group->blocking_domain)
>>>>    		return -EBUSY;
>>>> +	dev = iommu_group_first_dev(group);
>>>> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>>>> +		return -EINVAL;
>>>
>>> I was thinking about this later, how does this work for the global
>>> static domains? domain->owner will not be set?
>>>
>>> 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
>>> 		return ops->identity_domain;
>>> 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
>>> 		return ops->blocked_domain;
>>>
>>> Seems like it will break everything?
>>
>> I don't believe it makes any significant difference - as the commit message
>> points out, this validation is only applied at the public interface
>> boundaries of iommu_attach_group(), iommu_attach_device(),
> 
> Oh, making it only work for on domain type seems kind of hacky..
> 
> If that is the intention maybe the owner set should be moved into
> iommu_domain_alloc() with a little comment noting that it is limited
> to work in only a few cases?
> 
> I certainly didn't understand from the commit message to mean it was
> only actually working for one domain type and this also blocks using
> other types with the public interface.

It's not about one particular domain type, it's about the scope of what 
we consider valid usage. External API users should almost always be 
attaching to their own domain which they have allocated, however we also 
tolerate co-attaching additional groups to the same DMA domain in rare 
cases where it's reasonable. The fact is that those users cannot 
allocate blocking or identity domains, and I can't see that they would 
ever have any legitimate business trying to do anything with them 
anyway. So although yes, we technically lose some functionality once 
this intersects with the static domain optimisation, it's only 
questionable functionality which was never explicitly intended anyway.

I mean, what would be the valid purpose of trying to attach group A to 
group B's identity domain, even if they *were* backed by the same 
driver? At best it's pointless if group A also has its own identity 
domain already, otherwise at worst it's a deliberate attempt to 
circumvent a default domain policy imposed by the IOMMU core.

>> and iommu_attach_device_pasid(), which are only expected to be
>> operating on explicitly-allocated unmanaged domains.
> 
> We have nesting now in the iommufd branch, and SVA will come soon for
> these APIs.
> 
> Regardless this will clash with the iommufd branch for this reason so
> I guess it needs to wait till rc1.

Sigh, back on the shelf it goes then...

Thanks,
Robin.
