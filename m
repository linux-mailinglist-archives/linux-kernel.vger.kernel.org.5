Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0C78608D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbjHWTUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjHWTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:19:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 721E410CB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:19:48 -0700 (PDT)
Received: (qmail 196398 invoked by uid 1000); 23 Aug 2023 15:19:47 -0400
Date:   Wed, 23 Aug 2023 15:19:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
References: <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823175903.bpumanwv5fkpwc44@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 05:59:07PM +0000, Thinh Nguyen wrote:
> On Wed, Aug 23, 2023, Alan Stern wrote:
> > STALL is not a valid status for usb_requests on the gadget side; it 
> > applies only on the host side (the host doesn't halt its endpoints).
> 
> The host can send a CLEAR_FEATURE(halt_ep). This will reset the data
> sequence of the endpoint. In xhci spec (section 4.6.8), it suggests to
> send this when the endpoint is reset. The endpoint is reset typically
> when there's a transaction error.

It's important to be careful about the distinction between an actual 
endpoint in the gadget and the logical representation of an endpoint 
inside a host controller.  The host cannot reset the first; it can only 
reset the second.

So yes, the usb_clear_halt() routine on the host does a 
CLEAR_FEATURE(HALT) control transfer and then calls 
usb_reset_endpoint(), which calls usb_hcd_reset_endpoint().

> The problem here is that typical protocol spec like MSC/UVC don't
> specify how to handle CLEAR_FEATURE(halt_ep).

MSC does specify this.  I don't know about UVC.

> For Windows MSC driver, when the host recovers from the transaction
> error, it sends CLEAR_FEATURE(halt_ep) and expects the transfer to be
> cancelled. To synchronize with the host, the gadget driver needs to
> cancel the request. Dwc3 needs to notify the gadget driver of this.

No, that's not what happens in the Mass Storage Class.

For the Bulk-Only Transport version of MSC, when a Windows or Linux host 
detects a transaction error, it performs a USB port reset.  This clears 
all the state on the gadget.  The gadget gets re-enumerated, and the 
host proceeds to re-issue the MSC command.  The gadget driver doesn't 
need any special notifications; outstanding requests get cancelled as a 
normal part of the reset handling.

(In fact, this is not what the BOT spec says to do.  It says that when 
the host detects a transaction error, it should a Bulk-Only Mass Storage 
Reset -- this is a special class-specific control transfer.  In 
response, the gadget driver is supposed to reset its internal state and 
cancel all of its outstanding requests.  Then the host issues 
CLEAR_FEATURE(HALT) to both the bulk-IN and bulk-OUT endpoints and 
proceeds to issue its next MSC command.  A lot of MSC devices don't 
handle this properly, probably because Windows didn't use this 
approach.)

In the UAS version of MSC, the endpoints never halt.  If there's a 
transaction error, the host simply re-issues the transaction.  If that 
fails too, error recovery is started by the SCSI layer; it involves a 
USB port reset.

But as you can see, in each case the UDC driver doesn't have to cancel 
anything in particular when it gets a Clear-Halt.

> For other class driver, it may expect the transfer to resume after data
> sequence reset.

Indeed.  In which case, the UDC driver shouldn't cancel anything.

> As a result, for an endpoint that's STALL (or not), and if the host
> sends CLEAR_FEATURE(halt_ep), the dwc3 returns the request with some
> status code and let the gadget driver handle it. If the gadget driver
> wants to cancel the transfer, it can drop the transfer. If the gadget
> driver wants to resume, it can requeue the same requests with the saved
> status to resume where it left off.

The UDC driver should not dequeue a request merely because the endpoint 
is halted.  The gadget driver can take care of everything necessary.  
After all, it knows when an endpoint gets halted, because the gadget 
driver is what calls usb_ep_set_halt() or usb_ep_set_wedge() in the 
first place.

As for handling CLEAR_FEATURE(HALT), all the UDC driver needs to do is 
clear the HALT feature for the endpoint.  (Although if the endpoint is 
wedged, the HALT feature should not be cleared.)  It doesn't need to 
cancel any outstanding requests or inform the gadget driver in any way.

(Again, this is something that a lot of USB devices don't handle 
properly.  They get very confused if the host sends a Clear-Halt 
transfer for an endpoint that isn't halted.)

> > Putting this together, I get the following status codes:
> > 
> > -ESHUTDOWN	Request aborted because ep was disabled
> > -EREMOTEIO	Request was for an aborted control transfer
> > -ECONNRESET	Request was cancelled by usb_ep_dequeue()
> > -EXDEV		Data dropped (isoc only)
> > -EOVERFLOW	The host sent more data than the request wanted
> > 		(will never happen if the request's length is a
> > 		nonzero multiple of the maxpacket size)
> > 
> > This applies only to the .status field of struct usb_request.  Calls to 
> > usb_ep_queue() may return different error codes.
> > 
> > How does that sound?
> > 
> 
> That looks great!

At some point I'll write a patch adding this to the documentation.

Alan Stern
