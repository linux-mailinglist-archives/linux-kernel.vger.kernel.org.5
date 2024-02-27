Return-Path: <linux-kernel+bounces-82733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E778688D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9576C1C21DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DBA53375;
	Tue, 27 Feb 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6KDV8Fz"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A117FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014022; cv=none; b=OMmCQGSozJlJU7sIHKKVIvhKyem6dx2izf93q7cXNuU5fcja50z2yh4qmunynMgkce1HVF97x8A3M0Lw2DzqfbQj5WeR6ywN1E4thM9S9Ywq4U2dvnYH7rux5ol3UTLMoWqxkvcSdLFu9Kf20mbmHb/wusjwsha0PA7vtRGpHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014022; c=relaxed/simple;
	bh=Y+QE7Ge+KB7lAmHslk+gdLUNs2/yMyFmhAeGV/Yb21U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzV1z0jOJ9hlDNbcLtrGEP9/zNggeGrbh4K2DQb60Sw4sGHSXRgvEDgNeNoHLTQ+09LYTvyvC1nRxftFgEPNgPZLkO5276vlqZwKQ9gaU2AFxBYZYW4HtCMtptE69fRLNxuTuCVUAfEuqrc6XSFd7uDstvWGIcdsvWNcvgjt1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6KDV8Fz; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57bbso2039471241.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709014018; x=1709618818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztf4083pTZ5RLIpZH0hN9fs10mfQLsMuM0cOvPbKDX4=;
        b=T6KDV8FzNR/8yjWx6RRKamZDbfpOLLQjO1W0f6LinsMfPEEuiFFEOywjzHYwUpqQhO
         eJXU9H27mFSheX4nLquQHnjkCzvaDcOvgf+15UJ7MBhcgBLq9Ss0hIiHarfDddPoTJMz
         cTyPwJznLEwdKMp7v71Z8FJla1U7ckJUcHnzED1Bygo7iX8J3NSKu57lXROpw0xU598t
         CvZfSsI1zZ4t51L3Xko7VrNVVYSbuf1phZWzX9EtLlczdqL3memk4s7iQ2FD+DO5T09f
         4+fFwuMJxVG44mrjzxQTxPaDH/rO9DDRTryiFb0tAAbWRySIWhIA9T9Wv04BrcORv/1S
         q4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709014018; x=1709618818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztf4083pTZ5RLIpZH0hN9fs10mfQLsMuM0cOvPbKDX4=;
        b=IJNXrV7spT07E97PGZlqw2TruXw15C5xr0fNJ0lkmJTauP1HNKfzG66/sQFq47MZnE
         0dhutGPeqGVtri35/R2QQsOgLtBrPUbxKA7jgZSdfO6ELHLag62Jb1C7Q15YlvBoCzFr
         LAwVBmz037Kwc+yJX9lgXYjEIicOixd110tuVS92pVRD2cvJcgKXGW/2zfGM0fw4CM7t
         gxvdWXCKna8yDw8lnxKbLH/9oilJpru+A8dzRVgJxk1t0vcMtRfkNRvFpXX80jLs/K+W
         V9gtkzj5S5jIM88xQPKimfkDHfKYRsXSkwjMcF73j+0+of8KW/CfcVCW0omUdN2qqLmn
         jX0w==
X-Forwarded-Encrypted: i=1; AJvYcCXWiELucq+2PJFWJVq4LUdDbc5gDnnUjhAFGA9HQ9yDL4qYzJ5lRoIE6vLTSbFPCX2p5xvJrHVCYW0OMCjkG7fyz9+4a/muYQmkkmfU
X-Gm-Message-State: AOJu0Yy9eTKsr9Kd9UjBg/L3Of02WYx9KO6arVp0LS6yF+WdWqREyu/p
	dEOQtdycP39mu8YGY6+SXgquaY339KRoyIKbQHO/g8TXTcxnvqW2MXIPgKLJ5WPVOgqLe8NJgyt
	/h53hXP26lP+MgLfYfABd+QTtWB7MeVJoBEMf2w==
