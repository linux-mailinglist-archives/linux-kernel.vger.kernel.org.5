Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901347EE0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPMhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjKPMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:37:04 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A3DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:36:59 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so297299241.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700138218; x=1700743018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sBqjvobuK0FG72tvSIgWFZ4Ol7xLHNtUSM4flgNPMpQ=;
        b=AQRpgwZ+sx25OdoEQiqmzzczY3UvFHBbye89mlcN9N5e71ygsNBCWUvuShK3Y+xb81
         qz4s+q/7jpQHhqOrAM2rwCje3te7vA/UPo9AYEZ79+3T13Is6XJ+q3uxJ88yYIdzCFdI
         gDoVG5pCtRsrbQLIgxJlOWfwI1k2Ua2JdDvsedufT6uPA0yoFnigPT6CyqcD5QoN5/CA
         mdg4JGLEHIbkmLbsWOsHtB+ov5DG6e6FKTpyIsFj5m11o7N0GNeA+i/wO3hLYRUH/+vw
         /oqhnBs+5NO9XKugKbdRx2wGAJFP97BexjwqK47C73iH7Q0rJanrw9Gj7beDRjZ7cTfw
         MuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700138218; x=1700743018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBqjvobuK0FG72tvSIgWFZ4Ol7xLHNtUSM4flgNPMpQ=;
        b=e4VXRQ4E35vGLhyt3LABbEXZ56vk1flCG2DDuptXn9mkiJdAvFEZ5CaXwyV6PD6Bzk
         U6Y5p7KBp2wJ5H0VHIrM29Ms4uTTtbAVTRKBmtFLs6pD3BpmlbVWRG7cn191OxH4w1LN
         OMljRYDyql/PWRs3rovdE9sp9uhcyMgcqs0np0pudkuoZqAN7Khfr7216TuHUDqHynKk
         oQagcuvNxkyHzhovmWA3EZ5o+LE7AvmqVkCAqsdGDakXq4by6oyzrS1Ge2fK35T4tDzg
         iuAafbwbi+5wujXb4Sat41hGewOrDTgg3MSuMpJAGiRta4heyAN/SjDCqzXsCW2YCoZc
         lujA==
X-Gm-Message-State: AOJu0YzKo+kb1ZdqsogjqQ7d9TB9ovdT+L6CXlSPx7pUHCibSrvJICaM
        82zIC3D80xqywHRFJRqb6ZsegGPerAbVAH/s1uhiCA==
X-Google-Smtp-Source: AGHT+IFLGM1261pComVv+NHDmqh+2UEqT7nWG5hxMAYgDvvCOtWWuqwgPQF5TpOy7pa8p4Wg2ZuPsfVDMrzIWHTh/HA=
X-Received: by 2002:a1f:2b8e:0:b0:49a:466c:199e with SMTP id
 r136-20020a1f2b8e000000b0049a466c199emr13179848vkr.2.1700138218480; Thu, 16
 Nov 2023 04:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20231114095217.1142360-1-jens.wiklander@linaro.org> <20231114095217.1142360-3-jens.wiklander@linaro.org>
In-Reply-To: <20231114095217.1142360-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 16 Nov 2023 18:06:47 +0530
Message-ID: <CAFA6WYPPrH02aDCiUD6FhC_CzbZaeps++X6yj3FAp9TMr3uLVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] optee: allocate shared memory with alloc_pages_exact()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:22, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Allocate memory to share with the secure using alloc_pages_exact()

s/with the secure using/with the secure world using/

> instead of alloc_pages() for more efficient memory usage.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>

Apart from nit above, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 38ea2fecfc2e..4a4b03b4fc7d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -26,10 +26,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                                                    size_t num_pages,
>                                                    unsigned long start))
>  {
> -       unsigned int order = get_order(size);
> -       unsigned int nr_pages = 1 << order;
> +       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
>         struct page **pages;
> -       struct page *page;
>         unsigned int i;
>         int rc = 0;
>
> @@ -37,13 +35,13 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
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
> +       shm->paddr = virt_to_phys(shm->kaddr);
> +       shm->size = nr_pages * PAGE_SIZE;
>
>         pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>         if (!pages) {
> @@ -52,7 +50,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>         }
>
>         for (i = 0; i < nr_pages; i++)
> -               pages[i] = page + i;
> +               pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
>
>         shm->pages = pages;
>         shm->num_pages = nr_pages;
> @@ -66,7 +64,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>
>         return 0;
>  err:
> -       free_pages((unsigned long)shm->kaddr, order);
> +       free_pages_exact(shm->kaddr, shm->size);
>         shm->kaddr = NULL;
>         return rc;
>  }
> @@ -77,7 +75,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  {
>         if (shm_unregister)
>                 shm_unregister(shm->ctx, shm);
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +       free_pages_exact(shm->kaddr, shm->size);
>         shm->kaddr = NULL;
>         kfree(shm->pages);
>         shm->pages = NULL;
> --
> 2.34.1
>
