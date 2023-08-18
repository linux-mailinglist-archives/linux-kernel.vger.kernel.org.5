Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9827804E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357749AbjHRDmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357750AbjHRDmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:42:10 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B4BB4358D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:42:06 -0700 (PDT)
Received: (qmail 18664 invoked by uid 1000); 17 Aug 2023 23:42:05 -0400
Date:   Thu, 17 Aug 2023 23:42:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818031045.wovf5tj2un7nwf72@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:10:48AM +0000, Thinh Nguyen wrote:
> On Thu, Aug 17, 2023, Alan Stern wrote:
> > On Fri, Aug 18, 2023 at 01:08:19AM +0000, Thinh Nguyen wrote:
> > > Hi,
> > > 
> > > On Fri, Aug 18, 2023, Andrey Konovalov wrote:
> > > > Hi Alan and Thinh,
> > > > 
> > > > I have been testing Raw Gadget with the dwc3 UDC driver and stumbled
> > > > upon an issue related to how dwc3 handles setup requests with wLength
> > > > == 0.
> > > > 
> > > > When running a simple Raw Gadget-based keyboard emulator [1],
> > > > everything works as expected until the point when the host sends a
> > > > SET_CONFIGURATION request, which has wLength == 0.
> > > > 
> > > > For setup requests with wLength != 0, just like the other UDC drivers
> > > > I tested, dwc3 calls the gadget driver's ->setup() callback and then
> > > > waits until the gadget driver queues an URB to EP0 as a response.
> > > 
> > > For the lack of better term, can we use "request" or "usb_request"
> > > instead of URB for gadget side, I get confused with the host side
> > > whenever we mention URB.
> > > 
> > > > 
> > > > However, for a setup request with wLength == 0, dwc3 does not wait
> > > > until the gadget driver queues an URB to ack the transfer. It appears
> > > > that dwc3 just acks the request internally and then proceeds with
> > > > calling the ->setup() callback for the next request received from the
> > > 
> > > It depends on the bRequest. It should not proceed to ->setup() unless
> > > the gadget driver already setups the request for it.
> > 
> > Let's see if I understand what you're saying.  Some control transfers 
> > are handled directly by the UDC driver (things like SET_ADDRESS or 
> > CLEAR_HALT).  For these transfers, the ->setup() callback is not invoked 
> > and the gadget driver is completely unaware of them.  But for all other 
> > control transfers, the ->setup() callback _is_ invoked.
> > 
> > Is that what you meant?
> 
> That's not what I meant.
> 
> I was referring to the next request. It should not be processed until
> the first request is completed. Depending on the type of request, if
> there's a delayed_status, the dwc3 driver will not prepare for the
> Status stage and Setup stage (after status completion) to proceed to the
> _next_ ->setup callback.
> 
> My understanding from the described problem is that somehow dwc3
> processes the next request immediately without waiting for the raw
> gadget preparing the data stage.

Um.  This is one of the design flaws I mentioned: a new SETUP packet 
arriving before the old control transfer is finished.  The USB spec 
requires devices to accept the new SETUP packet and abort the old 
transfer.  So in this case, processing the next request immediately is 
the right thing to do.

One question is why Andrey is observing a new ->setup() callback 
happening so soon?  The host is supposed to allow a fairly long time for 
standard control requests to complete.  If the userspace component of 
the Raw Gadget takes too long to act, the transfer could time out and be 
cancelled on the host.  But "too long" means several seconds -- is that 
really what's going on here?

> I was talking in context of 0-length transfer (albeit I forgot about the
> special case of control OUT doesn't have 3-stage).
> 
> If it's a vendor request 0-length transfer, without responding with
> USB_GADGET_DELAYED_STATUS, the dwc3 will proceed with preparing the
> status stage.

This may be a holdover from the early days of the Gadget subsystem.  My 
memory from back then isn't very good; I vaguely recall that the first 
UDC drivers would queue their automatic Status-stage requests if wLength 
was 0 and ->setup() returned 0 (which would explain why 
USB_GADGET_DELAYED_STATUS had to be invented).  Unless I'm completely 
confused, that's not how UDC drivers are supposed to act now.

> > (IMO that automatic action is a design flaw; the UDC driver should wait 
> > for the gadget driver to explictly queue a 0-length request or a STALL 
> > instead of doing it automatically.)
> 
> Would every UDC has this capability? I recalled some aren't capable of
> delayed_status.

In those cases the UDC driver would just have to do the best it can.  
Very few modern USB device controllers should have this limitation.

> > (Another design flaw is that this design doesn't specify what should 
> > happen if the UDC receives another SETUP packet from the host before the 
> > Status stage completes.  By sending another SETUP packet, the host is 
> > indicating that the earlier control transfer has been aborted.  
> > Presumably the UDC driver will complete all the outstanding requests 
> > with an error status, but there's a potential race in the gadget driver 
> > between queuing a request for the first transfer and executing the 
> > ->setup() callback for the second transfer.)
> 
> If there's another SETUP packet coming while there's a pending control
> transfer, for dwc3 UDC, the pending control TRB should be completed with
> a Setup_pending status indicating aborted control transfer for dwc3
> driver to handle that.

Right.  The difficulty doesn't involve the communication between the HCD 
and the UDC hardware; it involves the communication between the UDC 
driver and the gadget driver.  Somehow they need to synchronize so that 
when the gadget driver queues a usb_request, the UDC driver can tell 
whether the request was meant for the earlier aborted control transfer 
or the new active one.  This can matter if the gadget driver has a 
separate control thread (a work routine or a kthread, for example) that 
could be queuing requests while the ->setup() callback is running.

Alan Stern
