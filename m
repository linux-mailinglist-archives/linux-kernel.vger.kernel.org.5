Return-Path: <linux-kernel+bounces-9487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20981C662
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A71F261CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50444FBE9;
	Fri, 22 Dec 2023 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqHoFeAZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39106E566;
	Fri, 22 Dec 2023 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM41Kip019525;
	Fri, 22 Dec 2023 08:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7TOELup7HdjFXxHvrLH432qq8ACCVjI2bPKbaa4fHmI=; b=gq
	HoFeAZ/Vj6yKRp/fWjEPs5Ohxu7uNwYhojcOBNDinQ24KE3gBGcvl0jEpCIZ2hKp
	Y6wQHRjgW050kjS1P6kqctds5k+vh4yQIq5jpd69GNsO966p7rjOuMj1yOykfUnd
	fNUy5e3sKdJdlxDW7o1KRHtg8ZdgN/EZwS/uGLLxg1U/Jz3dE/0MZTutJcnW1SJf
	5jk+ZG6zHgG40OLfQnb7ph8CFMbznupLxT0zEx7/RAoIbXqbEVMQhPiB/lcyN29N
	vJcU2FLdgXpXgDu33FNry59XBIS264eY2b8oExenz9PbBmHRGgbwvJ/J4ZZGO07I
	GfCL9Rld+suzi9ILrE6w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v51u08pp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:18:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM8IwqS022676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:18:58 GMT
Received: from [10.253.15.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 00:18:53 -0800
Message-ID: <0be12f26-f78c-4f3b-9560-3061b5ff9d54@quicinc.com>
Date: Fri, 22 Dec 2023 16:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/11] scsi: ufs: qcom: Perform read back after
 writing REG_UFS_SYS1CLK_1US
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-2-2195a1b66d2e@redhat.com>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-2-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h4ueyw0R-9NXOUSMyCW5kAFX1_ssNk4B
X-Proofpoint-ORIG-GUID: h4ueyw0R-9NXOUSMyCW5kAFX1_ssNk4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220058



On 12/22/2023 3:09 AM, Andrew Halaney wrote:
> Currently after writing to REG_UFS_SYS1CLK_1US a mb() is used to ensure
> that write has gone through to the device.
> 
> mb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring this bit has taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>      https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 480787048e75..4c15c8a1d058 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -501,7 +501,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>   		 * make sure above write gets applied before we return from
>   		 * this function.
>   		 */
> -		mb();
> +		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
>   	}
>   
>   	return 0;
> 
Reviewed-by: Can Guo <quic_cang@quicinc.com>

