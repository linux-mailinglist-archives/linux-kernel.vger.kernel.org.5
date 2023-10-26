Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F57D865B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbjJZQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:11 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E61A2;
        Thu, 26 Oct 2023 09:01:09 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.108) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 26 Oct
 2023 19:00:58 +0300
Subject: Re: [PATCH v6] usb: Reduce the 'SET_ADDRESS' request timeout with a
 new quirk
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>
References: <20231025164019.GA121292@vmlxhi-118.adit-jv.com>
 <20231026101551.36551-1-hgajjar@de.adit-jv.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cd598ae5-6eae-8e0b-8295-d98fa5c4b2fd@omp.ru>
Date:   Thu, 26 Oct 2023 19:00:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231026101551.36551-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.108]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 10/26/2023 15:43:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180928 [Oct 26 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.108 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.108 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.108
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/26/2023 15:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/26/2023 2:32:00 PM
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

   Please don't post the patches as a reply to the other thread, start a new
thread with a new patch version (I thought others would tell you that but nobody
has so far).
   And how about changing the wording of the subject to s/th like below?

usb: new quirk to reduce the SET_ADDRESS request timeout

On 10/26/23 1:15 PM, Hardik Gajjar wrote:

> This patch introduces a new USB quirk,
> USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT, which modifies the timeout value
> for the 'SET_ADDRESS' request. The standard timeout for USB request/command

   The upper case is enough of the emphasis, I don't think the apostrophes
are needed arounnd SET_ADDRESS...

[...]

> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
[...]
> Changes since version 5:
> 	- Changed the terminology in USB core driver files from 'command' to 'request'
> 	  as it is more commonly used. 
> 	  It's important to note that USB specifications indicate these terms are interchangeable.

   Didn't know that... tried to find the proof in the USB specs but haven't
managed to do it...

> 	  For example, USB spec 3.2, section 9.2.6.1, uses the term 'command' in its text
> 	  "USB sets an upper limit of 5 seconds for any command to be processed. "

   Hm, indeed; and this wording is even inherited from USB 1.1...

[...]

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 3c54b218301c..98db92af2cce 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -54,6 +54,19 @@
>  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
>  #define USB_PING_RESPONSE_TIME		400	/* ns */
>  
> +/*
> + * USB 3.2 spec, section 9.2.6.1
> + * USB sets an upper limit of 5000 ms for any command/request
> + * to be processed.
> + */
> +#define USB_DEFAULT_REQUEST_TIMEOUT_MS	5000 /* ms */
> +
> +/*
> + * The SET_ADDRESS request timeout will be 500 ms when
> + * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT enable.
> + */
> +#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT_MS	500  /* ms */

   I don'ts see the _MS-like suffixes in the other timeout #define's there...

[...]
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e1b1b64a0723..d856c4717ca9 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3997,12 +3997,18 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	return 0;
>  }
>  
> -/*
> - * Issue an Address Device command and optionally send a corresponding
> - * SetAddress request to the device.
> +/**
> + * xhci_setup_device - issues an Address Device command to assign a unique
> + *			USB bus address.
> + * @hcd: USB host controller data structure.
> + * @udev: USB dev structure representing the connected device.
> + * @setup: Enum specifying setup mode: address only or with context.
> + * @timeout_ms: Max wait time (ms) for the command operation to complete.
> + *
> + * Return: 0 if successful; otherwise, negative error code.

   I still think the above change should be a separate follow-up (or even
a preceding) patch...

[...]

MBR, Sergey
