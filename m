Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A0477B919
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHNM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjHNM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:56:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6F13E;
        Mon, 14 Aug 2023 05:56:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4395C1F383;
        Mon, 14 Aug 2023 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692017773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLAW/PphNbg1TEhFiEypZB5q9ika6zqlbWoI7379ZzY=;
        b=U7WXAit58eY9yDdne/j+gIV85WE5olzqNpHNtsNiLrnkyRXIsMKz4YwZbscic+s6xLPGZp
        PYs0ZQa2NtEj3p/BZh49xYYe9vbIkCsZfZx2984z45jsHhAwIPIjFbNOlVKQUO0gssfSIi
        hSKfsWQlGjU8oq2APzyKrXyF1/1n+9E=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 902692C143;
        Mon, 14 Aug 2023 12:56:11 +0000 (UTC)
Date:   Mon, 14 Aug 2023 14:56:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Kees Cook' <keescook@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Message-ID: <ZNokaoSFTXeB_LP4@alley>
References: <20230811054528.never.165-kees@kernel.org>
 <42a1e2099fe141c3a57e808cbf06d8a0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a1e2099fe141c3a57e808cbf06d8a0@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-14 10:42:26, David Laight wrote:
> From: Kees Cook
> > Sent: 11 August 2023 06:46
> > 
> > If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> > copy_data() was causing writes to truncate. This manifested as output
> > bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> > record size was larger than 65536. Fix the cast to no longer truncate
> > the calculation.
> > 
> ...
> > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > index 2dc4d5a1f1ff..fde338606ce8 100644
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
> >  	if (!buf || !buf_size)
> >  		return true;
> > 
> > -	data_size = min_t(u16, buf_size, len);
> > +	data_size = min_t(unsigned int, buf_size, len);
> 
> I'd noticed that during one of my test compiles while looking
> at making min() less fussy.
> 
> A better fix would be:
> 	data_size = min(buf_size + 0u, len);

This looks like a magic to me. The types are:

	unsigned int data_size;
	unsigned int buf_size;
	u16 len

I would naively expect that

	data_size = min(buf_size, len);

would do the right job and expand @len to "unsigned int".

I do not remember why "min_t" was used. Was it an optimization?
Did we miss the problem with casting "u32" down to "u16"?

I tried to read the discussion at
https://lore.kernel.org/lkml/b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com/
but it is more about "signed" vs. "unsigned" problem. Maybe
it is more complicated that I expected.

> Or put an ack on my patch 3/5 to minmax.h and then min(buf_size, len)
> will be fine (because both arguments are unsigned).

Do you mean
https://lore.kernel.org/lkml/6dc20ac7cb6f4570a0160f076e8362e3@AcuMS.aculab.com/ ?
It seems to be just indentation cleanup.

Best Regards,
Petr

PS: I have already pushed the patch because it looked reasonable and
    got testing. I have to admit that I am probably in a pre-vacation
    hurry mode.
