Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C09797400
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjIGPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjIGPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D3E49
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88F731F88D;
        Thu,  7 Sep 2023 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694074953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzgoDD/bHhxHsVR5uf1gKe91bvDoRy0Td5lufA5XW4o=;
        b=EiLJXKR6BlyGqAK9GeYYVS4++O0v5ZIVWFoX1WQebvNNT7K9fgIpU89W3Q3TII1fbZzSyh
        GuoP+un48Lmp5I8ZyQ7ZZgNUeo+RnPf6MtWj0CiHuHxMhkEu4e0rhMyHYxubXlr2OeC8Z1
        TZm6G4ml+s1XvjoOntnw1Hp1RVGmlmo=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2ED062C142;
        Thu,  7 Sep 2023 08:22:33 +0000 (UTC)
Date:   Thu, 7 Sep 2023 10:22:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 6/7] printk: nbcon: Add emit function and
 callback function for atomic printing
Message-ID: <ZPmISE9olpOkPOM8@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:38, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Implement an emit function for nbcon consoles to output printk
> messages. It utilizes the lockless printk_get_next_message() and
> console_prepend_dropped() functions to retrieve/build the output
> message. The emit function includes the required safety points to
> check for handover/takeover and calls a new write_atomic callback
> of the console driver to output the message. It also includes
> proper handling for updating the nbcon console sequence number.
> 
> A new nbcon_write_context struct is introduced. This is provided
> to the write_atomic callback and includes only the information
> necessary for performing atomic writes.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Well, I would prefer one small change, see below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -732,6 +756,102 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
>  	return nbcon_context_can_proceed(ctxt, &cur);
>  }
>  
> +/**
> + * nbcon_emit_next_record - Emit a record in the acquired context
> + * @wctxt:	The write context that will be handed to the write function
> + *
> + * Return:	True if this context still owns the console. False if
> + *		ownership was handed over or taken.
> + *
> + * When this function returns false then the calling context no longer owns
> + * the console and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context. If the caller
> + * wants to do more it must reacquire the console first.
> + *
> + * When true is returned, @wctxt->ctxt.backlog indicates whether there are
> + * still records pending in the ringbuffer,
> + */
> +__maybe_unused
> +static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> +	struct printk_message pmsg = {
> +		.pbufs = ctxt->pbufs,
> +	};
> +	unsigned long con_dropped;
> +	struct nbcon_state cur;
> +	unsigned long dropped;
> +	bool done;
[...]
> +update_con:
> +	/*
> +	 * The dropped count and the sequence number are updated within an
> +	 * unsafe section. This limits update races to the panic context and
> +	 * allows the panic context to win.
> +	 */
> +
> +	if (!nbcon_context_update_unsafe(ctxt, true))
> +		return false;

I would prefer to use nbcon_enter_unsafe(). It is more self-explaining.
And it will make it easier to see the "all" enter/exit points using cscope.

> +
> +	if (dropped != con_dropped) {
> +		/* Counterpart to the READ_ONCE() above. */
> +		WRITE_ONCE(con->dropped, dropped);
> +	}
> +
> +	nbcon_seq_try_update(ctxt, pmsg.seq + 1);
> +
> +	return nbcon_context_update_unsafe(ctxt, false);
> +}

Best Regards,
Petr
