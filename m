Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1475FF84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGXTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGXTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:06:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C008170F;
        Mon, 24 Jul 2023 12:05:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OHQrXr005598;
        Mon, 24 Jul 2023 19:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uT4ufz+wHsOJ65L3P5ysUER/zTxRqHomRl0RlZwXaWU=;
 b=OokxkpHpg4OhJ+OCpfuapHoM6I2dQqig7aOFRNq0AY571F2O7MXJtXTTLPemCMZc/+tq
 r3VUhZLif0/JRlGj6ouWBctGwyD1FQ/F/iSfjLJ/qsrfxidcpsHSJoe1wJJQN5DTqfEX
 XGLpY5PEASC7Zveb9mPYsefOe4oUj801Q5y0JzjlvDX9zFuqqK1NhY7LZjVvtsrpnC1i
 DTF96Msjrzw1UeGQY1TdEYeq0959rsMDHvN9Dz6YuzUGEiYKGJ6ZuC2jdx+wsYs3EfXb
 +XS+F14FMWpxoy86RRuIil00sWapNExHa9aofVFcmDex0n46sS/4pmPZq59KKjdjmLww Ww== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1v6u8fqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OJ5ssq007013
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:54 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 12:05:54 -0700
Message-ID: <c3e4912d-3635-864a-9944-6cc280641cf5@quicinc.com>
Date:   Mon, 24 Jul 2023 12:05:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 1/3] firmware: qcom_scm: provide a read-modify-write
 function
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
 <20230720070408.1093698-2-quic_kathirav@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230720070408.1093698-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SyZz-8N0IQ_YZPDQ-3VEN98z-z9nFdTu
X-Proofpoint-GUID: SyZz-8N0IQ_YZPDQ-3VEN98z-z9nFdTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=800 lowpriorityscore=0 impostorscore=0
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
> It was realized by Srinivas K. that there is a need of read-modify-write
> scm exported function so that it can be used by multiple clients.
> 
> Let's introduce qcom_scm_io_update_field() which masks out the bits and
> write the passed value to that bit-offset.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>


After updating EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL:

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
> Changes in V5:
> 	- No changes
> 
>   drivers/firmware/qcom_scm.c            | 15 +++++++++++++++
>   include/linux/firmware/qcom/qcom_scm.h |  2 ++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..104d86e49b97 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,6 +407,21 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> +int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	ret = qcom_scm_io_readl(addr, &old);
> +	if (ret)
> +		return ret;
> +
> +	new = (old & ~mask) | (val & mask);
> +
> +	return qcom_scm_io_writel(addr, new);
> +}
> +EXPORT_SYMBOL(qcom_scm_io_update_field);
> +
>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 250ea4efb7cb..ca41e4eb33ad 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -84,6 +84,8 @@ extern bool qcom_scm_pas_supported(u32 peripheral);
>   
>   extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>   extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +extern int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
> +				    unsigned int val);
>   
>   extern bool qcom_scm_restore_sec_cfg_available(void);
>   extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
