Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED07E3625
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjKGIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:00:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A3E8;
        Tue,  7 Nov 2023 00:00:00 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A76eXJH018774;
        Tue, 7 Nov 2023 07:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NDucsj2q75e98JcNIa4TZAP69g3rwEi7mKSn4CFEMBU=;
 b=Us2e+i2PXGtk2wpqideV659ZhYUno2778ZsxkuKHVYOAK/tObf2iOf7lWgwc/vo31tSa
 jsL45xPwV4J621+Z/ObpKwtfgo8WcddDe2JA7ptHZfTD9HG04KscovN+rsVQdZ5Nvt9Q
 POn9rGKTxC3GXbFTFcZQTH5NBeX5V6RgfzkCs7yOGginv/MCOwoGHbzSDjqSpdEHsk7J
 I2ggwTlF1bJxCexj2e/77rN7Z8/FF3H2gRZxDq2Q/gKxW18UTy/nWL7BO1/sgcmd9rCz
 MCJji/nHjVW8bnpqsa4p0ck+3o7zZ9f1eNzvhvZ8V/QlsQysg+Tfhma/gLxjHkaMMWEc 0A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer2vqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 07:59:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A77xrj1014858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 07:59:53 GMT
Received: from [10.253.15.27] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 23:59:51 -0800
Message-ID: <00305327-d866-4da4-916c-fb414398bc3a@quicinc.com>
Date:   Tue, 7 Nov 2023 15:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
 <af4fc816-d75b-997d-6d37-a774f5eb96ae@quicinc.com>
 <dfeb6071-8ae4-38ba-5273-59478ea8e178@quicinc.com>
 <c30c9c68-bfe1-0cc5-c511-218f7d1da92d@quicinc.com>
 <15526b95-518c-445a-be64-6a15259405fb@quicinc.com>
 <472817a7-78bb-25d9-b8c6-2d70f713b7fb@quicinc.com>
 <20231106045119.GB2474@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20231106045119.GB2474@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: owIEIQkDwFhbK7exT3Kb00mP_xfOVM9N
X-Proofpoint-GUID: owIEIQkDwFhbK7exT3Kb00mP_xfOVM9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 12:51 PM, Manivannan Sadhasivam wrote:
> On Fri, Oct 20, 2023 at 09:07:35AM -0600, Jeffrey Hugo wrote:
>> On 10/16/2023 2:46 AM, Qiang Yu wrote:
>>> On 9/29/2023 11:22 PM, Jeffrey Hugo wrote:
>>>> On 9/24/2023 9:10 PM, Qiang Yu wrote:
>>>>> On 9/22/2023 10:44 PM, Jeffrey Hugo wrote:
>>>>>> On 9/13/2023 2:47 AM, Qiang Yu wrote:
>>>>>>> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>>>>>
>>>>>>> Protect WP accesses such that multiple threads queueing buffers for
>>>>>>> incoming data do not race and access the same WP twice.
>>>>>>> Ensure read and
>>>>>>> write locks for the channel are not taken in succession
>>>>>>> by dropping the
>>>>>>> read lock from parse_xfer_event() such that a callback given to client
>>>>>>> can potentially queue buffers and acquire the write lock
>>>>>>> in that process.
>>>>>>> Any queueing of buffers should be done without channel
>>>>>>> read lock acquired
>>>>>>> as it can result in multiple locks and a soft lockup.
>>>>>>>
>>>>>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>>>> ---
>>>>>>>    drivers/bus/mhi/host/main.c | 11 ++++++++++-
>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>>>>> index dcf627b..13c4b89 100644
>>>>>>> --- a/drivers/bus/mhi/host/main.c
>>>>>>> +++ b/drivers/bus/mhi/host/main.c
>>>>>>> @@ -642,6 +642,7 @@ static int parse_xfer_event(struct
>>>>>>> mhi_controller *mhi_cntrl,
>>>>>>>                mhi_del_ring_element(mhi_cntrl, tre_ring);
>>>>>>>                local_rp = tre_ring->rp;
>>>>>>>    +            read_unlock_bh(&mhi_chan->lock);
>>>>>> This doesn't work due to the
>>>>>> write_lock_irqsave(&mhi_chan->lock, flags); on line 591.
>>>>> Write_lock_irqsave(&mhi_chan->lock, flags) is used in case of
>>>>> ev_code >= MHI_EV_CC_OOB. We only read_lock/read_unlock the
>>>>> mhi_chan while ev_code < MHI_EV_CC_OOB.
>>>> Sorry.  OOB != EOB
>>>>
>>>>>> I really don't like that we are unlocking the mhi_chan while
>>>>>> still using it.  It opens up a window where the mhi_chan
>>>>>> state can be updated between here and the client using the
>>>>>> callback to queue a buf.
>>>>>>
>>>>>> Perhaps we need a new lock that just protects the wp, and
>>>>>> needs to be only grabbed while mhi_chan->lock is held?
>>>>> Since we have employed mhi_chan lock to protect the channel and
>>>>> what we are concerned here is that client may queue buf to a
>>>>> disabled or stopped channel, can we check channel state after
>>>>> getting mhi_chan->lock like line 595.
>>>>>
>>>>> We can add the check after getting write lock in mhi_gen_tre()
>>>>> and after getting read lock again here.
>>>> I'm not sure that is sufficient.  After you unlock to notify the
>>>> client, MHI is going to manipulate the packet count and runtime_pm
>>>> without the lock (648-652).  It seems like that adds additional
>>>> races which won't be covered by the additional check you propose.
>>> I don't think read_lock_bh(&mhi_chan->lock) can protect runtime_pm and
>>> the packet count here. Even if we do not unlock, mhi state and packet
>>> count can still be changed because we did not get pm_lock here, which is
>>> used in all mhi state transition function.
>>>
>>> I also checked all places that mhi_chan->lock is grabbed, did not see
>>> packet count and runtime_pm be protected by write_lock(&mhi_chan->lock).
>>>
>>>
>>> If you really don't like the unlock operation, we can also take a new
>>> lock. But I think we only need to add the new lock in two places,
>>> mhi_gen_tre and mhi_pm_m0_transition while mhi_chan->lock is held.
>> Mani, if I recall correctly, you were the architect of the locking.  Do you
>> have an opinion?
>>
> TBH, the locking situation is a mess with MHI. Initially, we happen to have
> separate locks for protecting various operations, but then during review, it was
> advised to reuse existing locks and avoid having too many separate locks.
>
> This worked well but then we kind of abused the locks over time. I asked Hemant
> and Bhaumik to audit the locks and fix them, but both of them left Qcom.
>
> So in this situation, the intent of the pm_lock was to protect concurrent access
> against updating the pm_state. And it also happen to protect _other_things_ such
> as runtime_put, pending_pkts etc... But not properly, because most of the time
> read lock is taken in places where pm_state is being read. So there is still a
> possibility of race while accessing these _other_things_.
>
> For this patch, I'm happy with dropping chan->lock before calling xfer_cb() and
> I want someone (maybe Qiang) to do the audit of locking in general and come up
> with fixes where needed.
>
> - Mani

As discussed with Jeff before, we also need to check channel state 
before queue buffer and after re-lock

in parse_xfer_event, so I also add the channel state check in next 
version patch.

Probably I can do the audit of locking. It's a good chance for me to 
understand various locks in MHI host

driver completely.

