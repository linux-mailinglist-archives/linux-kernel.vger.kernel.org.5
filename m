Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765937D0779
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjJTFEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:04:11 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF8D4C;
        Thu, 19 Oct 2023 22:04:08 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qthfu-0096xm-7A; Fri, 20 Oct 2023 13:03:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:03:59 +0800
Date:   Fri, 20 Oct 2023 13:03:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     WangJinchao <wangjinchao@xfusion.com>
Cc:     steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [PATCH v4] padata: Fix refcnt handling in padata_free_shell()
Message-ID: <ZTIKP94KBuqhyj/k@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310160854+0800-wangjinchao@xfusion.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WangJinchao <wangjinchao@xfusion.com> wrote:
> In a high-load arm64 environment, the pcrypt_aead01 test in LTP can lead
> to system UAF (Use-After-Free) issues. Due to the lengthy analysis of
> the pcrypt_aead01 function call, I'll describe the problem scenario
> using a simplified model:
> 
> Suppose there's a user of padata named `user_function` that adheres to
> the padata requirement of calling `padata_free_shell` after `serial()`
> has been invoked, as demonstrated in the following code:
> 
> ```c
> struct request {
>    struct padata_priv padata;
>    struct completion *done;
> };
> 
> void parallel(struct padata_priv *padata) {
>    do_something();
> }
> 
> void serial(struct padata_priv *padata) {
>    struct request *request = container_of(padata,
>                                struct request,
>                                padata);
>    complete(request->done);
> }
> 
> void user_function() {
>    DECLARE_COMPLETION(done)
>    padata->parallel = parallel;
>    padata->serial = serial;
>    padata_do_parallel();
>    wait_for_completion(&done);
>    padata_free_shell();
> }
> ```
> 
> In the corresponding padata.c file, there's the following code:
> 
> ```c
> static void padata_serial_worker(struct work_struct *serial_work) {
>    ...
>    cnt = 0;
> 
>    while (!list_empty(&local_list)) {
>        ...
>        padata->serial(padata);
>        cnt++;
>    }
> 
>    local_bh_enable();
> 
>    if (refcount_sub_and_test(cnt, &pd->refcnt))
>        padata_free_pd(pd);
> }
> ```
> 
> Because of the high system load and the accumulation of unexecuted
> softirq at this moment, `local_bh_enable()` in padata takes longer
> to execute than usual. Subsequently, when accessing `pd->refcnt`,
> `pd` has already been released by `padata_free_shell()`, resulting
> in a UAF issue with `pd->refcnt`.
> 
> The fix is straightforward: add `refcount_dec_and_test` before calling
> `padata_free_pd` in `padata_free_shell`.
> 
> Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
> 
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
> V4:
>    Included Daniel's ack
>    Included Herbert's ack
> V3: https://lore.kernel.org/all/ZSDWAcUxXcwD4YUZ@fedora/
>    Included Daniel's ack
>    introduced wrong patch 
> V2: https://lore.kernel.org/all/ZRTLHY5A+VqIKhA2@fedora/
>    To satisfy Sparse, use rcu_dereference_protected.
>    Reported-by: kernel test robot <lkp@intel.com>
>    Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/
> 
> V1: https://lore.kernel.org/all/ZRE4XvOOhz4HSOgR@fedora/
> kernel/padata.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 222d60195de6..73108ac75f03 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1102,12 +1102,15 @@ EXPORT_SYMBOL(padata_alloc_shell);
>  */
> void padata_free_shell(struct padata_shell *ps)
> {
> +       struct parallel_data *pd;
>        if (!ps)
>                return;
> 
>        mutex_lock(&ps->pinst->lock);
>        list_del(&ps->list);
> -       padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> +       pd = rcu_dereference_protected(ps->pd, 1);
> +       if (refcount_dec_and_test(&pd->refcnt))
> +               padata_free_pd(pd);
>        mutex_unlock(&ps->pinst->lock);
> 
>        kfree(ps);

Daniel, could you please reconfirm that you're still with v4?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
