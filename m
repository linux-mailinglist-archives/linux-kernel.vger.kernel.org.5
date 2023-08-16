Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9A77E604
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbjHPQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbjHPQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:07:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2EE2;
        Wed, 16 Aug 2023 09:07:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFUeH3005295;
        Wed, 16 Aug 2023 16:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z91vvNC/Au2qvg1HL8J6YleQL6I/pRIJXnm/bn5KRcA=;
 b=IKfG806RswPb5FeDS1yVfEh6vevmJ0BFwU/28nfZ6gxplOqZo6lF6ZT/xljwfDsOXEn7
 kRupK1RujW7hCmstCMIviJiloV9TlxhqBco9SYs8cFBCCj2BRAPHoD14RrT9D00JQ9ij
 8Kl6JJj0MxIXztmDc2n+Wg3SLzj6msruusUa5SrFZqcatSKkl8/prr8w0n6sv+uReEFb
 Kv9bKGOlgHmck+o4/y5UkdnvXOHJprlXLgIZ7aVesIHIYfTNBz9UqVqtHVhdBsRPX0y2
 gei7gnIZha5qI35E5OfsBifPDon8hyvrjqbxxyQO1Exo1RzjQo04M459fbj7S2CkA3FI lA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgvrgrpnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:01:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GG1Tsx030903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:01:29 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 09:01:24 -0700
Message-ID: <5719ee0f-3cc5-e079-169b-a21f3c221146@quicinc.com>
Date:   Wed, 16 Aug 2023 21:31:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V4] scsi: ufs: qcom: Align programming sequence as per HW
 spec
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <quic_cang@quicinc.com>,
        <quic_asutoshd@quicinc.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <jejb@linux.ibm.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_ziqichen@quicinc.com>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230814142903.22780-1-quic_nitirawa@quicinc.com>
 <20230814234720.GW1428172@hu-bjorande-lv.qualcomm.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230814234720.GW1428172@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8gu5vvirHQOUCRKPdBZ5fQaSbVWaeL3H
X-Proofpoint-ORIG-GUID: 8gu5vvirHQOUCRKPdBZ5fQaSbVWaeL3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160140
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for reviewing the patch..We will take care of the comments and 
push next patchset.

-Nitin

