Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1027AB28F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjIVNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIVNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:13:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE62196
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:13:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF12DA7;
        Fri, 22 Sep 2023 06:14:01 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDA5F3F5A1;
        Fri, 22 Sep 2023 06:13:22 -0700 (PDT)
Message-ID: <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
Date:   Fri, 22 Sep 2023 14:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922124130.GD13795@ziepe.ca>
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

On 22/09/2023 1:41 pm, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
>>>> They're not strictly equivalent: this check works around a temporary issue
>>>> with the IOMMU core, which calls map/unmap before the domain is
>>>> finalized.
>>>
>>> Where? The above points to iommu_create_device_direct_mappings() but
>>> it doesn't because the pgsize_bitmap == 0:
>>
>> __iommu_domain_alloc() sets pgsize_bitmap in this case:
>>
>>          /*
>>           * If not already set, assume all sizes by default; the driver
>>           * may override this later
>>           */
>>          if (!domain->pgsize_bitmap)
>>                  domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> 
> Dirver's shouldn't do that.
> 
> The core code was fixed to try again with mapping reserved regions to
> support these kinds of drivers.

This is still the "normal" code path, really; I think it's only AMD that 
started initialising the domain bitmap "early" and warranted making it 
conditional. However we *do* ultimately want all the drivers to do the 
same, so we can get rid of ops->pgsize_bitmap, because it's already 
pretty redundant and meaningless in the face of per-domain pagetable 
formats.

Thanks,
Robin.
