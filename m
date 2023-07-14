Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296627543CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjGNUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGNUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:34:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE035AD;
        Fri, 14 Jul 2023 13:34:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EJpe0H022313;
        Fri, 14 Jul 2023 20:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZvBKHQt2H9QiG5lqWBVxSCqJDtoYqQbd9AvaEBg7LuM=;
 b=EUD+s1zlEP64XEzzYFmbezsaKhjJSNeUpDZbZM+8yiLCg5xksdSKhWm4y/WJVWXqC6d3
 IHDXbLBmMVAmtjhQRz9u1rpEZMZ47xBrKdW+qkEhIuBsJtsfpiA3JVJJbazrr1onwmLE
 qnIuiLxD1CZxDOcREvakusMIvGndnO8LMiNhBWbAc8nVyHy2wmnfMlInzpEy9llyXFO2
 q/0ZB6WddzhzHD8OMo9sIrzJlueNS9J+Fle513wIRZeS8pLFOohuQDMQEblVem0dvka/
 NhXzi5Qg3ej3ZOdViuLVepwVD7EToiD9A+nmakgI7KtRZxuHl88wkxrX5uQcr7WvVx9H Uw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpuhtqec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:34:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EKYb8r021026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:34:37 GMT
Received: from [10.110.17.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 13:34:37 -0700
Message-ID: <be57511d-2005-a1f5-d5a5-809e71029aec@quicinc.com>
Date:   Fri, 14 Jul 2023 13:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-4-quic_eserrao@quicinc.com>
 <9fc752db-ea8a-4bf0-a99a-832403668384@kernel.org>
 <3c9c6924-bf79-e8bb-fd44-9262f114504b@quicinc.com>
 <9715b60c-2caa-82d6-42ea-31502272ebc4@kernel.org>
 <aa311ec9-7abd-0684-16cd-e7a2cfa7ef3c@quicinc.com>
 <8b10d8a5-a9df-6a2e-61b9-7119961e2401@kernel.org>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <8b10d8a5-a9df-6a2e-61b9-7119961e2401@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vPbCluxjPCsWeuD5O3RFkcLp8mHaHdfm
X-Proofpoint-ORIG-GUID: vPbCluxjPCsWeuD5O3RFkcLp8mHaHdfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=276 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140188
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 5:23 AM, Roger Quadros wrote:
> 
> 

>>>>>>     }
>>>>>>       static void dwc3_gadget_interrupt(struct dwc3 *dwc,
>>>>>> @@ -4718,7 +4736,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>>>>>     {
>>>>>>         if (dwc->pending_events) {
>>>>>>             dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>>>>> +        pm_runtime_put(dwc->dev);
>>>>>
>>>>> Why the put here?
>>>>>
>>>>
>>>> To balance the get() called when setting the pending_events flag in dwc3_check_event_buf()
>>>>
>>>>       if (pm_runtime_suspended(dwc->dev)) {
>>>>           pm_runtime_get(dwc->dev);
>>>>           disable_irq_nosync(dwc->irq_gadget);
>>>>           dwc->pending_events = true;
>>>>           return IRQ_HANDLED;
>>>>       }
>>>>
>>>
>>> No this wrong. We want the device to be active from now on.
>>>
>>> runtime suspended->interrupt->pm_runtime_get->runtime_resume->process_pending_events->USB gadget resumed
>>>
>>> Only on next USB suspend you want to do the pm_runtime_put like you are doing it
>>> in dwc3_gadget_suspend_interrupt() by pm_request_autosuspend()
>>>
>>
>> That would break/block dwc3 runtime suspend during DISCONNECT case in below scenario
>>
>> runtime suspended->interrupt->pm_runtime_get (runtime usage count is 1)->runtime_resume->process_pending_events->USB gadget resumed -> USB disconnect (autosuspend blocked due to runtime usage count being 1 due to unbalanced get() ).
>>
>> The idea here is to balance the get() that was requested for processing the pending events, after processing those events. (like how we balance get() of ep_queue through put() in ep_dequeue)
>>
>> Also pm_request_autosuspend() doesnt decrement the usage count, it only requests for autosuspend.
> 
> Ah, indeed.
> 
>>
>> But I think better approach in terms of ordering is below
> 
> ok, but should dwc->pending_events be set before calling pm_runtime_get() in dwc3_check_event_buf()?

Yes that would be a better approach (just in case if there is any race 
between dwc3_check_event_buf() and the resume() path).

> Can we add a comment there that the get will be balanced out in dwc3_gadget_process_pending_events()?

Sure.
> 
>>
>> @@ -4718,7 +4736,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>   {
>>       if (dwc->pending_events) {
>>           dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>> +        /*
>> +         * We have only stored the pending events as part
>> +         * of dwc3_interrupt() above, but those events are
>> +         * not yet handled. So explicitly invoke the
>> +         * interrupt handler for handling those events.
>> +         */
>> +        dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>           dwc->pending_events = false;
>>           enable_irq(dwc->irq_gadget);
>> +        pm_runtime_put(dwc->dev);
> 
> We could do the put right after dwc3_thread_interrupt().

Ack.

> 
>>
>>       }
>>   }
> 
> I think this fix should be an independent patch
> as this fixes an issue that existed prior to this series?
> also need to -cc stable?
> 
Agree. Both dwc3_thread_interrupt() and pm_runtime_put() above are 
addressing an issue that existed prior. I will submit a separate patch 
for this modification.

Thanks
Elson
