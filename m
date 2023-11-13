Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C307E9978
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjKMJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjKMJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:54:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E97510D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:54:43 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E5DB66071C9;
        Mon, 13 Nov 2023 09:54:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699869282;
        bh=9bDqGXVfCHUlHc3hp7s0FADRMoSPM6UPpCOfpTvFpJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e2nUsO5N4mioF5D9r3oXlR2JsjGkqpom9d2RaVinEXcVe1eS4jchoB4tvp/1/zhJm
         SxgoR/Ml0EK9e+jaGd7BU6CQq4MFvbdg5Uw2emYy3fqOMQJHk2GztiQ15rboQCvX4X
         bBAVkLFm0XEe611DKwX4Jc/CGmJuoTNybITKl2drTSkZf5fgiHaBbDLVyZulRES/m0
         QNRNUMGmpcPvp1WqhYl52AHwP2228zWuLvjaDSs0ND1GftAua1AEw2lxk+5cZolPOx
         Miq8/zNSNNAXxlb1ckIBi3PMW2syUksnIxwu6BDbuXMDrrpHxjhm21Brza5nlwbLvL
         RGXPxrky1YIGQ==
Date:   Mon, 13 Nov 2023 10:54:38 +0100
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
Subject: Re: [PATCH v18 22/26] drm/shmem-helper: Don't free refcounted GEM
Message-ID: <20231113105438.60896fdf@collabora.com>
In-Reply-To: <20231029230205.93277-23-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-23-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:02:01 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Don't free refcounted shmem object to prevent use-after-free bug that
> is worse than a memory leak.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 6dd087f19ea3..4253c367dc07 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -203,9 +203,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  	if (obj->import_attach)
>  		drm_prime_gem_destroy(obj, shmem->sgt);
>  
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> +	if (drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count)) ||
> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count)) ||
> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count)))
> +		return;

I guess you're worried about ->sgt being referenced by the driver after
the GEM is destroyed. If we assume drivers don't cache the sgt and
always call get_pages_sgt() when they need it that shouldn't be an
issue. What we really don't want to release is the pages themselves,
but the GPU MMU might still have active mappings pointing to these
pages.

In any case, I'm not against leaking the GEM object when any of these
counters are not zero, but can we at least have a comment in the
code explaining why we're doing that, so people don't have to go look
at the git history to figure it out.

>  
>  	drm_gem_object_release(obj);
>  	kfree(shmem);

