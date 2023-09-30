Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B927B3EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjI3Gjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Gjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:39:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536EE1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 23:39:47 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mTdfqzIAmNwJhmTdfqg9fR; Sat, 30 Sep 2023 08:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696055985;
        bh=PuFtE8Nzqce9GbOstUVaI0iC3LvA8WVVT5UfiC0x0N8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B8ElbXXvOXWetZw3fI9NSyo1YhshaygFu+vth0MHhOvzg3ysKfsBlWRQpf0dzTSsv
         ON1DpCMkrAVP9pZsorOE7xJjN+WxBNnen29CakYPhf4cwjmCeVKS7ZFQhiGzexltvv
         5gLR5PM0fBWQBkP3ugRsFgsaq4arZftG6QWLwgrQOsnFEisWlYTzjODYjLAnvNGlAy
         MB3JZSgfIWkdOCS0HkBlRe/o7SpEyTrjxU/lUF5n1UwPYLdoA7tKJ4pWtfTPhEppd5
         kcFJHGZy8iV+eAhgOGlo7fS3LFD/foHBP2k2dpzZHvTkIBACjSu2mI4vcbrtcYW6Si
         ISnU8FR4vMGYw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Sep 2023 08:39:45 +0200
X-ME-IP: 86.243.2.178
Message-ID: <10341d7c-2903-9aba-9e33-c60bab32df5d@wanadoo.fr>
Date:   Sat, 30 Sep 2023 08:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] chelsio/l2t: Annotate struct l2t_data with
 __counted_by
To:     Kees Cook <keescook@chromium.org>, Raju Rangoju <rajur@chelsio.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20230929181042.work.990-kees@kernel.org>
 <20230929181149.3006432-1-keescook@chromium.org>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230929181149.3006432-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/09/2023 à 20:11, Kees Cook a écrit :
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct l2t_data.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Raju Rangoju <rajur@chelsio.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
>   drivers/net/ethernet/chelsio/cxgb4/l2t.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> index ea75f275023f..646ca0bc25bd 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> +++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> @@ -76,7 +76,7 @@ struct l2t_data {
>   	atomic_t nfree;		/* number of free entries */
>   	rwlock_t lock;
>   	struct rcu_head rcu_head;	/* to handle rcu cleanup */
> -	struct l2t_entry l2tab[];
> +	struct l2t_entry l2tab[] __counted_by(nentries);
>   };
>   
>   typedef void (*arp_failure_handler_func)(struct t3cdev * dev,
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> index a10a6862a9a4..1e5f5b1a22a6 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> @@ -59,7 +59,7 @@ struct l2t_data {
>   	rwlock_t lock;
>   	atomic_t nfree;             /* number of free entries */
>   	struct l2t_entry *rover;    /* starting point for next allocation */
> -	struct l2t_entry l2tab[];  /* MUST BE LAST */
> +	struct l2t_entry l2tab[] __counted_by(l2t_size);  /* MUST BE LAST */

Nit: the comment is maybe unneeded.

>   };
>   
>   static inline unsigned int vlan_prio(const struct l2t_entry *e)

