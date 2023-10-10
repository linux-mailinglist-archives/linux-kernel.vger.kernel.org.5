Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9D7C0403
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjJJTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjJJTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:01:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE23894;
        Tue, 10 Oct 2023 12:01:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AIklF5027319;
        Tue, 10 Oct 2023 19:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xdbkijLx7schihxcpHXzfMjQ0oJH76kV0Llxrn0wbiA=;
 b=EofFRRIlKAef89uJzy+8jv6R8IVwo4Rapb6+VPsoMmnm6NpU8gWw6lbGYrYQDyq+wKxR
 Z/VVWIoUk/3LPKFWcQSCAdjfr/eYuGpgADfWhCNfx1oTKbHGjxgIjheT3sObKeF0BxbR
 n/6mTfLnu8RycJccGJVt4KqD9hm0h5C06kFLGC/qHb40I0SbsOSRnV31ZuLuxAaX7WYt
 5uY/IQgkIk3oCv9NWRHI7VPUmnHC9ILMOSrZaYifbAN22PXCxoFnBK6SZeBBrm75FxaH
 eOc+0C/IEE8PVmcmFZ9zeXkD+g5wBQy2MUQEooX1TLGAMgc5loWLctZQiEHqw3kKXmvq Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj0dbec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 19:01:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AJ1AEf019930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 19:01:11 GMT
Received: from [10.110.38.80] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 12:01:10 -0700
Message-ID: <5f491814-c105-64e3-93c0-5fff89160ac1@quicinc.com>
Date:   Tue, 10 Oct 2023 12:01:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Content-Language: en-US
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230919224327.29974-1-quic_wcheng@quicinc.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230919224327.29974-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7kclmkzjCDgjRTkdC0DV3R4ZWupEK-f
X-Proofpoint-ORIG-GUID: t7kclmkzjCDgjRTkdC0DV3R4ZWupEK-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_15,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=691 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100145
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping to see if there are any updates/feedback on this patch?

Thanks
Wesley Cheng

On 9/19/2023 3:43 PM, Wesley Cheng wrote:
> There is a 120ms delay implemented for allowing the XHCI host controller to
> detect a U3 wakeup pulse.  The intention is to wait for the device to retry
> the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
> by the time it is checked.  As per the USB3 specification:
> 
>    tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")
> 
> This would allow the XHCI resume sequence to determine if the root hub
> needs to be also resumed.  However, in case there is no device connected,
> or if there is only a HSUSB device connected, this delay would still affect
> the overall resume timing.
> 
> Since this delay is solely for detecting U3 wake events (USB3 specific)
> then ignore this delay for the disconnected case and the HSUSB connected
> only case.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
> Depends-on:
> https://lore.kernel.org/linux-usb/20230915143108.1532163-3-mathias.nyman@linux.intel.com/
> 
>   drivers/usb/host/xhci.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..1855cab1be56 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -805,6 +805,18 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
>   	spin_unlock_irqrestore(&xhci->lock, flags);
>   }
>   
> +/*
> + * Utilize suspended_ports and bus_suspended to determine if USB3 device is
> + * connected.  The bus state bits are set by XHCI hub when root hub udev is
> + * suspended.  Used to determine if USB3 remote wakeup considerations need to
> + * be accounted for during XHCI resume.
> + */
> +static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
> +{
> +	return !!xhci->usb3_rhub.bus_state.suspended_ports ||
> +		!!xhci->usb3_rhub.bus_state.bus_suspended;
> +}
> +
>   static bool xhci_pending_portevent(struct xhci_hcd *xhci)
>   {
>   	struct xhci_port	**ports;
> @@ -968,6 +980,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>   	int			retval = 0;
>   	bool			comp_timer_running = false;
>   	bool			pending_portevent = false;
> +	bool			usb3_connected = false;
>   	bool			reinit_xhc = false;
>   
>   	if (!hcd->state)
> @@ -1116,9 +1129,14 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>   		 * Resume roothubs only if there are pending events.
>   		 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
>   		 * the first wake signalling failed, give it that chance.
> +		 * Avoid this check if there are no devices connected to
> +		 * the SS root hub. (i.e. HS device connected or no device
> +		 * connected)
>   		 */
>   		pending_portevent = xhci_pending_portevent(xhci);
> -		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
> +		usb3_connected = xhci_usb3_dev_connected(xhci);
> +		if (!pending_portevent && usb3_connected &&
> +		     msg.event == PM_EVENT_AUTO_RESUME) {
>   			msleep(120);
>   			pending_portevent = xhci_pending_portevent(xhci);
>   		}
