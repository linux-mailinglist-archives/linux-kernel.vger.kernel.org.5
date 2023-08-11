Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AAA7794F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHKQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjHKQoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51B2D78;
        Fri, 11 Aug 2023 09:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABE5676E0;
        Fri, 11 Aug 2023 16:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0135AC433C8;
        Fri, 11 Aug 2023 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691772240;
        bh=H0T5KOOnhJgk4vT613/BU0k/CXzWHKGlAL7DTQzOrF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zx9cJxWO9SOhl+q9w1YbmUe9L6B9BY/NS2DJqgr0yuwfRIYWRyow/QKTr3iVXFq57
         HN/13HPowQCZp8ehS02swEGwhxEmYGBtm+blJ1BVirb2GU9Kc++u9q6V8FHcny17Hd
         SGc5aohTc1vdPHj7OofMw42vOoCUp5A47MaOeqrg=
Date:   Fri, 11 Aug 2023 09:43:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] init: Add lockdep annotation to kthreadd_done completer
Message-Id: <20230811094359.ae44c1081b52f69baad8e651@linux-foundation.org>
In-Reply-To: <ZNZcBkiVkm87+Tvr@p100>
References: <ZNZcBkiVkm87+Tvr@p100>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 18:04:22 +0200 Helge Deller <deller@gmx.de> wrote:

> Add the missing lockdep annotation to avoid this warning:
> 
>  INFO: trying to register non-static key.
>  The code is fine but needs lockdep annotation, or maybe
>  you didn't initialize this object before use?
>  turning off the locking correctness validator.
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #681
>  Hardware name: 9000/785/C3700
>  Backtrace:
>   [<000000004030bcd0>] show_stack+0x74/0xb0
>   [<0000000041469c7c>] dump_stack_lvl+0x104/0x180
>   [<0000000041469d2c>] dump_stack+0x34/0x48
>   [<000000004040e5b4>] register_lock_class+0xd24/0xd30
>   [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
>   [<000000004040cd60>] lock_acquire+0x130/0x298
>   [<000000004146df54>] _raw_spin_lock_irq+0x60/0xb8
>   [<0000000041472044>] wait_for_completion+0xa0/0x2d0
>   [<000000004146b544>] kernel_init+0x48/0x3a8
>   [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
> 
> ...
>
> --- a/init/main.c
> +++ b/init/main.c
> @@ -682,6 +682,8 @@ noinline void __ref __noreturn rest_init(void)
>  	struct task_struct *tsk;
>  	int pid;
> 
> +	init_completion(&kthreadd_done);
> +
>  	rcu_scheduler_starting();
>  	/*
>  	 * We need to spawn init first so that it obtains pid 1, however

This is pretty old code, as is the page_alloc_init_late() change.  Do
we know why this warning has just turned up lately?

I'll add cc:stable to these, but might take that away again if we can
answer the above.

btw, please don't forget the "^---$" between changelog and patch.
