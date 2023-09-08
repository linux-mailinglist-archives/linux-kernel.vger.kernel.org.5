Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BDA798792
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbjIHNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjIHNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:03:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028119BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:03:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694178216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pb2OeXUPpOkPf9EGIoSTRmhDvf+CRinxkW94civOCoQ=;
        b=yP0H35UBdKTRb9RKdmsuvlN8PHD5pw58e/s/IOt0Dvtppocb6aRMU1iC4KEZMNtVzQWnUA
        tnRpaTPyt6KFLwj9RXvFvj8yRA4sPFD+hoJ5jis++4bfxgK9hoD8a/JdUTCYTxsBJfd5nc
        DccWQxgw4IaV5iTqWWEhkc9AHiKPEueXeTe7Xa5lueXRMfD+4KngLlrC4KpymiC6Yrummd
        pU+rkqbEAkSx6YmYW0TgJ9Udw72jBquY4OPaREF35TLBQbYpPnTJwcSo2qXO0aoVyBlywT
        tV6ZDYJwD7Eq8i49jppNkspwg7IJ46GZI3v7l9Cl45qDVHkZM7y6tgisBF3rAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694178216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pb2OeXUPpOkPf9EGIoSTRmhDvf+CRinxkW94civOCoQ=;
        b=MPGrLA4v8M5QWwoimSZEXVf/8GgGo5RDgfKWV6qSdJ2CmgcLjYUNeikC87jvdB5xtMUfPH
        u/crkat4O7nYMWDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 3/7] printk: nbcon: Add buffer management
In-Reply-To: <ZPh99nwo9zJXxqQz@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-4-john.ogness@linutronix.de>
 <ZPh99nwo9zJXxqQz@alley>
Date:   Fri, 08 Sep 2023 15:09:34 +0206
Message-ID: <875y4kx1eh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06, Petr Mladek <pmladek@suse.com> wrote:
>> +bool nbcon_alloc(struct console *con)
>> +{
>> +
>> +	con->pbufs = kmalloc(sizeof(*con->pbufs), GFP_KERNEL);
>
> We might need to use memblock_alloc() at least for early consoles.

I wasn't planning on addressing early consoles at this stage. The
initial 8250 NBCON implementation will only be for the regular console.

However, since it is planned that NBCON consoles are synchronized with
boot consoles using the console_lock, we might as well establish that
boot consoles (in general) are always synchronized uisng the
console_lock.

This allows us to use the single global pbufs of the legacy consoles
(see console_emit_next_record()) for NBCON boot consoles as well. The
static buffer is much more attractive because it is always available.

For v4, nbcon_alloc() will initialize con->pbufs to use the global
legacy pbufs for con->flags == CON_BOOT.

bool nbcon_alloc(struct console *con)
{
        if (con->flags & CON_BOOT) {
                /*
                 * Boot console printing is synchronized with legacy console
                 * printing, so boot consoles can share the same global printk
                 * buffers.
                 */
                con->pbufs = &printk_shared_pbufs;
        } else {
                con->pbufs = kmalloc(sizeof(*con->pbufs), GFP_KERNEL);
                if (!con->pbufs) {
                        con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
                        return false;
                }
        }

        return true;
}

John Ogness
