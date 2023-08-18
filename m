Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E9780C61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377036AbjHRNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbjHRNR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:17:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478502723;
        Fri, 18 Aug 2023 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692364637; x=1723900637;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=01GUnJdnsfSW3V/fRhcTMyz0P3VHw8bOSYw42JoVXSc=;
  b=AV7R5v4Iei65yjZNchiu0dTLIsT5igNHbQ44EnCkSaSJ6GU98+rRfU6L
   5aAjYnchzPUbQYd23PU9vPa/HD5p5LYMuBQ8PUqSiyeCK4SZFPdqG4cRp
   uepPxxDSN482ftjfkd1zcVsq9q+T8OA2ouKjbPtwcu8jfY/j6wCDsi60N
   Hex3I9gLRKDbH8e2M5Phm1nnafrR9kP+5zZyyUI5OtPJFimVuQf8xm8Zs
   jt7AzR5SlC3AVXsdxs8KaaBE01Z93IxpUEDMcmuf+N5q12GMVn8aBLMtJ
   vhn4Op2+urZhCo8hfT4mApRCPSkXIad13fjMfwmnswsZbUuRuYRAO0Fpn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373081511"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="373081511"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878686416"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2023 06:17:18 -0700
Message-ID: <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
Date:   Fri, 18 Aug 2023 16:18:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, stern@rowland.harvard.edu,
        yangyingliang@huawei.com
Cc:     jinpu.wang@ionos.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
In-Reply-To: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.8.2023 12.23, Hardik Gajjar wrote:
> xHCI driver starts the response timer after sending each
> command to the device. The default value of this timer is
> 5 seconds (XHCI_CMD_DEFAULT_TIMEOUT = HZ*5). This seems
> too high in time crtical use case.
> 
> This patch provides an API to change the default value of
> the timer from the vendor USB driver.
> 
> The default value will be XHCI_CMD_DEFAULT_TIMEOUT (5 sec)
> 
> Use case:
> According to the Smartphone integration certification
> requirement in the automotive, the phone connected via USB
> should complete enumeration and user space handshake
> within 3 sec.

The above incorrectly makes it sound as if the command timeout
timer causes the delay.

> 
> Reducing the response waiting time by setting the smaller
> command timer delay helps to speed up overall re-enumeration
> process of the USB device in case of device is not responding
> properly in first enumeration iteration.

So is this a case where addressing a usb device behind xHC always
fail on the first attempt, i.e. address device command in xhci
never completes. Solution proposed here is to fail faster and
retry?

Is the rootcause known why first enumeration fails?

Does setting old_scheme_first module parameter help?

> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
>   drivers/usb/core/hcd.c       | 23 +++++++++++++++++++++++
>   drivers/usb/host/xhci-ring.c | 10 +++++-----
>   drivers/usb/host/xhci.c      | 15 +++++++++++++++
>   drivers/usb/host/xhci.h      |  1 +
>   include/linux/usb/hcd.h      |  2 ++
>   5 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 8300baedafd2..e392e90e918c 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -3157,6 +3157,29 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
>   }
>   EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);
>   
> +/**
> + * usb_hcd_set_cmd_timer_delay Set the delay of the command timer.
> + * @hcd - pointer to the HCD representing the controller
> + * @delay - Delay value to be used in command timer.
> + *
> + * wrapper function to call the set_cmd_timer_delay API of the host
> + * diver.
> + *
> + * return 0 on success; otherwise -ENODEV means the feature not
> + * supported by host driver.
> + */
> +
> +int usb_hcd_set_cmd_timer_delay(struct usb_hcd *hcd, int delay)
> +{
> +	int ret = -ENODEV;
> +
> +	if (hcd->driver->set_cmd_timer_delay)
> +		ret = hcd->driver->set_cmd_timer_delay(hcd, delay);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_hcd_set_cmd_timer_delay);
> +

The xhci command timeout is more of a xhci internal thing, not sure it's a good
idea to add this to hcd.

Would it make sense to add a timeout parameter to hcd->driver->address_device(hcd, udev)
instead?

First priority should of course be finding out why the first enumeration fails,
and solve that.

Thanks
Mathias
