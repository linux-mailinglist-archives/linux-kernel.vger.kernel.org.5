Return-Path: <linux-kernel+bounces-93259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E340872D25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2421C25E47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C80DF51;
	Wed,  6 Mar 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nKtgTJ+e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019433D1;
	Wed,  6 Mar 2024 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694150; cv=none; b=A36fzjMls/Gxp1rIzOcEzNn/9bX8m3Owclm3PqV8sRYLzcYjhPtHV2WHZo72uNvU0RDBLtSA3YGKOs4935S6Le/tOWflQw3aMcUXl2HsJBxMcUAEyb0MaU/V6DMJtKw5V72aDbcyLPUc1KduIdTlk5X3/5C++VRybZM3iLtQBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694150; c=relaxed/simple;
	bh=4FOJMI7U00Rmio1lHE4tnBVYYgrRlqn+FM0XVx/zZXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FfK5eSBs3k3h6rC1cHcL/mw3v584KN31BIfYdkaDkrq6OnOI/dEPlTEFCMv2TnenHV1VFh9UJmPV3T4kL5euiicECUSmRaxC7kc4zNcwzgCthyiDnzBuCUPZy3AWrEKFu39/JHzoaUYRKeIzttxxwTKPFXNvqoKnfCVDZiY+rfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nKtgTJ+e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4261Tw9n021693;
	Wed, 6 Mar 2024 03:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rRaiK9UWLCp5edjp+w4OT88LCLd0s+QcNhwplwfkB2s=; b=nK
	tgTJ+ekQlmsyA3H+4QRcA+wJRUCNth8SUUXR1V9aPIO0+FLVsxHstuKThEL7evH5
	3OJbYuFE7/gv1n/5qcH2vyVXH6VI3muMjqPBorJ/LsJco7lNTppq4rwby2ac74vI
	iku0HahUFbpKQgfAy0R/xjjnzkYr3+37BZtLKu7mQo2Do80WATZDXX4Wv67zmVXk
	wArrc4nsqm0hEiQpEwqi2JuVgnJGTe+HoQ3NSBNR+D/eTPgaojc4Dt1KvX+bBkxi
	Gi48GBX1FojS2F68U6pGBeLpVGOADZtC/0dGRVua8fpxHeIKekqtXfONYfSGMy/2
	pYSeB0R1iycH4Q6mZ44A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp028a8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 03:02:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42632I81011834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 03:02:18 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 19:02:16 -0800
Message-ID: <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
Date: Wed, 6 Mar 2024 11:02:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240304-gpio-keys-v4-1-03604d778c86@quicinc.com>
 <f09dc3a4-ed5e-40b7-ae71-7c6cfd79da1b@linaro.org>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <f09dc3a4-ed5e-40b7-ae71-7c6cfd79da1b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VjIWG0VaUBMnGaE32ccq4ADzKwNG99-Y
X-Proofpoint-ORIG-GUID: VjIWG0VaUBMnGaE32ccq4ADzKwNG99-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=697 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060024



On 3/6/2024 5:20 AM, Konrad Dybcio wrote:
> 
> 
> On 3/4/24 08:09, Hui Liu via B4 Relay wrote:
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> The Volume Down & Power buttons are controlled by the PMIC via
>> the PON hardware, and the Volume Up is connected to a PMIC gpio.
>>
>> Enable the necessary hardware and setup the GPIO state for the
>> Volume Up gpio key.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
> 
> [...]
> 
> 
>> +&pmk8350_pon {
>> +    status = "okay";
>> +};
> 
> This device is already enabled
Hi Konrad,

The status is not set in pmk8350.dtsi, so I thought we should set it for 
"okay" manually. Do you think so?

Thanks,
Hui
> 
> Konrad

