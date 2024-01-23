Return-Path: <linux-kernel+bounces-35937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D0B8398F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C551F2C12B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379812BE96;
	Tue, 23 Jan 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M0KNNqkR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF312BE81;
	Tue, 23 Jan 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036064; cv=none; b=IKl/tBonUjf9tyAZTH3TW5uOs9gTOQprPDVPAEZl7OCQuLiXa0J3cB7k0MoXFajtAJmkDhdRTM7KaAHu3k9swKFVn7F8Hsu3reVon7xYgN8gdJ3aabEz8LSF6/gCq4TbnC1tJyUGXjXMGxyptFygD8wQiNwBVCs4UjCqsUowDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036064; c=relaxed/simple;
	bh=wapbg/gXJVLXNztq58z1k9mtnSNro1BIs4C5En1EkfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OHSmOSePdA6jJ55k6nt9Kt7rb+e1uMp62tAXEn84TNVzasPeovDnGZEZFLjNaof7x0npzTcEzrVKR7hABIlss04yb+t1ipikO/PqPd3mHK4fb5yN8XHEjDcgfDjY3cah70JQdZwBDkhrIKQo6h4mzWLohRf1P22/HeauIWPoRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M0KNNqkR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NHIlv0003720;
	Tue, 23 Jan 2024 18:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ik5Su9uSOfqH7bHMar+7HHjjFYHb1/D+732FGMae6dg=; b=M0
	KNNqkRX3W9lxqzd5p1wXDdgs11Um8DG8qeTKcGBoGVEAeGuRJDPyEZDKQgtPNISm
	fAuUzAkR99z2IBT3+pfInwAOA8ONw5KeZkpCq//ekSaFeCRyla3puMFYFPBs20uN
	SJiFbVTwHpw95WA1ZxuSPIyBQhpgTGdn0w1j87U5KQkvdWZYEiElMMQrAZDenRKC
	g08++p359p2gQR+IZDhazxs24+IrCo/lTpEE/du4xJOqOKFJKt0cgGlcED9ux5XE
	8umVGUfB1fGNZYzCJ6x4xWyv8ny/OLNephkuU8biRUEggi5isQ7gHOs/gsDl30PI
	MRmme7r+bzcIdIv9mAWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vthrb872x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:54:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NIsHdj014567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:54:17 GMT
Received: from [10.110.85.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 10:54:17 -0800
Message-ID: <02dc2748-e73d-f565-9879-6a05e84cbd8b@quicinc.com>
Date: Tue, 23 Jan 2024 10:54:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: qcom: aoss: Add tracepoints in qmp_send()
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gXI3Fr6ZJOBmex97sEvAFM0dBOC0yxtz
X-Proofpoint-ORIG-GUID: gXI3Fr6ZJOBmex97sEvAFM0dBOC0yxtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230140



On 1/17/2024 7:52 PM, Bjorn Andersson wrote:
> @@ -235,6 +238,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
>   
>   	mutex_lock(&qmp->tx_lock);
>   
> +	trace_aoss_send(buf);
> +
>   	/* The message RAM only implements 32-bit accesses */
>   	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
>   			 buf, sizeof(buf) / sizeof(u32));
> @@ -256,6 +261,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
>   		ret = 0;
>   	}
>   
> +	trace_aoss_send_done(buf, ret);
> +

As a side note, another place where we've traced before is on the 
receiving irq to get the full timing of how long AOSS takes to process a 
command. I think we've discussed this in the past and decided that we 
can use kprobes if that need occurs.

>   	mutex_unlock(&qmp->tx_lock);
>   
>   	return ret;
> diff --git a/drivers/soc/qcom/trace-aoss.h b/drivers/soc/qcom/trace-aoss.h
> new file mode 100644
> index 000000000000..48cd3f0f4cb8
> --- /dev/null
> +++ b/drivers/soc/qcom/trace-aoss.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qcom_aoss
> +
> +#if !defined(_TRACE_RPMH_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RPMH_H

Any Reason for this to be _TRACE_RPMH_H instead of _TRACE_AOSS_H?


