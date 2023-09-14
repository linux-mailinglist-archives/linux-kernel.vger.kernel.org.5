Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CA7A0A34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbjINQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbjINQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EFF26A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:02:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8101D21854;
        Thu, 14 Sep 2023 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694707337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vxq7URRkJPD07kiqLp7Cddy/GBYZW44bm+UVbfRiEz8=;
        b=ncDcfYgXND8KGTmBiH+nM4Byog92W+/0dnYtD6wHrpuCnTaxIXSdlgPD7m+v1z0RdYlT7o
        bolTgqHeL/geUfsJ8RjjDU/bwAPKmgeu17dFnhzE06SORWeyv6UA23L0wFwqIOxuMcPqdZ
        aWlFI/lpF2VcFqHmNGazTHDEg+GMkic=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 207CF2C142;
        Thu, 14 Sep 2023 16:02:17 +0000 (UTC)
Date:   Thu, 14 Sep 2023 18:02:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 6/8] printk: nbcon: Add sequence handling
Message-ID: <ZQMuiDPabS3t5TtT@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-7-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:06, John Ogness wrote:
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
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 644c4b9a4540..d23aa132fdcb 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> +/**
> + * nbcon_seq_init - Helper function to initialize the console sequence
> + * @con:	Console to work on
> + *
> + * Set @con->nbcon_seq to the starting record (specified with con->seq).
> + * If the starting record no longer exists, the oldest available record
> + * is chosen. This is especially important on 32bit systems because only
> + * the lower 32 bits of the sequence number are stored. The upper 32 bits
> + * are derived from the sequence numbers available in the ringbuffer.
> + *
> + * For init only. Do not use for runtime updates.
> + */
> +static void nbcon_seq_init(struct console *con)
> +{
> +	u64 seq = max_t(u64, con->seq, prb_first_valid_seq(prb));
> +
> +	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(seq));
> +
> +	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
> +	con->seq = 0;
> +}
> +
> +/**
> + * nbcon_seq_read - Read the current console sequence
> + * @con:	Console to read the sequence of
> + *
> + * Return:	Sequence number of the next record to print on @con.
> + */
> +u64 nbcon_seq_read(struct console *con)
> +{
> +	unsigned long nbcon_seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
> +
> +	return __nbcon_seq_to_seq(nbcon_seq);
> +}
> +
> +/**
> + * nbcon_seq_force - Force console sequence to a specific value
> + * @con:	Console to work on
> + * @seq:	Sequence number value to set
> + *
> + * Only to be used in extreme situations (such as panic with
> + * CONSOLE_REPLAY_ALL).
> + */
> +void nbcon_seq_force(struct console *con, u64 seq)
> +{
> +	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(seq));

We should actually do the same trick as in nbcon_seq_init() to make
sure that the 32-bit seq is shrinked against the prb_first_valid_seq().
I mean to do:

	/* If the starting record no longer exists, the oldest available record
	 * is chosen. This is especially important on 32bit systems because only
	 * the lower 32 bits of the sequence number are stored. The upper 32 bits
	 * are derived from the sequence numbers available in the ringbuffer.
	 */
	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));

	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(valid));

> +}

And we might implement nbcon_seq_init() using nbcon_seq_force(). I mean:

static void nbcon_seq_init(struct console *con)
{
	nbcon_seq_force(con->seq);

	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
	con->seq = 0;
}

> @@ -540,11 +649,14 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
>  	nbcon_context_release(ctxt);
>  
>  	/*
> -	 * It is not known whether the handover succeeded. The outermost
> -	 * callsite has to make the final decision whether printing
> -	 * should proceed or not (via reacquire, possibly hostile). The
> -	 * console is now unlocked so go back all the way instead of
> -	 * trying to implement heuristics in tons of places.
> +	 * It is not clear whether the waiter really took over ownership. The
> +	 * outermost callsite must make the final decision whether console
> +	 * ownership is needed for it to proceed. If yes, it must reacquire
> +	 * ownership (possibly hostile) before carefully proceeding.
> +	 *
> +	 * The calling context no longer owns the console so go back all the
> +	 * way instead of trying to implement reacquire heuristics in tons of
> +	 * places.
>  	 */
>  	return false;
>  }

This change probably should have been done in the patch introducing
nbcon_context_can_proceed().

> @@ -636,6 +748,8 @@ bool nbcon_alloc(struct console *con)
>   *
>   * nbcon_alloc() *must* be called and succeed before this function
>   * is called.
> + *
> + * This function expects that the legacy @con->seq has been set.
>   */
>  void nbcon_init(struct console *con)
>  {

Best Regards,
Petr
