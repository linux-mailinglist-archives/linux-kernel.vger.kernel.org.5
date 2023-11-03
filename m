Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E67E0593
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjKCPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjKCPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:31:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8471B2;
        Fri,  3 Nov 2023 08:31:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Dilt9022158;
        Fri, 3 Nov 2023 15:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=svLJkHBDhpcHCmfWFd867T+PC8YtdaaPIDojzVtcjkA=;
 b=KBIofXZM52m/qKx6UA0JChYqs+p/xH1wMsGQKleFZ6HGpP2ULOXJGockNBAZTgtDM5SC
 ck4lP8xOFHj3BfGDehT20ttK0dRI4OZTKW59zNa4DPKO1L8fzYT160CNizEHcpRWR1N9
 dQ7BD7xj0ZaMQItq5PbVpZGGf2qptk7BgLCgLzsm1vMgMuYjsSqhsIlTtuSU+J81FFwp
 ntaw+0af/DnMS8k7ghf1s9eYR8Ni5jbVLXqZngSosIxl7YEyqhScZSDyTkOpFXP7YQgF
 VkGykmwvKqLuL12opXVH4ZKBGoSvviyzObVLsqv2Au7Ihbx5pTSN7RSM6w6W9cJeEPcm 1g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4ss99847-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 15:30:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3FUaEv003131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 15:30:36 GMT
Received: from [10.216.59.4] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 08:30:33 -0700
Message-ID: <9a1baddd-830d-364b-5106-c33bb64d516f@quicinc.com>
Date:   Fri, 3 Nov 2023 21:00:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Atul Dhudase <quic_adhudase@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <swboyd@chromium.org>, <isaacm@codeaurora.org>,
        <dianders@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <c5eb223b-b7b1-c85f-a0d5-ab3cc3e86efa@quicinc.com>
In-Reply-To: <c5eb223b-b7b1-c85f-a0d5-ab3cc3e86efa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HTniq2loJZMfMlqSag-DKrtjDcOPUUl-
X-Proofpoint-GUID: HTniq2loJZMfMlqSag-DKrtjDcOPUUl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030131
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 4:47 PM, Mukesh Ojha wrote:
> 
> 
> On 11/3/2023 4:27 PM, Atul Dhudase wrote:
>> While programming dis_cap_alloc and retain_on_pc, set a bit
>> corresponding to a specific SCID without disturbing the
>> previously configured bits.
>>
>> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write 
>> to llcc")
>> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 674abd0d6700..509d972c1bd9 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct 
>> llcc_slice_config *config,
>>           u32 disable_cap_alloc, retain_pc;
>>
>>           disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
>> -        ret = regmap_write(drv_data->bcast_regmap,
>> -                LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
>> +        ret = regmap_update_bits(drv_data->bcast_regmap, 
>> LLCC_TRP_SCID_DIS_CAP_ALLOC,
>> +                BIT(config->slice_id), disable_cap_alloc);
>>           if (ret)
>>               return ret;
>>
>>           if (drv_data->version < LLCC_VERSION_4_1_0_0) {
>>               retain_pc = config->retain_on_pc << config->slice_id;
>> -            ret = regmap_write(drv_data->bcast_regmap,
>> -                    LLCC_TRP_PCB_ACT, retain_pc);
>> +            ret = regmap_update_bits(drv_data->bcast_regmap, 
>> LLCC_TRP_PCB_ACT,
>> +                    BIT(config->slice_id), retain_pc);
> 
> Good catch, LGTM

Forgot to tell.,
Please tag this to stable as well.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> 
>   Thanks
> -Mukesh
> 
>>               if (ret)
>>                   return ret;
>>           }
>> -- 
>> 2.25.1
>>
