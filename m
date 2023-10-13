Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580CD7C82A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjJMJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJMJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:57:57 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B515CCA;
        Fri, 13 Oct 2023 02:57:52 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrEvK-006ijp-3e; Fri, 13 Oct 2023 17:57:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 17:57:42 +0800
Date:   Fri, 13 Oct 2023 17:57:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [PATCH v3] Fixes: 07928d9bfc81 ("padata: Remove broken queue
 flushing")
Message-ID: <ZSkUlkp214AROxpG@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSDWAcUxXcwD4YUZ@fedora>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Jinchao <wangjinchao@xfusion.com> wrote:
>
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 222d60195de6..79d04a97ded6 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1102,12 +1102,16 @@ EXPORT_SYMBOL(padata_alloc_shell);
>  */
> void padata_free_shell(struct padata_shell *ps)
> {
> +       struct parallel_data *pd;
> +
>        if (!ps)
>                return;
> 
>        mutex_lock(&ps->pinst->lock);
>        list_del(&ps->list);
> -       padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> +       pd = rcu_dereference_protected(ps->pd, 1);
> +       if (refcount_dec_and_test(&pd->refcnt))
> +               padata_free_pd(rcu_dereference_protected(ps->pd, 1));

Why is this dereferencing ps->pd again after the refcount_dec_and_test?

If this is necessary please explain it in the code because it is not
at all obvious.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
