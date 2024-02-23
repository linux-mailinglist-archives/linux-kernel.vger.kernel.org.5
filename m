Return-Path: <linux-kernel+bounces-78114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D6860F15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D599B26D71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82E65D49A;
	Fri, 23 Feb 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GeCoMpt8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3741642A;
	Fri, 23 Feb 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683531; cv=none; b=h318X2qX+B+cPMKDdy6yaqIZM7IcAPOdxgi5as0f9NvVOGY4jXuZHpHScNsaem/DvevXWbPRHtNoc2VIqZTWb42Iu74pLwMxQdyFlLOduZQZkXQZiSm+cw1nF/TdncqrZd94A9xaTyAsLTzKt67GTqZlLM8Dy4zcZI9vBpuSk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683531; c=relaxed/simple;
	bh=0kvbSqosJ5PV6gzc4ndMjbUoqfFey9a9gTa/COfANw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J6Rq2jg8rSVE+BquwIoRtRP9+TbCVfH04MqNCwwslgJrctnYt3ZC7G/mNkWcAVdDZyiDyZ0NmkKHN3oqvzOaCJdv8ASBOb64SrFbEqYltY7XpVaGdCH/GuFkvW4P3Yv5scrA+rimGPMxyrYXFSYeVLm877RIQ87AYyQnpNTHAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GeCoMpt8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N7u7iV027179;
	Fri, 23 Feb 2024 10:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C2pBHnwMTIW0Lt1mPFv3jlV9ek01TT1xsSVaoZixcdw=; b=Ge
	CoMpt80TaowAfNcB52WBhNG2Qp5pRwVIrZN3AM07+OT/cE8Ow8ntwJmiwpcypCI1
	cTEupLNU6uIx0hAWB2iqyhgcNs0MrAGW/xV3H8ln4K+drhSrFSnYsyRIdPRCExrI
	KJJ/93TprC6jh0Iep74FG9YlxY7mqCKBFVSuL96zIR23DglI+YrZ8CDFg88o1wOd
	hB6YG+YirQFNjkgildBu57OiYBUq+zFOKzsgW752yr56VVnro0B9rw1iLZFfKwf9
	12vATnB3ZtXCZ1/KAAzRcw1MTuagAG57twMjIjpf/fiKJbX/GgF90G0rz5rRny6y
	i2nqO457aZmFrFjlqgwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqcf88xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:18:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NAIXm2010206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:18:33 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 02:18:27 -0800
Message-ID: <3a6d301d-16f6-4a11-8be5-6bbb6eb501f4@quicinc.com>
Date: Fri, 23 Feb 2024 15:48:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
 <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
 <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
 <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com>
 <CAA8EJppuNRB9fhjimg4SUR2PydX7-KLWSb9H-nC-oSMYVOME-Q@mail.gmail.com>
 <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com>
 <CAA8EJppP_bAPRH7Upnq8dO7__xQPOJ6F_Lc-fpRAcutKKzk0eA@mail.gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAA8EJppP_bAPRH7Upnq8dO7__xQPOJ6F_Lc-fpRAcutKKzk0eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TBM5zPBMFRANid5D1Kx_kZprPk2Mx-1T
X-Proofpoint-GUID: TBM5zPBMFRANid5D1Kx_kZprPk2Mx-1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=865
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230073



On 2/19/2024 3:53 PM, Dmitry Baryshkov wrote:
> On Sun, 18 Feb 2024 at 06:29, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>>
>>
>>
>> On 2/17/2024 10:15 PM, Dmitry Baryshkov wrote:
>>> On Sat, 17 Feb 2024 at 17:45, Kathiravan Thirumoorthy
>>> <quic_kathirav@quicinc.com> wrote:
>>>>
>>>>
>>>> <snip>
>>>>
>>>>>> Reason being, to access the NSSCC clocks, these GCC clocks
>>>>>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
>>>>>> should be turned ON. But CCF disables these clocks as well due to the
>>>>>> lack of consumer.
>>>>>
>>>>> This means that NSSCC is also a consumer of those clocks. Please fix
>>>>> both DT and nsscc driver to handle NSSNOC clocks.
>>>>
>>>>
>>>> Thanks Dmitry. I shall include these clocks in the NSSCC DT node and
>>>> enable the same in the NSSCC driver probe.
>>>
>>> Or use them through pm_clk. This might be better, as the system
>>> doesn't need these clocks if NSSCC is suspended.
>>
>>
>> IPQ53XX SoC doesn't support the PM(suspend / resume) functionality, so
>> that, can I enable these clocks in NSSCC driver probe itself?
> 
> There is a difference between PM (suspend/resume) and runtime PM.
> 
> 

Thanks Dmitry. IIUC your question correctly, runtime PM for the 
peripherals are not supported (except CPU cores which supports DVFS). 
Since these are router based products, once system is powered on, all 
the peripherals are configured to the required frequency and it will be 
never go into low power modes.

Please let me know if this answers your questions.

