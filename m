Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D787E8031
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjKJSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjKJSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E182704C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:08:33 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D67ED66073F9;
        Fri, 10 Nov 2023 10:08:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699610911;
        bh=KCYQjuvBuxZp544n/rzQNo2zbiK+/sDsQ1UcXNqg44c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ga1uUKYEYCxW4M5uvTyMJDuwJVeGOEZ1DEQ98wI3oCLBEWy3cc8/mOKBCocZ5CuU+
         +HNrw2nmDv1I60Kk7dZyOe1V60UfJx9TBu6TNhuh9jiC3cJ+Vcx+ThSpwkTq4poeUm
         bj2JyogkeSVigN7Vyo35bL/Hi7djIgpLxgb6qWKPSnKITT4JeODZHplMr+aaFgQu0H
         fsRTMlw5xC/jRBFTf9wF973yBzyhu0KrRXGjqPwb9Mu/dwdw28fKvxLLuABomhEoBt
         fZtrxS16lXVRU3nK41IxD/cAYZg1hWSsaTZ2T/NzHAkBjSztxBR6qIRBnfNIwsY4Um
         VVtL/U+4IFMwQ==
Date:   Fri, 10 Nov 2023 11:08:27 +0100
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
Subject: Re: [PATCH v18 05/26] drm/shmem-helper: Remove obsoleted is_iomem
 test
Message-ID: <20231110110827.403bdbeb@collabora.com>
In-Reply-To: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-6-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:44 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Everything that uses the mapped buffer should be agnostic to is_iomem.
> The only reason for the is_iomem test is that we're setting shmem->vaddr
> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
> the obsoleted is_iomem test to clean up the code.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 154585ddae08..2cc0601865f6 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -315,12 +315,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  
>  	if (obj->import_attach) {
>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
> -		if (!ret) {
> -			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
> -				dma_buf_vunmap(obj->import_attach->dmabuf, map);
> -				return -EIO;
> -			}
> -		}
>  	} else {
>  		pgprot_t prot = PAGE_KERNEL;
>  

