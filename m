Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60680C554
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjLKJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:57:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D6B8;
        Mon, 11 Dec 2023 01:57:06 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB8vQIw002804;
        Mon, 11 Dec 2023 09:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:from:subject:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=eZz2NH0MpC5WvnNslfBa0k9lf1A6RK8ts/s7dSoDI9g=; b=Mc
        PXVTDPGbgxwLNKw1SoIs/vIYK4F/8cFrAAWt9E7Fd5qIWWGKNNerJ1/FffgWm0O5
        rHTKhE102XCx7No1pegnrk3GvEKK3ax+x0CM68qBmfS2tYQRfGaVGnRytMgNA44c
        iiP0sJIUxy9MahCRHFVoIcA7nmSzNdlCqX305tuLbk988r0JvNcKS6dID3/OEqJw
        T3pKTwxCczsLarvtZPkwzg09bq9VcOnR1wHP5RO8Rg4NM0bT7vAkGtJ0yKEbzANu
        CEHEKnGVwt19eohz9xgEnFWaPIc6fwRzAICdQLeFtOO5dVz8KF1avUDHwNhaldPg
        SEWV+MT+bdQYw/iLN7Zg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnnstv8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:56:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB9uPdX017166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:56:26 GMT
Received: from [10.217.219.220] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 01:56:19 -0800
Message-ID: <9330ff38-5285-43d8-bf90-3441762fdb9c@quicinc.com>
Date:   Mon, 11 Dec 2023 15:26:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Naresh Maramaina <quic_mnaresh@quicinc.com>
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <chu.stanley@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, Nitin Rawat <quic_nitirawa@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <20231206152646.GH12802@thinkpad>
Content-Language: en-US
In-Reply-To: <20231206152646.GH12802@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8EL01U5GejapoCFeM0qsMjrDVxFEs5iU
X-Proofpoint-GUID: 8EL01U5GejapoCFeM0qsMjrDVxFEs5iU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2023 8:56 PM, Manivannan Sadhasivam wrote:
> On Mon, Dec 04, 2023 at 08:00:59PM +0530, Maramaina Naresh wrote:
>> Register ufs driver to CPU latency PM QoS framework can improves
>> ufs device random io performance.
>>
>> PM QoS initialization will insert new QoS request into the CPU
>> latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
>> value.
>>
>> UFS driver will vote for performance mode on scale up and power
>> save mode for scale down.
>>
>> If clock scaling feature is not enabled then voting will be based
>> on clock on or off condition.
>>
>> tiotest benchmark tool io performance results on sm8550 platform:
>>
>> 1. Without PM QoS support
>> 	Type (Speed in)    | Average of 18 iterations
>> 	Random Write(IPOS) | 41065.13
>> 	Random Read(IPOS)  | 37101.3
>>
>> 2. With PM QoS support
>> 	Type (Speed in)    | Average of 18 iterations
>> 	Random Write(IPOS) | 46784.9
>> 	Random Read(IPOS)  | 42943.4
>> (Improvement % with PM QoS = ~15%).
>>
>> Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
>> ---
>>   drivers/ufs/core/ufshcd-priv.h |  8 +++++
>>   drivers/ufs/core/ufshcd.c      | 62 ++++++++++++++++++++++++++++++++++
>>   include/ufs/ufshcd.h           | 16 +++++++++
>>   3 files changed, 86 insertions(+)
>>
>> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>> index f42d99ce5bf1..536805f6c4e1 100644
>> --- a/drivers/ufs/core/ufshcd-priv.h
>> +++ b/drivers/ufs/core/ufshcd-priv.h
>> @@ -241,6 +241,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>>   		hba->vops->config_scaling_param(hba, p, data);
>>   }
>>   
>> +static inline u32 ufshcd_vops_config_qos_vote(struct ufs_hba *hba)
>> +{
>> +	if (hba->vops && hba->vops->config_qos_vote)
>> +		return hba->vops->config_qos_vote(hba);
> 
> Please remove this callback as Bart noted.
> 

Sure Mani, will takecare of this comment.

>> +
>> +	return UFSHCD_QOS_DEFAULT_VOTE;
>> +}
>> +
>>   static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
>>   {
>>   	if (hba->vops && hba->vops->reinit_notify)
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index ae9936fc6ffb..13370febd2b5 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -1001,6 +1001,20 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>>   	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
>>   }
>>   
>> +/**
>> + * ufshcd_pm_qos_perf - vote for PM QoS performance or power save mode
> 
> ufshcd_pm_qos_update() - Update PM QoS request
> 

Sure Mani, will takecare of this comment.

>> + * @hba: per adapter instance
>> + * @on: If True, vote for perf PM QoS mode otherwise power save mode
>> + */
>> +static void ufshcd_pm_qos_perf(struct ufs_hba *hba, bool on)
>> +{
>> +	if (!hba->pm_qos_init)
>> +		return;
>> +
>> +	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? hba->qos_vote
>> +							: PM_QOS_DEFAULT_VALUE);
>> +}
>> +
>>   /**
>>    * ufshcd_set_clk_freq - set UFS controller clock frequencies
>>    * @hba: per adapter instance
>> @@ -1153,6 +1167,10 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
>>   	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
>>   			(scale_up ? "up" : "down"),
>>   			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
>> +
>> +	if (!ret)
>> +		ufshcd_pm_qos_perf(hba, scale_up);
> 
> Can't you just move this before trace_ufshcd_profile_clk_scaling()? This also
> avoids checking for !ret.
> 

In this case, we need to use goto out; inside if condition of 
ufshcd_vops_clk_scale_notify.

we can enable ufshcd_pm_qos_perf only when ufshcd_vops_clk_scale_notify 
is successful.

Will add goto out; in next patch set.


>> +
>>   	return ret;
>>   }
>>   
>> @@ -9204,6 +9222,8 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (!ufshcd_is_clkscaling_supported(hba))
>> +		ufshcd_pm_qos_perf(hba, on);
>>   out:
>>   	if (ret) {
>>   		list_for_each_entry(clki, head, list) {
>> @@ -9296,6 +9316,45 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
>>   	return ret;
>>   }
>>   
>> +/**
>> + * ufshcd_pm_qos_init - initialize PM QoS instance
> 
> "Initialize PM QoS request"
> 

Sure Mani, will takecare of this comment.

>> + * @hba: per adapter instance
>> + */
>> +static void ufshcd_pm_qos_init(struct ufs_hba *hba)
>> +{
>> +	if (!(hba->caps & UFSHCD_CAP_PM_QOS))
>> +		return;
>> +
>> +	/*
>> +	 * called to configure PM QoS vote value for UFS host,
>> +	 * expecting qos vote return value from caller else
>> +	 * default vote value will be return.
>> +	 */
>> +	hba->qos_vote = ufshcd_vops_config_qos_vote(hba);
> 
> No need of this variable too if you get rid of the callback.
> 
>> +	cpu_latency_qos_add_request(&hba->pm_qos_req,
>> +					PM_QOS_DEFAULT_VALUE);
>> +
>> +	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
>> +		hba->pm_qos_init = true;
> 
> Why do you need this flag?

this flag ensure UFS qos request got added into the list.

> 
>> +
>> +	dev_dbg(hba->dev, "%s: QoS %s, qos_vote: %u\n", __func__,
>> +		hba->pm_qos_init ? "initialized" : "uninitialized",
>> +		hba->qos_vote);
>> +}
>> +
>> +/**
>> + * ufshcd_pm_qos_exit - remove instance from PM QoS
>> + * @hba: per adapter instance
>> + */
>> +static void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>> +{
>> +	if (!hba->pm_qos_init)
>> +		return;
>> +
>> +	cpu_latency_qos_remove_request(&hba->pm_qos_req);
>> +	hba->pm_qos_init = false;
>> +}
>> +
> 
> [...]
> 
>>   /**
>>    * struct ufs_hba - per adapter private structure
>>    * @mmio_base: UFSHCI base register address
>> @@ -912,6 +923,8 @@ enum ufshcd_mcq_opr {
>>    * @mcq_base: Multi circular queue registers base address
>>    * @uhq: array of supported hardware queues
>>    * @dev_cmd_queue: Queue for issuing device management commands
>> + * @pm_qos_req: PM QoS request handle
>> + * @pm_qos_init: flag to check if pm qos init completed
>>    */
>>   struct ufs_hba {
>>   	void __iomem *mmio_base;
>> @@ -1076,6 +1089,9 @@ struct ufs_hba {
>>   	struct ufs_hw_queue *uhq;
>>   	struct ufs_hw_queue *dev_cmd_queue;
>>   	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
>> +	struct pm_qos_request pm_qos_req;
>> +	bool pm_qos_init;
>> +	u32 qos_vote;
> 
> Order doesn't match Kdoc.
>

qos_vote variable will be remove as per latest comment.

> - Mani
> 

Thanks,
Naresh.
