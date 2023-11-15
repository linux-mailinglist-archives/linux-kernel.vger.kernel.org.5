Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0F7EC65D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjKOOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjKOOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:53:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107678E;
        Wed, 15 Nov 2023 06:53:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706491FB;
        Wed, 15 Nov 2023 06:53:53 -0800 (PST)
Received: from [10.57.83.164] (unknown [10.57.83.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01893F641;
        Wed, 15 Nov 2023 06:53:05 -0800 (PST)
Message-ID: <c75d107a-44cb-4df3-b583-13719df1f8be@arm.com>
Date:   Wed, 15 Nov 2023 14:53:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-GB
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
        joro@8bytes.org, dmitry.baryshkov@linaro.org, a39.skl@gmail.com,
        konrad.dybcio@linaro.org, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-2-quic_bibekkum@quicinc.com>
 <372885ab-b24d-44ae-afb8-76755bcd6e21@arm.com>
 <40282b6e-9524-4a88-97ca-3ce890317279@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <40282b6e-9524-4a88-97ca-3ce890317279@quicinc.com>
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

On 2023-11-15 1:54 pm, Bibek Kumar Patro wrote:
> 
>>> @@ -467,6 +505,9 @@ static struct arm_smmu_device 
>>> *qcom_smmu_create(struct arm_smmu_device *smmu,
>>>       qsmmu->smmu.impl = impl;
>>>       qsmmu->cfg = data->cfg;
>>>
>>> +    if (data->actlrcfg && (data->actlrcfg->size))
>>> +        qsmmu->actlrcfg = data->actlrcfg;
>>
>> Do we really need to replicate multiple parts of the data, or would it 
>> be sensible to just replace qsmmu->cfg with qsmmu->data and handle the 
>> further dereferences in the places that want them?
>>
> 
> Mm, could not understand this properly. :( Could you help explain more 
> please?
> As per my understanding aren't data and qsmmu different structures.
> qcom_smmu is a superset of arm_smmu housing additonal properties
> and qcom_smmu_match_data is kind of a superset of arm_smmu_impl with
> additional specific implmentations, so both needs to be in place?
> Apologies if I understood your statement incorrectly.

My point is that the data is static and constant, so there's really no 
point storing multiple pointers into different bits of it. So rather than:

	qsmmu->cfg = data->cfg;
	qssmu->actlrcfg = data->actlrcfg;
	...
	do_something(qsmmu->cfg);
	...
	do_other_thing(qsmmu->actlrcfg);

we can just store the one pointer and have:

	qsmmu->data = data;
	...
	do_something(qsmmu->data->cfg);
	...
	do_other_thing(qsmmu->data->actlrcfg);

Thanks,
Robin.

>>> +
>>>       return &qsmmu->smmu;
>>>   }
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> index 593910567b88..4b6862715070 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> @@ -9,6 +9,7 @@
>>>   struct qcom_smmu {
>>>       struct arm_smmu_device smmu;
>>>       const struct qcom_smmu_config *cfg;
>>> +    const struct actlr_config *actlrcfg;
>>>       bool bypass_quirk;
>>>       u8 bypass_cbndx;
>>>       u32 stall_enabled;
>>> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
>>>   };
>>>