On 8/15/2023 5:17 AM, Bjorn Andersson wrote:
> On Mon, Aug 14, 2023 at 07:59:03PM +0530, Nitin Rawat wrote:
>> Align clock configuration as per Qualcomm UFS controller hardware
>> specification. As part of this patch we are aligning sequence
>> for SYS1CLK_1US, MAX_CORE_CLK_1US_CYCLES and
>> PA_VS_CORE_CLK_40NS_CYCLES.
>>
>> SYS1CLK_1US_REG represents the required number of system 1-clock
>> cycles for one microsecond. MAX_CORE_CLK_1US_CYCLES represents the
>> required number of Qunipro core clock for one microsecond.
>> PA_VS_CORE_CLK_40NS_CYCLES represents the required number of
>> Qunipro core clock for 40 nanoseconds.
>>
>> a) Support CORE_CLK_1US_CYCLES and PA_VS_CORE_CLK_40NS_CYCLES
>> for multiple unipro clock frequencies. This is currently handled
>> only for only 150Mhz and 75MHz. Also Configure SYS1CLK_1US_REG for
>> pre scale up condition.
>>
>> b) Update offset for core_clk_1us_cycles in DME_VS_CORE_CLK_CTRL. This
>> offset is changed from Qualcomm UFS Controller V4.0.0 onwards.
>>
>> c) Qualcomm UFS controller V4.0 and onwards PA_VS_CORE_CLK_40NS_CYCLES
>> attribute needs to be programmed with frequency of unipro core clk of
>> UFS host controller.
>>
>> d) Enable internal HW division of unipro core_clk based on scale up and
>> scale down condition. This bit should be cleared before entering any
>> SVS mode.
>>
> 
> Thank you for expanding this, now it's much easier to reason about the
> content of the patch.
> 
> 
> The change refactors ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(),
> adjusts the configuration for versions before 4, add new clock
> configuration for version 4.
> 
> With such an impact across many generations of hardware, and the
> refactoring, there is a significant risk of regressions. By lumping all
> these changes into one commit, it wouldn't be possible to distinguish
> regressions due to typos in the refactoring, changes to the existing
> clock support or regressions due to changes for version 4.
> 
> 
> I'd therefor like for you to split this in multiple patches, to isolate
> these different categories of changes.
> 
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>
>> Changes from v3:
>> -Addressed bjorn comment to update commit msg to capture change details.
>>
>> Changes from v2:
>> - Addressed bao comment, removed duplicate clock timer cfg API call
>>
>> Changes from v1:
>> - Addressed bao comment, removed wrapper function
>> - Tab alignment
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 261 ++++++++++++++++++++++++++----------
>>   drivers/ufs/host/ufs-qcom.h |  20 ++-
>>   2 files changed, 207 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index f88febb23123..5b603886f3d1 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -91,10 +91,7 @@ static const struct __ufs_qcom_bw_table {
>>   };
>>
>>   static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>> -
>>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles);
>>
>>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>>   {
>> @@ -532,7 +529,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>>    * Return: zero for success and non-zero in case of a failure.
>>    */
>>   static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>> -			       u32 hs, u32 rate, bool update_link_startup_timer)
>> +				 u32 hs, u32 rate, bool link_startup,
>> +				 bool is_pre_scale_up)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	struct ufs_clk_info *clki;
>> @@ -563,11 +561,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
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
>> @@ -576,8 +579,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
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
>> @@ -657,7 +666,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   		mb();
>>   	}
>>
>> -	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
>> +	if (link_startup && host->hw_ver.major != 0x5) {
>>   		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
>>   			      REG_UFS_CFG0);
>>   		/*
>> @@ -670,6 +679,105 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   	return 0;
>>   }
>>
>> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>> +				      u32 clk_1us_cycles,
>> +				      u32 clk_40ns_cycles,
>> +				      bool scale_up)
>> +{
>> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	u32 mask = MAX_CORE_CLK_1US_CYCLES_MASK;
>> +	u32 offset = 0;
>> +	u32 reg;
>> +	int err;
>> +
>> +	/* Bit mask and offset changed on UFS host controller V4.0.0 onwards */
>> +	if (host->hw_ver.major >= 4) {
>> +		mask = MAX_CORE_CLK_1US_CYCLES_MASK_V4;
>> +		offset = MAX_CORE_CLK_1US_CYCLES_OFFSET_V4;
>> +	}
>> +
>> +	if (clk_1us_cycles > mask)
>> +		return -EINVAL;
>> +
>> +	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
>> +	if (err)
>> +		return err;
>> +
>> +	reg &= ~(mask << offset);
>> +	reg |= clk_1us_cycles << offset;
>> +
>> +	if (scale_up)
>> +		reg |= CORE_CLK_DIV_EN_BIT;
>> +
>> +	err = ufshcd_dme_set(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), reg);
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * UFS host controller V4.0.0 onwards needs to program
>> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>> +	 * frequency of unipro core clk of UFS host controller.
>> +	 */
>> +	if (host->hw_ver.major >= 4) {
>> +		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>> +			return -EINVAL;
>> +
>> +		err = ufshcd_dme_get(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     &reg);
>> +		if (err)
>> +			return err;
>> +
>> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
>> +		reg |= clk_40ns_cycles;
>> +
>> +		err = ufshcd_dme_set(hba,
>> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
>> +				     reg);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)
>> +{
>> +	struct list_head *head = &hba->clk_list_head;
>> +	struct ufs_clk_info *clki;
>> +	u32 max_freq = 0;
>> +	int err;
>> +
>> +	list_for_each_entry(clki, head, list) {
>> +		if (!IS_ERR_OR_NULL(clki->clk) &&
>> +		    (!strcmp(clki->name, "core_clk_unipro"))) {
> 
> Unnecessary parenthesis, and line wrap (you may go beyond 80 characters
> if that improves readability).

    Sure will take care in next patchset


> 
>> +			max_freq = clki->max_freq;
>> +			break;
>> +		}
>> +	}
>> +
>> +	switch (max_freq) {
>> +	case MHZ_403:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16, true);
>> +		break;
>> +	case MHZ_300:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12, true);
>> +		break;
>> +	case MHZ_201_5:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8, true);
>> +		break;
>> +	case MHZ_150:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6, true);
>> +		break;
>> +	case MHZ_100:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, true);
>> +		break;
>> +	default:
>> +		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);
>> +		err = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return err;
>> +}
>>   static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   					enum ufs_notify_change_status status)
>>   {
>> @@ -679,19 +787,21 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>>   	switch (status) {
>>   	case PRE_CHANGE:
>>   		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
>> -					0, true)) {
>> +					0, true, false)) {
>>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>>   				__func__);
>>   			return -EINVAL;
>>   		}
>>
>> -		if (ufs_qcom_cap_qunipro(host))
>> -			/*
>> -			 * set unipro core clock cycles to 150 & clear clock
>> -			 * divider
>> -			 */
>> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
>> -									  150);
>> +		if (ufs_qcom_cap_qunipro(host)) {
>> +			err = ufs_qcom_cfg_core_clk_ctrl(hba);
>> +			if (err) {
>> +				dev_err(hba->dev,
>> +					"%s cfg core clk ctrl failed\n",
>> +					__func__);
>> +				return err;
>> +			}
>> +		}
>>
>>   		/*
>>   		 * Some UFS devices (and may be host) have issues if LCC is
>> @@ -926,7 +1036,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   	case POST_CHANGE:
>>   		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
>>   					dev_req_params->pwr_rx,
>> -					dev_req_params->hs_rate, false)) {
>> +					dev_req_params->hs_rate, false, false)) {
>>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>>   				__func__);
>>   			/*
>> @@ -1296,69 +1406,52 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>>   	phy_exit(host->generic_phy);
>>   }
>>
>> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>> -						       u32 clk_cycles)
>> +static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>>   {
>> -	int err;
>> -	u32 core_clk_ctrl_reg;
>> -
>> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
>> -		return -EINVAL;
>> -
>> -	err = ufshcd_dme_get(hba,
>> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>> -			    &core_clk_ctrl_reg);
>> -	if (err)
>> -		return err;
>> -
>> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>> -	core_clk_ctrl_reg |= clk_cycles;
>> -
>> -	/* Clear CORE_CLK_DIV_EN */
>> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>> +	int err = 0;
>>
>> -	return ufshcd_dme_set(hba,
>> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>> -			    core_clk_ctrl_reg);
>> -}
>> +	if (!ufs_qcom_cap_qunipro(host))
>> +		goto out;
>>
>> -static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>> -{
>> -	/* nothing to do as of now */
>> -	return 0;
>> +	if (attr) {
>> +		err = ufs_qcom_cfg_timers(hba, attr->gear_rx,
>> +					    attr->pwr_rx, attr->hs_rate,
>> +					    false, true);
>> +		if (err)
>> +			dev_err(hba->dev, "%s ufs cfg timer failed\n",
>> +					  __func__);
>> +	}
>> +	err = ufs_qcom_cfg_core_clk_ctrl(hba);
>> +out:
>> +	return err;
>>   }
>>
>>   static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>>   {
>> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -
>> -	if (!ufs_qcom_cap_qunipro(host))
>> -		return 0;
>> -
>> -	/* set unipro core clock cycles to 150 and clear clock divider */
>> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
>> +	return 0;
>>   }
>>
>>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	int err;
>> -	u32 core_clk_ctrl_reg;
>> +	u32 reg;
> 
> Really nice to see these variable names being cleaned up, but it makes
> it harder to determine what the functional change is. So again, better
> to keep that in a separate patch.

   Sure will take care of this in next patchset



