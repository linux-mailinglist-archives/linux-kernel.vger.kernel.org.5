Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AFC7B5BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjJBUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjJBUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:08:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23B0FD3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:08:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32FCFC15;
        Mon,  2 Oct 2023 13:09:26 -0700 (PDT)
Received: from [10.57.2.38] (unknown [10.57.2.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9B313F762;
        Mon,  2 Oct 2023 13:08:46 -0700 (PDT)
Message-ID: <13d73200-2d53-7f95-fb93-5b5f422251cd@arm.com>
Date:   Mon, 2 Oct 2023 21:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Content-Language: en-GB
To:     Kelly Devilliv <kelly.devilliv@outlook.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-26 16:30, Kelly Devilliv wrote:
> On 2023-09-26 13:32, Christian König wrote:
>> Am 26.09.23 um 06:33 schrieb Kelly Devilliv:
>>> On 2023-09-26 01:58, Christian König wrote:
>>>> Am 25.09.23 um 16:17 schrieb Kelly Devilliv:
>>>>> On 2023-09-25 19:16, Robin Murphy wrote:
>>>>>> On 2023-09-25 04:59, Kelly Devilliv wrote:
>>>>>>> Dear all,
>>>>>>>
>>>>>>> I am working on an ARM-V8 server with two gpu cards on it.
>>>>>>> Recently, I need to test pcie peer to peer communication between
>>>>>>> the two gpu cards, but the throughput is only 4GB/s.
>>>>>>> After I explored the gpu's kernel mode driver, I found it was
>>>>>>> using the dma_map_resource() API to map the peer device's MMIO
>>>>>>> space. The arm iommu driver then will hardcode a 'IOMMU_MMIO' prot in the later dma map:
>>>>>>>            static dma_addr_t iommu_dma_map_resource(struct device
>>>>>>> *dev, phys_addr_t phys,
>>>>>>>                                     size_t size, enum
>>>>>>> dma_data_direction dir, unsigned long attrs)
>>>>>>>             {
>>>>>>>                     return __iommu_dma_map(dev, phys, size,
>>>>>>>                                             dma_info_to_prot(dir,
>>>>>>> false,
>>>>>>> attrs) | IOMMU_MMIO,
>>>>>>>                                             dma_get_mask(dev));
>>>>>>>             }
>>>>>>>
>>>>>>> And that will finally set the 'ARM_LPAE_PTE_MEMATTR_DEV' attribute
>>>>>>> in PTE, which may have a negative impact on the performance of the
>>>>>>> pcie peer to peer transactions.
>>>>>>>             /*
>>>>>>>              * Note that this logic is structured to accommodate Mali LPAE
>>>>>>>              * having stage-1-like attributes but stage-2-like permissions.
>>>>>>>              */
>>>>>>>             if (data->iop.fmt == ARM_64_LPAE_S2 ||
>>>>>>>                 data->iop.fmt == ARM_32_LPAE_S2) {
>>>>>>>                     if (prot & IOMMU_MMIO)
>>>>>>>                             pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>>>>>>>                     else if (prot & IOMMU_CACHE)
>>>>>>>                             pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>>>>>>>                     else
>>>>>>>                             pte |= ARM_LPAE_PTE_MEMATTR_NC;
>>>>>>>             } else {
>>>>>>>                     if (prot & IOMMU_MMIO)
>>>>>>>                             pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>>>>>>>                                     << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>>>>                     else if (prot & IOMMU_CACHE)
>>>>>>>                             pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>>>>>                                     << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>>>>             }
>>>>>>>
>>>>>>> I tried to remove the 'IOMMU_MMIO' prot in the dma_map_resource()
>>>>>>> API and re-compile the linux kernel, the throughput then can be up
>>>>>>> to 28GB/s.
>>>>>>> Is there an elegant way to solve this issue without modifying the linux kernel?
>>>>>>> e.g., a substitution of dma_map_resource() API?
>>>>>> Not really. Other use-cases for dma_map_resource() include DMA
>>>>>> offload engines accessing FIFO registers, where allowing
>>>>>> reordering, write-gathering, etc. would be a terrible idea. Thus it
>>>>>> needs to assume a "safe" MMIO memory type, which on Arm means Device-nGnRE.
>>>>>>
>>>>>> However, the "proper" PCI peer-to-peer support under
>>>>>> CONFIG_PCI_P2PDMA ended up moving away from the dma_map_resource()
>>>>>> approach anyway, and allows this kind of device memory to be
>>>>>> treated more like regular memory (via
>>>>>> ZONE_DEVICE) rather than arbitrary MMIO resources, so your best bet
>>>>>> would be to get the GPU driver converted over to using that.
>>>>> Thanks Robin.
>>>>> So your suggestion is we'd better work out a new implementation just
>>>>> as what it does under CONFIG_PCI_P2PDMA instead of just using the
>>>>> dma_map_resource() API?
>>>>>
>>>>> I have explored the GPU drivers from AMD, Nvidia and habanalabs,
>>>>> e.g., and found they all using the dma_map_resource() API to map the
>>>>> peer device's bar address.
>>>>> If so, is it possible to be a common performance issue in PCI
>>>>> peer-to-peer scenario?
>>>> That's not an issue, but expected behavior.
>>>>
>>>> When you enable IOMMU every transaction needs to go through the root
>>>> complex for address translation and you completely lose the
>>>> performance benefit of PCIe P2P.
>>> Thanks Christian. That's true.
>>>
>>>> This is a hardware limitation and not really related to
>>>> dma_map_resource() in any way.
>>>>
>>> But when I removed the 'IOMMU_MMIO' prot in dma_map_resource(), the
>>> performace was significantly improved (from 4GB/s to 28GB/s), which was
>>> almost the same as what it can be when IOMMU disabled. So I guess in my common pci topology,
>>> what really matters may not be whether IOMMU is enabled or not, but in fact the attributes in dma mapping or ARM PTE does.
>>
>> The key point is that nobody really supports that configuration, so you probably
>> will find nobody looking into it.
>>
>> BTW: ARM isn't really supported as a platform for amdgpu either. E.g. we have
>> seen tons of boards which implement the PCIe standard incorrectly, if you run
>> into any trouble with that you are pretty much on your own.
>>
> 
> Thanks Christian. I am going to disable IOMMU or do some tricks in PCI peer-to-peer scenario.
> 
>>> I don't know if there is a way to make the memory attributes more configurable in order to be distinguished
>>> from the "safe" MMIO memory type, which on Arm means Device-nGnRE as Robin said.
>>
>> Well we would need to extend dma_map_resource() to include some use case
>> so that the mapping attributes don't need to be guessed.
>>
> 
> Hi Robin,
> 
> Is there any chance to extend the dma_map_resource() API as discussed above?

As Christoph says, no. There are things one could do to make a 
minimal-effort bodge in a downstream kernel, but upstream we already 
have a dedicated PCI peer-to-peer API, so we have no reason and no 
desire to also attempt to crowbar P2P support into a different API which 
isn't designed for it. Sure there exist some drivers that went ahead of 
the game and did their own thing before we realised that 
dma_map_resource() just fundamentally wouldn't be a good fit for P2P as 
initially suggested, but all that means is that if they're still doing 
that today, they're now lagging behind and it's on them to update to the 
newer solution if they want to benefit from all its goodness. Note that 
this isn't just maintainer semantics or relatively straightforward 
things like memory attributes; I believe the proper API can also handle 
stuff like direct P2P when you do have an IOMMU but don't have ACS 
upstream redirect, which dma_map_resource() could never do.

Thanks,
Robin.
