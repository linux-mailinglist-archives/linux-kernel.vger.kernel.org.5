Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAB7FCA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjK1W7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1W7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:59:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEDA283;
        Tue, 28 Nov 2023 14:59:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D85752F4;
        Tue, 28 Nov 2023 15:00:30 -0800 (PST)
Received: from [10.57.71.132] (unknown [10.57.71.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33433F6C4;
        Tue, 28 Nov 2023 14:59:35 -0800 (PST)
Message-ID: <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
Date:   Tue, 28 Nov 2023 22:59:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by
 iommu-pages.h
Content-Language: en-GB
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com>
 <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
 <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-28 10:50 pm, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 5:34 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
>>> Convert iommu/dma-iommu.c to use the new page allocation functions
>>> provided in iommu-pages.h.
>>
>> These have nothing to do with IOMMU pagetables, they are DMA buffers and
>> they belong to whoever called the corresponding dma_alloc_* function.
> 
> Hi Robin,
> 
> This is true, however, we want to account and observe the pages
> allocated by IOMMU subsystem for DMA buffers, as they are essentially
> unmovable locked pages. Should we separate IOMMU memory from KVM
> memory all together and add another field to /proc/meminfo, something
> like "iommu -> iommu pagetable and dma memory", or do we want to
> export DMA memory separately from IOMMU page tables?

These are not allocated by "the IOMMU subsystem", they are allocated by 
the DMA API. Even if you want to claim that a driver pinning memory via 
iommu_dma_ops is somehow different from the same driver pinning the same 
amount of memory via dma-direct when iommu.passthrough=1, it's still 
nonsense because you're failing to account the pages which iommu_dma_ops 
gets from CMA, dma_common_alloc_pages(), dynamic SWIOTLB, the various 
pools, and so on.

Thanks,
Robin.

> Since, I included DMA memory, I specifically removed mentioning of
> IOMMU page tables in the most of places, and only report it as IOMMU
> memory. However, since it is still bundled together with SecPageTables
> it can be confusing.
> 
> Pasha
