Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193417ACE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjIYDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjIYDKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:10:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BFAA7;
        Sun, 24 Sep 2023 20:10:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P2w9rj014284;
        Mon, 25 Sep 2023 03:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=30VHeSyGYzHPzTB3jvCEkL+AUpeDSctcovuhd0vnFV0=;
 b=f/RjTU52f7b3pYQYD2fEZT2Qvr14BxjU9A3OPNfdYgQ0rSY1eF12HDtIlYXz+x2eM7BM
 slZtfedheae0MGva7FbcezRLAeAL/Mh+F/ASnUY7Pwc9W4bwqGhKK5mKtlv8/YpQL2Hi
 6TwedjDF5MzqieedOZU5v0TUrN4qKxuw8+cB+nhkTVVQJrEz9QuTKHJQtg9fpBh6wLCK
 osy/EMZpSlP1LWLl5Vugf8euA/Er2xKkHvH4QfblZuq5e/dGAYSy4YxjOq1TGcnQ7N8C
 /uMQyPthOrxx9Bw2JZwyYTWlPeJJRL25t9zF67PHRiIZlZ6zyHMcIz3PASepg5OC1W7o jA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9qbptjcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 03:10:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P3AJwQ031384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 03:10:19 GMT
Received: from [10.253.15.18] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 24 Sep
 2023 20:10:16 -0700
Message-ID: <dfeb6071-8ae4-38ba-5273-59478ea8e178@quicinc.com>
Date:   Mon, 25 Sep 2023 11:10:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
 <af4fc816-d75b-997d-6d37-a774f5eb96ae@quicinc.com>
Content-Language: en-US
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <af4fc816-d75b-997d-6d37-a774f5eb96ae@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XJRBA2dU3AwcwaB447MKd2S34rCXhU9g
X-Proofpoint-ORIG-GUID: XJRBA2dU3AwcwaB447MKd2S34rCXhU9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250018
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/2023 10:44 PM, Jeffrey Hugo wrote:
> On 9/13/2023 2:47 AM, Qiang Yu wrote:
>> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>
>> Protect WP accesses such that multiple threads queueing buffers for
>> incoming data do not race and access the same WP twice. Ensure read and
>> write locks for the channel are not taken in succession by dropping the
>> read lock from parse_xfer_event() such that a callback given to client
>> can potentially queue buffers and acquire the write lock in that 
>> process.
>> Any queueing of buffers should be done without channel read lock 
>> acquired
>> as it can result in multiple locks and a soft lockup.
>>
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/main.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b..13c4b89 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -642,6 +642,7 @@ static int parse_xfer_event(struct mhi_controller 
>> *mhi_cntrl,
>>               mhi_del_ring_element(mhi_cntrl, tre_ring);
>>               local_rp = tre_ring->rp;
>>   +            read_unlock_bh(&mhi_chan->lock);
>
> This doesn't work due to the write_lock_irqsave(&mhi_chan->lock, 
> flags); on line 591.
Write_lock_irqsave(&mhi_chan->lock, flags) is used in case of ev_code >= 
MHI_EV_CC_OOB. We only read_lock/read_unlock the mhi_chan while ev_code 
< MHI_EV_CC_OOB.
>
> I really don't like that we are unlocking the mhi_chan while still 
> using it.  It opens up a window where the mhi_chan state can be 
> updated between here and the client using the callback to queue a buf.
>
> Perhaps we need a new lock that just protects the wp, and needs to be 
> only grabbed while mhi_chan->lock is held?

Since we have employed mhi_chan lock to protect the channel and what we 
are concerned here is that client may queue buf to a disabled or stopped 
channel, can we check channel state after getting mhi_chan->lock like 
line 595.

We can add the check after getting write lock in mhi_gen_tre() and after 
getting read lock again here.

>
>>               /* notify client */
>>               mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>   @@ -667,6 +668,7 @@ static int parse_xfer_event(struct 
>> mhi_controller *mhi_cntrl,
>>                       kfree(buf_info->cb_buf);
>>                   }
>>               }
>> +            read_lock_bh(&mhi_chan->lock);
>>           }
>>           break;
>>       } /* CC_EOT */
>> @@ -1204,6 +1206,9 @@ int mhi_gen_tre(struct mhi_controller 
>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>       int eot, eob, chain, bei;
>>       int ret;
>>   +    /* Protect accesses for reading and incrementing WP */
>> +    write_lock_bh(&mhi_chan->lock);
>> +
>>       buf_ring = &mhi_chan->buf_ring;
>>       tre_ring = &mhi_chan->tre_ring;
>>   @@ -1221,8 +1226,10 @@ int mhi_gen_tre(struct mhi_controller 
>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>         if (!info->pre_mapped) {
>>           ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
>> -        if (ret)
>> +        if (ret) {
>> +            write_unlock_bh(&mhi_chan->lock);
>>               return ret;
>> +        }
>>       }
>>         eob = !!(flags & MHI_EOB);
>> @@ -1239,6 +1246,8 @@ int mhi_gen_tre(struct mhi_controller 
>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>       mhi_add_ring_element(mhi_cntrl, tre_ring);
>>       mhi_add_ring_element(mhi_cntrl, buf_ring);
>>   +    write_unlock_bh(&mhi_chan->lock);
>> +
>>       return 0;
>>   }
>
