Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C8769011
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGaIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGaIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:25:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F5312D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:25:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690791904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btPZwdfFcfW7yh8HaTQzyWkQr5OvNAFfLD2Y4vZIGU0=;
        b=1XREGsUusEzIKE58IrOHwr0/UFTSXTZMgu2OOhYwEkfb8zmSKEQcPa+8o81QclfcsJn6Rk
        P8pW3ZxjexRmAPIlCnS41RyUy12tMzszmMBc5+qkkpo+edgNht7p+0NAYsNeLfPq+trkY6
        sxEqBygcRvC5z99pDEHdSGHPCLtvNt0nKX3ExiuWHnTULa7tFwAoloDyuWRucvZ+38Bird
        oLZsUuTQvTCevR5z4xDa8r7KL6uscDECOHolRz9fZsFOjT/sWEHu87BDP5tB+6oWHoTU/G
        BPmzzBpns5xosiUbw9m76dhMqpabvamH+o0Vp7/QdhNUC57joKiHUWqNIT7KQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690791904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btPZwdfFcfW7yh8HaTQzyWkQr5OvNAFfLD2Y4vZIGU0=;
        b=a4z1VuoM8pLOhMODcNrM8PA/KSmGCXLRVhfDjj6n9s5vO4XMrnCqtY2jIuuw2IWFolcgu6
        GXj8Fx8yjoQ6gyCQ==
To:     Jim Cromie <jim.cromie@gmail.com>, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        daniel@ffwll.ch, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        Simon Ser <contact@emersion.fr>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [RFC PATCH 1/1] tracefs: add TP_printk_no_nl - RFC
In-Reply-To: <20230730222134.54547-1-jim.cromie@gmail.com>
References: <20230730222134.54547-1-jim.cromie@gmail.com>
Date:   Mon, 31 Jul 2023 10:31:03 +0206
Message-ID: <87y1iwlc80.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-30, Jim Cromie <jim.cromie@gmail.com> wrote:
> This variant of TP_printk() does *not* add the trailing newline.
>
> https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/
>
> taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.
>
> It "reused" the include/trace/events/printk.h console event,
> which does the following:
>
> 	TP_fast_assign(
> 		/*
> 		 * Each trace entry is printed in a new line.
> 		 * If the msg finishes with '\n', cut it off
> 		 * to avoid blank lines in the trace.
> 		 */
> 		if ((len > 0) && (text[len-1] == '\n'))
> 			len -= 1;
>
> 		memcpy(__get_str(msg), text, len);
> 		__get_str(msg)[len] = 0;
> 	),
>
> That trim work could be avoided, *iff* all pr_debug() callers are
> known to have no '\n' to strip.  While thats not true for *all*
> callsites, it is 99+% true for DRM.debug callsites, and can be made
> true for some subsets of prdbg/dyndbg callsites.

Note that the trailing '\n' in printk messages has a purpose.  It
finalizes commitment of the message to the ringbuffer so that the
message cannot be extended by any LOG_CONT printk's that may come along
(from any context).

If it is not intended that a message is extended, then that message
should include a trailing '\n'.

Grepping through the kernel, I am surprised how many messages are
missing the trailing newline when it is obvious they are not intended to
be extended. I consider these bugs.

John Ogness
