Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30727D5ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjJXSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJXSmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:42:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75912C;
        Tue, 24 Oct 2023 11:42:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OIWRau025039;
        Tue, 24 Oct 2023 18:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uGHRv3zuutbStD7E9MlZNXiGhV3IMVGQQ/a4No1Mr2E=;
 b=OH6BGjQyGl+N4bgKZW2F9XyZXNIVRMsUO5bxNvNQlK7O32GQcJamz/Sz2Snj1jX64Kj0
 +HaS86V+V+9NTC7MHZP0bUW05XmKMEv+fKEV9z9m9jbUywpwDHnaOI8BWZF4W+mA7L1D
 yhgq1lqiQGv1x+oeO/L8+V9HesVRyVikfq8PYZ2ss5z6MHOdGQYg7bqS5YIbBlDVvNMt
 vxhq9beFsSJLwGzUhza/pfqUendvZ/xUaOHppPVqplTS47/Wm/RRwcNUDOWS0CH1Vjlf
 Qfdni6gud+3lv4zWxEG6Q8cY8/pJ1QH8R6pxSzXrO1dLrbZzLUTFiXZx9vDUnFFejJiG hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx7r81t01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 18:42:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39OIg3MO031347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 18:42:03 GMT
Received: from [10.110.113.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 11:42:03 -0700
Message-ID: <cd294a89-33e7-0569-81b3-df77a255f061@quicinc.com>
Date:   Tue, 24 Oct 2023 11:41:51 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <9be9fae5-f6f2-42fe-bd81-78ab50aafa06@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VU6LfGhr4GY0_tRn7IyMektX1o9WnNEj
X-Proofpoint-GUID: VU6LfGhr4GY0_tRn7IyMektX1o9WnNEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_18,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240160
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 3:14 AM, Roger Quadros wrote:
> Hi Elson,
> 
> On 14/08/2023 21:50, Elson Roy Serrao wrote:
>> The current implementation blocks the runtime pm operations when cable
>> is connected. This would block dwc3 to enter a low power state during
>> bus suspend scenario. Modify the runtime pm ops to handle bus suspend
>> case for such platforms where the controller low power mode entry/exit
>> is handled by the glue driver. This enablement is controlled through a
>> dt property and platforms capable of detecting bus resume can benefit
>> from this feature. Also modify the remote wakeup operations to trigger
>> runtime resume before sending wakeup signal.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 28 ++++++++++++++++++++++++++--
>>   drivers/usb/dwc3/core.h   |  3 +++
>>   drivers/usb/dwc3/gadget.c | 32 +++++++++++++++++++++++++-------
>>   3 files changed, 54 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 9c6bf054f15d..9bfd9bb18caf 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1518,6 +1518,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>   	dwc->dis_split_quirk = device_property_read_bool(dev,
>>   				"snps,dis-split-quirk");
>>   
>> +	dwc->runtime_suspend_on_usb_suspend = device_property_read_bool(dev,
>> +				"snps,runtime-suspend-on-usb-suspend");
>> +
>>   	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>>   	dwc->tx_de_emphasis = tx_de_emphasis;
>>   
>> @@ -2029,6 +2032,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> +		/* runtime resume on bus resume scenario */
>> +		if (PMSG_IS_AUTO(msg) && dwc->connected)
>> +			break;
>>   		ret = dwc3_core_init_for_resume(dwc);
>>   		if (ret)
>>   			return ret;
>> @@ -2090,8 +2096,13 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
>>   {
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> -		if (dwc->connected)
>> +		if (dwc->connected) {
>> +			/* bus suspend scenario */
>> +			if (dwc->runtime_suspend_on_usb_suspend &&
>> +			    dwc->suspended)
> 
> If dwc is already suspended why do we return -EBUSY?
> Should this be !dwc->suspended?
> 

Hi Roger

Thank you for reviewing.
If dwc->suspended is true (i.e suspend event due to U3/L2 is received), 
I am actually breaking from this switch statement and returning 0.

>> +				break;
>>   			return -EBUSY;
>> +		}
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_HOST:
>>   	default:
>> @@ -2107,9 +2118,22 @@ static int dwc3_runtime_suspend(struct device *dev)
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>>   
>> -	if (dwc3_runtime_checks(dwc))
>> +	ret = dwc3_runtime_checks(dwc);
>> +	if (ret)
>>   		return -EBUSY;
>>   
>> +	switch (dwc->current_dr_role) {
>> +	case DWC3_GCTL_PRTCAP_DEVICE:
>> +		/* bus suspend case */
>> +		if (!ret && dwc->connected)
> 
> No need to check !ret again as it will never happen because
> we are returning -EBUSY earlier if (ret);
> 
Thanks for this catch. I will remove !ret check in v5.

>> +			return 0;
>> +		break;
>> +	case DWC3_GCTL_PRTCAP_HOST:
>> +	default:
>> +		/* do nothing */
>> +		break;
>> +	}
>> +
> 
> While this takes care of runtime suspend case, what about system_suspend?
> Should this check be moved to dwc3_suspend_common() instead?
> 

Sure I can move these checks to dwc3_suspend_common to make it generic.
Will rename this patch to "Modify pm ops to handle bus suspend" since 
this is now not limited to only runtime suspend/resume. Will also rename 
dwc->runtime_suspend_on_usb_suspend to dwc->delegate_wakeup_interrupt 
based on earlier feedback.

I am still working on a clean way to enable/disable this feature (i.e 
set dwc->delegate_wakeup_interrupt flag) from the glue driver based on 
Thinh's feedback .
I will accommodate above feedback as well and upload v5.

Thanks
Elson
>>   	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index a69ac67d89fe..f2f788a6b4b5 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1124,6 +1124,8 @@ struct dwc3_scratchpad_array {
>>    * @num_ep_resized: carries the current number endpoints which have had its tx
>>    *		    fifo resized.
>>    * @debug_root: root debugfs directory for this device to put its files in.
>> + * @runtime_suspend_on_usb_suspend: true if dwc3 runtime suspend is allowed
>> + *			during bus suspend scenario.
>>    */
>>   struct dwc3 {
>>   	struct work_struct	drd_work;
>> @@ -1340,6 +1342,7 @@ struct dwc3 {
>>   	int			last_fifo_depth;
>>   	int			num_ep_resized;
>>   	struct dentry		*debug_root;
>> +	bool			runtime_suspend_on_usb_suspend;
>>   };
>>   
>>   #define INCRX_BURST_MODE 0
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 5fd067151fbf..978ce0e91164 100644
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
>>   		pm_runtime_put(dwc->dev);
>>   		if (ret < 0)
>>   			pm_runtime_set_suspended(dwc->dev);
>> @@ -4331,6 +4347,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
>>   	}
>>   
>>   	dwc->link_state = next;
>> +	pm_runtime_mark_last_busy(dwc->dev);
>> +	pm_request_autosuspend(dwc->dev);
>>   }
>>   
>>   static void dwc3_gadget_interrupt(struct dwc3 *dwc,
> 
