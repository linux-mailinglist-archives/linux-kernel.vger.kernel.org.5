Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14AC77569A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHIJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHIJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:42:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F59E5F;
        Wed,  9 Aug 2023 02:42:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37991Vh4023148;
        Wed, 9 Aug 2023 09:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gAlmMSajNxGiqRP/5zj4/uLsFVR+F11R41QkqU+VSy0=;
 b=nu0Ggx2a2PjTtVmuh4QPufVlEqq48uwdh/0572vSWcHiVbqtR9cWckvkBTyLFyC6Ql1a
 WlGKWgb2jbOsAWVEZH12h45r8iCIm0ud8KSMZFXXLKnJ00ZZygHNIHD8/aIbmGY4VKSN
 kWYETYSwgvXhbhRUTdmHmD1tX68T7Qnu9vs8vEWci3yqQXTSx2Q2czW74hpkRqOfnhyd
 9/ZI+a30UqB+DLkZo0+IsnQoDC3Q5qTCvCrtQbnlD6Oo+ZBnlXsgliY/Pdk8yJdomhP0
 SYoYm2Gk5i4VVeAMq04VKixFb3+s92356vDRINVpBe3DVm6QGONKenE32MQjByL5S++2 SA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbpqs266u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:42:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3799gZRV000643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 09:42:35 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 02:42:34 -0700
Message-ID: <de939daa-70be-8a21-0d86-3fdc59bc5979@quicinc.com>
Date:   Wed, 9 Aug 2023 02:42:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] scsi: ufs: qcom: Align programming sequence as per HW
 spec
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>
CC:     <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <jejb@linux.ibm.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_ziqichen@quicinc.com>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230808150438.13523-1-quic_nitirawa@quicinc.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230808150438.13523-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qzNneTJsgckBZjE4QWk9-sk-bJB1ztgE
X-Proofpoint-ORIG-GUID: qzNneTJsgckBZjE4QWk9-sk-bJB1ztgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_08,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090085
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 8:04 AM, Nitin Rawat wrote:
> Align clock configuration as per Qualcomm UFS controller
> hardware specification.
> 
> This change updates UFS_SYS1CLK_1US, CORE_CLK_1US_CYCLES,
> PA_VS_CORE_CLK_40NS_CYCLES timer configuration for Qunipro
> and UTP to align with Qualcomm UFS HW specification.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
> 
> Changes from v1:
> - Addressed bao comment, removed wrapper function
> - Tab alignment
> ---
>   drivers/ufs/host/ufs-qcom.c | 259 +++++++++++++++++++++++++++---------
>   drivers/ufs/host/ufs-qcom.h |  20 ++-
>   2 files changed, 210 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index e7164ce7336b..1b6904f28163 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -91,10 +91,7 @@ struct __ufs_qcom_bw_table {
>   };
> 
>   static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> -
>   static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles);
> 
>   static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>   {
> @@ -532,7 +529,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>    * Return: zero for success and non-zero in case of a failure.
>    */
>   static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
> -			       u32 hs, u32 rate, bool update_link_startup_timer)
> +				 u32 hs, u32 rate, bool link_startup,
> +				 bool is_pre_scale_up)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>   	struct ufs_clk_info *clki;
> @@ -563,11 +561,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>   	/*
>   	 * The Qunipro controller does not use following registers:
>   	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
> -	 * UFS_REG_PA_LINK_STARTUP_TIMER
> -	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
> -	 * Aggregation logic.
> -	*/
> -	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
> +	 * UFS_REG_PA_LINK_STARTUP_TIMER.
> +	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
> +	 * Aggregation logic and Auto hibern8 logic.
> +	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
> +	 * controller V4.0.0 onwards.
> +	 */
> +	if (ufs_qcom_cap_qunipro(host) &&
> +	    !(ufshcd_is_intr_aggr_allowed(hba) ||
> +	    ufshcd_is_auto_hibern8_supported(hba) ||
> +	    host->hw_ver.major >= 4))
>   		return 0;
> 
>   	if (gear == 0) {
> @@ -576,8 +579,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>   	}
> 
>   	list_for_each_entry(clki, &hba->clk_list_head, list) {
> -		if (!strcmp(clki->name, "core_clk"))
> -			core_clk_rate = clk_get_rate(clki->clk);
> +		if (!strcmp(clki->name, "core_clk")) {
> +			if (is_pre_scale_up)
> +				core_clk_rate = clki->max_freq;
> +			else
> +				core_clk_rate = clk_get_rate(clki->clk);
> +			break;
> +		}
> +
>   	}
> 
>   	/* If frequency is smaller than 1MHz, set to 1MHz */
> @@ -657,7 +666,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>   		mb();
>   	}
> 
> -	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
> +	if (link_startup && host->hw_ver.major != 0x5) {
>   		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
>   			      REG_UFS_CFG0);
>   		/*
> @@ -670,6 +679,107 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>   	return 0;
>   }
> 
> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
> +				      u32 clk_1us_cycles,
> +				      u32 clk_40ns_cycles,
> +				      bool scale_up)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	u32 mask = MAX_CORE_CLK_1US_CYCLES_MASK;
> +	u32 offset = 0;
> +	u32 reg;
> +	int err;
> +
> +	/* Bit mask and offset changed on UFS host controller V4.0.0 onwards */
> +	if (host->hw_ver.major >= 4) {
> +		mask = MAX_CORE_CLK_1US_CYCLES_MASK_V4;
> +		offset = MAX_CORE_CLK_1US_CYCLES_OFFSET_V4;
> +	}
> +
> +	if (clk_1us_cycles > mask)
> +		return -EINVAL;
> +
> +	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
> +	if (err)
> +		return err;
> +
> +	reg &= ~(mask << offset);
> +	reg |= clk_1us_cycles << offset;
Do you need the offset? the mask could have included the offset, and 
avoid the left shift operation here.

