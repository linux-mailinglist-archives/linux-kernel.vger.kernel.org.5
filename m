Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E57BA2F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjJEPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjJEPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887A836D1;
        Thu,  5 Oct 2023 07:17:06 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:17:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696515425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3o4obmDlIVbM+kFGU/mtTHVGxYc61qCsD7mRpS4nZQ4=;
        b=WoU3dnAZ5hGZkEOaElkZhFyFrELxVZe1MnunnB6QtjgfAQPfCHQnjhOznSShEpIJLAOICE
        tvJxyFpLRL4DCaS026cCq1iqkkT0A7+2TTyiYIKLZetKRAqcjaIU8iNrUqBIBxiyJH0jOR
        W7gy1/k51ZsRSLEZJokGGF78KGRANGzeQsqea3HZBlbPgFrUXJKBihkF7R82q0uBZbtD9M
        q6c2RgHiuJ0rv2ndUu2vTMNZ8YDYnKwNlMusXmE8wjiFh3+YWQ9qq1VPjKMWCVH9OgN/1c
        iRpGr0Bco3LOGsCIybW+cVPj47c8R6HEl3YyQ3BoyxwjJHpiE8X5v5dpJIL2GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696515425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3o4obmDlIVbM+kFGU/mtTHVGxYc61qCsD7mRpS4nZQ4=;
        b=5f2kvXVymMhupibhULmHjePIFnDs4I6jBw9la+pX0FuH771JG1JVvQqOh6PYzR0dOdKd8+
        Pn7tjVgYas6E1ODA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.6-rc4-rt7
Message-ID: <20231005141702.kcIBmUiU@linutronix.de>
References: <20231004160655.0D-7XFo_@linutronix.de>
 <375571ff-c63e-9045-81ff-dc93bcade8ee@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <375571ff-c63e-9045-81ff-dc93bcade8ee@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-05 15:38:06 [+0200], Pierre Gondois wrote:
> Hello Sebastian,
Hi Pierre,

> The following happened once [1]. In pl011_console_write() from:
>   commit da042bbb7a3f ("printk: Update the printk series.")
> &uap->port seems to be released, but various paths don't seem
> to acquire the lock,

Thank you for the report.
The following cures it:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 96da994e5af06..c6c2d3e46a8ec 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2335,7 +2335,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	if (uap->port.sysrq || oops_in_progress)
 		locked = uart_port_trylock_irqsave(&uap->port, &flags);
 	else
-		uart_port_trylock_irqsave(&uap->port, &flags);
+		uart_port_lock_irqsave(&uap->port, &flags);
 
 	/*
 	 *	First save the CR then disable the interrupts

> Regards,
> Pierre

Sebastian
