Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F4800B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbjLANHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLANHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:07:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E44310D;
        Fri,  1 Dec 2023 05:07:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9229F1007;
        Fri,  1 Dec 2023 05:08:28 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3165C3F73F;
        Fri,  1 Dec 2023 05:07:38 -0800 (PST)
Message-ID: <ae27768f-a6fa-4971-b44c-92899a81a2b7@arm.com>
Date:   Fri, 1 Dec 2023 13:07:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] dma-mapping: Clean up arch_setup_dma_ops()
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <cover.1701268753.git.robin.murphy@arm.com>
 <20231129203642.GO1312390@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231129203642.GO1312390@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 8:36 pm, Jason Gunthorpe wrote:
> On Wed, Nov 29, 2023 at 05:42:57PM +0000, Robin Murphy wrote:
>> Hi all,
>>
>> Prompted by Jason's proposal[1], here's a first step towards truly
>> unpicking the dma_configure vs. IOMMU mess. As I commented before, we
>> have an awful lot of accumulated cruft and technical debt here making
>> things more complicated than they need to be, and we already have hacks
>> on top of hacks trying to work around it, so polishing those hacks even
>> further is really not a desirable direction of travel. And I do know
>> they're hacks, because I wrote most of them and still remember enough of
>> the context of the time ;)
> 
> I quite like this, I was also looking at getting rid of those other
> parameters.
> 
> I wanted to take smaller steps because it is all pretty hairy.
> 
> One thing that still concerns me is if the FW data restricts the valid
> IOVA window that really should be reflected into the reserved ranges
> and not just dumped into the struct device for use by the DMA API.
> 
> Or, perhaps, viof/iommufd should be using the struct device data to
> generate some additional reserved ranges?
> 
> Either way, I would like to see the dma_iommu and the rest of the
> subsystem agree on what the valid IOVA ranges actually are.

Note that there is some intentional divergence where iommu-dma reserves 
IOVAs matching PCI outbound windows because it knows it wants to avoid 
clashing with potential peer-to-peer addresses and doesn't want to have 
to get into the details of ACS redirect etc., but we don't expose those 
as generic reserved regions because they're firmly a property of the PCI 
host bridge, not of the IOMMU group (and more practically, because we 
did do so briefly and it made QEMU unhappy). I think there may also have 
been some degree of conclusion that it's not the IOMMU API's place to 
get in the way of other domain users trying to do weird P2P stuff if 
they really want to.

Another issue is that the generic dma_range_map strictly represents 
device-specific constraints which may not always be desirable or 
appropriate to apply to a whole group. There wasn't really a conscious 
decision as such, but it kind of works out as why we still only consider 
PCI's bridge->dma_ranges (which comes from the same underlying data), 
since we can at least assume every device behind a bridge accesses 
memory through that bridge and so inherits its restrictions. However I 
don't recall any conscious decision for inbound windows to only be 
considered for DMA domain reservations rather than for proper reserved 
regions - pretty sure that's just a case of that code being added in the 
place where it seemed to fit best at the time (because hey it's more 
host bridge windows and we already have a thing for host bridge windows...)

Thanks,
Robin.
