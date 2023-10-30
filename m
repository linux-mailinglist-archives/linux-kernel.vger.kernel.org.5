Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA37DBFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJ3Sli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJ3Slg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:41:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310BC9;
        Mon, 30 Oct 2023 11:41:32 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UINMXH005744;
        Mon, 30 Oct 2023 18:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DBcvM7I6vA3kOhdjHsguFx5PKkUbrhWdDwhRXky9OcE=;
 b=geMCgZzi+kN3gO1A+f53U0jAXFkJbFIMGve9v8h8vlGD+bnGiOJ/l6v3yUxxlHm9xXgL
 Pd6TgYjyb+bl0Wwp4SewmrcwV110h3nbeihkGP5n7u0kD4SO0Pp8uBXexaqqUk7Pp1U/
 4CQjWaXP+E6n340eOfb55EHmgEFL8e3xh36rXzazGY2Hi/im0Xds724CTNkPXEPLpOPm
 S8FY4USoonO/cV9NEVVUcRtXL9AswVA1h2pbuIWMrX1l78SnC+/11zmnA8L9pyDrCX9G
 xfnmjd3Ppw4/XU+9fnFP7jNlZehaE8eDmPvaPN1Wn1dlAERNAeNx/rSdK9BR8tmw6RbD iA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey0t9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 18:41:26 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UIfPla006490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 18:41:25 GMT
Received: from [10.110.59.210] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 11:41:25 -0700
Message-ID: <4f37aace-004f-5ff1-bff4-d939892176be@quicinc.com>
Date:   Mon, 30 Oct 2023 11:41:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-4-quic_eserrao@quicinc.com>
 <9be9fae5-f6f2-42fe-bd81-78ab50aafa06@kernel.org>
 <cd294a89-33e7-0569-81b3-df77a255f061@quicinc.com>
 <0dee3bec-d49f-4808-a2f8-7a4205303e1f@kernel.org>
 <c7fc7bc2-1a84-e6b5-5198-1b8cc602d738@quicinc.com>
 <bd74947f-8827-4539-a590-9c53d5ddd02d@kernel.org>
 <ceb0f48f-8db9-40ae-769a-08e36373b922@quicinc.com>
 <09707469-193b-43c5-8503-b75f97ba1fbf@kernel.org>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <09707469-193b-43c5-8503-b75f97ba1fbf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v0iFOVinI0uV_gTyNVsky44UZQW0ytlH
X-Proofpoint-GUID: v0iFOVinI0uV_gTyNVsky44UZQW0ytlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=648
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300145
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 11:37 PM, Roger Quadros wrote:
> 
> 
> On 27/10/2023 03:07, Elson Serrao wrote:
>>
>>
>>
>>>>>>>
>>>>>>> While this takes care of runtime suspend case, what about system_suspend?
>>>>>>> Should this check be moved to dwc3_suspend_common() instead?
>>>>>>>
>>>>>>
>>>>>> Sure I can move these checks to dwc3_suspend_common to make it generic.
>>>>>
>>>>> Before you do that let's first decide how we want the gadget driver to behave
>>>>> in system_suspend case.
>>>>>
>>>>> Current behavior is to Disconnect from the Host.
>>>>>
>>>>> Earlier I was thinking on the lines that we prevent system suspend if
>>>>> we are not already in USB suspend. But I'm not sure if that is the right
>>>>> thing to do anymore. Mainly because, system suspend is a result of user
>>>>> request and it may not be nice to not to meet his/her request.
>>>>
>>>> Agree. Irrespective of whether USB is suspended or not it is better to honor the system suspend request from user.
>>>>
>>>>> Maybe best to leave this policy handling to user space?
>>>>> i.e. if user wants USB gadget operation to be alive, he will not issue
>>>>> system suspend?
>>>>>
>>>>
>>>> Sure. So below two cases
>>>>
>>>> Case1: User doesn't care if gadget operation is alive and triggers system suspend irrespective of USB suspend. Like you mentioned, current behavior already takes care of this and initiates a DISCONNECT
>>>>
>>>> Case2:  User wants gadget to stay alive and hence can trigger system suspend only when USB is suspended (there are already user space hooks that read cdev->suspended bit to tell whether USB is suspended or not for user to decide). Attempts to request system suspend when USB is not suspended, would result in a DISCONNECT.
>>>>
>>>> For supporting Case2 from gadget driver point of view, we need to extend this series by having relevant checks in suspend_common()
>>>>
>>>> Also, is it better to provide separate flags to control the gadget driver behavior for runtime suspend Vs system suspend when USB is suspended ? For example, what if we want to enable bus suspend handling for runtime suspend only and not for system suspend (Case1).
>>>
>>> But you mentioned that for Case1, USB gadget would disconnect from Host. So USB will be in disconnected state and USB controller can be fully de-activated? Except maybe wakeup handling to bring system out of suspend on a USB plug/unplug event?
>>> Why do we need separate flags for?
>>>
>>
>> Sorry let me clarify. This is in reference to deciding how we want the dwc3 driver to behave in system_suspend case.
>>
>> One option is to continue with the existing behavior where USB gadget would disconnect from Host irrespective of bus suspend state. We dont need any modification in this case and we can leave this series limited to runtime suspend only.
>>
>> Second option is to stay connected IF we are in bus suspend state (U3/L2) otherwise DISCONNECT IF we are not in bus suspend state. The main motivation is to preserve the ongoing usb session
>> without going through a re-enumeration (ofcourse true only if we are in bus suspend state). This would need relevant checks in suspend_common().
> 
> The catch here is, what to do if the USB device is not in bus suspend state but user wants to put the system in suspend state? Do we still disconnect?
> 
> You might also want to refer to the discussion in [1]
> 
> [1] - https://lore.kernel.org/all/Y+z9NK6AyhvTQMir@rowland.harvard.edu/
> 

Thanks for the details. If we dont DISCONNECT when the USB link is NOT 
in bus suspend, the other alternatives we have are below ones

1.) Abort system_suspend: In addition to not honoring the users request 
to put the system in suspend, there is always a possibility of host 
driver never sending bus suspend interrupt. If that happens we would be 
denying system_suspend every time user requests it. So this is not a 
right approach.

2.) Keep the gadget connected and proceed with system_suspend: Now the 
system is suspended but from host point of view the USB link is active 
and would continue the communication normally. The signalling probably 
is not going to to be detected as a wakeup by the Rx hardware as there 
is no explicit resume signal involved here . The only exception is if we 
can somehow configure each and every event from the host as a wakeup 
signal(not sure if this is even possible)

So IMO it is best to DISCONNECT from the host when USB link is NOT in 
bus suspend state and user requests system_suspend.

Thanks
Elson

