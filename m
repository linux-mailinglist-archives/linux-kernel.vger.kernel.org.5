Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE2753ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjGNMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbjGNMYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1230ED;
        Fri, 14 Jul 2023 05:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4C661D06;
        Fri, 14 Jul 2023 12:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9FEC433C7;
        Fri, 14 Jul 2023 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689337434;
        bh=8pAPa9LAiH8CqC58A4IqSufu6LWcLWvwyikY62DhFpQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GLburYcPL4o2ZErSHjjOv/U90vqX+WXWXq9o0TBxxUH+kEqGNBHyqdEr9kNmGRQ+/
         o/OdvJtEtIdMRFxMNsBDPYOhlJTIsbG22llt1UMCm90Ex03H5iA0X1Q9YlUg1sUjyH
         DzE8RWGFW7Kl94oYP403x4BjNxhKMd3kStq1GsA0s0tRmZMxavtg45yPXZPjD06tF2
         ZJR2Pfyn9i0866js5QzTyRUaQApHcV2rNd53wXeeLD7BSFMD9AjliJkgVcC/sTjh2k
         spchQag5uXm0DDYNGYYctrwzZbCmrgR2hsx7Ddt3WWalAmbUpHM0Uy2L6lzs7vYkOI
         owMMOqIs5cmJQ==
Message-ID: <8b10d8a5-a9df-6a2e-61b9-7119961e2401@kernel.org>
Date:   Fri, 14 Jul 2023 15:23:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Content-Language: en-US
To:     Elson Serrao <quic_eserrao@quicinc.com>, Thinh.Nguyen@synopsys.com,
        stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-4-quic_eserrao@quicinc.com>
 <9fc752db-ea8a-4bf0-a99a-832403668384@kernel.org>
 <3c9c6924-bf79-e8bb-fd44-9262f114504b@quicinc.com>
 <9715b60c-2caa-82d6-42ea-31502272ebc4@kernel.org>
 <aa311ec9-7abd-0684-16cd-e7a2cfa7ef3c@quicinc.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <aa311ec9-7abd-0684-16cd-e7a2cfa7ef3c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2023 01:31, Elson Serrao wrote:
