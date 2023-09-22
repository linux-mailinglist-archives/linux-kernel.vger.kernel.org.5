Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA937AB8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjIVSH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIVSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:07:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13554102
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:07:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876C7C15;
        Fri, 22 Sep 2023 11:08:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50FC03F59C;
        Fri, 22 Sep 2023 11:07:45 -0700 (PDT)
Message-ID: <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
Date:   Fri, 22 Sep 2023 19:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922162714.GH13795@ziepe.ca>
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

On 22/09/2023 5:27 pm, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 02:13:18PM +0100, Robin Murphy wrote:
>> On 22/09/2023 1:41 pm, Jason Gunthorpe wrote:
>>> On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
>>>>>> They're not strictly equivalent: this check works around a temporary issue
>>>>>> with the IOMMU core, which calls map/unmap before the domain is
>>>>>> finalized.
>>>>>
>>>>> Where? The above points to iommu_create_device_direct_mappings() but
>>>>> it doesn't because the pgsize_bitmap == 0:
>>>>
>>>> __iommu_domain_alloc() sets pgsize_bitmap in this case:
>>>>
>>>>           /*
>>>>            * If not already set, assume all sizes by default; the driver
>>>>            * may override this later
>>>>            */
>>>>           if (!domain->pgsize_bitmap)
>>>>                   domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>>>
>>> Dirver's shouldn't do that.
>>>
>>> The core code was fixed to try again with mapping reserved regions to
>>> support these kinds of drivers.
>>
>> This is still the "normal" code path, really; I think it's only AMD that
>> started initialising the domain bitmap "early" and warranted making it
>> conditional.
> 
> My main point was that iommu_create_device_direct_mappings() should
> fail for unfinalized domains, setting pgsize_bitmap to allow it to
> succeed is not a nice hack, and not necessary now.

Sure, but it's the whole "unfinalised domains" and rewriting 
domain->pgsize_bitmap after attach thing that is itself the massive 
hack. AMD doesn't do that, and doesn't need to; it knows the appropriate 
format at allocation time and can quite happily return a fully working 
domain which allows map before attach, but the old ops->pgsize_bitmap 
mechanism fundamentally doesn't work for multiple formats with different 
page sizes. The only thing I'd accuse it of doing wrong is the weird 
half-and-half thing of having one format as a default via one mechanism, 
and the other as an override through the other, rather than setting both 
explicitly.

virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings 
either; it sets it once it's discovered any instance, since apparently 
it's assuming that all instances must support identical page sizes, and 
thus once it's seen one it can work "normally" per the core code's 
assumptions. It's also I think the only driver which has a "finalise" 
bodge but *can* still properly support map-before-attach, by virtue of 
having to replay mappings to every new endpoint anyway.

> What do you think about something like this to replace
> iommu_create_device_direct_mappings(), that does enforce things
> properly?

I fail to see how that would make any practical difference. Either the 
mappings can be correctly set up in a pagetable *before* the relevant 
device is attached to that pagetable, or they can't (if the driver 
doesn't have enough information to be able to do so) and we just have to 
really hope nothing blows up in the race window between attaching the 
device to an empty pagetable and having a second try at 
iommu_create_device_direct_mappings(). That's a driver-level issue and 
has nothing to do with pgsize_bitmap either way.

Thanks,
Robin.
