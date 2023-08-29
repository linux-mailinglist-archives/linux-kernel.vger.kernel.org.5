Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636AE78C8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjH2PkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjH2Pj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:39:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D76B7;
        Tue, 29 Aug 2023 08:39:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623062F4;
        Tue, 29 Aug 2023 08:40:33 -0700 (PDT)
Received: from [10.1.34.35] (010265703453.arm.com [10.1.34.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4671B3F738;
        Tue, 29 Aug 2023 08:39:47 -0700 (PDT)
Message-ID: <f2a46201-d807-d7af-bf84-8c99b33cd916@arm.com>
Date:   Tue, 29 Aug 2023 16:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v11 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
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
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230717-dma_iommu-v11-5-a7a0b83c355c@linux.ibm.com>
 <9a466109-01c5-96b0-bf03-304123f435ee@arm.com>
 <b46210ce00b46ce42b8487e5670cc56b4458031f.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b46210ce00b46ce42b8487e5670cc56b4458031f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-23 15:21, Niklas Schnelle wrote:
[...]
>>> +struct dma_iommu_options {
>>> +#define IOMMU_DMA_OPTS_PER_CPU_QUEUE	0L
>>
>> Nit: if the intent is to add more flags then that will no longer make
>> sense, and if not then we may as well just have a bool ;)
>>
>>> +#define IOMMU_DMA_OPTS_SINGLE_QUEUE	BIT(0)
> 
> My thinking was that the above two options are mutually exclusive with
> per-CPU encoded as BIT(0) unset and single queue as set. Then other
> options could still use the other bits. It's true though that the below
> use of IOMMU_DMA_OPTS_PER_CPU_QUEUE is a nop so maybe just drop that?
> Or we could use an enum even if I don't forsee more than these 2 queue
> types.

My point was that the value 0 can only mean "all flags not set", so 
while we can very much have the semantic of "single queue flag not set 
means percpu queue", we cannot infer "0 means percpu queue" unless "all 
flags" and "single queue flag" are the same thing. As soon as any 
additional flag is defined, 0 then has a different meaning which may 
well not even be a combination that's useful to put a specific name to.

I'd like to hope it's sufficiently obvious from the implementation that 
the opposite of a single queue is multiple queues, since contextually 
this is already all happening in distinct paths from the case of no queue.

Thanks,
Robin.
