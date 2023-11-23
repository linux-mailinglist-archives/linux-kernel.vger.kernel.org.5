Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC17F5BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjKWKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjKWKIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:08:54 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C6F10F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:08:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso707562b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700734113; x=1701338913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jY5lmWDd+bwVJzI70rroTjaXbKeof76MmrzP7xLyxmI=;
        b=ng1j0ve3gwFiIyhQW7jl5tqLeHBnwC+SZhnnsYR+blry1oZtQPKba6g5VNG2lZhsul
         wH/M3JSSIj7jazkq8NZlvzaxIJxVypVnrM2lL+1x88VWM/SL1rmmmSjX9Qkg4QKMldBU
         0HAdY+ce58e4indSGry08h1Snn6q1O+Iiwfwor89Vwnliu5hADG0FD2x/GXzZRTcQv3+
         fgS3hZOTanCRtWyHaq7KitVoUR8P5RGE7Me75Y5MmoQztKMc6x8R5vVjJy5aqE9ZEKG4
         T0b2coJeaXm+d2PkJd5JsSgPM7OJmXHSKg/k7/GbrMdCXdfqkS2zfGZekrvaTEVcM/Ja
         rGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734113; x=1701338913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY5lmWDd+bwVJzI70rroTjaXbKeof76MmrzP7xLyxmI=;
        b=EKpefaoARjNvlV9f4NPj6Mykzq7LLxJdNPMtTARHw8/30rU08eu+HDCLoyK1Hen7Qk
         54kEOF85RI5AUqsbL1kCtpHEIbfPdtBRZB3MQmcuhD2XuKHQVEJ5Irjcr4ZnmcUZimx0
         q5H0OzwadmiGYpxjVA0LePYnKCdyvfI98bnM7M4qCKcQQ+W74a6p9cw5COipYJJNmuIb
         cofL1CNpxaG3/KUvSj48aDfVqwUXBCnPrOF/puUow0OkIiii/FhrmxXlphYywYUMAkZJ
         AaZe8uGPr2bsi/c9u0RM5i2WPle7UgoD8prg31px7+1IQUCdwMrGjWxf4LWSwZp1fC/y
         0WIQ==
X-Gm-Message-State: AOJu0YxQuVH4VzIyfXE7kXiJB8Yf+NsLJz1m+kTIOZClYF9gA4Y0jsYS
        J6GSiJwXMDmxNhPj6n+Kd3hGbtbuIU6OQw==
X-Google-Smtp-Source: AGHT+IGxAu8EtLSxP+gUaEG0MHXy3yx/qNKpzbfzRci5bxx9XWKIoGPzEAVh9XNOp9MW97qXcsipuQ==
X-Received: by 2002:a05:6a00:4c18:b0:6cb:913d:2cc6 with SMTP id ea24-20020a056a004c1800b006cb913d2cc6mr6057033pfb.15.1700734113218;
        Thu, 23 Nov 2023 02:08:33 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a001a8f00b006c4cfe40d11sm871357pfv.116.2023.11.23.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:08:32 -0800 (PST)
Date:   Thu, 23 Nov 2023 19:06:52 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yewon Choi <woni9911@gmail.com>, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <ZV8kPHlGoPYKORQn@dragonet>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
 <20231123074920.GA10480@libra05>
 <2023112331-wise-regain-72dc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112331-wise-regain-72dc@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 08:44:46AM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 23, 2023 at 04:49:22PM +0900, Yewon Choi wrote:
> > On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > > > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > > > and vmci_host_dev->context may cause uninitialized data access.
> > > > 
> > > > One of possible execution flows is as follows:
> > > > 
> > > > CPU 1 (vmci_host_do_init_context)
> > > > =====
> > > > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > > > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > > > 
> > > > CPU 2 (vmci_host_poll)
> > > > =====
> > > > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > > > 	context = vmci_host_dev->context; // 4
> > > > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > > > 
> > > > While ct_type serves as a flag indicating that context is initialized,
> > > > there is no memory barrier which prevents reordering between
> > > > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > > > vmci_host_dev->context.
> > > > In this case, the null dereference occurs in poll_wait().
> > > > 
> > > > In order to prevent this kind of reordering, we change plain accesses
> > > > to ct_type into smp_load_acquire() and smp_store_release().
> > > > 
> > > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > > > ---
> > > >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> > > >  1 file changed, 23 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > > > index abe79f6fd2a7..e83b6e0fe55b 100644
> > > > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > > > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > > > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> > > >  {
> > > >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> > > >  
> > > > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > > > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> > > 
> > > This is getting tricky, why not use a normal lock to ensure that all is
> > > safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> > > right?
> > > 
> > 
> > I think using locks can be considered orthogonal to correcting memory ordering. 
> 
> But they ensure proper memory ordering.

Yes, using a lock obviously ensures memory ordering.

> > If the lock is needed, we will need to add locks in all of them. I cannot be
> > sure which is better. Besides that, it seems to be a separate issue.
> 
> Nope, I think it's the same issue :)
> 
> > On the other hand, the current implementation doesn't guarantee memory ordering 
> > which leads to wrong behavior.
> > This patch fixes this issue by adding primitives. 
> 
> But it's still wrong, again, what keeps the value from changing right
> after checking it?
> 
> thanks,
> 
> greg k-h

It seems that VMCI assumes that vmci_host_dev->context is not NULL if
vmci_host_dev->ct_type == VMCIOBJ_CONTEXT (because all readers of
vmci_host_dev->context check whether vmci_host_dev->ct_type is
VMCIOBJ_CONTEXT or not, and access vmci_host_dev->context without
checking whether is it NULL or not). So I think this patch clarifies
this assumption.

As you said, we need to ensure that vmci_host_dev->context is not
changed after checking vmci_host_dev->ct_type. But
(1) the only place that changes vmci_host_dev->context is
vmci_host_close() and
(2) (I think) vmci_host_close() do not concurrently run with readers
of vmci_host_dev->context. IIUC, all readers of vmci_host_dev->context
are system calls (eg, ioctl handlers or the poll handler). So I think
the ref count of the file saves us here. (Otherwise, Syzkaller will
tell us the truth maybe?)

At least, this patch introduces no change of the logic but the
guarantees of the memory ordering, so I think this patch is safe?


Best regards,
Dae R. Jeong
