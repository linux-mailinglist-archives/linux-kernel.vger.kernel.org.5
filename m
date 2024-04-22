Return-Path: <linux-kernel+bounces-152809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F28AC492
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AA1C20D15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7E482FF;
	Mon, 22 Apr 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="at/WdSkl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120F3BBCC;
	Mon, 22 Apr 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768988; cv=none; b=jWqE7CNdJm27ip5odKxt/j6Q6MltARFxjcF7x+ZQM0FIM8bL+ApbtFm4VSry9hiuADmSM2NVzhKbWsgiwgbniQnrAN0N9mDUbOTef+aiTGRVtaaJXU7/40qGtwL0AQ8nmLBuGBO9wuiw5FRL5vhxO1m8CkJAlFeYMD4dN4SD+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768988; c=relaxed/simple;
	bh=3oBvyGNxSuYMijZVDwZcw5SdaQBnGHWnbUxUVG0xroU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QlLOZztn2IXbvFRt4UKGdCb2GEr0lPJx419MCkbskeI1+3x5tYiQFmW/0udOuvQUtldg8jFJrPJy3bCOmTR44TsR3sauXiHCpyZS5+/vgfG+DTEjVLcH6J0WDurTNFTiaQLdV8Rv5POC9ohVIfTvwvfE4pCVD4lRaf2vq7yJ6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=at/WdSkl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M4pkDJ004641;
	Mon, 22 Apr 2024 06:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8+AHSqgDCLt5kVqcOc/DDpfiN1Kjj8zepKjiGwLaYlY=; b=at
	/WdSklQcuwLqFpGKzmuCtT0yteHc2sbz8A4nVENqaKDMZBBRYcqqds58CcBup/GM
	i/z/DPoeuwKl5tnhzy+6Q7dxgVEifS7gZUAQ8U4h31UI6zODZE90TEq0fSjSWoyG
	IDq+gXBPc7b37VJ6lfQtsR387C1NmM0PVZF8Bs1BEkPrAVWgObOyG5NwzX8wdgKU
	eu9Lht2D9CISTuC/N+UWjZoRHgMt5C4mkffGfe52/LHwa0BaX3NvJHflu8j/lx2E
	5DPo1g7XGrzUuQZgP6HMuthdR2hypdvwea/ApKoXYtUL+9yGnOS0hNogyGOI1llq
	T0ZC1S4Vxs+/dwCGBbqA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6fkkc1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 06:55:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M6ttgG015385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 06:55:55 GMT
Received: from [10.216.28.79] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 23:55:49 -0700
Message-ID: <0b2de111-b5b4-ebf8-c9c9-81e90e8d6039@quicinc.com>
Date: Mon, 22 Apr 2024 12:25:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/8] ASoC: dt-bindings: wcd937x: add bindings for
 wcd937x
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
 <20240416063600.309747-2-quic_mohs@quicinc.com>
 <09410fa9-265e-4fb0-9814-35dee465dbec@kernel.org>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <09410fa9-265e-4fb0-9814-35dee465dbec@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5uFMima1O_API5pXGC0wT_8c6L8L2-DK
X-Proofpoint-ORIG-GUID: 5uFMima1O_API5pXGC0wT_8c6L8L2-DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220030

On 4/17/2024 9:21 PM, Krzysztof Kozlowski wrote:
> On 16/04/2024 08:35, Mohammad Rafi Shaik wrote:
>> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>>
>> Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC
>> connected over SoundWire. This device has two SoundWire device RX and
>> TX respectively, supporting 3 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
>> 6 DMICs, MBHC.
>>
>> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>> ---
>>   .../bindings/sound/qcom,wcd937x.yaml          | 119 ++++++++++++++++++
>>   1 file changed, 119 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
>> new file mode 100644
>> index 000000000000..b45f823af04f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
> 
> No wildcards. This is wcd9370, right?
> 
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm WCD9370 Audio Codec
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

ACK

will remove '|' in next version patch set.

> 
>> +  Qualcomm WCD9370 Codec is a standalone Hi-Fi audio codec IC.
>> +  It has RX and TX Soundwire slave devices.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,wcd9370-codec
> 
> Can it be anything else than codec?
> 
>> +
>> +  reset-gpios:
>> +    description: GPIO spec for reset line to use
>> +    maxItems: 1
>> +
>> +  vdd-buck-supply:
>> +    description: A reference to the 1.8V buck supply
>> +
>> +  vdd-rxtx-supply:
>> +    description: A reference to the 1.8V rx supply
>> +
>> +  vdd-px-supply:
>> +    description: A reference to the 1.8V I/O supply
>> +
>> +  vdd-mic-bias-supply:
>> +    description: A reference to the 3.8V mic bias supply
>> +
>> +  qcom,tx-device:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: A reference to Soundwire tx device phandle
> 
> "A reference to phandle" is not correct. Phandle is the reference.
> Anyway, both are redundant.
> 

ACK,

>>
>> +  qcom,rx-device:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: A reference to Soundwire rx device phandle
>> +
>> +  qcom,micbias1-microvolt:
>> +    description: micbias1 voltage
>> +    minimum: 1800000
>> +    maximum: 2850000
>> +
>> +  qcom,micbias2-microvolt:
>> +    description: micbias2 voltage
>> +    minimum: 1800000
>> +    maximum: 2850000
>> +
>> +  qcom,micbias3-microvolt:
>> +    description: micbias3 voltage
>> +    minimum: 1800000
>> +    maximum: 2850000
>> +
>> +  '#sound-dai-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +  - qcom,tx-device
>> +  - qcom,rx-device
>> +  - qcom,micbias1-microvolt
>> +  - qcom,micbias2-microvolt
>> +  - qcom,micbias3-microvolt
>> +  - "#sound-dai-cells"
>> +
>> +unevaluatedProperties: false
> 
> This does not make sense without ref to dai-common, so this should point
> you to missing ref.

ACK,

Will add missing dai-common reference.
> 
>> +
>> +examples:
>> +  - |
>> +    codec {
>> +        compatible = "qcom,wcd9370-codec";
>> +        pinctrl-names = "default", "sleep";
>> +        pinctrl-0 = <&wcd_reset_n>;
>> +        pinctrl-1 = <&wcd_reset_n_sleep>;
>> +        reset-gpios = <&tlmm 83 0>;
>> +        vdd-buck-supply = <&vreg_l17b_1p8>;
>> +        vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +        vdd-px-supply = <&vreg_l18b_1p8>;
>> +        vdd-mic-bias-supply = <&vreg_bob>;
>> +        qcom,micbias1-microvolt = <1800000>;
>> +        qcom,micbias2-microvolt = <1800000>;
>> +        qcom,micbias3-microvolt = <1800000>;
>> +        qcom,rx-device = <&wcd937x_rx>;
>> +        qcom,tx-device = <&wcd937x_tx>;
>> +        #sound-dai-cells = <1>;
>> +    };
>> +
>> +    /* ... */
>> +
>> +    soundwire@3210000 {
>> +        #address-cells = <2>;
> 
> Drop this and other nodes.
> 
> Best regards,
> Krzysztof

ACK,

will use the qcom,wcd93xx-common.yaml file and will drop the common 
duplicate nodes

Thanks and Regards,
Rafi
> 