> +
> +	if (scale_up)
> +		reg |= CORE_CLK_DIV_EN_BIT;
> +	else
> +		reg &= ~CORE_CLK_DIV_EN_BIT;
In the scale down case, the CORE_CLK_DIV_EN_BIT is already cleared by 
the ufs_qcom_clk_scale_down_pre_change(). Clearing this bit again here 
seems unnecessary.

> +
> +	err = ufshcd_dme_set(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), reg);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * UFS host controller V4.0.0 onwards needs to program
> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
> +	 * frequency of unipro core clk of UFS host controller.
> +	 */
> +	if (host->hw_ver.major >= 4) {
> +		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
> +			return -EINVAL;
> +
> +		err = ufshcd_dme_get(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     &reg);
> +		if (err)
> +			return err;
> +
> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
> +		reg |= clk_40ns_cycles;
> +
> +		err = ufshcd_dme_set(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     reg);
> +	}
> +
> +	return err;
> +}
> +
> +static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)
> +{
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	u32 max_freq = 0;
> +	int err;
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!IS_ERR_OR_NULL(clki->clk) &&
> +		    (!strcmp(clki->name, "core_clk_unipro"))) {
> +			max_freq = clki->max_freq;
> +			break;
> +		}
> +	}
> +
> +	switch (max_freq) {
> +	case MHZ_403:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16, true);
> +		break;
> +	case MHZ_300:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12, true);
> +		break;
> +	case MHZ_201_5:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8, true);
> +		break;
> +	case MHZ_150:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6, true);
> +		break;
> +	case MHZ_100:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, true);
> +		break;
> +	default:
> +		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	return err;
> +}
>   static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>   					enum ufs_notify_change_status status)
>   {
> @@ -679,19 +789,21 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>   	switch (status) {
>   	case PRE_CHANGE:
>   		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
> -					0, true)) {
> +					0, true, false)) {
>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>   				__func__);
>   			return -EINVAL;
>   		}
> 
> -		if (ufs_qcom_cap_qunipro(host))
> -			/*
> -			 * set unipro core clock cycles to 150 & clear clock
> -			 * divider
> -			 */
> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
> -									  150);
> +		if (ufs_qcom_cap_qunipro(host)) {
> +			err = ufs_qcom_cfg_core_clk_ctrl(hba);
> +			if (err) {
> +				dev_err(hba->dev,
> +					"%s cfg core clk ctrl failed\n",
> +					__func__);
> +				return err;
> +			}
> +		}
> 
>   		/*
>   		 * Some UFS devices (and may be host) have issues if LCC is
> @@ -926,7 +1038,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>   	case POST_CHANGE:
>   		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
>   					dev_req_params->pwr_rx,
> -					dev_req_params->hs_rate, false)) {
> +					dev_req_params->hs_rate, false, false)) {
>   			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>   				__func__);
>   			/*
> @@ -1296,69 +1408,52 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>   	phy_exit(host->generic_phy);
>   }
> 
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles)
> +static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>   {
> -	int err;
> -	u32 core_clk_ctrl_reg;
> -
> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
> -		return -EINVAL;
> -
> -	err = ufshcd_dme_get(hba,
> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    &core_clk_ctrl_reg);
> -	if (err)
> -		return err;
> -
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
> -	core_clk_ctrl_reg |= clk_cycles;
> -
> -	/* Clear CORE_CLK_DIV_EN */
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
> +	int err = 0;
> 
> -	return ufshcd_dme_set(hba,
> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    core_clk_ctrl_reg);
> -}
> +	if (!ufs_qcom_cap_qunipro(host))
> +		goto out;
> 
> -static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
> -{
> -	/* nothing to do as of now */
> -	return 0;
> +	if (attr) {
> +		err = ufs_qcom_cfg_timers(hba, attr->gear_rx,
> +					    attr->pwr_rx, attr->hs_rate,
> +					    false, true);
In the clock scaling up case, the ufs_qcom_cfg_timers() is called here 
which is fine.
Later in the ufs_qcom_clk_scale_notify(POST_CHANGE), the 
ufs_qcom_cfg_timers() is called again. Therefore it appears that for the 
clock scaling up path, the ufs_qcom_cfg_timers() is called twice.

> +		if (err)
> +			dev_err(hba->dev, "%s ufs cfg timer failed\n",
> +					  __func__);
> +	}
> +	err = ufs_qcom_cfg_core_clk_ctrl(hba);
> +out:
> +	return err;
>   }
> 
>   static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>   {
> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -
> -	if (!ufs_qcom_cap_qunipro(host))
> -		return 0;
> -
> -	/* set unipro core clock cycles to 150 and clear clock divider */
> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
> +	return 0;
>   }
> 
>   static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>   	int err;
> -	u32 core_clk_ctrl_reg;
> +	u32 reg;
> 
>   	if (!ufs_qcom_cap_qunipro(host))
>   		return 0;
> 
> -	err = ufshcd_dme_get(hba,
> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    &core_clk_ctrl_reg);
> +	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
> +	if (err)
> +		return err;
> 
>   	/* make sure CORE_CLK_DIV_EN is cleared */
> -	if (!err &&
> -	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
> -		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> +	if (reg & CORE_CLK_DIV_EN_BIT) {
> +		reg &= ~CORE_CLK_DIV_EN_BIT;
>   		err = ufshcd_dme_set(hba,
>   				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -				    core_clk_ctrl_reg);
> +				    reg);
>   	}
> 
>   	return err;
> @@ -1367,12 +1462,44 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>   static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	u32 curr_freq = 0;
> +	int err;
> 
>   	if (!ufs_qcom_cap_qunipro(host))
>   		return 0;
> 
> -	/* set unipro core clock cycles to 75 and clear clock divider */
> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
> +	if (attr)
> +		ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx, > +				    attr->hs_rate, false, false);
In the clock scaling down case, the ufs_qcom_cfg_timers() is called here 
which is fine.
Later, in the ufs_qcom_clk_scale_notify(POST_CHANGE), 
ufs_qcom_cfg_timers() is called again. Therefore it appears that for the 
clock scaling down path, the ufs_qcom_cfg_timers() is also called twice.

> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!IS_ERR_OR_NULL(clki->clk) &&
> +		    (!strcmp(clki->name, "core_clk_unipro"))) {
> +			curr_freq = clk_get_rate(clki->clk);
> +			break;
> +		}
> +	}
> +
> +	switch (curr_freq) {
> +	case MHZ_37_5:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2, false);
> +		break;
> +	case MHZ_75:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3, false);
> +		break;
> +	case MHZ_100:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, false);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		dev_err(hba->dev, "unipro curr_freq=%u entry missing\n", curr_freq);
> +		break;
> +	}
> +
> +	return err;
>   }
> 
>   static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
> @@ -1409,7 +1536,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>   				    dev_req_params->gear_rx,
>   				    dev_req_params->pwr_rx,
>   				    dev_req_params->hs_rate,
> -				    false);
> +				    false, false);
>   		ufs_qcom_icc_update_bw(host);
>   		ufshcd_uic_hibern8_exit(hba);
>   	}
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index d6f8e74bd538..d10234f6280b 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -79,6 +79,17 @@ enum {
>   	UFS_MEM_CQIS_VS		= 0x8,
>   };
> 
> +
> +/* QCOM UFS host controller core clk frequencies */
> +#define MHZ_37_5	37500000
> +#define MHZ_50		50000000
> +#define MHZ_75		75000000
> +#define MHZ_100		100000000
> +#define MHZ_150		150000000
> +#define MHZ_300		300000000
> +#define MHZ_201_5	201500000
> +#define MHZ_403		403000000
> +
>   #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
>   #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
> 
> @@ -129,9 +140,12 @@ enum {
>   #define PA_VS_CONFIG_REG1	0x9000
>   #define DME_VS_CORE_CLK_CTRL	0xD002
>   /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
> -#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
> -#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
> -
> +#define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF
> +#define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
> +#define MAX_CORE_CLK_1US_CYCLES_MASK		0xFF
> +#define CORE_CLK_DIV_EN_BIT			BIT(8)
> +#define PA_VS_CORE_CLK_40NS_CYCLES		0x9007
> +#define PA_VS_CORE_CLK_40NS_CYCLES_MASK		0x3F
>   static inline void
>   ufs_qcom_get_controller_revision(struct ufs_hba *hba,
>   				 u8 *major, u16 *minor, u16 *step)
> --
> 2.17.1
> 

