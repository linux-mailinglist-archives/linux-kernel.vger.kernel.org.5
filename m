Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CFF792A62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIEQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353696AbjIEHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:20:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990912A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:20:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A4F06606FC2;
        Tue,  5 Sep 2023 08:20:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693898432;
        bh=ViufKsNlWWk8KZTSfvqYHZ2OvbkMoj8nCUrSGDydXGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iH1ci9YojMcECNCDV3YsRmvOsabpbJ/198VEJ0SKr8qECVVrARyidjb8o58WJlFCV
         zKY9RLbyK8fMvziaUdfgzucn5WqxCqiUv9ykxGtQfVRsYhirlebqBgZHFfctaV6wZU
         p99ux1ZyebZ5LKLomfBWKrRBv7lHT7NalpAO0aPHrLSpvLcufesvqXvFpoShQHRb0f
         TXS6ntWMaCBltqPAVHBFHgW42trvJ/d0VrKaSz25znWRBhiLwQjmsCornj6LkhjAJA
         2r2t8o/ztoVTpzn4fFjfo/nSzSnT0A+vblHrA6gJ3A1I2akaIef7Eu0fN0roPwxhN7
         ZtzxENeDvHKqQ==
Date:   Tue, 5 Sep 2023 09:20:28 +0200
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
Subject: Re: [PATCH v16 06/20] drm/virtio: Replace drm_gem_shmem_free() with
 drm_gem_object_put()
Message-ID: <20230905092028.182f8ed8@collabora.com>
In-Reply-To: <20230903170736.513347-7-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-7-dmitry.osipenko@collabora.com>
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

On Sun,  3 Sep 2023 20:07:22 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Prepare virtio_gpu_object_create() to addition of memory shrinker support
> by replacing open-coded drm_gem_shmem_free() with drm_gem_object_put() that
> decrements GEM refcount to 0, which becomes important for drm-shmem because
> it will start to use GEM's refcount during the shmem's BO freeing time in
> order to prevent spurious lockdep warning about resv lock ordering vs
> fs_reclaim code paths.

I think I'm okay with the change (assuming virtio_gpu_free_object()
can deal with partially initialized objects), not with the explanation
:-). I don't really see why we need to take the resv lock in
drm_gem_shmem_free(). As said in my v15 review, I think we should
replace the drm_gem_shmem_put_pages() call we have in
drm_gem_shmem_free() by a call to a new drm_gem_shmem_free_pages()
helper that does exactly what drm_gem_shmem_put_pages() does without
the refcounting/locking, because all that should remain at the time
drm_gem_shmem_free() is called is the implicit pages ref owned by
shmem->sgt, and there's no risk of other threads accessing the GEM
object at that point.

> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index c7e74cf13022..343b13428125 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -244,6 +244,6 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  err_put_id:
>  	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  err_free_gem:
> -	drm_gem_shmem_free(shmem_obj);
> +	drm_gem_object_put(&bo->base.base);
>  	return ret;
>  }

