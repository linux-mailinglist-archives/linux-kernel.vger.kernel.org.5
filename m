Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454378E933
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjHaJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHaJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:18:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42DCED;
        Thu, 31 Aug 2023 02:18:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V9FmBQ020063;
        Thu, 31 Aug 2023 09:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d8sdrQUWGhc1SdIY2ZpxqRRFc9Qt5M2O2/ou6Jwu4Is=;
 b=J/ojzC1f4snWsaXBqVdk8ruDpNKvsGioAR7nsgzU3fe+XouAWDPKJX5UBn96t9cK88bS
 EBfpKEJfv/ZvdhtpGkTE9FaIU4c0PDVG+8gzVvHatFZiwwCvdGX+v1NP0WYwnIMCwrMp
 nB+CTUO/2E7PRky5BU/ma6tojE74ZvXlr0BpoR7SqkKuuAcxI2VhPhdcmC4/D+pM9DO2
 qq4CvpkVlHL94sY74G+AL2zWPglxeCIIiM1UI+lXP6ME1UgKdStDxU13sm5Ql0IbrLBJ
 FXdxRRmsXMriq9XwFSCIn2kx9x9sK0DkSHUriu8eBi4rrMqXbXuq+qbCIvP6q6IjNmhv 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0tatst0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:18:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V9IYZi025176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 09:18:34 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 02:18:29 -0700
Message-ID: <f539613f-e050-a9ec-ae9b-e6b6db5a9a32@quicinc.com>
Date:   Thu, 31 Aug 2023 14:48:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V5 5/6] scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers
 function.
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-6-quic_nitirawa@quicinc.com>
 <20230828081719.GG5148@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230828081719.GG5148@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: onuHKTfQx5ospRijv_kUUFyeRYketGzu
X-Proofpoint-ORIG-GUID: onuHKTfQx5ospRijv_kUUFyeRYketGzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310083
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2023 1:47 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 23, 2023 at 09:14:12PM +0530, Nitin Rawat wrote:
>> This change configures SYS1CLK_1US_REG for pre scale up condition. Also
>> move ufs_qcom_cfg_timers from clk scaling post change ops to clk scaling
>> pre change ops to align with the hardware specification.
>>
> 
> Same comment as previous patch. This looks like a bug fix to me.
> 
> Also, this patch should be splitted into 2. SYS1CLK_1US_REG and
> ufs_qcom_cfg_timers change.
> 
> - Mani
> 


In this patch we are trying to refactor ufs_qcom_cfg_timers function and 
added extra argument to this function. Since it is just refactoring 
code, IMO it's better to not split in to 2 patches. We will update the 
commit message to explain more in detail

--Nitin

>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 61 +++++++++++++++++++++++++------------
>>   1 file changed, 42 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 491c0173603e..82cf3ac4193a 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -533,7 +533,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>>    * Return: zero for success and non-zero in case of a failure.
>>    */
>>   static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>> -			       u32 hs, u32 rate, bool update_link_startup_timer)
>> +				 u32 hs, u32 rate, bool link_startup,
>> +				 bool is_pre_scale_up)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	struct ufs_clk_info *clki;
>> @@ -564,11 +565,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   	/*
>>   	 * The Qunipro controller does not use following registers:
>>   	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
>> -	 * UFS_REG_PA_LINK_STARTUP_TIMER
>> -	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
>> -	 * Aggregation logic.
>> -	*/
>> -	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
>> +	 * UFS_REG_PA_LINK_STARTUP_TIMER.
>> +	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
>> +	 * Aggregation logic and Auto hibern8 logic.
>> +	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
>> +	 * controller V4.0.0 onwards.
>> +	 */
>> +	if (ufs_qcom_cap_qunipro(host) &&
>> +	    !(ufshcd_is_intr_aggr_allowed(hba) ||
>> +	    ufshcd_is_auto_hibern8_supported(hba) ||
>> +	    host->hw_ver.major >= 4))
>>   		return 0;
>>
>>   	if (gear == 0) {
>> @@ -577,8 +583,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   	}
>>
>>   	list_for_each_entry(clki, &hba->clk_list_head, list) {
>> -		if (!strcmp(clki->name, "core_clk"))
>> -			core_clk_rate = clk_get_rate(clki->clk);
>> +		if (!strcmp(clki->name, "core_clk")) {
>> +			if (is_pre_scale_up)
>> +				core_clk_rate = clki->max_freq;
>> +			else
>> +				core_clk_rate = clk_get_rate(clki->clk);
>> +			break;
>> +		}
>> +
>>   	}
>>
>>   	/* If frequency is smaller than 1MHz, set to 1MHz */
>> @@ -658,7 +670,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   		mb();
>>   	}
>>
>> -	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
>> +	if (link_startup && host->hw_ver.major != 0x5) {
>>   		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
>>   			      REG_UFS_CFG0);
>>   		/*
>> @@ -719,7 +731,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   	switch (status) {
>>   	case PRE_CHANGE:
>>   		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
>> -					0, true)) {
>> +					0, true, false)) {
>>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>>   				__func__);
>>   			return -EINVAL;
>> @@ -968,7 +980,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   	case POST_CHANGE:
>>   		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
>>   					dev_req_params->pwr_rx,
>> -					dev_req_params->hs_rate, false)) {
>> +					dev_req_params->hs_rate, false, false)) {
>>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>>   				__func__);
>>   			/*
>> @@ -1401,11 +1413,24 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>>   static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>> +	int err;
>>
>>   	if (!ufs_qcom_cap_qunipro(host))
>> -		return 0;
>> +		goto out;
>> +
>> +	if (attr) {
>> +		err = ufs_qcom_cfg_timers(hba, attr->gear_rx,
>> +					    attr->pwr_rx, attr->hs_rate,
>> +					    false, true);
>> +		if (err)
>> +			dev_err(hba->dev, "%s ufs cfg timer failed\n",
>> +								__func__);
>> +	}
>>
>> -	return ufs_qcom_cfg_core_clk_ctrl(hba);
>> +	err = ufs_qcom_cfg_core_clk_ctrl(hba);
>> +out:
>> +	return err;
>>   }
>>
>>   static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>> @@ -1441,6 +1466,7 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>>   static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>>   	struct list_head *head = &hba->clk_list_head;
>>   	struct ufs_clk_info *clki;
>>   	u32 curr_freq = 0;
>> @@ -1449,6 +1475,9 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>   	if (!ufs_qcom_cap_qunipro(host))
>>   		return 0;
>>
>> +	if (attr)
>> +		ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
>> +					 attr->hs_rate, false, false);
>>
>>   	list_for_each_entry(clki, head, list) {
>>   		if (!IS_ERR_OR_NULL(clki->clk) &&
>> @@ -1480,7 +1509,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>>   		bool scale_up, enum ufs_notify_change_status status)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
>>   	int err = 0;
>>
>>   	/* check the host controller state before sending hibern8 cmd */
>> @@ -1510,11 +1538,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>>   			return err;
>>   		}
>>
>> -		ufs_qcom_cfg_timers(hba,
>> -				    dev_req_params->gear_rx,
>> -				    dev_req_params->pwr_rx,
>> -				    dev_req_params->hs_rate,
>> -				    false);
>>   		ufs_qcom_icc_update_bw(host);
>>   		ufshcd_uic_hibern8_exit(hba);
>>   	}
>> --
>> 2.17.1
>>
> 
