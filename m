Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345087513D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGLW50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGLW5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:57:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32E711D;
        Wed, 12 Jul 2023 15:57:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMcJlS025906;
        Wed, 12 Jul 2023 22:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pBUnbduWuA2+rqSjwuZCT+knBEO9r7qSKf+rlcikNlc=;
 b=itiCQ55SxCbJ8tOgS/WLAfcGVhJXTXZbPxVTk/ctejLU4gct03NtnHxtQ7FHAtQ1SIF1
 jOL9ZhvSBom5ja6zbHcx/ZNfDN8jOoCix/2+TTVOSIEHLJkd+k7pVbGF2FBosPTToHGI
 FzaIvVMZB/YJbGCANVRAo2u/9v33tQ1CSCdKrUxLtj/nQq4Vf2oDGADrcC7zlyJyiTRE
 WyqAhKKzQJETiZ1N6vaSVjBelwEik4Fmsgk/dZp56fyid9F/7LsboVdkeTReaq0whVd1
 T9TZKTTmpSx3mo/D+WDSJypfGsJINGImW6NLOxXCzLRNVzvA79keqMsAqHLBFUP5Mhb/ mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rse45jvvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 22:57:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CMvAdw027443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 22:57:10 GMT
Received: from [10.110.62.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 15:57:09 -0700
Message-ID: <3c9c6924-bf79-e8bb-fd44-9262f114504b@quicinc.com>
Date:   Wed, 12 Jul 2023 15:57:07 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <9fc752db-ea8a-4bf0-a99a-832403668384@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nj5rzGECJO1ichLIT1eikVLs-FZxeNrI
X-Proofpoint-ORIG-GUID: nj5rzGECJO1ichLIT1eikVLs-FZxeNrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120202
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 6:46 AM, Roger Quadros wrote:
> 
> 
> On 11/07/2023 20:43, Elson Roy Serrao wrote:
>> The current implementation blocks the runtime pm operations when cable
>> is connected. This would block platforms from entering system wide suspend
>> during bus suspend scenario. Modify the runtime pm ops to handle bus
>> suspend case for such platforms where the controller low power mode
>> entry/exit is handled by the glue driver. This enablement is controlled
>> through a dt property and platforms capable of detecting bus resume can
>> benefit from this feature. Also modify the remote wakeup operations to
>> trigger runtime resume before sending wakeup signal.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 26 ++++++++++++++++++++++---
>>   drivers/usb/dwc3/core.h   |  3 +++
>>   drivers/usb/dwc3/gadget.c | 40 ++++++++++++++++++++++++++++++++-------
>>   3 files changed, 59 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index f6689b731718..898c0f68e190 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1534,6 +1534,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>   	dwc->dis_split_quirk = device_property_read_bool(dev,
>>   				"snps,dis-split-quirk");
>>   
>> +	dwc->allow_rtsusp_on_u3 = device_property_read_bool(dev,
>> +				"snps,allow-rtsusp-on-u3");
>> +
>>   	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>   	dwc->tx_de_emphasis = tx_de_emphasis;
>>   
>> @@ -1984,11 +1987,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   {
>>   	unsigned long	flags;
>>   	u32 reg;
>> +	int link_state;
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>>   		if (pm_runtime_suspended(dwc->dev))
>>   			break;
>> +
>> +		if (dwc->connected) {
>> +			link_state = dwc3_gadget_get_link_state(dwc);
>> +			/* bus suspend case */
>> +			if (dwc->allow_rtsusp_on_u3 &&
>> +			    link_state == DWC3_LINK_STATE_U3> +				break;
> 
> dwc3_suspend_common() is called both during runtime suspend and system sleep with
> appropriate pm_msg_t argument.
> Do you want the same behavior for both cases?
> 
Thank you for your comments and feedback.
The goal here is to trigger runtime suspend when bus suspend interrupt 
is received. If dwc3 runtime suspend is executed, then for system sleep 
dwc3_suspend_common() is a no-op as we have a 
pm_runtime_suspended(dwc->dev) check in place in the above code.
The exception I can think of with these changes in place is below sequence
USB bus suspended---->Runtime suspend fails OR is not invoked for some 
reason--->System sleep is triggered.

We can extend this change to above case as well. I believe that was the 
intention of your patch (i.e avoid gadget disconnect if usb bus is 
suspended for system sleep case)
https://lore.kernel.org/linux-usb/20230320093447.32105-3-rogerq@kernel.org/

Please let me know your opinion on extending this series to system sleep 
also.


> You are not checking if the gadget driver was put into suspend state or not.
> So, instead of just checking line state, should we also check that we processed
> the suspend interrupt and gadget driver has been suspended as well?
> i.e. add a SW flag dwc3->suspended and set it at end of dwc3_suspend_gadget()
> and clear it at beginning of dwc3_resume_gadget().
> Check for that flag in the above if condition.
> i.e. if (dwc->connected && dwc->suspended)
>

We already have flags for these purposes (dwc->link_state and 
dwc->suspended) that we set when suspend interrupt is received and clear 
during wakeup. We can use these flags here

>> +			return -EBUSY;
>> +		}
>>   		dwc3_gadget_suspend(dwc);
>>   		synchronize_irq(dwc->irq_gadget);
>>   		dwc3_core_exit(dwc);
>> @@ -2045,6 +2058,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> +		/* bus resume case */
>> +		if (dwc->connected)
> 
> dwc->connected might get cleard to false if device was disconnected. So this is not reliable.
> You might want to set another SW flag to track this special case of suspend
> with controller kept active.
> 

Are you referring to the DISCONNECT interrupt ? We dont handle gadget 
interrupts when in runtime suspended state and dwc3 driver has to be 
resumed first. The mechanism for this already exists in 
dwc3_check_event_buf() like below

	if (pm_runtime_suspended(dwc->dev)) {
		pm_runtime_get(dwc->dev);
		disable_irq_nosync(dwc->irq_gadget);
		dwc->pending_events = true;
		return IRQ_HANDLED;
	}

I cant think of any scenario where dwc->connected is cleared before 
calling resume_common() for bus suspend case. Please let me know if I am 
missing any corner case.

>> +			break;
>>   		ret = dwc3_core_init_for_resume(dwc);
>>   		if (ret)
>>   			return ret;
>> @@ -2123,9 +2139,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>>   
>> -	if (dwc3_runtime_checks(dwc))
>> -		return -EBUSY;
>> -
> Instead of removing this how about modifying dwc3_runtime_checks(). see below.
>

Yes we can do that. But if we are planning to extend these changes to 
system sleep better to leave it here IMO.

>>   	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
>>   	if (ret)
>>   		return ret;
>> @@ -2160,9 +2173,15 @@ static int dwc3_runtime_resume(struct device *dev)
>>   static int dwc3_runtime_idle(struct device *dev)
>>   {
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>> +	int		link_state;
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> +		link_state = dwc3_gadget_get_link_state(dwc);
>> +		/* for bus suspend case return success */
>> +		if (dwc->allow_rtsusp_on_u3 && dwc->connected &&
>> +		    link_state == DWC3_LINK_STATE_U3)
>> +			goto autosuspend;
> 
> why not just break?
Done
> 
>>   		if (dwc3_runtime_checks(dwc))
> 
> what about this dwc3_runtime_checks()?
> Looks like the if condition you added above can go in dwc3_runtime_checks() instead.
> 
>>   			return -EBUSY;
>>   		break;
>> @@ -2172,6 +2191,7 @@ static int dwc3_runtime_idle(struct device *dev)
>>   		break;
>>   	}
>>   
>> +autosuspend:
>>   	pm_runtime_mark_last_busy(dev);
>>   	pm_runtime_autosuspend(dev);
>>   
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 8b1295e4dcdd..33b2ccbbd963 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1127,6 +1127,8 @@ struct dwc3_scratchpad_array {
>>    * @num_ep_resized: carries the current number endpoints which have had its tx
>>    *		    fifo resized.
>>    * @debug_root: root debugfs directory for this device to put its files in.
>> + * @allow_rtsusp_on_u3: true if dwc3 runtime suspend is allowed during bus
>> + *			suspend scenario.
> 
> what about system sleep?
> 
Currently this series is tested for runtime suspend during bus suspend 
scenario. We can extend to system sleep like explained above.

>>    */
>>   struct dwc3 {
>>   	struct work_struct	drd_work;
>> @@ -1343,6 +1345,7 @@ struct dwc3 {
>>   	int			last_fifo_depth;
>>   	int			num_ep_resized;
>>   	struct dentry		*debug_root;
>> +	bool			allow_rtsusp_on_u3;
>>   };
>>   
>>   #define INCRX_BURST_MODE 0
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 5fd067151fbf..0797cffa2d48 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2401,15 +2401,21 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>   		return -EINVAL;
>>   	}
>>   
>> -	spin_lock_irqsave(&dwc->lock, flags);
>>   	if (!dwc->gadget->wakeup_armed) {
>>   		dev_err(dwc->dev, "not armed for remote wakeup\n");
>> -		spin_unlock_irqrestore(&dwc->lock, flags);
>>   		return -EINVAL;
>>   	}
>> -	ret = __dwc3_gadget_wakeup(dwc, true);
>>   
>> +	ret = pm_runtime_resume_and_get(dwc->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_set_suspended(dwc->dev);
>> +		return ret;
>> +	}
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	ret = __dwc3_gadget_wakeup(dwc, true);
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	pm_runtime_put_noidle(dwc->dev);
>>   
>>   	return ret;
>>   }
>> @@ -2428,6 +2434,12 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		return -EINVAL;
>>   	}
>>   
>> +	ret = pm_runtime_resume_and_get(dwc->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_set_suspended(dwc->dev);
>> +		return ret;
>> +	}
>> +
>>   	spin_lock_irqsave(&dwc->lock, flags);
>>   	/*
>>   	 * If the link is in U3, signal for remote wakeup and wait for the
>> @@ -2438,6 +2450,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		ret = __dwc3_gadget_wakeup(dwc, false);
>>   		if (ret) {
>>   			spin_unlock_irqrestore(&dwc->lock, flags);
>> +			pm_runtime_put_noidle(dwc->dev);
>>   			return -EINVAL;
>>   		}
>>   		dwc3_resume_gadget(dwc);
>> @@ -2452,6 +2465,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
>>   
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	pm_runtime_put_noidle(dwc->dev);
>>   
>>   	return ret;
>>   }
>> @@ -2732,21 +2746,23 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>   	/*
>>   	 * Avoid issuing a runtime resume if the device is already in the
>>   	 * suspended state during gadget disconnect.  DWC3 gadget was already
>> -	 * halted/stopped during runtime suspend.
>> +	 * halted/stopped during runtime suspend except for bus suspend case
>> +	 * where we would have skipped the controller halt.
>>   	 */
>>   	if (!is_on) {
>>   		pm_runtime_barrier(dwc->dev);
>> -		if (pm_runtime_suspended(dwc->dev))
>> +		if (pm_runtime_suspended(dwc->dev) && !dwc->connected)
> 
> dwc->connected will to to false on disconnect. I'm not sure if we can rely
> on this flag here.
> 
This is for handling gadget_pullup() when we are in bus suspend state 
(and thus runtime suspended) for cases where a usb composition switch is 
triggered. Like explained above we dont clear dwc->connected flag 
without resuming the driver first.

>>   			return 0;
>>   	}
>>   
>>   	/*
>>   	 * Check the return value for successful resume, or error.  For a
>>   	 * successful resume, the DWC3 runtime PM resume routine will handle
>> -	 * the run stop sequence, so avoid duplicate operations here.
>> +	 * the run stop sequence except for bus resume case, so avoid
>> +	 * duplicate operations here.
>>   	 */
>>   	ret = pm_runtime_get_sync(dwc->dev);
>> -	if (!ret || ret < 0) {
>> +	if ((!ret && !dwc->connected) || ret < 0) {
> 
> Why this check?
> 
In the resume operation above we would have skipped setting the run stop 
bit and other operations for bus suspend scenario. Hence we are not 
bailing out here if dwc->connected is true (which indicates that the 
resume operation was for cable connected case)

>>   		pm_runtime_put(dwc->dev);
>>   		if (ret < 0)
>>   			pm_runtime_set_suspended(dwc->dev);
>> @@ -4331,6 +4347,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
>>   	}
>>   
>>   	dwc->link_state = next;
>> +	pm_runtime_mark_last_busy(dwc->dev);
>> +	pm_request_autosuspend(dwc->dev);
> 
> Not here. You should do this in dwc3_suspend_gadget() after gadget driver
> has completed suspend.
> 

Since the goal was to trigger runtime suspend when bus suspend irq is 
received I have added it here. I see that dwc3_suspend_gadget is called 
in other instances as well (like U1,U2) and hence having it here 
specific to U3/L2 handler is better IMO.
>>   }
>>   
>>   static void dwc3_gadget_interrupt(struct dwc3 *dwc,
>> @@ -4718,7 +4736,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>   {
>>   	if (dwc->pending_events) {
>>   		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>> +		pm_runtime_put(dwc->dev);
> 
> Why the put here?
>

To balance the get() called when setting the pending_events flag in 
dwc3_check_event_buf()

	if (pm_runtime_suspended(dwc->dev)) {
		pm_runtime_get(dwc->dev);
		disable_irq_nosync(dwc->irq_gadget);
		dwc->pending_events = true;
		return IRQ_HANDLED;
	}

>>   		dwc->pending_events = false;
>>   		enable_irq(dwc->irq_gadget);
>> +		/*
>> +		 * We have only stored the pending events as part
>> +		 * of dwc3_interrupt() above, but those events are
>> +		 * not yet handled. So explicitly invoke the
>> +		 * interrupt handler for handling those events.
>> +		 */
>> +		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>   	}
>>   }
> 
