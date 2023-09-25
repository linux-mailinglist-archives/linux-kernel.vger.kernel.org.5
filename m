Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B27AD89E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjIYNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIYNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:08:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 485019F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:07:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE8CDA7;
        Mon, 25 Sep 2023 06:08:32 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 832CE3F5A1;
        Mon, 25 Sep 2023 06:07:53 -0700 (PDT)
Message-ID: <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
Date:   Mon, 25 Sep 2023 14:07:50 +0100
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
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922233309.GI13795@ziepe.ca>
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

On 2023-09-23 00:33, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> 
>> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
>> either; it sets it once it's discovered any instance, since apparently it's
>> assuming that all instances must support identical page sizes, and thus once
>> it's seen one it can work "normally" per the core code's assumptions. It's
>> also I think the only driver which has a "finalise" bodge but *can* still
>> properly support map-before-attach, by virtue of having to replay mappings
>> to every new endpoint anyway.
> 
> Well it can't quite do that since it doesn't know the geometry - it
> all is sort of guessing and hoping it doesn't explode on replay. If it
> knows the geometry it wouldn't need finalize...

I think it's entirely reasonable to assume that any direct mappings 
specified for a device are valid for that device and its IOMMU. However, 
in the particular case of virtio, it really shouldn't ever have direct 
mappings anyway, since even if the underlying hardware did have any, the 
host can enforce the actual direct-mapping aspect itself, and just 
present them as unusable regions to the guest.

>>> What do you think about something like this to replace
>>> iommu_create_device_direct_mappings(), that does enforce things
>>> properly?
>>
>> I fail to see how that would make any practical difference. Either the
>> mappings can be correctly set up in a pagetable *before* the relevant device
>> is attached to that pagetable, or they can't (if the driver doesn't have
>> enough information to be able to do so) and we just have to really hope
>> nothing blows up in the race window between attaching the device to an empty
>> pagetable and having a second try at iommu_create_device_direct_mappings().
>> That's a driver-level issue and has nothing to do with pgsize_bitmap either
>> way.
> 
> Except we don't detect this in the core code correctly, that is my
> point. We should detect the aperture conflict, not pgsize_bitmap to
> check if it is the first or second try.

Again, that's irrelevant. It can only be about whether the actual 
->map_pages call succeeds or not. A driver could well know up-front that 
all instances support the same pgsize_bitmap and aperture, and set both 
at ->domain_alloc time, yet still be unable to handle an actual mapping 
without knowing which instance(s) that needs to interact with (e.g. 
omap-iommu).

Thanks,
Robin.
