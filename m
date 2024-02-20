Return-Path: <linux-kernel+bounces-72663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970E85B6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01951F2195B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72225F55D;
	Tue, 20 Feb 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqrmziMM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC245F470;
	Tue, 20 Feb 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420183; cv=none; b=WZErmxEbIysC+4BZAQv+8CARGjiVugb8dr8BWhzOQQgeRGKQQBIFnSQze7BdLFjhf3OEOwISmkxJG99sqDQpb4dtI9YK09T6lzXwc9v+MZPo/iufXBG6bbJCIG1PLb8DAduP5kkvMD7k3h88BDbhX31q99I2W+CFeQnV1WIbZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420183; c=relaxed/simple;
	bh=ea59svrsOu5dlbLtjEWTyx/h8XZRAapX+GDyKmk2a3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AjWEbsV34g5kVrp0s7Krc5CekscXOjlJ2/taC+AU5hlgBjDOrk8XPr5jc0BLkRRiwdZhLsqNYyuBkBiA7ELj8Y8KmcOBk0VpHdUJLtbcobu2gpVqT2Olm8BadMLEJ/OA8uizS/4CwrjCOzgRSGf7HS0lfSbRqDMmiNJMpX65NM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqrmziMM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K5r9LK003222;
	Tue, 20 Feb 2024 09:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kVw+fboXihIUyvZwpaQXCeM5RRxi/luEJWrYH/mAOfk=; b=Mq
	rmziMMN0vsVo1Lc2XSNfhrZEJsSUj0Ds5BPnjGjaDnvriSolIgFwx13crtlUUkbZ
	t/LLw2YVA6DAeCUyiJu3xu9h8RNeoc+c5g2ckJlx6H8uGkly9h5NBQL4sQLZgBr0
	RmMcBVrHHJ6e4fqT5tOfd3lvOB+YGXQUn2kWQDWr9jVqfDKcyL9qWwR0hO9iMqwd
	/Gx4/IOF/07ETbGhKuslaNALJyhqK7WJPwnwGCgsDB1/dzJQb4IwRvupZG39TYU9
	WVLoV1n1C1mHXR/zGJnzSPNfb74t0pQm7Ta8Dh/EkDGl+inW9QLujEzsv5l3RzrP
	+JefpvxFz9W0opMdBe5g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcn15rg2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:09:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K99aPj013399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:09:36 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:09:28 -0800
Message-ID: <88845d8d-0b58-46fa-8c52-c1bb4f2d39f8@quicinc.com>
Date: Tue, 20 Feb 2024 17:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
 <CAA8EJprpMjK03rKPK6wgfVuDvBikYsKZjMc0Wusa1BxFOBnXhQ@mail.gmail.com>
 <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
 <CAA8EJppkDDACV_sLxFW4EqKQLHfo4ivSLwa_jCde8JpeH4YfzA@mail.gmail.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <CAA8EJppkDDACV_sLxFW4EqKQLHfo4ivSLwa_jCde8JpeH4YfzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ApRx7ApCfF2OZsSqIujvWosMVmXWkwsp
X-Proofpoint-GUID: ApRx7ApCfF2OZsSqIujvWosMVmXWkwsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200065



