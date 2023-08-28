Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F35578AEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjH1LaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjH1L3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:29:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06080C7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:29:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33B7B6607181;
        Mon, 28 Aug 2023 12:29:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693222185;
        bh=c3kFI78Kqo10jaOCJEIYun+Psurv5NoeVd1SAAxjQ+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCQolNr/TCAggPx1k/DaL/QFMddFWnapIjx/iS+cLLqrbcf5IgNP/FUia0LsFnSRI
         mROY4Cnc1vIin6MKJNJpW5NO9H8yPldrleDCq8yydi2BTPux/Ptt44Uw7nToG+JLZG
         8U+qJcrDJ5uLLQZRuHtzUEIbxelhXQ8JXSIb+Q6P2KKokSF6mBQLt/EloXONIf6/RD
         w0UAPc1chc57PvHhrFAogAEy4RzYNP5K8Ong3y7MfkFx6dI6V6kHwzxRLrmBA2P3I5
         rx336VTe3xkKw+kelUEZvP8P6QIFl0AUM/rowVHy5ZV4+gnum+HTZVL50NEELARn1N
         avHvkBQOCbRJg==
Date:   Mon, 28 Aug 2023 13:29:42 +0200
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
Subject: Re: [PATCH v15 09/23] drm/shmem-helper: Remove obsoleted is_iomem
 test
Message-ID: <20230828132942.4f5f4f24@collabora.com>
In-Reply-To: <20230827175449.1766701-10-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
        <20230827175449.1766701-10-dmitry.osipenko@collabora.com>
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

On Sun, 27 Aug 2023 20:54:35 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Everything that uses the mapped buffer should by agnostic to is_iomem.

						^be

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
> index f053dc511508..d545d3d227d7 100644
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

