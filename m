Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AE7527C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjGMPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjGMPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:53:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D222702
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:53:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A85C62215A;
        Thu, 13 Jul 2023 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689263593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vieFlGRJliA/zMR7IuToxQRSElESzoAG4oj4phb1Az4=;
        b=idBen+g6Wvpuk6gU38PxDBkNI/jWfDLwn5Rq6+IqopFT4QmodBetRYPDzVHV7D2sSS+oD8
        4HtRyiuaMqLNejSLPXxVtQAKJMOkddJ7JUZy/wRxv+fHJe8ZHGPWIY9z7Pxb0De2UJbu8d
        jDmMQVmexf/GDq69GwTL8lodZY4v8s0=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E6382C146;
        Thu, 13 Jul 2023 15:53:13 +0000 (UTC)
Date:   Thu, 13 Jul 2023 17:53:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/5] printk: Add per-console suspended state
Message-ID: <ZLAd5cRNmOv-_1vW@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-10 15:51:23, John Ogness wrote:
> Currently the global @console_suspended is used to determine if
> consoles are in a suspended state. Its primary purpose is to allow
> usage of the console_lock when suspended without causing console
> printing. It is synchronized by the console_lock.
> 
> Rather than relying on the console_lock to determine suspended
> state, make it an official per-console state that is set within
> console->flags. This allows the state to be queried via SRCU.
> 
> Remove @console_suspended. Console printing will still be avoided
> when suspended because console_is_usable() returns false when
> the new suspended flag is set for that console.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have double checked the history. suspend_console() was added
into v2.6.18-rc1 by the commit ("Add support for suspending and
resuming the whole console subsystem").

The above commit added "secondary_console_sem". It was taken
by acquire_console_sem() instead of the normal "console_sem"
when "console_suspended" was set. It means that the normal
"console_sem" really was not taken.

The "secondary_console_sem" was removed in v2.6.29-rc6 by the commit
("PM: Fix suspend_console and resume_console to use only one
semaphore"). It solved races between code taking "console_sem"
and code "secondary_console_sem". This commit kept the handling of
"console_locked". It was not set when console_suspended was set
even though "console_sem" was actually taken.

IMHO, it was a bug in the commit removing "secondary_console_sem".
But it probably never caused any issues.

Anyway, this patch makes "console_locked" handling sane. And if some
tty code relies on the insane logic then it should get fixed.

Best Regards,
Petr
