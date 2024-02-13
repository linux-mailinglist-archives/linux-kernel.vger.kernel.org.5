Return-Path: <linux-kernel+bounces-63445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FA852FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7186B2305D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE42381BF;
	Tue, 13 Feb 2024 11:37:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BC3717A;
	Tue, 13 Feb 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824220; cv=none; b=TTs9ZKNUIPPeK4lGas2SlvForusu1DImY6s/KUvPIdTFRBcVugtlOSiwiZ8sUz8Whw4NIyMcXrsuzGQAbkYO/nmUPcq9QwC6SYws4U+RFCCtdGNBj4MYc0l0VT5nU+shQ3y7K1SEy81hcu8oPydjMnoEDnQ5EFgV+9fdn+LlFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824220; c=relaxed/simple;
	bh=fFDvWAUz+casXDjawJVoU0ywBbK/Tmx5t81ELfWtrYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drp2SyebBbdBigXhoEDvG0VrLxqoVmdcBrv4so620x8UisiM2GvZ4EoU+YSXcpfuBKfXAwi+w1ZMVg9Lyge2fgfiE4ifjhFiX3dynxTetUzEEqLSzoCEkK0Q25s2eG4X2HiMjkhysEvqVC2BIQKR0+AFh7LX9Saph3GveLZX+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF0ACDA7;
	Tue, 13 Feb 2024 03:37:37 -0800 (PST)
Received: from [10.57.49.48] (unknown [10.57.49.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36EA3F5A1;
	Tue, 13 Feb 2024 03:36:53 -0800 (PST)
Message-ID: <edfe34ca-06d4-46c8-81a2-f713ab74d769@arm.com>
Date: Tue, 13 Feb 2024 11:36:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in
 qcom_smmu_create()
Content-Language: en-GB
To: Pratyush Brahma <quic_pbrahma@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: quic_c_gdjako@quicinc.com, andersson@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, djakov@kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, konrad.dybcio@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, quic_sukadev@quicinc.com, robdclark@gmail.com,
 robh+dt@kernel.org, will@kernel.org
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
 <20240213062608.13018-1-quic_pbrahma@quicinc.com>
 <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
 <ccb6b2a2-040b-46cc-9b72-2e4bd4c75565@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ccb6b2a2-040b-46cc-9b72-2e4bd4c75565@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-13 8:17 am, Pratyush Brahma wrote:
> 
> On 2/13/2024 1:36 PM, Dmitry Baryshkov wrote:
>> On Tue, 13 Feb 2024 at 08:27, Pratyush Brahma 
>> <quic_pbrahma@quicinc.com> wrote:
>>> Currently, during arm smmu probe, struct arm_smmu_device pointer
>>> is allocated. The pointer is reallocated to a new struct qcom_smmu in
>>> qcom_smmu_create() with devm_krealloc() which frees the smmu device
>>> after copying the data into the new pointer.
>>>
>>> The freed pointer is then passed again in devm_of_platform_populate()
>>> inside qcom_smmu_create() which causes a use-after-free issue.
>>>
>>> Fix the use-after-free issue by reassigning the old pointer to
>>> the new pointer where the struct was copied by devm_krealloc().
>>>
>>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>> Missing Fixes tag.
> Haven't added as the patchset in-reply-to hasn't been merged to 
> linux-next. Please refer my next reply.
>>
>>> ---
>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> index ed5ed5da7740..49eaeed6a91c 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> @@ -710,6 +710,7 @@ static struct arm_smmu_device 
>>> *qcom_smmu_create(struct arm_smmu_device *smmu,
>>>          qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), 
>>> GFP_KERNEL);
>>>          if (!qsmmu)
>>>                  return ERR_PTR(-ENOMEM);
>>> +       smmu = &qsmmu->smmu;
>>>
>>>          qsmmu->smmu.impl = impl;
>>>          qsmmu->data = data;
>>> @@ -719,7 +720,7 @@ static struct arm_smmu_device 
>>> *qcom_smmu_create(struct arm_smmu_device *smmu,
>>>          if (ret)
>>>                  return ERR_PTR(ret);
>> What is the tree that you have been developing this against? I don't
>> see this part of the code in the linux-next.
> This is in reply to the patchset at: 
> https://lore.kernel.org/all/20240201210529.7728-4-quic_c_gdjako@quicinc.com
> The aforementioned patchset introduces this bug. This is a suggested fix 
> to the bug.

Unless you are the 0-day bot, please just point out bugs in under-review 
patches via regular review comments rather than sending patches for 
unmerged patches.

There is nothing to fix in mainline, and as I commented on the binding 
patch I'm not sure I agree with the fundamental premise for touching 
qcom_smmu_create() in this series at all.

Thanks,
Robin.

>>> -       return &qsmmu->smmu;
>>> +       return smmu;
>>>   }
>>>
>>>   /* Implementation Defined Register Space 0 register offsets */
>>> -- 
>>> 2.17.1
>>>
>>>
> Thanks,
> Pratyush

