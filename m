Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986A77BB817
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjJFMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjJFMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:51:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC783
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:51:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AFAD921879;
        Fri,  6 Oct 2023 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696596677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WygjZDNlYJVIYSTvhziaRFrytx9402lmuEnc9DPEY5g=;
        b=QmNwhKVAjZ3WRmZPz3HGzCxgi6NwuQziqFRt/RSQ3vHG4C8r4VYoVHwCuI2rx7xWRtfjif
        G16uJqkH8YlfT44dbb5Z/lpxGM3JjqzN9E2fB2N4FPMlMznt2aHUgF8qSWGy0QjMPqYojG
        5cyKGA3fKPInVGtsz8a4pvPSWP6EPkw=
Received: from suse.cz (pmladek.udp.ovpn1.nue.suse.de [10.163.31.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B1B22C142;
        Fri,  6 Oct 2023 12:51:16 +0000 (UTC)
Date:   Fri, 6 Oct 2023 14:51:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
Message-ID: <ZSACxAqnFQ1JDHk0@alley>
References: <ZRGvn4m2NGCn3Pef@alley>
 <87h6n5teos.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6n5teos.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Linus into Cc. I would like to be sure about the flushing
of atomic consoles in panic context.

> During the demo at LPC2022 we had the situation that there was a large
> backlog when a WARN was hit. With current mainline the first line of the
> WARN is put into the ringbuffer and then the entire backlog is flushed
> before storing the rest of the WARN into the ringbuffer. At the time it
> was obvious that we should finish storing the WARN message and then
> start flushing the backlog.

This talks about the "emergency" context (WARN/OOPS/watchdog).
The system might be in big troubles but it would still try to continue.

Do we really want to defer the flush also for panic() context?

I ask because I was not on LPC 2022 in person and I do not remember
all details.

Anyway, the deferred flush works relatively well for the "emergency" context:

   + flushed from nbcon_atomic_exit()
   + printk kthread might emit the messages while they are being added

But it is tricky in panic(), see 8th patch at
https://lore.kernel.org/r/20230919230856.661435-9-john.ogness@linutronix.de

   + nbcon_atomic_exit() is called only in one code path.

   + nbcon_atomic_flush_all() is used in other paths. It looks like
     a "Whack a mole" game to me.

   + messages are never emitted by printk kthread either because
     CPUs are stopped or the kthread is not allowed to get the lock[*]

I see only one positive of the explicit flush. The consoles would
not delay crash_exec() and the crash dump might be closer to
the point where panic() was called.

Otherwise I see only negatives => IMHO, we want to flush atomic
consoles synchronously from printk() in panic().

Does anyone really want explicit flushes in panic()?

[*] Emitting messages is explicitly blocked on non-panic CPUs. It
    increases the change that panic-CPU would be able to take
    the console lock the safe way.

Best Regards,
Petr
