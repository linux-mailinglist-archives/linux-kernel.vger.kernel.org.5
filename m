Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96580E3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjLLFZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLFZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:25:12 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB2D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:25:18 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4b314f78326so1374293e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702358717; x=1702963517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoYp+4YsOf0yk8r/cUKva8dbjrGiFrmWJp5aVfnLRmI=;
        b=ZCfkXrfXV1AUfQC5wF66hTTHiPKk0Y/wDMQda8kcu5ZbaVOBoazixkkgiKGhMMTnbd
         ZJFAx+hwLL8BT1oTzKaCXOmCmFFedsM2OOH4mfOw+ID2WuSonZZjNFyVrXDYmhPF0C3S
         iCyGok997cZjj4UaA1Ewl0n4f3lh9jS2mmSADJtyd9vHqsKt29naFqmUhicOY1GAm7CP
         cn5QyR3O91MCzyehhI/uMX6KxP9Oo0Vl9BIt3cKD4IxHvCPqSExKiH46RrTm4jpUUIzc
         4DgDNpAtkACdqvfh/FiI1bMkDJm8Q/xMx7r4MQtqP7uK2zUvl4MuTS3AQ1M1UEvcntk6
         f4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702358717; x=1702963517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoYp+4YsOf0yk8r/cUKva8dbjrGiFrmWJp5aVfnLRmI=;
        b=CX22NZCtM49wUm3vywyE29RTnzmi0iT2+oHL1zMlXoGbFSN3ntS6VI4yFeX/OTX9+i
         e8aujpB5C7nDARqWJFpUvmDmp6GTIO+ULcg2QSuFvCuTJfLLaHUe8MXghvke12xZ7pp0
         p0M4LlTTkL2NTJlFGfJTEOzvgU/YZFpLQ4/hHNzk2LOtuOTX2C7qaG8WX0maNZ8fRk/N
         h/l8/hsEpzaA61Td1gT+GqZPznI8Kjlbl0Xc9HtnPhabsWAulvQtq2Z78wrzxtOjPwjN
         vF3CVwJsgIMp5dJlATlTnUdpgbJlXgQhXug7fix1SJrpNvlKlJVCpecIdcWxqY9hMLLE
         iNTw==
X-Gm-Message-State: AOJu0Yx/41G1g32m1Lz6ZCBqvBdWVrz+KcsblBjMSiqBWJp0oVF3rFuw
        a1i5N2L8MOteMAFUipsflzAXws+eHwu9ykojYY6xruBRno6SPi8CSFoBJw==
X-Google-Smtp-Source: AGHT+IGl6n4DkMPzzFrpLEU5CzTBD1z86jOXG3CIj32ATWbsMdOqleM7mmHWc4Ba69DkoQSG/t6OLcD2QmwMtX6Le0U=
X-Received: by 2002:a05:6122:4d18:b0:4b2:d42c:2d67 with SMTP id
 fi24-20020a0561224d1800b004b2d42c2d67mr4252796vkb.32.1702358717207; Mon, 11
 Dec 2023 21:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20231205162330.196259-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20231205162330.196259-1-arnaud.pouliquen@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 12 Dec 2023 10:55:05 +0530
Message-ID: <CAFA6WYMYQDe-g9P_Gck2mH2Pn=B-8m2dzvK7of6djCp=wBjjUw@mail.gmail.com>
Subject: Re: [PATCH v5] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, 5 Dec 2023 at 21:53, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> Currently it's not possible to register kernel buffers with TEE
> which are allocated via vmalloc.
>
> Use iov_iter and associated helper functions to manage the page
> registration for all type of memories.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Update from V4 to V5:
> - replace import_ubuf() by iov_iter_ubuf(),
> - fix comment in register_shm_helper() function.
>

