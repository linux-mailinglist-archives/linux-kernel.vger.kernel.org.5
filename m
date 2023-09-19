Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31E7A5C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjISI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:28:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FCD911C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:28:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BE031FB;
        Tue, 19 Sep 2023 01:28:52 -0700 (PDT)
Received: from [10.57.94.129] (unknown [10.57.94.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9CDE3F59C;
        Tue, 19 Sep 2023 01:28:13 -0700 (PDT)
Message-ID: <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
Date:   Tue, 19 Sep 2023 09:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230919081519.GA3860249@myrica>
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

On 2023-09-19 09:15, Jean-Philippe Brucker wrote:
> On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>>> index 17dcd826f5c2..3649586f0e5c 100644
>>> --- a/drivers/iommu/virtio-iommu.c
>>> +++ b/drivers/iommu/virtio-iommu.c
>>> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>>>    	int ret;
>>>    	unsigned long flags;
>>> +	/*
>>> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
>>> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
>>> +	 */
>>> +	if (!viommu)
>>> +		return 0;
>>
>> Minor nit: I'd be inclined to make that check explicitly in the places where
>> it definitely is expected, rather than allowing *any* sync to silently do
>> nothing if called incorrectly. Plus then they could use
>> vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
>> (it did take me a moment to figure out how we could get to .iotlb_sync_map
>> with a NULL viommu without viommu_map_pages() blowing up first...)
> 
> They're not strictly equivalent: this check works around a temporary issue
> with the IOMMU core, which calls map/unmap before the domain is finalized.
> Once we merge domain_alloc() and finalize(), then this check disappears,
> but we still need to test nr_endpoints in map/unmap to handle detached
> domains (and we still need to fix the synchronization of nr_endpoints
> against attach/detach). That's why I preferred doing this on viommu and
> keeping it in one place.

Fair enough - it just seems to me that in both cases it's a detached 
domain, so its previous history of whether it's ever been otherwise or 
not shouldn't matter. Even once viommu is initialised, does it really 
make sense to send sync commands for a mapping on a detached domain 
where we haven't actually sent any map/unmap commands?

Thanks,
Robin.
