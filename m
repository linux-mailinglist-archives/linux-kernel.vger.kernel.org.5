Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB97B715D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbjJCSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjJCSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:55:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD99B;
        Tue,  3 Oct 2023 11:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55796C433C8;
        Tue,  3 Oct 2023 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696359304;
        bh=NFKhnj+jEO3QAJ7YWzF+twV7T5lsxhFLQX1vu6FAjtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iydG4IaZiHYTjC/gHXlx8VgRUoLtUy5Kbv+c3Fx7JfLbmZW6haKxTAdJ52IuCyg0e
         wZrzZ/9lV9QazYC7ziaD7V6pzDR83XLmaNmwss3DQpZvQZ/JxX7FqGC5YcPTOaWvHH
         7cHac1r0n7yhaLbj6yFU0QCTixxPEGQxxpjM28+tIcejCA7QjXFyS2vKKHwdySN2hS
         570FzNYpumwRrNHBuLCfKcjflq0IBy5nBvCRs5WXkmwlErla96FmETEwGnGQA0KCwB
         hEpB+RkJ/fE7pKX5+Ikas5G5/PGaYJ3uZyAQjVrfUZV0AWta4uEFAY/FFhxUUEiBAv
         uWiL8afRccabA==
Date:   Tue, 3 Oct 2023 19:55:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231003185500.GD8453@google.com>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100320-immorally-outboard-573a@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023, Greg Kroah-Hartman wrote:

> On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> > The important part of the call stack being:
> > 
> >   gsmld_write()             # Takes a lock and disables IRQs
> >     con_write()
> >       console_lock()
> 
> Wait, why is the n_gsm line discipline being used for a console?
> 
> What hardware/protocol wants this to happen?
> 
> gsm I thought was for a very specific type of device, not a console.
> 
> As per:
> 	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
> this is a specific modem protocol, why is con_write() being called?

What it's meant for and what random users can make it do are likely to
be quite separate questions.  This scenario is user driven and can be
replicated simply by issuing a few syscalls (open, ioctl, write).

> >         __might_sleep()
> >           __might_resched() # Complains that IRQs are disabled
> > 
> > To fix this, let's ensure mutual exclusion by using a protected shared
> > variable (busy) instead.  We'll use the current locking mechanism to
> > protect it, but ensure that the locks are released and IRQs re-enabled
> > by the time we transit further down the call chain which may sleep.
> > 
> > Cc: Daniel Starke <daniel.starke@siemens.com>
> > Cc: Fedor Pchelkin <pchelkin@ispras.ru>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/tty/n_gsm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 1f3aba607cd51..b83a97d58381f 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -270,6 +270,7 @@ struct gsm_mux {
> >  	struct tty_struct *tty;		/* The tty our ldisc is bound to */
> >  	spinlock_t lock;
> >  	struct mutex mutex;
> > +	bool busy;
> >  	unsigned int num;
> >  	struct kref ref;
> >  
> > @@ -3253,6 +3254,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
> >  	gsm->dead = true;	/* Avoid early tty opens */
> >  	gsm->wait_config = false; /* Disabled */
> >  	gsm->keep_alive = 0;	/* Disabled */
> > +	gsm->busy = false;
> >  
> >  	/* Store the instance to the mux array or abort if no space is
> >  	 * available.
> > @@ -3718,11 +3720,21 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
> >  
> >  	ret = -ENOBUFS;
> >  	spin_lock_irqsave(&gsm->tx_lock, flags);
> > +	if (gsm->busy) {
> > +		spin_unlock_irqrestore(&gsm->tx_lock, flags);
> > +		return -EBUSY;
> 
> So you just "busted" the re-entrant call chain here, are you sure this
> is ok for this protocl?  Can it handle -EBUSY?

I should have marked this submission as RFC.  Mea culpa.  Please
consider it as such going forward.  Feedback like this is highly
valuable.

> Daniel, any thoughts?
> 
> And Lee, you really don't have this hardware, right?  So why are you
> dealing with bug reports for it?  :)

'cos Syzkaller.

And no, as per the splat above, this was reproduced in qemu.

-- 
Lee Jones [李琼斯]
