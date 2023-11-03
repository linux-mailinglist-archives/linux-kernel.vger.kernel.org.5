Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72317E021D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjKCLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:18:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CB1A8;
        Fri,  3 Nov 2023 04:18:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A39tve4008925;
        Fri, 3 Nov 2023 11:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gUn+QmFcufcRA3kXSasIqyQsdDgA+H0KX3jGhhzdXc8=;
 b=a8C/eFpHqd64x4uS0HhydQjBWyiUrPTDhkRHa5KfHZElho6JlSCvfC4FjX1OZSjYzOOk
 ufw/VFfVLwjMAW+pZFr/GsFb5yjOpmfCJEpUEpkJGA0wMul9GAv3wZU/B96OzSWey6YS
 r2XCUv/LzefuCvPpp6J4LNu1sxYS749v6A5/CalNK8qWvw3CJuHHNt0vLsOldBUwMmZC
 hSANqKSFX1/t494qsT8NiNuwNZumhYbHKojP7M7Q/kzI1+kzoSe8HBkjyDONRNIlDNyj
 LUZCokX+25/hVEowXPcNUaHs+lYIW/Gk9I5mAsmRIWeJvo59t5IbZfAZwaB2tRXAOI3T /Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4sddgsc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 11:17:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3BHvNR014058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 11:17:57 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 04:17:54 -0700
Message-ID: <c5eb223b-b7b1-c85f-a0d5-ab3cc3e86efa@quicinc.com>
Date:   Fri, 3 Nov 2023 16:47:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Content-Language: en-US
To:     Atul Dhudase <quic_adhudase@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <swboyd@chromium.org>, <isaacm@codeaurora.org>,
        <dianders@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RLfGNlVWJkg_jtahr_DjE4X6ib-M53pa
X-Proofpoint-GUID: RLfGNlVWJkg_jtahr_DjE4X6ib-M53pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030094
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 4:27 PM, Atul Dhudase wrote:
> While programming dis_cap_alloc and retain_on_pc, set a bit
> corresponding to a specific SCID without disturbing the
> previously configured bits.
> 
> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 674abd0d6700..509d972c1bd9 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
>   		u32 disable_cap_alloc, retain_pc;
> 
>   		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
> -		ret = regmap_write(drv_data->bcast_regmap,
> -				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
> +		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
> +				BIT(config->slice_id), disable_cap_alloc);
>   		if (ret)
>   			return ret;
> 
>   		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
>   			retain_pc = config->retain_on_pc << config->slice_id;
> -			ret = regmap_write(drv_data->bcast_regmap,
> -					LLCC_TRP_PCB_ACT, retain_pc);
> +			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
> +					BIT(config->slice_id), retain_pc);

Good catch, LGTM

  Thanks
-Mukesh

>   			if (ret)
>   				return ret;
>   		}
> --
> 2.25.1
> 
