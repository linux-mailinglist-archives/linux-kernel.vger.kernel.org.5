Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A47A0979
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbjINPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbjINPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:38:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494ACC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:38:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7040E1F86A;
        Thu, 14 Sep 2023 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694705929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DS3lvxMhWCoHVji0cw3mIlmsOWdY16YXD2r5M37x5Ao=;
        b=GnjL2e8FhhFWoSkaj/IWLtBeviGFkh9tOYtfMsTSwgyvyI1gpF61gPnUxu8SeECELeV277
        udsfGb9oPp1OQPY6MkvSTY4p0OmNQ8iimeSEGnMIFaV4ISZ2L2bpl3mNL6SMF2EI071zuQ
        OQdQfIUsE1UpSYH4yia0RzYwXGuMvao=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1FF3E2C142;
        Thu, 14 Sep 2023 15:38:49 +0000 (UTC)
Date:   Thu, 14 Sep 2023 17:38:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 5/8] printk: nbcon: Add ownership state
 functions
Message-ID: <ZQMpCDKsfElXIXI7@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide functions that are related to the safe handover mechanism
> and allow console drivers to dynamically specify unsafe regions:
> 
>  - nbcon_context_can_proceed()
> 
>    Invoked by a console owner to check whether a handover request
>    is pending or whether the console has been taken over by another
>    context. If a handover request is pending, this function will
>    also perform the handover, thus cancelling its own ownership.
> 
>  - nbcon_context_enter_unsafe()/nbcon_context_exit_unsafe()
> 
>    Invoked by a console owner to denote that the driver is about
>    to enter or leave a critical region where a take over is unsafe.
>    These functions are also cancellation points where loss of
>    ownership can occur.

The last sentence is not completely clear to me. I would write:

     The exit variant is the point where the current owner releases
     the lock for a higher priority context which asked for
     the friendly handover.

>    The unsafe state is stored in the console state and allows a
>    new context to make informed decisions whether to attempt a
>    takeover of such a console. The unsafe state is also available
>    to the driver so that it can make informed decisions about the
>    required actions and possibly take a special emergency path.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -492,6 +491,115 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
>  	ctxt->pbufs = NULL;
>  }
>  
> +/**
> + * nbcon_context_can_proceed - Check whether ownership can proceed
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + * @cur:	The current console state
> + *
> + * Return:	True if this context still owns the console. False if
> + *		ownership was handed over or taken.
> + *
> + * Must be invoked after the record was dumped into the assigned buffer
> + * and at appropriate safe places in the driver.

I think that is not longer called explicitly in nbcon_emit_next_record().

I would write something like:

  * Must be invoked when entering the unsafe state to make sure that it still
  * owns the lock. Also must be invoked when exiting the unsafe context
  * to eventually free the lock for a higher priority context which asked
  * for the friendly handover.
  *
  * It can be called inside an unsafe section when the console is just
  * temporary in safe state instead of exiting and entering the unsafe
  * state.
  *
  * Also it can be called in the safe context before doing an expensive
  * safe operation. It does not make sense to do the operation when
  * a higher priority context took the lock.


> + *
> + * When this function returns false then the calling context no longer owns
> + * the console and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + */
> +static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();

With the proposed changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
