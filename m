Return-Path: <linux-kernel+bounces-98665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835FB877D93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A609B216C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45E241E7;
	Mon, 11 Mar 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OoGuMdoF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B1224D1;
	Mon, 11 Mar 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151431; cv=none; b=sepYeX8IGbA+t/N5ihc4aAyMzL72kFffrLr0N0P+14r1u8hlg2LoBn6+9zVe4FlapQxNenzvyN7W4wXlEH5aALBLxYqT+lxIYEhJ1AS7M3uyTWw7Z0uDDVwZqlsKEKEIQe4jP8UyomZWMN7s5E4AYDZte4Tc1pD5GE/eFRj+BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151431; c=relaxed/simple;
	bh=zHQOoOU/yW4nkFWOe914slr/bNkibALEuT0i6mHCyEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BamHTVhGFKmuiEp3+XjhjF2xHYx7VdB8pucRhax6GtusLMOGpyyNMR4Tl+ZUyprfWKcPIk4Ye0/hO8zetrsTmSdkT3tfdU3q9wx6sH2H+1paVc0PH7pfdr7SLVr001J97mh89u7+j4h4s6HW+4+/bVSH3v958F4+5XyFlBIBjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OoGuMdoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8VVSA019783;
	Mon, 11 Mar 2024 10:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VGQ8G27IACItbDTlaX3zXxf5EQZD5hLuMIFyfTNmKoo=; b=Oo
	GuMdoF0IWbprx6bKI0pJJSRKSHe0HQ2sMwLT5gapgNLa54X7XtNUjFX7FMtFQHFz
	oI1wicRP9VRxKfD7AQ0YBu1vPir9JCUM5evNHw47QI0xrsEGT6FaLWQKPQHV3EVb
	UgbNG9LMtZ8UuulNFiJFLdmOmC8/ERiGr1Y8cldn3dlnhimsSLjAsaYYfrI/JzHQ
	hkVRobgPCPpcue65fYrmXWFMlgEDIM6c+4sS8v1b7Vp2sQYAsap58gi7HbuIo0uH
	seFD/CiPoDZ3nQ97KUp9WHh2Z+5DyGECF8yiQ3MXVmf/bmmBYNJEjezb2zJqmyQq
	rKaYUJA7RvR6tkx8yb/A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsv208ev3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 10:03:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BA3iRp005261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 10:03:44 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 03:03:41 -0700
Message-ID: <e9f43ba6-dc4a-4f74-90eb-fdcea323bb3a@quicinc.com>
Date: Mon, 11 Mar 2024 18:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240304-gpio-keys-v4-1-03604d778c86@quicinc.com>
 <f09dc3a4-ed5e-40b7-ae71-7c6cfd79da1b@linaro.org>
 <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
 <CAA8EJpq64dwEi3NrEnvqnFR5YTSDitx9sgZVheho+UL0rz0FsQ@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJpq64dwEi3NrEnvqnFR5YTSDitx9sgZVheho+UL0rz0FsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yWD06ixfVMYinJzZx8eIs_-WgJASJnvY
X-Proofpoint-ORIG-GUID: yWD06ixfVMYinJzZx8eIs_-WgJASJnvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=687 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110073



On 3/6/2024 3:56 PM, Dmitry Baryshkov wrote:
> On Wed, 6 Mar 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
>>
>>
>>
>> On 3/6/2024 5:20 AM, Konrad Dybcio wrote:
>>>
>>>
>>> On 3/4/24 08:09, Hui Liu via B4 Relay wrote:
>>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>>
>>>> The Volume Down & Power buttons are controlled by the PMIC via
>>>> the PON hardware, and the Volume Up is connected to a PMIC gpio.
>>>>
>>>> Enable the necessary hardware and setup the GPIO state for the
>>>> Volume Up gpio key.
>>>>
>>>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>>>> ---
>>>
>>> [...]
>>>
>>>
>>>> +&pmk8350_pon {
>>>> +    status = "okay";
>>>> +};
>>>
>>> This device is already enabled
>> Hi Konrad,
>>
>> The status is not set in pmk8350.dtsi, so I thought we should set it for
>> "okay" manually. Do you think so?
> 
> What is the default device status if there is no status property?
The default status is okay.
OK, I will update it, remove the status configuration.

Thanks,
Hui
> 
> 

