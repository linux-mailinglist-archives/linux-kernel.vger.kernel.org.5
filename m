Return-Path: <linux-kernel+bounces-132433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517D8994D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7665E1C22235
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC2225D6;
	Fri,  5 Apr 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EBEtK++F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53E28E2;
	Fri,  5 Apr 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712296581; cv=none; b=RszLwnV1Ni6NzA+mcDCsnaRFDPkI63jBL5feautjLJiaGBZZRTs/SSwjHpJE/KoaZ7t98tU+DK1HJ0ayJ3yQ1ESmxsqq3huyvBOGVX4gVTc+LmyEvs40d6HDk4CKmR1XyWrJxPo8IqZl2Q44hnDhqnC3ISYqzcKfPulLAQX+4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712296581; c=relaxed/simple;
	bh=QH8/0vdWKqLvLhlaTEOPY1DzLMUunfK1ga6DWG4zw04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RXnOXpKvYzh7Ciu/6yUtxGjE8dw7ziiqozNNzNILvXwQeRH66uVBBJvaDALxI56Muok5MfqxiFZcvveFxCvSnB0i9mylkIUL0Iu/KaL85xuuJUKQC+PhW87xTtqLSrpFSwDA9DF0KysgK5bkGBw97YBx8SV1vvTYRjWLFvTUizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EBEtK++F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4354A1Rw006626;
	Fri, 5 Apr 2024 05:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1K1ICFohwUMcrjPH/jfd5Kx8iMzTgyLlLZ+F++nl47Q=; b=EB
	EtK++Fc2vHI7ZITr3ZaSSfP5dVE7cTFmEA9rt5Y8zGYWA4I6hUz9XzVjWuiPwkjT
	GDq2guzYtWC/oxnuyD1YdyNmhLDpe14RnALA9N4EcwPPYPE0PMmh/joYOA6ndKnl
	nSMzaFvFN7EYSaGJzO6Of09QzV0AlFlnCprs5//19U8cdZx79Jb1Bs0F6pWEAZp5
	rmQsJHDYWYfRzPxNQRFP8h54nJyjDxWiQIsISDSiTwMOb5N39eupIrRnTyhSrMK4
	b2j7CZostbHrp7dnqlB4BjP9wIj5z7ax67IfgaE9OC7SVacIWCzivzwtQ0O5HeoE
	G8uhDgkSaLiX1gFN4NMA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa2qmgwmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 05:55:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4355tvJc028098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 05:55:57 GMT
Received: from [10.216.14.90] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 22:55:52 -0700
Message-ID: <797d67b9-9e09-8b84-9abc-dd4a4a2a40f5@quicinc.com>
Date: Fri, 5 Apr 2024 11:25:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd
 QCS6490 sound card
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
References: <20240404084631.417779-1-quic_mohs@quicinc.com>
 <20240404084631.417779-2-quic_mohs@quicinc.com>
 <CAA8EJpqWaYhzPKgTREtJnfdNZ4oSFZaRFM7Jhg+qd3AqadGOkA@mail.gmail.com>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <CAA8EJpqWaYhzPKgTREtJnfdNZ4oSFZaRFM7Jhg+qd3AqadGOkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dK7oSUXmyg45iWwZUgl1_v6plDCubSX_
X-Proofpoint-GUID: dK7oSUXmyg45iWwZUgl1_v6plDCubSX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_05,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=985 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050040

On 4/4/2024 2:23 PM, Dmitry Baryshkov wrote:
> On Thu, 4 Apr 2024 at 11:48, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>>
>> Document the bindings for the Qualcomm QCM6490 IDP and QCS6490 RB3Gen2
>> soc platforms sound card.
>>
>> The bindings are the same as for other newer Qualcomm ADSP sound cards,
>> thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
>> is separate.
>>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> index 2ab6871e89e5..ff1a27f26bc2 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -29,6 +29,8 @@ properties:
>>         - enum:
>>             - qcom,apq8016-sbc-sndcard
>>             - qcom,msm8916-qdsp6-sndcard
>> +          - qcom,qcm6490-sndcard
>> +          - qcom,qcs6490-rb3gen2-sndcard
> 
> My 2c: you are adding one soundcard for the SoC family (qcm6490) and
> another one for the particular board kind (qcs6490-rb3gen2). That
> doesn't seem logical.

The qcm6490-sndcard compatible for enabling soundcard on
qcm6490 IDP boards.

Will change compatible name as qcom,qcm6490-idp-sndcard.

Thanks,
Rafi.
> 
>>             - qcom,qrb5165-rb5-sndcard
>>             - qcom,sc7180-qdsp6-sndcard
>>             - qcom,sc8280xp-sndcard
>> --
>> 2.25.1
>>
>>
> 
> 


