Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286375FF81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGXTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGXTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:05:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7910F0;
        Mon, 24 Jul 2023 12:05:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFi8sf001188;
        Mon, 24 Jul 2023 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DmYSbcdm3r/GiE4y3hnDR14eF24CvdssxQ+/wIqDyv8=;
 b=ps9FB9qmoE2S4SbGer+I3/mWRu16dxqjjiAa32GSTkW4XZmXzvOQBaL5imwvfG42mTmc
 kKKW6rO2hm1J1jz4iqMAWtCg01NwQ/cDFH+xZo0u9DKCQWFzfK5iya3ouSbZniI7SBIO
 x27DqpQhw5toxslqMG4fU/SNwqdZxbQ7lynnj6VAD/PLQ2wdA9mQMx4pONaFZZoUPxP8
 zYgpdEO3tGX73c/qFO5KFmh3aU0f5E7BV1OCcg70OCZi2tXdEMs5f6X7njLMBj47rkDu
 ooHi7Sv3QaWVyvg95tMGss3xPtwlw52o2lvE57dT/HWZYvoq3cMejiCzPX2PWzSyAbMA Aw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1v6u8fqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OJ5kML007773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:46 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 12:05:46 -0700
Message-ID: <5c56cc3c-13d0-d9d8-0209-5b6e8d7a4dac@quicinc.com>
Date:   Mon, 24 Jul 2023 12:05:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 3/3] firmware: scm: Modify only the download bits in
 TCSR register
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
 <20230720070408.1093698-4-quic_kathirav@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230720070408.1093698-4-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y9kVWX7f_i2nZ9x36npxybAcXyWpAiQB
X-Proofpoint-GUID: y9kVWX7f_i2nZ9x36npxybAcXyWpAiQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 12:04 AM, Kathiravan T wrote:
> From: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> CrashDump collection is based on the DLOAD bit of TCSR register. To retain
> other bits, we read the register and modify only the DLOAD bit as the
> other bits have their own significance.
> 
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V5:
> 	- Added the Signed-off-by tag for user Poovendhan
> 	- Dropped the macro QCOM_DOWNLOAD_MODE_SHIFT in the favor of
> 	  PREP_FIELD
> 
>   drivers/firmware/qcom_scm.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 104d86e49b97..3830dcf14326 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -30,6 +30,10 @@ module_param(download_mode, bool, 0);
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
> +#define QCOM_DOWNLOAD_FULLDUMP		0x1
> +#define QCOM_DOWNLOAD_NODUMP		0x0
> +#define QCOM_DOWNLOAD_MODE_MASK		BIT(4)
> +

Can you update __qcom_scm_set_dload_mode to use the FIELD_PREP bits as 
well? Ideally, you should be able to have no duplicate logic in 
__qcom_scm_set_dload_mode and in qcom_scm_set_download_mode. Before your 
patch, it was duplicated and we probably should've had it de-duplicated. 
With this patch, the logic and constants used have diverged when they 
don't need to.

>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
> @@ -440,6 +444,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   static void qcom_scm_set_download_mode(bool enable)
>   {
>   	bool avail;
> +	int val;
>   	int ret = 0;
>   
>   	avail = __qcom_scm_is_call_available(__scm->dev,
> @@ -448,8 +453,10 @@ static void qcom_scm_set_download_mode(bool enable)
>   	if (avail) {
>   		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		val = enable ? QCOM_DOWNLOAD_FULLDUMP : QCOM_DOWNLOAD_NODUMP;
> +		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> +					       QCOM_DOWNLOAD_MODE_MASK,
> +					       FIELD_PREP(QCOM_DOWNLOAD_MODE_MASK, val));
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
