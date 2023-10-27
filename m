Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301AF7D9462
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjJ0J55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjJ0J5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:57:52 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B81C191;
        Fri, 27 Oct 2023 02:57:47 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id BD7B0520532;
        Fri, 27 Oct 2023 11:57:45 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 27 Oct
 2023 11:57:45 +0200
Date:   Fri, 27 Oct 2023 11:57:35 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>
Subject: Re: [PATCH v6] usb: Reduce the 'SET_ADDRESS' request timeout with a
 new quirk
Message-ID: <20231027095708.GA78934@vmlxhi-118.adit-jv.com>
References: <20231025164019.GA121292@vmlxhi-118.adit-jv.com>
 <20231026101551.36551-1-hgajjar@de.adit-jv.com>
 <55a00749-7b9d-4fc8-a470-6eabdb93216f@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55a00749-7b9d-4fc8-a470-6eabdb93216f@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:34:22PM -0400, Alan Stern wrote:
> On Thu, Oct 26, 2023 at 12:15:51PM +0200, Hardik Gajjar wrote:
> > This patch introduces a new USB quirk,
> > USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT, which modifies the timeout value
> > for the 'SET_ADDRESS' request. The standard timeout for USB request/command
> > is 5000 ms, as recommended in the USB 3.2 specification (section 9.2.6.1).
> > 
> > However, certain scenarios, such as connecting devices through an APTIV
> > hub, can lead to timeout errors when the device enumerates as full speed
> > initially and later switches to high speed during chirp negotiation.
> > 
> > In such cases, USB analyzer logs reveal that the bus suspends for
> > 5 seconds due to incorrect chirp parsing and resumes only after two
> > consecutive timeout errors trigger a hub driver reset.
> > 
> > Packet(54) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
> > _______| Time Stamp(28 . 105 910 682)
> > _______|_____________________________________________________________Ch0
> > Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
> > _______| Time Stamp(28 . 106 910 632)
> > _______|_____________________________________________________________Ch0
> > Packet(56) Dir(?) Full Speed J(399.650 us) Idle(222.582 us)
> > _______| Time Stamp(28 . 107 910 600)
> > _______|_____________________________________________________________Ch0
> > Packet(57) Dir Chirp J( 23.955 ms) Idle(115.169 ms)
> > _______| Time Stamp(28 . 108 532 832)
> > _______|_____________________________________________________________Ch0
> > Packet(58) Dir(?) Full Speed J (Suspend)( 5.347 sec) Idle(  5.366 us)
> > _______| Time Stamp(28 . 247 657 600)
> > _______|_____________________________________________________________Ch0
> > 
> > This 5-second delay in device enumeration is undesirable, particularly
> > in automotive applications where quick enumeration is crucial
> > (ideally within 3 seconds).
> > 
> > The newly introduced quirks provide the flexibility to align with a
> > 3-second time limit, as required in specific contexts like automotive
> > applications.
> > 
> > By reducing the 'SET_ADDRESS' request timeout to 500 ms, the
> > system can respond more swiftly to errors, initiate rapid recovery, and
> > ensure efficient device enumeration. This change is vital for scenarios
> > where rapid smartphone enumeration and screen projection are essential.
> > 
> > To use the quirk, please write "vendor_id:product_id:p" to
> > /sys/bus/usb/drivers/hub/module/parameter/quirks
> > 
> > For example,
> > echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameters/quirks"
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> 
> For the usbcore parts: A couple of very minor things can be improved.  
> Once those improvements have been made, you can add:
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0a1731a0f0ef..4aa3723d2eaf 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6817,6 +6817,9 @@
> >  					pause after every control message);
> >  				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
> >  					delay after resetting its port);
> > +				p = USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT (Reduce
> > +					timeout of the SET_ADDRESS request from
> > +					5000 ms to 500 ms)
> 
> To avoid going over the 80-column limit, move "(Reduce" to the next 
> line and reflow the text in parentheses.
> 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 3c54b218301c..98db92af2cce 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -54,6 +54,19 @@
> >  #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
> >  #define USB_PING_RESPONSE_TIME		400	/* ns */
> >  
> > +/*
> > + * USB 3.2 spec, section 9.2.6.1
> > + * USB sets an upper limit of 5000 ms for any command/request
> > + * to be processed.
> > + */
> > +#define USB_DEFAULT_REQUEST_TIMEOUT_MS	5000 /* ms */
> 
> You don't need to define this macro at all.  Just use 
> USB_CTRL_SET_TIMEOUT (which is already defined to be 5000) as the 
> existing code already does.
> 
> > +/*
> > + * The SET_ADDRESS request timeout will be 500 ms when
> > + * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT enable.
> > + */
> > +#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT_MS	500  /* ms */
> 
> As remarked earlier, we don't need to have the "_MS" suffix on either 
> the macro name or the "timeout_ms" variable name.  Removing the suffix 
> will be more consistent with the USB_TP_TRANSMISSION_DELAY_MAX and 
> USB_PING_RESPONSE_TIME names you see above.

I understand the suffix _MS in macro but the suffix is variable name was
added after the comment about timeout unit from Greg in patchV2.

https://marc.info/?l=linux-usb&m=169687322126192&w=2

Other comments will be resolved in next patch.
> 
> > +
> > +/*
> > + * The SET_ADDRESS request timeout will be 500 ms when
> > + * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT enable.
> 
> Change the second line to:
> 
>  *  the USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT quirk flag is set.
> 
> > + */
> > +#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT_MS	500  /* ms */
> 
> Overall, I agree with Sergey that this would be cleaner if you split it 
> up into two patches.  The first should change the comment for the 
> set_address() callback function and the implementation in xhci-hcd.  The 
> second should add the quirk flag and make the corresponding changes to 
> the USB core.
> 
> Alan Stern

Thanks,
Hardik
