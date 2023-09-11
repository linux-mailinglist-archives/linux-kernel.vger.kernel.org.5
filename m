Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D79C078
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjIKUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjIKNsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:48:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7BF5;
        Mon, 11 Sep 2023 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694440128; x=1725976128;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=wqZlIdVI4T0TpZRqJhEz2BDkX20ZxKYMOyFZIF+vbyk=;
  b=V+bQrxEnAY5I0ZjkFLkOAFFlVMvlz3i5xwXzeXkVeLr2VNI63QuTaoOj
   eYip7ma1BuB/f6t7d2A97T75yy6ugZvKSZM9WBTDQ4fhYAiiAWvBlbk9J
   i+SyhYZojAwzlTom4a5D1DBFGrQS3mCRSMxtcGl4wmRYalnO5AOLb7TdA
   MOJpZmR27mEjyt4fR9Yud5f974oEMd0aqtnmiY0kSarN5Mm/h6HhB0GYb
   kXNRUTpw9XXERzcSJyyYIiiJOSqriOEw56ss8DPf8IVeYCfi6MKvXcGWH
   Y5Ou+eE+GpihgqACLRETp0nTi3CfZSOPHB0HJ6nBBbHSGzyLrjTLW0jVh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363116199"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363116199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="719990925"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="719990925"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2023 06:48:41 -0700
Message-ID: <8dd86cf5-6337-b8f5-34d5-dcd290dc2d38@linux.intel.com>
Date:   Mon, 11 Sep 2023 16:50:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
References: <20230901001518.25403-1-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
In-Reply-To: <20230901001518.25403-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.9.2023 3.15, Wesley Cheng wrote:
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

Thanks, makes sense

> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..640db6a4e686 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -805,6 +805,24 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
>   	spin_unlock_irqrestore(&xhci->lock, flags);
>   }
>   
> +static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
> +{
> +	struct xhci_port	**ports;
> +	int			port_index;
> +	u32			portsc;
> +
> +	port_index = xhci->usb3_rhub.num_ports;
> +	ports = xhci->usb3_rhub.ports;
> +
> +	while (port_index--) {
> +		portsc = readl(ports[port_index]->addr);
> +		if (portsc & (portsc & PORT_CONNECT))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

This is one way, but we can probably avoid re-reading all the usb3 portsc registers
by checking if any bit is set in either:

  // bitfield, set if xhci usb3 port neatly set to U3 with a hub request
xhci->usb3_rhub.bus_state.suspended_ports

// bitfield, set if xhci usb3 port is forced to U3 during xhci suspend.
xhci->usb3_rhub.bus_state.bus_suspended

But haven't checked this works in all corner cases.

Thanks
Mathias

