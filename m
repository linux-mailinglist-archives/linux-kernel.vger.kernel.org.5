Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92303765822
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjG0P5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjG0P5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:57:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DE9E5271E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:57:43 -0700 (PDT)
Received: (qmail 1994833 invoked by uid 1000); 27 Jul 2023 11:57:43 -0400
Date:   Thu, 27 Jul 2023 11:57:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     liulongfang <liulongfang@huawei.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <c827147f-793b-49ae-8549-3c5d4e8a7264@rowland.harvard.edu>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
 <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
 <73b58ff7-2a0a-43f7-bda9-52b9437f5bc0@rowland.harvard.edu>
 <e983fecd-ff59-e97e-0099-b33685d45d00@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e983fecd-ff59-e97e-0099-b33685d45d00@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:31:41PM +0200, Oliver Neukum wrote:
> On 27.07.23 16:42, Alan Stern wrote:
> > On Thu, Jul 27, 2023 at 03:03:57PM +0800, liulongfang wrote:
> > > On 2023/7/26 22:20, Alan Stern wrote:
> 
> > > > It seems to me that something along these lines must be necessary in
> > > > any case.  Unless the bad memory is cleared somehow, it would never be
> > > > usable again.  The kernel might deallocate it, then reallocate for
> > > > another purpose, and then crash when the new user tries to access it.
> > > > 
> > > > In fact, this scenario could still happen even with your patch, which
> > > > means the patch doesn't really fix the problem.
> 
> I suppose in theory you could have something like a bad blocks list
> just for RAM, but that would really hurt. You'd have to do something
> about every DMA operation in every driver in theory.
> 
> Error handling would basically be an intentional memory leak.

I started out thinking this way, but maybe that's not how it works.  
Perhaps simply overwriting the part of memory that got the ECC error 
would clear the error state.  (This may depend on the kind of error, 
one-time vs. permanent.)

If that's the case, and if the memory buffer was deallocated without 
being accessed and then later reallocated, things would be okay.  The 
routine that reallocated the buffer wouldn't try to read from it before 
initializing it somehow.

> > > This patch is only used to prevent data in the buffer from being accessed.
> > > As long as the data is not accessed, the kernel does not crash.
> > 
> > I still don't understand.  You haven't provided nearly enough
> > information.  You should start by answering the questions that Oliver
> > asked.  Then answer this question:
> > 
> > The code you are concerned about is this:
> > 
> > 		r = usb_control_msg(udev, usb_rcvaddr0pipe(),
> > 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> > 				USB_DT_DEVICE << 8, 0,
> > 				buf, GET_DESCRIPTOR_BUFSIZE,
> > 				initial_descriptor_timeout);
> > 		switch (buf->bMaxPacketSize0) {
> > 
> > You're worried that if an ECC memory error occurs during the
> > usb_control_msg transfer, the kernel will crash when the "switch"
> > statement tries to read the value of buf->bMaxPacketSize0.  That's a
> > reasonable thing to worry about.
> 
> Albeit unlikely. If the hardware and implementation are reasonable
> you'd return a specific error code from the HCD and clean up the
> RAM in your ecc driver.
> 
> The fix for USB would then conceptually be something like
> 
> retryio:
> 	r = usb_control_msg()
> 	if (r == -EMEMORYCORRUPTION)
> 		goto retryio;

Yes, we could do this, but it's not necessary.  Let's say that the HCD 
returns -EMEMORYCORRUPTION and the ecc driver cleans up the RAM 
(probably by resetting its contents to 0, but possibly leaving garbage 
there instead).  Then when the following code in hub_port_init() tests 
buf->bMaxPacketSize0, it will see an invalid value and will retry the 
transfer.

Or, with low probability, it will see a valid but incorrect value.  If 
that happens then later transfers using ep0 will fail, causing the hub 
driver to reiterate the outer loop in hub_port_connect().  Eventually 
the device will be correctly initialized and enumerated.

Alan Stern
