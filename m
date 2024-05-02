Return-Path: <linux-kernel+bounces-166376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B93A8B99C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D2A2876A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11060B95;
	Thu,  2 May 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QMFTKOww"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA35C8EF;
	Thu,  2 May 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648201; cv=none; b=Z01tia1G9cRf6z/nbGTngn7XYRJdrY+egSFbqgnjG5+p1KocBI/Eg38t55y+sQVfGzP1k7nbcEf/CEZiJjtbOcezXIE0D4V1VZbF+nduciI5dIAs+vfQdMdAYXZQAXcdGHQHCwSJGfuNge5ylg2SagmwjfriWo49rzcZTwwzeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648201; c=relaxed/simple;
	bh=unJP1NwysKlSIETESGSQdBq48jBlZec/OubfEgTf09A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IxGCf7xgIMc6raiZNah6Wp6LyFDBxBfrnKbzTH36F/2AhBMVXlLliYWSEjZKGognU43Yp6p/NKW0088ym4JaBfd9cPt5ClDSorrY76drKC1q88pct0n07CzfaXZxmBHnDQOZ97LcPuGDgtG58cqqyzAQ2ic9qI6yo1brYZBooO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QMFTKOww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4425pI1M018346;
	Thu, 2 May 2024 11:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1R54idS8kX6ibLVp50hFilNZrY8MA6+STSvHKvSkkOg=; b=QM
	FTKOwwFTrW6nxJgwmXoqO6a3jwh5629anl0FLNBeyoWyUXCChyvh66PZwI8RbYgQ
	iJz6CqoZKN2Y0pW6ij4XbApNrqrLvnUMn8Ti74/rgS7aqeSaYEqmtqaXwtZluCKQ
	jfxTzEaKis4pZU4E0YxopiqghejtKAXH2fbeFLFWXZQibL7niNJgwLGXh7vXhs62
	Qa7O9RnNAckQene4AoKd1m2RiycKKMtjF4ZFwdrNCdnnUIJBpTzO2s02Tgir/Fb2
	xoBelNy3HPzfcT0rLeH1r0GBu/i1C2a2aj6YIuXjdEs5vppILuFYVrH+7i/E+zxr
	YNvypvhUmf0R/wj2K3jg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71jbr56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 11:09:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442B9sPQ013474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 11:09:54 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 04:09:48 -0700
Message-ID: <b21f2d88-3429-41cd-b8df-4353845c1320@quicinc.com>
Date: Thu, 2 May 2024 16:39:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/8] dt-bindings: clock: qcom: Fix the incorrect order
 of SC8280XP camcc header
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
 <20240430142757.16872-6-quic_jkona@quicinc.com>
 <ZjHklEN4zV5QG5Zv@hovoldconsulting.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <ZjHklEN4zV5QG5Zv@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bZ-kJ4VXR6TYYluN2ZLfL6vMolDF_x39
X-Proofpoint-ORIG-GUID: bZ-kJ4VXR6TYYluN2ZLfL6vMolDF_x39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_01,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405020070



On 5/1/2024 12:13 PM, Johan Hovold wrote:
> On Tue, Apr 30, 2024 at 07:57:54PM +0530, Jagadeesh Kona wrote:
>> Fix the incorrect order of SC8280XP camcc header file in SM8450 camcc
>> bindings.
> 
> Try to avoid using the word "fix" in the commit summary (Subject) and
> commit message for things like this which are essentially cleanups to
> avoid making it sound like a bug fix (which automated tooling may then
> select for backporting).
>   

Thanks Johan for your review!

Yes, will remove the word "fix" in commit subject and message.

>> Fixes: 206cd759fbd2 ("dt-bindings: clock: Add SC8280XP CAMCC")
> 
> Also drop the Fixes tag as this is not a bug fix.
> 

Sure, will drop Fixes tag in next series.

Thanks,
Jagadeesh

>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> index fa0e5b6b02b8..bf23e25d71f5 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> @@ -14,9 +14,9 @@ description: |
>>     domains on SM8450.
>>   
>>     See also::
>> +    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>>       include/dt-bindings/clock/qcom,sm8450-camcc.h
>>       include/dt-bindings/clock/qcom,sm8550-camcc.h
>> -    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>>       include/dt-bindings/clock/qcom,x1e80100-camcc.h
> 
> Johan

