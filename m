Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1F78A9B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjH1KNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjH1KMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:12:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357B10C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:12:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C03AE6607181;
        Mon, 28 Aug 2023 11:12:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693217563;
        bh=8VxF/Zh3lcDahMBvxQgvdgpueUTKgY5p3OuJRZFv2TI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=degu/FMjBsTpOjLuM74t3Lew4KY74VhueEVgDUPC8dNb5RXlvt9bqrW4oFqRXlVck
         rdnBIawv7jS5BTtN9Kn3EtUCL7nbianiihDTPAteaWT4zy/pdVb+w1T/RgU2ORbky3
         8MVFUGGNyF0xHtueLkSYFIE8VzdsClHeildj8WER5U8dIQEVVTAmfSg6EWQv7xsCJp
         QDKCX0D0b6uzweZK68Uj2eaaoVML5eX3x/kgeh85BeQcOseq4qm827inHHwEv6/JRa
         p/tIXOaTgz6ILjJsb1ZabJqfdjD2bekXIMO3VXDKvV8g1UrkXBMCIc9dlyMNBWPedX
         aqvpnqF5euzzQ==
Date:   Mon, 28 Aug 2023 12:12:39 +0200
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
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v15 17/23] drm/shmem-helper: Add and use
 drm_gem_shmem_resv_assert_held() helper
Message-ID: <20230828121239.78a180e6@collabora.com>
In-Reply-To: <20230827175449.1766701-18-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
        <20230827175449.1766701-18-dmitry.osipenko@collabora.com>
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

On Sun, 27 Aug 2023 20:54:43 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> In a preparation of adding drm-shmem memory shrinker, move all reservation
> locking lockdep checks to use new drm_gem_shmem_resv_assert_held() that
> will resolve spurious lockdep warning about wrong locking order vs
> fs_reclam code paths during freeing of shmem GEM, where lockdep isn't
> aware that it's impossible to have locking contention with the fs_reclam
> at this special time.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 37 +++++++++++++++++---------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index d96fee3d6166..ca5da976aafa 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -128,6 +128,23 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
>  
> +static void drm_gem_shmem_resv_assert_held(struct drm_gem_shmem_object *shmem)
> +{
> +	/*
> +	 * Destroying the object is a special case.. drm_gem_shmem_free()
> +	 * calls many things that WARN_ON if the obj lock is not held.  But
> +	 * acquiring the obj lock in drm_gem_shmem_free() can cause a locking
> +	 * order inversion between reservation_ww_class_mutex and fs_reclaim.
> +	 *
> +	 * This deadlock is not actually possible, because no one should
> +	 * be already holding the lock when drm_gem_shmem_free() is called.
> +	 * Unfortunately lockdep is not aware of this detail.  So when the
> +	 * refcount drops to zero, we pretend it is already locked.
> +	 */
> +	if (kref_read(&shmem->base.refcount))
> +		drm_gem_shmem_resv_assert_held(shmem);
> +}
> +
>  /**
>   * drm_gem_shmem_free - Free resources associated with a shmem GEM object
>   * @shmem: shmem GEM object to free
> @@ -142,8 +159,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  	if (obj->import_attach) {
>  		drm_prime_gem_destroy(obj, shmem->sgt);
>  	} else if (!shmem->imported_sgt) {
> -		dma_resv_lock(shmem->base.resv, NULL);
> -
>  		drm_WARN_ON(obj->dev, kref_read(&shmem->vmap_use_count));
>  
>  		if (shmem->sgt) {
> @@ -156,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  			drm_gem_shmem_put_pages_locked(shmem);

AFAICT, drm_gem_shmem_put_pages_locked() is the only function that's
called in the free path and would complain about resv-lock not being
held. I think I'd feel more comfortable if we were adding a
drm_gem_shmem_free_pages() function that did everything
drm_gem_shmem_put_pages_locked() does except for the lock_held() check
and the refcount dec, and have it called here (and in
drm_gem_shmem_put_pages_locked()). This way we can keep using
dma_resv_assert_held() instead of having our own variant.

>  
>  		drm_WARN_ON(obj->dev, kref_read(&shmem->pages_use_count));
> -
> -		dma_resv_unlock(shmem->base.resv);
>  	}
>  
>  	drm_gem_object_release(obj);
> @@ -170,7 +183,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct page **pages;
>  
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	if (kref_get_unless_zero(&shmem->pages_use_count))
>  		return 0;
> @@ -228,7 +241,7 @@ static void drm_gem_shmem_kref_release_pages(struct kref *kref)
>   */
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	kref_put(&shmem->pages_use_count, drm_gem_shmem_kref_release_pages);
>  }
> @@ -252,7 +265,7 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
>  
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	if (kref_get_unless_zero(&shmem->pages_pin_count))
>  		return 0;
> @@ -276,7 +289,7 @@ static void drm_gem_shmem_kref_unpin_pages(struct kref *kref)
>  
>  static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>  {
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	kref_put(&shmem->pages_pin_count, drm_gem_shmem_kref_unpin_pages);
>  }
> @@ -357,7 +370,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  	} else {
>  		pgprot_t prot = PAGE_KERNEL;
>  
> -		dma_resv_assert_held(shmem->base.resv);
> +		drm_gem_shmem_resv_assert_held(shmem);
>  
>  		if (kref_get_unless_zero(&shmem->vmap_use_count)) {
>  			iosys_map_set_vaddr(map, shmem->vaddr);
> @@ -426,7 +439,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
>  	if (obj->import_attach) {
>  		dma_buf_vunmap(obj->import_attach->dmabuf, map);
>  	} else {
> -		dma_resv_assert_held(shmem->base.resv);
> +		drm_gem_shmem_resv_assert_held(shmem);
>  		kref_put(&shmem->vmap_use_count, drm_gem_shmem_kref_vunmap);
>  	}
>  
> @@ -462,7 +475,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>   */
>  int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv)
>  {
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	if (shmem->madv >= 0)
>  		shmem->madv = madv;
> @@ -478,7 +491,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct drm_device *dev = obj->dev;
>  
> -	dma_resv_assert_held(shmem->base.resv);
> +	drm_gem_shmem_resv_assert_held(shmem);
>  
>  	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
>  

