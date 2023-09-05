Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82727929E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbjIEQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353543AbjIEGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:40:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B8BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:40:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97A566607186;
        Tue,  5 Sep 2023 07:40:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693896002;
        bh=g+OWJT4s3+bbYpOWkEKJ7hdMk/aXOOMG+H2OMRK+Xc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A1KaqNOA4wfy9xhf17B1BcBTv99Vb9Rz/xWQLPWSWKOXfsjbNM0wTsNqDkaa++pkd
         vOwVAfF0/R0zYShFAm35J9+Gr+ONTI81TTCQtUqVVjw/i8bXfg4Hhd15HRZCwaztKV
         rPEh5CPeHSy7Zeh4XzKzWVoDUv1tIidMnfBNwP0xH7iYjdalCoCrv/pxpZbP82yXx+
         5mrbG7fKVy8VH88l4idvig5fuu8bkBpT+UTokK+jV3beCF+/N7dMaIMyX6naFR+80b
         YXFfPDpFzUhTd6yEdQW7jFU88buYG88+dFXKhKSI1xgJABw6X1dwx+a9S5/wBxyjiA
         Oy7E9/LAgar2A==
Date:   Tue, 5 Sep 2023 08:39:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v16 10/20] drm/shmem-helper: Add and use pages_pin_count
Message-ID: <20230905083958.64a1d100@collabora.com>
In-Reply-To: <20230903170736.513347-11-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-11-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Sep 2023 20:07:26 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Add separate pages_pin_count for tracking of whether drm-shmem pages are
> moveable or not. With the addition of memory shrinker support to drm-shmem,
> the pages_use_count will no longer determine whether pages are hard-pinned
> in memory, but whether pages exist and are soft-pinned (and could be swapped
> out). The pages_pin_count > 1 will hard-pin pages in memory.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 24 ++++++++++++++++--------
>  include/drm/drm_gem_shmem_helper.h     | 10 ++++++++++
>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 25e99468ced2..7e1e674e2c9f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -236,18 +236,16 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  
>  	dma_resv_assert_held(shmem->base.resv);
>  
> +	if (refcount_inc_not_zero(&shmem->pages_pin_count))
> +		return 0;
> +
>  	ret = drm_gem_shmem_get_pages_locked(shmem);
> +	if (!ret)
> +		refcount_set(&shmem->pages_pin_count, 1);
>  
>  	return ret;
>  }
>  
> -static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
> -{
> -	dma_resv_assert_held(shmem->base.resv);
> -
> -	drm_gem_shmem_put_pages_locked(shmem);
> -}
> -
>  /**
>   * drm_gem_shmem_pin - Pin backing pages for a shmem GEM object
>   * @shmem: shmem GEM object
> @@ -265,6 +263,9 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
>  
>  	drm_WARN_ON(obj->dev, obj->import_attach);
>  
> +	if (refcount_inc_not_zero(&shmem->pages_pin_count))
> +		return 0;
> +
>  	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
>  	if (ret)
>  		return ret;
> @@ -288,8 +289,14 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
>  
>  	drm_WARN_ON(obj->dev, obj->import_attach);
>  
> +	if (refcount_dec_not_one(&shmem->pages_pin_count))
> +		return;
> +
>  	dma_resv_lock(shmem->base.resv, NULL);
> -	drm_gem_shmem_unpin_locked(shmem);
> +
> +	if (refcount_dec_and_test(&shmem->pages_pin_count))
> +		drm_gem_shmem_put_pages_locked(shmem);
> +
>  	dma_resv_unlock(shmem->base.resv);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
> @@ -634,6 +641,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
>  	if (shmem->base.import_attach)
>  		return;
>  
> +	drm_printf_indent(p, indent, "pages_pin_count=%u\n", refcount_read(&shmem->pages_pin_count));
>  	drm_printf_indent(p, indent, "pages_use_count=%u\n", shmem->pages_use_count);
>  	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
>  	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 808083279fd5..1cd74ae5761a 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -39,6 +39,16 @@ struct drm_gem_shmem_object {
>  	 */
>  	unsigned int pages_use_count;
>  
> +	/**
> +	 * @pages_pin_count:
> +	 *
> +	 * Reference count on the pinned pages table.
> +	 * The pages allowed to be evicted and purged by memory
> +	 * shrinker only when the count is zero, otherwise pages
> +	 * are hard-pinned in memory.
> +	 */
> +	refcount_t pages_pin_count;
> +
>  	/**
>  	 * @madv: State for madvise
>  	 *

