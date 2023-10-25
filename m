Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF767D645B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjJYICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJYICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:02:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179899
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:02:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7CFC433C9;
        Wed, 25 Oct 2023 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698220962;
        bh=jQc7NqI/yKjks8Vc9GC6S3bk6T8WV+i0v/+4jkcKVwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jb1iyz1KC38E0Q355lenhDghCvpYJXOEQWWFzT1di4TLfSm3Y0fWQh+BuGwHKymEi
         MHoX68UU1FjZK5VfuRkcF60v+Yc8CYFsMs6ox7OrXfsP1H3frwlW2+5drXu1+M+n/5
         xkdQlYdvjOxK4iaq+acHv9oh+WSLumYjojZLeTUT9Ml1TZYUQdNYoM6Lf1z37r8ZzP
         vNaPz58MLgyvjQmtqTzh+mvLUlAiI4df/vDLbNEBG2hJIkgx2oHrz4ig1LHe6FPfgi
         mAzaWjQVT2VRAiguPbTN4UtR5chnBrLBfvNhLev6ZgOshxN7axRTuSDRKj5Y4cVzOw
         n2wnb5R0JBz3w==
Message-ID: <0dee3bec-d49f-4808-a2f8-7a4205303e1f@kernel.org>
Date:   Wed, 25 Oct 2023 11:02:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-4-quic_eserrao@quicinc.com>
 <9be9fae5-f6f2-42fe-bd81-78ab50aafa06@kernel.org>
 <cd294a89-33e7-0569-81b3-df77a255f061@quicinc.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <cd294a89-33e7-0569-81b3-df77a255f061@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 21:41, Elson Serrao wrote:
> 
> 
> On 10/24/2023 3:14 AM, Roger Quadros wrote:
>> Hi Elson,
>>
>> On 14/08/2023 21:50, Elson Roy Serrao wrote:
>>> The current implementation blocks the runtime pm operations when cable
>>> is connected. This would block dwc3 to enter a low power state during
>>> bus suspend scenario. Modify the runtime pm ops to handle bus suspend
>>> case for such platforms where the controller low power mode entry/exit
>>> is handled by the glue driver. This enablement is controlled through a
>>> dt property and platforms capable of detecting bus resume can benefit
>>> from this feature. Also modify the remote wakeup operations to trigger
>>> runtime resume before sending wakeup signal.
>>>
>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>> ---
>>>   drivers/usb/dwc3/core.c   | 28 ++++++++++++++++++++++++++--
>>>   drivers/usb/dwc3/core.h   |  3 +++
>>>   drivers/usb/dwc3/gadget.c | 32 +++++++++++++++++++++++++-------
>>>   3 files changed, 54 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 9c6bf054f15d..9bfd9bb18caf 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1518,6 +1518,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>>       dwc->dis_split_quirk = device_property_read_bool(dev,
>>>                   "snps,dis-split-quirk");
>>>   +    dwc->runtime_suspend_on_usb_suspend = device_property_read_bool(dev,
>>> +                "snps,runtime-suspend-on-usb-suspend");
>>> +
>>>       dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>>       dwc->tx_de_emphasis = tx_de_emphasis;
>>>   @@ -2029,6 +2032,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>>         switch (dwc->current_dr_role) {
>>>       case DWC3_GCTL_PRTCAP_DEVICE:
>>> +        /* runtime resume on bus resume scenario */
>>> +        if (PMSG_IS_AUTO(msg) && dwc->connected)
>>> +            break;
>>>           ret = dwc3_core_init_for_resume(dwc);
>>>           if (ret)
>>>               return ret;
>>> @@ -2090,8 +2096,13 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
>>>   {
>>>       switch (dwc->current_dr_role) {
>>>       case DWC3_GCTL_PRTCAP_DEVICE:
>>> -        if (dwc->connected)
>>> +        if (dwc->connected) {
>>> +            /* bus suspend scenario */
>>> +            if (dwc->runtime_suspend_on_usb_suspend &&
>>> +                dwc->suspended)
>>
>> If dwc is already suspended why do we return -EBUSY?
>> Should this be !dwc->suspended?
>>
> 
> Hi Roger
> 
> Thank you for reviewing.
> If dwc->suspended is true (i.e suspend event due to U3/L2 is received), I am actually breaking from this switch statement and returning 0.

Of course. I missed the break :)

> 
>>> +                break;
>>>               return -EBUSY;
>>> +        }
>>>           break;
>>>       case DWC3_GCTL_PRTCAP_HOST:
>>>       default:
>>> @@ -2107,9 +2118,22 @@ static int dwc3_runtime_suspend(struct device *dev)
>>>       struct dwc3     *dwc = dev_get_drvdata(dev);
>>>       int        ret;
>>>   -    if (dwc3_runtime_checks(dwc))
>>> +    ret = dwc3_runtime_checks(dwc);
>>> +    if (ret)
>>>           return -EBUSY;
>>>   +    switch (dwc->current_dr_role) {
>>> +    case DWC3_GCTL_PRTCAP_DEVICE:
>>> +        /* bus suspend case */
>>> +        if (!ret && dwc->connected)
>>
>> No need to check !ret again as it will never happen because
>> we are returning -EBUSY earlier if (ret);
>>
> Thanks for this catch. I will remove !ret check in v5.
> 
>>> +            return 0;
>>> +        break;
>>> +    case DWC3_GCTL_PRTCAP_HOST:
>>> +    default:
>>> +        /* do nothing */
>>> +        break;
>>> +    }
>>> +
>>
>> While this takes care of runtime suspend case, what about system_suspend?
>> Should this check be moved to dwc3_suspend_common() instead?
>>
> 
> Sure I can move these checks to dwc3_suspend_common to make it generic.

Before you do that let's first decide how we want the gadget driver to behave
in system_suspend case.

Current behavior is to Disconnect from the Host.

Earlier I was thinking on the lines that we prevent system suspend if
we are not already in USB suspend. But I'm not sure if that is the right
thing to do anymore. Mainly because, system suspend is a result of user
request and it may not be nice to not to meet his/her request.
Maybe best to leave this policy handling to user space?
i.e. if user wants USB gadget operation to be alive, he will not issue
system suspend?


> Will rename this patch to "Modify pm ops to handle bus suspend" since this is now not limited to only runtime suspend/resume. Will also rename dwc->runtime_suspend_on_usb_suspend to dwc->delegate_wakeup_interrupt based on earlier feedback.
> 
> I am still working on a clean way to enable/disable this feature (i.e set dwc->delegate_wakeup_interrupt flag) from the glue driver based on Thinh's feedback .
> I will accommodate above feedback as well and upload v5.
> 
> Thanks
> Elson

-- 
cheers,
-roger
