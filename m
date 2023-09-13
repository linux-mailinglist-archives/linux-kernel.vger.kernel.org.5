Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7F79EAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjIMOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbjIMOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:20:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47812CD8;
        Wed, 13 Sep 2023 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694614814; x=1726150814;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5jPY8v6Vag2va/ECGzDgocqpjhEHew/KUS5KSoroMjk=;
  b=Cqws+xpRq552LLkHRWZbBbvs20iAMKD/idsez5LWbhZjCpS5pDPTZiNg
   89bZQTWWFHPrKHIZVNqAvAgBQf2lVzPgCH7qbpsVsWGYqW5Z+ASPArGSq
   gmxShBw3q+cwy+PQFOvNaTv4+WFVDq8QXv1I3VDCWoBixTqvqgQrKKGun
   /yNIJuntF6k6dsF4w+v5hAtISrZfvG7rBgtpTRldcqKRizDpRAdVtmaQ8
   L+2DGhOj5FtN8YEM9pAaOW0K1g+1NHRq0Wa4XXn6ZfoYwAjWa+3/eBC6t
   25jRNAP6b5nRm4THhZvShafITPtwxUlFO+XqgjrpkHBz9lHIuDubhPYXm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363705890"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363705890"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 07:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693853121"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693853121"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga003.jf.intel.com with ESMTP; 13 Sep 2023 07:20:11 -0700
Message-ID: <fa815665-5b50-87b9-eb21-535f1f883061@linux.intel.com>
Date:   Wed, 13 Sep 2023 17:21:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
References: <20230901001518.25403-1-quic_wcheng@quicinc.com>
 <8dd86cf5-6337-b8f5-34d5-dcd290dc2d38@linux.intel.com>
 <ee47814e-969b-a96c-9323-e47bbf89297e@quicinc.com>
 <d68aa806-b26a-0e43-42fb-b8067325e967@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
In-Reply-To: <d68aa806-b26a-0e43-42fb-b8067325e967@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 13.9.2023 0.51, Wesley Cheng wrote:
> Hi Mathias,
> 
>>> This is one way, but we can probably avoid re-reading all the usb3 portsc registers
>>> by checking if any bit is set in either:
>>>
>>>   // bitfield, set if xhci usb3 port neatly set to U3 with a hub request
>>> xhci->usb3_rhub.bus_state.suspended_ports
>>>
>>> // bitfield, set if xhci usb3 port is forced to U3 during xhci suspend.
>>> xhci->usb3_rhub.bus_state.bus_suspended
>>>
>>> But haven't checked this works in all corner cases.
>>>
>> Thanks for the suggestion.  I think I also looked at seeing if we could use the suspended_ports param, and it was missing one of the use cases we had.  I haven't thought on combining it with the bus_suspend param also to see if it could work.  Let me give it a try, and I'll get back to you.
>>
> 
> So in one of our normal use cases, which is to use an USB OTG adapter with our devices, we can have this connected with no device.  In this situation, the XHCI HCD and root hub are enumerated, and is in a state where nothing is connected to the port.  I added a print to the xhci_resume() path to check the status of "suspended_ports" and "bus_suspended" and they seem to reflect the same status as when there is something connected (to a device that supports autosuspend).  Here's some pointers I've found on why these parameters may not work:
> 
> 1.  bus_suspended is only set (for the bus) if we reach the bus_suspend() callback from USB HCD if the link is still in U0.  If USB autosuspend is enabled, then the suspending of the root hub udev, would have caused a call to suspend the port (usb_port_suspend()), and that would set "suspended_ports" and placed the link in U3 already.
> 
> 2. "suspended_ports" can't differentiate if a device is connected or not after plugging in a USB3 device that has autosuspend enabled.  It looks like on device disconnection, the suspended_ports isn't cleared for that port number.  It is only cleared during the resume path where a get port status is queried:
> 
> static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
>                        u32 portsc)
> {
> ...
>       /* USB3 specific wPortStatus bits */
>       if (portsc & PORT_POWER) {
>           *status |= USB_SS_PORT_STAT_POWER;
>           /* link state handling */
>           if (link_state == XDEV_U0)
>               bus_state->suspended_ports &= ~(1 << portnum);
>       }
> 
> IMO, this seems kind of weird, because the PLS shows that the port is in the RxDetect state, so it technically isn't suspended.  If you think we should clear suspended_ports on disconnect, then I think we can also change the logic to rely on it for avoiding the unnecessary delay in xhci_resume().

I think you found a bug.

We should clear suspended_ports bit if link state in portsc is anything other than U3, Resume or Recovery.

Not doing so might cause USB_PORT_STAT_C_SUSPEND bit to be set incorrectly in a USB2 get port status request.

So we want something like:
if (suspended_ports bit is set) {
	if (U3 || Resume || Recovery) {
		don't touch anything
	} else {
		clear suspended_port bit
		if ((U2 || U0) && USB2)
			set bus_state->port_c_suspend bit
}

I'll look into it

-Mathias

