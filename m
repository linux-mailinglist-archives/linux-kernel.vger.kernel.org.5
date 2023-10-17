Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F27CC3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjJQMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjJQMtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:49:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD795;
        Tue, 17 Oct 2023 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697546962; x=1729082962;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Vz3NwthM2agmUBZ7iXJuVbQIzPOwBgb/lOJg8aBciBU=;
  b=ITy8woyfnXVsWfzhNuc1XnbiGiKNvnkIyzctALCZFgSmvovpqSA59kWo
   F1l8g8TV+VMmuzyCWEb7F0KFaX1ONa6K17yBoxvCak4s0Pxw0bS9mPoLh
   mJhulnv5nMevl2Lqaatx/oOMFFq8dl6bIGFVx4uD0GV+4FAwQSCmGUEnB
   m0WrAGYtfA2cgpy9ZHdXnvEaidYhm6bf8gJT3TbgYDa8n6MQA5/QALdL1
   TSXgETwLkQU4qrmdNJ8iIkUCwdSTNVek9m5O95d7WN/0TINvFM+BuxdZy
   6yfG72tIfG7N3PgavmVE7J/WUgTgEmtMO+AR1K/t2ETtUKYowcnlJAbc3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385609331"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385609331"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872553522"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="872553522"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2023 05:49:20 -0700
Message-ID: <b5d81f1c-c33e-99f0-a05b-c00d43ff5c28@linux.intel.com>
Date:   Tue, 17 Oct 2023 15:50:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231011220740.32297-1-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
In-Reply-To: <20231011220740.32297-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2023 1.07, Wesley Cheng wrote:
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
> changes in v4:
> - Added change log between versions
> 
> changes in v3:
> - Modified logic to determine if a USB3.0 device is connected.  Using the suspended_ports
> and bus_suspended bitmasks.  suspended_port is non-zero as ports are runtime suspended,
> while bus_suspended is non-zero if system suspend occurs while ports are active.
> 
> changes in v2:
> - Looping across portsc to determine if there is a valid USB3 connection.
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

The function name xhci_usb3_dev_connected() is a bit misleading as it only returns
true if there are _suspended_ USB 3 devices connected.

I got rid of this helper and did some other minor modifications as well.
Modified version is in my for-usb-next branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=for-usb-next

Let me know if these changes are ok.
If yes, then I'll send it forward

Thanks
-Mathias

