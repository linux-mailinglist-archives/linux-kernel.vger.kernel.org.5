Return-Path: <linux-kernel+bounces-64960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751585452E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03792286A14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25695134A3;
	Wed, 14 Feb 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I3MEEXdc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81E12B69;
	Wed, 14 Feb 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902906; cv=none; b=TW3aUzdaFmVhiGk2I9vx58K0NhzWd9Dl5snZjnuoUhUEkdeZDFDZ86Nsa1rueHAbvXVdlhkjFljzz4HsJkm+9Yz2DXGiE6D5BJuxBHOhwcclGSTWts7foe8w0ObmVCzhI8NVPzV41QEwaFlekwCD2xJ3vfxFodsZ9kCJu8BHEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902906; c=relaxed/simple;
	bh=7iDIf20OmeYQc9dtbnkqUEwyJYpR4gtKqSRf663dNIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PSWoDah7acCBmIulnwSNs5KmIDeuQWSsTZjTcn+fShKCMv9InxVb+t05CMPXy3pXj7fyqAd0X6YeV2CluT8+TtwABWT8IybB0ayO81MxJ/ifIaYy6a0/wqHpg5BnayWmM4QxFlFfSXEQEhdKVFVBW+LBB0pYWV/mabjDG0fmahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I3MEEXdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E9JAMv029873;
	Wed, 14 Feb 2024 09:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tYik73OUjCMVd31RdndFP6ddzTr57qI1pHLEgBgKThc=; b=I3
	MEEXdcLmdU/9k3O3XySDXQzIz+4kU/FvgF9wSHQHkusA+YvOSd5hBORh+CpojDvE
	RhNSeE5qaIxqkTTPTDw3bip0dIsQkK138qL7dzav1fEXKk257xBt+jxrArcMPv1q
	pv4WTqr20YSgD2Fzbe1P2odJfdVQ5K6JLrky/bWsDHDd7/aYxwXfAh7o6qhNvy24
	vvLUgJX6gJW2n8TCmkrIyOWBX5LLXXccuK7jM69oysbo8cw2+szFycn5dxpNuUGR
	iSi3Wy8RyjmZ1rrgBKkMWLJGzBRO7jUJixaZBBfX5XcdFmSJNB4qVRUYiBDmAGd9
	d6qL8JszJVBMeKYhKysg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8eks987a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:28:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E9SDfW001639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:28:13 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 01:28:07 -0800
Message-ID: <222b330d-ecc0-4755-b1b5-674e11dcec5c@quicinc.com>
Date: Wed, 14 Feb 2024 14:58:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
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
 <20240122-ipq5332-nsscc-v4-4-19fa30019770@quicinc.com>
 <635f5e41-1ca2-4b4e-86a5-fdb8f7b27ef9@lunn.ch>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <635f5e41-1ca2-4b4e-86a5-fdb8f7b27ef9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k1yxsMlcmMEIAr4Giot05SLm1J4TKlmk
X-Proofpoint-GUID: k1yxsMlcmMEIAr4Giot05SLm1J4TKlmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=891 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140073



On 1/26/2024 1:41 AM, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 11:27:00AM +0530, Kathiravan Thirumoorthy wrote:
>> Add support for gpll0_out_aux clock which acts as the parent for
>> certain networking subsystem (NSS) clocks.
> 
> This answers the question i asked for the previous patch.
> 
> Why did you split this into two patches?


driver and binding patch should be separate patches, else checkpatch 
will complain it.

> 
> Please also give a more detailed description, rather than the vague
> 'certain networking subsystem (NSS) clocks'


Sure, will call out the clock names explicitly in the next spin.

> 
> If you device tree and drivers are correct, i should be able to work
> out what the clock tree looks like, so there is no point trying to
> hide the information.


Clocks which are part of the NSSCC are used by the Networking drivers 
which are in the pipeline for upstream. Once the networking patches are 
submitted in the list, we should be able to get the clear picture of the 
clock tree.


> 
>       Andrew

