Return-Path: <linux-kernel+bounces-9501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D581C69A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089CD28807E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45ABC2F0;
	Fri, 22 Dec 2023 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I4FKeQR5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17661DA36;
	Fri, 22 Dec 2023 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM719DU015012;
	Fri, 22 Dec 2023 08:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GL6lp2wW4JHVejR/6UuwkRpfRLijH7j1BFmAhAH8s10=; b=I4
	FKeQR5CDhWRiaAqoN+EFQzvnSv8qqy+EXgW0BV7QrRP+ULZNTFDRtJ7dsAMFrKqS
	gCMOAj7tZ4f/nh5GOP9kpDLzs4zkc0jhCq45H9wzQhVTq2dZpUTMHIw+nl3gJS8C
	9V4yEyAam5Yg7RcNHarIbIXrpbd6XfAFdQvkhNHJtEhN7eCSWpsZuaTlZ4dAM3MY
	vU66u97/Hje+QNCzBqI4CUqJ6DIpf2klxoT++trN76hM1w3jlPI4c9VqmwAk7WUT
	CZ0pcFR+oV/9QIbu9SgVvFbju68usVUvk6EKgCeie9fFA8+zmEJ2P4Uvs6Jd+Tec
	sCYOzsWk+mqq3QVUBBTw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4ptgjey0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:27:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM8Rv8b031578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:27:57 GMT
Received: from [10.253.15.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 00:27:53 -0800
Message-ID: <c4d20f0c-89ff-4d80-a648-1e4ef2aee9af@quicinc.com>
Date: Fri, 22 Dec 2023 16:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 11/11] scsi: ufs: core: Perform read back before
 writing run/stop regs
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Janek Kotas
	<jank@cadence.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman
	<avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
CC: Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v3-11-2195a1b66d2e@redhat.com>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-11-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QRRHUvIAmp6VrEnCJ3WCDmzWks2yM4Od
X-Proofpoint-ORIG-GUID: QRRHUvIAmp6VrEnCJ3WCDmzWks2yM4Od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=986 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220059



On 12/22/2023 3:09 AM, Andrew Halaney wrote:
> Currently a wmb() is used to ensure that writes to the
> UTP_TASK_REQ_LIST_BASE* regs are completed prior to following writes to
> the run/stop registers.
> 
> wmb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring the bits have taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>      https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bits hit the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index caebd589e08c..7c1975a1181f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4726,7 +4726,7 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
>   	 * Make sure base address and interrupt setup are updated before
>   	 * enabling the run/stop registers below.
>   	 */
> -	wmb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
>   
>   	/*
>   	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1
> 
Reviewed-by: Can Guo <quic_cang@quicinc.com>

