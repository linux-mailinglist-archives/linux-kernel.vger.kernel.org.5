Return-Path: <linux-kernel+bounces-64945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17748544FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41D51C21575
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE28134A3;
	Wed, 14 Feb 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ARE4m//X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081ACA73;
	Wed, 14 Feb 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902455; cv=none; b=Fp/hYVGFqed0dQCOrGfqf2+BPvv7h1YFxYFwI3jqJrqQ7CGGKUrhvZhE/kA/3FTkNRlRoz5K6hIM4a3xauBDX3EHugXWQ+x47YoCNp7zem2/QDkxpH11O7Hn3g+bYI2OGpwKmIJPCFXnsEGTfLbdnFmAVGTU8NlLiaW9ua41Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902455; c=relaxed/simple;
	bh=1V7vBgcSelzRxGc+Yp06s7YCcpAeGumWC0XRRRTAgJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eNAMFmq+BIzo4DYcA1LJl1Vuk3uiaHWvoslujpe5CFQviMLjrri7y3uxnx9oykH46vfkFf2k6STLM+BncaGnnEQUxItt1g8IAFXWRxHXpyAN9u9PcID3tZjl8wgOzA8r/7/7NPS+naL0RRN354qNZ3W6wEeh/7dbyOC8P5dgN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ARE4m//X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E6qvXl020154;
	Wed, 14 Feb 2024 09:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=c1fGLw+Aj6mriPq5WpKl/zYCaU0Xd8piAX+/oLGdicg=; b=AR
	E4m//X3oroCi1qswAUYrzIiiFRCx7YOTVo/CRkOwzy+N1+0dhGqo3dN2Iq/+uLn7
	ubyVoCrzqe2BC751Xg3vH1N+oUkKxezWdYbazJi4xXUsvMZLR4dsWBPZTqTqpgpe
	Cg9floGgzHSUl/GF1bMPtAQGR5qg3RGC1XbsL1dCGZYr+6gex/JEv9UmHXTxLMnA
	2HOsKzwu38kMsfWTBD/Xvo/Vm7tMoFCWKdWVKDNN+fj1O89vBaqHw8iEKw1Sde6M
	/iF0rmDCIhU2HZMekS+89TBxlkURbXqgqA4ycucIzI+ja09xgEfT1rBAktjXyaxk
	xhpQPIDrn4vVHHgbIv1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8enn97dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:20:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E9KduW027597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:20:39 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 01:20:33 -0800
Message-ID: <d121c049-ad77-4783-b42e-626c809fe98c@quicinc.com>
Date: Wed, 14 Feb 2024 14:50:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: ipq5332: add definition for
 GPLL0_OUT_AUX clock
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
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-3-19fa30019770@quicinc.com>
 <b939445e-c0a8-48fd-bc95-25c4f22e1e0d@lunn.ch>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <b939445e-c0a8-48fd-bc95-25c4f22e1e0d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kLLLijcgKzudMQkHfupaqSNWqyV6OgEv
X-Proofpoint-ORIG-GUID: kLLLijcgKzudMQkHfupaqSNWqyV6OgEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=635
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140071



On 1/26/2024 1:37 AM, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 11:26:59AM +0530, Kathiravan Thirumoorthy wrote:
>> Add the definition for GPLL0_OUT_AUX clock.
> 
> The commit message should answer the question "Why?". Why are you
> adding this clock? What consumes it?
> 
>         Andrew


Ack, will add more details in the next spin.

