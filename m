Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30EF765622
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjG0Omh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjG0Ome (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:42:34 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8418235A6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:42:18 -0700 (PDT)
Received: (qmail 1967770 invoked by uid 1000); 27 Jul 2023 10:42:17 -0400
Date:   Thu, 27 Jul 2023 10:42:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <73b58ff7-2a0a-43f7-bda9-52b9437f5bc0@rowland.harvard.edu>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
 <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:03:57PM +0800, liulongfang wrote:
> On 2023/7/26 22:20, Alan Stern wrote:
> >> It may be that the handling solution for ECC errors is different from that
> >> of the OS platform. On the test platform, after usb_control_msg() fails,
> >> reading the memory data of buf will directly lead to kernel crash:
> > 
> > All right, then here's a proposal for a different way to solve the 
> > problem: Change the kernel's handler for the ECC error notification.  
> > Have it clear the affected parts of memory, so that the kernel can go 
> > ahead and use them without crashing.
> > 
> > It seems to me that something along these lines must be necessary in 
> > any case.  Unless the bad memory is cleared somehow, it would never be 
> > usable again.  The kernel might deallocate it, then reallocate for 
> > another purpose, and then crash when the new user tries to access it.  
> > 
> > In fact, this scenario could still happen even with your patch, which 
> > means the patch doesn't really fix the problem.
> > 
> 
> This patch is only used to prevent data in the buffer from being accessed.
> As long as the data is not accessed, the kernel does not crash.

I still don't understand.  You haven't provided nearly enough 
information.  You should start by answering the questions that Oliver 
asked.  Then answer this question:

The code you are concerned about is this:

		r = usb_control_msg(udev, usb_rcvaddr0pipe(),
				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
				USB_DT_DEVICE << 8, 0,
				buf, GET_DESCRIPTOR_BUFSIZE,
				initial_descriptor_timeout);
		switch (buf->bMaxPacketSize0) {

You're worried that if an ECC memory error occurs during the 
usb_control_msg transfer, the kernel will crash when the "switch" 
statement tries to read the value of buf->bMaxPacketSize0.  That's a 
reasonable thing to worry about.

Now think about what will happen if usb_control_msg works successfully 
but an ECC memory error occurs when the return code from the function 
call is stored in r?  Won't the kernel crash then?  Or if not then, when 
it reads the value of r a few lines later?

So why bother to handle the first kind of ECC error but not the second?  
What makes one ECC error more important than another?

Alan Stern
