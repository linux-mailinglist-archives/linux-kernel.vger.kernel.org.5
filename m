Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65847792B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjIEQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353568AbjIEGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:46:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD11B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:46:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FCA066071F8;
        Tue,  5 Sep 2023 07:46:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693896375;
        bh=fJwED56Qhvdtu7z0U1GYzrQoI1Muoc82RDmLEyljqjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZAsFguPp1mjXFmpDkEjgRUcqUn0ljQnWscxYzfYdVQ6kQftwcTJa91FbapIu0cyd
         oyqedwBX2aQVqNp5NxRUICwrxb/teG59KFDf5oPkal570CGMVGazRwjII3fmFN9pgY
         Ywp+H2K3jn8bQJgCyZ+LK4sihYpKLuwQz0lOr3S2PNO6cuJSsSZgZTIWpszWdSCl/8
         BM6n6jVdOPbkNbL/OjUN+5u5C7SYHJoRYHaRMc4K8j4hAnLQiPuwcrxGdMndaFHQvd
         no1riSKkgmgEsY5M+TD2pbUqFR4OJcOSaMAUNA6jjlq2sjlz6ZCs6VKaFCiLjIBwN9
         RxHmyLLq7Ej4Q==
Date:   Tue, 5 Sep 2023 08:46:11 +0200
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
Subject: Re: [PATCH v16 09/20] drm/shmem-helper: Remove obsoleted is_iomem
 test
Message-ID: <20230905084611.6a404ff1@collabora.com>
In-Reply-To: <20230903170736.513347-10-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
        <20230903170736.513347-10-dmitry.osipenko@collabora.com>
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

On Sun,  3 Sep 2023 20:07:25 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Everything that uses the mapped buffer should be agnostic to is_iomem.
> The only reason for the is_iomem test is that we're setting shmem->vaddr
> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
> the obsoleted is_iomem test to clean up the code.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 2b50d1a7f718..25e99468ced2 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -317,12 +317,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  
>  	if (obj->import_attach) {
>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
> -		if (!ret) {
> -			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
> -				dma_buf_vunmap(obj->import_attach->dmabuf, map);
> -				return -EIO;
> -			}
> -		}

Given there's nothing to unroll for the dmabuf case, I think it'd be
good to return directly and skip all the error paths. It would also
allow you to get rid of one indentation level for the !dmabuf path.

	if (obj->import_attach)
		return dma_buf_vmap(obj->import_attach->dmabuf, map);

	// non-dmabuf vmap logic here...



>  	} else {
>  		pgprot_t prot = PAGE_KERNEL;
>  

