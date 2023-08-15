Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8377CA67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHOJ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjHOJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:27:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2F1FC4;
        Tue, 15 Aug 2023 02:27:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A31BD1F8B8;
        Tue, 15 Aug 2023 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692091646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5j9dNyxti1ROGyLXuS1N2B0CryBtKNjR7Ms5Qc3ptvc=;
        b=s5qWwgUzCcQh2opehNzwo/XtMtmgQFwM5YPHNJ6WKdpiXDUsvoAnZEa+6nhpiLOko/1p1n
        h986A8wd+YCaJERReOEOdLhVirKt+n2MePo6dp5HWO1tvRLSjgehLxwpQerJWpkgXKDYp9
        j392VV/i2tNyXKmL2ctTw3KwwWVLj7I=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6581D2C143;
        Tue, 15 Aug 2023 09:27:26 +0000 (UTC)
Date:   Tue, 15 Aug 2023 11:27:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
Message-ID: <ZNtE_dcBaDm-wbHt@alley>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
 <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
 <87bkfa6nvx.fsf@jogness.linutronix.de>
 <ZNn7KHY3iMRarqAZ@alley>
 <154dfc10-76fa-b054-54a8-faa22ad52158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154dfc10-76fa-b054-54a8-faa22ad52158@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-14 12:21:23, Jiri Slaby wrote:
> On 14. 08. 23, 12:00, Petr Mladek wrote:
> > I personally vote to keep it as is unless people see this warning
> > on daily basis. After all, the lockdep splat is correct. The serial
> > console might not work correctly in panic() when there is the race.
> 
> Sorry, but no, the warning is not correct at all. The code path deliberately
> does NOT take the lock and calls a function which is currently annotated
> that the lock is _always_ taken. Therefore, the warning is clearly a false
> positive and I see no reason in keeping it.

There might be a misunderstanding. I only want to keep panic()
implementation as it is for now. I mean to keep calling
debug_locks_off() right before console_flush_on_panic().
The lockdep should stay on before to report potential problems
in non-printk code, like kexec, panic notifiers.

But I am fine with disabling the particular lockdep_assert_held_once()
during panic().

It should stay during the normal system state to catch not
yet discovered races. John is working hard on preventing any
races which might blow up after introducing the printk kthreads.

I mean something like:

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ecfdc4534123..9533c1eedfb1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -704,7 +704,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 static void serial8250_clear_IER(struct uart_8250_port *up)
 {
 	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&up->port.lock);
+	if (!oops_in_progress)
+		lockdep_assert_held_once(&up->port.lock);
 
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);


Best Regards,
Petr
