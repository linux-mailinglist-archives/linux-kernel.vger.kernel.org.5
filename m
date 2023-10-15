Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F67C9A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjJOQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:48:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5DAB;
        Sun, 15 Oct 2023 09:48:19 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39FGg2aZ008768;
        Sun, 15 Oct 2023 16:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mEUVVgqaCA4wpoOL2SQhIE0kR75KjYORD2C4fBXqT9Y=;
 b=ERUOaU8wLOhBdYZHr7Vn6Wl14wJ8yYlsQ7P+uQgOSpb6UJlvzf15Be4wfAkvP23wYLnS
 q4L9dxo4AMymLfJBXhHNo7qe5sqIqW4BiZ6CnPa5r3DT79C6Vupaa1/KjzpV8QTMz2Wf
 OzfMUAfubhC84MV1r+dtY7PF9cW/Nb/fblEvvog9HlYyd+AnkesSLFQF+Zha+ligRPNu
 nFavrwHdl5+TBgBoaUUBqpAmtwsWq+nC4Z3j0l+zBWShFZWEPvokNFoZmS2f42R0gOcH
 fjesQA5BzjkNc6DZmRtmAE4Uo1tGPCedBiHrRGEYwHoLtD4H66p0C7KaAL8NbNHnDODa Mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqkrpadqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Oct 2023 16:48:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39FGmDoY013458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Oct 2023 16:48:13 GMT
Received: from [10.216.16.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 15 Oct
 2023 09:48:09 -0700
Message-ID: <6b2115c2-ddd1-401e-81ef-e998264bfd89@quicinc.com>
Date:   Sun, 15 Oct 2023 22:18:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usb: dwc3: core: Fix RAM interface getting stuck during
 enumeration
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
 <20231012175912.umc3ugzk4iqwtcp3@synopsys.com>
 <bac414a7-aa2a-4b93-82e0-998002c455e0@quicinc.com>
 <20231012221744.ww2w6febhurvlqi6@synopsys.com>
 <cabf2de7-bde2-4cec-9f99-2cb8c92875a5@quicinc.com>
Content-Language: en-US
In-Reply-To: <cabf2de7-bde2-4cec-9f99-2cb8c92875a5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nPLU4SAadXg2dZQpxeGhyhhG5LimVYnU
X-Proofpoint-GUID: nPLU4SAadXg2dZQpxeGhyhhG5LimVYnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=986 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310150152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 9:28 AM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/13/2023 3:47 AM, Thinh Nguyen wrote:
>> On Fri, Oct 13, 2023, Krishna Kurapati PSSNV wrote:
>>>
>>>
>>> On 10/12/2023 11:29 PM, Thinh Nguyen wrote:
>>>
>>>>> -static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>>>> +int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>>>>    {
>>>>>        unsigned long flags;
>>>>>        int ret;
>>>>> @@ -2701,7 +2701,7 @@ static int dwc3_gadget_soft_disconnect(struct 
>>>>> dwc3 *dwc)
>>>>>        return ret;
>>>>>    }
>>>>> -static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
>>>>> +int dwc3_gadget_soft_connect(struct dwc3 *dwc)
>>>>>    {
>>>>>        int ret;
>>>>> @@ -3963,6 +3963,7 @@ static void 
>>>>> dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
>>>>>        dwc3_gadget_dctl_write_safe(dwc, reg);
>>>>>        dwc->connected = false;
>>>>> +    dwc->cable_disconnected = true;
>>>>>        dwc3_disconnect_gadget(dwc);
>>>>> @@ -4038,6 +4039,7 @@ static void 
>>>>> dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>>>>         */
>>>>>        dwc3_stop_active_transfers(dwc);
>>>>>        dwc->connected = true;
>>>>> +    dwc->cable_disconnected = false;
>>>>>        reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>>>>        reg &= ~DWC3_DCTL_TSTCTRL_MASK;
>>>>> -- 
>>>>> 2.42.0
>>>>>
>>>>
>>>> We can just reset the controller when there's End Transfer command
>>>> timeout as a failure recovery. No need to do what you're doing here.
>>>>
>>> Hi Thinh,
>>>
>>>   That was what I initially wanted to do, but there were couple of 
>>> reasons I
>>> wanted to take this approach:
>>>
>>> 1. We can't just reset the controller in midst of gadget_interrupt. 
>>> We need
>>> to process it completely and then take action.
>>
>> You can flag the driver so you can do the teardown/soft-reset at the
>> appropriate time.
>>
>>>
>>> 2. The above log was seen on QRD variant of SM8550/SM8650 easily. But on
>>> other platforms of same targets, the issue comes up at some other 
>>> instances
>>> of code, at a point where no IRQ is running. In such cases its not 
>>> possible
>>> to accurately find out code portions and reset the controller. The way I
>>> confirmed that both platforms are having the same issue is:
>>>
>>> a. During cable disconnect, I am not receiving disconnect interrupt
>>> b. The reg dump is exactly same in both cases (BMU as well)
>>>
>>> So I felt it was better to fix it during cable disconnect because 
>>> even if we
>>> remove cable, we are still in device mode only and in this case we can
>>> unblock suspend and also bring back controller to a known state.
>>>
>>> Let me know your thoughts on the above.
>>>
>>
>> This issue happens outside of disconnect right? Did you account for port
>> reset?
>>
>> The symptom should be the same. At some point, a command will be issued.
>> If a command timed out, then something is really wrong (especially End
>> Transfer command). We can attempt to recover base on this symptom then.
>>
>> And you don't need to poll for timeout for this specific type of error.
>> Just read some known register like GSNPSID to see if it's invalid.
> 
> Hi Thinh,
> 
>   Yes. It actually happens before disconnect, but I was trying to handle 
> it during disconnect. How about I add a check in gadget_ep_cmd saying 
> that if cmd timeout happens, then read the snpsid and if it reads an 
> invalid value, then I will call soft_disconnect followed by 
> soft_connect. That must cover all cases ?
> 
Hi Thinh,

One more datapoint for putting forward the above opinion. There are two 
types of situations observed during bus reset when we try to do endxfer 
on ep0in followed by set_stall on ep0out:

1. If we issue endxfer for ep0in, and it times out, then the next 
command set_stall is successful (only because all reads give zero and 
since we check for CMDACT bit for ep0out after setting it, and since the 
read of DEPCMD register gives "0" while polling for it, sw indicated 
that set stall is successful. But when we check GEVTADDR at this point, 
both ADDRLO and ADDRHI read zero.

2. If ram access timeout occurs while polling for CMDACT bit after 
issuing endxfer on ep0in, then at that instant, polling returns true, sw 
indicates that endxfer is successful but inreality when checked, 
GEVTADDR LO/HI read zero.

So I think it would be better to check for validity of GEVADDR registers 
at end of gadget_ep_cmd to identify id RAM access timeout happened and 
call soft_disconnect followed by soft_connect.

Let me know your thoughts on this

Regards,
Krishna,
