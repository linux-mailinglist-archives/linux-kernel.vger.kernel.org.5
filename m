Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52002803371
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjLDMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:54:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87663A8;
        Mon,  4 Dec 2023 04:54:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD8E1424;
        Mon,  4 Dec 2023 04:55:45 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F8DA3F5A1;
        Mon,  4 Dec 2023 04:54:54 -0800 (PST)
Message-ID: <4c55f016-ae17-4ba1-aa39-3b96f11bdb5a@arm.com>
Date:   Mon, 4 Dec 2023 12:54:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Vineet Gupta <vgupta@kernel.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1701268753.git.robin.murphy@arm.com>
 <590a4a1b7d10fb9bb1c42ca6cd438e98e6cc94a7.1701268753.git.robin.murphy@arm.com>
 <20231204084440.GB919@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231204084440.GB919@lst.de>
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

On 04/12/2023 8:44 am, Christoph Hellwig wrote:
> On Wed, Nov 29, 2023 at 05:43:04PM +0000, Robin Murphy wrote:
>> The dma_base, size and iommu arguments are only used by ARM, and can
>> now easily be deduced from the device itself, so there's no need to pass
>> them through the callchain as well.
> 
> This looks even better than the patch form Jason that only removed the
> iommu argument:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I wonder if it makes sense to also remove the coherent argument
> by setting up dev->dma_coherent in the caller.  That would require
> a pretty careful audit as we're doing a few weird things in that
> area, though.

Yeah, it crossed my mind too, but then I remembered we have at least the 
ARM stuff which may have already set a platform-specific value for 
dev->dma_coherent to take precedence over the firmware value, thus still 
needs to differentiate between the two at this point. Leaving the 
established argument in place seems neater IMO than having to go back to 
arch-specific mechanisms for that and any other similar tricks.

Thanks,
Robin.
