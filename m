Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843C78DDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbjH3Svc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbjH3OsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:48:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A744B11B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:48:03 -0700 (PDT)
Received: (qmail 423072 invoked by uid 1000); 30 Aug 2023 10:48:02 -0400
Date:   Wed, 30 Aug 2023 10:48:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
References: <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830013222.ukw5dtburjnrrjko@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:32:28AM +0000, Thinh Nguyen wrote:
> That reminds me another thing, if the host (xhci in this case) does a
> hard reset to the endpoint, it also resets the TRB pointer with dequeue
> ep command. So, the transfer should not resume. It needs to be
> cancelled. This xHCI behavior is the same for Windows and Linux.

That's on the host side, right?  How does this affect the gadget side?

That is, cancelling a transfer on the host doesn't necessarily mean it 
has to be cancelled on the gadget.  Does it have any implications at all 
for the gadget driver?

> > I think it should be the opposite; the class protocol should specify
> > how to recover from errors.  If for no other reason then to avoid the
> > data duplication problem for USB-2.  However, if it doesn't specify a
> > recovery procedure then there's not much else you can do.
> 
> Right, unfortunately that's not always the case that class protocol
> spell out how to handle transaction error.

All too true...

> > But regardless, how can the gadget driver make any use of the
> > knowledge that the UDC received a Clear-Halt?  What would it do
> > differently?  If the intent is simply to clear an error condition and
> > continue with the existing transfer, the gadget driver doesn't need to
> > do anything.
> 
> It's not simple to clear an error. It is to notify the gadget driver to
> cancel the active transfer and resync with the host.

How does the gadget driver sync with the host if the class protocol 
doesn't say what should be done?

Also, what if there is no active transfer?  That is, what if the 
transaction that got an error on the host appeared to be successful on 
the gadget and it was the last transaction in the final transfer queued 
for the endpoint?  How would the UDC driver notify the gadget driver in 
this situation?

>  This is observed in
> UASP driver in Windows and how various consumer UASP devices handle it.

I don't understand what you're saying here.  How can you observe whether 
a transfer is cancelled in a consumer UAS device?  And how does the 
consumer device resync with the host?

> There no eqivalent of Bulk-Only Mass Storage Reset request from the
> class protocol. We still have the USB analyzer traces for this.

Can you post an example?  Not necessarily in complete detail, but enough 
so that we can see what's going on.

> Regardless whether the class protocol spells out how to handle the
> transaction error, if there's transaction error, the host may send
> CLEAR_FEATURE(halt_ep) as observed in Windows. The gadget driver needs
> to know about it to cancel the active transfer and resync with the host.

I'll be able to understand this better after seeing an example.  Do you 
have any traces that were made for a High-speed connection (say, using 
a USB-2 cable)?  It would probably be easier to follow than a SuperSpeed 
example.

Alan Stern
