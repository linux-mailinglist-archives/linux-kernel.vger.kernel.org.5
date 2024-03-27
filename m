Return-Path: <linux-kernel+bounces-120759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF388DCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E6D296C28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B083A0B;
	Wed, 27 Mar 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z2wah1ZL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACA1EF13;
	Wed, 27 Mar 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539362; cv=none; b=Vgfb6KhdKe9n4GalZwSCdhMZyStk5WfmYLbfte5TqIAtFFtg8oRFQBR9GO2+ufqVGbjTEPL1OCFGHk191Lz93TaSMIi1yspXAj0gHlZFo/MmLisKe27e6VIxux6aOouxwA5dLJen4dis3aFSN1SBVhtq7W5YRnr9Vrj8JwIpC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539362; c=relaxed/simple;
	bh=ounXj3DhlrTptsGP5PqADS/b/FXdUIsxRjKDXHyl+/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F20FtbFSU4aEfJBLshzC9vRRywCi+X4TA2Kov1UbevsqRCiXPdKZLl41MGa/PdXoYRVk/DauhhG9OFEWz0SujkEsLm5ZQpSZGOhNAsRdHOUnCmLKTw9fe5xUMvChpH1HXe2y5QvqZaRP9XgFKjwoPtF4rmDpQDUYtNhwyliX/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z2wah1ZL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RAZBVg023622;
	Wed, 27 Mar 2024 11:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xBYM6f70ZR2pcj3sl/OZMO6mlexMav1G0aYjspFRsUI=; b=Z2
	wah1ZLardwVK8j6pZFVzFjlZ6Q+4suun75QYkbW/cndriRiTKgAaCAd6AnhKvaiL
	UWfbBfVbOKb6PyUnfIZ/gjPf3GmUG3CwxMd5wtM8XWie+jcllSMVPAGn17PIVxbQ
	l4idVPBXW0a9NRuyBtBYAHrR9xKqOlqzID+epIqzb/OoYctVtx8rjAfM4TxqY48D
	mXtM/qWA/CyVgnMIelnF/uHimhNcp0/UtOa72DRt9e2pvxyi2y9P0OAvyCcMERhn
	4vh9RTR7eJS4tr4Z1mpu87U3IE13dNdN93t4kb45VpcYQ0Wzmakpc9buTBWPCJJM
	qM8k5vLGwZ5Eb12mO4SA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4hu2r4he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:35:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RBZsQC012332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:35:54 GMT
Received: from [10.50.35.38] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 04:35:46 -0700
Message-ID: <e95634ba-b186-4fee-b93b-1ac4662fd2c4@quicinc.com>
Date: Wed, 27 Mar 2024 17:05:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: interconnect: add clock property to
 enable QOS on SC7280
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Georgi
 Djakov" <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-4-quic_okukatla@quicinc.com>
 <a259fa95-bfc3-4959-a159-8683df473e66@linaro.org>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <a259fa95-bfc3-4959-a159-8683df473e66@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yr9u7FbR8chIvxO5mMICAlHjtDjNN2Sz
X-Proofpoint-GUID: yr9u7FbR8chIvxO5mMICAlHjtDjNN2Sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270079



On 3/26/2024 1:00 PM, Krzysztof Kozlowski wrote:
> On 25/03/2024 19:16, Odelu Kukatla wrote:
>> Added clock property to enable clocks required for accessing
>> qos registers.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>  .../bindings/interconnect/qcom,sc7280-rpmh.yaml    | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> index b135597d9489..950ecdd5252e 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> @@ -35,6 +35,10 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Why is this flexible? Nothing in commit msg explains that. I gave the
> same talk twice, gave there examples, yet it is not enough...
> 

Clocks property is optional, and can be either 1 or 2 or none.
I think "minItems: 1" should be removed. If no clock property is mentioned in node that means no clock is required to be enabled for QoS configuration.

I will add back specific number of clocks based on interconnect compatible similar to what i did in v3.

> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132
> 
>> +
>>  required:
>>    - compatible
>>  
>> @@ -57,6 +61,7 @@ unevaluatedProperties: false
>>  
>>  examples:
>>    - |
>> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>>      interconnect {
>>          compatible = "qcom,sc7280-clk-virt";
>>          #interconnect-cells = <2>;
>> @@ -69,3 +74,12 @@ examples:
>>          #interconnect-cells = <2>;
>>          qcom,bcm-voters = <&apps_bcm_voter>;
> 
> If all devices have clocks, then you could add them here. It seems not
> all of them have clocks...
> 
> Best regards,
> Krzysztof
> 

Thanks,
Odelu

