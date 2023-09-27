Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB227B09CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjI0QQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0QQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:16:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D67392;
        Wed, 27 Sep 2023 09:16:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F6B1FB;
        Wed, 27 Sep 2023 09:17:11 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3893F59C;
        Wed, 27 Sep 2023 09:16:28 -0700 (PDT)
Message-ID: <96c0892f-20e6-db1f-f310-9b09d419aa6a@arm.com>
Date:   Wed, 27 Sep 2023 17:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
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
 <ZRP8CiBui7suB5D6@8bytes.org>
 <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
 <e1efbbd827e34800bd7fb0ea687645cc6c65e1ab.camel@linux.ibm.com>
 <6dab29f58ac1ccd58caaee031f98f4d0d382cbcd.camel@linux.ibm.com>
 <a672b6b122c7a5f708614346885c190a6960aaea.camel@linux.ibm.com>
 <20230927154009.GN13795@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230927154009.GN13795@ziepe.ca>
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

On 27/09/2023 4:40 pm, Jason Gunthorpe wrote:
> On Wed, Sep 27, 2023 at 05:24:20PM +0200, Niklas Schnelle wrote:
> 
>> Ok, another update. On trying it out again this problem actually also
>> occurs when applying this v12 on top of v6.6-rc3 too. Also I guess
>> unlike my prior thinking it probably doesn't occur with
>> iommu.forcedac=1 since that still allows IOVAs below 4 GiB and we might
>> be the only ones who don't support those. From my point of view this
>> sounds like a mlx5_core issue they really should call
>> dma_set_mask_and_coherent() before their first call to
>> dma_alloc_coherent() not after. So I guess I'll send a v13 of this
>> series rebased on iommu/core and with an additional mlx5 patch and then
>> let's hope we can get that merged in a way that doesn't leave us with
>> broken ConnectX VFs for too long.
> 
> Yes, OK. It definitely sounds wrong that mlx5 is doing dma allocations before
> setting it's dma_set_mask_and_coherent(). Please link to this thread
> and we can get Leon or Saeed to ack it for Joerg.
> 
> (though wondering why s390 is the only case that ever hit this?)

Probably because most systems happen to be able to satisfy the 
allocation within the default 32-bit mask - the whole bottom 4GB of IOVA 
space being reserved is pretty atypical.

TBH it makes me wonder the opposite - how this ever worked on s390 
before? And I think the answer to that is "by pure chance", since upon 
inspection the existing s390_pci_dma_ops implementation appears to pay 
absolutely no attention to the device's DMA masks whatsoever :(

Robin.
