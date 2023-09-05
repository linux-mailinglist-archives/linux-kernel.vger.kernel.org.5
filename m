Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B02792ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbjIEQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353641AbjIEHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:00:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2A1B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:00:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 365506607186;
        Tue,  5 Sep 2023 08:00:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693897245;
        bh=gjw9UsrNPHk8NsvI3Oc7dZ/ykpTFR6C89yjJF8x2PtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TklyJm3Xf4ziPLu+DDAeO6JEJmBgfqyHvJ3IgIdNCNGQv4gZclrLe1Uqf/rxjVoBv
         izkDBxZiWCQ0kbdLKfj0hr0devreAViZeeO6JkzAc60n0zyAknpFIAgiw5WqyFxZX5
         U51hQm6g27B2PCJob8hjEt961QmwOgv19nzTYTJFEIOsDdgD2+YDGHGVtqmvBfNMAm
         Z03ZmBN5CpD4Gwo473BeQ6ZeaKZb7J84L9J69tqZfzhXd0WF1C6wtw1yO3OTjipAoo
         kvMBWVI+LvSeLys/WWYmV5fbDB1XibBuug8mdgZ8IlF61ss9wke8n2JhdVd9VjYb8H
         gQcTWAKR2VZCw==
Date:   Tue, 5 Sep 2023 09:00:42 +0200
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
Subject: Re: [PATCH v16 13/20] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
Message-ID: <20230905090042.3a7b7557@collabora.com>
In-Reply-To: <20230903170736.513347-14-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-14-dmitry.osipenko@collabora.com>
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

On Sun,  3 Sep 2023 20:07:29 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> The vmapped pages shall be pinned in memory and previously get/put_pages()
> were implicitly hard-pinning/unpinning the pages. This will no longer be
> the case with addition of memory shrinker because pages_use_count > 0 won't
> determine anymore whether pages are hard-pinned (they will be soft-pinned),
> while the new pages_pin_count will do the hard-pinning. Switch the
> vmap/vunmap() to use pin/unpin() functions in a preparation of addition
> of the memory shrinker support to drm-shmem.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 ++++++++++++-------
>  include/drm/drm_gem_shmem_helper.h     |  2 +-
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index d93ebfef20c7..899f655a65bb 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -257,6 +257,14 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  	return ret;
>  }
>  
> +static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
> +{
> +	dma_resv_assert_held(shmem->base.resv);
> +
> +	if (refcount_dec_and_test(&shmem->pages_pin_count))
> +		drm_gem_shmem_put_pages_locked(shmem);
> +}
> +
>  /**
>   * drm_gem_shmem_pin - Pin backing pages for a shmem GEM object
>   * @shmem: shmem GEM object
> @@ -304,10 +312,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
>  		return;
>  
>  	dma_resv_lock(shmem->base.resv, NULL);
> -
> -	if (refcount_dec_and_test(&shmem->pages_pin_count))
> -		drm_gem_shmem_put_pages_locked(shmem);
> -
> +	drm_gem_shmem_unpin_locked(shmem);
>  	dma_resv_unlock(shmem->base.resv);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
> @@ -345,7 +350,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  			return 0;
>  		}
>  
> -		ret = drm_gem_shmem_get_pages_locked(shmem);
> +		ret = drm_gem_shmem_pin_locked(shmem);
>  		if (ret)
>  			goto err_zero_use;
>  
> @@ -368,7 +373,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  
>  err_put_pages:
>  	if (!obj->import_attach)
> -		drm_gem_shmem_put_pages_locked(shmem);
> +		drm_gem_shmem_unpin_locked(shmem);
>  err_zero_use:
>  	shmem->vmap_use_count = 0;
>  
> @@ -405,7 +410,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
>  			return;
>  
>  		vunmap(shmem->vaddr);
> -		drm_gem_shmem_put_pages_locked(shmem);
> +		drm_gem_shmem_unpin_locked(shmem);
>  	}
>  
>  	shmem->vaddr = NULL;
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index bd545428a7ee..396958a98c34 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -137,7 +137,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
>  static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
>  {
>  	return (shmem->madv > 0) &&
> -		!shmem->vmap_use_count && shmem->sgt &&
> +		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
>  		!shmem->base.dma_buf && !shmem->base.import_attach;
>  }
>  