> 
>>
>>   	if (!ufs_qcom_cap_qunipro(host))
>>   		return 0;
>>
>> -	err = ufshcd_dme_get(hba,
>> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>> -			    &core_clk_ctrl_reg);
>> +	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
>> +	if (err)
>> +		return err;
>>
>>   	/* make sure CORE_CLK_DIV_EN is cleared */
>> -	if (!err &&
>> -	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
>> -		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
>> +	if (reg & CORE_CLK_DIV_EN_BIT) {
>> +		reg &= ~CORE_CLK_DIV_EN_BIT;
>>   		err = ufshcd_dme_set(hba,
>>   				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>> -				    core_clk_ctrl_reg);
>> +				    reg);
>>   	}
>>
>>   	return err;
>> @@ -1367,19 +1460,50 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>>   static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>> +	struct list_head *head = &hba->clk_list_head;
>> +	struct ufs_clk_info *clki;
>> +	u32 curr_freq = 0;
>> +	int err;
>>
>>   	if (!ufs_qcom_cap_qunipro(host))
>>   		return 0;
>>
>> -	/* set unipro core clock cycles to 75 and clear clock divider */
>> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
>> +	if (attr)
>> +		ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
>> +					 attr->hs_rate, false, false);
>> +
>> +	list_for_each_entry(clki, head, list) {
>> +		if (!IS_ERR_OR_NULL(clki->clk) &&
>> +		   (!strcmp(clki->name, "core_clk_unipro"))) {
> 
> Unnecessary parenthesis, and line wrap (you may go beyond 80 characters
> if that improves readability).

   We will take care of this in next patch.


> 
>> +			curr_freq = clk_get_rate(clki->clk);
>> +			break;
>> +		}
>> +	}
>> +
>> +	switch (curr_freq) {
>> +	case MHZ_37_5:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2, false);
>> +		break;
>> +	case MHZ_75:
>> +		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3, false);
>> +		break;
>> +	case MHZ_100:
>> +	err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, false);
> 
> Odd indentation.
> 
> Regards,
> Bjorn
