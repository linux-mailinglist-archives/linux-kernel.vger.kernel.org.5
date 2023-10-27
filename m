Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F637D8C78
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjJ0AIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJ0AIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:08:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B1D4F;
        Thu, 26 Oct 2023 17:08:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QNxq7e010558;
        Fri, 27 Oct 2023 00:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KTwkppKtfnt2SAszLh2T9OBebpVxwToekkwIOrS6bL4=;
 b=nZbcxUsJY0ezVL5sidh830ykjrp0PQ6loSuQuiqUgbwY027VsGahwVKjM3mllbbwY/65
 WC6yqfUOe+iXZIcGZqtXWCcrBBAIIwMDCKWDr7C68FkJnjnRoev7CjblainhJ+m5OdD3
 JH9KA57UeywlKwi3KB8sayFHiEbVxzNzK9uFU60QoHtF2bPFBx3X1b7i/FQGc63ug794
 J91gXQfO3NfFML7Vp7R4kEudUtVYDPXnG7Bc6fQp8nICl/T4HnqitGAruKPIWib9esce
 MXNTeS9cFWHKciLlUjAuOYjgvmPL2FAQXBtM7if9nFdpXZZD7HEEk4jEu1pOoKX+EdX2 lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyx3u8jtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 00:07:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R07oVw032425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 00:07:50 GMT
Received: from [10.71.115.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 17:07:50 -0700
Message-ID: <ceb0f48f-8db9-40ae-769a-08e36373b922@quicinc.com>
Date:   Thu, 26 Oct 2023 17:07:49 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <bd74947f-8827-4539-a590-9c53d5ddd02d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7rxH9l_SyWSXCToapu9r2IwRjqwzkuZ8
X-Proofpoint-GUID: 7rxH9l_SyWSXCToapu9r2IwRjqwzkuZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=668 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260211
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>>>
>>>>> While this takes care of runtime suspend case, what about system_suspend?
>>>>> Should this check be moved to dwc3_suspend_common() instead?
>>>>>
>>>>
>>>> Sure I can move these checks to dwc3_suspend_common to make it generic.
>>>
>>> Before you do that let's first decide how we want the gadget driver to behave
>>> in system_suspend case.
>>>
>>> Current behavior is to Disconnect from the Host.
>>>
>>> Earlier I was thinking on the lines that we prevent system suspend if
>>> we are not already in USB suspend. But I'm not sure if that is the right
>>> thing to do anymore. Mainly because, system suspend is a result of user
>>> request and it may not be nice to not to meet his/her request.
>>
>> Agree. Irrespective of whether USB is suspended or not it is better to honor the system suspend request from user.
>>
>>> Maybe best to leave this policy handling to user space?
>>> i.e. if user wants USB gadget operation to be alive, he will not issue
>>> system suspend?
>>>
>>
>> Sure. So below two cases
>>
>> Case1: User doesn't care if gadget operation is alive and triggers system suspend irrespective of USB suspend. Like you mentioned, current behavior already takes care of this and initiates a DISCONNECT
>>
>> Case2:  User wants gadget to stay alive and hence can trigger system suspend only when USB is suspended (there are already user space hooks that read cdev->suspended bit to tell whether USB is suspended or not for user to decide). Attempts to request system suspend when USB is not suspended, would result in a DISCONNECT.
>>
>> For supporting Case2 from gadget driver point of view, we need to extend this series by having relevant checks in suspend_common()
>>
>> Also, is it better to provide separate flags to control the gadget driver behavior for runtime suspend Vs system suspend when USB is suspended ? For example, what if we want to enable bus suspend handling for runtime suspend only and not for system suspend (Case1).
> 
> But you mentioned that for Case1, USB gadget would disconnect from Host. So USB will be in disconnected state and USB controller can be fully de-activated? Except maybe wakeup handling to bring system out of suspend on a USB plug/unplug event?
> Why do we need separate flags for?
> 

Sorry let me clarify. This is in reference to deciding how we want the 
dwc3 driver to behave in system_suspend case.

One option is to continue with the existing behavior where USB gadget 
would disconnect from Host irrespective of bus suspend state. We dont 
need any modification in this case and we can leave this series limited 
to runtime suspend only.

Second option is to stay connected IF we are in bus suspend state 
(U3/L2) otherwise DISCONNECT IF we are not in bus suspend state. The 
main motivation is to preserve the ongoing usb session
without going through a re-enumeration (ofcourse true only if we are in 
bus suspend state). This would need relevant checks in suspend_common().

Which option do you think is more suitable? IMO option2 is better. For 
example if we are in a scenario where there is a network session (over 
USB) open between Host and the device and usb bus is suspended due to 
data inactivity. Option2 would preserve the session whereas Option1 we 
would terminate this session when a system_suspend happens.

Thanks
Elson
