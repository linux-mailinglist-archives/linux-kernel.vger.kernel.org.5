Return-Path: <linux-kernel+bounces-6572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15BF819A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD296284769
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1351CAB7;
	Wed, 20 Dec 2023 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W62plWJw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3421B26F;
	Wed, 20 Dec 2023 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6J6Z4016964;
	Wed, 20 Dec 2023 08:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K2rmhOkJoMd+1/Y9bNhaQ8Tg5onlPPDtMcs47isLr5g=; b=W6
	2plWJwDIEdGhyQ9EYkjKrc7tWZvtsbXnj6AlFUvn8BYpHWnG7bM1A/WSkoGqMuwd
	8IomSmJTw4N0GKDeLsFmm99vqC5iOL1ueadjQohqIV6xYw4IE7W0+zFV9bEg5ylK
	Osokc4N9CSZYRte80bnRudrH1Ehx6xttyRxXnKRrOtiR2YKXCpUzMeTexpeRj2yK
	6/WMFRv7wyb6gc4JbmBrbyiQ76/1jKdL/ffOvzq6AtdSenlit/OY/A1Ls50evW5H
	bv14aBgfPwpw0PMLkYJBakPXQHdtaNMelL0G8X+cHp4639ao0EMgBAt3iWvFrbGV
	Rp4og06LYv2FaBjszB7w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm0b28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:29:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8TwhC018391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:29:58 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:29:54 -0800
Message-ID: <c41c0b30-a3be-28d6-f06e-cb1d6be3608b@quicinc.com>
Date: Wed, 20 Dec 2023 13:59:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 20/34] media: iris: add video hardware internal buffer
 count and size calculation
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-21-git-send-email-quic_dikshita@quicinc.com>
 <cc2da776-9aed-476e-9654-8ad75496db8b@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <cc2da776-9aed-476e-9654-8ad75496db8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2MAU1cA5MYXZaEeLHu_0xfS8SgAecpbx
X-Proofpoint-ORIG-GUID: 2MAU1cA5MYXZaEeLHu_0xfS8SgAecpbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200058



On 12/19/2023 5:36 PM, Bryan O'Donoghue wrote:
> On 18/12/2023 11:32, Dikshita Agarwal wrote:
>> drivers/media/platform/qcom/vcodec/iris/Makefile | 1 +
>> .../media/platform/qcom/vcodec/iris/iris_buffer.c | 48 ++
>> .../media/platform/qcom/vcodec/iris/iris_common.h | 1 +
>> .../media/platform/qcom/vcodec/iris/iris_core.h | 2 +
>> .../media/platform/qcom/vcodec/iris/iris_helpers.c | 13 +
>> .../media/platform/qcom/vcodec/iris/iris_helpers.h | 4 +
>> .../platform/qcom/vcodec/iris/iris_instance.h | 2 +
>> .../media/platform/qcom/vcodec/iris/iris_vdec.c | 1 +
>> .../media/platform/qcom/vcodec/iris/vpu_common.h | 8 +
>> .../media/platform/qcom/vcodec/iris/vpu_iris3.c | 6 +
>> .../platform/qcom/vcodec/iris/vpu_iris3_buffer.c | 201 +++++
>> .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h | 845 +++++++++++++++++++++
> 
> So, unless the code you are adding effects existing upstream venus, I think
> it would be a bit easier to review if you squashed down changes that
> pertain to Iris only.
> 
> For example this patch seems to relate to Iris only, so why is it a
> progressive change within your series.
> 
> Similar comment for "add vb2 streaming and buffer ops" and other "add
> feature x" patches in this series.
> 
> If the change is contained to your own codebase, then progressive changes
> are more noise than content.
> 
> Please try to squash down changes - to reduce the number of patches and the
> total LOC being proposed here.
> 
As requested in V1, we separated out the iris driver code in functional
patches. Also, as commented in 1st patch, we are OK to have the common
helpers as separate series.

Patch 6 onward all the code is contained to iris driver only.
Could you please elaborate, what do you mean by squashing down the changes?
which patches you want us to squash?
> ---
> bod

