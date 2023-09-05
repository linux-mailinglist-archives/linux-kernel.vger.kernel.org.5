Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E42792C01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbjIERFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353724AbjIEHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:33:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF918C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:33:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB205660716C;
        Tue,  5 Sep 2023 08:33:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693899203;
        bh=77PTdlmF0OU78SUMZuNK96mglFtntqL2JeT8yn02ajs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EqvzcgU5VH/pSuVHsNn6GF+WxvkX4Z61bGfgcsACjQrW0qnZAXPPKBS8On4o/nw2K
         CiJfsgpszqWOeWdGwBrh7VD3lYAr+FUUMyAEdrKP0DHVdAg4i+EXvSCBeDDvILsxnY
         7ouEn1J/6n+bh5XqV9K6CUfTivk1MaXtP+WTMQe8+TcvXa2tt0WZRjuJcBNIkhghxR
         B4boyww+atN/8YZ0AFwC4EUqDLr8w/G89wYpgp04T4+DcialHK2eHXKGeM5l8OdlFo
         bUjvinVuakOuI56VfQ5c85rd2RLVvHRck5CyDYHk/4TbmBrkFmPhP3woHm5s+3TWSY
         EW+a/t02HPIvw==
Date:   Tue, 5 Sep 2023 09:33:19 +0200
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
Subject: Re: [PATCH v16 05/20] drm/v3d: Replace open-coded
 drm_gem_shmem_free() with drm_gem_object_put()
Message-ID: <20230905093319.25300fa4@collabora.com>
In-Reply-To: <20230903170736.513347-6-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-6-dmitry.osipenko@collabora.com>
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

On Sun,  3 Sep 2023 20:07:21 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> The drm_gem_shmem_free() doesn't put GEM's kref to zero, which becomes
> important with addition of the shrinker support to drm-shmem that will
> use kref=0 in order to prevent taking lock during special GEM-freeing
> time in order to avoid spurious lockdep warning about locking ordering
> vs fs_reclaim code paths.

As for patch 4, I don't mind the change (I actually think it's better
to have a single error path with a free function handling partially
initialized GEM objects, which is exactly what your patch is doing), but
I disagree with the explanation, especially after you dropped
"drm/shmem-helper: Add and use drm_gem_shmem_resv_assert_held() helper"
and went for a drm_gem_shmem_do_release_pages_locked() helper called in
drm_gem_shmem_free().

> 
> Replace open-coded drm_gem_shmem_free() with drm_gem_object_put() that
> drops kref to zero before freeing GEM.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/v3d/v3d_bo.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 8b3229a37c6d..70c1095d6eec 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -33,16 +33,18 @@ void v3d_free_object(struct drm_gem_object *obj)
>  	struct v3d_dev *v3d = to_v3d_dev(obj->dev);
>  	struct v3d_bo *bo = to_v3d_bo(obj);
>  
> -	v3d_mmu_remove_ptes(bo);
> +	if (drm_mm_node_allocated(&bo->node)) {
> +		v3d_mmu_remove_ptes(bo);
>  
> -	mutex_lock(&v3d->bo_lock);
> -	v3d->bo_stats.num_allocated--;
> -	v3d->bo_stats.pages_allocated -= obj->size >> PAGE_SHIFT;
> -	mutex_unlock(&v3d->bo_lock);
> +		mutex_lock(&v3d->bo_lock);
> +		v3d->bo_stats.num_allocated--;
> +		v3d->bo_stats.pages_allocated -= obj->size >> PAGE_SHIFT;
> +		mutex_unlock(&v3d->bo_lock);
>  
> -	spin_lock(&v3d->mm_lock);
> -	drm_mm_remove_node(&bo->node);
> -	spin_unlock(&v3d->mm_lock);
> +		spin_lock(&v3d->mm_lock);
> +		drm_mm_remove_node(&bo->node);
> +		spin_unlock(&v3d->mm_lock);
> +	}
>  
>  	/* GPU execution may have dirtied any pages in the BO. */
>  	bo->base.pages_mark_dirty_on_put = true;
> @@ -142,7 +144,7 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
>  	return bo;
>  
>  free_obj:
> -	drm_gem_shmem_free(shmem_obj);
> +	drm_gem_object_put(&shmem_obj->base);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -160,7 +162,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>  
>  	ret = v3d_bo_create_finish(obj);
>  	if (ret) {
> -		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
> +		drm_gem_object_put(obj);
>  		return ERR_PTR(ret);
>  	}
>  

