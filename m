Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78C79F378
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjIMVJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIMVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:09:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E19B;
        Wed, 13 Sep 2023 14:09:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DKoTWo006924;
        Wed, 13 Sep 2023 21:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Lbqq6WFsgoO1N9j1FW7OzsN+59oAcjFTOnvcO7zfshU=;
 b=KRsv6/yByL7N2TN4Jri09QHS3Df8mJZ3x5TnxO9xPos8bFlboH8bIaQFTjrBm+kicGFS
 HwK8/Y82b6ceNY4iME8nVyqX2310NAual7TwqgMHsunE7i8sg9G3dacUqbqtOi+gHuXT
 1v/wj8MZt+sXbzBjdUf5H1kIbYmukLensYcZtGWR8r/Xh/VD3mEhz61S0cHMHBR9D3Sr
 j48hjBuuJp9Nt9PsXws5I7MOl6hs9PrteKtyO+AzqfsllhCNjsBXdjvNQgaI3RIqc1WK
 9vhozZMati5ahxPLf/PoTESNKK/nfDzYkW1W4g9PpCtTAcOINSNmzSb3QSLf0bbfxv84 BQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8q2p9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 21:08:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38DL8XkH028113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 21:08:33 GMT
Received: from [10.71.114.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 14:08:32 -0700
Message-ID: <291f2270-5afc-7570-91cd-049c590b704f@quicinc.com>
Date:   Wed, 13 Sep 2023 14:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>
References: <20230901001518.25403-1-quic_wcheng@quicinc.com>
 <8dd86cf5-6337-b8f5-34d5-dcd290dc2d38@linux.intel.com>
 <ee47814e-969b-a96c-9323-e47bbf89297e@quicinc.com>
 <d68aa806-b26a-0e43-42fb-b8067325e967@quicinc.com>
 <fa815665-5b50-87b9-eb21-535f1f883061@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <fa815665-5b50-87b9-eb21-535f1f883061@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3ywC2N2-sm5XFRuVRTolKzNU0CBOXy_b
X-Proofpoint-GUID: 3ywC2N2-sm5XFRuVRTolKzNU0CBOXy_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_16,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=907 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 9/13/2023 7:21 AM, Mathias Nyman wrote:
> Hi
> 
> On 13.9.2023 0.51, Wesley Cheng wrote:
>> Hi Mathias,
>>
>>>> This is one way, but we can probably avoid re-reading all the usb3 
>>>> portsc registers
>>>> by checking if any bit is set in either:
>>>>
>>>>   // bitfield, set if xhci usb3 port neatly set to U3 with a hub 
>>>> request
>>>> xhci->usb3_rhub.bus_state.suspended_ports
>>>>
>>>> // bitfield, set if xhci usb3 port is forced to U3 during xhci suspend.
>>>> xhci->usb3_rhub.bus_state.bus_suspended
>>>>
>>>> But haven't checked this works in all corner cases.
>>>>
>>> Thanks for the suggestion.  I think I also looked at seeing if we 
>>> could use the suspended_ports param, and it was missing one of the 
>>> use cases we had.  I haven't thought on combining it with the 
>>> bus_suspend param also to see if it could work.  Let me give it a 
>>> try, and I'll get back to you.
>>>
>>
>> So in one of our normal use cases, which is to use an USB OTG adapter 
>> with our devices, we can have this connected with no device.  In this 
>> situation, the XHCI HCD and root hub are enumerated, and is in a state 
>> where nothing is connected to the port.  I added a print to the 
>> xhci_resume() path to check the status of "suspended_ports" and 
>> "bus_suspended" and they seem to reflect the same status as when there 
>> is something connected (to a device that supports autosuspend).  
>> Here's some pointers I've found on why these parameters may not work:
>>
>> 1.  bus_suspended is only set (for the bus) if we reach the 
>> bus_suspend() callback from USB HCD if the link is still in U0.  If 
>> USB autosuspend is enabled, then the suspending of the root hub udev, 
>> would have caused a call to suspend the port (usb_port_suspend()), and 
>> that would set "suspended_ports" and placed the link in U3 already.
>>
>> 2. "suspended_ports" can't differentiate if a device is connected or 
>> not after plugging in a USB3 device that has autosuspend enabled.  It 
>> looks like on device disconnection, the suspended_ports isn't cleared 
>> for that port number.  It is only cleared during the resume path where 
>> a get port status is queried:
>>
>> static void xhci_get_usb3_port_status(struct xhci_port *port, u32 
>> *status,
>>                        u32 portsc)
>> {
>> ...
>>       /* USB3 specific wPortStatus bits */
>>       if (portsc & PORT_POWER) {
>>           *status |= USB_SS_PORT_STAT_POWER;
>>           /* link state handling */
>>           if (link_state == XDEV_U0)
>>               bus_state->suspended_ports &= ~(1 << portnum);
>>       }
>>
>> IMO, this seems kind of weird, because the PLS shows that the port is 
>> in the RxDetect state, so it technically isn't suspended.  If you 
>> think we should clear suspended_ports on disconnect, then I think we 
>> can also change the logic to rely on it for avoiding the unnecessary 
>> delay in xhci_resume().
> 
> I think you found a bug.
> 
> We should clear suspended_ports bit if link state in portsc is anything 
> other than U3, Resume or Recovery.
> 
> Not doing so might cause USB_PORT_STAT_C_SUSPEND bit to be set 
> incorrectly in a USB2 get port status request.
> 
> So we want something like:
> if (suspended_ports bit is set) {
>      if (U3 || Resume || Recovery) {
>          don't touch anything
>      } else {
>          clear suspended_port bit
>          if ((U2 || U0) && USB2)
>              set bus_state->port_c_suspend bit
> }
> 
> I'll look into it
> 

Thanks, Mathias.  Will take some time to take a look as well since I 
have a reliable set up that observes this issue.  If you have any test 
code you might want to try, let me know!

Thanks
Wesley Cheng
