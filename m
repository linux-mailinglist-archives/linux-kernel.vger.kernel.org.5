Return-Path: <linux-kernel+bounces-82763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C2F86895E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E281C2273F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15A537F7;
	Tue, 27 Feb 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dsvJYMkN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F18535A8;
	Tue, 27 Feb 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016764; cv=none; b=g+FGoIUiOd3++/Qn/D+L25LgQFC5rVMs9IqAI4Jb1P5ilUzUW+13hEhZgVy1ffbW+5MzrQUxxsIonETsS+2VEFCEnFA3FO/BeRgETL4RzLqTfGsD7oRk6PvpxM9P7Vi55Cw6I7oUPQHjXU4dbTYBw8uUZQ0h+QEVe+9daK+XIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016764; c=relaxed/simple;
	bh=dKO0y759UC9YSaR7Ppcz61UlULFZAHRPSmrxSOQOtLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CNYSwWJq1T5Ryyu87FhTIKsz+8V1w1Gk02ZFK3V+NYXDz06JUqnHr6NkDQrOlv6E4Y8rrPj8MiMBREnLGs48/0Pp52mIV6qYoQPuGXJ2vbFdzQvEM6Im6To27JZ0aqqYbOXpJkHarq8qT9FViaQFbagn8RQefrQ/7EhZ/OfmHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dsvJYMkN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R4CDte010141;
	Tue, 27 Feb 2024 06:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JAnRhrEQMkbSmludSJIZ++ZdrMiRkw6Vfgx6Zv8WOZ4=; b=ds
	vJYMkNLrIQP+lGAK+KMOA2Zf8I7SBnjleZlzovoW6X3V5VCH4trjULBO+yGNjQ7V
	C6uYXvm45e9cTpJJVBnymNenrioKpWlctz9pXlF5KuOV89fgixzM8A50ZHn8AyNX
	rWFP7RDP7rAMtbDuqV6sa6MoPUgM50H6NLIGKubYwLa2ALXksjb4WiWil65bsFpm
	VKtfIKaj7CUGMu8pZo604uz1vucJJD5AIzxiF2VB+PBBAiYwWA2UQO5kGYbdPagw
	Y1heVDI4hG8dSr2hgM3eoiNyNRQJb2EPfGKQHMCOvccbpSp3+lm9DVJsnqc+hpG0
	ttoqyHXxw9tzxl4aWlQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8augab5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:52:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R6qcmK026827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:52:38 GMT
Received: from [10.214.66.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 22:52:32 -0800
Message-ID: <96733f86-c3dc-4f9d-88a5-654584b5acdf@quicinc.com>
Date: Tue, 27 Feb 2024 12:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Document rb5gen2-hdk board
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240202133638.4720-1-quic_wasimn@quicinc.com>
 <20240202133638.4720-2-quic_wasimn@quicinc.com>
 <CAA8EJpqARMwKhybgsFDKNZ=-uSAY=j4ocdZ=ax5U1KVPNXBTCg@mail.gmail.com>
From: Wasim Nazir <quic_wasimn@quicinc.com>
In-Reply-To: <CAA8EJpqARMwKhybgsFDKNZ=-uSAY=j4ocdZ=ax5U1KVPNXBTCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PwuGs0EHYnHbdDxWjXJM8ZM_7wBhDS12
X-Proofpoint-GUID: PwuGs0EHYnHbdDxWjXJM8ZM_7wBhDS12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=848 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270053



On 2/2/2024 8:21 PM, Dmitry Baryshkov wrote:
> On Fri, 2 Feb 2024 at 15:37, Wasim Nazir <quic_wasimn@quicinc.com> wrote:
>>
>> Document board bindings for Rb5 gen2 hardware development kit.
>> Rb5gen2-HDK is using Rb5 gen2 SOM which is based on QCS8550 SoC.
>> RB5gen2-HDK is development kit used for IOT solutions.
> 
> What is the actual marketing name for the SoM and the carrier board?
> The RB5gen2-HDK doesn't follow the previous example of the RB* boards
> and doesn't sound in tune with the RB3gen2 submission.
> Could you please sync up internally and come up with two similar names
> for the platforms with similar purpose?
> 
Discussed internally and we concluded on these official names, will 
update accordingly in next patch.

SOM: qcs8550-rb5gen2-som.dtsi
Board: qcs8550-rb5gen2.dts

>>
>> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 9cee874a8eae..ce5b5dfe0e46 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -104,6 +104,7 @@ description: |
>>           qcp
>>           qrd
>>           rb2
>> +        rb5gen2-hdk
>>           ride
>>           sbc
>>           x100
>> @@ -915,6 +916,14 @@ properties:
>>             - const: qcom,qcm8550
>>             - const: qcom,sm8550
>>
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8550-rb5gen2-hdk
>> +          - const: qcom,qcs8550-rb5gen2
>> +          - const: qcom,qcs8550
>> +          - const: qcom,qcm8550
>> +          - const: qcom,sm8550
>> +
>>         - items:
>>             - enum:
>>                 - qcom,sa8155p-adp
>> --
>> 2.43.0
>>
>>
> 
> 

Thanks & Regards,
Wasim

