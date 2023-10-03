Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA497B6740
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjJCLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjJCLJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:09:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3159E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:09:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 145A0660731C;
        Tue,  3 Oct 2023 12:09:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696331353;
        bh=qhpiVcKFT7dJL847ee3DXa0YUpydpW7zhFpxmr/dhvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TjJcT+Rib1JV/7Xma8o6sD4s2oscHZ/L7vAOn13i19Xww2TebVBO5xr/eSOaCQE0d
         cKhVXSSQbb12hS1xji9dnKkyJFdreuXaN3s/yC22Ft3f3vLp3UYYL+Bb6B3ABtS9jL
         ecJo9hwxguDpLbAYOCUYZ25V+Li8dPsiiJnv1LknEOVPIFKCB6TTLytzn3oAh1PQ75
         vUf0guwuMClW/ZvrRXVSxITULBAzVBwJ/EQiwEycLKiMlGVczdQM8ko75IN94CWQS1
         lWMU+oCTZ9sP/iPhnqhuSHG+LtIwcCb/ecEgw7zoadfQ60/FwjJTN8JMffFlqFf99v
         07+WbsgjAEdkA==
Date:   Tue, 3 Oct 2023 13:09:09 +0200
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
Message-ID: <20231003130909.3b470a43@collabora.com>
In-Reply-To: <d93375df-215a-2325-ba6d-4616dfed0947@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
        <20230914232721.408581-14-dmitry.osipenko@collabora.com>
        <20230915104633.0d5c3932@collabora.com>
        <454c464e-4534-7ec3-6d38-49b7df83c7be@collabora.com>
        <20230926093517.11a172ad@collabora.com>
        <d93375df-215a-2325-ba6d-4616dfed0947@collabora.com>
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

On Mon, 2 Oct 2023 22:28:13 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 9/26/23 10:35, Boris Brezillon wrote:
> >> On 9/15/23 11:46, Boris Brezillon wrote:  
> >>> The naming becomes quite confusing, with drm_gem_shmem_unpin_locked()
> >>> and drm_gem_shmem_unpin_pages_locked(). By the look of it, it seems to
> >>> do exactly the opposite of drm_gem_shmem_swapin_locked(), except for
> >>> the missing ->evicted = true, which we can move here anyway, given
> >>> drm_gem_shmem_purge_locked() explicitly set it to false anyway. The
> >>> other thing that's missing is the
> >>> drm_gem_shmem_update_pages_state_locked(), but it can also be moved
> >>> there I think, if the the ->madv update happens before the
> >>> drm_gem_shmem_unpin_pages_locked() call in
> >>> drm_gem_shmem_purge_locked().
> >>>
> >>> So, how about renaming this function drm_gem_shmem_swapout_locked()?    
> >> The swapout name would be misleading to me because pages aren't moved to
> >> swap, but allowed to be moved. I'll rename it to
> >> drm_gem_shmem_shrinker_unpin_locked().  
> > If you go this way, I would argue that drm_gem_shmem_swapin_locked() is
> > just as incorrect as drm_gem_shmem_swapout_locked(), in that
> > drm_gem_get_pages() might just return pages that were flagged
> > reclaimable but never reclaimed/swapped-out. I do think that having
> > some symmetry in the naming makes more sense than being 100% accurate.  
> 
> That function is internal to drm-shmem and is used for both eviction and
> purging. Having "swap-out" invoked by the purging also doesn't sound good.

The part that discards the GEM in the shmem file is outside this
function (shmem_truncate_range()), so all this function does in practice
is flag the pages as evictable (or rather, clear the unevictable flag),
so they can be reclaimed. The swapout suggesting was mostly based on
the fact it does exactly the opposite of swapin().

> 
> Given that the function in question mainly "unmaps" the pages, what
> about drm_gem_shmem_shkinker_unmap_pages_locked()?

Unmap tends to refer to a VM related operation (removing a mapping in
the CPU or GPU VM), so it's confusing too IMHO. What we do here is
return pages to the shmem file logic, so they can be reclaimed.

Given the drm_gem function doing that is called drm_gem_put_pages(),
maybe rename it drm_gem_shmem_shrinker_put_pages_locked(), and rename
drm_gem_shmem_swapin_locked() into
drm_gem_shmem_shrinker_get_pages_locked(), to be consistent.

> 
> >>>>  {
> >>>>  	struct drm_gem_object *obj = &shmem->base;
> >>>>  	struct drm_device *dev = obj->dev;
> >>>>  
> >>>>  	dma_resv_assert_held(shmem->base.resv);
> >>>>  
> >>>> -	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
> >>>> +	if (shmem->evicted)
> >>>> +		return;
> >>>>  
> >>>>  	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);    
> >>> Are we sure we'll always have sgt != NULL? IIRC, if the GEM is only
> >>> mmap-ed in userspace, get_sgt() is not necessarily called by the driver
> >>> (needed to map in GPU space), and we have a potential NULL deref here.
> >>> Maybe that changed at some point in the series, and sgt is
> >>> unconditionally populated when get_pages() is called now.    
> >> The sgt is always set in this function because it's part of shrinker and
> >> shrinker doesn't touch GEMs without sgt.  
> > Okay, that's questionable. Why would we not want to reclaim BOs that
> > are only mapped in userspace (sgt == NULL && pages_use_count > 0 &&
> > pages_pin_count == 0)? I agree that creating such a BO would be
> > pointless (why create a buffer through DRM if it's not passed to the
> > GPU), but that's still something the API allows...  
> 
> This is a pre-existing behaviour. There is no driver that uses pages
> without sgt, hence there is nobody to test such code paths.
> 
> Maybe will worth to explicitly prohibit usage of get_pages() without
> having sgt for clarity.

Nope, I don't think we should. Panthor is dissociating the BO creation
for the GPU VM map operation, meaning we only get to ask for an sgt when
the BO is first mapped in GPU space. In the meantime, the shrinker logic
might decide to evict an object that has been already CPU-mapped (using
mmap()).

> But this should be separate to this patchset, IMO.

FYI, I'm not being picky just for fun, I do intend to use the
shmem-shrinker in panthor at some point, and I think it's important to
get it right from the beginning, even if all your existing users don't
care. I mean, I would understand if what I was asking was requiring
heavy changes to the existing logic, but, unless I'm wrong, I don't
think it does.
