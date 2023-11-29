Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C196C7FCF88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjK2G5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2G53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:57:29 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E01BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:57:34 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4ac45927974so2043563e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701241054; x=1701845854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2rN0UfLiiiMpxoKOMV5rZidDm7YCoyfBG7lHyQ2JEbk=;
        b=Si3VJre6l+KZz0bNUbjN9MMvRay+2h31wH4cPoPwB3k1BT0wY/vafWtj4JovorjzbI
         LRCMHOSfkThqkZ6dUSK50+2WLOos8woJmFt/BBBCAETst/aqVKZ7xkxTAcWbDv/r1NMG
         9adAeW3FLfmCNa3wR5ehnPrMcPesI6bJrnnkOEvlD0ebpHBzMGJ6Jt7r2L/6v1B1/pfA
         Aetf6bKycd71Zg7PlP5YtIHnuVRCW0OuPVfqb97J3qRR6rZWP6gziyLyTulgmB/Dqz4l
         jBqgp/RyDJDVC7GSxA9zKivGlLABDOYioZzbMJePmm+5gosnNc7XyiIGXzEj4sQMyQsr
         /h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701241054; x=1701845854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rN0UfLiiiMpxoKOMV5rZidDm7YCoyfBG7lHyQ2JEbk=;
        b=P4g9KqIXSDlHa2SprENyg3M0EOrBvP0WLFc8v/2RfBZ2zicUsoJtg1uRBGyeoPJIO+
         qYE26P97bUQSsCzjhtFTaz6aCJtUxiQIHhz87kb/iaEJIVA3AGELI+FGL2tU4lf+KqrM
         akGNLxQ36jYmt3mBZvSTe6Ytxm1hS2UeQ7pcnpYJzzPAyMni4OaFE0hPJIeKmFuYHdDA
         gHGQzFKRIkVhTw2Cq1zl3Dh/nC81bdb88Yyy06uE1gBY9Uj3YOGzrwXfGVXPKynWtFgB
         Xpc4u79OxYpb4wVEivD62mKhlfFdpDV5OME44m93o/espZOlMLT6k+UU69TVTh7S8EF2
         FeWg==
X-Gm-Message-State: AOJu0YwQ1zD8nsEZVFlztxX6YR4E73ZxnESBGgjGE802OLxibGQVF/m5
        LHd3Fmoq6mIGGuWsh9oKCP2NvuIkWgZ2MOPjd5HUZfU7aF4qplJdNkk=
X-Google-Smtp-Source: AGHT+IH9TFhvk880Jam8Wl6I7LDVWTCOzpBceJv1f330z3kkkC3tNZEtDZWhO47mdtjSzA8KDrhhid4mmb73h9uyia0=
X-Received: by 2002:a05:6122:d8e:b0:4ac:2316:5afa with SMTP id
 bc14-20020a0561220d8e00b004ac23165afamr20776753vkb.12.1701241053753; Tue, 28
 Nov 2023 22:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20231128081928.329420-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20231128081928.329420-1-arnaud.pouliquen@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 29 Nov 2023 12:27:22 +0530
Message-ID: <CAFA6WYOJcKrSmK1LaUDB01nBdCLU=RcGRt_VMkhOXdGnQUC0xw@mail.gmail.com>
Subject: Re: [PATCH v3] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Tue, 28 Nov 2023 at 13:49, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> It is not possible to register buffers allocated with vmalloc.

I would rephrase it as:

Currently it's not possible to register kernel buffers with TEE
which are allocated via vmalloc.

> Use iov_iter and associated helper functions to manage the page
> registration for all type of memories.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
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
>  drivers/tee/tee_shm.c | 77 ++++++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..fe0a205be7ef 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -22,23 +22,16 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
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
> +       /*
> +        * iov_iter_extract_kvec_pages does not get reference on the pages,
> +        * get a pin on them.
> +        */
> +       for (n = 0; n < page_count; n++)
>                 get_page(pages[n]);
> -       }
> -
> -       return page_count;
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> @@ -214,13 +207,13 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
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
> +       size_t num_pages, length, len, off;
>         void *ret;
>         int rc;
>
> @@ -245,31 +238,32 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>         shm->flags = flags;
>         shm->ctx = ctx;
>         shm->id = id;
> -       addr = untagged_addr(addr);
> +       addr = (unsigned long)iter_iov_addr(iter);

Why did you drop untagged_addr() here?

> +       length = iter_iov_len(iter);
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
> +       len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
> +                                    &off);
> +       if (len != length) {

Any particular reason for this check?

> +               ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_put_shm_pages;
>         }
>
> +       shm->offset = off;
> +       shm->size = len;
> +       shm->num_pages = num_pages;
> +
>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>                                              shm->num_pages, start);
>         if (rc) {
> @@ -307,6 +301,8 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
> +       struct iovec iov;
> +       struct iov_iter iter;
>         void *ret;
>         int id;
>
> @@ -319,7 +315,10 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         if (id < 0)
>                 return ERR_PTR(id);
>
> -       shm = register_shm_helper(ctx, addr, length, flags, id);
> +       iov.iov_base = (void __user *)addr;
> +       iov.iov_len = length;
> +       iov_iter_init(&iter, ITER_DEST, &iov, 1, length);

We should rather use import_ubuf() instead of this and the above
access_ok() check.

> +       shm = register_shm_helper(ctx, &iter, flags, id);
>         if (IS_ERR(shm)) {
>                 mutex_lock(&teedev->mutex);
>                 idr_remove(&teedev->idr, id);
> @@ -351,9 +350,19 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
> +       struct tee_shm *shm;
>         u32 flags = TEE_SHM_DYNAMIC;
> +       struct kvec kvec;
> +       struct iov_iter iter;
>
> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
> +       kvec.iov_base = addr;
> +       kvec.iov_len = length;
> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
> +       shm = register_shm_helper(ctx, &iter, flags, -1);
> +       if (!IS_ERR(shm))
> +               shm_get_kernel_pages(shm->pages, shm->num_pages);

The kernel pages reference should be taken before invoking
teedev->desc->ops->shm_register(). So you should move this to
register_shm_helper() instead. You can use iov_iter_is_kvec() to know
if you have to get a reference or not.

-Sumit

> +
> +       return shm;
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>
> --
> 2.25.1
>
