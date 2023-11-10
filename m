Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850D7E7F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjKJRxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKJRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD72DE75
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:15:43 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BF1A66073EB;
        Fri, 10 Nov 2023 11:15:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699614941;
        bh=IX+JT55IYP1u5VMEzIBMbRyK6BoNMKTFRZG8ZICiNpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nl1qwv/ExujGVRXi4s+XEQXd+vR1UNkr9UD1QSUFwFY7sbhDYRnmCdB7A+2yO9ar3
         LTJfddwSoKWvGrI/54va3pfmN3G4jeH41dGnaJIT+b2JU0V/cay5bNiU23ySm8ecMI
         iw1rMZMh7oidN2xpmemNKnZhg8U4+ZNDbU2Q+cqGWmrTHZHBbSLjbr8MP2NV2ahuZo
         BgW4pVR/9FnnBS/3Lql2Mp2fXvqLFq+Z2MfiPP67djbsgPR2Oa0H2BE3F9iD0Yx5c8
         LAuAbGWDtYL88bXyts34wJyXjyqkMj+R09jYk0AAbk5ILd/3YmMt90GMNccDe99QP7
         R8Aizc3dMReQA==
Date:   Fri, 10 Nov 2023 12:15:37 +0100
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
Subject: Re: [PATCH v18 18/26] drm/shmem-helper: Change sgt allocation
 policy
Message-ID: <20231110121537.6f37c5a0@collabora.com>
In-Reply-To: <20231029230205.93277-19-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-19-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:57 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> In a preparation to addition of drm-shmem memory shrinker support, change
> the SGT allocation policy in this way:
> 
> 1. SGT can be allocated only if shmem pages are pinned at the
> time of allocation, otherwise allocation fails.
> 
> 2. Drivers must ensure that pages are pinned during the time of SGT usage
> and should get new SGT if pages were unpinned.

In general, I would discourage drivers from caching the sgt returned by
drm_gem_shmem_get_pages_sgt[_locked](), since the GEM SHMEM layer does
the caching already, so calling drm_gem_shmem_get_pages_sgt_locked()
should be pretty cheap. What this implies is that any portion of the
code using an sgt returned by drm_gem_shmem_get_pages_sgt_locked() must
be surrounded by get/pin_pages()/put/unpin_pages() calls unless the
pages are known to be pinned for the whole BO lifetime. And of course,
as soon as an MMU mapping is created, and even if the sgt is no longer
accessed, the pages must remain pinned until the MMU mapping is torn
down.

> 
> This new policy is required by the shrinker because it will move pages
> to/from SWAP unless pages are pinned, invalidating SGT pointer once pages
> are relocated.
> 
> Previous patches prepared drivers to the new policy.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 51 +++++++++++++-------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f371ebc6f85c..1420d2166b76 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -133,6 +133,14 @@ drm_gem_shmem_free_pages(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  
> +	if (shmem->sgt) {
> +		dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
> +				  DMA_BIDIRECTIONAL, 0);
> +		sg_free_table(shmem->sgt);
> +		kfree(shmem->sgt);
> +		shmem->sgt = NULL;
> +	}
> +
>  #ifdef CONFIG_X86
>  	if (shmem->map_wc)
>  		set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
> @@ -155,23 +163,12 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  
> -	if (obj->import_attach) {
> +	if (obj->import_attach)
>  		drm_prime_gem_destroy(obj, shmem->sgt);
> -	} else {
> -		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> -
> -		if (shmem->sgt) {
> -			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
> -					  DMA_BIDIRECTIONAL, 0);
> -			sg_free_table(shmem->sgt);
> -			kfree(shmem->sgt);
> -		}
> -		if (shmem->pages)
> -			drm_gem_shmem_put_pages_locked(shmem);
>  
> -		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> -		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> -	}
> +	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> +	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> +	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
>  
>  	drm_gem_object_release(obj);
>  	kfree(shmem);
> @@ -705,6 +702,9 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>  
>  	drm_WARN_ON(obj->dev, obj->import_attach);
>  
> +	if (drm_WARN_ON(obj->dev, !shmem->pages))
> +		return ERR_PTR(-ENOMEM);
> +
>  	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
> @@ -720,15 +720,10 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  
>  	drm_WARN_ON(obj->dev, obj->import_attach);
>  
> -	ret = drm_gem_shmem_get_pages_locked(shmem);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
>  	sgt = drm_gem_shmem_get_sg_table(shmem);
> -	if (IS_ERR(sgt)) {
> -		ret = PTR_ERR(sgt);
> -		goto err_put_pages;
> -	}
> +	if (IS_ERR(sgt))
> +		return sgt;
> +
>  	/* Map the pages for use by the h/w. */
>  	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  	if (ret)
> @@ -741,8 +736,6 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  err_free_sgt:
>  	sg_free_table(sgt);
>  	kfree(sgt);
> -err_put_pages:
> -	drm_gem_shmem_put_pages_locked(shmem);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -759,6 +752,14 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>   * and difference between dma-buf imported and natively allocated objects.
>   * drm_gem_shmem_get_sg_table() should not be directly called by drivers.
>   *
> + * Drivers should adhere to these SGT usage rules:
> + *
> + * 1. SGT should be allocated only if shmem pages are pinned at the
> + *    time of allocation, otherwise allocation will fail.
> + *
> + * 2. Drivers should ensure that pages are pinned during the time of
> + *    SGT usage and should get new SGT if pages were unpinned.
> + *
>   * Returns:
>   * A pointer to the scatter/gather table of pinned pages or errno on failure.
>   */

