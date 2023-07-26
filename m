Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CC762E68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjGZHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGZHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:46:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDC1736;
        Wed, 26 Jul 2023 00:41:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q56BMS016001;
        Wed, 26 Jul 2023 07:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9x0Mv34uuYpy3yutiI2WloPK6GAvYfFwUF8clv17zgw=;
 b=OLfkOPjmPLqlLKkqYu1FiPLwFPwbmkJM/lLJajNF9MXt168rX2/B6Ekir7+fwwsSAsVQ
 ONkh82Iqsn3dhto8WwsXYI1CBz8Jbd3D/Qm5GTgqTxTIn3bjBTTy2Fh+WYhIOw2V7tLt
 GG7cbxWjQDq2ZJ7z7k2kWUtOJ/U5h3njVs2xhHHNcyMyBxEL7wu3L9hoqXU5Avf1B5Xb
 6nPdbz/wA4Vp2wIGkenuBrrrjh7VXLL///xGSQmnWGeqQmY/s4BDOhxEPP7gUxKm+Ya0
 C2xAGn6CE6jnGaOKRcmYt2rAJ29WuufaaTOL9nYGBHxkuz5pIro9Bg+RL9l2azVVKg06 lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1spy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:41:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q7f0NT030560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:41:00 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 00:40:57 -0700
Message-ID: <0e2b2819-dc54-4038-0046-712a3391c595@quicinc.com>
Date:   Wed, 26 Jul 2023 13:10:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] misc: fastrpc: Fix incorrect DMA mapping unmap request
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1690182571-7348-1-git-send-email-quic_ekangupt@quicinc.com>
 <zo6wjmqolvnla7x24qguh6rbjpf7l62vmckxhy3nps7hhaljdr@kyoh6xedhxaq>
Content-Language: en-US
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <zo6wjmqolvnla7x24qguh6rbjpf7l62vmckxhy3nps7hhaljdr@kyoh6xedhxaq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EQiso6J4LaYTVyfUAUzgoHiJLdUBL4fc
X-Proofpoint-ORIG-GUID: EQiso6J4LaYTVyfUAUzgoHiJLdUBL4fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260067
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 12:00 PM, Bjorn Andersson wrote:
> On Mon, Jul 24, 2023 at 12:39:31PM +0530, Ekansh Gupta wrote:
>> Scatterlist table is obtained during map create request and the same
> 
> I'm guessing that this all happens in fastrpc_map_create() where:
> 
>    map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
> 
> fails, we jump to map_err, and then call fastrpc_map_put(map), which
> then ends up in the code below?
> 
yes, your understanding is correct.
>> table is used for DMA mapping unmap. In case there is any failure
>> while getting the sg_table, ERR_PTR is returned instead of sg_table.
> 
> The problem isn't that ERR_PTR() is being returned, the problem is that
> this is being assigned to map->table and you keep running.
> 
>>
>> When the map is getting freed, there is only a non-NULL check of
>> sg_table which will also be true in case failure was returned instead
>> of sg_table. This would result in improper unmap request. Add proper
>> check to avoid bad unmap request.
>>
>> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
>> Cc: stable <stable@kernel.org>
>> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> 
> You always test your own patches, so no need to declare this.
> 
sure, I'll avoid adding this for future changes.
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>> Changes in v2:
>>    - Added fixes information to commit text
>>
>>   drivers/misc/fastrpc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 9666d28..75da69a 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -313,7 +313,7 @@ static void fastrpc_free_map(struct kref *ref)
>>   
>>   	map = container_of(ref, struct fastrpc_map, refcount);
>>   
>> -	if (map->table) {
>> +	if (map->table && !IS_ERR(map->table)) {
> 
> Rather than carrying around an IS_ERR(map->table), I think you should
> address this at the originating place. E.g. assign the return value of
> the dma_buf_map_attachment_unlocked() to a local variable and only if it
> is valid you assign map->table. Or perhaps make it NULL in the error
> path.
> 
understood, this looks much cleaner solution. I'll update this in the 
next patch. Thanks for taking your time to review this change, Bjorn.
--ekansh

> Regards,
> Bjorn
> 
>>   		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
>>   			struct qcom_scm_vmperm perm;
>>   			int vmid = map->fl->cctx->vmperms[0].vmid;
>> -- 
>> 2.7.4
>>