Looks good to me, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> Update from V3 to V4:
> - improve commit message,
> - use import_ubuf() instead of iov_iter_init(),
> - move shm_get_kernel_pages in register_shm_helper,
> - put back untagged_addr in register_shm_helper(),
> - move the comment related to pin pages from shm_get_kernel_pages()
>   to register_shm_helper().
>
> Update from V2 to V3:
> - break lines longer than 80 columns.
>
> Update from V1 to V2:
> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf().
>
> V1:
> The support of buffer registration allocated with vmalloc is no more
> available since c83900393aa1 ("tee: Remove vmalloc page support").
>
> This patch is an alternative to a revert and resulted from a discussion
> with Christopher Hellwig [1].
>
> This patch has been tested using xtest tool in optee qemu environment [2]
> and using the series related to the remoteproc tee that should be
> proposed soon [3].
>
> References:
> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#build-instructions
> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
> ---
>  drivers/tee/tee_shm.c | 78 +++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..731d9028b67f 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>                 put_page(pages[n]);
>  }
>
> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
> -                               struct page **pages)
> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>  {
> -       struct page *page;
>         size_t n;
>
> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> -                        is_kmap_addr((void *)start)))
> -               return -EINVAL;
> -
> -       page = virt_to_page((void *)start);
> -       for (n = 0; n < page_count; n++) {
> -               pages[n] = page + n;
> +       for (n = 0; n < page_count; n++)
>                 get_page(pages[n]);
> -       }
> -
> -       return page_count;
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
>  static struct tee_shm *
> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
> -                   size_t length, u32 flags, int id)
> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
> +                   int id)
>  {
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
> -       unsigned long start;
> -       size_t num_pages;
> +       unsigned long start, addr;
> +       size_t num_pages, off;
> +       ssize_t len;
>         void *ret;
>         int rc;
>
> @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>         shm->flags = flags;
>         shm->ctx = ctx;
>         shm->id = id;
> -       addr = untagged_addr(addr);
> +       addr = untagged_addr((unsigned long)iter_iov_addr(iter));
>         start = rounddown(addr, PAGE_SIZE);
> -       shm->offset = addr - start;
> -       shm->size = length;
> -       num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;
> +       num_pages = iov_iter_npages(iter, INT_MAX);
> +       if (!num_pages) {
> +               ret = ERR_PTR(-ENOMEM);
> +               goto err_ctx_put;
> +       }
> +
>         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>         if (!shm->pages) {
>                 ret = ERR_PTR(-ENOMEM);
>                 goto err_free_shm;
>         }
>
> -       if (flags & TEE_SHM_USER_MAPPED)
> -               rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> -                                        shm->pages);
> -       else
> -               rc = shm_get_kernel_pages(start, num_pages, shm->pages);
> -       if (rc > 0)
> -               shm->num_pages = rc;
> -       if (rc != num_pages) {
> -               if (rc >= 0)
> -                       rc = -ENOMEM;
> -               ret = ERR_PTR(rc);
> -               goto err_put_shm_pages;
> +       len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
> +                                    &off);
> +       if (unlikely(len <= 0)) {
> +               ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
> +               goto err_free_shm_pages;
>         }
>
> +       /*
> +        * iov_iter_extract_kvec_pages does not get reference on the pages,
> +        * get a reference on them.
> +        */
> +       if (iov_iter_is_kvec(iter))
> +               shm_get_kernel_pages(shm->pages, num_pages);
> +
> +       shm->offset = off;
> +       shm->size = len;
> +       shm->num_pages = num_pages;
> +
>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>                                              shm->num_pages, start);
>         if (rc) {
> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>
>         return shm;
>  err_put_shm_pages:
> -       if (flags & TEE_SHM_USER_MAPPED)
> +       if (!iov_iter_is_kvec(iter))
>                 unpin_user_pages(shm->pages, shm->num_pages);
>         else
>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
> +err_free_shm_pages:
>         kfree(shm->pages);
>  err_free_shm:
>         kfree(shm);
> @@ -307,6 +305,7 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
> +       struct iov_iter iter;
>         void *ret;
>         int id;
>
> @@ -319,7 +318,8 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         if (id < 0)
>                 return ERR_PTR(id);
>
> -       shm = register_shm_helper(ctx, addr, length, flags, id);
> +       iov_iter_ubuf(&iter, ITER_DEST,  (void __user *)addr, length);
> +       shm = register_shm_helper(ctx, &iter, flags, id);
>         if (IS_ERR(shm)) {
>                 mutex_lock(&teedev->mutex);
>                 idr_remove(&teedev->idr, id);
> @@ -352,8 +352,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
>         u32 flags = TEE_SHM_DYNAMIC;
> +       struct kvec kvec;
> +       struct iov_iter iter;
> +
> +       kvec.iov_base = addr;
> +       kvec.iov_len = length;
> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
>
> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
> +       return register_shm_helper(ctx, &iter, flags, -1);
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>
> --
> 2.25.1
>
