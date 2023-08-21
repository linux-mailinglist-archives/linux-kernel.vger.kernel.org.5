Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A865782F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjHURZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjHURZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:25:25 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 125F9F7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:25:23 -0700 (PDT)
Received: (qmail 124572 invoked by uid 1000); 21 Aug 2023 13:25:23 -0400
Date:   Mon, 21 Aug 2023 13:25:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 06:13:05PM +0200, Andrey Konovalov wrote:
> Out of curiosity, I also did some digging around USB_GADGET_DELAYED_STATUS.
> 
> 1. USB_GADGET_DELAYED_STATUS was introduced in 1b9ba000177 ("usb:
> gadget: composite: Allow function drivers to pause control
> transfers"). It looks like it was indeed initially intended for the
> composite framework, as nor that commit nor the directly following
> commits use USB_GADGET_DELAYED_STATUS in any UDC drivers. However,
> this commit had an unintended (?) side-effect of returning
> USB_GADGET_DELAYED_STATUS from the ->setup() call of the composite
> framework gadget driver.
> 
> 2. In 5bdb1dcc6330 ("usb: dwc3: ep0: handle delayed_status again"),
> the dwc3 driver was the first one to start relying on
> USB_GADGET_DELAYED_STATUS to decide when to avoid auto-completing the
> Status stage (+Sebastian). The commit description mentions some
> previous rework of the driver that made it lose the ability of handle
> delayed Status stage handling, but I couldn't figure out the exact
> commit it refers to.
> 
> 3. Following that, a few other UDC drivers also started using
> USB_GADGET_DELAYED_STATUS, potentially using the dwc3 behavior as a
> reference.
> 
> Interestingly, in 946ef68ad4e4 ("usb: gadget: ffs: Let setup() return
> USB_GADGET_DELAYED_STATUS"), the FunctionFS composite driver had to
> add USB_GADGET_DELAYED_STATUS to specifically avoid failures when dwc3
> is used. This is the same "fix" that worked for me with Raw Gadget.
> 
> Right now dwc2, dwc3, mtu3, cdns3, bdc, and renesas have special
> handling for USB_GADGET_DELAYED_STATUS. Surprisingly, dwc2 works with
> Raw Gadget as is nevertheless. dwc3 fails as I described. For the
> others, I don't have the hardware to test them.
> 
> I guess the proper solution would be to contain
> USB_GADGET_DELAYED_STATUS within the composite framework and make all
> UDCs not to handle the Status stage on their own. However, this would
> require a collaborative effort from the maintainers of the UDC drivers
> I mentioned.

Most if not all of the UDC drivers you listed are actively maintained.  
It shouldn't be too hard to get people to remove the special treatment 
of USB_GADGET_DELAYED_STATUS in them.

The necessary changes should be pretty small: Whenever wLength is 0, 
treat any non-negative return value from ->setup() as if it were 
USB_GADGET_DELAYED_STATUS.  This would probably end up shrinking the 
UDC driver code a little.  :-)

> An alternative would to declare USB_GADGET_DELAYED_STATUS to be usable
> outside of the composite framework and leave everything as is
> otherwise (but change Raw Gadget to return USB_GADGET_DELAYED_STATUS).
> The downside is the discrepancy in the interface of different UDCs
> (some require USB_GADGET_DELAYED_STATUS, others imply), but perhaps
> it's not that bad provided that this discrepancy is documented.

This alternative is less desirable, because the legacy gadgets (some of 
which don't use the composite framework) may not be compatible with it.

And as a matter of general principle, allowing UDC drivers to start 
automatically send Status replies to 0-length control transfers is a 
step in the wrong direction.  What we really should focus our energy on 
is getting them to _stop_ sending automatic Status replies to 
non-zero-length control transfers!

Alan Stern
