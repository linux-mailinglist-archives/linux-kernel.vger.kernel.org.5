Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8876CF31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjHBNts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHBNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:49:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB8FDC;
        Wed,  2 Aug 2023 06:49:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AAWu4005236;
        Wed, 2 Aug 2023 13:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g43xVjYg1vuP+BwMaOXl5nwdrLL57nsRQFXxYLnIuP4=;
 b=b/tvbUQ9R3DTMxZyUMiSQz8LVT/iFfVRrnoFdturA5+cByYvmyW23dTZeU9j+KTOQq/X
 +upclq4Gl/gn/ipDrRX9W4eLwMTHTC1bm8PFq+1mnx8VwGtTTvw07FYFTI+PBFH6A4HN
 hMqgs/eRlTeqsAGHygo525J5u7FQp1WxIrKhRUkOXSH3+f9vc/ebyA6zr3q0EgD11BDc
 hVUE6JWYSFwRE36H516MGjYI/a25x7Zy+7ThO6XSMqey2/AfR7LmGLH9WPTw4rPilyEr
 ATcm4sFVn5gZjIXq1yNtKjA4OEtQpcW+OZFmRv3tX9pahp/J5IOsgP50/zgafCXhZZnp oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre1erq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 13:49:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372DndaE019914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 13:49:39 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 06:49:36 -0700
Message-ID: <7f7aab67-69a3-b2ca-0bed-30cb6a5bca16@quicinc.com>
Date:   Wed, 2 Aug 2023 19:19:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] misc: fastrpc: Fix incorrect DMA mapping unmap request
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1690953032-17070-1-git-send-email-quic_ekangupt@quicinc.com>
 <4059684f-2e44-ccd6-4c65-5137cc76492c@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <4059684f-2e44-ccd6-4c65-5137cc76492c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IB4G8ESR6Vrl4m6q2s6a5d9H2mti2mSB
X-Proofpoint-ORIG-GUID: IB4G8ESR6Vrl4m6q2s6a5d9H2mti2mSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=972 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020122
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 7:13 PM, Srinivas Kandagatla wrote:
> 
> 
> On 02/08/2023 06:10, Ekansh Gupta wrote:
>> Scatterlist table is obtained during map create request and the same
>> table is used for DMA mapping unmap. In case there is any failure
>> while getting the sg_table, ERR_PTR is returned instead of sg_table.
>>
>> When the map is getting freed, there is only a non-NULL check of
>> sg_table which will also be true in case failure was returned instead
>> of sg_table. This would result in improper unmap request. Add proper
>> check before setting map table to avoid bad unmap request.
>>
>> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke 
>> method")
>> Cc: stable <stable@kernel.org>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>> Changes in v2:
>>    - Added fixes information to commit text
>> Changes in v3:
>>    - Set map->table only if attachment for successful
>>
>>   drivers/misc/fastrpc.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 9666d28..de7c812 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -756,6 +756,7 @@ static int fastrpc_map_create(struct fastrpc_user 
>> *fl, int fd,
>>   {
>>       struct fastrpc_session_ctx *sess = fl->sctx;
>>       struct fastrpc_map *map = NULL;
>> +    struct sg_table *table;
>>       int err = 0;
>>       if (!fastrpc_map_lookup(fl, fd, ppmap, true))
>> @@ -783,11 +784,12 @@ static int fastrpc_map_create(struct 
>> fastrpc_user *fl, int fd,
>>           goto attach_err;
>>       }
>> -    map->table = dma_buf_map_attachment_unlocked(map->attach, 
>> DMA_BIDIRECTIONAL);
>> -    if (IS_ERR(map->table)) {
>> -        err = PTR_ERR(map->table);
>> +    table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);
> 
> Any reason why dma_buf_map_attachment_unlocked changed to 
> dma_buf_map_attachment?
This is a mistake from my end. My local workspace had older version due 
to which the function also got reverted. I will fix this in new patch. 
Apologies for the confusion.
> 
> --srini
>> +    if (IS_ERR(table)) {
>> +        err = PTR_ERR(table);
>>           goto map_err;
>>       }
>> +    map->table = table;
>>       if (attr & FASTRPC_ATTR_SECUREMAP) {
>>           map->phys = sg_phys(map->table->sgl);
