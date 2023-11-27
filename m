Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697AA7F9F48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjK0MM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjK0MM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:12:27 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7381C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:12:32 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a242c232eso11353176d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701087152; x=1701691952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfABWDjajj/IKV6ZFw6elh3Q+m1vyrfJKijTYYMQhmg=;
        b=dj+w0LxrsS/YcNNsxPpykMJ5dPvmiXWYp/Yu5SWpCqGR5uYSn2qVFxti7dCNCfFjOV
         Gfyg0FkaztKaPOhwlFGJzz6zVvQnpErxgYzmJkcQVioREs7rDO0IWV7ClXnVDB7AVzVJ
         EyuUrmv3YIhFMYLitN5a3ATvP9qaRIxN3d9AEUlrIqalQ7qHulIPbzemxsW91aVr2V69
         LcW6WWdDFD9ibNO7TOczQo39nvihiN+DsNc95KYv8r+pO3+8SKZl+fV5kT8HU6MU6KgY
         h5r3SYeW/1qA2oWhmmRXiz+4/T2wjuAG6fZ8Fu/iWmzbxbrgoRiW2A7EUZB9KQ5glc2M
         Z0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087152; x=1701691952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfABWDjajj/IKV6ZFw6elh3Q+m1vyrfJKijTYYMQhmg=;
        b=CBLro2b0E1qAQJha3+M87mUTqOZ9YSP2x530PBBQVK+Y47H6h9eDHCGpiZhh7YR00I
         MPk4AFOIS0rlrI3zkemM5Rz+kJ20eUcDL8ePNMk9fc6RXt6OP2w+DK4t3GIUIPWocyUa
         ZkC2jdiYUeQfLd6fdu/8Wv2DAm5+t5Vv2Mu0BU0kbewVNmsnrUMqFRFdzXOVUKQyUYK3
         XYe3eJTIVoHkOc7pAppbfSqANwwKll1PDHAJ59dC63xd4Yaj4noRtzEyWcKYAjTTO11T
         CDlk2fGhxQkvarTsNyqDqKJRaeVjz7iJwvvxVuDLDOuxNSuK9tV4uDmos4iBqcGPWVXo
         znPg==
X-Gm-Message-State: AOJu0YyKYfcEo33sI85higCs4xkIv0vTtKh3VVpBvritwVtlXcWw4EM6
        SQ712qUqkVy34TPFkMNw7/h8n5nIrJFKCp3NUofC1IkoL1k+A7zrL3g=
X-Google-Smtp-Source: AGHT+IH30OzW4B8b8itSK4X8wMg8vyFFzaU2Zc4GDgmKMiWyZeljkIbtrlUreUPpCrw3EcmmQvm/Jhfn4Kqs2kElSq0=
X-Received: by 2002:ad4:58b1:0:b0:67a:1639:7f52 with SMTP id
 ea17-20020ad458b1000000b0067a16397f52mr10895683qvb.27.1701087151782; Mon, 27
 Nov 2023 04:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20231124173411.111713-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20231124173411.111713-1-arnaud.pouliquen@foss.st.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 27 Nov 2023 13:12:20 +0100
