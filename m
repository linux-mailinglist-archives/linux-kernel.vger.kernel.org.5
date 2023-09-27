Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2F7AFFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjI0J0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjI0J03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:26:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24A64EB;
        Wed, 27 Sep 2023 02:26:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C3F1FB;
        Wed, 27 Sep 2023 02:27:05 -0700 (PDT)
Received: from [10.57.0.175] (unknown [10.57.0.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5E73F59C;
        Wed, 27 Sep 2023 02:26:19 -0700 (PDT)
Message-ID: <068aeebd-df24-5097-96e3-ebaaa7a763fd@arm.com>
Date:   Wed, 27 Sep 2023 10:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <ZRLy_AaJiXxZ2AfK@8bytes.org> <20230926160832.GM13795@ziepe.ca>
 <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 09:55, Niklas Schnelle wrote:
> On Tue, 2023-09-26 at 13:08 -0300, Jason Gunthorpe wrote:
>> On Tue, Sep 26, 2023 at 05:04:28PM +0200, Joerg Roedel wrote:
>>> Hi Niklas,
>>>
>>> On Fri, Aug 25, 2023 at 12:11:15PM +0200, Niklas Schnelle wrote:
>>>> Niklas Schnelle (6):
>>>>        iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
>>>>        s390/pci: prepare is_passed_through() for dma-iommu
>>>>        s390/pci: Use dma-iommu layer
>>>>        iommu/s390: Disable deferred flush for ISM devices
>>>>        iommu/dma: Allow a single FQ in addition to per-CPU FQs
>>>>        iommu/dma: Use a large flush queue and timeout for shadow_on_flush
>>>
>>> Turned out this series has non-trivial conflicts with Jasons
>>> default-domain work so I had to remove it from the IOMMU tree for now.
>>> Can you please rebase it to the latest iommu/core branch and re-send? I
>>> will take it into the tree again then.
>>
>> Niklas, I think you just 'take yours' to resolve this. All the
>> IOMMU_DOMAIN_PLATFORM related and .default_domain = parts should be
>> removed. Let me know if you need anything
>>
>> Thanks,
>> Jason
> 
> Hi Joerg, Hi Jason,
> 
> I've run into an unfortunate problem, not with the rebase itself but
> with the iommu/core branch.
> 
> Jason is right, I basically need to just remove the platform ops and
> .default_domain ops. This seems to work fine for an NVMe both in the
> host and also when using the IOMMU with vfio-pci + KVM. I've already
> pushed the result of that to my git.kernel.org:
> https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=b4/dma_iommu
> 
> The problem is that something seems to  be broken in the iommu/core
> branch. Regardless of whether I have my DMA API conversion on top or
> with the base iommu/core branch I can not use ConnectX-4 VFs.
> 
> # lspci
> 111a:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
> # dmesg | grep mlx
> [    3.189749] mlx5_core 111a:00:00.0: mlx5_mdev_init:1802:(pid 464): Failed initializing cmdif SW structs, aborting
> [    3.189783] mlx5_core: probe of 111a:00:00.0 failed with error -12
> 
> This same card works on v6.6-rc3 both with and without my DMA API
> conversion patch series applied. Looking at mlx5_mdev_init() ->
> mlx5_cmd_init(). The -ENOMEM seems to come from the following
> dma_pool_create():
> 
> cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
> 
> I'll try to debug this further but wanted to let you know already in
> case you have some ideas.

I could imagine that potentially something in the initial default domain 
conversion somehow interferes with the DMA ops in a way that ends up 
causing alloc_cmd_page() to fail (maybe calling zpci_dma_init_device() 
at the wrong point, or too many times?). FWIW I see nothing that would 
obviously affect dma_pool_create() itself.

Robin.

> Either way as it doesn't seem to be related
> to the DMA API conversion I can sent that out again regardless if you
> want, really don't want to miss another cycle.
> 
> Thanks,
> Niklas
