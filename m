Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D67E9969
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjKMJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjKMJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:50:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4110D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:50:02 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 599A966071C9;
        Mon, 13 Nov 2023 09:50:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699869001;
        bh=wCfkXVzFh9+4/eq4jvC4jcqKh2QCYCyEjmq0UU8BsDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZPUaFlPSKPp3o6zruu/QciXsc7IUJUUWsGdEFqHyBk79f3gt7ldiZCkGCTcQByFL
         URjfigZn911fDQha95PLuUss6T6/Nq6Xa9150A0aij5ByTPs4+LWV81CMmWU0pKdDN
         ub2bKS2aO6rbcVIlOedm1FilPSCI6wWT5q5AUiGSD9k6OOhl+C3HuLMsZKiKt/No7C
         2D3u/BqrowOvvKcxvDzyDx4nAIVz/YaEAHhlXosdQ2IYxlCsNpl+I0CBYFmnZ+nTiT
         Zf/gVe1drWYIyqbxIQXJBAaS/LrJL6Qiu4njP416DMYHN6h9C5laL8f+xy9uHeZDKs
         XC5cvNPCqPXpg==
Date:   Mon, 13 Nov 2023 10:49:56 +0100
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
Subject: Re: [PATCH v18 21/26] drm/shmem-helper: Optimize unlocked
 get_pages_sgt()
Message-ID: <20231113104956.2255269a@collabora.com>
In-Reply-To: <20231029230205.93277-22-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-22-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:02:00 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> SGT isn't refcounted. Once SGT pointer has been obtained, it remains the
> same for both locked and unlocked get_pages_sgt(). Return cached SGT
> directly without taking a potentially expensive lock.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 560ce565f376..6dd087f19ea3 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -955,6 +955,9 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>  	drm_WARN_ON(obj->dev, drm_gem_shmem_is_evictable(shmem));
>  	drm_WARN_ON(obj->dev, drm_gem_shmem_is_purgeable(shmem));
>  
> +	if (shmem->sgt)
> +		return shmem->sgt;
> +

By doing that, you introduce a race between drm_gem_shmem_put_pages()
and drm_gem_shmem_get_pages_sgt(). I know it's only happening if the
user doesn't follow the rule listed in drm_gem_shmem_get_pages_sgt() doc
(caller must owns a pages ref before calling
drm_gem_shmem_get_pages_sgt()), but now you return a possibly invalid
pointer instead of returning an error when this happens.
If that's what we want, we should at least update the documentation to
make it clear.

>  	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
>  	if (ret)
>  		return ERR_PTR(ret);

