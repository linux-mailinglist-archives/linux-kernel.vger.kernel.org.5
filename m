Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B6789394
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHZDLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjHZDLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:11:04 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 01D3226BF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:10:59 -0700 (PDT)
Received: (qmail 279161 invoked by uid 1000); 25 Aug 2023 23:10:58 -0400
Date:   Fri, 25 Aug 2023 23:10:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
References: <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826012024.mboftu3wk7fsrslp@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 01:20:34AM +0000, Thinh Nguyen wrote:
> Sorry for the delay response.
> 
> On Wed, Aug 23, 2023, Alan Stern wrote:
> > In uas, a -EPROTO error will cause an error status to be returned to the 
> > SCSI layer, which will invoke the SCSI error handler.  After enough 
> > failures it will call the uas device-reset handler, and 
> > uas_eh_device_reset_handler() calls usb_reset_device().
> 
> From my testing with UASP, if I recall correctly, there's a 30 second
> timeout before the reset handler kicks in.

That timeout length comes from the SCSI error handler.  I believe the
user can control the length by setting a sysfs attribute.  Also, it
should be possible to change the uas driver to make it perform a reset
on its own right away, the way usb-storage does, without waiting for
the SCSI error handler -- if this matters.


> From the xHCI spec, it suggests to issue a CLEAR_FEATURE(halt_ep) after
> the endpoint reset (e.g. from transaction error). Whether this action
> should be taken from the class driver or from the xHCI driver, it's not
> clear. However, as you said, without Bulk-Only Mass Storage Reset
> request, the host and device will be out of sync. The response action
> taken from xHCI is independent from MSC protocol. So it would make sense
> for the UDC driver to treat CLEAR_FEATURE(halt_ep) as such and not
> expect a Bulk-Only Mass Storage Reset or the equivalent.

In USB-2, performing an endpoint reset in the host controller together
with sending a Clear-Halt is dangerous.  It can lead to data
duplication.

Here's how that can happen.  Suppose the data toggles on both the host
and gadget side are initially equal to 0 when a bulk-OUT transaction
occur.  The host sends a DATA0 packet which the gadget receives,
causing the gadget's data toggle to change to 1.  But let's say the
gadget's ACK handshake gets corrupted, causing a protocol error on the
host.  So the host does an internal endpoint reset and sends a
Clear-Halt to the gadget.  When the gadget processes this command, it
resets its data toggle back to 0.  Now the host resends the same DATA0
packet as before -- and the gadget accepts it the second time because
its data toggle is set to 0!  The duplicated data leads to
corruption.  If the gadget's data toggle had remained 1 then it would
have acknowledged the duplicate DATA0 packet but otherwise ignored it,
avoiding the corruption.

I admit the probability of this happening is very low, but a more
robust error recovery procedure at the class level would prevent this
scenario.


> > > The UDC driver needs to notify the gadget driver somehow, cancelling the
> > > request and give it back is currently the way dwc3 handling it.
> > 
> > And I'm saying that the UDC driver does _not_ need to notify the gadget 
> > driver.
> > 
> > The MSC gadget driver works just fine without any such notification.  
> > Can you name any gadget driver that _does_ need a notification?
> > 
> 
> We were testing against UASP. The reason I added this was to mimic the
> behavior of common vendor UASP devices when it recovers from transaction
> errors in Windows.
> 
> When the data sequence of a transfer is reset, the host needs to send
> CLEAR_FEATURE(halt_ep). It should be a common behavior. Since it is
> common and part of the xHCI spec, do we expect the xHCI to send this or
> do we expect the class protocol to document and handle this? At the
> moment, I expect it to be the former and expect the UDC driver to treat
> it as a common synchronization that perhaps the only synchronization
> mechanism the upper protocol depends on.

I think it should be the opposite; the class protocol should specify
how to recover from errors.  If for no other reason then to avoid the
data duplication problem for USB-2.  However, if it doesn't specify a
recovery procedure then there's not much else you can do.

But regardless, how can the gadget driver make any use of the
knowledge that the UDC received a Clear-Halt?  What would it do
differently?  If the intent is simply to clear an error condition and
continue with the existing transfer, the gadget driver doesn't need to
do anything.

Alternatively, if the procedure for clearing an error condition is
given by the class protocol then the protocol should spell out a
method for the host to inform the gadget about what it is doing --
something more than just sending a Clear-Halt.

Alan Stern
