Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26477815A8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbjHRXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbjHRXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:07:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 736A212B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:06:59 -0700 (PDT)
Received: (qmail 44209 invoked by uid 1000); 18 Aug 2023 19:06:58 -0400
Date:   Fri, 18 Aug 2023 19:06:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 07:49:27PM +0000, Thinh Nguyen wrote:
> On Thu, Aug 17, 2023, Alan Stern wrote:
> > On Fri, Aug 18, 2023 at 03:10:48AM +0000, Thinh Nguyen wrote:
> > > I was referring to the next request. It should not be processed until
> > > the first request is completed. Depending on the type of request, if
> > > there's a delayed_status, the dwc3 driver will not prepare for the
> > > Status stage and Setup stage (after status completion) to proceed to the
> > > _next_ ->setup callback.
> > > 
> > > My understanding from the described problem is that somehow dwc3
> > > processes the next request immediately without waiting for the raw
> > > gadget preparing the data stage.
> > 
> > Um.  This is one of the design flaws I mentioned: a new SETUP packet 
> > arriving before the old control transfer is finished.  The USB spec 
> > requires devices to accept the new SETUP packet and abort the old 
> > transfer.  So in this case, processing the next request immediately is 
> > the right thing to do.
> 
> No, as I've mentioned, from the gadget driver, it should not see the
> next ->setup until the first control transfer completion, regardless
> whether the transfer completed with error code due to abort or not.
> Everything should happen sequentially from the gadget driver. This
> should be handled in the dwc3 driver (though we missed a setup_pending
> status check in the data phase that needs to be fixed now that I look at
> it again).

Actually I agree with you.  When a new SETUP packet arrives before the 
old control transfer has finished, the UDC driver should cancel all 
pending requests and then invoke the ->setup() callback.  (I don't think 
there is a standard error code for the cancelled requests; net2280 seems 
to use -EPROTO whereas dummy-hcd seems to use -EOVERFLOW.)

> Perhaps the core design should be so that this synchronization does not
> depend on the udc driver implementation.

Do you mean the UDC core?  I don't see how it could get involved in 
managing control transfers.

> > One question is why Andrey is observing a new ->setup() callback 
> > happening so soon?  The host is supposed to allow a fairly long time for 
> > standard control requests to complete.  If the userspace component of 
> > the Raw Gadget takes too long to act, the transfer could time out and be 
> > cancelled on the host.  But "too long" means several seconds -- is that 
> > really what's going on here?
> 
> As I noted initially, it should not happen so I'm not sure what's really
> the problem here. Granted that the setup_pending check for data phase is
> missing in dwc3 driver, there should not be a problem unless the host
> actually aborted a control transfer. Also, there should be no data phase
> for wlength=0 even for IN direction if we go through the composite
> layer. So, I doubt that's what happening here.
> 
> Perhaps Andrey can clarify.

My impression from his initial email was that something different was 
happening.  It sounded like his ->setup() callback was invoked with 
wLength = 0, but before the Raw Gadget driver was ready to queue a 
response request, the UDC driver sent an automatic status, at which 
point the host sent another SETUP packet.  So the gadget driver got two 
->setup() callbacks in a row with no chance to do anything in between.

> > > I was talking in context of 0-length transfer (albeit I forgot about the
> > > special case of control OUT doesn't have 3-stage).
> > > 
> > > If it's a vendor request 0-length transfer, without responding with
> > > USB_GADGET_DELAYED_STATUS, the dwc3 will proceed with preparing the
> > > status stage.
> > 
> > This may be a holdover from the early days of the Gadget subsystem.  My 
> > memory from back then isn't very good; I vaguely recall that the first 
> > UDC drivers would queue their automatic Status-stage requests if wLength 
> > was 0 and ->setup() returned 0 (which would explain why 
> > USB_GADGET_DELAYED_STATUS had to be invented).  Unless I'm completely 
> > confused, that's not how UDC drivers are supposed to act now.

I did a little checking.  The USB_GADGET_DELAYED_STATUS mechanism was 
introduced for use by the composite framework -- not in order to make a 
UDC driver work properly.

> For dwc3, it's been like this since the beginning that it automatically
> queues the status upon host request. USB_GADGET_DELAYED_STATUS was
> introduced to support scenarios where the device may need a longer time
> to process the specific request (such as SET_CONFIGURATION).

It's hard to be sure, but that may be the cause of Andrey's problem.  He 
mentioned something about the Raw Gadget's ->setup() routine returning 
USB_GADGET_DELAYED_STATUS when the problem occurred, but I think he 
meant that it did this for the second callback, not the first one.

Still, I recommand that dwc3 not automatically queue a Status request 
when wLength is 0.  Gadget drivers don't expect UDC drivers to handle 
this for them.  For example, look at the composite_setup() function in 
composite.c.  It does this:

	/* respond with data transfer before status phase? */
	if (value >= 0 && value != USB_GADGET_DELAYED_STATUS) {
		req->length = value;
		req->context = cdev;
		req->zero = value < w_length;
		value = composite_ep0_queue(cdev, req, GFP_ATOMIC);

Clearly it doesn't want the UDC driver to queue a request for it, no 
matter what wLength or value is set to.

Alan Stern
