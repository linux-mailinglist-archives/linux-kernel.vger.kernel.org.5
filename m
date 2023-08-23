Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0D785C79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjHWPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjHWPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:48:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6C42610C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:48:09 -0700 (PDT)
Received: (qmail 188465 invoked by uid 1000); 23 Aug 2023 11:48:08 -0400
Date:   Wed, 23 Aug 2023 11:48:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <bdf69b9d-fe82-48e2-9638-d84d00d4ef1d@rowland.harvard.edu>
References: <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
 <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
 <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 04:30:23AM +0200, Andrey Konovalov wrote:
> I started looking into reworking the UDC drivers to drop the special
> case for USB_GADGET_DELAYED_STATUS, but this seems more complicated.
> 
> First, I noticed that some of the UDC drivers only expect to handle a
> delayed Status stage for SET_CONFIGURATION requests. (Which is

That expectation is wrong; gadget drivers can also want to delay the 
Status stage for a SET_INTERFACE request.  And in theory they might want 
to delay any control-OUT transfer.

> reasonable, as they were developed assuming that only the composite
> framework might request to delay the Status stage.) In particular,
> dwc3, cdns2, and cdns3 set the gadget state to USB_STATE_CONFIGURED
> when handling a delayed Status stage:
> 
> dwc3/ep0.c:136: usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
> cdns3/cdns3-ep0.c:739: usb_gadget_set_state(&priv_dev->gadget,
> USB_STATE_CONFIGURED);
> gadget/udc/cdns2/cdns2-ep0.c:572: usb_gadget_set_state(&pdev->gadget,
> USB_STATE_CONFIGURED);

This is also wrong.  SET_CONFIGURATION can tell a gadget to install 
config 0, in which case the state should be changed to 
USB_STATE_ADDRESS.

For that matter, a gadget can undergo many state changes other than the 
change into the CONFIGURED state.  It doesn't look like many of the UDC 
drivers are careful about reporting them.

> So I believe an additional check for whether the request was indeed
> SET_CONFIGURATION is required. (cdns2 and cdns3 also do other things
> besides setting the state to USB_STATE_CONFIGURED, but it should be
> possible to hide that under the same check.)
> 
> I also looked into how other UDC drivers change the gadget state to
> USB_STATE_CONFIGURED:
> 
> 1. isp1760, mtu3, and bdc immediately set USB_STATE_CONFIGURED once
> they receive a SET_CONFIGURATION request, before calling ->setup() for
> the gadget driver;
> 2. gr and mv_u3d do that after the ->setup() call;
> 3. tegra does it after the first non-control endpoint is enabled;
> 4. dwc3, cdns2, and cdns3 appear to not set USB_STATE_CONFIGURED if
> the Status stage is not delayed;
> 5. dwc2, cdnsp, and all other UDCs don't set USB_STATE_CONFIGURED at all.
> 
> I'm guessing the UDCs in #4 and #5 expect the gadget driver to set
> USB_STATE_CONFIGURED.
> 
> I see that the composite framework sets the gadget state to
> USB_STATE_CONFIGURED even if some of the functions request a delayed
> Status stage via USB_GADGET_DELAYED_STATUS. And GadgetFS also sets the
> state to USB_STATE_CONFIGURED before delegating the SET_CONFIGURATION
> request to userspace. However, Raw Gadget expects the userspace to
> issue an ioctl that sets USB_STATE_CONFIGURED before completing the
> delayed SET_CONFIGURATION request.
> 
> So I am wondering: when is proper time to set USB_STATE_CONFIGURED?
> And should this be handled by the UDC driver or the gadget driver?

The proper time isn't really well defined.  As far as the gadget driver 
is concerned, it's when the configuration change is completed (when it 
tells the composite framework to stop delaying the status stage).  But 
as far as the host is concerned, it's when the Status stage completes 
successfully.

If the Status stage of the control transfer gets corrupted, it's 
possible to end up in a situation where the gadget believes it is 
configured and the host believes it isn't.  Luckily this doesn't 
happen very often, and if it does then the host should reissue the 
transfer.

All the other state changes are (or should be) handled by the UDC 
drivers.  I guess they can handle the changes to/from the CONFIGURED 
state as well, although they will have to be more careful about it than 
they are now.

> > > An alternative would to declare USB_GADGET_DELAYED_STATUS to be usable
> > > outside of the composite framework and leave everything as is
> > > otherwise (but change Raw Gadget to return USB_GADGET_DELAYED_STATUS).
> > > The downside is the discrepancy in the interface of different UDCs
> > > (some require USB_GADGET_DELAYED_STATUS, others imply), but perhaps
> > > it's not that bad provided that this discrepancy is documented.
> >
> > This alternative is less desirable, because the legacy gadgets (some of
> > which don't use the composite framework) may not be compatible with it.
> 
> I think GadgetFS and Raw Gadget are the only two such drivers?

Yes, that appears to be so.  I didn't realize those were the only 
hold-outs.

> > And as a matter of general principle, allowing UDC drivers to start
> > automatically send Status replies to 0-length control transfers is a
> > step in the wrong direction.  What we really should focus our energy on
> > is getting them to _stop_ sending automatic Status replies to
> > non-zero-length control transfers!
> 
> Ack!
> 
> But I don't think it's within my capability to fix all UDCs,
> considering the issues I mentioned above.

One step at a time...

Alan Stern
