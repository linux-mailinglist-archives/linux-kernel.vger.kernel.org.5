Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2417ADDCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjIYRYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:24:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AC68BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:24:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2B9DA7;
        Mon, 25 Sep 2023 10:24:37 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B4B3F59C;
        Mon, 25 Sep 2023 10:23:58 -0700 (PDT)
Message-ID: <f044a3cf-b9af-cc4e-80d5-fc40806bda98@arm.com>
Date:   Mon, 25 Sep 2023 18:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
 <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
 <20230925132941.GK13795@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230925132941.GK13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-25 14:29, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 02:07:50PM +0100, Robin Murphy wrote:
>> On 2023-09-23 00:33, Jason Gunthorpe wrote:
>>> On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
>>>
>>>> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
>>>> either; it sets it once it's discovered any instance, since apparently it's
>>>> assuming that all instances must support identical page sizes, and thus once
>>>> it's seen one it can work "normally" per the core code's assumptions. It's
>>>> also I think the only driver which has a "finalise" bodge but *can* still
>>>> properly support map-before-attach, by virtue of having to replay mappings
>>>> to every new endpoint anyway.
>>>
>>> Well it can't quite do that since it doesn't know the geometry - it
>>> all is sort of guessing and hoping it doesn't explode on replay. If it
>>> knows the geometry it wouldn't need finalize...
>>
>> I think it's entirely reasonable to assume that any direct mappings
>> specified for a device are valid for that device and its IOMMU. However, in
>> the particular case of virtio, it really shouldn't ever have direct mappings
>> anyway, since even if the underlying hardware did have any, the host can
>> enforce the actual direct-mapping aspect itself, and just present them as
>> unusable regions to the guest.
> 
> I assume this machinery is for the ARM GIC ITS page....
> 
>> Again, that's irrelevant. It can only be about whether the actual
>> ->map_pages call succeeds or not. A driver could well know up-front that all
>> instances support the same pgsize_bitmap and aperture, and set both at
>> ->domain_alloc time, yet still be unable to handle an actual mapping without
>> knowing which instance(s) that needs to interact with (e.g. omap-iommu).
> 
> I think this is a different issue. The domain is supposed to represent
> the actual io pte storage, and the storage is supposed to exist even
> when the domain is not attached to anything.
> 
> As we said with tegra-gart, it is a bug in the driver if all the
> mappings disappear when the last device is detached from the domain.
> Driver bugs like this turn into significant issues with vfio/iommufd
> as this will result in warn_on's and memory leaking.
> 
> So, I disagree that this is something we should be allowing in the API
> design. map_pages should succeed (memory allocation failures aside) if
> a IOVA within the aperture and valid flags are presented. Regardless
> of the attachment status. Calling map_pages with an IOVA outside the
> aperture should be a caller bug.
> 
> It looks omap is just mis-designed to store the pgd in the omap_iommu,
> not the omap_iommu_domain :( pgd is clearly a per-domain object in our
> API. And why does every instance need its own copy of the identical
> pgd?

The point wasn't that it was necessarily a good and justifiable example, 
just that it is one that exists, to demonstrate that in general we have 
no reasonable heuristic for guessing whether ->map_pages is going to 
succeed or not other than by calling it and seeing if it succeeds or 
not. And IMO it's a complete waste of time thinking about ways to make 
such a heuristic possible instead of just getting on with fixing 
iommu_domain_alloc() to make the problem disappear altogether. Once 
Joerg pushes out the current queue I'll rebase and resend v4 of the bus 
ops removal, then hopefully get back to despairing at the hideous pile 
of WIP iommu_domain_alloc() patches I currently have on top of it...

Thanks,
Robin.
