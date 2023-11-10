Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FE7E80FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbjKJSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbjKJSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46062AD30
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:59:19 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45E7066073F9;
        Fri, 10 Nov 2023 10:59:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699613958;
        bh=ZwpoO39PwAcjfL9GkpofbSRYEQHZvFcfLJvO8dVtaOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCwmaf1/GH2BOD+QU8ObZlILAodHTzNOczSmHflRumj1efPx3yYxSSS9u67/DiPc9
         akCQp8c8oTOmR8KC+mUyP97IXWHGAnBWXdAyB2TqgNfS5I+YUO0ix490jHP7+jz5c2
         H+2AkWtC8sXPXWLw+FbbyF2to86qEcIqtFjO/qNOkrVZq5xsZ+GX7TVYtFtRQSN6+O
         qdC7dMsQMct6JEA0CziZ7/54ZwAM2TtiWCQ6Sm5T78vZBA/A3AgfvN97u3kJLBlmWq
         MFuCUM9UOE59hK9dNfyWC+XWCy9ivT0Au5UIlH8rH9uluauoeexGSdEr/4/wj5O3Z/
         Yry6w8sobEgdg==
Date:   Fri, 10 Nov 2023 11:59:13 +0100
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
Subject: Re: [PATCH v18 16/26] drm/virtio: Explicitly get and put drm-shmem
 pages
Message-ID: <20231110115913.48f5672b@collabora.com>
In-Reply-To: <20231029230205.93277-17-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-17-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:55 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're moving away from implicit get_pages() that is done by
> get_pages_sgt() to simplify the refcnt handling. Drivers will have
> to pin pages while they use sgt. VirtIO-GPU doesn't support shrinker,
> hence pages are pinned and sgt is valid as long as pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index ee5d2a70656b..998f8b05ceb1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -67,6 +67,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>  
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  	if (virtio_gpu_is_shmem(bo)) {
> +		drm_gem_shmem_put_pages(&bo->base);
>  		drm_gem_shmem_free(&bo->base);
>  	} else if (virtio_gpu_is_vram(bo)) {
>  		struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
> @@ -196,9 +197,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		return PTR_ERR(shmem_obj);
>  	bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
>  
> +	ret = drm_gem_shmem_get_pages(shmem_obj);
> +	if (ret)
> +		goto err_free_gem;
> +
>  	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
>  	if (ret < 0)
> -		goto err_free_gem;
> +		goto err_put_pages;
>  
>  	bo->dumb = params->dumb;
>  
> @@ -243,6 +248,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  	kvfree(ents);
>  err_put_id:
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> +err_put_pages:
> +	drm_gem_shmem_put_pages(shmem_obj);
>  err_free_gem:
>  	drm_gem_shmem_free(shmem_obj);
>  	return ret;

