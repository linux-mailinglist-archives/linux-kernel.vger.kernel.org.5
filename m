Return-Path: <linux-kernel+bounces-9499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB381C696
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FE9287B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EF41A598;
	Fri, 22 Dec 2023 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y10Xr7sc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7519448;
	Fri, 22 Dec 2023 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM6mJT7021447;
	Fri, 22 Dec 2023 08:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IWQzRiq1FJLluo9evumHWLCWgz7uK87P5Y+UWB7CfDE=; b=Y1
	0Xr7sc2sesUsi+IsNReuxibxzl4Gz0uoPKIl81Cc/Z8Mr9szXGxL8xd6m9PNOk+a
	JXlIj6ub6WVpfFcL8K1gvTcnqkPL3y5y/kn2pxOsXS8e47fjDY1XlZb9KPiGNSNL
	epKs4bZVB6mmuzzFFJz7LUf4cDJid3RlmafKXofz2jcsum7irAazZ8/97kz8T6xf
	9P7H2bjr5nTChQHrtj/kiZoL762GT3n1vC9i9xsArlEh1EPjPIjnP9Wc0SP1kpET
	0aKugFNxsjKSJGprS/QtyTEw3dX9WCVhdgX50XKNQNlAzgNXZdqaRe/vcXyp3/Ie
	tB2FKhB6qUvNUc1yVZYg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v51u08qkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM8RI5C023532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:27:19 GMT
Received: from [10.253.15.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 00:27:14 -0800
Message-ID: <2b04cca6-ee41-47c3-86db-c52aa5f5405d@quicinc.com>
Date: Fri, 22 Dec 2023 16:27:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 10/11] scsi: ufs: core: Perform read back to commit
 doorbell
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qtanN9W5L-UCIrrhRrbLM6krCEmG8c36
X-Proofpoint-ORIG-GUID: qtanN9W5L-UCIrrhRrbLM6krCEmG8c36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220058



On 12/22/2023 3:09 AM, Andrew Halaney wrote:
> Currently, the doorbell is written to and a wmb() is used to commit it
> immediately.
> 
> wmb() ensures that the write completes before following writes occur,
> but completion doesn't mean that it isn't stored in a buffer somewhere.
> The recommendation for ensuring this bit has taken effect on the device
> is to perform a read back to force it to make it all the way to the
> device. This is documented in device-io.rst and a talk by Will Deacon on
> this can be seen over here:
> 
>      https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the doorbell")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 75a03ee9a1ba..caebd589e08c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7050,7 +7050,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
>   
>   	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
>   	/* Make sure that doorbell is committed immediately */
> -	wmb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>   
>   	spin_unlock_irqrestore(host->host_lock, flags);
>   
> 
Reviewed-by: Can Guo <quic_cang@quicinc.com>

