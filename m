Return-Path: <linux-kernel+bounces-72626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEA85B662
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3869C283C85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2A6168D;
	Tue, 20 Feb 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HFndHDmn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF45FF0F;
	Tue, 20 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419372; cv=none; b=Li/eTxrvfiYeTkkCx4M9md7G1pPkZ/mlDE8GTelHZvsLGXZTx/1ZpB/ExRT3R9X6hOjRSViHPN8/tAVjKOvsjA+AwFQS6R7RZixK2+NGPBGpPBeZe3wSnS/EYocw1Y5rTw/1GrGiTpJqCbfKzaGZC/GOOjnrTHxJ0LBfDRJfuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419372; c=relaxed/simple;
	bh=zDfSBLJbbIrbJcXCzH/p1UQgT0n+EWE9SZXW7U5XCyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T0evPhhfS1E31MtKyfO3gbq9/rHpY7nJNW/lfGfnJnzcGGtU6xLWTuIjh1cnKLzz58TiQd84gTgM4Xepl2g3e3xi4qTJNsy64+TC4jnwT+vLEDQPqdj9u8ryeCn60sUpkBEN2ZykKqiKF1uXuao4cAkNLtW4erOR0aOgnW2JFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HFndHDmn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K644pi002528;
	Tue, 20 Feb 2024 08:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LEgPixatv3d0ywWoeBLBebOftW6W4Qx9nCBkHmjSrkI=; b=HF
	ndHDmnd+7B9QTxfY5pLksAJ0U8T9ZNL9V0Tf9Q7wTE7G92u0tgoTfikBcjxvcisi
	OSQtcfbfaUuMus+j6F2pVRXOFDCalnzrmtUWSNr2rSRQq1IdAe/QNupsyDP2bM8A
	4/w9DWaafxdGgGXWaUQUr+AGhLyEvJ/NpdHI2oHA2y+PM1vxX0CISakj/O5GRicH
	Y0NwT5YlIRl6DA2h6wgWSlJIJApqWQEp+o1KX2TkDwIPLBoC9N5ai0ayPHVwjaUv
	xmYEu1HCcY0ZHnHJTZxJUR+kpsZO10g/TnB5Il0Ymy7MJzBOggxdcDh0DBe0b3wm
	G2RBSoryw7MwqkcsnmFw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcnbd8e4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 08:56:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K8u4sC027490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 08:56:04 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 00:55:59 -0800
Message-ID: <441ffff2-81a8-4b53-b15b-5ac6375d65c3@quicinc.com>
Date: Tue, 20 Feb 2024 16:55:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: arm: qcom: Document sm8650p soc and
 AIM500 AIoT board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-2-quic_jingyw@quicinc.com>
 <2fa4d857-7262-40df-a842-56945ecffb81@linaro.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <2fa4d857-7262-40df-a842-56945ecffb81@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q43VoSriLbrKjtzjHQhM1QKpaZNyE-Rn
X-Proofpoint-ORIG-GUID: q43VoSriLbrKjtzjHQhM1QKpaZNyE-Rn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=965 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200063


Hi Krzysztof,

On 2/5/2024 8:33 PM, Krzysztof Kozlowski wrote:
> On 05/02/2024 12:57, Jingyi Wang wrote:
>> Document Qualcomm SM8650P SoC and AIM500 AIoT board.
> 
> Please describe shortly what is SM8650P and what are the differences
> with SM8650.
> 
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 1999a5f2f254..e87ceb42853b 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -88,11 +88,13 @@ description: |
>>          sm8450
>>          sm8550
>>          sm8650
>> +        sm8650p
>>          x1e80100
>>  
>>    The 'board' element must be one of the following strings:
>>  
>>          adp
>> +        aim500-aiot
> 
> Drop this line.
> 
drop this line will cause fail dt binding check failure, any suggestion on that?
>>          cdp
>>          dragonboard
>>          idp
>> @@ -1051,6 +1053,13 @@ properties:
>>                - qcom,sm8650-qrd
>>            - const: qcom,sm8650
>>  
>> +      - items:
>> +          - enum:
>> +              - qcom,sm8650p-aim500-aiot
>> +          - const: qcom,sm8650p-aim500
>> +          - const: qcom,sm8650p
>> +          - const: qcom,sm8650
> 
> 
> 
> Best regards,
> Krzysztof
> 
Thanks,
Jingyi

