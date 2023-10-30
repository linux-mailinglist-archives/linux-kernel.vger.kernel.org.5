Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0E7DB5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjJ3JEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjJ3JEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:04:45 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C89D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:04:42 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45845db2d63so1627825137.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698656681; x=1699261481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNHbXrFWhWb/UiAuTpbdORAPbgvvHc5fpttisINRUz8=;
        b=V273kYK7rTpjgkxqtTrH5oKLkk3gcEthAuTdYvLuKghn1wffYKmeS3cfPFd0oLsLeX
         +fQsfysEOmzY4EMjGILcukhhmtF9cewjg698/kjiJCNPnfoYtWB6Ti7KOmaEE7AZNqhe
         NXfP783h8zHNmOJ2YR4w2NzYyHe3e1h2AWMpXy2XErDl2mGEnzOA1WOOgwZ2oEYlznwH
         QAgYSuEfbBBw7PZCKT6MUU4eaJkoHDVZQXEZcxW6BdSY4Poh/xh5E+6jQhWFWjq095+/
         ldvc0D2KEPOHiMwa4+2QjuUv6+thq+Yd4Gv2qFlB+2uwB5G1FnWABCl8mlahau/Q7349
         WVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656681; x=1699261481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNHbXrFWhWb/UiAuTpbdORAPbgvvHc5fpttisINRUz8=;
        b=LXzfk27nPwyjMiKsfaMDe07aAlvU/JnWy9CGrpO65yIkIUoJdzZSIj0+EUwSRvtMiw
         HvXtoKoYhGFa0X9YsN/LnXYV+wMxU0otTJ8+qluMABgWqG8wGPBJ2Dv8yMCbnRU4iNkH
         wMZp03dYHkRDiPrMsxHi+ySpxzz/lvOkY4X3cgV9XDZYT4gdblbeRji33Yefr4vmQsLZ
         snmOmuEsQBTkAeHNSxjbuSQA5Xfx57mZmHviDInQ2O9rAMzbgFHwr68lAZ3CN7a7B1IN
         OnNMu08kV+hqKcvvfRfxTNnUMM2fyNtoM0dwjpmWVOWRqUHJBN8wQTWSYzPIuZC20IrH
         +wfQ==
X-Gm-Message-State: AOJu0YzZvU7Vke3nPuzF/SrWrN8rSwkvhRd4fz6osx9LrLc7BorXNA2k
        iUMAfFBxHNp+dPtUOiwef47sfOxz4uz6enVLDlBsy4/Sypj4LR9wd/Q=
X-Google-Smtp-Source: AGHT+IHuMK9CPJIWmMpESi2n4X7oAb2ZRTCVwmgkWi5Chd/PoJkkncuL97D8EmlBmOuzqcNXR3fZmeqURszCkADFv2k=
X-Received: by 2002:a67:b80c:0:b0:458:1c00:c32f with SMTP id
 i12-20020a67b80c000000b004581c00c32fmr8952504vsf.34.1698656681327; Mon, 30
 Oct 2023 02:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231026171650.515275-1-jens.wiklander@linaro.org>
In-Reply-To: <20231026171650.515275-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 30 Oct 2023 14:34:29 +0530
Message-ID: <CAFA6WYOw9jbKFA5rvsNt7fqRNgirH2ueH3pRKKSmC9HAmmcfhA@mail.gmail.com>
Subject: Re: [PATCH] optee: add page list to kernel private shared memory
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Can we split this change into 2 patches for ease of review?

On Thu, 26 Oct 2023 at 22:47, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Until now has kernel private shared memory allocated as dynamic shared
> memory (not from the static shared memory pool) been returned without a
> list of physical pages on allocations via RPC. To support allocations
> larger than one page add a list of physical pages for all allocations
> larger than one page.

The second patch.

> Allocate the memory with  alloc_pages_exact()
> instead of alloc_pages() for more efficient memory usage.

The first patch.

-Sumit

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c    | 59 +++++++++++++++++++++++++------------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++---------------
>  2 files changed, 61 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..60fe351ee5c8 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -26,24 +26,36 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                                                    size_t num_pages,
>                                                    unsigned long start))
>  {
> -       unsigned int order = get_order(size);
> -       struct page *page;
> +       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
> +       unsigned int i;
>         int rc = 0;
>
>         /*
>          * Ignore alignment since this is already going to be page aligned
>          * and there's no need for any larger alignment.
>          */
> -       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> -       if (!page)
> +       shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
> +                                      GFP_KERNEL | __GFP_ZERO);
> +       if (!shm->kaddr)
>                 return -ENOMEM;
>
> -       shm->kaddr = page_address(page);
> -       shm->paddr = page_to_phys(page);
> -       shm->size = PAGE_SIZE << order;
> +       shm->size = nr_pages * PAGE_SIZE;
> +       shm->num_pages = nr_pages;
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
> +       if (shm_register || nr_pages > 1) {
>                 struct page **pages;
>
>                 pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> @@ -53,19 +65,26 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                 }
>
>                 for (i = 0; i < nr_pages; i++)
> -                       pages[i] = page + i;
> -
> -               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               kfree(pages);
> -               if (rc)
> -                       goto err;
> +                       pages[i] = virt_to_page((u8 *)shm->kaddr +
> +                                               i * PAGE_SIZE);
> +
> +               if (shm_register) {
> +                       rc = shm_register(shm->ctx, shm, pages, nr_pages,
> +                                         (unsigned long)shm->kaddr);
> +                       kfree(pages);
> +                       if (rc)
> +                               goto err;
> +               } else {
> +                       shm->pages = pages;
> +               }
> +       } else {
> +               shm->paddr = virt_to_phys(shm->kaddr);
>         }
>
>         return 0;
> -
>  err:
> -       free_pages((unsigned long)shm->kaddr, order);
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr = NULL;
>         return rc;
>  }
>
> @@ -75,8 +94,10 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  {
>         if (shm_unregister)
>                 shm_unregister(shm->ctx, shm);
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +       free_pages_exact(shm->kaddr, shm->size);
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
>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> --
> 2.34.1
>
