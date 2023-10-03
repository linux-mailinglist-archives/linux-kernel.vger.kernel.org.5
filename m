Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E457B6737
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJCLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjJCLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:07:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C7A1;
        Tue,  3 Oct 2023 04:07:44 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3939SCNL016483;
        Tue, 3 Oct 2023 11:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D4oUZ8kfQKPTdcqTl4WRNkRlvKVgbbEpc84zKOpgbNI=;
 b=jLNKXJRxSkUXQNnmmyGbBCFs3BCCoEoS5P9y2N0mLOZqE/y6aAVXtBEAkS/Stvr1kWpl
 emXm+hWCNroYgdhcIyzPZzGYiLtD2k3jkgbmejHgatVmx2g9ilQLXEIeLaTuGHS+MWQu
 G8SRMF+LfwcwtLml9d+s75DuqyqQq/BGy44WxYlja5xQDAVXxO+tXM8r3X7BEwx+hywz
 m5GEMt+9xgfIgXqBMFbM2+pRurkX7Orrlb557Q5kUjzV8xzevnm4jFK7oAkUJ74SS0pp
 QLhN/8St/2N582uaIiM7MXKBbXZs/dvKd3ljtHi1tNaG2MlWkc6O4NKnaUn+MWy90udw 2w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg77es4dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 11:07:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393B7aCO012337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 11:07:36 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 04:07:34 -0700
Message-ID: <856929f7-7e6e-8dd5-a12f-9f4de524ce61@quicinc.com>
Date:   Tue, 3 Oct 2023 16:37:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Free DMA handles for RPC calls with
 no arguments
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
 <1695973360-14369-3-git-send-email-quic_ekangupt@quicinc.com>
 <92db4a0d-c416-6a1c-ad71-15c2156d59aa@linaro.org>
Content-Language: en-US
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <92db4a0d-c416-6a1c-ad71-15c2156d59aa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JqGyO4giKgrIVUUtVZwsksOA_ciFTEtr
X-Proofpoint-GUID: JqGyO4giKgrIVUUtVZwsksOA_ciFTEtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030079
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2023 3:00 PM, Srinivas Kandagatla wrote:
> 
> 
> On 29/09/2023 08:42, Ekansh Gupta wrote:
>> The FDs for DMA handles to be freed is updated in fdlist by DSP over
>> a remote call. This holds true even for remote calls with no
>> arguments. To handle this, get_args and put_args are needed to
>> be called for remote calls with no arguments also as fdlist
>> is allocated in get_args and FDs updated in fdlist is freed
>> in put_args.
>>
>> Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
>> Cc: stable <stable@kernel.org>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   drivers/misc/fastrpc.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index fb92197..a52701c 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1091,6 +1091,7 @@ static int fastrpc_put_args(struct 
>> fastrpc_invoke_ctx *ctx,
>>           }
>>       }
>> +    /* Clean up fdlist which is updated by DSP */
>>       for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>>           if (!fdlist[i])
>>               break;
>> @@ -1157,11 +1158,9 @@ static int fastrpc_internal_invoke(struct 
>> fastrpc_user *fl,  u32 kernel,
>>       if (IS_ERR(ctx))
>>           return PTR_ERR(ctx);
> <---
>> -    if (ctx->nscalars) {
>> -        err = fastrpc_get_args(kernel, ctx);
>> -        if (err)
>> -            goto bail;
>> -    }
>> +    err = fastrpc_get_args(kernel, ctx);
>> +    if (err)
>> +        goto bail;
> -->
> I dont see any point of the above change as fastrpc_internal_invoke will 
> be called from kernel with nscalars always set.
> 
> do you see a path that does not set this?
> 
The context specific rpra buffer is allocated as part of 
fastrpc_get_args and there is a possibility that the DSP intends to 
update fdlist for a call with 0 nscalars. In that scenario, the driver 
needs to ensure that the rpra is allocated which will carry the fdlist. 
The same can be extended to crc and dsp perf memory(to be added, patches 
shared for missing features) for remote calls with 0 nscalars.

Thanks for taking your time to review the patches Srini, please let me 
know if you have more queries.

-ekansh
> --srini
>>       /* make sure that all CPU memory writes are seen by DSP */
>>       dma_wmb();
>> @@ -1185,14 +1184,12 @@ static int fastrpc_internal_invoke(struct 
>> fastrpc_user *fl,  u32 kernel,
>>       if (err)
>>           goto bail;
>> -    if (ctx->nscalars) {
>> -        /* make sure that all memory writes by DSP are seen by CPU */
>> -        dma_rmb();
>> -        /* populate all the output buffers with results */
>> -        err = fastrpc_put_args(ctx, kernel);
>> -        if (err)
>> -            goto bail;
>> -    }
>> +    /* make sure that all memory writes by DSP are seen by CPU */
>> +    dma_rmb();
>> +    /* populate all the output buffers with results */
>> +    err = fastrpc_put_args(ctx, kernel);
>> +    if (err)
>> +        goto bail;
>>   bail:
>>       if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
