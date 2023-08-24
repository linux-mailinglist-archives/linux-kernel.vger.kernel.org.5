Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51578654B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjHXCXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjHXCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:23:03 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 622E910FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:22:28 -0700 (PDT)
Received: (qmail 209045 invoked by uid 1000); 23 Aug 2023 22:21:04 -0400
Date:   Wed, 23 Aug 2023 22:21:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
References: <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:22:07PM +0000, Thinh Nguyen wrote:
> On Wed, Aug 23, 2023, Alan Stern wrote:
> > On Wed, Aug 23, 2023 at 05:59:07PM +0000, Thinh Nguyen wrote:
> > > On Wed, Aug 23, 2023, Alan Stern wrote:
> > > > STALL is not a valid status for usb_requests on the gadget side; it 
> > > > applies only on the host side (the host doesn't halt its endpoints).
> > > 
> > > The host can send a CLEAR_FEATURE(halt_ep). This will reset the data
> > > sequence of the endpoint. In xhci spec (section 4.6.8), it suggests to
> > > send this when the endpoint is reset. The endpoint is reset typically
> > > when there's a transaction error.
> > 
> > It's important to be careful about the distinction between an actual 
> > endpoint in the gadget and the logical representation of an endpoint 
> > inside a host controller.  The host cannot reset the first; it can only 
> > reset the second.
> > 
> > So yes, the usb_clear_halt() routine on the host does a 
> > CLEAR_FEATURE(HALT) control transfer and then calls 
> > usb_reset_endpoint(), which calls usb_hcd_reset_endpoint().
> > 
> > > The problem here is that typical protocol spec like MSC/UVC don't
> > > specify how to handle CLEAR_FEATURE(halt_ep).
> > 
> > MSC does specify this.  I don't know about UVC.
> 
> No, from what I last recalled, it doesn't clearly define what should
> happen here. It just indicates ClearFeature(halt_ep) for reset recovery.
> However, the "reset recovery" can be implementation specific for how the
> host can synchronize with the device.

Read the BOT spec.  I quote some of the relevant parts below.

> > > For Windows MSC driver, when the host recovers from the transaction
> > > error, it sends CLEAR_FEATURE(halt_ep) and expects the transfer to be
> > > cancelled. To synchronize with the host, the gadget driver needs to
> > > cancel the request. Dwc3 needs to notify the gadget driver of this.
> > 
> > No, that's not what happens in the Mass Storage Class.
> > 
> > For the Bulk-Only Transport version of MSC, when a Windows or Linux host 
> > detects a transaction error, it performs a USB port reset.  This clears 
> 
> No, that's implementation specific for reset recovery. Typically for

I haven't tested recent versions of Windows.  Older versions did behave 
this way.  I still have the logs to prove it.

> Windows, for the first recovery, it sends a ClearFeature(halt_ep) and
> sends a new MSC command.

That's a violation of the BOT spec.  Are you sure Windows really does 
this?

>  If the transfer doesn't complete within a
> specific time, there will be a timeout and a port reset, which is
> another level of recovery.
> 
> > all the state on the gadget.  The gadget gets re-enumerated, and the 
> > host proceeds to re-issue the MSC command.  The gadget driver doesn't 
> > need any special notifications; outstanding requests get cancelled as a 
> > normal part of the reset handling.
> > 
> > (In fact, this is not what the BOT spec says to do.  It says that when 
> > the host detects a transaction error, it should a Bulk-Only Mass Storage 
> > Reset -- this is a special class-specific control transfer.  In 
> > response, the gadget driver is supposed to reset its internal state and 
> > cancel all of its outstanding requests.  Then the host issues 
> > CLEAR_FEATURE(HALT) to both the bulk-IN and bulk-OUT endpoints and 
> > proceeds to issue its next MSC command.  A lot of MSC devices don't 
> > handle this properly, probably because Windows didn't use this 
> > approach.)
> 
> At the moment, the gadget driver doesn't handle CLEAR_FEATURE(halt_ep),
> the UDC driver does.

Correct.  My point is that it works this way because the gadget driver 
doesn't _need_ to handle Clear-Halt.

>   I don't recall this being handled in the composite
> framework or in the f_mass_storage function driver. Unless we change
> this, the UDC driver needs to notify the gadget driver somehow.

No, f_mass_storage does not need to be notified about Clear-Halts.  As 
you say, it isn't getting notified now, and yet it somehow still manages 
to work with every type of host I'm aware of.

> > In the UAS version of MSC, the endpoints never halt.  If there's a 
> > transaction error, the host simply re-issues the transaction.  If that 
> 
> There are multiple levels of recovery. Different driver handles it
> differently. For xHCI, Initially there's retry at the packet level
> (typically set to retry 3 times in a row). If it fails, host controller
> driver will get a transaction error event.

That 3-strikes-and-you're-out thing is the normal USB low-level retry 
mechanism.  We're talking about what happens when it fails and the HCD 
reports a transaction error such as -EPROTO.

> In Linux xHCI, the recovery for transaction error we perform soft-reset
> (xhci reset ep command with TSP=1). If it still fails, we reset the
> endpoint (TSP=0) and return the request with -EPROTO to the class
> driver. However, we don't send ClearFeature(halt_ep). I don't recall
> Linux MSC driver handle -EPROTO and do a port reset. However it does do
> a port reset due to transfer timeout.

In usb-storage, a -EPROTO error status causes interpret_urb_result() to 
return USB_STOR_XFER_ERROR.  This causes usb_stor_invoke_transport() to 
goto Handle_Errors:, which calls usb_stor_port_reset().

In uas, a -EPROTO error will cause an error status to be returned to the 
SCSI layer, which will invoke the SCSI error handler.  After enough 
failures it will call the uas device-reset handler, and 
uas_eh_device_reset_handler() calls usb_reset_device().

> In Windows, it doesn't do soft-reset, but it does reset endpoint (TSP=0)
> and send CLEAR_FEATURE(halt_ep) without port reset initially. It then
> can send the a new MSC command expecting the device to be in sync based
> on the CLEAR_FEATURE(halt_ep) request.

That is not how the Bulk-Only Transport protocol resynchronizes after a 
protocol error.  The BOT spec mentions in several places variations of:

	If the host detects a STALL of the Bulk-Out endpoint during 
	command transport, the host shall respond with a Reset Recovery
	(see 5.3.4 - Reset Recovery).

It doesn't say specifically what to do in case of other lower-level 
protocol errors, but we have to assume that the intention is for the 
host to follow the Reset Recovery procedure, because that's what the 
device will expect to see.  The spec goes on to say:

	5.3.4	Reset Recovery

	For Reset Recovery the host shall issue in the following order:
		(a) a Bulk-Only Mass Storage Reset
		(b) a Clear Feature HALT to the Bulk-In endpoint
		(c) a Clear Feature HALT to the Bulk-Out endpoint

It most definitely does _not_ say that the host should do a Clear-Halt 
without the Bulk-Only Mass Storage Reset.  By reading the spec carefully 
you can see that such action would leave the host out of sync with the 
device.

>  If the recovery fails and the
> transfer/command timed out, it will then do a port reset to recover.
> 
> > fails too, error recovery is started by the SCSI layer; it involves a 
> > USB port reset.
> > 
> > But as you can see, in each case the UDC driver doesn't have to cancel 
> > anything in particular when it gets a Clear-Halt.
> > 
> > > For other class driver, it may expect the transfer to resume after data
> > > sequence reset.
> > 
> > Indeed.  In which case, the UDC driver shouldn't cancel anything.
> > 
> > > As a result, for an endpoint that's STALL (or not), and if the host
> > > sends CLEAR_FEATURE(halt_ep), the dwc3 returns the request with some
> > > status code and let the gadget driver handle it. If the gadget driver
> > > wants to cancel the transfer, it can drop the transfer. If the gadget
> > > driver wants to resume, it can requeue the same requests with the saved
> > > status to resume where it left off.
> > 
> > The UDC driver should not dequeue a request merely because the endpoint 
> > is halted.  The gadget driver can take care of everything necessary.  
> > After all, it knows when an endpoint gets halted, because the gadget 
> 
> No, currently it doesn't know. That's the problem. The dwc3 driver
> handles the CLEAR_FEATURE(halt_ep), not the gadget driver.

You misunderstood what I wrote.  I said that the gadget driver knows 
when an endpoint's halt feature gets _set_; I didn't say that it knows 
when the halt feature gets _cleared_.

(There is one exception: The gadget driver won't know if the host sends 
a SET_FEATURE(halt_ep).  Hosts don't normally do this and I don't think 
we need to worry about it.)

> > driver is what calls usb_ep_set_halt() or usb_ep_set_wedge() in the 
> > first place.
> > 
> > As for handling CLEAR_FEATURE(HALT), all the UDC driver needs to do is 
> > clear the HALT feature for the endpoint.  (Although if the endpoint is 
> > wedged, the HALT feature should not be cleared.)  It doesn't need to 
> > cancel any outstanding requests or inform the gadget driver in any way.
> 
> The UDC driver needs to notify the gadget driver somehow, cancelling the
> request and give it back is currently the way dwc3 handling it.

And I'm saying that the UDC driver does _not_ need to notify the gadget 
driver.

The MSC gadget driver works just fine without any such notification.  
Can you name any gadget driver that _does_ need a notification?

Alan Stern
