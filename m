Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E87E998E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjKMJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjKMJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:57:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488910E7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:57:50 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D18D6602F31;
        Mon, 13 Nov 2023 09:57:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699869469;
        bh=72DkHrm/4LoTQGeZraAu8tWfhlCvXvGaJaNJq753Nj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gmPwQOGAWKtQDjfW3LQ9xFthrOqeZW5TsVOA25Sm7DaZloUvaTC1lo2WdSZZtcIYW
         VQdh/29Luqhsfg8C6S7339J+xq7nkac0zGxaKwqnaXabT1xvrm1jm9rr67GTfIcF98
         +YoZc3wnQ2VSTv74lBhsUn/+L+aPjILOD+ATGSA00hRxLPow9+e2O8z2t0fJSaYmYr
         Z3sQi5NpkZWxC1Ws77f4N3kFhA/Id7bobMIfNDtfRDzySNMuChWUtvJXyCuAVNL+T8
         sVWB1VKU82BF+yqEEKbGM/NG2vD/sOYa0JEsYTuKOJbHw2nZmZB7JKZTAVQgDt269n
         ziEgQat01oWVg==
Date:   Mon, 13 Nov 2023 10:57:45 +0100
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
Subject: Re: [PATCH v18 24/26] drm/virtio: Attach shmem BOs dynamically
Message-ID: <20231113105745.7543e8dd@collabora.com>
In-Reply-To: <20231029230205.93277-25-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-25-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:02:03 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Prepare for addition of memory shrinker support by attaching shmem pages
> to host dynamically on first use. Previously the attachment vq command
> wasn't fenced and there was no vq kick made in the BO creation code path,
> hence the attachment already was happening dynamically, but implicitly.
> Making attachment explicitly dynamic will allow to simplify and reuse more
> code when shrinker will be added. The virtio_gpu_object_shmem_init() now
> works under the held reservation lock, which will be important to have for
> shrinker to avoid moving pages while they are in active use by the driver.

Ah, this commit might actually help getting rid of the workaround
introduced in "drm/shmem-helper: Add common memory shrinker".

> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  7 +++
>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 26 +++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 32 +++++++----
>  drivers/gpu/drm/virtio/virtgpu_object.c | 73 ++++++++++++++++++++-----
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 15 ++++-
>  5 files changed, 125 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 56269814fb6d..421f524ae1de 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -89,6 +89,7 @@ struct virtio_gpu_object {
>  	uint32_t hw_res_handle;
>  	bool dumb;
>  	bool created;
> +	bool detached;
>  	bool host3d_blob, guest_blob;
>  	uint32_t blob_mem, blob_flags;
>  
> @@ -313,6 +314,8 @@ void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
>  void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
>  				       struct virtio_gpu_object_array *objs);
>  void virtio_gpu_array_put_free_work(struct work_struct *work);
> +int virtio_gpu_array_prepare(struct virtio_gpu_device *vgdev,
> +			     struct virtio_gpu_object_array *objs);
>  int virtio_gpu_gem_pin(struct virtio_gpu_object *bo);
>  void virtio_gpu_gem_unpin(struct virtio_gpu_object *bo);
>  
> @@ -453,6 +456,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  
>  bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo);
>  
> +int virtio_gpu_reattach_shmem_object_locked(struct virtio_gpu_object *bo);
> +
> +int virtio_gpu_reattach_shmem_object(struct virtio_gpu_object *bo);
> +
>  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
>  			       uint32_t *resid);
>  /* virtgpu_prime.c */
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 625c05d625bf..97e67064c97e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -295,6 +295,26 @@ void virtio_gpu_array_put_free_work(struct work_struct *work)
>  	spin_unlock(&vgdev->obj_free_lock);
>  }
>  
> +int virtio_gpu_array_prepare(struct virtio_gpu_device *vgdev,
> +			     struct virtio_gpu_object_array *objs)
> +{
> +	struct virtio_gpu_object *bo;
> +	int ret = 0;
> +	u32 i;
> +
> +	for (i = 0; i < objs->nents; i++) {
> +		bo = gem_to_virtio_gpu_obj(objs->objs[i]);
> +
> +		if (virtio_gpu_is_shmem(bo) && bo->detached) {
> +			ret = virtio_gpu_reattach_shmem_object_locked(bo);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int virtio_gpu_gem_pin(struct virtio_gpu_object *bo)
>  {
>  	int err;
> @@ -303,6 +323,12 @@ int virtio_gpu_gem_pin(struct virtio_gpu_object *bo)
>  		err = drm_gem_shmem_pin(&bo->base);
>  		if (err)
>  			return err;
> +
> +		err = virtio_gpu_reattach_shmem_object(bo);
> +		if (err) {
> +			drm_gem_shmem_unpin(&bo->base);
> +			return err;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index b24b11f25197..070c29cea26a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -246,6 +246,10 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>  	if (ret != 0)
>  		goto err_put_free;
>  
> +	ret = virtio_gpu_array_prepare(vgdev, objs);
> +	if (ret)
> +		goto err_unlock;
> +
>  	fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
>  	if (!fence) {
>  		ret = -ENOMEM;
> @@ -288,11 +292,25 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
>  		goto err_put_free;
>  	}
>  
> +	ret = virtio_gpu_array_lock_resv(objs);
> +	if (ret != 0)
> +		goto err_put_free;
> +
> +	ret = virtio_gpu_array_prepare(vgdev, objs);
> +	if (ret)
> +		goto err_unlock;
> +
> +	fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
> +	if (!fence) {
> +		ret = -ENOMEM;
> +		goto err_unlock;
> +	}
> +
>  	if (!vgdev->has_virgl_3d) {
>  		virtio_gpu_cmd_transfer_to_host_2d
>  			(vgdev, offset,
>  			 args->box.w, args->box.h, args->box.x, args->box.y,
> -			 objs, NULL);
> +			 objs, fence);
>  	} else {
>  		virtio_gpu_create_context(dev, file);
>  
> @@ -301,23 +319,13 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
>  			goto err_put_free;
>  		}
>  
> -		ret = virtio_gpu_array_lock_resv(objs);
> -		if (ret != 0)
> -			goto err_put_free;
> -
> -		ret = -ENOMEM;
> -		fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
> -					       0);
> -		if (!fence)
> -			goto err_unlock;
> -
>  		virtio_gpu_cmd_transfer_to_host_3d
>  			(vgdev,
>  			 vfpriv ? vfpriv->ctx_id : 0, offset, args->level,
>  			 args->stride, args->layer_stride, &args->box, objs,
>  			 fence);
> -		dma_fence_put(&fence->f);
>  	}
> +	dma_fence_put(&fence->f);
>  	virtio_gpu_notify(vgdev);
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 998f8b05ceb1..000bb7955a57 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -143,7 +143,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	struct sg_table *pages;
>  	int si;
>  
> -	pages = drm_gem_shmem_get_pages_sgt(&bo->base);
> +	pages = drm_gem_shmem_get_pages_sgt_locked(&bo->base);
>  	if (IS_ERR(pages))
>  		return PTR_ERR(pages);
>  
> @@ -177,6 +177,40 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	return 0;
>  }
>  
> +int virtio_gpu_reattach_shmem_object_locked(struct virtio_gpu_object *bo)
> +{
> +	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> +	struct virtio_gpu_mem_entry *ents;
> +	unsigned int nents;
> +	int err;
> +
> +	if (!bo->detached)
> +		return 0;
> +
> +	err = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
> +	if (err)
> +		return err;
> +
> +	virtio_gpu_object_attach(vgdev, bo, ents, nents);
> +
> +	bo->detached = false;
> +
> +	return 0;
> +}
> +
> +int virtio_gpu_reattach_shmem_object(struct virtio_gpu_object *bo)
> +{
> +	int ret;
> +
> +	ret = dma_resv_lock_interruptible(bo->base.base.resv, NULL);
> +	if (ret)
> +		return ret;
> +	ret = virtio_gpu_reattach_shmem_object_locked(bo);
> +	dma_resv_unlock(bo->base.base.resv);
> +
> +	return ret;
> +}
> +
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  			     struct virtio_gpu_object_params *params,
>  			     struct virtio_gpu_object **bo_ptr,
> @@ -207,45 +241,56 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  
>  	bo->dumb = params->dumb;
>  
> -	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
> -	if (ret != 0)
> -		goto err_put_id;
> +	if (bo->blob_mem == VIRTGPU_BLOB_MEM_GUEST)
> +		bo->guest_blob = true;
>  
>  	if (fence) {
>  		ret = -ENOMEM;
>  		objs = virtio_gpu_array_alloc(1);
>  		if (!objs)
> -			goto err_free_entry;
> +			goto err_put_id;
>  		virtio_gpu_array_add_obj(objs, &bo->base.base);
>  
>  		ret = virtio_gpu_array_lock_resv(objs);
>  		if (ret != 0)
>  			goto err_put_objs;
> +	} else {
> +		ret = dma_resv_lock(bo->base.base.resv, NULL);
> +		if (ret)
> +			goto err_put_id;
>  	}
>  
>  	if (params->blob) {
> -		if (params->blob_mem == VIRTGPU_BLOB_MEM_GUEST)
> -			bo->guest_blob = true;
> +		ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
> +		if (ret)
> +			goto err_unlock_objs;
> +	} else {
> +		bo->detached = true;
> +	}
>  
> +	if (params->blob)
>  		virtio_gpu_cmd_resource_create_blob(vgdev, bo, params,
>  						    ents, nents);
> -	} else if (params->virgl) {
> +	else if (params->virgl)
>  		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
>  						  objs, fence);
> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> -	} else {
> +	else
>  		virtio_gpu_cmd_create_resource(vgdev, bo, params,
>  					       objs, fence);
> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> -	}
> +
> +	if (!fence)
> +		dma_resv_unlock(bo->base.base.resv);
>  
>  	*bo_ptr = bo;
>  	return 0;
>  
> +err_unlock_objs:
> +	if (fence)
> +		virtio_gpu_array_unlock_resv(objs);
> +	else
> +		dma_resv_unlock(bo->base.base.resv);
>  err_put_objs:
>  	virtio_gpu_array_put_free(objs);
> -err_free_entry:
> -	kvfree(ents);
>  err_put_id:
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  err_put_pages:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
> index 5c514946bbad..6e4ef2593e8f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -464,8 +464,19 @@ static void virtio_gpu_install_out_fence_fd(struct virtio_gpu_submit *submit)
>  
>  static int virtio_gpu_lock_buflist(struct virtio_gpu_submit *submit)
>  {
> -	if (submit->buflist)
> -		return virtio_gpu_array_lock_resv(submit->buflist);
> +	int err;
> +
> +	if (submit->buflist) {
> +		err = virtio_gpu_array_lock_resv(submit->buflist);
> +		if (err)
> +			return err;
> +
> +		err = virtio_gpu_array_prepare(submit->vgdev, submit->buflist);
> +		if (err) {
> +			virtio_gpu_array_unlock_resv(submit->buflist);
> +			return err;
> +		}
> +	}
>  
>  	return 0;
>  }

