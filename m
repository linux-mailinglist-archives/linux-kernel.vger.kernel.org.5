Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963D793D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjIFN0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjIFN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:26:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B210E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:26:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 83E8C1F459;
        Wed,  6 Sep 2023 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694006775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPEx/as2GZuIMuZSiPTwrqmnZcEPZ5iPb0RuDEC2pEI=;
        b=fTe4UDRUH45Di70HOKDhVdrs7CP5B1Rg0HW2IKpo6tpN66ZD6GGnU08bf7nuT0zLsKzUcv
        6ekx7UlCNEHXnt6D7H5rWcm274vNOSSgt+lfwASvkt+Z+pccvs1wsJdBUVhQ+20SgIz0gx
        xwtCQSvGruQHrvwFI1JQbZW46x+tNbU=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 346CF2C142;
        Wed,  6 Sep 2023 13:26:15 +0000 (UTC)
Date:   Wed, 6 Sep 2023 15:26:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 3/7] printk: nbcon: Add buffer management
Message-ID: <ZPh99nwo9zJXxqQz@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:35, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In case of hostile takeovers it must be ensured that the previous
> owner cannot scribble over the output buffer of the emergency/panic
> context. This is achieved by:
> 
>  - Adding a global output buffer instance for the panic context.
>    This is the only situation where hostile takeovers can occur and
>    there is always at most 1 panic context.
> 
>  - Allocating an output buffer per console upon console
>    registration. This buffer is used by the console owner when not
>    in panic context.
> 
>  - Choosing the appropriate buffer is handled in the acquire/release
>    functions.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -503,6 +514,30 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
>  		new.unsafe |= cur.unsafe_takeover;
>  
>  	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
> +
> +	ctxt->pbufs = NULL;
> +}
> +
> +/**
> + * nbcon_alloc - Allocate buffers needed by the nbcon console
> + * @con:	Console to initialize
> + *
> + * Return:	True on success. False otherwise and the console cannot
> + *		be used.
> + *
> + * This is not part of nbcon_init() because buffer allocation must
> + * be performed earlier in the console registration process.
> + */
> +bool nbcon_alloc(struct console *con)
> +{
> +
> +	con->pbufs = kmalloc(sizeof(*con->pbufs), GFP_KERNEL);

We might need to use memblock_alloc() at least for early consoles.

mm_core_init() is called after processing the kernel parameters.

For example, setup_log_buf() or vfs_caches_init_early() use
memblock_alloc() as well.

> +	if (!con->pbufs) {
> +		con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
> +		return false;
> +	}
> +
> +	return true;
>  }
>  
>  /**
> @@ -525,4 +563,6 @@ void nbcon_cleanup(struct console *con)
>  	struct nbcon_state state = { };
>  
>  	nbcon_state_set(con, &state);
> +	kfree(con->pbufs);
> +	con->pbufs = NULL;

It would be cleaner to create nbcon_free() as a counter part
for nbcon_alloc().

>  }

Best Regards,
Petr
