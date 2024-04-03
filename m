Return-Path: <linux-kernel+bounces-129151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E310C8965ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E8E1F26CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46E5A7A0;
	Wed,  3 Apr 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kBSDYUiM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635958AA9;
	Wed,  3 Apr 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128607; cv=none; b=eOQfiRhMgbv2EPqA0lwHTLgUC540n2BgozehsNufpZQjGrKwYG9PDz+9hA0dkpEbN6wTI4XyOS+XpSSCm35+PZIuVWrnimMctpJlFaNF5CM8jA29w3bwviUVhvXt9qFHZavg/7gZcSqaUm9t0J6OshCgJYEu/js088PX0FfP6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128607; c=relaxed/simple;
	bh=DNyuDMDOnU8oP0Fha06OgacP01yQsS5aEozJrYA4CHE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Xls6HxUxvDO30EK9zAJijAFt0GktEGQkbN4tt7PY0O+cU9r40UYNa4OY0lgzg4YlbLL500GGS/K+GxWT5uGhqA3TKwDUWhdzgOL2q3+t3XFjPoJ/diM4BhCeawW2g1L/eY/9j7tLfArxPc7Rhfsuw0RaPXpSplzpE1GC4L1gKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kBSDYUiM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4334vutI002584;
	Wed, 3 Apr 2024 07:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qLOH31cZZRibZuXjooWD41InFzEidvYCw3H2VVRIAmU=; b=kB
	SDYUiMRC7K+FAAEQz5Xsziv1eZoGK4DuTsD1J9gwJ8cVtJxTuZwL4fOVEL6FYjZR
	xQ+hWw1hedLsHrhlHsr2+4+F4WiXX0YsDjRVgRLEvJ97hSTu0lo+nAqXZM0qbSYK
	H8m0ktOd4TuSEq6sYV0SP93sLnhZ3PSySSEsEzX9FIfofo8LTGXVAC8itAp1DH0J
	pqIdkhUl1sBmEKILGZhvj7s1FknpuqewjnnW9u/70HhxeuY6dVfa3T6dHZI1+OVX
	IEl+sd4cEzWmhPcH+YtR5JABZ1JOoYkWPkPUcOK+0ieCJCGMpMP+aV1moWijadhm
	w0v8+jE6BjrKr7detkzw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8pj4hctw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:16:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4337GcLg024861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 07:16:38 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 00:16:32 -0700
Message-ID: <b3464321-0c52-4c41-9198-e9e7b16aa419@quicinc.com>
Date: Wed, 3 Apr 2024 12:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 6/6] arm64: dts: qcom: sm8650: Add video and
 camera clock controllers
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-7-quic_jkona@quicinc.com>
 <CAA8EJppHGS+W-aiXvJ2cE=jCbua8Y0Q+zv_QTs+C9V5+Y1vuZg@mail.gmail.com>
 <008d574f-9c9e-48c6-b64e-89fb469cbde4@quicinc.com>
Content-Language: en-US
In-Reply-To: <008d574f-9c9e-48c6-b64e-89fb469cbde4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DWxmH7rUyjwJgd5YkLC4jXT5bdJ63qhi
X-Proofpoint-GUID: DWxmH7rUyjwJgd5YkLC4jXT5bdJ63qhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030048



On 3/25/2024 11:38 AM, Jagadeesh Kona wrote:
> 
> 
> On 3/21/2024 6:43 PM, Dmitry Baryshkov wrote:
>> On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com> 
>> wrote:
>>>
>>> Add device nodes for video and camera clock controllers on Qualcomm
>>> SM8650 platform.
>>>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> index 32c0a7b9aded..d862aa6be824 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> @@ -4,6 +4,8 @@
>>>    */
>>>
>>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>>> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>>>   #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>>>   #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>>>   #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
>>> @@ -3110,6 +3112,32 @@ opp-202000000 {
>>>                          };
>>>                  };
>>>
>>> +               videocc: clock-controller@aaf0000 {
>>> +                       compatible = "qcom,sm8650-videocc";
>>> +                       reg = <0 0x0aaf0000 0 0x10000>;
>>> +                       clocks = <&bi_tcxo_div2>,
>>> +                                <&gcc GCC_VIDEO_AHB_CLK>;
>>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>>
>> The required-opps should no longer be necessary.
>>
> 
> Sure, will check and remove this if not required.


I checked further on this and without required-opps, if there is no vote 
on the power-domain & its peer from any other consumers, when runtime 
get is called on device, it enables the power domain just at the minimum 
non-zero level. But in some cases, the minimum non-zero level of 
power-domain could be just retention and is not sufficient for clock 
controller to operate, hence required-opps property is needed to specify 
the minimum level required on power-domain for this clock controller.

Thanks,
Jagadeesh

> 
>>> +                       #clock-cells = <1>;
>>> +                       #reset-cells = <1>;
>>> +                       #power-domain-cells = <1>;
>>> +               };
>>> +
>>> +               camcc: clock-controller@ade0000 {
>>> +                       compatible = "qcom,sm8650-camcc";
>>> +                       reg = <0 0x0ade0000 0 0x20000>;
>>> +                       clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>>> +                                <&bi_tcxo_div2>,
>>> +                                <&bi_tcxo_ao_div2>,
>>> +                                <&sleep_clk>;
>>> +                       power-domains = <&rpmhpd RPMHPD_MMCX>;
>>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>>> +                       #clock-cells = <1>;
>>> +                       #reset-cells = <1>;
>>> +                       #power-domain-cells = <1>;
>>> +               };
>>> +
>>>                  mdss: display-subsystem@ae00000 {
>>>                          compatible = "qcom,sm8650-mdss";
>>>                          reg = <0 0x0ae00000 0 0x1000>;
>>> -- 
>>> 2.43.0
>>>
>>>
>>
>>

