Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40876C7FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjHBIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjHBIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:07:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B2F7;
        Wed,  2 Aug 2023 01:07:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724OE8g011187;
        Wed, 2 Aug 2023 08:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U4iunAVfuADoinDKeRTU0T8/d58ZZVr4+EjRZXZbKsY=;
 b=Jez4wgmkd6xRt3COBGUeB/E5VOZr3iGG1D1LjrekbmDBKJd+pGJN3gt0Z9n5jw3psnfe
 d/a172p6RtCs8sL1tq/Hc7on3i8FIv7uf9mUQOG2MtSqUBGdCG0O6kP9tuYjkqZPvZLb
 i84foLzxxlF2YHxkozg8IGRxASd5k1p0SBGyt8v1UcoJn3bHa+tyHtmqLbezOWVxI0UP
 8AbwllrlG9HRGepKfvrVg3qTYweIocrASGDBJbljB0lA3buVC81tgHlIT2L4rKgn8TUq
 Cj73XMWJJmb/x8Skzo6QA+FWD88CkRrk8rc/wIUsvIQ6NW+VaPp6XFOAPZmUyjgGsEjt Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre0nef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:07:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37287WjN007727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:07:32 GMT
Received: from [10.216.20.75] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:07:29 -0700
Message-ID: <c2f50606-5589-276d-e106-8ee01c37eabe@quicinc.com>
Date:   Wed, 2 Aug 2023 13:37:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] soc: qcom: qmi: Signal the txn completion after releasing
 the mutex
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20230731130755.2674029-1-quic_ipkumar@quicinc.com>
 <eda306fc-1a92-4a2d-b13f-c3b59a39ef8d@quicinc.com>
 <abcd7ea3-086b-b07c-bb08-63aaf2585040@quicinc.com>
 <1f1b2453-c6c4-8bd7-404e-fb95a356235e@quicinc.com>
 <73f25c8f-6193-6001-d3ff-b7fd060cce83@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <73f25c8f-6193-6001-d3ff-b7fd060cce83@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F-yMjAAwXEVKIYtqS7U1z_uipAMaZj1g
X-Proofpoint-ORIG-GUID: F-yMjAAwXEVKIYtqS7U1z_uipAMaZj1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 5:11 AM, Chris Lew wrote:
> 
> 
> On 8/1/2023 4:13 AM, Sricharan Ramabadhran wrote:
>> Hi,
>>
>> On 8/1/2023 6:06 AM, Chris Lew wrote:
>>>
>>>
>>> On 7/31/2023 8:19 AM, Pavan Kondeti wrote:
>>>> On Mon, Jul 31, 2023 at 06:37:55PM +0530, Praveenkumar I wrote:
>>>>> txn is in #1 stack
>>>>>
>>>>> Worker #1                                       Worker #2
>>>>> ********                    *********
>>>>>
>>>>> qmi_txn_wait(txn)                               qmi_handle_message
>>>>>     |                                                  |
>>>>>     |                                                  |
>>>>>   wait_for_complete(txn->complete)                    ....
>>>>>     |                                             
>>>>> mutex_lock(txn->lock)
>>>>>     |                                                  |
>>>>>   mutex_lock(txn->lock)                                |
>>>>>     .....                                         complete(txn->lock)
>>>>>     | mutex_unlock(txn->lock)
>>>>>     |
>>>>>   mutex_unlock(txn->lock)
>>>>>
>>>>> In this case above, while #2 is doing the mutex_unlock(txn->lock),
>>>>> in between releasing lock and doing other lock related wakeup, #2 gets
>>>>> scheduled out. As a result #1, acquires the lock, unlocks, also
>>>>> frees the txn also (where the lock resides)
>>>>>
>>>>> Now #2, gets scheduled again and tries to do the rest of the lock
>>>>> related wakeup, but lock itself is invalid because txn itself is gone.
>>>>>
>>>>> Fixing this, by doing the mutex_unlock(txn->lock) first and then
>>>>> complete(txn->lock) in #2
>>>>>
>>>>> Fixes: 3830d0771ef6 ("soc: qcom: Introduce QMI helpers")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>> ---
>>>>>   drivers/soc/qcom/qmi_interface.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/soc/qcom/qmi_interface.c 
>>>>> b/drivers/soc/qcom/qmi_interface.c
>>>>> index 78d7361fdcf2..92e29db97359 100644
>>>>> --- a/drivers/soc/qcom/qmi_interface.c
>>>>> +++ b/drivers/soc/qcom/qmi_interface.c
>>>>> @@ -505,12 +505,13 @@ static void qmi_handle_message(struct 
>>>>> qmi_handle *qmi,
>>>>>                   pr_err("failed to decode incoming message\n");
>>>>>               txn->result = ret;
>>>>> -            complete(&txn->completion);
>>>>>           } else  {
>>>>>               qmi_invoke_handler(qmi, sq, txn, buf, len);
>>>>>           }
>>>>>           mutex_unlock(&txn->lock);
>>>>> +        if (txn->dest && txn->ei)
>>>>> +            complete(&txn->completion);
>>>>>       } else {
>>>>>           /* Create a txn based on the txn_id of the incoming 
>>>>> message */
>>>>>           memset(&tmp_txn, 0, sizeof(tmp_txn));
>>>>
>>>> What happens in a remote scenario where the waiter gets timed out at 
>>>> the
>>>> very same time you are releasing the mutex but before calling
>>>> complete()? The caller might end up freeing txn structure and it 
>>>> results
>>>> in the same issue you are currently facing.
>>>>
>>>> Thanks,
>>>> Pavan
>>>
>>> I think downstream we had various attempts of moving the signal 
>>> around trying to avoid this, but hit scenarios like the one Pavan 
>>> described.
>>>
>>> We eventually settled on removing the txn->lock and treating the 
>>> qmi->txn_lock as a big lock. This remedied the issue where the 
>>> txn->lock goes out of scope since qmi->txn_lock is tied to the qmi 
>>> handle.
>>>
>>
>>   ok agree. Using qmi->txn_lock looks a better approach.
>>   That said, this race between mutex lock/unlock looks odd though.
>>   If i remember we saw the issue only with CONFIG_DEBUG_LOCK_ALLOC.
>>   Was that the same case for you guys as well ?
>>
>>   Otherwise, ideally handling all members of the object inside lock
>>   should be the right solution (ie moving the wait_for_complete(txn)
>>   inside the mutex_lock in qmi_txn_wait. That should take care of the
>>   scenario that Pavan described too.
>>
> 
> No, we saw the issue even without CONFIG_DEBUG_LOCK_ALLOC. The 
> callstacks always ended up showing that the mutex could be acquired 
> before mutex_unlock() completely finished.
> 
> It didn't seem wise to poke at the mutex implementation so we went with 
> the txn_lock.

  ok, that's strange. That effectively means, mutex_lock/unlock are not
  working/protecting the critical section ? Then qmi->txn_lock also would
  result in a similar issue ? I guess, in this case, during issue, txn
  (which holds the lock) was going out of context, while still the txn
  was in used in other thread. That effectively shows up a mutex issue
  maybe. While the downstream change to use qmi->txn_lock would fix the
  mutex issue, will have to check if the txn object itself is protected
  correctly.

Regards,
  Sricharan
