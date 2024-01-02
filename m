Return-Path: <linux-kernel+bounces-14052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A2821768
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E661F21A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B715D5;
	Tue,  2 Jan 2024 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nl1lHNMA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1310E1;
	Tue,  2 Jan 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4025Rbfe007671;
	Tue, 2 Jan 2024 05:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qauHpT8Cv5h+lxNJ4zAG88/byQjuW0Ft89WL3+XjSkc=; b=nl
	1lHNMAvKZTUzFCcZk0d8O8OwN/0Jjgc3A40Qggq4QRlVTqWZxjw9L+bnvAnwBVbd
	Ww1JrFT0FRxlPbsgavFZuXupVZ2txGMdK0oz8Luv0SF4ExD6axx3DtpRlo7b163F
	wZP8FEG/JOgbOdOEj+qp5T5YPHuEusGfPCGufUmOTkTUAql/DeyiyQ/bL0ri+9Yo
	A/nr4k5ID80ypKdKDY1JZCak+IJcPm5Fzz9DW3aIZlnLwBrN/OX7oPJ3CX6YguJi
	5ywKpqKKvLmBHMDMFkdwsQ3v+XK/77IKFFu7E2ALibzMMXTm/hr6uZlWnxK8LRtQ
	Up2H/yDk6rFaZC84jJBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vccc1g074-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 05:32:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4025Wgpc003855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 05:32:42 GMT
Received: from [10.216.57.255] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Jan
 2024 21:32:38 -0800
Message-ID: <0f605226-dd98-addc-eac2-9e3eb36e748a@quicinc.com>
Date: Tue, 2 Jan 2024 11:02:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: use div64_u64() instead of do_div()
To: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231229121504.3479594-1-himanshu.bhavani@siliconsignals.io>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20231229121504.3479594-1-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _L2fIfjnQID-87Hay-S6d9yKpVq4Cl57
X-Proofpoint-ORIG-GUID: _L2fIfjnQID-87Hay-S6d9yKpVq4Cl57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=895
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401020039



On 12/29/2023 5:45 PM, Himanshu Bhavani wrote:
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> 
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 44b13696cf82..81853eb2993a 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -409,13 +409,13 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>  	out->capability = V4L2_CAP_TIMEPERFRAME;
>  
>  	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
> -	do_div(us_per_frame, timeperframe->denominator);
> +	div64_u64(us_per_frame, timeperframe->denominator);
I think, this should be like below:
us_per_frame = div64_u64(us_per_frame, timeperframe->denominator);

because do_div does the in-place division while div64_u64 doesn't.
so final value of us_per_frame won't be correct with this change.

>  
>  	if (!us_per_frame)
>  		return -EINVAL;
>  
>  	fps = (u64)USEC_PER_SEC;
> -	do_div(fps, us_per_frame);
> +	div64_u64(fps, us_per_frame);
ditto..
fps = div64_u64(fps, us_per_frame);
>  
>  	inst->timeperframe = *timeperframe;
>  	inst->fps = fps;

Thanks,
Dikshita

