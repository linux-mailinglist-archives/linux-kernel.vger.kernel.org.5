Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880AB79A30D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjIKF4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIKF4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:56:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6899;
        Sun, 10 Sep 2023 22:56:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B59Zi0004353;
        Mon, 11 Sep 2023 05:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5fskxNYip6juZF6ZgboQP1brWeEpv2IVbnXaOrDETNI=;
 b=Nil08lPxJxwqq2b5L+apd/zT9MzQnP+iq6DLd10yZ8YW+D0DpTbLOagauAX78Z3LPQKI
 LOFrqhpzsVnNX/Gf+SZdlqdT/uTV4oYdpbiots0N/Zt/PfqIlFrsScuuNPTzCiFqWsBP
 WcWq106+ULjqvqoGm1baR87AhzuxscDJloaQcxima6F6Kkixug8zGu0fQM11Bd1Usjab
 aHs8dUH+fxcU8Jc0dyO+UVjauLFIXTQvMe5po3Ti1ggKo77nNzQwCBcvuL5pdqjTGFHP
 e7MbwKazQTxZVG2909Z1HaHl4nUmyPNX20xdCEglu1rzzfR5R3oupTJffo6bColmK16h pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0j0fjrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:55:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B5tp7T017058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:55:51 GMT
Received: from [10.253.14.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 22:55:48 -0700
Message-ID: <6cd2b67a-5c92-536f-6233-e1dae5e1c3a2@quicinc.com>
Date:   Mon, 11 Sep 2023 13:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] scsi: ufs: ufs-qcom: Update PHY settings only when
 scaling to higher gears
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <bvanassche@acm.org>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_nitirawa@quicinc.com>, <stable@vger.kernel.org>
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qxZlqyBcbhgKm5xWA9ggx6mhf5P7ZomE
X-Proofpoint-GUID: qxZlqyBcbhgKm5xWA9ggx6mhf5P7ZomE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110054
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/2023 10:53 PM, Manivannan Sadhasivam wrote:
> The "hs_gear" variable is used to program the PHY settings (submode) during
> ufs_qcom_power_up_sequence(). Currently, it is being updated every time the
> agreed gear changes. Due to this, if the gear got downscaled before suspend
> (runtime/system), then while resuming, the PHY settings for the lower gear
> will be applied first and later when scaling to max gear with REINIT, the
> PHY settings for the max gear will be applied.
>
> This adds a latency while resuming and also really not needed as the PHY
> gear settings are backwards compatible i.e., we can continue using the PHY
> settings for max gear with lower gear speed.
>
> So let's update the "hs_gear" variable _only_ when the agreed gear is
> greater than the current one. This guarantees that the PHY settings will be
> changed only during probe time and fatal error condition.
>
> Due to this, UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH can now be skipped
> when the PM operation is in progress.
>
> Cc: stable@vger.kernel.org
> Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
> Reported-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/core/ufshcd.c   | 3 ++-
>   drivers/ufs/host/ufs-qcom.c | 9 +++++++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 34472871610d..1f0a9d96e613 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8782,7 +8782,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>   	if (ret)
>   		goto out;
>   
> -	if (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH) {
> +	if (!hba->pm_op_in_progress &&
> +	    (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH)) {
>   		/* Reset the device and controller before doing reinit */
>   		ufshcd_device_reset(hba);
>   		ufshcd_hba_stop(hba);
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 78689d3479e4..ebb8054a3b3e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -909,8 +909,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   			return ret;
>   		}
>   
> -		/* Use the agreed gear */
> -		host->hs_gear = dev_req_params->gear_tx;
> +		/*
> +		 * Update hs_gear only when the gears are scaled to a higher value. This is because,
> +		 * the PHY gear settings are backwards compatible and we only need to change the PHY
> +		 * settings while scaling to higher gears.
> +		 */
> +		if (dev_req_params->gear_tx > host->hs_gear)
> +			host->hs_gear = dev_req_params->gear_tx;
>   
>   		/* enable the device ref clock before changing to HS mode */
>   		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&

Reviewed-by: Can Guo <quic_cang@quicinc.com>

Tested-by: Can Guo <quic_cang@quicinc.com>

