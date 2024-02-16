Return-Path: <linux-kernel+bounces-68955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC712858263
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0041C21A08
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35912FF89;
	Fri, 16 Feb 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XTmMXY2k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B8D12FF6B;
	Fri, 16 Feb 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100696; cv=none; b=kXCuZuEn1jJqnsTwrfhcPBTuTwL4FPD6pZYCmDZLakztrv94HOSm9FwOnchBQKwl3SpgQdq9kS/6hNaMpNPcJUM0ff0eie14va1Kf/fJpecRNq63fWa8P1UpZyfsrBMA/gnm43NZcjbA3CuM0qNX9q/XALPM91KdyDk+vPXRIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100696; c=relaxed/simple;
	bh=4s1vWTaBK1a7eErd0aZR00tw4M/zLRbeF4g7c5F3osE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LjaJqEBlVhvVhrcH3T+V7axmCtzJh0V2U+Et0wzQN5+DfI0IpaTeINNOsTpz2DYF3sp30sKmY7p+L0QTUPRaj3+kcp/XsPeagStrJpaQk2j0Vu8Jm6NIkB1VJcIrVnm+zOVjQa2h2uTvhBCec6/WTP8KIVGiZoAVXfPejKARwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XTmMXY2k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GEvcuj023701;
	Fri, 16 Feb 2024 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FZCRCQA7RDFeOV8/PzhAWCk5baSbdABuUVo9ZHC8ppY=; b=XT
	mMXY2k0PAZb5W9EbakthNgBITfByqkpGG7Vmq5VJEI9t2I++skpgchR2eStsxZBQ
	Y3VtUUjohe0QZi5JhMr1HRly1p9nnVGlKAXtTS70ytPblDQqNX4YqNeEIINZOIOl
	4SSKBSA02iR7wukJK1JlpJZFZw9Kpl+Roe2bQx4rKAKm92mdXIdDmEhUwTvkGDBs
	zt7cgp5PH9EtQi2Rfa9LCtaJdRlDwNgmDNDp2I2xFG3Pid9jHOm9wiaaULqKOGnR
	rn6i8rB9pAGNlSoUNd18TtL1+280TaWY0XpOMarIMpuW1Bgl9iAyRU9E59O6FiXz
	PhyGbuYNCONHxZEi01jg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa61ngmrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:24:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGOZt0029956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:24:35 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:24:34 -0800
Message-ID: <f0414c84-d4b4-2c9c-5737-6f4fa9259adf@quicinc.com>
Date: Fri, 16 Feb 2024 09:24:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Update maintainer to
 Rajendra Nayak
Content-Language: en-US
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mmZwq7mxpncIZEjCQepWB6g0fZ45Jt36
X-Proofpoint-ORIG-GUID: mmZwq7mxpncIZEjCQepWB6g0fZ45Jt36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=632
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402160130

On 2/9/2024 9:18 AM, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce. Sai has left the company and appears no longer
> active in the community which leaves this binding orphaned. Rajendra Nayak
> has volunteered to take over as maintainer.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Guenter/Wim, will you take this change?

-Jeff

