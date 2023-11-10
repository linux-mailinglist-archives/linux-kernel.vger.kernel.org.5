Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728ED7E7FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjKJSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjKJR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:31 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138E39742
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:36:45 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45f19811ae5so1380645137.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699627004; x=1700231804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T8lXgHfjhLQ1Wv745j16/Mu5J6Uz3eXfZfSC2W4ANLQ=;
        b=fJXEP42W3UIevc0rzbpnGO2c6LYI75AjNDHtk8pDzNHZXH5VhqcVHAkApl46emr6et
         gDhJjMvikgfFjB6nKJNQ0tHQAm8neuIIsgdxgLDYicJZr8OjtnDNKrqzTQxqWJwd3ycr
         bzgqXXE1ZjYh+o0hcpAEe+6ZQSLI+TuVoBvA05dVqq+nU8mIWM9fd5WBGk6mDXt66RA2
         xSiH471HVMVFjgIx0uay01BLxBAEG4xMlRZYN5ptozQnmGr+prFtx3ETWmf7gkd9+OVI
         RAItCdBbkDj5VX1kygtCMmFr1uK7KnJkoL/zu9NwYW0xfnAY6GZgjVruoR/aClf7pt15
         WRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627004; x=1700231804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8lXgHfjhLQ1Wv745j16/Mu5J6Uz3eXfZfSC2W4ANLQ=;
        b=rCu3ZBqA9GkOOwnKR8/29Smzn+e4W00fjOEGSFFM/vwQOctT8srUOiAxs/KANIN9T7
         ALNRVeHQLhTTibNV5UvTSwOtv9HEx9dDH9KSA57EQYFtp/jGCHcVWyFuY3ze4IrdOday
         YdHyPIf8z7mlpAMsYk4G8UdI6e2IQki5dezUw+aS5sq2sYi6qlcgX+xfdx3NFlUdPSNg
         os37rXAXq8Oa9pAdEz5PFcoaMQih4Ed2/kuUktBfLar5uF9WzB6A2DI0EJnkFafrlwfY
         gv/XMLvAuJhttPTjm1uFozVhuKY4IT/WV69zbUTV8jhX2YjOn/rHkgMEU7PSLzN6mKKy
         eTgg==
X-Gm-Message-State: AOJu0Yw5/BYQQjzWEseFRFrCAOaZuOeCN5+FQVKzUb9nyNkBT3ZGYE2b
        Cepn8bvzUaN0u4HNMA676W5hMY8I2lbSmkzDHYczyQ==
X-Google-Smtp-Source: AGHT+IEUdKQuuZDHxAEIKk0jvynrARkMCYqZ+prBHZYSGA5W6fLsZmxUN30C493LT5BDM5Xf/vCM1+1igAQ5ojd9gwQ=
X-Received: by 2002:a05:6102:53cc:b0:452:7341:a098 with SMTP id
 bs12-20020a05610253cc00b004527341a098mr1143167vsb.0.1699627004219; Fri, 10
 Nov 2023 06:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20231108102755.93079-1-jens.wiklander@linaro.org> <20231108102755.93079-2-jens.wiklander@linaro.org>
