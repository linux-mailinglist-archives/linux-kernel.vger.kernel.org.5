Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8277665E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjG1H53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjG1H5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB823582;
        Fri, 28 Jul 2023 00:57:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S7c2g0020753;
        Fri, 28 Jul 2023 07:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h8agajaLfWeXSOxgQ4Tqn5wqoCAvvaRjiSyfa4aGhpU=;
 b=pVIwXsDa7ajs3/hOdLSqOsyyBXKCem93pdxTki0S6PNOOGpGZBJYp0598QuF5AB1sxNx
 rUTA+7WPIWEDE9uKdTRSqzn8tDNWFDjDfWM1SV87KCLKWw6jtD0RGJBBsxOcDLFWOJk6
 L07BDh75ELZwe+2ECA4gCbdSlZVOBQBm57hElFsS05zFxNczutvfUBSzxAcUX3Op1+v2
 ca1/mQed0EgL/Jree3HuZFbemCYBck5uoJhtlRpIaf1mHH4bASG1hmteeVJICDWhkLRl
 LopOdqq7/QAqJr4/KBZAkpGr8kJWM07KX/XlRfcAYglbPLT+Ttg2KPT3U+oqLs3O8H7q bQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3n2kapsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:57:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S7vCqY029525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:57:12 GMT
Received: from [10.50.27.108] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 00:57:02 -0700
Message-ID: <6692f826-c2ca-3f8e-c6e5-d02a99150095@quicinc.com>
Date:   Fri, 28 Jul 2023 13:26:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] venus: hfi: add checks to perform sanity on queue
 pointers
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690432469-14803-2-git-send-email-quic_vgarodia@quicinc.com>
 <df947545-23ef-2ee9-72cc-8e54bbe46be1@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <df947545-23ef-2ee9-72cc-8e54bbe46be1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -6dzAtQqeXQpsT02Ey88kGVZfMtQ9ke-
X-Proofpoint-ORIG-GUID: -6dzAtQqeXQpsT02Ey88kGVZfMtQ9ke-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=825 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2023 10:38 PM, Konrad Dybcio wrote:
> On 27.07.2023 06:34, Vikash Garodia wrote:
>> Read and write pointers are used to track the packet index in the memory
>> shared between video driver and firmware. There is a possibility of OOB
>> access if the read or write pointer goes beyond the queue memory size.
>> Add checks for the read and write pointer to avoid OOB access.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  drivers/media/platform/qcom/venus/hfi_venus.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index f0b4638..dc228c4 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -206,6 +206,10 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
>>  
>>  	new_wr_idx = wr_idx + dwords;
>>  	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
>> +
>> +	if (wr_ptr < (u32 *)queue->qmem.kva || wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size))
> Shouldn't the cases on the right side of the OR operator include a
> "- 1"?

I see your point here. Possibly subtracting with sizeof(*wr_ptr) instead of "1"
would be appropriate. Similarly for read queue handling.

- Vikash

> Konrad
