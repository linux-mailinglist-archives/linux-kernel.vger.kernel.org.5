Return-Path: <linux-kernel+bounces-37017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC183AA41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC62290C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5677646;
	Wed, 24 Jan 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="prfLhcc8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC07763E;
	Wed, 24 Jan 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100456; cv=none; b=e4Nd/QztjpQn8ZzjLacrYdH1L20MsY8e6nuqGP1VPft+a34g8E5kbQZGOfAuuz4KOXVN6IChlrMqqz4PDySa/EXKyDf3KLv0Rc6wiVG3xUj6PDertjWWnEyBPM3X8QVJ705sCjK9Qpu7RjrTzzeXLxZ8BM4cHHuZbItNtABOX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100456; c=relaxed/simple;
	bh=ngwi/WQKx7M21CAQ5yqJYZz1lZBCQ4n603TIiNMV9+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IdKhKYqkVWcYK8JhFCwCdO6TtMl9acvk7ZdFOYilh4xpBNspLA94zEgBCdtI7ZzvotXnJO4oj+CIDKfrOzULgUEWQMYcrlOr8GEVv7HGh+s5X52jURmwIFhjXl3XYhAVdNsDA7JpC+Fq+7r15/yEmLyPnlsKsrcet8BhdId7Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=prfLhcc8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCarpj007834;
	Wed, 24 Jan 2024 12:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cPDvLw0z8mDxBOLQy9GvIGIBQNCLv9aLEEfo2mw9Wjg=; b=pr
	fLhcc8mhL34mqCM9emTzoRCKzuzqYSfxTvsh6gKN9fjeQrKtcZnblWTaes9sR4r0
	f/vHHyrJeOFjcxUNEX/EPqNI5dV+ZY9pZsRetKuYVW0l7frOFQzWS3kextSAMgSu
	x8raIHcGzhIN48JlmyOnCXAGV1v/GDeiZ7H+t/knjg4kyHYS+5/k+QMi10oWyAsL
	kFxjRM18FvSbzHMGfq4IKtTjpccVpecbpn4v6/xU8jaIvm3qmccjw92sNXImc1Qo
	NHZzBhwcLPK9m68bW5+N0y1EiAOLblqQAKAkWgJXs7bPZymS48CNKodSvI22NkSm
	QdebmHQ3Ax8WWG+F/4Rg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu1ccg6bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:47:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OClRso030466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:47:27 GMT
Received: from [10.216.58.233] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 04:47:20 -0800
Message-ID: <3e3e1e03-bb58-a09c-8ce5-4cd5481b059e@quicinc.com>
Date: Wed, 24 Jan 2024 18:17:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
 <54426665-90c5-4355-a174-f512004e11e5@linaro.org>
 <391f8f48-d1f5-702d-20d4-ae8b8a7ace58@quicinc.com>
 <065601d3-92e7-46cc-a7aa-116cd02b3c36@quicinc.com>
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <065601d3-92e7-46cc-a7aa-116cd02b3c36@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8OMXU6VLiaklhsQX2yhmp_UEyjDvftzZ
X-Proofpoint-GUID: 8OMXU6VLiaklhsQX2yhmp_UEyjDvftzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240092