In-Reply-To: <20231108102755.93079-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 10 Nov 2023 20:06:33 +0530
Message-ID: <CAFA6WYPqkRdGc6R6Q=w0YJ=SN9FvQ48qDEc6d05gOyyV6x066g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: add page list to kernel private shared memory
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, 8 Nov 2023 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Until now has kernel private shared memory allocated as dynamic shared
> memory (not from the static shared memory pool) been returned without a
> list of physical pages on allocations via RPC. To support allocations
> larger than one page add a list of physical pages for all allocations
> larger than one page.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c    | 40 +++++++++++++++++++++++++--------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
>  2 files changed, 52 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..a425eca0173d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -27,6 +27,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                                                    unsigned long start))
>  {
>         unsigned int order = get_order(size);
> +       unsigned int nr_pages = 1 << order;
>         struct page *page;
>         int rc = 0;
>
> @@ -39,12 +40,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                 return -ENOMEM;
>
>         shm->kaddr = page_address(page);
> -       shm->paddr = page_to_phys(page);
>         shm->size = PAGE_SIZE << order;
>
> -       if (shm_register) {
> -               unsigned int nr_pages = 1 << order, i;
> +       /*
> +        * If memory is registered immediately use a temporary page list
> +        * and free it directly after the registration is completed.
> +        *
> +        * Else, if we have allocated more than one page store a page
> +        * list in the struct tee_shm.
> +        *
> +        * Else, store the physical address of the single page that was
> +        * allocated.
> +        *
> +        * optee_pool_op_free_helper() is responsible for freeing the
> +        * resourses allocated in this function.
> +        */

It looks a bit complex to me. Do we really need it to be conditional?
I was thinking if we can simplify this API as follows:

int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
                               size_t size, size_t align,
                               int (*shm_register)(struct tee_shm *shm))
{
        unsigned int order = get_order(size);
        unsigned int nr_pages = 1 << order, i;
        struct page **pages;
        struct page *page;
        int rc = 0;

        /*
         * Ignore alignment since this is already going to be page aligned
         * and there's no need for any larger alignment.
         */
        page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
        if (!page)
                return -ENOMEM;

        shm->kaddr = page_address(page);
        shm->paddr = page_to_phys(page);
        shm->size = PAGE_SIZE << order;

        pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
        if (!pages) {
                rc = -ENOMEM;
                goto err;
        }

        for (i = 0; i < nr_pages; i++)
                pages[i] = page + i;

        shm->pages = pages;
        shm->num_pages = nr_pages;

        if (shm_register) {
                rc = shm_register(shm);
                if (rc)
                        goto err;
        }

        return 0;

err:
        kfree(pages);
        free_pages((unsigned long)shm->kaddr, order);
        return rc;
}

-Sumit

> +       if (shm_register || nr_pages > 1) {
>                 struct page **pages;
> +               unsigned int i;
>
>                 pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>                 if (!pages) {
> @@ -55,17 +68,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                 for (i = 0; i < nr_pages; i++)
>                         pages[i] = page + i;
>
> -               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               kfree(pages);
> -               if (rc)
> -                       goto err;
> +               if (shm_register) {
> +                       rc = shm_register(shm->ctx, shm, pages, nr_pages,
> +                                         (unsigned long)shm->kaddr);
> +                       kfree(pages);
> +                       if (rc)
> +                               goto err;
> +               } else {
> +                       shm->pages = pages;
> +                       shm->num_pages = nr_pages;
> +               }
> +       } else {
> +               shm->paddr = page_to_phys(page);
>         }
>
>         return 0;
> -
>  err:
>         free_pages((unsigned long)shm->kaddr, order);
> +       shm->kaddr = NULL;
>         return rc;
>  }
>
> @@ -77,6 +97,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                 shm_unregister(shm->ctx, shm);
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>         shm->kaddr = NULL;
> +       kfree(shm->pages);
> +       shm->pages = NULL;
>  }
>
>  static void optee_bus_scan(struct work_struct *work)
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..b69410c7cc0a 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                                           struct optee_msg_arg *arg,
>                                           struct optee_call_ctx *call_ctx)
>  {
> -       phys_addr_t pa;
>         struct tee_shm *shm;
>         size_t sz;
>         size_t n;
> +       struct page **pages;
> +       size_t page_count;
>
>         arg->ret_origin = TEEC_ORIGIN_COMMS;
>
> @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 return;
>         }
>
> -       if (tee_shm_get_pa(shm, 0, &pa)) {
> -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> -               goto bad;
> -       }
> -
> -       sz = tee_shm_get_size(shm);
> -
> -       if (tee_shm_is_dynamic(shm)) {
> -               struct page **pages;
> +       /*
> +        * If there are pages it's dynamically allocated shared memory (not
> +        * from the reserved shared memory pool) and needs to be
> +        * registered.
> +        */
> +       pages = tee_shm_get_pages(shm, &page_count);
> +       if (pages) {
>                 u64 *pages_list;
> -               size_t page_num;
> -
> -               pages = tee_shm_get_pages(shm, &page_num);
> -               if (!pages || !page_num) {
> -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> -                       goto bad;
> -               }
>
> -               pages_list = optee_allocate_pages_list(page_num);
> +               pages_list = optee_allocate_pages_list(page_count);
>                 if (!pages_list) {
>                         arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
>                         goto bad;
>                 }
>
>                 call_ctx->pages_list = pages_list;
> -               call_ctx->num_entries = page_num;
> +               call_ctx->num_entries = page_count;
>
>                 arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
>                                       OPTEE_MSG_ATTR_NONCONTIG;
> @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_list) |
>                         (tee_shm_get_page_offset(shm) &
>                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> -               arg->params[0].u.tmem.size = tee_shm_get_size(shm);
> -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>
> -               optee_fill_pages_list(pages_list, pages, page_num,
> +               optee_fill_pages_list(pages_list, pages, page_count,
>                                       tee_shm_get_page_offset(shm));
>         } else {
> +               phys_addr_t pa;
> +
> +               if (tee_shm_get_pa(shm, 0, &pa)) {
> +                       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +                       goto bad;
> +               }
> +
>                 arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
>                 arg->params[0].u.tmem.buf_ptr = pa;
> -               arg->params[0].u.tmem.size = sz;
> -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>         }
> +       arg->params[0].u.tmem.size = tee_shm_get_size(shm);
> +       arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>
>         arg->ret = TEEC_SUCCESS;
>         return;
> --
> 2.34.1
>
