Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D090978F082
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbjHaPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjHaPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:40:46 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3A01B8F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:40:42 -0700 (PDT)
Received: (qmail 482806 invoked by uid 1000); 31 Aug 2023 11:40:41 -0400
Date:   Thu, 31 Aug 2023 11:40:41 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <1a66bb8f-9680-424a-a051-27353b8a4130@rowland.harvard.edu>
References: <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
 <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 02:43:51AM +0000, Thinh Nguyen wrote:
> On Wed, Aug 30, 2023, Alan Stern wrote:
> > On Wed, Aug 30, 2023 at 01:32:28AM +0000, Thinh Nguyen wrote:
> > > That reminds me another thing, if the host (xhci in this case) does a
> > > hard reset to the endpoint, it also resets the TRB pointer with dequeue
> > > ep command. So, the transfer should not resume. It needs to be
> > > cancelled. This xHCI behavior is the same for Windows and Linux.
> > 
> > That's on the host side, right?  How does this affect the gadget side?
> > 
> > That is, cancelling a transfer on the host doesn't necessarily mean it 
> > has to be cancelled on the gadget.  Does it have any implications at all 
> > for the gadget driver?
> 
> There are 2 things that needs to be in sync'ed between host and device:
> 1) The data sequence.

You mean the USB-3 sequence number value?

> 2) The transfer.
> 
> If host doesn't send CLEAR_FEATURE(halt_ep), best case scenario, the
> data sequence does't match and the host issues usb reset after some
> timeout because the packet won't go through.

The data toggles in USB-2, which are analogous to the sequence numbers 
in USB-3, don't work the same way.  When a USB-2 controller receives a 
data packet with the wrong sequence number, it sends an ACK response but 
otherwise ignores it.  This prevents timeouts (but not other types of 
errors).

>  Worst case scenario, the
> data sequence matches 0, and the wrong data is received causing
> corruption.
> 
> If the device doesn't cancel the transfer in response to
> CLEAR_FEATURE(halt_ep), it may send/receive data of a different transfer
> because the host doesn't resume where it left off, causing corruption.
> 
> Base on the class protocol, the class driver and gadget driver know
> what makes up a "transfer" and can appropriately cancel a transfer to
> stay in sync.

You're still thinking of UAS in particular, right?  What I would expect 
to happen when there's a transaction error in a UAS data transfer, based 
on reading the UAS spec, is that the host would cancel the transfer on 
its side and send either an Abort Task or an I_T Nexus Reset task 
management request to the device (in addition to resetting the host 
endpoint and sending a Clear-Halt).  I would not expect the host to hope 
that the device would abandon the transfer merely because it got the 
Clear-Halt.

Does Windows really work this way?  Does it not send a task management 
request?  That would definitely seem to be against the intent of the 
spec, if not against the letter.

> > How does the gadget driver sync with the host if the class protocol 
> > doesn't say what should be done?
> > 
> > Also, what if there is no active transfer?  That is, what if the 
> > transaction that got an error on the host appeared to be successful on 
> > the gadget and it was the last transaction in the final transfer queued 
> > for the endpoint?  How would the UDC driver notify the gadget driver in 
> > this situation?
> 
> That's fine. If there's no active transfer, the gadget doesn't need to
> cancel anything. As long as the host knows that the transfer did not
> complete, it can retry and be in sync. For UASP, the host will send a
> new MSC command to retry the failed transfer. ie. The host would
> overwrite/re-read the transfer with the same transfer offset.
> 
> The problem arises if the gadget attempts to resume the incomplete
> transfer.

Quite so.  But would the host send a new MSC retry command before the 
failed command completes?

> > >  This is observed in
> > > UASP driver in Windows and how various consumer UASP devices handle it.
> > 
> > I don't understand what you're saying here.  How can you observe whether 
> > a transfer is cancelled in a consumer UAS device?  And how does the 
> > consumer device resync with the host?
> 
> You can see a hang if the transfer are out of sync. If the transfer
> isn't cancelled, the device would only source/sink whatever the
> remaining of the previous transfer but not enough to complete the new
> transfer. The new transfer is seen as incomplete from host and thus the
> hang and the usb reset.
> 
> > 
> > > There no eqivalent of Bulk-Only Mass Storage Reset request from the
> > > class protocol. We still have the USB analyzer traces for this.
> > 
> > Can you post an example?  Not necessarily in complete detail, but enough 
> > so that we can see what's going on.
> > 
> > > Regardless whether the class protocol spells out how to handle the
> > > transaction error, if there's transaction error, the host may send
> > > CLEAR_FEATURE(halt_ep) as observed in Windows. The gadget driver needs
> > > to know about it to cancel the active transfer and resync with the host.
> > 
> > I'll be able to understand this better after seeing an example.  Do you 
> > have any traces that were made for a High-speed connection (say, using 
> > a USB-2 cable)?  It would probably be easier to follow than a SuperSpeed 
> > example.
> > 
> 
> Unfortunately I only have LeCroy usb analyzer traces of Gen 2x1, not for
> usb2 speed. It's a bit tricky converting it to text with all the proper
> info to see all the context. If my explanation isn't clear, I'll try to
> figure out how to proceed.

I would appreciate seeing whatever you can provide.

Alan Stern
