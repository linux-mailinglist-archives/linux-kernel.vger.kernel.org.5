Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F47536CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjGNJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjGNJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:41:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C712D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:41:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B976E22118;
        Fri, 14 Jul 2023 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689327687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V58G6k0S7NfSY//HiKoAYgvYkcXeF11/x3e2pQLhXQo=;
        b=kHyK4fPd7F72876ra7gyB0ErqV52Ctd/8NgZkb+A2kMXzsMK2mP6lWEsqvjITdhQ9ZqNg5
        RLztS7mqpab3NscxFdFBuWI/85RgwNMMTKPKIiCI/NnfAviToiaITeumGb82Y1Rp3GqTen
        X3XjaPVmvaRLQ8esV9ah1dlb01d4FWc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 92C2F2C142;
        Fri, 14 Jul 2023 09:41:27 +0000 (UTC)
Date:   Fri, 14 Jul 2023 11:41:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
Message-ID: <ZLEYR-eaZTWXO2Ld@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
 <ZK14p-ocWuuHkSAQ@alley>
 <878rbkrg16.fsf@jogness.linutronix.de>
 <ZLANiK_1YoBu1YpU@alley>
 <20230714040049.GA81525@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714040049.GA81525@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-14 13:00:49, Sergey Senozhatsky wrote:
> On (23/07/13 16:43), Petr Mladek wrote:
> > 
> > Simple removal of console_trylock() in console_flush_on_panic() would
> > cause that other CPUs might still be able to take it and race.
> > The problem is avoided by checking panic_in_progress() in console_lock()
> > and console_trylock(). They will never succeed on non-panic CPUs.
> > 
> 
> In theory, we also can have non-panic CPU in console_flush_all(),
> which should let panic CPU to take over the next time it checks
> abandon_console_lock_in_panic() (other_cpu_in_panic() after 5/5),
> but it may not happen immediately. I wonder if we somehow can/want
> to "wait" in console_flush_on_panic() for non-panic CPU handover?

Good point. It might actually be any console_lock() owner,
including printk() on other CPU.

I think that we might need to add some wait() as we did in the last
attempt, see the commit b87f02307d3cfbda76852 ("printk: Wait for
the global console lock when the system is going down").

Anyway, it will be more important after introducing the kthreads.
There is a non-trivial chance that they would block the lock.
They might be busy when handling a message printed right before
the panic() was called. At least, this is what I saw in the last
attempt to introduce the kthreads.

But maybe, it will be somehow hidden in the new atomic lock.
It might be passed to a printk context with a higher priority
and it uses some wait internally, see the waiting in the patch
https://lore.kernel.org/all/20230302195618.156940-7-john.ogness@linutronix.de/

Anyway, this patch does not make it worse. It just ignores the
potential console_lock owner in console_flush_on_panic() another
way.

Best Regards,
Petr
