Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2917D77B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:21:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C8137;
        Wed, 25 Oct 2023 15:21:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PMBhSt011435;
        Wed, 25 Oct 2023 22:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=frd7X+b4+QqkmgA1UT/vTe4tnMvePCr2JwVMf31XUok=;
 b=cB2uTwODOxmgZw2DZwdojT2lNNCRSV0zPqLb+HosHK6D8TFu+wRUS1DNdoT5rp12CTyw
 5DZMmjdHJuuSd0Uei4Ju8G0kdzu/xo7FPgXum35ShQUw0lVgP1uXtzwsXPZ6g8QLPIDY
 ftb4LRgtNflP10HpNiA8LZM+W6gXE9+pHXMR8vioMDxQiVR0qYDh+XDGemc6GdqMeBgr
 sELUtxbFcwV14eqtUfzhd4vYX5Zp17lULDOnwQtTb++cu7gtQcboMK1bw9riVor6UmcB
 AFLlZqA8brzKgaRisniAJAa4cZTyHX5/QCcr7Qe50+zErpeUwWJJsK0+HhO2FjoPOvvv Pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty5wdrub5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 22:21:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PMLHRk012370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 22:21:17 GMT
Received: from [10.110.113.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 15:21:16 -0700
Message-ID: <c7fc7bc2-1a84-e6b5-5198-1b8cc602d738@quicinc.com>
Date:   Wed, 25 Oct 2023 15:21:15 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <0dee3bec-d49f-4808-a2f8-7a4205303e1f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mf4O9_ePsbzvPaMKt_MargIae0JXDtBK
X-Proofpoint-ORIG-GUID: Mf4O9_ePsbzvPaMKt_MargIae0JXDtBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250192
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 1:02 AM, Roger Quadros wrote:
> 
> 
> On 24/10/2023 21:41, Elson Serrao wrote:
>>
>>
>> On 10/24/2023 3:14 AM, Roger Quadros wrote:
>>> Hi Elson,
>>>
>>> On 14/08/2023 21:50, Elson Roy Serrao wrote:
>>>> The current implementation blocks the runtime pm operations when cable
>>>> is connected. This would block dwc3 to enter a low power state during
>>>> bus suspend scenario. Modify the runtime pm ops to handle bus suspend
>>>> case for such platforms where the controller low power mode entry/exit
>>>> is handled by the glue driver. This enablement is controlled through a
>>>> dt property and platforms capable of detecting bus resume can benefit
>>>> from this feature. Also modify the remote wakeup operations to trigger
>>>> runtime resume before sending wakeup signal.
>>>>
>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/core.c   | 28 ++++++++++++++++++++++++++--
>>>>    drivers/usb/dwc3/core.h   |  3 +++
>>>>    drivers/usb/dwc3/gadget.c | 32 +++++++++++++++++++++++++-------
>>>>    3 files changed, 54 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 9c6bf054f15d..9bfd9bb18caf 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -1518,6 +1518,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>>>        dwc->dis_split_quirk = device_property_read_bool(dev,
>>>>                    "snps,dis-split-quirk");
>>>>    +    dwc->runtime_suspend_on_usb_suspend = device_property_read_bool(dev,
>>>> +                "snps,runtime-suspend-on-usb-suspend");
>>>> +
>>>>        dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>>>        dwc->tx_de_emphasis = tx_de_emphasis;
>>>>    @@ -2029,6 +2032,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>>>          switch (dwc->current_dr_role) {
>>>>        case DWC3_GCTL_PRTCAP_DEVICE:
>>>> +        /* runtime resume on bus resume scenario */
>>>> +        if (PMSG_IS_AUTO(msg) && dwc->connected)
>>>> +            break;
>>>>            ret = dwc3_core_init_for_resume(dwc);
>>>>            if (ret)
>>>>                return ret;
>>>> @@ -2090,8 +2096,13 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
>>>>    {
>>>>        switch (dwc->current_dr_role) {
>>>>        case DWC3_GCTL_PRTCAP_DEVICE:
>>>> -        if (dwc->connected)
>>>> +        if (dwc->connected) {
>>>> +            /* bus suspend scenario */
>>>> +            if (dwc->runtime_suspend_on_usb_suspend &&
>>>> +                dwc->suspended)
>>>
>>> If dwc is already suspended why do we return -EBUSY?
>>> Should this be !dwc->suspended?
>>>
>>
>> Hi Roger
>>
>> Thank you for reviewing.
>> If dwc->suspended is true (i.e suspend event due to U3/L2 is received), I am actually breaking from this switch statement and returning 0.
> 
> Of course. I missed the break :)
> 
>>
>>>> +                break;
>>>>                return -EBUSY;
>>>> +        }
>>>>            break;
>>>>        case DWC3_GCTL_PRTCAP_HOST:
>>>>        default:
>>>> @@ -2107,9 +2118,22 @@ static int dwc3_runtime_suspend(struct device *dev)
>>>>        struct dwc3     *dwc = dev_get_drvdata(dev);
>>>>        int        ret;
>>>>    -    if (dwc3_runtime_checks(dwc))
>>>> +    ret = dwc3_runtime_checks(dwc);
>>>> +    if (ret)
>>>>            return -EBUSY;
>>>>    +    switch (dwc->current_dr_role) {
>>>> +    case DWC3_GCTL_PRTCAP_DEVICE:
>>>> +        /* bus suspend case */
>>>> +        if (!ret && dwc->connected)
>>>
>>> No need to check !ret again as it will never happen because
>>> we are returning -EBUSY earlier if (ret);
>>>
>> Thanks for this catch. I will remove !ret check in v5.
>>
>>>> +            return 0;
>>>> +        break;
>>>> +    case DWC3_GCTL_PRTCAP_HOST:
>>>> +    default:
>>>> +        /* do nothing */
>>>> +        break;
>>>> +    }
>>>> +
>>>
>>> While this takes care of runtime suspend case, what about system_suspend?
>>> Should this check be moved to dwc3_suspend_common() instead?
>>>
>>
>> Sure I can move these checks to dwc3_suspend_common to make it generic.
> 
> Before you do that let's first decide how we want the gadget driver to behave
> in system_suspend case.
> 
> Current behavior is to Disconnect from the Host.
> 
> Earlier I was thinking on the lines that we prevent system suspend if
> we are not already in USB suspend. But I'm not sure if that is the right
> thing to do anymore. Mainly because, system suspend is a result of user
> request and it may not be nice to not to meet his/her request.

Agree. Irrespective of whether USB is suspended or not it is better to 
honor the system suspend request from user.

> Maybe best to leave this policy handling to user space?
> i.e. if user wants USB gadget operation to be alive, he will not issue
> system suspend?
> 

Sure. So below two cases

Case1: User doesn't care if gadget operation is alive and triggers 
system suspend irrespective of USB suspend. Like you mentioned, current 
behavior already takes care of this and initiates a DISCONNECT

Case2:  User wants gadget to stay alive and hence can trigger system 
suspend only when USB is suspended (there are already user space hooks 
that read cdev->suspended bit to tell whether USB is suspended or not 
for user to decide). Attempts to request system suspend when USB is not 
suspended, would result in a DISCONNECT.

For supporting Case2 from gadget driver point of view, we need to extend 
this series by having relevant checks in suspend_common()

Also, is it better to provide separate flags to control the gadget 
driver behavior for runtime suspend Vs system suspend when USB is 
suspended ? For example, what if we want to enable bus suspend handling 
for runtime suspend only and not for system suspend (Case1).

Thanks
Elson



> 
>> Will rename this patch to "Modify pm ops to handle bus suspend" since this is now not limited to only runtime suspend/resume. Will also rename dwc->runtime_suspend_on_usb_suspend to dwc->delegate_wakeup_interrupt based on earlier feedback.
>>
>> I am still working on a clean way to enable/disable this feature (i.e set dwc->delegate_wakeup_interrupt flag) from the glue driver based on Thinh's feedback .
>> I will accommodate above feedback as well and upload v5.
>>
>> Thanks
>> Elson
> 
