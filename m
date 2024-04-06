Return-Path: <linux-kernel+bounces-133956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510889AB6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4174F1C212AA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DE383B2;
	Sat,  6 Apr 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLkzMh+c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776C2561F;
	Sat,  6 Apr 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414935; cv=none; b=iE+EpRH1nPhjY2qXdDE+F1znatZ78qNUcE0f6O/GtHQzjuELhoUZI+y0+dh7XnQWfrdlcYiwNZVcFubxt1H9n3m9UpKntNrg+svbF8Oc2tm49goju3dMRHy8VlqNkKc7HjoaaXfAD6W/TQy9BUP9M8hWw28BzFObpN1ueLlwDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414935; c=relaxed/simple;
	bh=3IsIiSHahqBrRCmVosGXFKNr6uA/zks+RieTV/DRZM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JrvJLkoxSOBG9uAQ4Pnwqxo1j6AaZN4n8leNtPW3Ru2zd1t7s3I+ZaQqAijn2t5WxP0ruKTeFYL8gBMnpNEj+ak2eCgLodBaVZbUFIbZ3hHK/+2ABhiw07odcLkUwHygJ3BtVlLwLbg0+SwsVCeC4k+OPbjKT0saixZXrAKV4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLkzMh+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 436ElWSM028801;
	Sat, 6 Apr 2024 14:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/a+AbHpn+isNK8mqS3AAtxnCcpkXqIhp0UtjQqbegYg=; b=nL
	kzMh+cDl4AGJK5i1QkCc0seSvFUy2gqvPwMpaSUrXFkvKqcaYH4+VSnUVe4yA4b/
	GUIOI4lhEvO7Xu7Gx0Gq2sVf/JCOdAkuPo48nMUnrcCDGptTllBRvoUUJaCYWqzU
	hS8JBSHWVDs/eva5mxDH1FR7ucEF5JBIWtbBOQLhKXHbM6y/BjGlu/UIwfZkmfet
	zplXIF/mUmz4BiNjyn3I1bmW7pYBDlpHC/jeCv1OSNpiPdfGlAI6DVRHzDbT48EU
	WlSWvnlg/XOkPbSTdWB9OHD5Rg8WWJ1/4URbRVFifpA9cK13hKfAYO+lilchSU5q
	GRLi2eRH9U7kLB9nfZVw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xawbv0q5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 14:48:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 436Emaoj011182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 14:48:36 GMT
Received: from [10.216.19.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 6 Apr 2024
 07:48:28 -0700
Message-ID: <12e5708a-ea6e-4798-a487-f2465c848278@quicinc.com>
Date: Sat, 6 Apr 2024 20:18:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for the IPQ5321 SoC
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
References: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fkQFsPcLaDGYK77QlZfeX-OzOvz9NqXz
X-Proofpoint-GUID: fkQFsPcLaDGYK77QlZfeX-OzOvz9NqXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=828 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404060116



On 3/25/2024 9:19 PM, Kathiravan Thirumoorthy wrote:
> IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
> support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
> based on the eFuse.
> 
> Viresh is okay to merge the cpufreq change via qcom tree[1] and provided
> his Ack.
> 
> [1]
> https://lore.kernel.org/linux-arm-msm/20240306053200.6iwrviltwt3pnfnt@vireshk-i7/


Gentle Reminder...

> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
> Changes in v2:
> 	- rebase on next-20240325
> 	- pick up the tags
> 	- Link to v1:
> 	  https://lore.kernel.org/linux-arm-msm/20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com/
> 
> ---
> Kathiravan Thirumoorthy (3):
>        dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
>        soc: qcom: socinfo: Add SoC ID for IPQ5321
>        cpufreq: qcom-nvmem: add support for IPQ5321
> 
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>   drivers/soc/qcom/socinfo.c           | 1 +
>   include/dt-bindings/arm/qcom,ids.h   | 1 +
>   3 files changed, 3 insertions(+)
> ---
> base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
> change-id: 20240228-ipq5321-sku-support-bd07056d5e01
> 
> Best regards,

