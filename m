Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A747F7F9EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjK0Ldw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjK0Lds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:33:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71920101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:33:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2FA22F4;
        Mon, 27 Nov 2023 03:34:41 -0800 (PST)
Received: from [10.57.72.179] (unknown [10.57.72.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094993F73F;
        Mon, 27 Nov 2023 03:33:51 -0800 (PST)
Message-ID: <4a519708-6b5c-4947-b6ca-3fdd503392ed@arm.com>
Date:   Mon, 27 Nov 2023 11:33:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panfrost: Consider dma-buf imported objects as
 resident
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20231125205438.375407-1-adrian.larumbe@collabora.com>
 <20231125205438.375407-2-adrian.larumbe@collabora.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231125205438.375407-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 20:52, Adrián Larumbe wrote:
> A GEM object constructed from a dma-buf imported sgtable should be regarded
> as being memory resident, because the dma-buf API mandates backing storage
> to be allocated when attachment succeeds.

This obviously can cause a bit of double-counting system wide (both the
exporter and importer could show the memory usage). But I think we're
better off over-counting rather than under-counting.

Reviewed-by: Steven Price <steven.price@arm.com>

> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 9ccdac7aa822 ("drm/panfrost: Add fdinfo support for memory stats")
> Reported-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 0cf64456e29a..d47b40b82b0b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -200,7 +200,7 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
>  	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
>  	enum drm_gem_object_status res = 0;
>  
> -	if (bo->base.pages)
> +	if (bo->base.base.import_attach || bo->base.pages)
>  		res |= DRM_GEM_OBJECT_RESIDENT;
>  
>  	if (bo->base.madv == PANFROST_MADV_DONTNEED)

