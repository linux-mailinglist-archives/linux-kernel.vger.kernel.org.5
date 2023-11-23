Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFE7F5EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjKWMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbjKWMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBB1B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:21:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60121C433C7;
        Thu, 23 Nov 2023 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700742078;
        bh=axcY6bN4nPTnjK8UDyanLoJcrQAdgOa6cRLjz7SRy80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InU5uxLSEcLHcpOinjXrVSBv4Ld0cB+O5d1NFzrM2Q62mmFM6dC2HCTb5X87AP+xe
         TRfqHYqxc5yupOuWHv0avtZo0/IjCqhNp9AxaNmdp4hwvd/9a2eJs5nx5paQJbM2JL
         102jtC5feqZi+P1P7/Dluo01S/Ft9g1XrQGdgeRg=
Date:   Thu, 23 Nov 2023 12:21:12 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     Yewon Choi <woni9911@gmail.com>, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <2023112319-sureness-anyplace-ecb7@gregkh>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
 <20231123074920.GA10480@libra05>
 <2023112331-wise-regain-72dc@gregkh>
 <ZV8kPHlGoPYKORQn@dragonet>
 <2023112352-congested-puzzling-f76d@gregkh>
 <ZV8yrfAnCv-sxLbq@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV8yrfAnCv-sxLbq@dragonet>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 08:08:29PM +0900, Dae R. Jeong wrote:
> On Thu, Nov 23, 2023 at 10:14:52AM +0000, Greg Kroah-Hartman wrote:
> > On Thu, Nov 23, 2023 at 07:06:52PM +0900, Dae R. Jeong wrote:
> > > On Thu, Nov 23, 2023 at 08:44:46AM +0000, Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 23, 2023 at 04:49:22PM +0900, Yewon Choi wrote:
> > > > > On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > > > > > > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > > > > > > and vmci_host_dev->context may cause uninitialized data access.
> > > > > > > 
> > > > > > > One of possible execution flows is as follows:
> > > > > > > 
> > > > > > > CPU 1 (vmci_host_do_init_context)
> > > > > > > =====
> > > > > > > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > > > > > > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > > > > > > 
> > > > > > > CPU 2 (vmci_host_poll)
> > > > > > > =====
> > > > > > > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > > > > > > 	context = vmci_host_dev->context; // 4
> > > > > > > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > > > > > > 
> > > > > > > While ct_type serves as a flag indicating that context is initialized,
> > > > > > > there is no memory barrier which prevents reordering between
> > > > > > > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > > > > > > vmci_host_dev->context.
> > > > > > > In this case, the null dereference occurs in poll_wait().
> > > > > > > 
> > > > > > > In order to prevent this kind of reordering, we change plain accesses
> > > > > > > to ct_type into smp_load_acquire() and smp_store_release().
> > > > > > > 
> > > > > > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> > > > > > >  1 file changed, 23 insertions(+), 17 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > > index abe79f6fd2a7..e83b6e0fe55b 100644
> > > > > > > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> > > > > > >  {
> > > > > > >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> > > > > > >  
> > > > > > > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > > > > > > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> > > > > > 
> > > > > > This is getting tricky, why not use a normal lock to ensure that all is
> > > > > > safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> > > > > > right?
> > > > > > 
> > > > > 
> > > > > I think using locks can be considered orthogonal to correcting memory ordering. 
> > > > 
> > > > But they ensure proper memory ordering.
> > > 
> > > Yes, using a lock obviously ensures memory ordering.
> > > 
> > > > > If the lock is needed, we will need to add locks in all of them. I cannot be
> > > > > sure which is better. Besides that, it seems to be a separate issue.
> > > > 
> > > > Nope, I think it's the same issue :)
> > > > 
> > > > > On the other hand, the current implementation doesn't guarantee memory ordering 
> > > > > which leads to wrong behavior.
> > > > > This patch fixes this issue by adding primitives. 
> > > > 
> > > > But it's still wrong, again, what keeps the value from changing right
> > > > after checking it?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > It seems that VMCI assumes that vmci_host_dev->context is not NULL if
> > > vmci_host_dev->ct_type == VMCIOBJ_CONTEXT (because all readers of
> > > vmci_host_dev->context check whether vmci_host_dev->ct_type is
> > > VMCIOBJ_CONTEXT or not, and access vmci_host_dev->context without
> > > checking whether is it NULL or not). So I think this patch clarifies
> > > this assumption.
> > > 
> > > As you said, we need to ensure that vmci_host_dev->context is not
> > > changed after checking vmci_host_dev->ct_type. But
> > > (1) the only place that changes vmci_host_dev->context is
> > > vmci_host_close() and
> > 
> > Then why is it even checked in close()?
> 
> It is because close() needs to destory vmci_host_dev->context if it is
> created.
> 
> > > (2) (I think) vmci_host_close() do not concurrently run with readers
> > > of vmci_host_dev->context. IIUC, all readers of vmci_host_dev->context
> > > are system calls (eg, ioctl handlers or the poll handler). So I think
> > > the ref count of the file saves us here. (Otherwise, Syzkaller will
> > > tell us the truth maybe?)
> > 
> > Ok, then why is this needed to be checked then at all?
> 
> It is because vmci_host_dev->context is created by
> ioctl(IOCTL_VMCI_INIT_CONTEXT). So it is possible that vmci_host_dev
> is created but vmci_host_dev->context is *not* created. All other
> places should be careful of this.
> 
> > > At least, this patch introduces no change of the logic but the
> > > guarantees of the memory ordering, so I think this patch is safe?
> > 
> > I think the logic is incorrect, don't try to paper over it thinking that
> > the issue to be solved is "memory ordering" please.  Solve the root
> > issue here.
> 
> I don't exactly get the point what you think the root issue is.
> 
> We can have a system call sequence like this:
> fd = open("/dev/vmci")
> ioctl(fd, VMCI_VERSION2, user_version)
> ioctl(fd, INIT_CONTEXT) // this somewhat depends on ioctl(VMCI_VERSION2) as it runs `context->user_version = user_version`
> 
> Between open() and ioctl(INIT_CONTEXT), we have vmci_host_dev
> initialized but vmci_host_dev->context is not initialized. We need to
> check whether vmci_host_dev->context is initialized in other
> places. And I still think store_release/load_acquire can be used to
> declare that context is created and check whether context is created
> or not. Please excuse me if I'm wrong...

What race can happen here that you are trying to prevent?  If you don't
think a lock is needed as all you want to do is ensure that context is
set properly, then it doesn't matter if you race with a different
process to that check, as that is going to happen from different
processes and you can't guarantee anything there (even with a lock, one
will win first.)

So I don't see the problem here, except for the complexity involved in
this code for trying to keep a state of the device in a local variable
that can be accessed by multiple callers at the same time and somehow
userspace thinks it will be automatically synced properly despite it not
wanting to break it on purpose?

Either use a real lock because you want to guarantee ordering here, or
just leave it alone as it doesn't matter.

To be explicit, is this something that you are seeing in real workloads
for this driver?  If so, what is the call trace that is happening and
who is in charge of that userspace code?

thanks,

greg k-h
