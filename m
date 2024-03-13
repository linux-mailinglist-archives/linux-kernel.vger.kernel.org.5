Return-Path: <linux-kernel+bounces-101184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A987A3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACA21C214B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA517552;
	Wed, 13 Mar 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hr36eVei"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573710A11;
	Wed, 13 Mar 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316565; cv=none; b=T8Dx7LgfiU39s0QosfbrHzwlQeW3+VHIQGshT9BOkZbXHsbfrVXALeEleD3ariswjnQnIw24/ufcimiD+TMm1CnhbOT/te772A/a99K39x9CKupTmWGk0oEL7BBcu3ibTI6Rd5aLtAiP6yTTYf6g8G1m9MtluI5PHGbrlaI3xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316565; c=relaxed/simple;
	bh=dhVJDW8Qrm+wYLkmkfOSA2Xkk7LDzKs59l51l7avfp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+EpRzZcyHj/1m/BX8Vnh1fI8JTygmIRsP9I/wbbfoEgijM2+JL4KSmIDYOmH+D2aw7i3xagWGv4KMCJvBZ8EoJRuGJW9D7aP+H4O7H4YX3Ds+qRC9pb3IkMcyLrRJ2GquEkJU6rjpa10HyvbPR1iLO9sT1DwdsJMkTxXXTpGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hr36eVei; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D6vvGE015895;
	Wed, 13 Mar 2024 07:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/o5Xh5ectBhVkTIwKBNcUl1dyYPGYXuvz1gsgQ2Mby4=; b=hr
	36eVeiw1OtPSBOMdN4G18xV5C0kpQfj6VVsg15qKsOkWBvXPcXDNfL6HLOzYw+wc
	J7NGM7O1VHTKzXYqXOgZ8hdJ7rNVLJhP6lKVt8ecAGY7ZCdV/wv/rUjBAESGI5wd
	TIjNGFFszAos6wvg0yY1AR4Hmnk4yQG0MCKGd599kDjjpQKnbyhDGecZJ5Mz8GK6
	Co3q3hnLfwkalwwFHFlEskwNcmwrr0wu6t00s75qqSRtcAFrwG/G0OcdGGKzMzR3
	yafa7SPD1pMLKoKy+92bKYBWp6+rRuf3RU4sYy0giQK3o9RDZbrKbWSsNIHFm9b0
	GIi+44WWXEDIy1PSUlCA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu3jn0gf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:55:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D7tkZZ014179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:55:46 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 00:55:41 -0700
Message-ID: <f515f9f4-b87c-465b-83c0-f4b7b5c47840@quicinc.com>
Date: Wed, 13 Mar 2024 15:55:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240312025807.26075-1-quic_tengfan@quicinc.com>
 <20240312025807.26075-2-quic_tengfan@quicinc.com>
 <0d768f17-22d9-448e-9253-8498b61bf71e@linaro.org>
 <31b02b76-88ff-42d7-a665-18d2661e028c@quicinc.com>
 <6a3b5c9d-6375-457f-83c9-269746c1612a@linaro.org>
 <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
 <60a0e51f-dc0e-4bbf-8127-f987ac2aae71@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <60a0e51f-dc0e-4bbf-8127-f987ac2aae71@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PLqYrTjrwVbBk5_3lOQx60xH3Cu4P-w8
X-Proofpoint-GUID: PLqYrTjrwVbBk5_3lOQx60xH3Cu4P-w8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130057



On 3/13/2024 3:23 PM, Krzysztof Kozlowski wrote:
> On 13/03/2024 02:30, Tengfei Fan wrote:
>>
>>
>> On 3/12/2024 6:55 PM, Krzysztof Kozlowski wrote:
>>> On 12/03/2024 08:47, Tengfei Fan wrote:
>>>>
>>>>
>>>> On 3/12/2024 3:41 PM, Krzysztof Kozlowski wrote:
>>>>> On 12/03/2024 03:58, Tengfei Fan wrote:
>>>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>>>
>>>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> Wasn't this applied?
>>>>
>>>> My test code base on tag: next-20240308, this patch is still not applied.
>>>>
>>>> In fact, the following dt binding check warning only can be got before
>>>> this patch is applied.
>>>>
>>>
>>> Please read all emails in the previous thread. You ignored two emails in
>>> the past and apparently one more recent.
>>
>> I don't know if you mean I ignored the email which related with "Patch
>> applied" tag from Linus Walleij. If so, the following is the reasion why
>> I still include this patch:
> 
> Yep, that's the one. Please do not send patches which were already
> applied. It causes unnecessary effort on reviewer and maintainer side.
> 
>>
>> I synced the latest upstream code on 03/12/2024, the latest tag is
>> next-20240308, this tag still doesn't include this patch[PATCH v3 1/2].
> 
> Happens, considering Linus applied it after 8th of March, I think.
> 
>>
>> Dt binding check still get warning if I only send [PATCH v3 2/2] patch
>> to upstream base on next-20240308. so I include this patch[PATCH v3 1/2]
> 
> If you send patch 1+2, dt_binding_check will have exactly the same
> result. I don't know about what sort of dt binding check you talk, but
> for all cases: you changed nothing by sending these two patches in that
> regard. Only noise on the lists.

The dt binding check failed which Rob Herring remind me in previous 
patch series as the following:

Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
/example-0/pinctrl@f100000: failed to match any schema with
compatible: ['qcom,sm4450-tlmm']

This failed is introduced by 
https://lore.kernel.org/linux-arm-msm/20231206020840.33228-2-quic_tengfan@quicinc.com/. 
Something got broken aroud -m flags for dtschema, so indeed no reports 
this unmatched compatibles warning when this patch was revriwed. We also 
have some discusstion in patch email.

The patch[PATCH v3 1/2] is made for fix this previous patch dt binding 
check failed. So dt binding check failed will disappear after this 
patch[PATCH v3 1/2] is applied.

> 
>> in patch series even if this patch have "Patch applied" tag.
>>
>> Looking forward to getting your advice if submitting patch series this
>> way is problematic.
> 
> Do not send patches which are known to be applied.

Yes, I will be careful not to resend the patch which have already been 
applied in the future work.

Do you think it is necessary to send another version patch series for 
remove this applied patch[PATCH v3 1/2] from patch series?

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

