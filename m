Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160B8797A36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbjIGRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbjIGRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:33:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6010F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:32:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 433D92183F;
        Thu,  7 Sep 2023 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694072751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVitCV73IEm0U/wyQ7OOiYOL7wy9AT7hlb2FIBZpCK8=;
        b=WisQYHIJRlfAWVGsPogQXOT0fM8ccBe3CEvgxsKZwhycCgOHtYX92xFzXY46Rk03Hs1UcO
        CsQTV2j5Xp44kMDAzqK/j7yoLDLlxPgzVoQXWoJFz9JOWo9JhdVQzBejP87wJuBlc6zX/z
        CIrgjgctWbykzxj6D/oIK44g1jybFNk=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAD592C143;
        Thu,  7 Sep 2023 07:45:50 +0000 (UTC)
Date:   Thu, 7 Sep 2023 09:45:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 5/7] printk: nbcon: Add sequence handling
Message-ID: <ZPl_rvMGCg_u538g@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:37, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add an atomic_long_t field @nbcon_seq to the console struct to
> store the sequence number for nbcon consoles. For nbcon consoles
> this will be used instead of the non-atomic @seq field. The new
> field allows for safe atomic sequence number updates without
> requiring any locking.
> 
> On 64bit systems the new field stores the full sequence number.
> On 32bit systems the new field stores the lower 32 bits of the
> sequence number, which are expanded to 64bit as needed by
> folding the values based on the sequence numbers available in
> the ringbuffer.
> 
> For 32bit systems, having a 32bit representation in the console
> is sufficient. If a console ever gets more than 2^31 records
> behind the ringbuffer then this is the least of the problems.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> +/**
> + * nbcon_seq_try_update - Try to update the console sequence number
> + * @ctxt:	Pointer to an acquire context that contains
> + *		all information about the acquire mode
> + * @new_seq:	The new sequence number to set
> + *
> + * @ctxt->seq is updated to the new value of @con::nbcon_seq. This could
> + * be a different value than @new_seq if nbcon_seq_force() was used or the
> + * current context no longer owns the console. In the later case, it will
> + * stop printing anyway.
> + */
> +__maybe_unused
> +static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
> +{
> +	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
> +	struct console *con = ctxt->console;
> +
> +	if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &nbcon_seq,
> +				    __seq_to_nbcon_seq(new_seq))) {
> +		ctxt->seq = new_seq;
> +	} else {
> +		ctxt->seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));

This should be:

		ctxt->seq = nbcon_seq_read(con);

so that it extends the 32-bit nbcon_seq to the full 64-bit seq on
32-bit systems.

> +	}
> +}
> +
>  /**
>   * nbcon_context_try_acquire_direct - Try to acquire directly
>   * @ctxt:	The context of the caller

Otherwise, it looks good. With the above fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
