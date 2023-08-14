Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBCD77C0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjHNTZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHNTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:25:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8A9C;
        Mon, 14 Aug 2023 12:25:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEdKUX003012;
        Mon, 14 Aug 2023 19:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IMWIuzdfUdiDalclkOcq9aeS/qWv4yQF9nLI9N1tBa0=;
 b=Z2lktQ2HseAGwLfDIOt6wT79aytJIfMl3jOzjuYEejB+8bu/v4px9wfmjAtm5/DBCQqs
 LujEAYMcCCYlt/ydESAkZ40XEG0wlytmYB9Rczuoz8hQZuW7vHYsYCMd1RcuSgjwTJZ3
 J2CnX+JwweVNe0xe2o/k9Llnl3rZVuz1aFH5j0Ztc3vPe7xnJuORUZ8fCdRR3F4cP6zG
 eqQ2dfETVJPCiTuQJ842JAg8T89cFD1qYbeE66mF/zOMxBWxFFjI6PoTthYlKIibBk3x
 99oSJ+BRnGjQY7/Emx3UByIiidPXqdI5bnnFZ5nL2i2ygR8/0guxEYtyTUiAtV6fAiW9 bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94ptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:25:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJPURZ024975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:25:30 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:25:26 -0700
Message-ID: <620dae91-3b15-5300-1aae-8e458508f620@quicinc.com>
Date:   Tue, 15 Aug 2023 00:55:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 32/33] iris: variant: iris3: implement logic to compute
 clock frequency
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-33-git-send-email-quic_vgarodia@quicinc.com>
 <df9b1ee4-1462-f37a-1f08-0321a10fc4f9@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <df9b1ee4-1462-f37a-1f08-0321a10fc4f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lwE_YpSorPGvhJuHyKscsyRsmvVOnLCe
X-Proofpoint-GUID: lwE_YpSorPGvhJuHyKscsyRsmvVOnLCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:43 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements the logic to computer the required clock frequency
>> by encoder or decoder for a specific usecase. It considers the input
>> as various parameters configured by client for that usecase.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  .../iris/variant/iris3/src/msm_vidc_clock_iris3.c  | 627 +++++++++++++++++++++
>>  1 file changed, 627 insertions(+)
>>  create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
>>
>> diff --git a/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
>> new file mode 100644
>> index 0000000..6665aef
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
>> @@ -0,0 +1,627 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "msm_vidc_debug.h"
>> +
>> +#define ENABLE_FINEBITRATE_SUBUHD60 0
>> +#include "perf_static_model.h"
>> +
>> +/*
>> + * Chipset Generation Technology: SW/FW overhead profiling
>> + * need update with new numbers
>> + */
>> +static u32 frequency_table_iris3[2][6] = {
> I think it's the third repetition of the same (ftbl + OPP)
> 
Sure, will check and do the needful.

>> +	/* //make lowsvs_D1 as invalid; */
>> +	{533, 444, 366, 338, 240, 0},
>> +	{800, 666, 549, 507, 360, 0},
>> +};
>> +
>> + /* Tensilica cycles */
>> +#define DECODER_VPP_FW_OVERHEAD_IRIS3                                                  66234
>> +
>> +/* Tensilica cycles; this is measured in Lahaina 1stage with FW profiling */
> Is it gonna differ for other SoCs? Especially that 8350 has IRIS2?
> 
>> +#define DECODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3                                         93000
>> +
>> +#define DECODER_VSP_FW_OVERHEAD_IRIS3 \
>> +	(DECODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3 - DECODER_VPP_FW_OVERHEAD_IRIS3)
>> +
>> +/* Tensilica cycles; encoder has ARP register */
>> +#define ENCODER_VPP_FW_OVERHEAD_IRIS3                                                  48405
>> +
>> +#define ENCODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3 \
>> +	(ENCODER_VPP_FW_OVERHEAD_IRIS3 + DECODER_VSP_FW_OVERHEAD_IRIS3)
>> +
>> +#define DECODER_SW_OVERHEAD_IRIS3                                                      489583
>> +#define ENCODER_SW_OVERHEAD_IRIS3                                                      489583
>> +
>> +/* Video IP Core Technology: pipefloor and pipe penlaty */
>> +static u32 decoder_vpp_target_clk_per_mb_iris3 = 200;
> Why is this a variable?

Agree, this doesn't need to be a variable, will convert to macro.
> 
> [...]
> 
>> +
>> +/* 8KUHD60; UHD240; 1080p960  with B */
>> +static u32 fp_pixel_count_bar0 = 3840 * 2160 * 240;
>> +/* 8KUHD60; UHD240; 1080p960  without B */
>> +static u32 fp_pixel_count_bar1 = 3840 * 2160 * 240;
> Not sure what the 'B' is, but the entries are the same. And looks like
> there's:
> 
> - no need for it to be a variable
> - maybe you could make this a macro or just a simple multiplication
> 
B here is B frames and I agree these can be converted to macros.
> [...]
> 
>> +u32 get_bitrate_entry(u32 pixle_count)
> pixle -> pixel, checkpatch should point out typos
> 
> [...]
Ah! Thanks for pointing it out, checkpatch didn't complain about it, will
fix it.
> 
>> +static int calculate_vsp_min_freq(struct api_calculation_input codec_input,
>> +				  struct api_calculation_freq_output *codec_output)
>> +{
>> +	/*
>> +	 * VSP calculation
>> +	 * different methodology from Lahaina
>> +	 */
> Not sure if that comment is useful to the reader.
> 
> [...]
> 
right, will remove
> 
>> +
>> +static u32 calculate_pipe_penalty(struct api_calculation_input codec_input)
>> +{
>> +	u32 pipe_penalty_codec = 0;
>> +
>> +	/* decoder */
>> +	if (codec_input.decoder_or_encoder == CODEC_DECODER)
>> +		pipe_penalty_codec = pipe_penalty_iris3[0][0];
>> +	else
>> +		pipe_penalty_codec = 101;
> Add a define for this magic number?
> 
> Also, return the value instead of assigning it and doing the same
will fix in next version

Thanks,
Dikshita
> 
> 
> Konrad
