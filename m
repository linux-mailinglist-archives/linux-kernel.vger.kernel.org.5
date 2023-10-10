Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4577BFE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJJNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjJJNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:52:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F6D4A;
        Tue, 10 Oct 2023 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945404; x=1728481404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8GzamgwMi9wu+H60ATttaaxd7JDaPmhsJATl/qWfVDo=;
  b=T66D2HUaZIwr1VFrV6ozV9pH0TuLJSmHnC1hHkOhvl173lZtvu80h/28
   EP/8aft27POeYFzOgZUtbkigJL3F+UFqQa/71rg7JAQqk8JL+aLHndzCO
   MrJBiaM8rGFjzsCI+nwnBzkmPKmKb1vvb2W/Kq6qhoZ2ypzkKgmsrqaRs
   ndX+7ca/azWvsU1RIRmRDYRI0HUwQyHuYQVHoBtSEtW/cNBuC8AlWdf95
   sh+bYls2x5LC9tEyoXItvQyVH+Wc6HplS1LvS9cN3sV9uRUr82+yvUFgs
   tZP+NMJ9EKKPBZpFPNfgKoejdtjm1zNW74kR+cUzpIbBbjlRE3EkxSTAR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="450894968"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450894968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="869697333"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="869697333"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2023 06:38:51 -0700
Message-ID: <6b26db15-89a0-d455-5740-9abb1befa3a8@intel.com>
Date:   Tue, 10 Oct 2023 16:40:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2] usb: core: hub: Add quirks for reducing device address
 timeout
Content-Language: en-US
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
References: <--in-reply-to=20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231009161402.104224-1-hgajjar@de.adit-jv.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <20231009161402.104224-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.10.2023 19.14, Hardik Gajjar wrote:
> Currently, the timeout for the set address command is fixed at
> 5 seconds in the xhci driver. This means the host waits up to 5
> seconds to receive a response for the set_address command from
> the device.
> 
> In the automotive context, most smartphone enumerations, including
> screen projection, should ideally complete within 3 seconds.
> Achieving this is impossible in scenarios where the set_address is
> not successful and waits for a timeout.
> 
> The shortened address device timeout quirks provide the flexibility
> to align with a 3-second time limit in the event of errors.
> By swiftly triggering a failure response and swiftly initiating
> retry procedures, these quirks ensure efficient and rapid recovery,
> particularly in automotive contexts where rapid smartphone enumeration
> and screen projection are vital.
> 
> The quirk will set the timeout to 500 ms from 5 seconds.
> 
> To use the quirk, please write "vendor_id:product_id:p" to
> /sys/bus/usb/drivers/hub/module/parameter/quirks
> 
> For example,
> echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameter/quirks"
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- implement quirk instead of new API in xhci driver
> ---
>   drivers/usb/core/hub.c       | 15 +++++++++++++--
>   drivers/usb/core/quirks.c    |  3 +++
>   drivers/usb/host/xhci-mem.c  |  1 +
>   drivers/usb/host/xhci-ring.c |  3 ++-
>   drivers/usb/host/xhci.c      |  9 +++++----
>   drivers/usb/host/xhci.h      |  1 +
>   include/linux/usb/hcd.h      |  3 ++-
>   include/linux/usb/quirks.h   |  3 +++
>   8 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3c54b218301c..975449b03426 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -54,6 +54,9 @@
>   #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
>   #define USB_PING_RESPONSE_TIME		400	/* ns */
>   
> +#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT		(HZ * 5) /* 5000ms */
> +#define USB_SHORT_ADDR_DEVICE_TIMEOUT		125  /* ~500ms */

maybe use milliseconds directly
define USB_DEFAULT_ADDR_DEVICE_TIMEOUT		5000	/* ms */
...

