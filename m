Return-Path: <linux-kernel+bounces-102971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D287B94B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE1E1C21EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D75D91E;
	Thu, 14 Mar 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SScl5PSS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B154677;
	Thu, 14 Mar 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404943; cv=none; b=BICi61uJf3A5pSHOlFToXADcLD2O8xMDVgy8mM0GcQlNkINxeY2L8wHwdgEU2MzKFQSp52Ir9LF5oWJ193Enxspa4GMkm1V9aXZg9nZIgGwmoDRy1LOoUSaVElh46wjd92I9/XwAPEK8NSfU0NzY7EsmATIP5hkunTEOqSKwENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404943; c=relaxed/simple;
	bh=JzGyHEjo0l5+t705kG/iFokneXzvLXfTOvbSZ7ORaQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GCiUP1imq8OFWqMXtGZbk6rjHWyDxwKLUikYqIyYGejicQ9BsaHg6Voy/fSrNamknMTOLlml7qdM6uCw5nl2bzlOaqsxsFCMKbIuOYXKxq6B+TWjfS/6fNbsgS4VSlKhCfp9xPYz56qJk/v7ZvX6Lb04tBaWbZN82A5Emz++2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SScl5PSS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E7MsdY032381;
	Thu, 14 Mar 2024 08:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K1DI991HbjwKV63GHD7ax9zV5QvSZ/lxPe4APc6ldJ4=; b=SS
	cl5PSSel+4Erl0rURjtjYVAKuPzxU5tpymP0aSMamry9oQQoNq/ndKGhvtSrISog
	QVRj1XoTte7kaNod5lRayBkTa9uxCrm15wb1mYLV5NJpOg9bcFrQqJQjwIz7zDWa
	w3tnGWg5pGf2r+lEfBKS0Iel+fYbIkHN2ibpZSC3s0hUkntD5zUS0h7Hzvgw33lz
	2r/Dcg8k+WyqCCM/VWL09DoiI8FFQDKMajHtYzKJPYhUI33xq3XiDdZhbDE1yjxD
	BhKkhqUeW9alHPvSCUHu7EdbJaD+y0duSJTrEmtFmoyUsavFPxLQAum0j90ExWgp
	hQ6A73Jn6HNmuBF7gGuw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wusxgghmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 08:28:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E8SaMu007591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 08:28:36 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 01:28:24 -0700
Message-ID: <1537d42f-fe61-48c2-9ee2-1066db71a19e@quicinc.com>
Date: Thu, 14 Mar 2024 13:58:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
        <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <linus.walleij@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
 <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
 <0b9e807d-e0ca-411c-9a2b-3d804bdf168c@quicinc.com>
 <d3dc9a41-4738-4634-9a98-fefcf418f552@linaro.org>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <d3dc9a41-4738-4634-9a98-fefcf418f552@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: USFgAHj3NNLldE_h9mKjClq3LRVoHbpe
X-Proofpoint-GUID: USFgAHj3NNLldE_h9mKjClq3LRVoHbpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_05,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140057

Hi Krzysztof,

On 2/21/2024 12:49 PM, Krzysztof Kozlowski wrote:
> On 21/02/2024 06:36, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 2/17/2024 7:43 PM, Krzysztof Kozlowski wrote:
>>> On 16/02/2024 11:39, Jishnu Prakash wrote:
>>>> Hi Krzysztof,
>>>>


>>
>>> How is this a problem?
>>
>> In qcom,spmi-vadc.yaml, we have the following top-level constraints for
>> the "reg" and "interrupts" properties:
>>
>>     reg:
>>       maxItems: 1
>>
>>     interrupts:
>>       maxItems: 1
>>
>> For the ADC5 Gen3 device being added now, these constraints cannot be
>> followed always, as there may be more than one peripheral under one
>> device instance, each with a corresponding interrupt. For example, the
>> above properties could be like this for a ADC5 Gen3 device:
>>
>>       reg = <0x9000>, <0x9100>;
>>       interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
>>                    <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
>>
>>
>> I could not overwrite the top-level constraints for the new device
>> "qcom,spmi-adc5-gen3" alone in qcom,spmi-vadc.yaml, so I tried to remove
>> the constraints from the top level and add them back conditionally for
>> all the device types separately, but you told me not to remove them
>> (full message:
>> https://lore.kernel.org/linux-iio/832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org/)
> 
> Because top-level widest constraints must stay, but it is not a problem.
> Most of the multi-device bindings work like this. Dozen of Qualcomm. Why
> you cannot do this the same way we do for all Qualcomm devices?
> 

I would like to clarify a point with you related to the top-level 
constraints, as I think I have not asked this exact question earlier.

For these top-level constraints in qcom,spmi-vadc.yaml:

     reg:
       maxItems: 1

     interrupts:
       maxItems: 1

If we add ADC5 Gen3 bindings in the same file, is it acceptable to 
update the top-level constraints to something like this:

     reg:
       minItems: 1
       maxItems: 2

     interrupts:
       minItems: 1
       maxItems: 2

followed by updating maxItems back to 1 for all the earlier existing 
compatibles, using if:then: conditions, like the below example?

   - if:
       properties:
         compatible:
           contains:
             const: qcom,spmi-adc5

     then:
       properties:
         reg:
           maxItems: 1
         interrupts:
           maxItems: 1


If this is acceptable, I'll add ADC5 Gen3 bindings in the same file with 
changes like the above, else I'll add them in a new file after first 
creating a common schema file as you suggested.

Thanks,
Jishnu

>>
>> Since these constraints cannot be modified for a specific new device or
> 
> ???
> 
>> removed, I think the only way to accommodate this new device is to add
>> it in its own new file.
>>
>> Is this a sufficient justification for adding this documentation in a
>> new file or do you have any other suggestions?
> 
> I already gave you the suggestions and you ignored them. Do like we are
> doing for all other drivers. Don't re-invent stuff. Either this fits to
> existing schema or come with common schema (and then provide rationale
> why it does not fit to existing one).
> 
> Best regards,
> Krzysztof
> 

