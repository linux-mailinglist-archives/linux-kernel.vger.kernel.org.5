Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD57F5C08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjKWKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:14:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC39F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:14:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB8C433C7;
        Thu, 23 Nov 2023 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700734496;
        bh=olc2VOouxGYvM14Tj0AO4e9V39Dc2KatskZsfmaluQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ncz0K9C0NVYZKPiSoS2Cb1mcs27qWL9MTuKhZ5hVaCnrtqPcVJuyqhtail7oRAK+J
         69ys7CjhlQh3ADDDZMlFn/wt0TSFNbYY44Ark43nOJhF3rWaVS6gm1ALQNO3ACPnUv
         wG5qeGRiIOzh2aTGIy84SQCfo6W+j1wEEYxzf7vo=
Date:   Thu, 23 Nov 2023 10:14:52 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     Yewon Choi <woni9911@gmail.com>, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <2023112352-congested-puzzling-f76d@gregkh>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
 <20231123074920.GA10480@libra05>
 <2023112331-wise-regain-72dc@gregkh>
 <ZV8kPHlGoPYKORQn@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV8kPHlGoPYKORQn@dragonet>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:06:52PM +0900, Dae R. Jeong wrote:
> On Thu, Nov 23, 2023 at 08:44:46AM +0000, Greg Kroah-Hartman wrote:
> > On Thu, Nov 23, 2023 at 04:49:22PM +0900, Yewon Choi wrote:
> > > On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> > > > On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > > > > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > > > > and vmci_host_dev->context may cause uninitialized data access.
> > > > > 
> > > > > One of possible execution flows is as follows:
> > > > > 
> > > > > CPU 1 (vmci_host_do_init_context)
> > > > > =====
> > > > > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > > > > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > > > > 
> > > > > CPU 2 (vmci_host_poll)
> > > > > =====
> > > > > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > > > > 	context = vmci_host_dev->context; // 4
> > > > > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > > > > 
> > > > > While ct_type serves as a flag indicating that context is initialized,
> > > > > there is no memory barrier which prevents reordering between
> > > > > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > > > > vmci_host_dev->context.
> > > > > In this case, the null dereference occurs in poll_wait().
> > > > > 
> > > > > In order to prevent this kind of reordering, we change plain accesses
> > > > > to ct_type into smp_load_acquire() and smp_store_release().
> > > > > 
> > > > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > > > > ---
> > > > >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> > > > >  1 file changed, 23 insertions(+), 17 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > index abe79f6fd2a7..e83b6e0fe55b 100644
> > > > > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > > > > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> > > > >  {
> > > > >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> > > > >  
> > > > > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > > > > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> > > > 
> > > > This is getting tricky, why not use a normal lock to ensure that all is
> > > > safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> > > > right?
> > > > 
> > > 
> > > I think using locks can be considered orthogonal to correcting memory ordering. 
> > 
> > But they ensure proper memory ordering.
> 
> Yes, using a lock obviously ensures memory ordering.
> 
> > > If the lock is needed, we will need to add locks in all of them. I cannot be
> > > sure which is better. Besides that, it seems to be a separate issue.
> > 
> > Nope, I think it's the same issue :)
> > 
> > > On the other hand, the current implementation doesn't guarantee memory ordering 
> > > which leads to wrong behavior.
> > > This patch fixes this issue by adding primitives. 
> > 
> > But it's still wrong, again, what keeps the value from changing right
> > after checking it?
> > 
> > thanks,
> > 
> > greg k-h
> 
> It seems that VMCI assumes that vmci_host_dev->context is not NULL if
> vmci_host_dev->ct_type == VMCIOBJ_CONTEXT (because all readers of
> vmci_host_dev->context check whether vmci_host_dev->ct_type is
> VMCIOBJ_CONTEXT or not, and access vmci_host_dev->context without
> checking whether is it NULL or not). So I think this patch clarifies
> this assumption.
> 
> As you said, we need to ensure that vmci_host_dev->context is not
> changed after checking vmci_host_dev->ct_type. But
> (1) the only place that changes vmci_host_dev->context is
> vmci_host_close() and

Then why is it even checked in close()?

> (2) (I think) vmci_host_close() do not concurrently run with readers
> of vmci_host_dev->context. IIUC, all readers of vmci_host_dev->context
> are system calls (eg, ioctl handlers or the poll handler). So I think
> the ref count of the file saves us here. (Otherwise, Syzkaller will
> tell us the truth maybe?)

Ok, then why is this needed to be checked then at all?

> At least, this patch introduces no change of the logic but the
> guarantees of the memory ordering, so I think this patch is safe?

I think the logic is incorrect, don't try to paper over it thinking that
the issue to be solved is "memory ordering" please.  Solve the root
issue here.

thanks,

greg k-h
