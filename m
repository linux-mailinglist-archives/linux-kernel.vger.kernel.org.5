Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B27EE5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjKPREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKPREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:04:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1F621A8;
        Thu, 16 Nov 2023 09:04:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D1F1595;
        Thu, 16 Nov 2023 09:05:02 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B4C03F6C4;
        Thu, 16 Nov 2023 09:04:15 -0800 (PST)
Message-ID: <4db1b4d2-0aa9-4640-b7d7-7d18ab64569a@arm.com>
Date:   Thu, 16 Nov 2023 17:04:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-GB
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, joro@8bytes.org, a39.skl@gmail.com,
        konrad.dybcio@linaro.org, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
 <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
 <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
 <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
 <0d290a5c-081f-4dfa-af9a-b061e6134662@quicinc.com>
 <CAA8EJprHppoN6rg8-rS1F+4kynQqmV1L3OiHFnJ0HyrshywFig@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAA8EJprHppoN6rg8-rS1F+4kynQqmV1L3OiHFnJ0HyrshywFig@mail.gmail.com>
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

On 16/11/2023 3:24 pm, Dmitry Baryshkov wrote:
> On Thu, 16 Nov 2023 at 14:45, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>>
>>
>> On 11/15/2023 4:33 PM, Dmitry Baryshkov wrote:
>>> On Wed, 15 Nov 2023 at 11:45, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>> On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>
>>>>>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>>>>>> through SoC specific reset ops, which is disabled in the default MMU-500
>>>>>> reset ops, but is expected for context banks using ACTLR register to
>>>>>> retain the prefetch value during reset and runtime suspend.
>>>>>
>>>>> Please refer to Documentation/process/submitting-patches.rst and
>>>>> rephrase this following the rules there.
>>>>>
>>>>
>>>> Noted, will go through the description once and rephrase it
>>>> in next version complying with rules.
>>>>
>>>>>>
>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>> ---
>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
>>>>>>     1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> index 0eaf6f2a2e49..fa867b1d9d16 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>>>>>>            return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>>>>>     }
>>>>>>
>>>>>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +       u32 reg;
>>>>>> +
>>>>>> +       arm_mmu500_reset(smmu);
>>>>>> +
>>>>>> +       /* Re-enable context caching after reset */
>>>>>> +       for (i = 0; i < smmu->num_context_banks; ++i) {
>>>>>> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>>>>>> +               reg |= CPRE;
>>>>>> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>>>>>> +       }
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>     static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>>>>>>     {
>>>>>>            int ret;
>>>>>>
>>>>>> -       arm_mmu500_reset(smmu);
>>>>>> +       qcom_smmu500_reset(smmu);
>>>>>
>>>>> Is this applicable for sdm845? For all other platforms supported by
>>>>> qcom_smmu_500 implementation?
>>>>>
>>>>
>>>> In arm_mmu500_reset operation drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>>> CPRE bit is reset for all SoC based on mmu500 platform, hence for all
>>>> Qualcomm SoCs including sm845 we are setting back the CPRE bit.
>>>
>>> The errata for the CoreLink MMU-500 requires CPRE to be disabled for
>>> all revisions before r2p2. Do we know whether these SoC used CoreLink
>>> MMU-500 and which version of it?
>>>
>>
>> Just checked all these SoCs are using r2p4 revision.
>> So CPRE needs to be enabled back here then?
> 
> can be enabled, yes.

There are still open errata #562869 and #1047329 which might need this 
workaround. I guess one could argue that we're not (knowingly) using 
nested translation at the moment, and also probably not running this in 
situations which would end up using short-descriptor format, however 
stuff like pKVM and IOMMUFD could potentially change those assumptions 
in future, so they still feel a bit sketchy to me.

Thanks,
Robin.

> 
>>
>>>>
>>>>>>
>>>>>>            /*
>>>>>>             * To address performance degradation in non-real time clients,
>>>>>> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>>>>>>            .init_context = qcom_smmu_init_context,
>>>>>>            .cfg_probe = qcom_smmu_cfg_probe,
>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>> -       .reset = arm_mmu500_reset,
>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>            .write_s2cr = qcom_smmu_write_s2cr,
>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>     };
>>>>>> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>>>>>            .init_context = qcom_smmu_init_context,
>>>>>>            .cfg_probe = qcom_smmu_cfg_probe,
>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>> -       .reset = arm_mmu500_reset,
>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>            .write_s2cr = qcom_smmu_write_s2cr,
>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>     };
>>>>>> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>>>>>     static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>>>>>>            .init_context = qcom_adreno_smmu_init_context,
>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>> -       .reset = arm_mmu500_reset,
>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>            .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>>>>>>            .write_sctlr = qcom_adreno_smmu_write_sctlr,
>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>> --
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
> 
> 
> 
