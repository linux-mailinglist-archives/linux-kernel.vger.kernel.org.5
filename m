Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606C787D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbjHYCJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjHYCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:09:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 68A492128
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:08:54 -0700 (PDT)
Received: (qmail 244973 invoked by uid 1000); 24 Aug 2023 22:08:53 -0400
Date:   Thu, 24 Aug 2023 22:08:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <8209aefa-5ab3-43dd-94f5-350e6d38cec2@rowland.harvard.edu>
References: <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
 <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
 <CA+fCnZcJ0JHHY04By+PjYvofpefKtp1br63gJNsEL=J7n1_vCA@mail.gmail.com>
 <bdf69b9d-fe82-48e2-9638-d84d00d4ef1d@rowland.harvard.edu>
 <20230823171757.vegbktpkk23eg34z@synopsys.com>
 <CA+fCnZdewxqN6jaOmah4Ptz5CaJoc6iKisFBMLujBGOD_6HoiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdewxqN6jaOmah4Ptz5CaJoc6iKisFBMLujBGOD_6HoiA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:36:36AM +0200, Andrey Konovalov wrote:
> So to summarize the issue wrt the 0-length requests:
> 
> 1. UDC drivers must always delay the status stage for 0-length
> requests until the gadget driver queues an empty request.

Any request, not necessarily empty (although it should be).  The request 
queued by the gadget driver _is_ the Status stage response; in this 
situation the UDC driver doesn't create one automatically.

> 2. Many UDC drivers do not do this, and only delay the status stage
> when USB_GADGET_DELAYED_STATUS is returned from ->setup(). Some
> drivers also assume that only a SET_CONFIGURATION request can be
> delayed.
> 
> 3. All such UDC drivers should be fixed and USB_GADGET_DELAYED_STATUS
> should be contained within the composite framework.
> 
> 4. Fixing all such UDC drivers is a non-trivial amount of work, but
> this is the goal to strive towards.
> 
> Alan, would it be acceptable if I add custom handling of
> USB_GADGET_DELAYED_STATUS to Raw Gadget in the meantime? It would be

Sure.  It's your driver; do whatever you want with it.  :-)

> great to keep it at least somewhat working with dwc3. I can also do it
> for GadgetFS, if you think it's a good idea.

I suspect gadgetfs doesn't need it.  But go ahead and look through the 
code to check for yourself; I might be wrong.

> I can also add some clarifying comments for USB_GADGET_DELAYED_STATUS
> and ->setup() to hopefully avoid having new UDC drivers being added
> with the same issue (e.g. cdns2 and renesas_usbf with the same issue
> were added just recently).

Good idea, although mistakes like this tend to propagate more through 
copy-and-paste than by failures of documentation.

> Maybe it's also a good idea to add a checkpatch.pl check for using
> USB_GADGET_DELAYED_STATUS in UDC drivers. Or maybe ask Greg to keep an
> eye out for this?

I wouldn't try to modify checkpatch.pl.

Alan Stern
