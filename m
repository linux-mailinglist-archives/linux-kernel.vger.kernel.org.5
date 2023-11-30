Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC87FE9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjK3Hy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Hyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:54:55 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A7A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:01 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so220250241.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701330900; x=1701935700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDKAg1oWtzfrgq97MaNgCMwcFK/3NQBpNHoe9HbhccM=;
        b=i7eLfhdBFSMSktdlLBJ/IA/1MAR3QqU7YJabHU/KkXGM9wsLW4KBVZu17yys2qhMjT
         wKYfZcBXSAoiefWuRUJdxeLwNihpKErhVK3ilv+Xj3/kn53J/RXcUsZ7TtxSHYUUj3MF
         ozZGBOPWn7NVWTJJs1IDUHkglmjWWheIgtdNY0Vp7plu8D3wufOrywPVsdvxgH9CtGi+
         91n6u8TUqSr9sBEv+/p3ieL4d1jSNcPu/GiPCJNjjY9xEIDg1c/YNezEjAua8XU73g0Y
         IarA/ZBFdGYeV4kX+iMRvgX1h7u1gfaryFF6uPgSw6EcGByvc0gDAbd/7vH2BXmveenZ
         xy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330900; x=1701935700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDKAg1oWtzfrgq97MaNgCMwcFK/3NQBpNHoe9HbhccM=;
        b=iqrF+2V5zmZq9H+vOIp5WnhxzqkBYsLv2/gy/VzZFHj8OzsAwDDl3hGi1Xc4fByf2R
         rdbjHyzt+pas7V1tusJFVThQ4zBYm2q4+I5VRMKbps9XnvaHPpZCIi0VOZmfTRpR6rrr
         Rs5SAfs6auiuqRwsT/YlbeEaBIhOZ5b3jk924eYq0rBt7kt4v9pcJkoQmUOdYenx2O09
         bIajBF17eNgw6Cxiw7OlTuIUUtW55K3GiGhAwMcOrq0RqOzPxgUfwe0ax26N63s5Pj6N
         UNk5yfkkYFbTibDeKziJD8X63sU04Lns4BFkcrEZuHJbyDozyTD9OwKyjlzd7gWM5+wW
         3lDw==
X-Gm-Message-State: AOJu0YxytEm9VWwkJ7qFnkCwlgpbVolE9EK9Od7sFTFqKhUyWQkpVFwv
        33VVSfiTgAAey7Ey7H6W86xf27jGhoaDoSARQILCBQ==
X-Google-Smtp-Source: AGHT+IEccAA/wek/3H9QWXeFmStRafU3xHk1GsIZNpnd1Ed7c6lbQ3iUeDJ1WeCYeD5U0C59Z2Suf4hvel78Fk/pgl4=
X-Received: by 2002:a1f:4982:0:b0:4b2:8efa:65df with SMTP id
 w124-20020a1f4982000000b004b28efa65dfmr3539451vka.14.1701330900302; Wed, 29
 Nov 2023 23:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 30 Nov 2023 13:24:49 +0530
Message-ID: <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
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

On Wed, 29 Nov 2023 at 22:15, Arnaud Pouliquen
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
>  drivers/tee/tee_shm.c | 83 ++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..ac73e8143233 100644
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
> +        * get a pin on them.

I think you meant: "get a reference on them". But I don't see the
value of this comment since iov_iter_extract_kvec_pages() already has
been commented properly as follows:

/*
 * Extract a list of virtually contiguous pages from an ITER_KVEC iterator.
 * This does not get references on the pages, nor does it get a pin on them.
 */

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
> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
> +       struct iov_iter iter;
>         void *ret;
> -       int id;
> +       int id, err;
>
>         if (!access_ok((void __user *)addr, length))
>                 return ERR_PTR(-EFAULT);
> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>         if (id < 0)
>                 return ERR_PTR(id);
>
> -       shm = register_shm_helper(ctx, addr, length, flags, id);
> +       err = import_ubuf(ITER_DEST, (void __user *)addr, length, &iter);

As I mentioned in a previous review, import_ubuf() already does the
access_ok() check, so we don't need the extra access_ok() check above.
Also, you should move import_ubuf() to be the first invocation within
this API.

-Sumit

> +       if (err)
> +               return ERR_PTR(err);
> +
> +       shm = register_shm_helper(ctx, &iter, flags, id);
>         if (IS_ERR(shm)) {
>                 mutex_lock(&teedev->mutex);
>                 idr_remove(&teedev->idr, id);
> @@ -352,8 +355,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
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
