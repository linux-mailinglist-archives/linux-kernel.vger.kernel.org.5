Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB457F5ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKWJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:08:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D63A110
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:08:35 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B73B86607377;
        Thu, 23 Nov 2023 09:08:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700730513;
        bh=BIHodNmsBiGjHqmmU2/SA/mIIzueNfft8YCTcpkLTgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cXWnvuH2n9K2VzAsDkgwZW6+wVffZIAgGJPyIyl4iY6CA5ZEZLHdwnS/E6UzU/ju/
         6sFmHXVuEb31W1jwWXksIzQLoYFfRv5f+C9VqCUvh4hHs/AZf7/YBEIZPEncVEN3uV
         AAUO/q2UlgCcyEGw8444Agt0CLXNfeSqHhLXgCSO1UjWM5WO8WlwOtE8198AbDX7p4
         Re1gN18WWsPBREhAUxkQsHRq0d6yA44PpLx6quYZ9Slpi6z8fMl8cD6NQXUptuRocp
         +2QKYnE3GWBCIfi+hn1a6kzP4jNGhfhuBftAnL+HXKzlQofFiGrSRQx2q11hHncSwp
         GR6eTwumf6icQ==
Date:   Thu, 23 Nov 2023 10:08:29 +0100
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
Message-ID: <20231123100829.2e4addd0@collabora.com>
In-Reply-To: <2faf1111-9646-21e3-feb3-f59c955bc719@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
        <20231029230205.93277-23-dmitry.osipenko@collabora.com>
        <20231113105438.60896fdf@collabora.com>
        <2faf1111-9646-21e3-feb3-f59c955bc719@collabora.com>
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

On Thu, 23 Nov 2023 01:30:24 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 11/13/23 12:54, Boris Brezillon wrote:
> > On Mon, 30 Oct 2023 02:02:01 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> Don't free refcounted shmem object to prevent use-after-free bug that
> >> is worse than a memory leak.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> index 6dd087f19ea3..4253c367dc07 100644
> >> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> @@ -203,9 +203,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> >>  	if (obj->import_attach)
> >>  		drm_prime_gem_destroy(obj, shmem->sgt);
> >>  
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> >> +	if (drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count)) ||
> >> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count)) ||
> >> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count)))
> >> +		return;  
> > 
> > I guess you're worried about ->sgt being referenced by the driver after
> > the GEM is destroyed. If we assume drivers don't cache the sgt and
> > always call get_pages_sgt() when they need it that shouldn't be an
> > issue. What we really don't want to release is the pages themselves,
> > but the GPU MMU might still have active mappings pointing to these
> > pages.
> > 
> > In any case, I'm not against leaking the GEM object when any of these
> > counters are not zero, but can we at least have a comment in the
> > code explaining why we're doing that, so people don't have to go look
> > at the git history to figure it out.  
> 
> This patch is a minor improvement, it doesn't address any specific
> issue. This should be a common pattern in kernel. If you're giving a
> warning and know about the inevitable catastrophe, then avoid it if you can.

Sure, I'm just asking that we add a comment to explain why we leak
memory here. Is that too much to ask?
