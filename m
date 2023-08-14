Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723B77C0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjHNTT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjHNTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:19:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAF9C;
        Mon, 14 Aug 2023 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIkgor004310;
        Mon, 14 Aug 2023 19:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IRERsFoR3zwfuJd6RJoaJKcGALrgNwo444eFSm6CBkU=;
 b=SBQyfqsMQV22088W/pZ9VtxKJXJLVd0o9ZTwq2VgF58Q/3mcjJmHqFsriW/dHg6wRd9Y
 36nMzCWDxMoRN20HPuIQO5W1r6+H+3ZvXhEXM0zNuHoHOTeWOq6lRQXFDKwuT5lzUoe7
 /ZNYaGUoJS86UhYo6fIZ6VG+VNDgphh2UrLUngy6QHev0U4yLJcTxJjwOJ0xyWMx9AVi
 HxljkQ5MOn/tgLjJyUS9KYCakfZ1bUS8thqa791aX1KI0T4/dcxZLsmv5WGTnGxrF9Eo
 +UJ3+VfNhxe3B/j/Cai2+11VWYqtwnSPeP6P/7gLzRWY40osMAk01HAfNHt7TI5eE0CE pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfn4c8sqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:19:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJJcRg017162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:19:38 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:19:35 -0700
Message-ID: <3096d194-e137-df16-2628-5b1871df51e8@quicinc.com>
Date:   Tue, 15 Aug 2023 00:49:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 20/33] iris: vidc: hfi: add helpers for handling shared
 queues
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-21-git-send-email-quic_vgarodia@quicinc.com>
 <9eec378f-9e77-6c08-eb82-2387c77734f1@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <9eec378f-9e77-6c08-eb82-2387c77734f1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rMHwid2vQ-e55oQBNrnnPZziGA0Uz-5o
X-Proofpoint-GUID: rMHwid2vQ-e55oQBNrnnPZziGA0Uz-5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=794 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:28 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> This implements functions to allocate and update the shared memory
>> used for sending commands to firmware and receiving messages from
>> firmware.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |  89 ++++
>>  .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  | 537 +++++++++++++++++++++
>>  2 files changed, 626 insertions(+)
>>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
>>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
>>
>> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
>> new file mode 100644
>> index 0000000..f533811
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
>> @@ -0,0 +1,89 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _VENUS_HFI_QUEUE_H_
>> +#define _VENUS_HFI_QUEUE_H_
>> +
>> +#include <linux/types.h>
>> +
>> +#include "msm_vidc_internal.h"
>> +
>> +#define HFI_MASK_QHDR_TX_TYPE			0xff000000
>> +#define HFI_MASK_QHDR_RX_TYPE			0x00ff0000
>> +#define HFI_MASK_QHDR_PRI_TYPE			0x0000ff00
>> +#define HFI_MASK_QHDR_Q_ID_TYPE			0x000000ff
>> +#define HFI_Q_ID_HOST_TO_CTRL_CMD_Q		0
>> +#define HFI_Q_ID_CTRL_TO_HOST_MSG_Q		1
>> +#define HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q		2
>> +#define HFI_MASK_QHDR_STATUS			0x000000ff
> GENMASK, BIT()..
> 
sure, will explore these standard macros and use wherever possible.
> Konrad
