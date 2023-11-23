Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393077F61EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbjKWOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjKWOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:48:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EFD71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:48:54 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C2B82660739B;
        Thu, 23 Nov 2023 14:48:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700750932;
        bh=TOxOSufmcOtURwsWljuFpDtQMmDKswF940eCd0/40e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GUBVz5eUSRzQhnr6IkWj+jo4rJm341qH1y3W881oKdKubsHsULT1YCS3ioMDZwpOk
         ssD5sNLakFDgu7dS5Tk0PaAgh/hMAMZSwynz1ccdNpYDxkC2mXV4ltmrpw0TxKcr0Y
         ejGZ8g02aLRVdDIGsom6njnd/GnR/GR8PtMIupQIRnWdEOcFWDnUw1bHWNO1rgY/d4
         0IgKTiFj8JKT43OsH+hoW3pIq1Vho62mmbtrbQQaHZhXeLB+saxCqR1swFBEa12Gtn
         4594UIN8+PPbXGQFijdjHu65/TC45og1ePfRGgUCaxv/Bih77MoQcIGiEm9ATQNTDG
         tUaj9so8WEU+Q==
Date:   Thu, 23 Nov 2023 15:48:48 +0100
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
Subject: Re: [PATCH v18 15/26] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20231123154848.034f4710@collabora.com>
In-Reply-To: <20231029230205.93277-16-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-16-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:54 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> To simplify the drm-shmem refcnt handling, we're moving away from
> the implicit get_pages() that is used by get_pages_sgt(). From now on
> drivers will have to pin pages while they use sgt. Panfrost's shrinker
> doesn't support swapping out BOs, hence pages are pinned and sgt is valid
> as long as pages' use-count > 0.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 17 +++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  6 ++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 6b77d8cebcb2..bb9d43cf7c3c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -47,8 +47,13 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>  			}
>  		}
>  		kvfree(bo->sgts);
> +
> +		drm_gem_shmem_put_pages(&bo->base);
>  	}
>  
> +	if (!bo->is_heap && !obj->import_attach)
> +		drm_gem_shmem_put_pages(&bo->base);
> +
>  	drm_gem_shmem_free(&bo->base);
>  }
>  
> @@ -269,6 +274,7 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	struct panfrost_gem_object *bo;
> +	int err;
>  
>  	/* Round up heap allocations to 2MB to keep fault handling simple */
>  	if (flags & PANFROST_BO_HEAP)
> @@ -282,7 +288,18 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
>  	bo->noexec = !!(flags & PANFROST_BO_NOEXEC);
>  	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
>  
> +	if (!bo->is_heap) {
> +		err = drm_gem_shmem_get_pages(shmem);

I really hate the fact we request pages here while we call
panfrost_mmu_map() in panfrost_gem_open(), because ultimately, pages
are requested for the MMU mapping. Also hate the quirk we have in shmem
to call free_pages() instead of put_pages_locked() when the BO refcount
dropped to zero, and I was hoping we could get rid of it at some point
by teaching drivers to request pages when they actually need it instead
of tying pages lifetime to the GEM object lifetime.

Maybe what we should do instead is move the get/put_pages() in
panfrost_mmu_map/unmap() (as I suggested), but have a special mapping
panfrost_mmu_evict/restore() helpers that kill/restore the MMU mappings
without releasing/acquiring the pages ref.
