Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A287E1A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKFGzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjKFGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:55:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8308F9;
        Sun,  5 Nov 2023 22:55:11 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A65jsWZ016340;
        Mon, 6 Nov 2023 06:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HJ6GRnQ/8Ob7oEFSpbuEehbm50jZlgbcaROVolgfBDg=;
 b=Gl571hWahS3qa3QG+V78TMTGRYia/qM8+iZW1RZnVi+4yrfcEnBzrgHP7vqprnuYed1Q
 Y97W0QRsDaG4iIg3M1TOEfWCebbGgQDE7bg187P5a5pasANqW8/fNUvwvznc+AO9jJAn
 dKXcBoY/Y+fWOshm/zYa+ED1+S96abm/ZkoIo3xN7CgmcL46vOmU2tm/k0gmoaifvTMm
 4V4qu3d9x7ESjkczZ+lg/gEBsdd3EmlDBOfYSBwlEVdhTkwaWumlYEKgtneHr3/IoDLf
 6N8x5sUWXrfLt7LKcBdCjpvHlYL8Q0neTK7F2dbkkEc8Z9NKjuzwYKlRAdggByaQiHJs 3g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eqn38sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:54:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66sYpi024802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:54:35 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 22:54:31 -0800
Message-ID: <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
Date:   Mon, 6 Nov 2023 12:24:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Atul Dhudase <quic_adhudase@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <swboyd@chromium.org>,
        <isaacm@codeaurora.org>, <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8jRe6dw1F8iLfi4zfsQc1OmpK_zXY-EA
X-Proofpoint-ORIG-GUID: 8jRe6dw1F8iLfi4zfsQc1OmpK_zXY-EA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060059
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
> On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
>> While programming dis_cap_alloc and retain_on_pc, set a bit
>> corresponding to a specific SCID without disturbing the
>> previously configured bits.
>>
> 
> As far as I can see, the only invocation of _qcom_llcc_cfg_program()
> comes from qcom_llcc_cfg_program(), which is only called once, from
> qcom_llcc_probe(), and here also seems to only be the single write to
> these two registers.

It does not look to be single write but the write is for each slice
in the same register which was overriding other slices values.

-Mukesh
> 
> This implies that "the previously configured bits" would be some unknown
> configuration provided to us either from the bootloader or by reset of
> the hardware. As such this changes the value of the two registers from
> being known, to having 31 unknown bits.
> 
> 
> I'm not saying that the change is wrong, but you're altering the
> behavior of every platform except SDM845.
> As such, I want the commit message to provide an actual problem
> description, and mention the fact that you're changing the logic to
> retain the state prior to Linux.
> 
> Regards,
> Bjorn
> 
>> Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
>> Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 674abd0d6700..509d972c1bd9 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
>>   		u32 disable_cap_alloc, retain_pc;
>>
>>   		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
>> -		ret = regmap_write(drv_data->bcast_regmap,
>> -				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
>> +		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
>> +				BIT(config->slice_id), disable_cap_alloc);
>>   		if (ret)
>>   			return ret;
>>
>>   		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
>>   			retain_pc = config->retain_on_pc << config->slice_id;
>> -			ret = regmap_write(drv_data->bcast_regmap,
>> -					LLCC_TRP_PCB_ACT, retain_pc);
>> +			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
>> +					BIT(config->slice_id), retain_pc);
>>   			if (ret)
>>   				return ret;
>>   		}
>> --
>> 2.25.1
>>
