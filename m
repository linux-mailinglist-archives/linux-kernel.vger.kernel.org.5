Return-Path: <linux-kernel+bounces-19117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871F826844
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84D71F21B37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB458BE7;
	Mon,  8 Jan 2024 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YRUFwPG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6579DC;
	Mon,  8 Jan 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086kel0018212;
	Mon, 8 Jan 2024 06:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ip/sp5Uiq66KxZvnGzhPTlV3Ok/XCmMqVJ9pJkw7pu8=; b=YR
	UFwPG9IJchbbD7PVgZD7uAqD7Gt4j/0JIn1YFKF1Hjl5rWGdvvEBVGs5NEZ/Ybx1
	t8+F2eCbJ1NAHPWvmKvIBNB1thH4MCoiDgyVu4U7NrDH8nnoXG5jaPoYd5Ev2Rpz
	a2fZfIbx5jV6EmN065pPAiyFXU2QbgmhSMpNgyvvp+yipftWad4Zg1l1GvghdAQk
	4OXVNt6UpVV79a5V7Ws4AUhOcP8DU0Sn2PbgSlE7TU6GV6/iQymtr/vlvXC8PZPF
	rqNySmZo116WQu+pigkiq9yLVx73t2vM9vD4KDZEteLWef5ge5g68/J1Fog76zv8
	XYdCXZG4ADNlZb/KY6Tg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg97b09hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 06:49:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4086nMNW022657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 06:49:22 GMT
Received: from [10.216.5.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 7 Jan
 2024 22:49:18 -0800
Message-ID: <02f5e23d-f760-3f3e-23f9-35317b81ec54@quicinc.com>
Date: Mon, 8 Jan 2024 12:19:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: flush all buffers in output streamoff
Content-Language: en-US
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1704695615-1036-1-git-send-email-quic_dikshita@quicinc.com>
 <1704695615-1036-2-git-send-email-quic_dikshita@quicinc.com>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <1704695615-1036-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ko16LJ3AXbnGtGvS4R0w7jlZkblyxRlK
X-Proofpoint-ORIG-GUID: ko16LJ3AXbnGtGvS4R0w7jlZkblyxRlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080055

Hello All,

Please ignore this duplicate email and review the other patch [1].
Sorry for the spam.

[1]
https://patchwork.linuxtv.org/project/linux-media/patch/1704695615-1036-1-git-send-email-quic_dikshita@quicinc.com/

Thanks,
Dikshita

On 1/8/2024 12:03 PM, Dikshita Agarwal wrote:
> For scenarios, when source change is followed by VIDIOC_STREAMOFF
> on output, driver should discards any remaining queued OUTPUT
> buffers which are not decoded or dequeued.
> Flush with HFI_FLUSH_INPUT doesn't have any actual implact. So,
> fix it by invoking HFI_FLUSH_ALL which will flush all queued buffers.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9..0d2ab95 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1255,7 +1255,7 @@ static int vdec_stop_output(struct venus_inst *inst)
>  		break;
>  	case VENUS_DEC_STATE_INIT:
>  	case VENUS_DEC_STATE_CAPTURE_SETUP:
> -		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
> +		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>  		break;
>  	default:
>  		break;

