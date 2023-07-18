Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556F757932
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGRKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGRKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:21:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA06128
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:21:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 97A1A1FDA9;
        Tue, 18 Jul 2023 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689675672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwF2Nf8weX8GOZqx7IRoWLwhlbkAR6nO1T17tt5sLB4=;
        b=pZCpWVWkezRTIbLFi8VdLk8MWjn95m+lvAlEFzLjXbSu8NV1OaS0pWRzuCTxQESCE8dKdW
        41A79gWL0fNbVuWNym5/VGr1Yjv43VV78Wcu38pS/ls6dSbRwSeCOFFWbfyzgqvtrqSyam
        gUhhmEzvGMcGmDR/4Xul5akp6l3Vwww=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F80F2C142;
        Tue, 18 Jul 2023 10:21:12 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:21:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 2/7] printk: Reduce console_unblank() usage in
 unsafe scenarios
Message-ID: <ZLZnl_UUirKz0DFd@alley>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-17 21:52:02, John Ogness wrote:
> A semaphore is not NMI-safe, even when using down_trylock(). Both
> down_trylock() and up() are using internal spinlocks and up()
> might even call wake_up_process().
> 
> In the panic() code path it gets even worse because the internal
> spinlocks of the semaphore may have been taken by a CPU that has
> been stopped.
> 
> To reduce the risk of deadlocks caused by the console semaphore in
> the panic path, make the following changes:
> 
> - First check if any consoles have implemented the unblank()
>   callback. If not, then there is no reason to take the console
>   semaphore anyway. (This check is also useful for the non-panic
>   path since the locking/unlocking of the console lock can be
>   quite expensive due to console printing.)
> 
> - If the panic path is in NMI context, bail out without attempting
>   to take the console semaphore or calling any unblank() callbacks.
>   Bailing out is acceptable because console_unblank() would already
>   bail out if the console semaphore is contended. The alternative of
>   ignoring the console semaphore and calling the unblank() callbacks
>   anyway is a bad idea because these callbacks are also not NMI-safe.
> 
> If consoles with unblank() callbacks exist and console_unblank() is
> called from a non-NMI panic context, it will still attempt a
> down_trylock(). This could still result in a deadlock if one of the
> stopped CPUs is holding the semaphore internal spinlock. But this
> is a risk that the kernel has been (and continues to be) willing
> to take.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
