Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F17A1722
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjIOHS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjIOHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:18:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989EE0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:18:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82674660733F;
        Fri, 15 Sep 2023 08:18:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694762301;
        bh=xtkvug0J6qipef4H7k8twsG7RHvOTDB4NQhN9bH6eLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jWY7xzFzO5jwIXL4hrXYfzfQAdduHMs3LI5jgFXeFmsqBYJaU/OfPLqc09yjre3gK
         rKYqlAxWVtt6rfhkIxEsoUiIEYr7Ry6BjgSu4D/4ivNhwlvl5OEnLkxHAjLSnWPfV5
         yGYF2BV3Hd32XteT+5gyo3vjufFcs2rP9Y0Fdfr45kNVvuuL+wGo4TUcCcxIW6T5Nq
         SG2xLpE3HeXl2BBvkjYSrw0RTTN9mRLa+G4yvxKiJ0xocFPtBx2ZqeJE5H15uWcSF5
         m8uaojHf2y/nJChvaviwKzQkK+jhVKSMftmqUaGRnkEyrVi9eZNOdzCHvABrv8bTAh
         gqvENf9jx5xNg==
Date:   Fri, 15 Sep 2023 09:18:18 +0200
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
Subject: Re: [PATCH v17 11/18] drm/shmem-helper: Improve
 drm_gem_shmem_vmap_locked() error handling
Message-ID: <20230915091818.1dd3d6ed@collabora.com>
In-Reply-To: <20230914232721.408581-12-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
        <20230914232721.408581-12-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 02:27:14 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Remove error unwinding from drm_gem_shmem_vmap_locked() making error
> paths consistent for both dmabuf and non-dmabuf cases and improving
> readability of the code. Often it's preferred to do the explicit error
> unwinding, but this multi-path function is an exception.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>

Actually, I suggested returning directly, but I hadn't noticed the debug
message which you pointed in one of your replies. No longer sure it's a
good idea to drop the error path, since it makes code addition more
error-prone (pretty easy to forget the drm_gem_shmem_unpin_locked() in
new error paths).

> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index e1fcb5154209..8a8eab4d0332 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -334,7 +334,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  			      struct iosys_map *map)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
> -	int ret = 0;
> +	int ret;
>  
>  	if (obj->import_attach) {
>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
> @@ -357,6 +357,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
>  				    VM_MAP, prot);
>  		if (!shmem->vaddr) {
> +			drm_gem_shmem_unpin_locked(shmem);
>  			ret = -ENOMEM;
>  		} else {
>  			iosys_map_set_vaddr(map, shmem->vaddr);
> @@ -364,16 +365,8 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  		}
>  	}
>  
> -	if (ret) {
> +	if (ret)
>  		drm_dbg_kms(obj->dev, "Failed to vmap pages, error %d\n", ret);
> -		goto err_put_pages;
> -	}
> -
> -	return 0;
> -
> -err_put_pages:
> -	if (!obj->import_attach)
> -		drm_gem_shmem_unpin_locked(shmem);
>  
>  	return ret;
>  }

