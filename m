Return-Path: <linux-kernel+bounces-132901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0072899BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70351B24580
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95E16C68D;
	Fri,  5 Apr 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mkERQ8kk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746616132B;
	Fri,  5 Apr 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316160; cv=none; b=dF5MEB/ktj1niVdT+Hbb/V+bEs1X+ipNAGQNRKVwNfASM50pQ8gfaia9bOK5p/n4kkeFP2MvYavExLrmZkrwdlBWpg/rFboPhFfYow+HZvQM+FEikNB2afm6AGvDiXSwBbCTC1Ljp+PNw5lrUFJcqAnb2oieJnQhpKCkU3xOr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316160; c=relaxed/simple;
	bh=1tjDRUcH77n7AFaN2cajrY2o4bzMBKqdbpc28HYee/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VdZj+sjZSlV2fRM3uoONsdlZOCmJo/ts9tNYAJ7Vzakl/3ruAlS8DZuXmbeVPiWJAV26fox9TyQh4Gl/+rocZIzDum3TgAfZW3uHePs+kE86n0kwKt/tIDuS9woFwxdvUaY69jY+NWu/tpiqs/yKkyjxFIv7uGL/y98CEBIpa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mkERQ8kk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435BDYWD031510;
	Fri, 5 Apr 2024 11:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YudMWaGyIH7qK971PvnZqUSurFzuszHH/y7TZFTPi68=; b=mk
	ERQ8kkdvjzLdEgWm1mjkoBVk3eHNBhxhZs8rqGQA13mUd9s5S9O1g/ZNaiAHXaky
	VIGB5ATpoMAF0tWmA5t1T1zdBGvgwckXFeECdSaXNPEVlVzxqfhFDSIdFaCGPsB4
	neNV8Eg1ns0JVSolL5IzdaupDrthz6NyfDqBee7S8TyXgSwn4C/Q98O1nK0gZ3iU
	0zHTBkichv8ZPaYrV7WdBxbNe76of+vrmUcL8mQx2mouSIGT/TRE9wG8+Ra+bZg0
	a6NHc2ptOlUVDx7Bj5t9JgMTcEDwlHZT+szh1tsDvK9ctHyolrfbtWZ6AU7Du5Jt
	+vWxmG6y4rZ8VjUdIC9Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc100y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:22:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435BMXHD030955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 11:22:33 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 04:22:29 -0700
Message-ID: <a59e7378-a3c3-4ec6-6566-346ae9cb3017@quicinc.com>
Date: Fri, 5 Apr 2024 16:52:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various
 remoteprocs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
 <20240402090349.30172-3-quic_kbajaj@quicinc.com>
 <CAA8EJpofbeyER39_tjG=sYmVp+vN2WbNZyhU6NEaePxd-QUZaQ@mail.gmail.com>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpofbeyER39_tjG=sYmVp+vN2WbNZyhU6NEaePxd-QUZaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nd10BpdFJGfvA74wVJgYD9FU74RqEJWW
X-Proofpoint-ORIG-GUID: Nd10BpdFJGfvA74wVJgYD9FU74RqEJWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=648 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050081



On 4/2/2024 2:47 PM, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.
> 
> No MPSS even for GPS?

Earlier was thinking of sending a separate patch for that.
Anyway, will add MPSS too in the next series.

Thanks
Komal

> 
> Anyway,
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 97824c769ba3..a25431ddf922 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -434,6 +434,21 @@ &qupv3_id_0 {
>>          status = "okay";
>>   };
>>
>> +&remoteproc_adsp {
>> +       firmware-name = "qcom/qcm6490/adsp.mbn";
>> +       status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +       firmware-name = "qcom/qcm6490/cdsp.mbn";
>> +       status = "okay";
>> +};
>> +
>> +&remoteproc_wpss {
>> +       firmware-name = "qcom/qcm6490/wpss.mbn";
>> +       status = "okay";
>> +};
>> +
>>   &tlmm {
>>          gpio-reserved-ranges = <32 2>, /* ADSP */
>>                                 <48 4>; /* NFC */
>> --
>> 2.42.0
>>
>>
> 
> 

