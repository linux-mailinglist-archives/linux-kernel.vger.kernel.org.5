Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D076D133
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjHBPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjHBPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DC11F;
        Wed,  2 Aug 2023 08:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208D16186B;
        Wed,  2 Aug 2023 15:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BEBC433C8;
        Wed,  2 Aug 2023 15:13:07 +0000 (UTC)
Date:   Wed, 2 Aug 2023 11:13:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230802111306.4f52c1c6@gandalf.local.home>
In-Reply-To: <ZMpMgA85+DyGirXa@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
        <20230728164754.460767-2-vdonnefort@google.com>
        <20230801132603.0b18c0eb@gandalf.local.home>
        <20230802074526.2fa479ab@gandalf.local.home>
        <ZMpMgA85+DyGirXa@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 13:30:56 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Wed, Aug 02, 2023 at 07:45:26AM -0400, Steven Rostedt wrote:
> > On Tue, 1 Aug 2023 13:26:03 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > > +
> > > > +	if (READ_ONCE(cpu_buffer->mapped)) {
> > > > +		/* Ensure the meta_page is ready */
> > > > +		smp_rmb();
> > > > +		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
> > > > +			   local_read(&cpu_buffer->pages_touched));
> > > > +	}    
> > > 
> > > I was thinking instead of doing this in the semi fast path, put this logic
> > > into the rb_wakeup_waiters() code. That is, if a task is mapped, we call
> > > the irq_work() to do this for us. It could even do more, like handle
> > > blocked mapped waiters.  
> > 
> > I was thinking how to implement this, and I worry that it may cause an irq
> > storm. Let's keep this (and the other locations) as is, where we do the
> > updates in place. Then we can look at seeing if it is possible to do it in
> > a delayed fashion another time.  
> 
> I actually looking at this. How about:
> 
> On the userspace side, a simple poll:
> 
>   static void wait_entries(int fd)
>   {
>           struct pollfd pollfd = {
>                   .fd     = fd,
>                   .events = POLLIN,
>           };
>   
>           if (poll(&pollfd, 1, -1) == -1)
>                   pdie("poll");
>   }
> 
> And on the kernel side, just a function to update the "writer fields" of the
> meta-page:
> 
>    static void rb_wake_up_waiters(struct irq_work *work)
>    {
>           struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
>   +       struct ring_buffer_per_cpu *cpu_buffer =
>   +               container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
>   +
>   +       rb_update_meta_page(cpu_buffer);
>    
>           wake_up_all(&rbwork->waiters);
> 
> That would rate limit the number of updates to the meta-page without any irq storm?
> 

Is poll an issue? It requires user space to do a system call to see if
there's more data? But I guess that's not too much of an issue, as it needs
to do the ioctl to get the reader page.

We could also add an option to the ioctl to block, or have the ioctl honor
the NON_BLOCK flags of the fd?

-- Steve
