Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA17A19E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjIOJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjIOJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:03:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E17435B1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9wlO3rUFQVJBWcV7mhdkxrvqrd+3fPdTJu/jyfvO8Bc=; b=gJ6gyVpXM9P16XgBh2993EQa/D
        hojJIiLKz3hnN6UfrUwAMnH4eLP+Td8nzvkKOd/cNBmZVOr//JW3+1MM4Kg4+lV5QO/XJJUFDRUxT
        mnJjWUzTKZMkXKZLAVbtQcJkT/42TqgEorDn/Fqb9efqcsed7tMvFIpOmIoOqhC9GQ+eAQ5TznJXK
        E0JDzY2bzUDck4hehp7v1seztV6VnifIqPvRiLJ6DYhpRqFPRbkV43Cp9hZO9BklkvkxmtLGUZ/4I
        GBkJmHZUdX6VjACdzaSCOGgcYBflarwRL1kB2TLMKvF2FSDiixoB+PdHc6x+9w8A7jjRSaG4mESrZ
        8nbVD2bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qh4hu-008tL3-2M;
        Fri, 15 Sep 2023 09:01:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D09913005B2; Fri, 15 Sep 2023 11:01:47 +0200 (CEST)
Date:   Fri, 15 Sep 2023 11:01:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Fix a wild-memory-access bug in
 static_call_del_module()
Message-ID: <20230915090147.GB6721@noisy.programming.kicks-ass.net>
References: <20230915082126.4187913-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915082126.4187913-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 04:21:25PM +0800, Jinjie Ruan wrote:
> Inject fault while probing btrfs.ko, if the first kzalloc() fails
> in __static_call_init(), key->mods will no be initialized. And then
> in static_call_del_module() the site_mod->mod will cause
> wild-memory-access as below:
> 
> So assign key->mods to NULL in __static_call_init() if it fails
> to fix the issue. And if kzalloc fails, it will just return in init
> func, so it should break if it the key->mods is NULL in exit func.
> 

I don't think we need that full splat.

> 
> Fixes: 8fd4ddda2f49 ("static_call: Don't make __static_call_return0 static")

And that looks wrong, that just moved code around.

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/static_call_inline.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
> index 639397b5491c..e7aa70d33530 100644
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -256,8 +256,10 @@ static int __static_call_init(struct module *mod,
>  			}
>  
>  			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
> -			if (!site_mod)
> +			if (!site_mod) {
> +				key->mods = NULL;
>  				return -ENOMEM;
> +			}
>  
>  			/*
>  			 * When the key has a direct sites pointer, extract
> @@ -422,7 +424,7 @@ static void static_call_del_module(struct module *mod)
>  			;
>  
>  		if (!site_mod)
> -			continue;
> +			break;
>  
>  		*prev = site_mod->next;
>  		kfree(site_mod);

The actual patch looks okay.