> 
> 
> On 7/13/2023 5:56 AM, Roger Quadros wrote:
>>
>>
>> On 13/07/2023 01:57, Elson Serrao wrote:
>>>
>>>
>>> On 7/12/2023 6:46 AM, Roger Quadros wrote:
>>>>
>>>>
>>>> On 11/07/2023 20:43, Elson Roy Serrao wrote:
>>>>> The current implementation blocks the runtime pm operations when cable
>>>>> is connected. This would block platforms from entering system wide suspend
>>>>> during bus suspend scenario. Modify the runtime pm ops to handle bus
>>>>> suspend case for such platforms where the controller low power mode
>>>>> entry/exit is handled by the glue driver. This enablement is controlled
>>>>> through a dt property and platforms capable of detecting bus resume can
>>>>> benefit from this feature. Also modify the remote wakeup operations to
>>>>> trigger runtime resume before sending wakeup signal.
>>>>>
>>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>>> ---
>>>>>    drivers/usb/dwc3/core.c   | 26 ++++++++++++++++++++++---
>>>>>    drivers/usb/dwc3/core.h   |  3 +++
>>>>>    drivers/usb/dwc3/gadget.c | 40 ++++++++++++++++++++++++++++++++-------
>>>>>    3 files changed, 59 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>> index f6689b731718..898c0f68e190 100644
>>>>> --- a/drivers/usb/dwc3/core.c
>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>> @@ -1534,6 +1534,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>>>>        dwc->dis_split_quirk = device_property_read_bool(dev,
>>>>>                    "snps,dis-split-quirk");
>>>>>    +    dwc->allow_rtsusp_on_u3 = device_property_read_bool(dev,
>>>>> +                "snps,allow-rtsusp-on-u3");
>>>>> +
>>>>>        dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>>>>        dwc->tx_de_emphasis = tx_de_emphasis;
>>>>>    @@ -1984,11 +1987,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>>>>    {
>>>>>        unsigned long    flags;
>>>>>        u32 reg;
>>>>> +    int link_state;
>>>>>          switch (dwc->current_dr_role) {
>>>>>        case DWC3_GCTL_PRTCAP_DEVICE:
>>>>>            if (pm_runtime_suspended(dwc->dev))
>>>>>                break;
>>>>> +
>>>>> +        if (dwc->connected) {
>>>>> +            link_state = dwc3_gadget_get_link_state(dwc);
>>>>> +            /* bus suspend case */
>>>>> +            if (dwc->allow_rtsusp_on_u3 &&
>>>>> +                link_state == DWC3_LINK_STATE_U3> +                break;
>>>>
>>>> dwc3_suspend_common() is called both during runtime suspend and system sleep with
>>>> appropriate pm_msg_t argument.
>>>> Do you want the same behavior for both cases?
>>>>
>>> Thank you for your comments and feedback.
>>> The goal here is to trigger runtime suspend when bus suspend interrupt is received. If dwc3 runtime suspend is executed, then for system sleep dwc3_suspend_common() is a no-op as we have a pm_runtime_suspended(dwc->dev) check in place in the above code.
>>> The exception I can think of with these changes in place is below sequence
>>> USB bus suspended---->Runtime suspend fails OR is not invoked for some reason--->System sleep is triggered.
>>>
>>> We can extend this change to above case as well. I believe that was the intention of your patch (i.e avoid gadget disconnect if usb bus is suspended for system sleep case)
>>> https://lore.kernel.org/linux-usb/20230320093447.32105-3-rogerq@kernel.org/
>>>
>>> Please let me know your opinion on extending this series to system sleep also.
>>
>> As dwc3_suspend_common()/dwc3_resume_common() is used for both runtime and
>> system suspend it would be nice if you test that system suspend is not broken.
>> Doesn't have to be enhanced.
>>
> Sure. Will update the details accordingly in v4.
>>>
>>>
>>>> You are not checking if the gadget driver was put into suspend state or not.
>>>> So, instead of just checking line state, should we also check that we processed
>>>> the suspend interrupt and gadget driver has been suspended as well?
>>>> i.e. add a SW flag dwc3->suspended and set it at end of dwc3_suspend_gadget()
>>>> and clear it at beginning of dwc3_resume_gadget().
>>>> Check for that flag in the above if condition.
>>>> i.e. if (dwc->connected && dwc->suspended)
>>>>
>>>
>>> We already have flags for these purposes (dwc->link_state and dwc->suspended) that we set when suspend interrupt is received and clear during wakeup. We can use these flags here
>>
>> OK but bear in mind that link_state might not be updated once runtime suspended.
>>
>>>
>>>>> +            return -EBUSY;
>>>>> +        }
>>>>>            dwc3_gadget_suspend(dwc);
>>>>>            synchronize_irq(dwc->irq_gadget);
>>>>>            dwc3_core_exit(dwc);
>>>>> @@ -2045,6 +2058,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>>>>          switch (dwc->current_dr_role) {
>>>>>        case DWC3_GCTL_PRTCAP_DEVICE:
>>>>> +        /* bus resume case */
>>>>> +        if (dwc->connected)
>>>>
>>>> dwc->connected might get cleard to false if device was disconnected. So this is not reliable.
>>>> You might want to set another SW flag to track this special case of suspend
>>>> with controller kept active.
>>>>
>>>
>>> Are you referring to the DISCONNECT interrupt ? We dont handle gadget interrupts when in runtime suspended state and dwc3 driver has to be resumed first. The mechanism for this already exists in dwc3_check_event_buf() like below
>>>
>>>      if (pm_runtime_suspended(dwc->dev)) {
>>>          pm_runtime_get(dwc->dev);
>>>          disable_irq_nosync(dwc->irq_gadget);
>>>          dwc->pending_events = true;
>>>          return IRQ_HANDLED;
>>>      }
>>>
>>> I cant think of any scenario where dwc->connected is cleared before calling resume_common() for bus suspend case. Please let me know if I am missing any corner case.
>>>
>>>>> +            break;
>>>>>            ret = dwc3_core_init_for_resume(dwc);
>>>>>            if (ret)
>>>>>                return ret;
>>>>> @@ -2123,9 +2139,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>>>>>        struct dwc3     *dwc = dev_get_drvdata(dev);
>>>>>        int        ret;
>>>>>    -    if (dwc3_runtime_checks(dwc))
>>>>> -        return -EBUSY;
>>>>> -
>>>> Instead of removing this how about modifying dwc3_runtime_checks(). see below.
>>>>
>>>
>>> Yes we can do that. But if we are planning to extend these changes to system sleep better to leave it here IMO.
>>>
>>>>>        ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
>>>>>        if (ret)
>>>>>            return ret;
>>>>> @@ -2160,9 +2173,15 @@ static int dwc3_runtime_resume(struct device *dev)
>>>>>    static int dwc3_runtime_idle(struct device *dev)
>>>>>    {
>>>>>        struct dwc3     *dwc = dev_get_drvdata(dev);
>>>>> +    int        link_state;
>>>>>          switch (dwc->current_dr_role) {
>>>>>        case DWC3_GCTL_PRTCAP_DEVICE:
>>>>> +        link_state = dwc3_gadget_get_link_state(dwc);
>>>>> +        /* for bus suspend case return success */
>>>>> +        if (dwc->allow_rtsusp_on_u3 && dwc->connected &&
>>>>> +            link_state == DWC3_LINK_STATE_U3)
>>>>> +            goto autosuspend;
>>>>
>>>> why not just break?
>>> Done
>>>>
>>>>>            if (dwc3_runtime_checks(dwc))
>>>>
>>>> what about this dwc3_runtime_checks()?
>>>> Looks like the if condition you added above can go in dwc3_runtime_checks() instead.
>>>>
>>>>>                return -EBUSY;
>>>>>            break;
>>>>> @@ -2172,6 +2191,7 @@ static int dwc3_runtime_idle(struct device *dev)
>>>>>            break;
>>>>>        }
>>>>>    +autosuspend:
>>>>>        pm_runtime_mark_last_busy(dev);
>>>>>        pm_runtime_autosuspend(dev);
>>>>>    diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>>> index 8b1295e4dcdd..33b2ccbbd963 100644
>>>>> --- a/drivers/usb/dwc3/core.h
>>>>> +++ b/drivers/usb/dwc3/core.h
>>>>> @@ -1127,6 +1127,8 @@ struct dwc3_scratchpad_array {
>>>>>     * @num_ep_resized: carries the current number endpoints which have had its tx
>>>>>     *            fifo resized.
>>>>>     * @debug_root: root debugfs directory for this device to put its files in.
>>>>> + * @allow_rtsusp_on_u3: true if dwc3 runtime suspend is allowed during bus
>>>>> + *            suspend scenario.
>>>>
>>>> what about system sleep?
>>>>
>>> Currently this series is tested for runtime suspend during bus suspend scenario. We can extend to system sleep like explained above.
>>>
>>>>>     */
>>>>>    struct dwc3 {
>>>>>        struct work_struct    drd_work;
>>>>> @@ -1343,6 +1345,7 @@ struct dwc3 {
>>>>>        int            last_fifo_depth;
>>>>>        int            num_ep_resized;
>>>>>        struct dentry        *debug_root;
>>>>> +    bool            allow_rtsusp_on_u3;
>>>>>    };
>>>>>      #define INCRX_BURST_MODE 0
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>> index 5fd067151fbf..0797cffa2d48 100644
>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>> @@ -2401,15 +2401,21 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>>>>            return -EINVAL;
>>>>>        }
>>>>>    -    spin_lock_irqsave(&dwc->lock, flags);
>>>>>        if (!dwc->gadget->wakeup_armed) {
>>>>>            dev_err(dwc->dev, "not armed for remote wakeup\n");
>>>>> -        spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>            return -EINVAL;
>>>>>        }
>>>>> -    ret = __dwc3_gadget_wakeup(dwc, true);
>>>>>    +    ret = pm_runtime_resume_and_get(dwc->dev);
>>>>> +    if (ret < 0) {
>>>>> +        pm_runtime_set_suspended(dwc->dev);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    spin_lock_irqsave(&dwc->lock, flags);
>>>>> +    ret = __dwc3_gadget_wakeup(dwc, true);
>>>>>        spin_unlock_irqrestore(&dwc->lock, flags);
>>>>> +    pm_runtime_put_noidle(dwc->dev);
>>>>>          return ret;
>>>>>    }
>>>>> @@ -2428,6 +2434,12 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>>>>            return -EINVAL;
>>>>>        }
>>>>>    +    ret = pm_runtime_resume_and_get(dwc->dev);
>>>>> +    if (ret < 0) {
>>>>> +        pm_runtime_set_suspended(dwc->dev);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>>        spin_lock_irqsave(&dwc->lock, flags);
>>>>>        /*
>>>>>         * If the link is in U3, signal for remote wakeup and wait for the
>>>>> @@ -2438,6 +2450,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>>>>            ret = __dwc3_gadget_wakeup(dwc, false);
>>>>>            if (ret) {
>>>>>                spin_unlock_irqrestore(&dwc->lock, flags);
>>>>> +            pm_runtime_put_noidle(dwc->dev);
>>>>>                return -EINVAL;
>>>>>            }
>>>>>            dwc3_resume_gadget(dwc);
>>>>> @@ -2452,6 +2465,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>>>>            dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
>>>>>          spin_unlock_irqrestore(&dwc->lock, flags);
>>>>> +    pm_runtime_put_noidle(dwc->dev);
>>>>>          return ret;
>>>>>    }
>>>>> @@ -2732,21 +2746,23 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>        /*
>>>>>         * Avoid issuing a runtime resume if the device is already in the
>>>>>         * suspended state during gadget disconnect.  DWC3 gadget was already
>>>>> -     * halted/stopped during runtime suspend.
>>>>> +     * halted/stopped during runtime suspend except for bus suspend case
>>>>> +     * where we would have skipped the controller halt.
>>>>>         */
>>>>>        if (!is_on) {
>>>>>            pm_runtime_barrier(dwc->dev);
>>>>> -        if (pm_runtime_suspended(dwc->dev))
>>>>> +        if (pm_runtime_suspended(dwc->dev) && !dwc->connected)
>>>>
>>>> dwc->connected will to to false on disconnect. I'm not sure if we can rely
>>>> on this flag here.
>>>>
>>> This is for handling gadget_pullup() when we are in bus suspend state (and thus runtime suspended) for cases where a usb composition switch is triggered. Like explained above we dont clear dwc->connected flag without resuming the driver first.
>>>
>>>>>                return 0;
>>>>>        }
>>>>>          /*
>>>>>         * Check the return value for successful resume, or error.  For a
>>>>>         * successful resume, the DWC3 runtime PM resume routine will handle
>>>>> -     * the run stop sequence, so avoid duplicate operations here.
>>>>> +     * the run stop sequence except for bus resume case, so avoid
>>>>> +     * duplicate operations here.
>>>>>         */
>>>>>        ret = pm_runtime_get_sync(dwc->dev);
>>>>> -    if (!ret || ret < 0) {
>>>>> +    if ((!ret && !dwc->connected) || ret < 0) {
>>>>
>>>> Why this check?
>>>>
>>> In the resume operation above we would have skipped setting the run stop bit and other operations for bus suspend scenario. Hence we are not bailing out here if dwc->connected is true (which indicates that the resume operation was for cable connected case)
>>
>> I think we are over-complicating the simple pullup() function.
>> How about not skipping setting the necessary bits in bus suspend case?
> 
> We cannot clear the RUN_STOP bit during bus suspend as that would stop the controller and disconnect from the bus. (I believe the exception would be if HIBERNATION feature is enabled on dwc3 IP).
> 
> I am failing to see the complication here.
> The current implementation is to skip the run stop sequence in pullup() function if resume is triggered. The addition here is, not to skip the run stop sequence in pullup() if resume is triggered in bus suspend context.
> 
>>>
>>>>>            pm_runtime_put(dwc->dev);
>>>>>            if (ret < 0)
>>>>>                pm_runtime_set_suspended(dwc->dev);
>>>>> @@ -4331,6 +4347,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
>>>>>        }
>>>>>          dwc->link_state = next;
>>>>> +    pm_runtime_mark_last_busy(dwc->dev);
>>>>> +    pm_request_autosuspend(dwc->dev);
>>>>
>>>> Not here. You should do this in dwc3_suspend_gadget() after gadget driver
>>>> has completed suspend.
>>>>
>>>
>>> Since the goal was to trigger runtime suspend when bus suspend irq is received I have added it here. I see that dwc3_suspend_gadget is called in other instances as well (like U1,U2) and hence having it here specific to U3/L2 handler is better IMO.
>>
>> OK.
>>
>>>>>    }
>>>>>      static void dwc3_gadget_interrupt(struct dwc3 *dwc,
>>>>> @@ -4718,7 +4736,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>>>>    {
>>>>>        if (dwc->pending_events) {
>>>>>            dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>>>> +        pm_runtime_put(dwc->dev);
>>>>
>>>> Why the put here?
>>>>
>>>
>>> To balance the get() called when setting the pending_events flag in dwc3_check_event_buf()
>>>
>>>      if (pm_runtime_suspended(dwc->dev)) {
>>>          pm_runtime_get(dwc->dev);
>>>          disable_irq_nosync(dwc->irq_gadget);
>>>          dwc->pending_events = true;
>>>          return IRQ_HANDLED;
>>>      }
>>>
>>
>> No this wrong. We want the device to be active from now on.
>>
>> runtime suspended->interrupt->pm_runtime_get->runtime_resume->process_pending_events->USB gadget resumed
>>
>> Only on next USB suspend you want to do the pm_runtime_put like you are doing it
>> in dwc3_gadget_suspend_interrupt() by pm_request_autosuspend()
>>
> 
> That would break/block dwc3 runtime suspend during DISCONNECT case in below scenario
> 
> runtime suspended->interrupt->pm_runtime_get (runtime usage count is 1)->runtime_resume->process_pending_events->USB gadget resumed -> USB disconnect (autosuspend blocked due to runtime usage count being 1 due to unbalanced get() ).
> 
> The idea here is to balance the get() that was requested for processing the pending events, after processing those events. (like how we balance get() of ep_queue through put() in ep_dequeue)
> 
> Also pm_request_autosuspend() doesnt decrement the usage count, it only requests for autosuspend.

Ah, indeed.

> 
> But I think better approach in terms of ordering is below

ok, but should dwc->pending_events be set before calling pm_runtime_get() in dwc3_check_event_buf()?
Can we add a comment there that the get will be balanced out in dwc3_gadget_process_pending_events()?

> 
> @@ -4718,7 +4736,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>  {
>      if (dwc->pending_events) {
>          dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
> +        /*
> +         * We have only stored the pending events as part
> +         * of dwc3_interrupt() above, but those events are
> +         * not yet handled. So explicitly invoke the
> +         * interrupt handler for handling those events.
> +         */
> +        dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>          dwc->pending_events = false;
>          enable_irq(dwc->irq_gadget);
> +        pm_runtime_put(dwc->dev);

We could do the put right after dwc3_thread_interrupt().

> 
>      }
>  }

I think this fix should be an independent patch
as this fixes an issue that existed prior to this series?
also need to -cc stable?

-- 
cheers,
-roger
