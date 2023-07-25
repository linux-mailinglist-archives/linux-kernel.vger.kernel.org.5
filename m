Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608B760BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjGYH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGYH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:28:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5426A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:27:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDAEB6607105;
        Tue, 25 Jul 2023 08:27:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690270032;
        bh=ZYUTx+BvPIPmtEGL5Ro9byEVVDfU167QGfKJqwSxeQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lb/i3/B0m7SIsXo4lLqu5960BB5UABN7MZGLiNob/Y5r/1X0Yjh3nUvReqhSQPtMT
         gav5i4Hcu5gp7/v34u6xuMsMKOlThs8HrbU2Fb5tGdGEatEmCmAtYgRBFlKQdN/5K5
         paNueNywLBSbpvtpHRFTrjhbWsqtYJXvHtCuSQ6dI2aFp81CWCm4qaRiksEzATd8Sp
         Vz65V5XuJ4rQmIdt1j5khhTceEaZLch97epYz92mb1Df0G3iptwpVaNzqKsKi6BuPX
         D2AkCHK3pberBqbc+Lej2HHzs/+THn+0ov8TohJxlO4iij2RcMR6Hy93tM1X7h73in
         8wF+VwMvJgAjA==
Date:   Tue, 25 Jul 2023 09:27:09 +0200
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
Subject: Re: [PATCH v14 02/12] drm/shmem-helper: Add pages_pin_count field
Message-ID: <20230725092709.51356f39@collabora.com>
In-Reply-To: <20230722234746.205949-3-dmitry.osipenko@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
        <20230722234746.205949-3-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 02:47:36 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> And new pages_pin_count field to struct drm_gem_shmem_object that will
> determine whether pages are evictable by memory shrinker. The pages will
> be evictable only when pages_pin_count=0. This patch prepares code for
> addition of the memory shrinker that will utilize the new field.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 9 +++++++++
>  include/drm/drm_gem_shmem_helper.h     | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 267153853e2c..42ba201dda50 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -274,15 +274,24 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  	dma_resv_assert_held(shmem->base.resv);
>  
>  	ret = drm_gem_shmem_get_pages(shmem);
> +	if (!ret)
> +		shmem->pages_pin_count++;
>  
>  	return ret;
>  }
>  
>  static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>  {
> +	struct drm_gem_object *obj = &shmem->base;
> +
>  	dma_resv_assert_held(shmem->base.resv);
>  
> +	if (drm_WARN_ON_ONCE(obj->dev, !shmem->pages_pin_count))
> +		return;
> +
>  	drm_gem_shmem_put_pages(shmem);
> +
> +	shmem->pages_pin_count--;
>  }
>  
>  /**
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index bf0c31aa8fbe..7111f5743006 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -39,6 +39,15 @@ struct drm_gem_shmem_object {
>  	 */
>  	unsigned int pages_use_count;
>  
> +	/**
> +	 * @pages_pin_count:
> +	 *
> +	 * Reference count on the pinned pages table.
> +	 * The pages allowed to be evicted by memory shrinker
> +	 * only when the count is zero.
> +	 */
> +	unsigned int pages_pin_count;

Can we make it an atomic_t, so we can avoid taking the lock when the
GEM has already been pinned. That's something I need to be able to grab
a pin-ref in a path where the GEM resv lock is already held[1]. We could
of course expose the locked version, but in my case, I want to enforce
the fact the GEM has been pinned before the drm_gem_shmem_pin() call in
the section protected by the resv lock, so catching a "refcount 0 -> 1"
situation would be useful. Beside, using an atomic to avoid the
lock/unlock dance when refcount > 1 might be beneficial to everyone.

[1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/4420fa0d5768ebdc35b34d58d4ae5fad9fbb93f9

> +
>  	/**
>  	 * @madv: State for madvise
>  	 *

