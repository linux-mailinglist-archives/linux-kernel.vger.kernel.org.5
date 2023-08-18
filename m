Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC37803DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357278AbjHRChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352529AbjHRChK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:37:10 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1585D3A94
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:37:05 -0700 (PDT)
Received: (qmail 17280 invoked by uid 1000); 17 Aug 2023 22:37:05 -0400
Date:   Thu, 17 Aug 2023 22:37:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818010815.4kcue67idma5yguf@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:08:19AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> On Fri, Aug 18, 2023, Andrey Konovalov wrote:
> > Hi Alan and Thinh,
> > 
> > I have been testing Raw Gadget with the dwc3 UDC driver and stumbled
> > upon an issue related to how dwc3 handles setup requests with wLength
> > == 0.
> > 
> > When running a simple Raw Gadget-based keyboard emulator [1],
> > everything works as expected until the point when the host sends a
> > SET_CONFIGURATION request, which has wLength == 0.
> > 
> > For setup requests with wLength != 0, just like the other UDC drivers
> > I tested, dwc3 calls the gadget driver's ->setup() callback and then
> > waits until the gadget driver queues an URB to EP0 as a response.
> 
> For the lack of better term, can we use "request" or "usb_request"
> instead of URB for gadget side, I get confused with the host side
> whenever we mention URB.
> 
> > 
> > However, for a setup request with wLength == 0, dwc3 does not wait
> > until the gadget driver queues an URB to ack the transfer. It appears
> > that dwc3 just acks the request internally and then proceeds with
> > calling the ->setup() callback for the next request received from the
> 
> It depends on the bRequest. It should not proceed to ->setup() unless
> the gadget driver already setups the request for it.

Let's see if I understand what you're saying.  Some control transfers 
are handled directly by the UDC driver (things like SET_ADDRESS or 
CLEAR_HALT).  For these transfers, the ->setup() callback is not invoked 
and the gadget driver is completely unaware of them.  But for all other 
control transfers, the ->setup() callback _is_ invoked.

Is that what you meant?

> > host. This confuses Raw Gadget, as it does not expect to get a new
> > ->setup() call before it explicitly acks the previous one by queuing
> > an URB. As a result, the emulation fails.
> 
> If the host intent is to send a 3-stage control request with a 0-length
> data packet, the gadget driver needs to return USB_GADGET_DELAYED_STATUS
> to prepare a 0-length request. For SET_CONFIGURATION, we don't expect
> a data phase, why should the gadget driver queue a 0-length data?

The USB-2 spec prohibits 3-stage control requests with wLength == 0 (see 
sections 9.3.1 and 9.3.5).  Therefore the host's intent can never be to 
send a 3-stage control request with a 0-length Data-stage packet.

> > I suspect this issue has not been observed with other gadget drivers,
> > as they queue an URB immediately after receiving a ->setup() call:
> > dwc3 appears to somehow correctly handle this internally even though
> > it acks the transfer by itself. But the timings with Raw Gadget are
> > different, as it requires userspace to ack the transfer. Sometimes
> > though, the Raw Gadget-based emulator also manages to queue an URB
> > before the next request is received from the host and the enumeration
> > continues properly (until the next request with wLength == 0).
> > 
> > What do you think would be the best approach to deal with this?
> 
> The communication should be clearly defined. That is, the dwc3 needs to
> know if this is a 3-stage or 2-stage control transfer. It knows about
> the standard requests, but not the vendor/non-standard ones. If the raw
> gadget defined some unknown OUT request, it needs to tell dwc3 whether
> it should expect the data stage or not.

The communication _is_ clearly defined.  Here's how it works:

For control transfers that aren't handled directly by the UDC, the UDC 
driver invokes the ->setup() callback and waits for the gadget driver to 
queue a request.  If the SETUP packet's wLength value is > 0 then the 
gadget driver queues an IN or OUT request (depending on the transfer's 
direction) and the UDC waits for the host to transfer the Data stage 
packets, completing the request.  After this happens, the UDC driver 
automatically queues an internal 0-length request in the opposite 
direction for the Status stage.  Data-stage transfers are not allowed to 
span more than one usb_request.

(IMO that automatic action is a design flaw; the UDC driver should wait 
for the gadget driver to explictly queue a 0-length request or a STALL 
instead of doing it automatically.)

But if the SETUP packet's wLength value is 0 then when the gadget driver 
is ready, it queues a 0-length IN request which will act as the Status 
stage.  In this situation the UDC does not automatically create a 
Status-stage request.

Note that the gadget driver is allowed to queue its various requests 
either while the ->setup() callback is running or after it has returned.

(Another design flaw is that this design doesn't specify what should 
happen if the UDC receives another SETUP packet from the host before the 
Status stage completes.  By sending another SETUP packet, the host is 
indicating that the earlier control transfer has been aborted.  
Presumably the UDC driver will complete all the outstanding requests 
with an error status, but there's a potential race in the gadget driver 
between queuing a request for the first transfer and executing the 
->setup() callback for the second transfer.)

If the dwc3 UDC driver doesn't behave this way then it needs to be 
fixed.

Alan Stern
