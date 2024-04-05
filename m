Return-Path: <linux-kernel+bounces-133011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6774899D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC6228778F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950416D4F0;
	Fri,  5 Apr 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G/6m+4fM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185B16C86E;
	Fri,  5 Apr 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321080; cv=none; b=NnZzwiHKZ/F50Ngt3XGMOaSYscDEw0J5bxHIN6r94eDxG+5ZzfVYXFj+uW9zNEXRDsOrVQ8n79YHuyktP7eJnqIkjgGHE3MxJnBwrBu5HH7KrmUqHhJLUYUne2MbxODbXWwMhLG0f9WWLwEpySxfwoPfYoBpBbs6N2RtBSkbXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321080; c=relaxed/simple;
	bh=TogtJ4Vn6Gy6a4ti9uknKk9nKZOA1/ci5s+DLH+6evg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bIr7OHincA9PfjCax2+A9IrmsSrA8Dksl6PO4IOg4bm4BFswfeBv9tqzkGTHTKdoPkv965V9MuMoptAtmgEwbXlWBEgomPdC8mbHfPiQO8WDTblHG/sT5qmfXH4iUhmuohJyD5+6w69VeBZ/5V97CwdByk7W/LtgPHn3j3v9EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G/6m+4fM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435ADrwG031356;
	Fri, 5 Apr 2024 12:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zc5ni8QDAeHdiipwqwPSCdrgWjokMHTr3M0/Uql0XH0=; b=G/
	6m+4fMrPwInyfNgjBmWpg3zx2VRL5LH6qhNJiy07g07PeDghPprZYhPpNQmj3LtG
	eUthjxo11NMvMaHVVHQYUgeQsshZMj9P+8g3zwEFZyAVoPpFAtFZbdC8Z0WHLuIL
	+p+cIzEAQATE+WumpagCmocsSo+BKUGdC62zTQ0ihIT9TdIPBgGQkbldkPSlffhX
	nzpdJfKn4nXhPQuaz3j8kAR2jhyDjxpEL26UQ/X9a/9TWaVBK/OdFGxRaS3JSar4
	v2or5q5kvk72vHfUOcAVKF9daBv1RzO2VoyG2L7sCQ3+IJ/6Gt9ZOvxOFis23NHp
	jgie0KQnT4dmv6hsv50A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaaj18x42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 12:44:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435CiOBi018171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 12:44:24 GMT
Received: from [10.216.12.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 05:44:19 -0700
Message-ID: <66492657-3649-3bdb-b7df-0f5196418e06@quicinc.com>
Date: Fri, 5 Apr 2024 18:14:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/19] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
 <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: foUleAOSXv8jrkBMfYMX_5RrGXcxukIO
X-Proofpoint-GUID: foUleAOSXv8jrkBMfYMX_5RrGXcxukIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050091

Hi Konrad,

On 4/5/2024 1:56 PM, Dikshita Agarwal wrote:
> 
> 
> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>> To make it easier to understand the various clock requirements within
>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index ac7c83404c6e..cf91f50a33aa 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -23,6 +23,34 @@
>>  
>>  static bool legacy_binding;
>>  
>> +/**
>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>> + * @core: A pointer to the venus core resource
>> + *
>> + * The Venus block (depending on the generation) can be split into a couple
>> + * of clock domains: one for main logic and one for each video core (0-2 instances).
s/main logic/controller. Applies to below places as well.

>> + *
>> + * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
>> + * domain, so this function is the only kind if clk_get necessary there.
To be checked, unable to get the clock document to see why only core clock
(VENUS0_VCODEC0_CLK). Will update.

>> + *
>> + * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
>> + * statically defined a decoder and core1 an encoder, with both having
>> + * their own clock domains.
>> + *
>> + * SDM845 features two video cores, each one of which may or may not be
s/two video cores/two identical video cores
>> + * subdivided into two encoder/decoder threads.
decoder cannot be split into core threads. you can keep it like "each of which
is capable to do any encode or decode"

>> + *
>> + * Other SoCs either feature a single video core (with its own clock domain)
>> + * or one video core and one CVP (Computer Vision Processor) core. In both cases
>> + * we treat it the same way (CVP only happens to live near-by Venus on the SoC).
>> + *
>> + * Due to unfortunate developments in the past, we need to support legacy
> why unfortunate? please re-phrase this.
>> + * bindings (MSM8996, SDM660, SDM845) that require specifying the clocks and
>> + * power-domains associated with a video core domain in a bogus sub-node,
>> + * which means that additional fluff is necessary.
Some background:
It was done that way to support decoder core with specific clocks and similarly
for encoder. Earlier architectures use to have different clock source for these
specific decoder/encoder core clocks, now there is a common clock source for
both the cores. Hence if any one is enabled, others gets enabled as it is
derived from same source.
So if we see the later bindings, the clocks were moved out of sub node to main
venus node.

Regards,
Vikash
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>>  static int venus_clks_get(struct venus_core *core)
>>  {
>>  	const struct venus_resources *res = core->res;
>>
> 
> Thanks,
> Dikshita

