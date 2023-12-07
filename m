Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A457808029
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjLGF1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjLGF1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:27:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FDD6D;
        Wed,  6 Dec 2023 21:27:36 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B759NV1005313;
        Thu, 7 Dec 2023 05:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sJtq/mf3IaDcHrZEnV/Gxwe8zGF+t6C09xMyyojnKQs=;
 b=GqlD4qhcEs6svQOeJvzsjB9ZaaGXpr+3NmClMPHolbWtdQzpBZcARIqNHqTLmYWJIuAW
 lEG4+M4x9gCDVPWdfOLola6CtvceQoFkoWKHS1BFMxjfbee7gYAqZoS88W370Vv5chGT
 XyXCbU2Q2kAxomiqVAahmNv+RmiY41OO722ZlELEK6SGNXuep/rNsz9bHSF6RGf1CZTG
 zX8A0sV3xO0lLM1I5OWb53H2SuFUw86x+HbC+EVVj/utLcfmv+tQkZf7Ukgj13GPz2MX
 SussIt/AeM5Iab9in2rY2VEkP6QlmzV+7opFGRDdUcPeeFRHoNNEiBXkIkSDKpCajMsD Bw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu6qr04eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 05:27:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B75RObR031511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 05:27:24 GMT
Received: from [10.253.35.241] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 21:27:22 -0800
Message-ID: <947af144-e2a2-49bc-9f39-31f6ee5b1aa1@quicinc.com>
Date:   Thu, 7 Dec 2023 13:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
 <20231124100403.GA4536@thinkpad>
 <639d6008-bdfa-4b6e-b622-e916003ec908@quicinc.com>
 <20231128133252.GX3088@thinkpad>
 <5eb0a521-0b72-4d15-9a65-429c4c123833@quicinc.com>
 <20231130053157.GB3043@thinkpad>
 <9873ee7b-7ef1-4327-8e22-49e1cd3872f1@quicinc.com>
 <20231206134848.GG12802@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20231206134848.GG12802@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v8lOCPpFY54S-_fcui5HN1YbNZv7s8iq
X-Proofpoint-ORIG-GUID: v8lOCPpFY54S-_fcui5HN1YbNZv7s8iq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_03,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=733
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2023 9:48 PM, Manivannan Sadhasivam wrote:
> On Wed, Dec 06, 2023 at 10:25:12AM +0800, Qiang Yu wrote:
>> On 11/30/2023 1:31 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Nov 29, 2023 at 11:29:07AM +0800, Qiang Yu wrote:
>>>> On 11/28/2023 9:32 PM, Manivannan Sadhasivam wrote:
>>>>> On Mon, Nov 27, 2023 at 03:13:55PM +0800, Qiang Yu wrote:
>>>>>> On 11/24/2023 6:04 PM, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
>>>>>>>> Ensure read and write locks for the channel are not taken in succession by
>>>>>>>> dropping the read lock from parse_xfer_event() such that a callback given
>>>>>>>> to client can potentially queue buffers and acquire the write lock in that
>>>>>>>> process. Any queueing of buffers should be done without channel read lock
>>>>>>>> acquired as it can result in multiple locks and a soft lockup.
>>>>>>>>
>>>>>>> Is this patch trying to fix an existing issue in client drivers or a potential
>>>>>>> issue in the future drivers?
>>>>>>>
>>>>>>> Even if you take care of disabled channels, "mhi_event->lock" acquired during
>>>>>>> mhi_mark_stale_events() can cause deadlock, since event lock is already held by
>>>>>>> mhi_ev_task().
>>>>>>>
>>>>>>> I'd prefer not to open the window unless this patch is fixing a real issue.
>>>>>>>
>>>>>>> - Mani
>>>>>> In [PATCH v4 1/4] bus: mhi: host: Add spinlock to protect WP access when
>>>>>> queueing
>>>>>> TREs,  we add
>>>>>> write_lock_bh(&mhi_chan->lock)/write_unlock_bh(&mhi_chan->lock)
>>>>>> in mhi_gen_tre, which may be invoked as part of mhi_queue in client xfer
>>>>>> callback,
>>>>>> so we have to use read_unlock_bh(&mhi_chan->lock) here to avoid acquiring
>>>>>> mhi_chan->lock
>>>>>> twice.
>>>>>>
>>>>>> Sorry for confusing you. Do you think we need to sqush this two patch into
>>>>>> one?
>>>>> Well, if patch 1 is introducing a potential deadlock, then we should fix patch
>>>>> 1 itself and not introduce a follow up patch.
>>>>>
>>>>> But there is one more issue that I pointed out in my previous reply.
>>>> Sorry, I can not understand why "mhi_event->lock" acquired during
>>>> mhi_mark_stale_events() can cause deadlock. In mhi_ev_task(), we will
>>>> not invoke mhi_mark_stale_events(). Can you provide some interpretation?
>>> Going by your theory that if a channel gets disabled while processing the event,
>>> the process trying to disable the channel will try to acquire "mhi_event->lock"
>>> which is already held by the process processing the event.
>>>
>>> - Mani
>> OK, I get you. Thank you for kind explanation. Hopefully I didn't intrude
>> too much.
> Not at all. Btw, did you actually encounter any issue that this patch is trying
> to fix? Or just fixing based on code inspection.
>
> - Mani
Yes, we actually meet the race issue in downstream driver. But I can not 
find more details about the issue.
>>>>> Also, I'm planning to cleanup the locking mess within MHI in the coming days.
>>>>> Perhaps we can revisit this series at that point of time. Will that be OK for
>>>>> you?
>>>> Sure, that will be great.
>>>>> - Mani
>>>>>
>>>>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>>>>> ---
>>>>>>>>      drivers/bus/mhi/host/main.c | 4 ++++
>>>>>>>>      1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>>>>>> index 6c6d253..c4215b0 100644
>>>>>>>> --- a/drivers/bus/mhi/host/main.c
>>>>>>>> +++ b/drivers/bus/mhi/host/main.c
>>>>>>>> @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>>>>>>>      			mhi_del_ring_element(mhi_cntrl, tre_ring);
>>>>>>>>      			local_rp = tre_ring->rp;
>>>>>>>> +			read_unlock_bh(&mhi_chan->lock);
>>>>>>>> +
>>>>>>>>      			/* notify client */
>>>>>>>>      			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>>>>>>> @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>>>>>>>      					kfree(buf_info->cb_buf);
>>>>>>>>      				}
>>>>>>>>      			}
>>>>>>>> +
>>>>>>>> +			read_lock_bh(&mhi_chan->lock);
>>>>>>>>      		}
>>>>>>>>      		break;
>>>>>>>>      	} /* CC_EOT */
>>>>>>>> -- 
>>>>>>>> 2.7.4
>>>>>>>>
>>>>>>>>
