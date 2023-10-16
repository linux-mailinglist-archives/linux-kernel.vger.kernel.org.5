Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78377CA231
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJPIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjJPIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:47:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414AFC;
        Mon, 16 Oct 2023 01:46:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G7Eevq015368;
        Mon, 16 Oct 2023 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6PdGZexFiZdEmLSFU/iSKXNyHxsB0KZlMvjNSsGZia4=;
 b=j57qn934K/sHfFYcGU0JryEiOGlU5Pt8/dBSH7eQNzHZSyB9RqIhHisjqgsX3nI0i8DX
 eJbdOgPloa5DGKzwyAdOWYrj68Q6W58iLB7NH62WzFc/YUlmGRyUPzVI9fRx6abUJ0nb
 E8TclVuJjp7diUp5dcm6oCi6ZC80NMyEueqtrzGrz8iP9AZjTxCsjWnu4kuJMPDm9azt
 vMWF2BnApY2Y+evBM0rrt1jTKbApqfc1j7NoAmDOM4M1e3Zdr9L+HePDvsrqcrFZ9Qtv
 KzFUQvREiV6tx3Tpdtiw87btSdazI4idvAROG9L96OCJwgf/yRrrogNdFHK+kFe+Xs5N OA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqjk6ugcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 08:46:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39G8knpe005915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 08:46:49 GMT
Received: from [10.253.8.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 16 Oct
 2023 01:46:46 -0700
Message-ID: <15526b95-518c-445a-be64-6a15259405fb@quicinc.com>
Date:   Mon, 16 Oct 2023 16:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
 <af4fc816-d75b-997d-6d37-a774f5eb96ae@quicinc.com>
 <dfeb6071-8ae4-38ba-5273-59478ea8e178@quicinc.com>
 <c30c9c68-bfe1-0cc5-c511-218f7d1da92d@quicinc.com>
Content-Language: en-US
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <c30c9c68-bfe1-0cc5-c511-218f7d1da92d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GxPvcZBb9-MBIisc2QKTwSJycm163L8S
X-Proofpoint-ORIG-GUID: GxPvcZBb9-MBIisc2QKTwSJycm163L8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_01,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2023 11:22 PM, Jeffrey Hugo wrote:
> On 9/24/2023 9:10 PM, Qiang Yu wrote:
>>
>> On 9/22/2023 10:44 PM, Jeffrey Hugo wrote:
>>> On 9/13/2023 2:47 AM, Qiang Yu wrote:
>>>> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>>
>>>> Protect WP accesses such that multiple threads queueing buffers for
>>>> incoming data do not race and access the same WP twice. Ensure read 
>>>> and
>>>> write locks for the channel are not taken in succession by dropping 
>>>> the
>>>> read lock from parse_xfer_event() such that a callback given to client
>>>> can potentially queue buffers and acquire the write lock in that 
>>>> process.
>>>> Any queueing of buffers should be done without channel read lock 
>>>> acquired
>>>> as it can result in multiple locks and a soft lockup.
>>>>
>>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> ---
>>>>   drivers/bus/mhi/host/main.c | 11 ++++++++++-
>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>> index dcf627b..13c4b89 100644
>>>> --- a/drivers/bus/mhi/host/main.c
>>>> +++ b/drivers/bus/mhi/host/main.c
>>>> @@ -642,6 +642,7 @@ static int parse_xfer_event(struct 
>>>> mhi_controller *mhi_cntrl,
>>>>               mhi_del_ring_element(mhi_cntrl, tre_ring);
>>>>               local_rp = tre_ring->rp;
>>>>   +            read_unlock_bh(&mhi_chan->lock);
>>>
>>> This doesn't work due to the write_lock_irqsave(&mhi_chan->lock, 
>>> flags); on line 591.
>> Write_lock_irqsave(&mhi_chan->lock, flags) is used in case of ev_code 
>> >= MHI_EV_CC_OOB. We only read_lock/read_unlock the mhi_chan while 
>> ev_code < MHI_EV_CC_OOB.
>
> Sorry.  OOB != EOB
>
>>>
>>> I really don't like that we are unlocking the mhi_chan while still 
>>> using it.  It opens up a window where the mhi_chan state can be 
>>> updated between here and the client using the callback to queue a buf.
>>>
>>> Perhaps we need a new lock that just protects the wp, and needs to 
>>> be only grabbed while mhi_chan->lock is held?
>>
>> Since we have employed mhi_chan lock to protect the channel and what 
>> we are concerned here is that client may queue buf to a disabled or 
>> stopped channel, can we check channel state after getting 
>> mhi_chan->lock like line 595.
>>
>> We can add the check after getting write lock in mhi_gen_tre() and 
>> after getting read lock again here.
>
> I'm not sure that is sufficient.  After you unlock to notify the 
> client, MHI is going to manipulate the packet count and runtime_pm 
> without the lock (648-652).  It seems like that adds additional races 
> which won't be covered by the additional check you propose.

I don't think read_lock_bh(&mhi_chan->lock) can protect runtime_pm and 
the packet count here. Even if we do not unlock, mhi state and packet 
count can still be changed because we did not get pm_lock here, which is 
used in all mhi state transition function.

I also checked all places that mhi_chan->lock is grabbed, did not see 
packet count and runtime_pm be protected by write_lock(&mhi_chan->lock).


If you really don't like the unlock operation, we can also take a new 
lock. But I think we only need to add the new lock in two places, 
mhi_gen_tre and mhi_pm_m0_transition while mhi_chan->lock is held.

>
>>
>>>
>>>>               /* notify client */
>>>>               mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>>>   @@ -667,6 +668,7 @@ static int parse_xfer_event(struct 
>>>> mhi_controller *mhi_cntrl,
>>>>                       kfree(buf_info->cb_buf);
>>>>                   }
>>>>               }
>>>> +            read_lock_bh(&mhi_chan->lock);
>>>>           }
>>>>           break;
>>>>       } /* CC_EOT */
>>>> @@ -1204,6 +1206,9 @@ int mhi_gen_tre(struct mhi_controller 
>>>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>>>       int eot, eob, chain, bei;
>>>>       int ret;
>>>>   +    /* Protect accesses for reading and incrementing WP */
>>>> +    write_lock_bh(&mhi_chan->lock);
>>>> +
>>>>       buf_ring = &mhi_chan->buf_ring;
>>>>       tre_ring = &mhi_chan->tre_ring;
>>>>   @@ -1221,8 +1226,10 @@ int mhi_gen_tre(struct mhi_controller 
>>>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>>>         if (!info->pre_mapped) {
>>>>           ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
>>>> -        if (ret)
>>>> +        if (ret) {
>>>> +            write_unlock_bh(&mhi_chan->lock);
>>>>               return ret;
>>>> +        }
>>>>       }
>>>>         eob = !!(flags & MHI_EOB);
>>>> @@ -1239,6 +1246,8 @@ int mhi_gen_tre(struct mhi_controller 
>>>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>>>       mhi_add_ring_element(mhi_cntrl, tre_ring);
>>>>       mhi_add_ring_element(mhi_cntrl, buf_ring);
>>>>   +    write_unlock_bh(&mhi_chan->lock);
>>>> +
>>>>       return 0;
>>>>   }
>>>
>
