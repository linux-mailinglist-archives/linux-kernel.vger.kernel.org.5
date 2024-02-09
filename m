Return-Path: <linux-kernel+bounces-59388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308684F633
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89062838C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED84D11B;
	Fri,  9 Feb 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CYs6iTpq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71004CE19
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486855; cv=none; b=njflyj7ntOptLxSStV6tScDCd+PpIUuvfA4fjmLvBWeaVgTnH3yS/WPWAag195M0QWy30UTWdZphvQ78po2euMEBwyYrv5NmJYVdCAdybDS0ysVUbAQL7qwV3B4VpvTtV+JcS9uRkcSDsPlTvaKzt1eeA2n6e9fP9ptOG4bwZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486855; c=relaxed/simple;
	bh=sV/cqBdBFzqcDtKXNO9HyT7h5X1t9NRYRdLSjQCunZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jTpDwUNTItTzmVPJ7uDVno5vhRj4cNayeLiBpaVV8PJsktFZbPGSnERG2GEYh6MOOu2Gdsk793G41jPCg2jsHeqDzg7E8lLNFSKyviNN+XIS1dsln+rCpwO/eKTg15l7MqKW7EPMECKroTEi40vQJzV75D8R5WJ66bPuDIoLRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CYs6iTpq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419DenCI014249;
	Fri, 9 Feb 2024 13:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=By7lUeNulklMUEX/med8ZyVIEZyvK0KBOkHHrVI94UY=; b=CY
	s6iTpq9JmnUf+wBqo7vxU/Os+1jRyOEwPURbJNqZTdPo3Dc+uVGIq00ofzL1XiMi
	+1lKy2jyXydt5SVLq/BxiztBGq3Je2inImAzWaarM4nJASB6zTEmVkegp8/j6N7S
	jfA81NtFvNPtILwXmcbRFLsT8i7TulFQMjCQGBN8ztKUqC7TcRdWBBVG+4V3VIQ/
	8R4MKUc4spjUbvjXz41TDSRTbpFjxBa2/e+wd44NJK3kFHecFMMA1nWTCwy/Lp7s
	5qr47MZM6e4Rv6rxGsW6cc7iGoEm8C+x7b/1S+2IFxIxug5JV9IPfooMB6+YoYLh
	ycECc1UZj8ac8ZYtDQew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4y62ty4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 13:53:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419Drlr2008852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 13:53:47 GMT
Received: from [10.216.38.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 05:53:42 -0800
Message-ID: <14cfbfe0-de9f-e81f-60d6-5c8a6496d816@quicinc.com>
Date: Fri, 9 Feb 2024 19:23:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: defconfig: Enable GCC and interconnect for
 QDU1000/QRU1000
Content-Language: en-US
To: <quic_bjorande@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
References: <20230822132333.17580-1-quic_kbajaj@quicinc.com>
 <b4d7d4cf-5bee-492c-819d-79af01e73cec@linaro.org>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <b4d7d4cf-5bee-492c-819d-79af01e73cec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tOsga1wU2BhnPuh3CpNGNQkGcCXIxNsl
X-Proofpoint-GUID: tOsga1wU2BhnPuh3CpNGNQkGcCXIxNsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=599 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090102



On 8/22/2023 7:54 PM, Konrad Dybcio wrote:
> On 22.08.2023 15:23, Komal Bajaj wrote:
>> Add the QDU1000/QRU1000 GCC and interconnect drivers as built-in.
>> These are necessary for the Qualcomm QDU1000/QRU1000 platform to boot
>> to shell.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

Can you please apply this patch?

Thanks
Komal

