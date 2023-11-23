Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78F17F5AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKWJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjKWJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:06:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056ECD69
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:06:04 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A0129660738E;
        Thu, 23 Nov 2023 09:06:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700730362;
        bh=jXx0AZxK0x/3x229o8gedk/6QPlybYeQFVHL/LcCTj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSp86ftyTaaRQ1uCyPN0eOAAmXLdLz+oOdzcxBeABdqLPtswej1z5nVQj2WLuVB35
         2yuuRJUU8TjK4IAowsJVj2LRWBngf1dLfc2U4SqkoiJPIbp2DlnFz6jGMVG/dZMHaQ
         z12bNmCYM65GsdnU3hGAsEtkmQCQBr73UD/NOJ+lXOXuUVi60Y5UkVAiidyhKdWXrt
         TnUMkoloHlHX663vqHVpzOiLGL0AWM7Z4QcDg5xJp15giD05mAlqAPC/dpF4zvnhBo
         b9TS12tqrFhXs/iHkIPO8jLsAPW6hAslJdiwi9F77GDI3Ws7aCmbvN0XNu0oUmDf16
         /5Pey2NHXtIwA==
Date:   Thu, 23 Nov 2023 10:05:57 +0100
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
Message-ID: <20231123100557.05a49343@collabora.com>
In-Reply-To: <26890ba7-5e19-df0c-fce0-26af58e66266@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-16-dmitry.osipenko@collabora.com>
        <20231110115354.356c87f7@collabora.com>
        <26890ba7-5e19-df0c-fce0-26af58e66266@collabora.com>
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

On Thu, 23 Nov 2023 01:04:56 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 11/10/23 13:53, Boris Brezillon wrote:
> > Hm, there was no drm_gem_shmem_get_pages_sgt() call here, why should we
> > add a drm_gem_shmem_get_pages()? What we should do instead is add a
> > drm_gem_shmem_get_pages() for each drm_gem_shmem_get_pages_sgt() we
> > have in the driver (in panfrost_mmu_map()), and add
> > drm_gem_shmem_put_pages() calls where they are missing
> > (panfrost_mmu_unmap()).
> >   
> >> +		if (err)
> >> +			goto err_free;
> >> +	}
> >> +
> >>  	return bo;
> >> +
> >> +err_free:
> >> +	drm_gem_shmem_free(&bo->base);
> >> +
> >> +	return ERR_PTR(err);
> >>  }
> >>  
> >>  struct drm_gem_object *
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >> index 770dab1942c2..ac145a98377b 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >> @@ -504,7 +504,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> >>  		if (IS_ERR(pages[i])) {
> >>  			ret = PTR_ERR(pages[i]);
> >>  			pages[i] = NULL;
> >> -			goto err_pages;
> >> +			goto err_unlock;
> >>  		}
> >>  	}
> >>  
> >> @@ -512,7 +512,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> >>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
> >>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
> >>  	if (ret)
> >> -		goto err_pages;
> >> +		goto err_unlock;  
> > Feels like the panfrost_gem_mapping object should hold a ref on the BO
> > pages, not the BO itself, because, ultimately, the user of the BO is
> > the GPU. This matches what I was saying about moving get/put_pages() to
> > panfrost_mmu_map/unmap(): everytime a panfrost_gem_mapping becomes
> > active, to want to take a pages ref, every time it becomes inactive,
> > you should release the pages ref.  
> 
> The panfrost_mmu_unmap() is also used by shrinker when BO is purged. I'm
> unhappy with how icky it all becomes if unmap is made to put pages.

Why, that's exactly what's supposed to happen. If you mmu_unmap(), that
means you no longer need the pages ref you got.

> 
> Previously map() was implicitly allocating pages with get_sgt() and then
> pages were implicitly released by drm_gem_shmem_free(). A non-heap BO is
> mapped when it's created by Panfrost, hence the actual lifetime of pages
> is kept unchanged by this patch.

But the whole point of making it explicit is to control when pages are
needed or not, isn't it. The fact we mmu_map() the BO at open time, and
keep it mapped until it's not longer referenced is an implementation
choice, and I don't think having pages_put() in mmu_unmap() changes
that.

> The implicit allocation is turned into
> explicit one, i.e. pages are explicitly allocated before BO is mapped.
> 