Message-ID: <CAHUa44Hm0T_48+T9NbpDR5gtntjpnzZTabFddR1h8-73+Kc6pw@mail.gmail.com>
Subject: Re: [PATCH] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 6:34=E2=80=AFPM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> It is not possible to register buffers allocated with vmalloc.
> Use iov_iter and associated helper functions to manage the page
> registration for all type of memories.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>
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
> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee4=
7dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#bui=
ld-instructions
> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee4=
7dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
> ---
>  drivers/tee/tee_shm.c | 72 +++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..0bb47ffd049a 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -22,23 +22,13 @@ static void shm_put_kernel_pages(struct page **pages,=
 size_t page_count)
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
> -       page =3D virt_to_page((void *)start);
> -       for (n =3D 0; n < page_count; n++) {
> -               pages[n] =3D page + n;
> +       /* iov_iter_extract_kvec_pages does not get reference on the page=
s, get a pin on them. */
> +       for (n =3D 0; n < page_count; n++)
>                 get_page(pages[n]);
> -       }
> -
> -       return page_count;
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> @@ -214,13 +204,12 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_c=
ontext *ctx, size_t size)
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
>  static struct tee_shm *
> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
> -                   size_t length, u32 flags, int id)
> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 =
flags, int id)
>  {
>         struct tee_device *teedev =3D ctx->teedev;
>         struct tee_shm *shm;
> -       unsigned long start;
> -       size_t num_pages;
> +       unsigned long start, addr;
> +       size_t num_pages, length, len, off;
>         void *ret;
>         int rc;
>
> @@ -245,31 +234,31 @@ register_shm_helper(struct tee_context *ctx, unsign=
ed long addr,
>         shm->flags =3D flags;
>         shm->ctx =3D ctx;
>         shm->id =3D id;
> -       addr =3D untagged_addr(addr);
> +       addr =3D (unsigned long)iter_iov_addr(iter);
> +       length =3D iter_iov_len(iter);
>         start =3D rounddown(addr, PAGE_SIZE);
> -       shm->offset =3D addr - start;
> -       shm->size =3D length;
> -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAGE_=
SIZE;
> +       num_pages =3D iov_iter_npages(iter, INT_MAX);
> +       if (!num_pages) {
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto err_ctx_put;
> +       }
> +
>         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL=
);
>         if (!shm->pages) {
>                 ret =3D ERR_PTR(-ENOMEM);
>                 goto err_free_shm;
>         }
>
> -       if (flags & TEE_SHM_USER_MAPPED)
> -               rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> -                                        shm->pages);
> -       else
> -               rc =3D shm_get_kernel_pages(start, num_pages, shm->pages)=
;
> -       if (rc > 0)
> -               shm->num_pages =3D rc;
> -       if (rc !=3D num_pages) {
> -               if (rc >=3D 0)
> -                       rc =3D -ENOMEM;
> -               ret =3D ERR_PTR(rc);
> +       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0, &off);
> +       if (len !=3D length) {
> +               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_put_shm_pages;
>         }
>
> +       shm->offset =3D off;
> +       shm->size =3D len;
> +       shm->num_pages =3D num_pages;
> +
>         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>                                              shm->num_pages, start);
>         if (rc) {
> @@ -307,6 +296,8 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_=
context *ctx,
>         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev =3D ctx->teedev;
>         struct tee_shm *shm;
> +       struct iovec iov;
> +       struct iov_iter iter;
>         void *ret;
>         int id;
>
> @@ -319,7 +310,10 @@ struct tee_shm *tee_shm_register_user_buf(struct tee=
_context *ctx,
>         if (id < 0)
>                 return ERR_PTR(id);
>
> -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
> +       iov.iov_base =3D (void __user *)addr;
> +       iov.iov_len =3D length;
> +       iov_iter_init(&iter, ITER_DEST, &iov, 1, length);
> +       shm =3D register_shm_helper(ctx, &iter, flags, id);
>         if (IS_ERR(shm)) {
>                 mutex_lock(&teedev->mutex);
>                 idr_remove(&teedev->idr, id);
> @@ -351,9 +345,19 @@ struct tee_shm *tee_shm_register_user_buf(struct tee=
_context *ctx,
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
> +       struct tee_shm *shm;
>         u32 flags =3D TEE_SHM_DYNAMIC;
> +       struct kvec kvec;
> +       struct iov_iter iter;
>
> -       return register_shm_helper(ctx, (unsigned long)addr, length, flag=
s, -1);
> +       kvec.iov_base =3D addr;
> +       kvec.iov_len =3D length;
> +       iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, length);

Why are you using ITER_SOURCE? This memory can be both read from and writte=
n to.

> +       shm =3D register_shm_helper(ctx, &iter, flags, -1);
> +       if (!IS_ERR_OR_NULL(shm))

IS_ERR should be enough.

Cheers,
Jens

> +               shm_get_kernel_pages(shm->pages, shm->num_pages);
> +
> +       return shm;
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>
> --
> 2.25.1
>
