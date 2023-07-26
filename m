Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454497638EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjGZOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjGZOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:20:28 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 68AE411F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:20:26 -0700 (PDT)
Received: (qmail 1924077 invoked by uid 1000); 26 Jul 2023 10:20:25 -0400
Date:   Wed, 26 Jul 2023 10:20:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:58:18PM +0800, liulongfang wrote:
> On 2023/7/21 22:57, Alan Stern Wrote:
> > On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
> >> On systems that use ECC memory. The ECC error of the memory will
> >> cause the USB controller to halt. It causes the usb_control_msg()
> >> operation to fail.
> > 
> > How often does this happen in real life?  (Besides, it seems to me that 
> > if your system is getting a bunch of ECC memory errors then you've got 
> > much worse problems than a simple USB failure!)
> >
> 
> This problem is on ECC memory platform.
> In the test scenario, the problem is 100% reproducible.
> 
> > And why do you worry about ECC memory failures in particular?  Can't 
> > _any_ kind of failure cause the usb_control_msg() operation to fail?
> > 
> >> At this point, the returned buffer data is an abnormal value, and
> >> continuing to use it will lead to incorrect results.
> > 
> > The driver already contains code to check for abnormal values.  The 
> > check is not perfect, but it should prevent things from going too 
> > badly wrong.
> >
> 
> If it is ECC memory error. These parameter checks would also
> actually be invalid.
> 
> >> Therefore, it is necessary to judge the return value and exit.
> >>
> >> Signed-off-by: liulongfang <liulongfang@huawei.com>
> > 
> > There is a flaw in your reasoning.
> > 
> > The operation carried out here is deliberately unsafe (for full-speed 
> > devices).  It is made before we know the actual maxpacket size for ep0, 
> > and as a result it might return an error code even when it works okay.  
> > This shouldn't happen, but a lot of USB hardware is unreliable.
> > 
> > Therefore we must not ignore the result merely because r < 0.  If we do 
> > that, the kernel might stop working with some devices.
> > 
> It may be that the handling solution for ECC errors is different from that
> of the OS platform. On the test platform, after usb_control_msg() fails,
> reading the memory data of buf will directly lead to kernel crash:

All right, then here's a proposal for a different way to solve the 
problem: Change the kernel's handler for the ECC error notification.  
Have it clear the affected parts of memory, so that the kernel can go 
ahead and use them without crashing.

It seems to me that something along these lines must be necessary in 
any case.  Unless the bad memory is cleared somehow, it would never be 
usable again.  The kernel might deallocate it, then reallocate for 
another purpose, and then crash when the new user tries to access it.  

In fact, this scenario could still happen even with your patch, which 
means the patch doesn't really fix the problem.

Alan Stern
