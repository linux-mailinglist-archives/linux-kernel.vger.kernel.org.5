Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5B79DB27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjILVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjILVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:52:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96B10CC;
        Tue, 12 Sep 2023 14:51:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CLlB4U009709;
        Tue, 12 Sep 2023 21:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eHXVCyPaKtscWd6OatiAUnCF33+lL86aGfQqeLeSQjQ=;
 b=jspYczqgdr8FRWQtUfr5uVlUcGTVhNCGsL7B8RojZstzm4n5iOt3A/mqJXK/4kfmRxES
 /RVAziO1NNz5KB/WRH0MWJW6tX0BmtmskCjrQ7asUUU96Lf4OVdW+aE8X8dMh/zwDgFa
 MtHPem79L3hli8MjAKLdkoSzeMex1sJ4LNnAMxkf9yKvNPSaesANZiv4YcKew4o/v0li
 lCaLgG5XtX6G/y/foks8PB+fKCQZGufaBv9UmtWI2cfk+jDcFqofIxR4NXrWJxdjzjue
 kh1M57IeuN4RINATU+zeq7ONNqopSa9AesKeFruhWR01gs6qmz7p3Yk8FRaSVAi3RvIK Aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7q83n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 21:51:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CLppCI011190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 21:51:51 GMT
Received: from [10.110.43.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 14:51:51 -0700
Message-ID: <d68aa806-b26a-0e43-42fb-b8067325e967@quicinc.com>
Date:   Tue, 12 Sep 2023 14:51:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>
References: <20230901001518.25403-1-quic_wcheng@quicinc.com>
 <8dd86cf5-6337-b8f5-34d5-dcd290dc2d38@linux.intel.com>
 <ee47814e-969b-a96c-9323-e47bbf89297e@quicinc.com>
In-Reply-To: <ee47814e-969b-a96c-9323-e47bbf89297e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LR4R7ND1D1UpC4D5TGvwaW9gMyTc8zFA
X-Proofpoint-ORIG-GUID: LR4R7ND1D1UpC4D5TGvwaW9gMyTc8zFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_21,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 9/11/2023 5:15 PM, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 9/11/2023 6:50 AM, Mathias Nyman wrote:
>> On 1.9.2023 3.15, Wesley Cheng wrote:
>>> There is a 120ms delay implemented for allowing the XHCI host 
>>> controller to
>>> detect a U3 wakeup pulse.  The intention is to wait for the device to 
>>> retry
>>> the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link 
>>> status
>>> by the time it is checked.  As per the USB3 specification:
>>>
>>>    tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")
>>>
>>> This would allow the XHCI resume sequence to determine if the root hub
>>> needs to be also resumed.  However, in case there is no device 
>>> connected,
>>> or if there is only a HSUSB device connected, this delay would still 
>>> affect
>>> the overall resume timing.
>>>
>>> Since this delay is solely for detecting U3 wake events (USB3 specific)
>>> then ignore this delay for the disconnected case and the HSUSB connected
>>> only case.
>>
>> Thanks, makes sense
>>
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   drivers/usb/host/xhci.c | 26 +++++++++++++++++++++++++-
>>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index e1b1b64a0723..640db6a4e686 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -805,6 +805,24 @@ static void xhci_disable_hub_port_wake(struct 
>>> xhci_hcd *xhci,
>>>       spin_unlock_irqrestore(&xhci->lock, flags);
>>>   }
>>> +static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
>>> +{
>>> +    struct xhci_port    **ports;
>>> +    int            port_index;
>>> +    u32            portsc;
>>> +
>>> +    port_index = xhci->usb3_rhub.num_ports;
>>> +    ports = xhci->usb3_rhub.ports;
>>> +
>>> +    while (port_index--) {
>>> +        portsc = readl(ports[port_index]->addr);
>>> +        if (portsc & (portsc & PORT_CONNECT))
>>> +            return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>
>> This is one way, but we can probably avoid re-reading all the usb3 
>> portsc registers
>> by checking if any bit is set in either:
>>
>>   // bitfield, set if xhci usb3 port neatly set to U3 with a hub request
>> xhci->usb3_rhub.bus_state.suspended_ports
>>
>> // bitfield, set if xhci usb3 port is forced to U3 during xhci suspend.
>> xhci->usb3_rhub.bus_state.bus_suspended
>>
>> But haven't checked this works in all corner cases.
>>
> Thanks for the suggestion.  I think I also looked at seeing if we could 
> use the suspended_ports param, and it was missing one of the use cases 
> we had.  I haven't thought on combining it with the bus_suspend param 
> also to see if it could work.  Let me give it a try, and I'll get back 
> to you.
> 

So in one of our normal use cases, which is to use an USB OTG adapter 
with our devices, we can have this connected with no device.  In this 
situation, the XHCI HCD and root hub are enumerated, and is in a state 
where nothing is connected to the port.  I added a print to the 
xhci_resume() path to check the status of "suspended_ports" and 
"bus_suspended" and they seem to reflect the same status as when there 
is something connected (to a device that supports autosuspend).  Here's 
some pointers I've found on why these parameters may not work:

1.  bus_suspended is only set (for the bus) if we reach the 
bus_suspend() callback from USB HCD if the link is still in U0.  If USB 
autosuspend is enabled, then the suspending of the root hub udev, would 
have caused a call to suspend the port (usb_port_suspend()), and that 
would set "suspended_ports" and placed the link in U3 already.

2. "suspended_ports" can't differentiate if a device is connected or not 
after plugging in a USB3 device that has autosuspend enabled.  It looks 
like on device disconnection, the suspended_ports isn't cleared for that 
port number.  It is only cleared during the resume path where a get port 
status is queried:

static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
				      u32 portsc)
{
...
  	/* USB3 specific wPortStatus bits */
  	if (portsc & PORT_POWER) {
  		*status |= USB_SS_PORT_STAT_POWER;
  		/* link state handling */
  		if (link_state == XDEV_U0)
  			bus_state->suspended_ports &= ~(1 << portnum);
  	}

IMO, this seems kind of weird, because the PLS shows that the port is in 
the RxDetect state, so it technically isn't suspended.  If you think we 
should clear suspended_ports on disconnect, then I think we can also 
change the logic to rely on it for avoiding the unnecessary delay in 
xhci_resume().

Thanks
Wesley Cheng
