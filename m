Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C97D7162
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjJYQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbjJYQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:00:20 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89482132;
        Wed, 25 Oct 2023 09:00:17 -0700 (PDT)
Received: from [192.168.1.103] (31.173.84.85) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 25 Oct
 2023 19:00:07 +0300
Subject: Re: [PATCH v5] usb: Reduce 'set_address' command timeout with a new
 quirk
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>
References: <de2ed64a-363a-464c-95be-584ce1a7a4ad@rowland.harvard.edu>
 <20231025141316.117514-1-hgajjar@de.adit-jv.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <41e22c23-07b3-5fd9-5fb1-935ab42fa83e@omp.ru>
Date:   Wed, 25 Oct 2023 19:00:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231025141316.117514-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.85]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 10/25/2023 15:39:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180895 [Oct 25 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.85 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;31.173.84.85:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.85
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/25/2023 15:44:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/25/2023 12:12:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/25/23 5:13 PM, Hardik Gajjar wrote:

   Sorry to be PITA but... (-:

> This patch introduces a new USB quirk, USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT,
> which modifies the timeout value for the 'set_address' command. The

   This is called a request, not a command by the spec. And the USB spec
names the requests in all uppercase, e.g. SET_ADDRESS...

> standard timeout for this command is 5000 ms, as recommended in the USB
> 3.2 specification (section 9.2.6.1).

   This section in the USB specs 1.1/2.0/3.0 talks about _all_ requests.
I don't have USB 3.2 but It believe it has the same wording.

[...]

> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
[...]

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..3c03f23bd5d5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6817,6 +6817,9 @@
>  					pause after every control message);
>  				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
>  					delay after resetting its port);
> +				p = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT (Timeout
> +					of set_address command reducing from

   Please, "The SET_ADDRESS request" instead...

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3c54b218301c..3594eeb892ac 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -54,6 +54,18 @@
>  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
>  #define USB_PING_RESPONSE_TIME		400	/* ns */
>  
> +/*
> + * address device command timeout 5000 ms is recommended in

   What address device command? Are you sure you're not mixing
the USB and xHCI terminologies?

> + * USB 3.2 spec, section 9.2.6.1
> + */
> +#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS	5000 /* ms */
> +
> +/*
> + * address device command timeout will be 500 ms when

   Same here. This is a generic USB file, not the xHCI driver...

> + * USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT enable.
> + */
> +#define USB_SHORT_ADDR_DEVICE_TIMEOUT_MS	500  /* ms */
> +
>  /* Protect struct usb_device->state and ->children members
>   * Note: Both are also protected by ->dev.sem, except that ->state can
>   * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
[...]
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..0c610a853aef 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3998,11 +3998,17 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  }
>  
>  /*

   You seem to be converting the existing comment to a kernel-doc one
but you miss changing from /* /** at the start and adding colons after
the param names below...

> - * Issue an Address Device command and optionally send a corresponding
> - * SetAddress request to the device.
> + * xhci_setup_device - issues an Address Device command to assign a unique
> + *			USB bus address.
> + * @hcd USB host controller data structure.
> + * @udev USB dev structure representing the connected device.
> + * @setup Enum specifying setup mode: address only or with context.
> + * @timeout_ms Max wait time (ms) for the command operation to complete.
> + *
> + * Return: 0 if successful; otherwise, negative error code.
>   */
>  static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
> -			     enum xhci_setup_dev setup)
> +			     enum xhci_setup_dev setup, unsigned int timeout_ms)
[...]

MBR, Sergey
