Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2E7A1903
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjIOIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjIOIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:38:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9F1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:38:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 759F92186F;
        Fri, 15 Sep 2023 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694767082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfgyyzazrOp9lV1wfwFfoCZhiUNB4T4EERql1ERZJ8A=;
        b=gI0wlMXwJJUUmgLw519e+ocIuJsOWQCaE+nOhNYG1+onzCkWe8UMbt4M9IpQ2usOGPCwfY
        SFP3ZiFVsYZJJ4cp99fQFhLlubZiH4jWPZodRUQLAm+Q1em9UjHpzaMRniUmFBcJScVFvO
        m6tUnOxjKGJ7hsZE2lNSqJcnAMFEIf8=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2201E2C142;
        Fri, 15 Sep 2023 08:38:02 +0000 (UTC)
Date:   Fri, 15 Sep 2023 10:38:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 8/8] printk: nbcon: Allow drivers to mark
 unsafe regions and check state
Message-ID: <ZQQX6V93nJGoBwfJ@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:08, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> For the write_atomic callback, the console driver may have unsafe
> regions that need to be appropriately marked. Provide functions
> that accept the nbcon_write_context struct to allow for the driver
> to enter and exit unsafe regions.
> 
> Also provide a function for drivers to check if they are still the
> owner of the console.
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index e2c274f4142e..04fac73c6e96 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -660,6 +660,32 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
>  	return false;
>  }
>  
> +/**
> + * nbcon_can_proceed - Check whether ownership can proceed
> + * @wctxt:	The write context that was handed to the write function
> + *
> + * Return:	True if this context still owns the console. False if
> + *		ownership was handed over or taken.
> + *
> + * Must be invoked at appropriate safe places in the driver.

This is a bit vague. I guess that enter_unsafe()/exit_unsafe() will be
used most of the time. The guestion is if this need to be called
in another locations explicitely.

I would write something similar as I suggested for nbcon_context_can_proceed():

  * It is used in nbcon_enter_unsafe() to make sure that it still owns the lock.
  * Also it is used in nbcon_exit_unsafe() to eventually free the lock
  * for a higher priority context which asked for the friendly handover.
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
> +bool nbcon_can_proceed(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +
> +	nbcon_state_read(con, &cur);
> +
> +	return nbcon_context_can_proceed(ctxt, &cur);
> +}
> +EXPORT_SYMBOL_GPL(nbcon_can_proceed);
> +

With the updated comment:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
