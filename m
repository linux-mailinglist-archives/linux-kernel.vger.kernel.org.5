Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D9785BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjHWPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjHWPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:18:06 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 49D2B1988
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:17:46 -0700 (PDT)
Received: (qmail 187319 invoked by uid 1000); 23 Aug 2023 11:17:14 -0400
Date:   Wed, 23 Aug 2023 11:17:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823021429.rlgixqehry4rsqmm@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:14:32AM +0000, Thinh Nguyen wrote:
> On Sun, Aug 20, 2023, Alan Stern wrote:
> > On Sat, Aug 19, 2023 at 12:06:53AM +0000, Thinh Nguyen wrote:
> > > On Fri, Aug 18, 2023, Alan Stern wrote:
> > > > Actually I agree with you.  When a new SETUP packet arrives before the 
> > > > old control transfer has finished, the UDC driver should cancel all 
> > > > pending requests and then invoke the ->setup() callback.  (I don't think 
> > > > there is a standard error code for the cancelled requests; net2280 seems 
> > > > to use -EPROTO whereas dummy-hcd seems to use -EOVERFLOW.)
> > > 
> > > Those are very odd choice of error codes for cancelled request. Even
> > > though the gadget side doesn't have very defined error codes, I try to
> > > follow the equivalent doc from the host side
> > > (driver-api/usb/error-codes.rst), which is -ECONNRESET.
> > > 
> > > Whenever I see -EPROTO, I associate that to a specific host error:
> > > transaction error. For -EOVERFLOW, I think of babble errors.
> > 
> > Do you have a suggestion for an error code that all the UDCs should use 
> > in this situation?  -ECONNRESET is currently being used for requests 
> > that were cancelled by usb_ep_dequeue().  Would -EREMOTEIO be more 
> > suitable for requests attached to an aborted control transfer?
> > 
> 
> That works. It would be great if we can document the usb error codes for
> gadget side and keep them consistent across UDC drivers. I think there
> are only a few common errors:
> 
> * Request aborted
> * Request dequeued
> * STALL
> * Data dropped (isoc only)
> 
> Any other?

* Overflow

STALL is not a valid status for usb_requests on the gadget side; it 
applies only on the host side (the host doesn't halt its endpoints).

Requests can be aborted for two different reasons:

	The endpoint is being disabled, either by an config/altsetting
	change or because of a disconnect

	The request was for an aborted control transfer

Putting this together, I get the following status codes:

-ESHUTDOWN	Request aborted because ep was disabled
-EREMOTEIO	Request was for an aborted control transfer
-ECONNRESET	Request was cancelled by usb_ep_dequeue()
-EXDEV		Data dropped (isoc only)
-EOVERFLOW	The host sent more data than the request wanted
		(will never happen if the request's length is a
		nonzero multiple of the maxpacket size)

This applies only to the .status field of struct usb_request.  Calls to 
usb_ep_queue() may return different error codes.

How does that sound?

Alan Stern
