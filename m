Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749817EAA75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKNGRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjKNGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:17:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D20C1BF;
        Mon, 13 Nov 2023 22:17:33 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE5OnxZ028719;
        Tue, 14 Nov 2023 06:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VfR1d3VfvowgfP3Ve6H+Nvh15iZ5w1IgG2Yr/nNYKR4=;
 b=f+qaVeqNTsDTPz+nbz5nBZ0S7kzGTQoGSwdK4OOSR35ruWXXR2FKdXFcR3hLCYVnthzX
 8w4Bq92J63biOUNBNZe2ZXyJLMJ7H+6FV5zHZ+8+xMToXe/lZhJgRPD9EqfbncZqFpk3
 dyNbXqBsqE1TFzgnU6HBIBMgxURUYgcsGw6ZPjh6szUmNCaozXAX5upCVPYt2WuOdHSK
 Yqj2/bgceV5jiiSbJP9svTt2OZYLuSOhBHDdmJ8xFcukxj6LejQ8TDo2v+tGO/wi77LH
 X2zXw++ONwg/4q9gSU8F5nn3Qc+d1Nos8TCKmfdgRKax7v1ky4tnwu/ClPaSwp+DppsV aw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqfdhew6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 06:17:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AE6HNhN015604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 06:17:23 GMT
Received: from [10.253.8.153] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 22:17:21 -0800
Message-ID: <72bb93a5-29a7-4608-b787-18a982df38ba@quicinc.com>
Date:   Tue, 14 Nov 2023 14:17:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event
 of a disable channel
Content-Language: en-US
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
 <1699341365-47737-4-git-send-email-quic_qianyu@quicinc.com>
 <20231109163253.GL3752@thinkpad>
 <808f8982-8c2c-40ed-9fb9-1c9932c8db28@quicinc.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc:    imap://quic_qianyu@qcmail1.qualcomm.com/Sent
In-Reply-To: <808f8982-8c2c-40ed-9fb9-1c9932c8db28@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cMUF-993r9acRvBlAFoRL0Pb-GxZ4L0m
X-Proofpoint-ORIG-GUID: cMUF-993r9acRvBlAFoRL0Pb-GxZ4L0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=692 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2023 11:38 AM, Qiang Yu wrote:
>
> On 11/10/2023 12:32 AM, Manivannan Sadhasivam wrote:
>> On Tue, Nov 07, 2023 at 03:16:04PM +0800, Qiang Yu wrote:
>>> Ckeck mhi channel state after getting chan->lock to ensure that we only
>>> queue buffer to an enabled channel and process event of an enabled 
>>> channel.
>>>
>> This commit message doesn't give proper explanation on how the 
>> channel can go to
>> disabled state in between parse_xfer_event() and mhi_gen_tre().
>>
>> - Mani
>
> Hi Mani. How about following commit message
>
> MHI channel state is protected by mhi_chan->lock. Hence, after core drops
> mhi_chan->lock during processing xfer event, it can not prevent channel
> state being changed if client closes channel or driver is removed at this
> time. So let's check mhi channel state after getting chan->lock again 
> to avoid
> queuing buffer to a disabled channel in xfer callback and stop processing
> event of the disabled channel.
Hi Mani, Have updated this commit message in V4 patch, hope get your 
comments.
>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> ---
>>>   drivers/bus/mhi/host/main.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>> index a236dc2..b137d54 100644
>>> --- a/drivers/bus/mhi/host/main.c
>>> +++ b/drivers/bus/mhi/host/main.c
>>> @@ -672,6 +672,8 @@ static int parse_xfer_event(struct 
>>> mhi_controller *mhi_cntrl,
>>>               }
>>>                 read_lock_bh(&mhi_chan->lock);
>>> +            if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
>>> +                goto end_process_tx_event;
>>>           }
>>>           break;
>>>       } /* CC_EOT */
>>> @@ -1211,6 +1213,8 @@ int mhi_gen_tre(struct mhi_controller 
>>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>>         /* Protect accesses for reading and incrementing WP */
>>>       write_lock_bh(&mhi_chan->lock);
>>> +    if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
>>> +        return -EINVAL;
>>>         buf_ring = &mhi_chan->buf_ring;
>>>       tre_ring = &mhi_chan->tre_ring;
>>> -- 
>>> 2.7.4
>>>
>>>
>