X-Google-Smtp-Source: AGHT+IGYqahDatj5+yVLQz7txwSkeI2eV7I6NLB7src9IlNQaWKf37hIjexRX3qOazK8NreM8tiy6+o3IHOL/S8h21I=
X-Received: by 2002:a05:6102:125c:b0:470:53d1:2900 with SMTP id
 p28-20020a056102125c00b0047053d12900mr4832831vsg.30.1709014018186; Mon, 26
 Feb 2024 22:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com> <20240223095133.109046-2-balint.dobszay@arm.com>
In-Reply-To: <20240223095133.109046-2-balint.dobszay@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Feb 2024 11:36:47 +0530
Message-ID: <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Balint,

On Fri, 23 Feb 2024 at 15:22, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> Move the pool alloc and free helper functions from the OP-TEE driver to
> the TEE subsystem, since these could be reused in other TEE drivers.
> This patch is not supposed to change behavior, it's only reorganizing
> the code.
>
> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  drivers/tee/optee/core.c          | 64 ------------------------------
>  drivers/tee/optee/ffa_abi.c       |  6 +--
>  drivers/tee/optee/optee_private.h | 12 ------
>  drivers/tee/optee/smc_abi.c       | 11 +++---
>  drivers/tee/tee_shm.c             | 65 +++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h           | 11 ++++++
>  6 files changed, 85 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 3aed554bc8d8..9390f21f9902 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -9,7 +9,6 @@
>  #include <linux/crash_dump.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> -#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -17,69 +16,6 @@
>  #include <linux/types.h>
>  #include "optee_private.h"
>
> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              size_t size, size_t align,
> -                              int (*shm_register)(struct tee_context *ctx,
> -                                                  struct tee_shm *shm,
> -                                                  struct page **pages,
> -                                                  size_t num_pages,
> -                                                  unsigned long start))
> -{
> -       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
> -       struct page **pages;
> -       unsigned int i;
> -       int rc = 0;
> -
> -       /*
> -        * Ignore alignment since this is already going to be page aligned
> -        * and there's no need for any larger alignment.
> -        */
> -       shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
> -                                      GFP_KERNEL | __GFP_ZERO);
> -       if (!shm->kaddr)
> -               return -ENOMEM;
> -
> -       shm->paddr = virt_to_phys(shm->kaddr);
> -       shm->size = nr_pages * PAGE_SIZE;
> -
> -       pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> -       if (!pages) {
> -               rc = -ENOMEM;
> -               goto err;
> -       }
> -
> -       for (i = 0; i < nr_pages; i++)
> -               pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
> -
> -       shm->pages = pages;
> -       shm->num_pages = nr_pages;
> -
> -       if (shm_register) {
> -               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               if (rc)
> -                       goto err;
> -       }
> -
> -       return 0;
> -err:
> -       free_pages_exact(shm->kaddr, shm->size);
> -       shm->kaddr = NULL;
> -       return rc;
> -}
> -
> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              int (*shm_unregister)(struct tee_context *ctx,
> -                                                    struct tee_shm *shm))
> -{
> -       if (shm_unregister)
> -               shm_unregister(shm->ctx, shm);
> -       free_pages_exact(shm->kaddr, shm->size);
> -       shm->kaddr = NULL;
> -       kfree(shm->pages);
> -       shm->pages = NULL;
> -}
> -
>  static void optee_bus_scan(struct work_struct *work)
>  {
>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index ecb5eb079408..ee11918a2b35 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
>  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>                              struct tee_shm *shm, size_t size, size_t align)
>  {
> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> -                                         optee_ffa_shm_register);
> +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> +                                           optee_ffa_shm_register);
>  }
>
>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>                              struct tee_shm *shm)
>  {
> -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
> +       tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
>  }
>
>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 7a5243c78b55..a153285a1919 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  int optee_enumerate_devices(u32 func);
>  void optee_unregister_devices(void);
>
> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              size_t size, size_t align,
> -                              int (*shm_register)(struct tee_context *ctx,
> -                                                  struct tee_shm *shm,
> -                                                  struct page **pages,
> -                                                  size_t num_pages,
> -                                                  unsigned long start));
> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              int (*shm_unregister)(struct tee_context *ctx,
> -                                                    struct tee_shm *shm));
> -
> -
>  void optee_remove_common(struct optee *optee);
>  int optee_open(struct tee_context *ctx, bool cap_memref_null);
>  void optee_release(struct tee_context *ctx);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a37f87087e5c..b0c616b6870d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -592,19 +592,20 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
>          * to be registered with OP-TEE.
>          */
>         if (shm->flags & TEE_SHM_PRIV)
> -               return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
> +               return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> +                                                   NULL);
>
> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> -                                         optee_shm_register);
> +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> +                                           optee_shm_register);
>  }
>
>  static void pool_op_free(struct tee_shm_pool *pool,
>                          struct tee_shm *shm)
>  {
>         if (!(shm->flags & TEE_SHM_PRIV))
> -               optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
> +               tee_shm_pool_op_free_helper(pool, shm, optee_shm_unregister);
>         else
> -               optee_pool_op_free_helper(pool, shm, NULL);
> +               tee_shm_pool_op_free_helper(pool, shm, NULL);
>  }
>
>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 731d9028b67f..641aad92ffe2 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,

