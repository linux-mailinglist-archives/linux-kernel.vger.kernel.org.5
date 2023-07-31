Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AF769303
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjGaKWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGaKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:21:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39677E6F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:21:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA8E12230A;
        Mon, 31 Jul 2023 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690798894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFPUin3BTH5KkTUi/cDS3D3blp01XPuN4dipF/jRadY=;
        b=r+YyO5OJsrpyOfI/QDvo4SY7B23V5QFrnhHB/lnHdQxvcScdQud7+rnYzqTu4/p7Md5vLS
        865OlGDy2z/fINyOFoohZvHEhZT50I0B6pr+4dUbUFMqlO9AjwYa1YRFlYdVlXTrBRulm5
        sVndnVCJOvAt5aI8SwGbxRdpI0KO4w4=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 93B162C142;
        Mon, 31 Jul 2023 10:21:33 +0000 (UTC)
Date:   Mon, 31 Jul 2023 12:21:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jim Cromie <jim.cromie@gmail.com>, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        daniel@ffwll.ch, sergey.senozhatsky@gmail.com,
        Simon Ser <contact@emersion.fr>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [RFC PATCH 1/1] tracefs: add TP_printk_no_nl - RFC
Message-ID: <ZMeLKTzSWh3kbw8c@alley>
References: <20230730222134.54547-1-jim.cromie@gmail.com>
 <87y1iwlc80.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1iwlc80.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-31 10:31:03, John Ogness wrote:
> On 2023-07-30, Jim Cromie <jim.cromie@gmail.com> wrote:
> > This variant of TP_printk() does *not* add the trailing newline.
> >
> > https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/
> >
> > taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.
> >
> > It "reused" the include/trace/events/printk.h console event,
> > which does the following:
> >
> > 	TP_fast_assign(
> > 		/*
> > 		 * Each trace entry is printed in a new line.
> > 		 * If the msg finishes with '\n', cut it off
> > 		 * to avoid blank lines in the trace.
> > 		 */
> > 		if ((len > 0) && (text[len-1] == '\n'))
> > 			len -= 1;
> >
> > 		memcpy(__get_str(msg), text, len);
> > 		__get_str(msg)[len] = 0;
> > 	),
> >
> > That trim work could be avoided, *iff* all pr_debug() callers are
> > known to have no '\n' to strip.  While thats not true for *all*
> > callsites, it is 99+% true for DRM.debug callsites, and can be made
> > true for some subsets of prdbg/dyndbg callsites.
> 
> Note that the trailing '\n' in printk messages has a purpose.  It
> finalizes commitment of the message to the ringbuffer so that the
> message cannot be extended by any LOG_CONT printk's that may come along
> (from any context).

Also the message is printed on consoles only when finalized. As a
result, the last non-finalized message might not be visible on
consoles for hours or days.

> If it is not intended that a message is extended, then that message
> should include a trailing '\n'.
> 
> Grepping through the kernel, I am surprised how many messages are
> missing the trailing newline when it is obvious they are not intended to
> be extended. I consider these bugs.

I consider this bug as well.

My understanding is that this patch affects only messages printed to
the ftrace buffer so that it does not affect printk() directly.

But still. It creates a habit that is bad for printk(). Also relies
on the fact that people are aware of this macro and use it. IMHO,
it will not work in practice. Or do I miss something?

Best Regards,
Petr