> +
>   /* Protect struct usb_device->state and ->children members
>    * Note: Both are also protected by ->dev.sem, except that ->state can
>    * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
> @@ -4626,8 +4629,16 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
>   static int hub_set_address(struct usb_device *udev, int devnum)
>   {
>   	int retval;
> +	int timeout = USB_DEFAULT_ADDR_DEVICE_TIMEOUT;
>   	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>   
> +	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
> +
> +	if (hub->hdev->quirks & USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT)
> +		timeout = USB_SHORT_ADDR_DEVICE_TIMEOUT;
> +
> +	dev_dbg(&udev->dev, "address_device timeout %d\n", timeout);
> +
>   	/*
>   	 * The host controller will choose the device address,
>   	 * instead of the core having chosen it earlier
> @@ -4639,11 +4650,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
>   	if (udev->state != USB_STATE_DEFAULT)
>   		return -EINVAL;
>   	if (hcd->driver->address_device)
> -		retval = hcd->driver->address_device(hcd, udev);
> +		retval = hcd->driver->address_device(hcd, udev, timeout);
>   	else
>   		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
>   				USB_REQ_SET_ADDRESS, 0, devnum, 0,
> -				NULL, 0, USB_CTRL_SET_TIMEOUT);
> +				NULL, 0, jiffies_to_msecs(timeout));
>   	if (retval == 0) {
>   		update_devnum(udev, devnum);
>   		/* Device now using proper address. */
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 15e9bd180a1d..01ed26bd41f0 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>   			case 'o':
>   				flags |= USB_QUIRK_HUB_SLOW_RESET;
>   				break;
> +			case 'p':
> +				flags |= USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT;
> +				break;
>   			/* Ignore unrecognized flag characters */
>   			}
>   		}
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 8714ab5bf04d..492433fdac77 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1729,6 +1729,7 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
>   	}
>   
>   	command->status = 0;
> +	command->timeout = 0;

This could be command->timeout = XHCI_CMD_DEFAULT_TIMEOUT_MS;
For address device commands we then  override it later in xhci_setup_device()

The default xhci command timeout could be changed to 5000ms instead of 5 * HZ,
so in xhci.h:

/* Default xhci command timeout in milliseconds */
XHCI_CMD_DEFAULT_TIMEOUT_MS	5000

>   	INIT_LIST_HEAD(&command->cmd_list);
>   	return command;
>   }
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 1dde53f6eb31..0bd19a1efdec 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -4301,7 +4301,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
>   	/* if there are no other commands queued we start the timeout timer */
>   	if (list_empty(&xhci->cmd_list)) {
>   		xhci->current_cmd = cmd;
> -		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
> +		xhci_mod_cmd_timer(xhci, (cmd->timeout) ? cmd->timeout :
> +				XHCI_CMD_DEFAULT_TIMEOUT);

xhci_mod_cmd_timer(xhci, cmd->timeout);

We would then also need to convert ms to jiffies in xhci_mod_cmd_timer():

return mod_delayed_work(system_wq, &xhci->cmd_timer, msecs_to_jiffies(delay));


>   	}
>   
>   	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..1d088ceb2b74 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4002,7 +4002,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>    * SetAddress request to the device.
>    */
>   static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
> -			     enum xhci_setup_dev setup)
> +			     enum xhci_setup_dev setup, int timeout)
  
Hmm, I know usb_control_msg() uses int for timeout, but unsigned int would seem more
appropriate.

Same for xhci_address_device() and xhci_enable_device()

>   {
>   	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
>   	unsigned long flags;
> @@ -4059,6 +4059,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>   	}
>   
>   	command->in_ctx = virt_dev->in_ctx;
> +	command->timeout = timeout;
>   
>   	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
>   	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
> @@ -4185,14 +4186,14 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>   	return ret;
>   }
>   
> -static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
> +static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev, int timeout)
>   {
> -	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
> +	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout);
>   }
>   
>   static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
>   {
> -	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
> +	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY, 0);

return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY, XHCI_CMD_DEFAULT_TIMEOUT_MS);

>   }
>   
>   /*
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 7e282b4522c0..ebdca8dd01c2 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -818,6 +818,7 @@ struct xhci_command {
>   	struct completion		*completion;
>   	union xhci_trb			*command_trb;
>   	struct list_head		cmd_list;
> +	int				timeout;

unsigned int?

Thanks
Mathias

