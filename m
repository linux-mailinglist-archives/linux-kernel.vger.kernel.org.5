Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A505B7AE70C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjIZHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIZHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:43:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141D92
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:43:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 356786607314;
        Tue, 26 Sep 2023 08:43:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695714190;
        bh=yxiZWpVqxhEON5vsUHcs14H1MKuPG2laNGhIxvUFUj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X++0iks2Sjt4BtU3DuUWiNtZAp7n9eU5yx8gJaKnwb4In5KbopYEZE0UKDSqPsF5+
         YhDie/npt0KcwKy8kcnAd4Bf7x/NT9Z8znqAZkl3mZlRRagGY+1QzDgwU8f15BvPnH
         CfbCB2Lstrng2Yg99mmdwvgjyh75mVkABdUNTE4+mG0oxoJpbbfPOhCkhYN4qoa3Qu
         IxJZ2YfRaAlApG7JPkaxHzPRAObFUjQ2s7aJ3vnbuD2U4J2wbmpBpD1YH0e0GJJqFc
         yLiwrg7p+77hHL2+ojmv/D1gRdB1P9+iyj+/TfPgC2C9kKTk6GDUurw3Dh+eZehSlZ
         axodwmk8Yezcw==
Date:   Tue, 26 Sep 2023 09:43:07 +0200
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
Subject: Re: [PATCH v17 13/18] drm/shmem-helper: Add memory shrinker
Message-ID: <20230926094307.506f4b93@collabora.com>
In-Reply-To: <64e8708a-bb73-96ae-90af-f7b51317613b@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
        <20230914232721.408581-14-dmitry.osipenko@collabora.com>
        <20230915104633.0d5c3932@collabora.com>
        <64e8708a-bb73-96ae-90af-f7b51317613b@collabora.com>
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

On Tue, 26 Sep 2023 03:37:22 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 9/15/23 11:46, Boris Brezillon wrote:
> >> -static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
> >> +static int
> >> +drm_gem_shmem_acquire_pages(struct drm_gem_shmem_object *shmem, bool init)
> >>  {
> >>  	struct drm_gem_object *obj = &shmem->base;
> >>  	struct page **pages;
> >>  
> >>  	dma_resv_assert_held(shmem->base.resv);
> >>  
> >> -	if (refcount_inc_not_zero(&shmem->pages_use_count))
> >> +	if (shmem->madv < 0) {
> >> +		drm_WARN_ON(obj->dev, shmem->pages);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	if (shmem->pages) {
> >> +		drm_WARN_ON(obj->dev, !shmem->evicted);
> >>  		return 0;
> >> +	}
> >> +
> >> +	if (drm_WARN_ON(obj->dev, !(init ^ refcount_read(&shmem->pages_use_count))))
> >> +		return -EINVAL;  
> > OOC, why do we care? Is there any difference between initial and re-pin
> > that make the page allocation impossible? Feels like, if there's a
> > check to do, it should be done in the caller instead, and you can drop
> > the init param here.  
> 
> This is a sanity check that addresses additional refcnt tracking
> complexity imposed by shrinker.
> 
> This function is used by both init and re-pin that is invoked from
> several places in the code. It's not trivial to move that check to the
> callers.

drm_gem_shmem_acquire_pages() is called twice, once with init=false,
once with init=true. If you really care about this check, it can
be moved to the callers so

1/ it's clearer (the XOR operation between init and refcount to check if
refcount is zero on init and non-zero otherwise is convoluted)
2/ it doesn't leak to the function whose purpose it to [re-]acquire
pages

