Return-Path: <linux-kernel+bounces-73026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87CC85BC45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594ADB25C03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9797A69941;
	Tue, 20 Feb 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hu6lTqj/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AE69DEF;
	Tue, 20 Feb 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432403; cv=none; b=cLFVzX1PZ1F8jXl6Y/oQtICxUt9hp3axrvk7KgTh+nZe7BhtRUIz9E9+HBzE2RnLnhyCJPpS6E5fezAFWG5J3TDHf8/JnQBE+oxleMceUMQD+fdQjJn5tSyl7aSDb5oIESGB4qe2XrzNNqdAXwtWsctBe8AktvBDweN7yGR/BMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432403; c=relaxed/simple;
	bh=0wVED/9C4BHcAGXG06FK0lIb6BP1R4PoCmGhqelMi8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OopVICJU0/pNYRsNkF43VR41qY4gAlclSQwMik10Gw2r0OIiFzOS8yRSrWlPeFA3EahajRS8sfH9t3cYKDHiuY95Ggo5hLFYngHls9GkWRklBma4whC4pB5IDgiMcEAQoQuiEdkNmIZJzzb991vNbAxvfG5kqCdkqVxqwRnK1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hu6lTqj/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KADuSC021368;
	Tue, 20 Feb 2024 12:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aZqdYkf9yBn7uDqQwJZdkkHvOw5yxarzAkmgKi369wA=; b=Hu
	6lTqj/Dka7Nyrs3Y7SBTBeUkRkny9U8IHotkrpXQdNdyzVy3Wwxqd9Lrv0nh6Biw
	Ft5tVDLYdZKOmTYERTUSrof1T1WKeVeG8Qz9m2+wdpTGAnUuO70ZGXHn8mnaG4eQ
	1rm6gX2BdBlp52GHs8vh95/PZ7zGq1IAy4/IrURlNuExpxetx6c1zBttkQVsNtB4
	RYGfyQONcscwBa8i4cQH3oymFOcczh3/JRcIavMj2sDkE1NiF9ItjJkuHjM3O5r0
	MQW7k9m93UAgF7WfmkEpo7cPtnZMUfTZIU2A7V16wy35810ryj9xqSYZgjNz9neB
	J33c6hKUKsWsbKzdwunA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct5787xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:33:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCXAdv008363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:33:10 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:33:04 -0800
Message-ID: <b3e3a1e3-9c48-6c37-cd7c-6df2faaf884e@quicinc.com>
Date: Tue, 20 Feb 2024 18:03:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-6-quic_mdalam@quicinc.com>
 <ea840faa-e628-4f2f-a7ea-aa222f58f820@quicinc.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <ea840faa-e628-4f2f-a7ea-aa222f58f820@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gD9JeeBpxLCBL311higl3RFS1l1sha_1
X-Proofpoint-GUID: gD9JeeBpxLCBL311higl3RFS1l1sha_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=771 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200090



On 2/16/2024 9:13 PM, Kathiravan Thirumoorthy wrote:
> 
> 
> On 2/15/2024 7:18 PM, Md Sadre Alam wrote:
>> Disable eMMC node for rdp433, since rdp433 default boot mode
>> is norplusnand.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> 
> Single line of change is developed by 3 authors?

  Will fix in next patch.
> 
> 
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 1bb8d96c9a82..e33e7fafd695 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -24,7 +24,7 @@ &sdhc_1 {
>>       mmc-hs400-enhanced-strobe;
>>       max-frequency = <384000000>;
>>       bus-width = <8>;
>> -    status = "okay";
>> +    status = "disabled";
>>   };
>>   &tlmm {

