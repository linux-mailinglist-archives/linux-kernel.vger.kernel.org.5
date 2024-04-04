Return-Path: <linux-kernel+bounces-130981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95022898183
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E941C25E63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B661526AC3;
	Thu,  4 Apr 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WMGB39oo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3964502E;
	Thu,  4 Apr 2024 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212386; cv=none; b=sVr83Agzvr+QR1TqWdnbKZLAyNPqwwvyj2RKELASXTHYdnFbWEZrUXQJPKlMyVGPo+nczFA6FK67XJtQlAGLCcNgXFWhJi9ZrcoJYAoA7lkL/GOvQ3qCS9J35FVjZOjW+owF70ti4oYDoPuCKG1J/DsrHdG8bZiT0teZXlP+bEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212386; c=relaxed/simple;
	bh=zBp7l1pCCRQ/1DG9vSOLOoejkezKYho1bTLSm2YyHk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KcAS2gUcVO72CBkgK2+j1XzDLxQ6adhHDY70eaZdLeQD3/3qsJ6Do46ST4Ro9BIcOJ7m3yESMHGI8RKH9qP+N73tFMoXSrcsP1VLzfCsDp6RXpC3K+tAyLWiFSjcnNNFS05Qt7gq8SBcts56MwbVd9PrjkAqtZNlV9RyhFkd6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WMGB39oo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4343n1P7009860;
	Thu, 4 Apr 2024 06:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ASwo3eh/R38HNfjkLyInf8LNYmY2dpS0uKZyDDjM+zg=; b=WM
	GB39oo4b94bFPdFYjzHjRjRan4lgCZck6DNgYyfmK2vLO6IkAaCqp8PSOD7ydU9k
	2lfcwemX7vuIsv8FN2iFt9pHfvtBtqjBPA2yXDu6feG9qx0vjMB5WSS0R4hy2Gjh
	gcd/wBzsAKHJ+5eWLjFq2ON2HokHtfqv2vEERPxIImGvH3ADHChLsoOXJn7zIQuD
	XNrOhYiTlKXJvadXTR/okzX44n1MNrqnL3Gy47rMSr5Mm3xRxVnsVjSd9Ff69WYz
	1LmUs+nUfoS+feg+5OmzqKID++aas0j4oiVLXtjAhjmOPDWcPxGmJ3Cxyc9rOR0M
	/dR1zzBL8u9SMxb61QGw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep0rr99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:32:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4346WkRX006233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 06:32:46 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 23:32:41 -0700
Message-ID: <a1623b86-6ab1-12cb-9bf8-37f7e09a0566@quicinc.com>
Date: Thu, 4 Apr 2024 12:02:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        <quic_gkohli@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_psodagud@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-6-quic_sibis@quicinc.com> <Zgvnh0J2a_fBH0bR@bogus>
 <CAPDyKFous+aoopf+=ZRugR78jyekobODqn7tqWRCyirPD+=eYw@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAPDyKFous+aoopf+=ZRugR78jyekobODqn7tqWRCyirPD+=eYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MvyK8rVB4OKEYMa7xOgX9ekBbMm1As71
X-Proofpoint-GUID: MvyK8rVB4OKEYMa7xOgX9ekBbMm1As71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=958
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404040041



On 4/3/24 16:50, Ulf Hansson wrote:
> On Tue, 2 Apr 2024 at 13:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Thu, Mar 28, 2024 at 03:20:44PM +0530, Sibi Sankar wrote:
>>> Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> index 4e0ec859ed61..d1d232cd1f25 100644
>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> @@ -68,6 +68,7 @@ CPU0: cpu@0 {
>>>                        compatible = "qcom,oryon";
>>>                        reg = <0x0 0x0>;
>>>                        enable-method = "psci";
>>> +                     clocks = <&scmi_dvfs 0>;
>>>                        next-level-cache = <&L2_0>;
>>>                        power-domains = <&CPU_PD0>;
>>>                        power-domain-names = "psci";
>>
>>
>> Any reason why you wouldn't want to use the new genpd based perf controls.
>> IIRC it was added based on mainly Qcom platform requirements.
>>
>> -                     clocks = <&scmi_dvfs 0>;
>>                        next-level-cache = <&L2_0>;
>> -                     power-domains = <&CPU_PD0>;
>> -                     power-domain-names = "psci";
>> +                     power-domains = <&CPU_PD0>, <&scmi_dvfs 0>;
>> +                     power-domain-names = "psci", "perf";
>>
>>
>> And the associated changes in the scmi dvfs node for cells property.
>>
>> This change is OK but just wanted to check the reasoning for the choice.
> 
> To me, it seems reasonable to move to the new binding with
> #power-domain-cells for protocol@13. This becomes more future proof,
> as it can then easily be extended to be used beyond CPUs.
> 
> That said, I just submitted a patch [1] to update the examples in the
> scmi DT doc to use  #power-domain-cells in favor of #clock-cells. I
> don't know if there is a better way to promote the new bindings?
> Perhaps moving Juno to use this too?
> 
> Kind regards
> Uffe

Sudeep/Ulfe,

Thanks I'll move to the new recommendation.

-Sibi

> 
> [1]
> https://lore.kernel.org/all/20240403111106.1110940-1-ulf.hansson@linaro.org/

