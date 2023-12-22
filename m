Return-Path: <linux-kernel+bounces-9489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975181C66A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55AA1F24DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF07D2E0;
	Fri, 22 Dec 2023 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TknAz7gp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94579C8D5;
	Fri, 22 Dec 2023 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM5tRXd021265;
	Fri, 22 Dec 2023 08:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=k9NnBgwQWBGlcSjw2XivotEuVpgrgcbg+BSWC1pANec=; b=Tk
	nAz7gppl9MkvonLXpmMYcXmPTv/pvgPQOoSOp6+ZfEVq8pK8tG8Qtmdy3Tt1aZxN
	P0ANBhktzGBvl1kHD1V8elMXzKiA/5i8RhtN9hkSsPK/LKfDGkykffCQahOdzaAW
	DWWbWzSS1hIgtIJVGm3F9qMpvWBKPdRDv9z157qQPJkOBlG52/POi+GjtQ5xnztS
	55eQbub7w4UN6eKqbdeL4f03t9qEMRRkCQFJSsEdjxhLDWN3pt44AaXtde6iy1DU
	MHWnVJWh6JL6bQZzJIREciMFv925MRI0G4cGO2AXVX/zxb/A7UfNVLFHpGhOCVms
	63QkdcBEJRajLZeyXtkw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4xe513mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:20:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM8KPm9020211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:20:25 GMT
Received: from [10.253.15.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 00:20:21 -0800
Message-ID: <107abfd9-b3f5-4495-b86c-070ed354d2bb@quicinc.com>
Date: Fri, 22 Dec 2023 16:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/11] scsi: ufs: qcom: Perform read back after
 writing testbus config
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-3-2195a1b66d2e@redhat.com>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-3-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ALaKptp8_57e4SGB9WqiqVeHmzrlq4Z2
X-Proofpoint-GUID: ALaKptp8_57e4SGB9WqiqVeHmzrlq4Z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220058



On 12/22/2023 3:09 AM, Andrew Halaney wrote:
> Currently, the testbus configuration is written and completed with an
> mb().
> 
> mb() ensure that the write completes, but completion doesn't mean
> that it isn't stored in a buffer somewhere. The recommendation for
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
> Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 4c15c8a1d058..6df2ab3b6f23 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1332,6 +1332,9 @@ static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
>   	ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
>   			UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
>   	ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
> +
> +	/* dummy read to ensure this has been enabled prior to returning */
> +	ufshcd_readl(host->hba, REG_UFS_CFG1);
>   }
>   
>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host)
> @@ -1429,11 +1432,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
>   		    (u32)host->testbus.select_minor << offset,
>   		    reg);
>   	ufs_qcom_enable_test_bus(host);
> -	/*
> -	 * Make sure the test bus configuration is
> -	 * committed before returning.
> -	 */
> -	mb();
>   
>   	return 0;
>   }
> 
Reviewed-by: Can Guo <quic_cang@quicinc.com>