On 1/22/2024 11:40 PM, Elliot Berman wrote:
>
> On 1/22/2024 2:07 AM, Amrit Anand wrote:
>> On 1/20/2024 7:02 PM, Konrad Dybcio wrote:
>>> On 20.01.2024 12:20, Amrit Anand wrote:
>>>> Qualcomm based DT uses two or three different identifiers. The SoC
>>>> based idenfier which signifies chipset and the revision for those
>>>> chipsets. The board based identifier is used to distinguish different
>>>> boards (e.g. IDP, MTP) along with the different types of same boards.
>>>> The PMIC attached to the board can also be used as a identifier for
>>>> device tree.
>>>>
>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
>>>>    include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
>>>>    2 files changed, 146 insertions(+), 8 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>>> new file mode 100644
>>>> index 0000000..807f134
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
>>>> @@ -0,0 +1,86 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwinfo/qcom,board-id.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: QCOM Board Identifier for Devicetree Selection
>>>> +
>>>> +maintainers:
>>>> +  - Amrit Anand <quic_amrianan@quicinc.com>
>>>> +  - Elliot Berman <quic_eberman@quicinc.com>
>>>> +
>>>> +description: |
>>> The '|'s are unnecessary in both commits, IIRC they're used for
>>> preserving formatting which we don't really need for non-styled
>>> plaintext
>> Sure, will do.
>>>> +  Qualcomm uses two and sometimes three hardware identifiers to describe
>>>> +  its boards
>>>> +      - a SoC identifier is used to match chipsets (e.g. sm8550 vs sm8450)
>>>> +      - a board identifier is used to match board form factor (e.g. MTP, QRD,
>>>> +        ADP, CRD)
>>>> +      - a PMIC identifier is occasionally used when different PMICs are used
>>>> +        for a given board/SoC combination.
>>>> +  Each field and helper macros are defined at::
>>>> +      - include/dt-bindings/arm/qcom,ids.h
>>>> +
>>>> +  For example,
>>>> +    / {
>>>> +        #board-id-cells = <2>;
>>>> +        board-id = <456 0>, <457 0>, <10 0>;
>>>> +        board-id-types = "qcom,soc-id", "qcom,soc-id", "qcom,board-id";
>>>> +     }
>>>> +
>>>> +allOf:
>>>> +  - $ref: board-id.yaml#
>>>> +
>>>> +properties:
>>>> +  board-id:
>>>> +    minItems: 2
>>> I believe some older platforms match exclusively based on socid, so
>>> perhaps 1 would be okay as well.
>>>
>>> [...]
>> Ok, considering legacy targets we can make it 1.
>>
>> But i think ideally it should always be recommended to have a board ID associated with a SoC ID, correct me if my understanding is wrong.
>>
> There is no "legacy" support needed here: Qualcomm's bootloaders
> need to be updated to adhere to the new proposed spec. I suppose
> we need to consider whether we have targets that only need SoC to
> differentiate?
>
>>>> +examples:
>>>> +   - |
>>>> +     #include <dt-bindings/arm/qcom,ids.h>
>>>> +     / {
>>>> +         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
>>>> +         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
>>>> +
>>>> +         #board-id-cells = <2>;
>>>> +         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
>>>> +                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
>>>> +                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
>>>> +         board-id-types = "qcom,soc-id",
>>>> +                          "qcom,soc-id",
>>>> +                          "qcom,board-id";
>>> So, would the matching here would be:
>>>
>>> loop over disctinct board-id-types
>>>      check if there's at least 1 match for all of them
>>>          use this dtb if that's the case
>>>
>>> stop booting / "best guess match"
>>>
>>> ?
>>>
>>> [...]
>> Yes, But the "if" checking would have preference in place.
>> The preference logic would look something like this,
>>
>> First will check for SoC-ID, if we have an exact match for SoC-ID then will proceed for board-ID match. Otherwise the DT would be discarded.
>> Once (exact) board-ID found, will proceed for subtype , pmic and so on.
>> Exact match and best match logic is used. Parameters like SoC-ID, board-ID are required to be best matched. Other few fields follow best match logic and best of the DT can be picked.
>>
>>>> +#define QCOM_BOARD_ID_MTP        0x8
>>>> +#define QCOM_BOARD_ID_DRAGONBOARD    0x10
>>>> +#define QCOM_BOARD_ID_QRD        0x11
>>>> +#define QCOM_BOARD_ID_HDK        0x1F
>>>> +#define QCOM_BOARD_ID_ATP        0x21
>>>> +#define QCOM_BOARD_ID_IDP        0x22
>>>> +#define QCOM_BOARD_ID_SBC        0x24
>>>> +#define QCOM_BOARD_ID_QXR        0x26
>>>> +#define QCOM_BOARD_ID_CRD        0x28
>>> Missing ADP/QCP/Ride (if they're separate)
>> Sure, will update. Would need to work with teams.
> There are probably more boards that we aren't aware of.
>
> Amrit, please add board IDs for all the boards that are
> in kernel.org.

Sure, will do that.

Thanks,
Amrit



