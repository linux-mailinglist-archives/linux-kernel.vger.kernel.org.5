Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40D7E81D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbjKJSh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbjKJSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:34:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFC2AD3C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:01:28 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A25A66073EB;
        Fri, 10 Nov 2023 11:01:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699614087;
        bh=M7g15Ds3YB0rAZrwMqFqhvf/l8gr3sjjjFteM0C28zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hbb8LDTQq4RSYvyQKXhwzEaFY3S/PSmM2XeVj8XNi5/pmEFm+CXppTiuTj7QD4CZx
         8co2y4KUpNxbre2QFzUUcxRA8sCPdl2Z+jxgtbG+80PTAsE9BoMeC5F14w0W1jgmz/
         OV5w1DJ/ocBfKg7xRQQelCeq/r68xhZxMOmsrL02W9qe9LuCWJhmbL6HHGAUD/0Ttf
         gHYguXb0/fxr81PZJhFrPt7GM8DXDF0KWVIHuuXNSLRCIbzrQHP/Aq36d0BSVXWFpV
         IZTIsIKBR0jzOw9XBpgwo9WUTuSuRdYKExb716IYVxzMjqPM6sGpodGY933J8AqFLT
         c9mLE9lfwOacw==
Date:   Fri, 10 Nov 2023 12:01:23 +0100
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
Subject: Re: [PATCH v18 17/26] drm/v3d: Explicitly get and put drm-shmem
 pages
Message-ID: <20231110120123.65f399af@collabora.com>
In-Reply-To: <20231029230205.93277-18-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-18-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:56 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> To simplify the drm-shmem refcnt handling, we're moving away from
> the implicit get_pages() that is used by get_pages_sgt(). From now on
> drivers will have to pin pages while they use sgt. V3D driver doesn't
> support shrinker, hence pages are pinned and sgt is valid as long as
> pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/v3d/v3d_bo.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 42cd874f6810..0597c6b01b6c 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -47,6 +47,9 @@ void v3d_free_object(struct drm_gem_object *obj)
>  	/* GPU execution may have dirtied any pages in the BO. */
>  	bo->base.pages_mark_dirty_on_put = true;
>  
> +	if (!obj->import_attach)
> +		drm_gem_shmem_put_pages(&bo->base);
> +
>  	drm_gem_shmem_free(&bo->base);
>  }
>  
> @@ -135,12 +138,18 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
>  		return ERR_CAST(shmem_obj);
>  	bo = to_v3d_bo(&shmem_obj->base);
>  
> -	ret = v3d_bo_create_finish(&shmem_obj->base);
> +	ret = drm_gem_shmem_get_pages(shmem_obj);
>  	if (ret)
>  		goto free_obj;
>  
> +	ret = v3d_bo_create_finish(&shmem_obj->base);
> +	if (ret)
> +		goto put_pages;
> +
>  	return bo;
>  
> +put_pages:
> +	drm_gem_shmem_put_pages(shmem_obj);
>  free_obj:
>  	drm_gem_shmem_free(shmem_obj);
>  	return ERR_PTR(ret);

