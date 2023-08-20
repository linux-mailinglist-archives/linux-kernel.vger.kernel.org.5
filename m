Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE96781E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjHTOZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHTOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 10:25:19 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C09222723
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 07:20:39 -0700 (PDT)
Received: (qmail 90313 invoked by uid 1000); 20 Aug 2023 10:20:38 -0400
Date:   Sun, 20 Aug 2023 10:20:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819000643.7mddkitzr4aqjsms@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 12:06:53AM +0000, Thinh Nguyen wrote:
> On Fri, Aug 18, 2023, Alan Stern wrote:
> > Actually I agree with you.  When a new SETUP packet arrives before the 
> > old control transfer has finished, the UDC driver should cancel all 
> > pending requests and then invoke the ->setup() callback.  (I don't think 
> > there is a standard error code for the cancelled requests; net2280 seems 
> > to use -EPROTO whereas dummy-hcd seems to use -EOVERFLOW.)
> 
> Those are very odd choice of error codes for cancelled request. Even
> though the gadget side doesn't have very defined error codes, I try to
> follow the equivalent doc from the host side
> (driver-api/usb/error-codes.rst), which is -ECONNRESET.
> 
> Whenever I see -EPROTO, I associate that to a specific host error:
> transaction error. For -EOVERFLOW, I think of babble errors.

Do you have a suggestion for an error code that all the UDCs should use 
in this situation?  -ECONNRESET is currently being used for requests 
that were cancelled by usb_ep_dequeue().  Would -EREMOTEIO be more 
suitable for requests attached to an aborted control transfer?


> > My impression from his initial email was that something different was 
> > happening.  It sounded like his ->setup() callback was invoked with 
> > wLength = 0, but before the Raw Gadget driver was ready to queue a 
> > response request, the UDC driver sent an automatic status, at which 
> > point the host sent another SETUP packet.  So the gadget driver got two 
> > ->setup() callbacks in a row with no chance to do anything in between.
> 
> What else should the gadget driver do? There's no data stage for
> wLength=0.

So when wLength is 0, dwc3 should not automatically handle the Status 
stage.  It should wait for the gadget driver to submit an explicit 
Status-stage request.  As far as I know, all the gadget drivers will do 
this.

> > > > This may be a holdover from the early days of the Gadget subsystem.  My 
> > > > memory from back then isn't very good; I vaguely recall that the first 
> > > > UDC drivers would queue their automatic Status-stage requests if wLength 
> > > > was 0 and ->setup() returned 0 (which would explain why 
> > > > USB_GADGET_DELAYED_STATUS had to be invented).  Unless I'm completely 
> > > > confused, that's not how UDC drivers are supposed to act now.
> > 
> > I did a little checking.  The USB_GADGET_DELAYED_STATUS mechanism was 
> > introduced for use by the composite framework -- not in order to make a 
> > UDC driver work properly.
> 
> Hm... perhaps we can update so that it's applicable outside of the
> composite framework. Currently dwc3 treats it as such, which may not
> work if the gadget driver does not know about USB_GADGET_DELAYED_STATUS.

I think USB_GADGET_DELAYED_STATUS belongs entirely inside the composite 
framework and it should not be used by UDC drivers at all.

That return code makes some sense in composite.c, because the composite 
framework juggles several function drivers in a single gadget.  It has 
to know when all of them are ready to complete a configuration change; 
it can't assume each function is ready when the callback returns.

An alternative approach for composite.c would be _always_ to assume that 
functions aren't ready until they have called 
usb_composite_setup_continue().  However, doing this would require 
auditing each function driver.


> dwc3 parse the SETUP data and determine whether it's a 3-state or
> 2-stage control transfer. If wLength > 0, then it must be a 3-stage
> control transfer. The dwc3 driver would not queue the status immediately
> until the data stage is completed.
> 
> To enforce the gadget driver to manually queue the status would take
> some effort to ensure all the UDC driver comply to it. We would also
> need to update the composite framework.

The composite framework already does the right thing.  And as Andrey 
said, most if not all of the other UDC drivers already behave this way.

Alan Stern
