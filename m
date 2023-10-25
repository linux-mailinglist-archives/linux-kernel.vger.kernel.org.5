Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100B7D71CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJYQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:40:29 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA08137;
        Wed, 25 Oct 2023 09:40:25 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 02BF95200CE;
        Wed, 25 Oct 2023 18:40:24 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Wed, 25 Oct
 2023 18:40:23 +0200
Date:   Wed, 25 Oct 2023 18:40:19 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v5] usb: Reduce 'set_address' command timeout with a new
 quirk
Message-ID: <20231025164019.GA121292@vmlxhi-118.adit-jv.com>
References: <de2ed64a-363a-464c-95be-584ce1a7a4ad@rowland.harvard.edu>
 <20231025141316.117514-1-hgajjar@de.adit-jv.com>
 <41e22c23-07b3-5fd9-5fb1-935ab42fa83e@omp.ru>
 <032f236a-e212-fa28-ecf4-b5b585ba7ac2@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <032f236a-e212-fa28-ecf4-b5b585ba7ac2@omp.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 07:16:05PM +0300, Sergey Shtylyov wrote:
> On 10/25/23 7:00 PM, Sergey Shtylyov wrote:
> 
> [...]
> >    Sorry to be PITA but... (-:
> 
>    I just had to speak up after Alan's ACK. :-)
No problem, Thanks for the feedback. I agreed with many of them
> 
> >> This patch introduces a new USB quirk, USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT,
> >> which modifies the timeout value for the 'set_address' command. The
> > 
> >    This is called a request, not a command by the spec. And the USB spec
> > names the requests in all uppercase, e.g. SET_ADDRESS...
> > 
> >> standard timeout for this command is 5000 ms, as recommended in the USB
> >> 3.2 specification (section 9.2.6.1).
> > 
> >    This section in the USB specs 1.1/2.0/3.0 talks about _all_ requests.
> > I don't have USB 3.2 but It believe it has the same wording.
> > 

The patch modifies both xhci and hub.c, and the keywords 'command' come from the xhci driver.
I will change 'command' to '(all)request' and newly added 'address_device' to 'SET_ADDRESS' in hub.c.
That sounds better for hub.c

> > [...]
> > 
> >> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> [...]
> 
> >> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >> index e1b1b64a0723..0c610a853aef 100644
> >> --- a/drivers/usb/host/xhci.c
> >> +++ b/drivers/usb/host/xhci.c
> >> @@ -3998,11 +3998,17 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
> >>  }
> >>  
> >>  /*
> > 
> >    You seem to be converting the existing comment to a kernel-doc one
> > but you miss changing from /* /** at the start and adding colons after
> 
>    From /* to /**, I meant to type...
> 
> > the param names below...
> 
>    This comment update also looks like a meterial for a separate patch...
>

I think this is acceptable in the patch since it modifies the function arguments
as well. I improved the existing comments while adding information about the new
argument. However will update /* to /**


> >> - * Issue an Address Device command and optionally send a corresponding
> >> - * SetAddress request to the device.
> >> + * xhci_setup_device - issues an Address Device command to assign a unique
> >> + *			USB bus address.
> >> + * @hcd USB host controller data structure.
> >> + * @udev USB dev structure representing the connected device.
> >> + * @setup Enum specifying setup mode: address only or with context.
> >> + * @timeout_ms Max wait time (ms) for the command operation to complete.
> >> + *
> >> + * Return: 0 if successful; otherwise, negative error code.
> >>   */
> >>  static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
> >> -			     enum xhci_setup_dev setup)
> >> +			     enum xhci_setup_dev setup, unsigned int timeout_ms)
> > [...]
> 
> MBR, Sergey

Thanks,
Hardik
