Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC47B709B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjJCSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjJCSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FDAF;
        Tue,  3 Oct 2023 11:14:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF6AC433C9;
        Tue,  3 Oct 2023 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696356895;
        bh=8GoDX/lQWvZX83VR+w8ZgUvPrV/g+cmMeP0xEH3Sras=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGTl4pkMUq/U7oa/9mlZKnVyDUGV0B/kyreObHCMvVsUMKXABrHa6mAbU43zLnRq/
         PO2W31KFoJH7edCCkm5XH4zVT1jjJgtx1FCqVwq+e04D4RVcPH3VgDixwS2BmIlq6R
         ugFgnPMzX57NqHHwGRRElwJSZcFrk80KNW8cTUHA=
Date:   Tue, 3 Oct 2023 20:14:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100320-immorally-outboard-573a@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003170020.830242-1-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> The important part of the call stack being:
> 
>   gsmld_write()             # Takes a lock and disables IRQs
>     con_write()
>       console_lock()

Wait, why is the n_gsm line discipline being used for a console?

What hardware/protocol wants this to happen?

gsm I thought was for a very specific type of device, not a console.

As per:
	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
this is a specific modem protocol, why is con_write() being called?


>         __might_sleep()
>           __might_resched() # Complains that IRQs are disabled
> 
> To fix this, let's ensure mutual exclusion by using a protected shared
> variable (busy) instead.  We'll use the current locking mechanism to
> protect it, but ensure that the locks are released and IRQs re-enabled
> by the time we transit further down the call chain which may sleep.
> 
> Cc: Daniel Starke <daniel.starke@siemens.com>
> Cc: Fedor Pchelkin <pchelkin@ispras.ru>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/tty/n_gsm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 1f3aba607cd51..b83a97d58381f 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -270,6 +270,7 @@ struct gsm_mux {
>  	struct tty_struct *tty;		/* The tty our ldisc is bound to */
>  	spinlock_t lock;
>  	struct mutex mutex;
> +	bool busy;
>  	unsigned int num;
>  	struct kref ref;
>  
> @@ -3253,6 +3254,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  	gsm->dead = true;	/* Avoid early tty opens */
>  	gsm->wait_config = false; /* Disabled */
>  	gsm->keep_alive = 0;	/* Disabled */
> +	gsm->busy = false;
>  
>  	/* Store the instance to the mux array or abort if no space is
>  	 * available.
> @@ -3718,11 +3720,21 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
>  
>  	ret = -ENOBUFS;
>  	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	if (gsm->busy) {
> +		spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +		return -EBUSY;

So you just "busted" the re-entrant call chain here, are you sure this
is ok for this protocl?  Can it handle -EBUSY?

Daniel, any thoughts?

And Lee, you really don't have this hardware, right?  So why are you
dealing with bug reports for it?  :)

thanks,

greg k-h
