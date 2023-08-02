Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB5176D02A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjHBOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHBOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79B11B;
        Wed,  2 Aug 2023 07:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B86619C0;
        Wed,  2 Aug 2023 14:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ADEC433C8;
        Wed,  2 Aug 2023 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690987033;
        bh=iYdzytNAMkrdTcwt0fJP8Phpqg8JorxckNukjlnNPvA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZPmn8UusjG/Tdcgs0+dSVOO9CdWjtR3dPEdhDuKmOkOYJvnEwAjY9Qd8Zo4CiE6zQ
         Xe2pfESDfqM3/3Ih7OgitR4QeDv99FGjKBs/imzjZlfCC89GdkA2Jerhbc9WXbki/4
         uFCR9Oy7obOhOrV+QMSi88bERlM5jGjMFqqxk84ouWJP+kZ2VHMJiDneeREXyc1LxC
         2R7b5ow8BwFjt/uuFlyVfmSYdmLsPVOS9QWi9DDeflggQc1A3AMTmedjGTg0Llyt1/
         moLRxjo4HwjBsWBDVy1sAntDKSBVvG6lds0bBMirYjYwSYYQMaXwClFXbNumIrVgmy
         aySKkb5Vd21AA==
Message-ID: <b2ab8803-d4e0-bd63-7a64-bcc411e04cfe@kernel.org>
Date:   Wed, 2 Aug 2023 17:37:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc3: Properly handle processing of pending events
Content-Language: en-US
To:     =?UTF-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= 
        <surong.pang@unisoc.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <2bf3663abc72448da44427dcaedb49fe@shmbx05.spreadtrum.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2bf3663abc72448da44427dcaedb49fe@shmbx05.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/08/2023 04:39, 庞苏荣 (Surong Pang) wrote:
> Dears，
> If there is/are event(s) in evt->buf,  in dwc3_check_event_buf,  dwc3_thread_interrupt will be woke up.

How will it be woken up if we had disabled the IRQ to begin with?

> 
>>> @@ -4718,6 +4723,8 @@ void dwc3_gadget_process_pending_events(struct
>>> dwc3 *dwc)  {
>>>       if (dwc->pending_events) {
>>>               dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>> +             dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>> +             pm_runtime_put(dwc->dev);
>>>               dwc->pending_events = false;
>>>               enable_irq(dwc->irq_gadget);
>>>       }
> 
> I just want to know dwc3_thread_interrupt here is necessary or not?
> 
As IRQ was disabled, we will have to call dwc3_thread_interrupt() to
process the events that are still pending.

> 
>> On Tue, Aug 02, 2023 8:12 Thinh Nguyen wrote:
>>> On Tue, Aug 01, 2023, Elson Roy Serrao wrote:
>>> If dwc3 is runtime suspended we defer processing the event buffer
>>> until resume, by setting the pending_events flag. Set this flag before
>>> triggering resume to avoid race with the runtime resume callback.
>>>
>>> While handling the pending events, in addition to checking the event
>>> buffer we also need to process it. Handle this by explicitly calling
>>> dwc3_thread_interrupt(). Also balance the runtime pm get() operation
>>> that triggered this processing.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>> ---
>>> Change separated from below series as an independent fix based on the
>>> earlier discussion
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/be57511d-2005-
>>> a1f5-d5a5-809e71029aec@quicinc.com/__;!!A4F2R9G_pg!YtZ93ALEpDNTCEhf0WE
>>> yB5S090pPlKIKVtjqTOAEJdxdWbl8QG6eiRmlvfivUtD5qjKWWLX2C4fb4W8VAg5w9qasL
>>> uKB$
>>>
>>>  drivers/usb/dwc3/gadget.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 5fd067151fbf..858fe4c299b7 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -4455,9 +4455,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>>       u32 count;
>>>
>>>       if (pm_runtime_suspended(dwc->dev)) {
>>> +             dwc->pending_events = true;
>>> +             /*
>>> +              * Trigger runtime resume. The get() function will be balanced
>>> +              * after processing the pending events in dwc3_process_pending
>>> +              * events().
>>> +              */
>>>               pm_runtime_get(dwc->dev);
>>>               disable_irq_nosync(dwc->irq_gadget);
>>> -             dwc->pending_events = true;
>>>               return IRQ_HANDLED;
>>>       }
>>>
>>> @@ -4718,6 +4723,8 @@ void dwc3_gadget_process_pending_events(struct
>>> dwc3 *dwc)  {
>>>       if (dwc->pending_events) {
>>>               dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>> +             dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>> +             pm_runtime_put(dwc->dev);
>>>               dwc->pending_events = false;
>>>               enable_irq(dwc->irq_gadget);
>>>       }
>>> --
>>> 2.17.1
>>>
>>
>> This fix is more complete.
>>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>
>> Thanks,
>> Thinh

-- 
cheers,
-roger
