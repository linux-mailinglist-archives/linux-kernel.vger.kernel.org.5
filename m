Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55368773FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjHHQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjHHQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBAB4FB0E;
        Tue,  8 Aug 2023 08:58:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADBD066071E9;
        Tue,  8 Aug 2023 08:21:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691479281;
        bh=UXRcgMncZj39YeKfwT0rE7PfhMSJQ8L3/sbxhBni15s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NK7ESBq/vynUZ0Aazs9Dv3B48dz4zwMylbAeXJWVjgbX0SRVb4XVKHmOK689nJcsI
         940GrX/OyXYwglHIez6BsuJ5SnoypyDdhvMlC2dh48xqc5re0LuN0wGfHbaZu7yjPw
         ihmKR3w23weg0AxJVQWy/DWUzflpbA+9m4O40mHmqts6OB7F45jYaok7FmOlO6nfGK
         Tvd8zy79/WYRbfuW2OXi7nNEf15+GwtJLaA96nzjdh7VWWlo1DZgC2A17iqiEiWYMP
         9Xwp9XM2n/jZgg/P/NiZ4YaVImnQoV7VHCDvuGCqKp5cnDSEr2bq3xsXFSnIGHnAx8
         kMbkoFMYZdQ7g==
Date:   Tue, 8 Aug 2023 09:21:17 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v9 01/11] drm/gem: fix lockdep check for
 dma-resv lock
Message-ID: <20230808092117.7f7fdef9@collabora.com>
In-Reply-To: <20230803165238.8798-2-dakr@redhat.com>
References: <20230803165238.8798-1-dakr@redhat.com>
        <20230803165238.8798-2-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 18:52:20 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> When no custom lock is set to protect a GEMs GPUVA list, lockdep checks
> should fall back to the GEM objects dma-resv lock. With the current
> implementation we're setting the lock_dep_map of the GEM objects 'resv'
> pointer (in case no custom lock_dep_map is set yet) on
> drm_gem_private_object_init().
> 
> However, the GEM objects 'resv' pointer might still change after
> drm_gem_private_object_init() is called, e.g. through
> ttm_bo_init_reserved(). This can result in the wrong lock being tracked.
> 
> To fix this, call dma_resv_held() directly from
> drm_gem_gpuva_assert_lock_held() and fall back to the GEMs lock_dep_map
> pointer only if an actual custom lock is set.
> 
> Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

but I'm wondering if it wouldn't be a good thing to add a
drm_gem_set_resv() helper, so the core can control drm_gem_object::resv
re-assignments (block them if it's happening after the GEM has been
exposed to the outside world or update auxiliary data if it's happening
before that).

> ---
>  include/drm/drm_gem.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index c0b13c43b459..bc9f6aa2f3fe 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -551,15 +551,17 @@ int drm_gem_evict(struct drm_gem_object *obj);
>   * @lock: the lock used to protect the gpuva list. The locking primitive
>   * must contain a dep_map field.
>   *
> - * Call this if you're not proctecting access to the gpuva list
> - * with the dma-resv lock, otherwise, drm_gem_gpuva_init() takes care
> - * of initializing lock_dep_map for you.
> + * Call this if you're not proctecting access to the gpuva list with the
> + * dma-resv lock, but with a custom lock.
>   */
>  #define drm_gem_gpuva_set_lock(obj, lock) \
> -	if (!(obj)->gpuva.lock_dep_map) \
> +	if (!WARN((obj)->gpuva.lock_dep_map, \
> +		  "GEM GPUVA lock should be set only once.")) \
>  		(obj)->gpuva.lock_dep_map = &(lock)->dep_map
>  #define drm_gem_gpuva_assert_lock_held(obj) \
> -	lockdep_assert(lock_is_held((obj)->gpuva.lock_dep_map))
> +	lockdep_assert((obj)->gpuva.lock_dep_map ? \
> +		       lock_is_held((obj)->gpuva.lock_dep_map) : \
> +		       dma_resv_held((obj)->resv))
>  #else
>  #define drm_gem_gpuva_set_lock(obj, lock) do {} while (0)
>  #define drm_gem_gpuva_assert_lock_held(obj) do {} while (0)
> @@ -573,11 +575,12 @@ int drm_gem_evict(struct drm_gem_object *obj);
>   *
>   * Calling this function is only necessary for drivers intending to support the
>   * &drm_driver_feature DRIVER_GEM_GPUVA.
> + *
> + * See also drm_gem_gpuva_set_lock().
>   */
>  static inline void drm_gem_gpuva_init(struct drm_gem_object *obj)
>  {
>  	INIT_LIST_HEAD(&obj->gpuva.list);
> -	drm_gem_gpuva_set_lock(obj, &obj->resv->lock.base);
>  }
>  
>  /**

