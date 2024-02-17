Return-Path: <linux-kernel+bounces-69942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B3859095
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D33282E62
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1F7CF29;
	Sat, 17 Feb 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aeT28H24"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F87C6E9;
	Sat, 17 Feb 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184538; cv=none; b=llu153PFxjaCvLdBk3vTcMCaRvPQg/Oggxigpa3HNFaXjXAzEvGcEqyyayMAgOLNTb3BSObHKR5ajcEh2Xj4fKPufgZVDgSuJcUzubNB0jxcSbJkFyxPtEK14smTL5l5OuOiDjw/1drNhqtGg6ZyjarS+NipQzc92GB4NECICXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184538; c=relaxed/simple;
	bh=mf3hDra+Fy4zUND3zQIsgb1RjqWyn4ZuEPxH5lcJZkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iE/7Nb+J1bxIYNl4Ri5tTeXlbv4HdlIdJzZLehn6hs2EDmBP2Jm2wvUOVVBWrqgUEcTmUMEY7Bm0zjW9h+2Xg+ZWprc6or522979toZ0sDMaN4ojShoJo2fWQ/pORrJT0TL44e7Au9llFXzQuoHb7VBVLqjky6Gs7LfUeBKXg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aeT28H24; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HF1SD4015101;
	Sat, 17 Feb 2024 15:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uRvSSOLaUrymb3axaLkFU+WolmKzsir5LJxjFERnvVs=; b=ae
	T28H24onaZXEW0FyP5W7AwGLHRjWT8eI9u8Fp+066b0/3xqPC0ETAwZnvK6M3yrF
	nAI2cpe6vD2emXsKfMhASCOiMgiCgxhSCcmUEpXONzk+lXwZZnT8XTVtf9lvkJdg
	sJsQUUHteHy89UC5dz6EnKx1MJcEToV+G2q58iGJXljh1qbjaDP5HLQmMwZJ+wAZ
	xbkpPD+vWkWQ5Qx1MdHg5xDkZIxAo6xAgRk2MZ7PJ8VksmjRH0GhjdjWvhk2m9+b
	hIJ+O1DfHEiqoVGt8gYpRp4QAgBviS3Aif+OxuLQUmnRd1fKRomzSURDyvGI8WB9
	0zCTGaP+FO+9g4KCoUEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wav1ar7vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 15:41:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HFfcOq027708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 15:41:38 GMT
Received: from [10.216.61.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 07:41:29 -0800
Message-ID: <6c64a7fa-2cc4-4791-8af1-1a4972c3856b@quicinc.com>
Date: Sat, 17 Feb 2024 21:11:25 +0530
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
To: Andrew Lunn <andrew@lunn.ch>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
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
 <9638a213-76a5-4a72-b6b2-018ae50305be@lunn.ch>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <9638a213-76a5-4a72-b6b2-018ae50305be@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nnsRYfpaZ0jSHZgxDP72f9t45hp5W49A
X-Proofpoint-GUID: nnsRYfpaZ0jSHZgxDP72f9t45hp5W49A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=716 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170128



On 2/16/2024 10:46 PM, Andrew Lunn wrote:
>> You can get the source at https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/tree/NHSS.QSDK.12.2?ref_type=heads
> 
> Cool, thanks. But is it really u-boot from 2016?


Yes, it is. If you want to try on IPQ95xx / IPQ53xx SoCs, you can also 
use the 2023's u-boot, which is available at [1].

[1] 
https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot/-/tree/NHSS.QSDK.12.4.5?ref_type=heads

> 
>> Yeah agree with your comments.
>>
>> QSDK's u-boot enables the network support, so the required NSSCC clocks are
>> turned ON and left it in ON state. CCF tries to disables the unused NSSCC
>> clocks but system goes for reboot.
>>
>> Reason being, to access the NSSCC clocks, these GCC clocks
>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
>> should be turned ON. But CCF disables these clocks as well due to the lack
>> of consumer.
> 
> So there is your solution, make NSSCC a consumer of the clocks it
> actually consumes. If it needs these clocks, it should get and enable
> them.


Thanks for the suggestion. I will include these clocks in NSSCC DT node 
and enable the same in the NSSCC driver probe.


> 	Andrew

