Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE027F5A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKWIos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKWIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:44:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19ACBC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:44:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF9AC433C9;
        Thu, 23 Nov 2023 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700729091;
        bh=dtaLQq/bqc1M0xpR/qmqubmgPbyfTmY1kfj1QmiH7Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg5qffX8KHPfF3Apj4rjZwOrxOfUs5uLp+HPb8N3pCHXuXdVUW0TNK/NIMPq9nglQ
         q7Kt/a/FSDnXOJiW4jXHZTnEi3dMCAzWYYp9XoQnzN9lrkqKTMBLnQQDpFfXQ5LdPw
         t7z4XsCsJ2yRUkif0TZl4YjpCv74+ZC9XRbiJwdU=
Date:   Thu, 23 Nov 2023 08:44:46 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yewon Choi <woni9911@gmail.com>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        threeearcat@gmail.com
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <2023112331-wise-regain-72dc@gregkh>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
 <20231123074920.GA10480@libra05>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123074920.GA10480@libra05>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:49:22PM +0900, Yewon Choi wrote:
> On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> > On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > > and vmci_host_dev->context may cause uninitialized data access.
> > > 
> > > One of possible execution flows is as follows:
> > > 
> > > CPU 1 (vmci_host_do_init_context)
> > > =====
> > > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > > 
> > > CPU 2 (vmci_host_poll)
> > > =====
> > > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > > 	context = vmci_host_dev->context; // 4
> > > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > > 
> > > While ct_type serves as a flag indicating that context is initialized,
> > > there is no memory barrier which prevents reordering between
> > > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > > vmci_host_dev->context.
> > > In this case, the null dereference occurs in poll_wait().
> > > 
> > > In order to prevent this kind of reordering, we change plain accesses
> > > to ct_type into smp_load_acquire() and smp_store_release().
> > > 
> > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > > ---
> > >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> > >  1 file changed, 23 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > > index abe79f6fd2a7..e83b6e0fe55b 100644
> > > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> > >  {
> > >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> > >  
> > > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> > 
> > This is getting tricky, why not use a normal lock to ensure that all is
> > safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> > right?
> > 
> 
> I think using locks can be considered orthogonal to correcting memory ordering. 

But they ensure proper memory ordering.

> As you pointed out, vmci_host_close is not a performance-critical function
> while other functions using vmci_host_dev->context are performance-critical.

In what way?  Why is the context being constantly checked in such
situations?  And if so, it can change right after being checked so a
real lock needs to be used.

> If the lock is needed, we will need to add locks in all of them. I cannot be
> sure which is better. Besides that, it seems to be a separate issue.

Nope, I think it's the same issue :)

> On the other hand, the current implementation doesn't guarantee memory ordering 
> which leads to wrong behavior.
> This patch fixes this issue by adding primitives. 

But it's still wrong, again, what keeps the value from changing right
after checking it?

thanks,

greg k-h
