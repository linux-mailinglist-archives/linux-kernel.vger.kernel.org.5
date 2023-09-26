Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886617AEBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjIZLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjIZLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:44:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A2CE;
        Tue, 26 Sep 2023 04:44:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QBGTaA017555;
        Tue, 26 Sep 2023 11:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tPqjOI9jnSrhMNKRt6apnESC2DHPD8ZdaJb1+5YJT4M=;
 b=CdU/mDgx7Q5JqbQe1oBTklviiJ1JXT4v+oFtzVdZThNXqV8w+dJIxmGATFmplKdw4mdK
 O/DCN6BtYez0huiNnOZ5KLu7hW3LZHGdyIxr708EbDtQ7+BHiaXo1qx7LiWVV87wV6Hp
 KL+kU+6bH5CnM6MGncx3UBGSqHGikMQJ9EadPZU6dYyoxNMQYGavCwxlpl7/AvDUwcuV
 XKzc+2eghiqT5UDd2LDrcKgyS3zD8syTP2J0AOVijwlrPSbuddwSccKzE8bUbH/KPIMa
 O9NBfIZsIS3nE4vkIKQzNqbXgAZ1CUjj7Hd0xJQiTrlR8uB8F4oXxA8eZGuDV5N60Dcl Xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexght4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 11:44:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QBilce022879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 11:44:47 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 04:44:45 -0700
Message-ID: <32e00823-35d3-be56-eb5d-b1c7eee77551@quicinc.com>
Date:   Tue, 26 Sep 2023 17:14:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Free DMA handles for RPC calls with no
 arguments
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
References: <1693463029-9311-1-git-send-email-quic_ekangupt@quicinc.com>
 <90dffe7f-02c1-4965-8d48-1d689abc9323@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <90dffe7f-02c1-4965-8d48-1d689abc9323@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rXivPm9D4umEz_hCtk5F5h07EOA8sMQ0
X-Proofpoint-GUID: rXivPm9D4umEz_hCtk5F5h07EOA8sMQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260101
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 3:57 PM, Srinivas Kandagatla wrote:
> Thanks Ekansh for this patch.
> 
> few comments below
> 
> On 31/08/2023 07:23, Ekansh Gupta wrote:
>> The FDs for DMA handles to be freed is updated in fdlist by DSP over
> 
> So the dsp is updating the fd list after invoke?
> 
Yes, correct. DSP updates this fd list when the buffer is no longer 
needed by the user PD.
> 
>> a remote call. This holds true even for remote calls with no
>> arguments. To handle this, get_args and put_args are needed to
>> be called for remote calls with no arguments also as fdlist
>> is allocated in get_args and FDs updated in fdlist is freed
>> in put_args.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   drivers/misc/fastrpc.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 9666d28..e6df66e 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1153,11 +1153,9 @@ static int fastrpc_internal_invoke(struct 
>> fastrpc_user *fl,  u32 kernel,
>>       if (IS_ERR(ctx))
>>           return PTR_ERR(ctx);
>> -    if (ctx->nscalars) {
> 
> Why do we need to remove this check?
> fastrpc_internal_invoke will have nscalars set before calling. and we 
> are not dealing with fdlist in fastrpc_get_args(), so am not sure what 
> this change is helping with.
Memory for fdlist is allocated as part of fastrpc_get_args. The reason 
to add this change is that fdlist can be updated by DSP over a call with 
no remote arguments, for this call, there should be some fdlist 
allocated so the DSP can update the list if needed. Same apply for 
fastrpc_put_args also as when DSP updates fdlist for any remote call 
with no arguments, the maps corresponding to the fdlist should be freed.
> 
> 
>> -        err = fastrpc_get_args(kernel, ctx);
>> -        if (err)
>> -            goto bail;
>> -    }
>> +    err = fastrpc_get_args(kernel, ctx);
>> +    if (err)
>> +        goto bail;
>>       /* make sure that all CPU memory writes are seen by DSP */
>>       dma_wmb();
>> @@ -1181,14 +1179,12 @@ static int fastrpc_internal_invoke(struct 
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
> 
> A comment about fdlist here would be really useful
Sure, I will add a comment in the next patch. Do you suggest to add 
comment here or inside fastrpc_put_args function:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n1092
> 
>> +    err = fastrpc_put_args(ctx, kernel);
>> +    if (err)
>> +        goto bail;
>>   bail:
>>       if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