I don't see the first argument (struct tee_shm_pool *pool) being used,
so drop that. Also, we can just rename it as
tee_dyn_shm_alloc_helper().

> +                                size_t size, size_t align,
> +                                int (*shm_register)(struct tee_context *ctx,
> +                                                    struct tee_shm *shm,
> +                                                    struct page **pages,
> +                                                    size_t num_pages,
> +                                                    unsigned long start))
> +{
> +       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
> +       struct page **pages;
> +       unsigned int i;
> +       int rc = 0;
> +
> +       /*
> +        * Ignore alignment since this is already going to be page aligned
> +        * and there's no need for any larger alignment.
> +        */
> +       shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
> +                                      GFP_KERNEL | __GFP_ZERO);
> +       if (!shm->kaddr)
> +               return -ENOMEM;
> +
> +       shm->paddr = virt_to_phys(shm->kaddr);
> +       shm->size = nr_pages * PAGE_SIZE;
> +
> +       pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +       if (!pages) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       for (i = 0; i < nr_pages; i++)
> +               pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
> +
> +       shm->pages = pages;
> +       shm->num_pages = nr_pages;
> +
> +       if (shm_register) {
> +               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> +                                 (unsigned long)shm->kaddr);
> +               if (rc)
> +                       goto err;
> +       }
> +
> +       return 0;
> +err:
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr = NULL;
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
> +
> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,

Ditto tee_shm_pool_op_free_helper() -> tee_dyn_shm_free_helper()

> +                                int (*shm_unregister)(struct tee_context *ctx,
> +                                                      struct tee_shm *shm))
> +{
> +       if (shm_unregister)
> +               shm_unregister(shm->ctx, shm);
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr = NULL;
> +       kfree(shm->pages);
> +       shm->pages = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
> +
>  static struct tee_shm *
>  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>                     int id)
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911ddf92dcee..4cf402424e71 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>
> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> +                                size_t size, size_t align,
> +                                int (*shm_register)(struct tee_context *ctx,
> +                                                    struct tee_shm *shm,
> +                                                    struct page **pages,
> +                                                    size_t num_pages,
> +                                                    unsigned long start));
> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> +                                int (*shm_unregister)(struct tee_context *ctx,
> +                                                      struct tee_shm *shm));
> +

These rather belong to drivers/tee/tee_private.h as we shouldn't
expose them to other kernel client drivers.

-Sumit

>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length);
>
> --
> 2.34.1
>

