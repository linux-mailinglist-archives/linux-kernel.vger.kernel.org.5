Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8433F7A071F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjINOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjINOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:19:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C027B1FD8;
        Thu, 14 Sep 2023 07:19:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A341FB;
        Thu, 14 Sep 2023 07:20:06 -0700 (PDT)
Received: from [10.57.93.68] (unknown [10.57.93.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591303F738;
        Thu, 14 Sep 2023 07:19:27 -0700 (PDT)
Message-ID: <9595ad86-ecdc-e613-1b34-113b8c3123cd@arm.com>
Date:   Thu, 14 Sep 2023 15:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-GB
To:     Alexandre Bailon <abailon@baylibre.com>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
 <741920ba-8637-5e28-695c-699b46351590@arm.com>
 <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
 <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
 <21fef8eb-6482-fd8c-118a-c4d9da4cfbaf@baylibre.com>
 <2b8e19488386b5ca523f010b8ded750a4213f84e.camel@mediatek.com>
 <68673ccd-d136-075e-6704-7d1558388784@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <68673ccd-d136-075e-6704-7d1558388784@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 09:07, Alexandre Bailon wrote:
> Hi,
> 
> Sorry for long delay before the response.
> 
> On 2/14/23 06:48, Yong Wu (吴勇) wrote:
>> On Tue, 2023-01-31 at 16:31 +0100, Alexandre Bailon wrote:
>>>
>>> On 1/31/23 15:15, Robin Murphy wrote:
>>>> On 31/01/2023 1:08 pm, Alexandre Bailon wrote:
>>>>> Hi Robin
>>>>>
>>>>> On 1/30/23 13:04, Robin Murphy wrote:
>>>>>> On 2023-01-30 10:27, Alexandre Bailon wrote:
>>>>>>> Currently, the driver can allocate an unmanaged iommu domain.
>>>>>>> But, this only works for SoC having multiple bank or multiple
>>>>>>> iova
>>>>>>> region.
>>>>>>
>>>>>> That is for good reason - there is only a single pagetable per
>>>>>> bank,
>>>>>> so if there are multiple devices assigned to a single bank,
>>>>>> they
>>>>>> cannot possibly be attached to different domains at the same
>>>>>> time.
>>>>>> Hence why the banks are modelled as groups.
>>>>>
>>>>> I understand.
>>>>> I am trying to upstream a remoteproc driver but the remote
>>>>> processor is
>>>>> behind the iommu.
>>>>> remoteproc can manage the iommu but it requires an unmanaged
>>>>> domain.
>>>>> I tried a couple of things but this cause code duplication,
>>>>> implies many hacks and not always reliable.
>>>>> Do you have any suggestion ?
>>>>
>>>> If there are other active devices behind the same IOMMU, and the
>>>> remoteproc device cannot be isolated into its own bank using the
>>>> existing IOMMU driver logic, then the remoteproc driver cannot
>>>> manage
>>>> the IOMMU directly, and must just use the regular DMA API. There's
>>>> no
>>>> way around it; you can't have two different parts of the kernel
>>>> both
>>>> thinking they have exclusive control of a single IOMMU address
>>>> space at
>>>> the same time. Similarly, remoteproc also cannot take explicit
>>>> control
>>>> of a multi-device group if it's not actually in control of the
>>>> other
>>>> devices, since their drivers will not be expecting the DMA address
>>>> space
>>>> to suddenly change underfoot - that's why iommu_attach_device() has
>>>> the
>>>> check which you presumably ran into.
>>>
>>> Unfortunately, we can't just use the regular DMA API.
>>> Basically, the firmware use static addresses (and the remote core is
>>> only supposed to access addresses between 0x60000000 and 0x70000000).
>>> When we use DMA API, we get a random address that doesn't match what
>>> the
>>> firmware would expect.
>>> remoteproc use directly the iommu API to map physical address to the
>>> static address expected by the firmware when DMA API can't be use.
>>
>> If this master can only support this special address, We could handle
>> it inside this driver.
>>
>> Could you help try to add these two patches [3/11] and [4/11]?
>>
>> [3/11]
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20230214031114.926-4-yong.wu@mediatek.com/
>> [4/11]
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20230214031114.926-5-yong.wu@mediatek.com/
>>
>>
>> and, then add the logical for mt8365(I see the APU is larb0 port10/11
>> in the binding):
>> --------------------------------
>>
>> +#define MT8365_REGION_NR        2
>> +
>> +static const struct mtk_iommu_iova_region
>> mt8365_multi_rgn[MT8365_REGION_NR] = {
>> +    { .iova_base = 0x0,        .size = SZ_4G},           /* 0 ~
>> 4G. */
>> +    { .iova_base = 0x60000000,    .size = SZ_256M},      /* APU
>> */
>> +};
>> +
>>
>> xxxxxxxxxxx
>>
>> +static const unsigned int
>> mt8365_larb_region_msk[MT8365_REGION_NR][MTK_LARB_NR_MAX] = {
>> +    [0] = {~(u32)(BIT(10) | BIT(11)), ~0, ~0, ~0, ~0, ~0},
>> +    [1] = {[0] = BIT(10) | BIT(11)},
>> +};
>> +
>>   static const struct mtk_iommu_plat_data mt8365_data = {
>>       .m4u_plat    = M4U_MT8365,
>>       .flags        = RESET_AXI | INT_ID_PORT_WIDTH_6,
>>       .inv_sel_reg    = REG_MMU_INV_SEL_GEN1,
>>       .banks_num    = 1,
>>       .banks_enable    = {true},
>> -    .iova_region    = single_domain,
>> -    .iova_region_nr    = ARRAY_SIZE(single_domain),
>> +    .iova_region    = mt8365_multi_rgn,
>> +    .iova_region_nr    = ARRAY_SIZE(mt8365_multi_rgn),
>> +    .iova_region_larb_msk = mt8365_larb_region_msk,
>>       .larbid_remap    = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear
>> mapping. */
>>   };
>> --------------------------------
>>
>> After that, If we call DMA API with the device whose dtsi has
>> M4U_PORT_APU_READ/M4U_PORT_APU_WRITE. The iova should be located at
>> that special address. Sorry, I have no board to test.
>>
> 
> I have not yet tested the patches but it will only address one part of 
> the problem.
> Using your patches, I could allocate some shared memory using DMA API 
> but the main issue still remain.
> The firmware is not relocatable at all. So, once the firmware is built, 
> it is expected to be loaded at a specific address.
> Remoteproc framework support this use case. Using the resource table, 
> the firmware expose to remoteproc what device address is expect and 
> remoteproc manually call iommu_map to satisfy this requirement.
> Using DMA_API, I could allocate the memory to load the firmware but I 
> could not be sure that the DMA address will be the one expected by 
> firmware.

I think the solution to this is now to use the new DT binding to require 
an IOMMU identity mapping of the firmware region[1], such that it's all 
taken care of for you.

Thanks,
Robin.

[1] https://git.kernel.org/torvalds/c/af0d81357cc5