On 2/5/2024 9:48 PM, Dmitry Baryshkov wrote:
> On Mon, 5 Feb 2024 at 12:21, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>>
>>
>> On 2/5/2024 12:29 AM, Dmitry Baryshkov wrote:
>>> On Fri, 19 Jan 2024 at 11:07, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>
>>>> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
>>>> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
>>>> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
>>>> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
>>>> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
>>>> AIM300 Series is a highly optimized family of modules designed to
>>>> support AIoT applications. The module is mounted onto Qualcomm AIoT
>>>> carrier board to support verification, evaluation and development. It
>>>> integrates QCS8550 SoC, UFS and PMIC chip etc.
>>>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index 1a5fb889a444..9cee874a8eae 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -49,8 +49,10 @@ description: |
>>>>            msm8996
>>>>            msm8998
>>>>            qcs404
>>>> +        qcs8550
>>>>            qcm2290
>>>>            qcm6490
>>>> +        qcm8550
>>>
>>> Drop
>>
>> we want to introduce qcm8550 here.
> 
> What for. It either had to be introduced beforehand, or it should be
> introduced when one adds support for an actual qcm8550 device.
> 
>> qcm8550.dtsi has been introduced and qcs8550-aim300.dtsi include
>> qcm8550.dtsi directly.
>>
>> qcs8550 is a QCS version for qcm8550. qcs8550 is a sub-series of
>> qcm8550. qcm8550 will be a firmware release series from qualcomm.
> 
> All three names refer to the different kinds of the same platform. The
> base chip name is sm8550, so it is the last one. Other than that,
> there is no need to include any SoC compatibles other than the actual
> SoC name. See existing qrb devices for an inspiration.
> 
>>
>> here is the qcm8550/qcs8550 detailed spec:
>> https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
>>
>> here is the sm8550 detailed spec:
>> https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_C_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf
> 
> Can you please summarise the _actual_ difference between qcm8550,
> qcs8550 and sm8550? Are they fully soft compatible? Soft compatible
> except the modem? Pin compatible?

we can remove the qcm8550 compatible for now, and rename current dtsi 
back for qcs8550.dtsi, and only introduce qcm8550 later when there is 
qcm8550 board public-ed.

 From software point of view, currently it is single firmware image 
release for both qcm8550 and qcs8550, and the firmware is not grantee 
for sm8550 software compatible.

 From hardware point of view, qcm8550, qcs8550, sm8550 are different 
hardware socs, qcm8550, qcs8550 is derived from sm8550. We can only 
share the public document about those soc descriptions [1]. For soc 
itself, it is all similar difference for QCS and QCM version. 
Currently(in current development stage) there is not notable software 
difference needed other than memory map in kernel side needed to be 
differentiate from qcm8550 qcs8550 to sm8550.

[1] 
https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf

> 
>>
>>>
>>>>            qdu1000
>>>>            qrb2210
>>>>            qrb4210
>>>> @@ -93,6 +95,7 @@ description: |
>>>>      The 'board' element must be one of the following strings:
>>>>
>>>>            adp
>>>> +        aim300-aiot
>>>
>>> We probably need to drop this list, it doesn't surve its purposes.
>>
>> I am a little confused, do you expect to just remove this "aim300-aiot"
>> or do you want to introduce a new patch and remove the whole list?
> 
> If you were following the list, you would have seen the patch
> reworking the bindings.
> 
>>
>>>
>>>>            cdp
>>>>            dragonboard
>>>>            idp
>>>> @@ -904,6 +907,14 @@ properties:
>>>>              - const: qcom,qcs404-evb
>>>>              - const: qcom,qcs404
>>>>
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,qcs8550-aim300-aiot
>>>> +          - const: qcom,qcs8550-aim300
>>>> +          - const: qcom,qcs8550
>>>> +          - const: qcom,qcm8550
>>>
>>> In the review comments for v3 you have been asked to add qcom,sm8550.
>>> But not the qcom,qcm8550. I don't think that there is any need to
>>> mention qcm8550 here.
>>
>> qcm8550 and sm8550 are different, they have different firmware release.
>>
>> AIM300 AIoT board depend on qcs8550, qcs8550 is a QCS version for
>> qcm8550. Modem RF only in qcm8550 but not in qcs8550.
> 
> There are no 'dependecies' here. The thing is about declaring compatibility.
> In my opinion, the qcm8550 is an unnecesary part of the equation. You
> declare compatibility with the board itself,  with the SoM, with the
> actual SoC and with the base of the series. Anybody caring for the
> difference between QCM, QCS and SM will have to check for both
> qcom,qcs8550 and qcom,qcm8550 anyway, as there are differences on the
> modem side.
> 
>>>> +          - const: qcom,sm8550
>>>> +
>>>>          - items:
>>>>              - enum:
>>>>                  - qcom,sa8155p-adp
>>>> --
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

