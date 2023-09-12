Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02379C1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjILBmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjILBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:42:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E31F83BC;
        Mon, 11 Sep 2023 18:18:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C09p9A014873;
        Tue, 12 Sep 2023 00:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Tr3IY+C45LoAz3w3IC6elbtVdxcGxATFiWxbw0mPWA0=;
 b=QDCV+YTbbqa+ygA8FgU/2AoRTLDEMAbti2oW4dZdsr6pD20/sijs36DUCAKstGpzPAh8
 v5G3NIKRD0ZQgyiHw3fNUYlYgE3zt5amuZaTnrHPX18baxrl0BV1TGxqVuXRNFH8yrQp
 J5j1fn6Z9ASzVUP5EFJIqrhnkD4ik0184R6I+RN2WM6GrwMxO//N2RudjTXnmCGfuVAr
 sa8snhVOvp618x2ApKZ2iME7S2rEzDH/LzbigpGsCxbab6/sTYA+FzVA9O0A7U+zdrXY
 rFaxKr3nCdeW5wIoTs4hCfpoVWDMoEYJPuCeWBoPveS8lKelF3XJedC/0HQbMJo+jewU Hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t268fgyq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 00:15:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C0FZvn007683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 00:15:35 GMT
Received: from [10.110.43.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 17:15:34 -0700
Message-ID: <ee47814e-969b-a96c-9323-e47bbf89297e@quicinc.com>
Date:   Mon, 11 Sep 2023 17:15:34 -0700
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
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <8dd86cf5-6337-b8f5-34d5-dcd290dc2d38@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PlwYVLTm0vguPwpHqGQ1qCPCtIXToy2p
X-Proofpoint-ORIG-GUID: PlwYVLTm0vguPwpHqGQ1qCPCtIXToy2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=790 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 9/11/2023 6:50 AM, Mathias Nyman wrote:
> On 1.9.2023 3.15, Wesley Cheng wrote:
>> There is a 120ms delay implemented for allowing the XHCI host 
>> controller to
>> detect a U3 wakeup pulse.  The intention is to wait for the device to 
>> retry
>> the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link 
>> status
>> by the time it is checked.  As per the USB3 specification:
>>
>>    tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")
>>
>> This would allow the XHCI resume sequence to determine if the root hub
>> needs to be also resumed.  However, in case there is no device connected,
>> or if there is only a HSUSB device connected, this delay would still 
>> affect
>> the overall resume timing.
>>
>> Since this delay is solely for detecting U3 wake events (USB3 specific)
>> then ignore this delay for the disconnected case and the HSUSB connected
>> only case.
> 
> Thanks, makes sense
> 
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/host/xhci.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index e1b1b64a0723..640db6a4e686 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -805,6 +805,24 @@ static void xhci_disable_hub_port_wake(struct 
>> xhci_hcd *xhci,
>>       spin_unlock_irqrestore(&xhci->lock, flags);
>>   }
>> +static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
>> +{
>> +    struct xhci_port    **ports;
>> +    int            port_index;
>> +    u32            portsc;
>> +
>> +    port_index = xhci->usb3_rhub.num_ports;
>> +    ports = xhci->usb3_rhub.ports;
>> +
>> +    while (port_index--) {
>> +        portsc = readl(ports[port_index]->addr);
>> +        if (portsc & (portsc & PORT_CONNECT))
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
> 
> This is one way, but we can probably avoid re-reading all the usb3 
> portsc registers
> by checking if any bit is set in either:
> 
>   // bitfield, set if xhci usb3 port neatly set to U3 with a hub request
> xhci->usb3_rhub.bus_state.suspended_ports
> 
> // bitfield, set if xhci usb3 port is forced to U3 during xhci suspend.
> xhci->usb3_rhub.bus_state.bus_suspended
> 
> But haven't checked this works in all corner cases.
> 
Thanks for the suggestion.  I think I also looked at seeing if we could 
use the suspended_ports param, and it was missing one of the use cases 
we had.  I haven't thought on combining it with the bus_suspend param 
also to see if it could work.  Let me give it a try, and I'll get back 
to you.

Thanks
Wesley Cheng
