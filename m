Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7047B78BF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjH2Hag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjH2HaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:30:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F740B5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:29:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1234966071EF;
        Tue, 29 Aug 2023 08:29:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693294194;
        bh=Ecrnw1IOFH3doPfE6+44e9yvuZAmYZFTAiUn0vXlg0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IECg13CjZ43Q9RAtlU/1MDOlh4f6fKzxlmtZKFa6vwn5PW5Enn1riu1/7d8sq8uZk
         3nq1tdc5hQXbEa5AiiGuJlD4u7GdBKzoKslSaLiYW5Td3TQr0kTLqRPwOKfo8fyoec
         5YcnF+L82WBVUnNOcpOLw7XlWuoNUrFD+A6SGWppcm2++KyzQbm3pzhl9UCjXf3hQN
         rO8RSMrWoJSUaLwccu/59ogl5r3+On1BiCt1mEerWirZCNpMiN8jArzVho0oWz2UlL
         YuRHukQTodOuvzthDIZqWymGszSIjxJsvu/QvPOChIZHEh5u4ES/kAv8h0KzLCM4GC
         vUIelZ1biepIw==
Date:   Tue, 29 Aug 2023 09:29:50 +0200
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
Subject: Re: [PATCH v15 17/23] drm/shmem-helper: Add and use
 drm_gem_shmem_resv_assert_held() helper
Message-ID: <20230829092950.3a9c40c1@collabora.com>
In-Reply-To: <01930e66-cba2-5d81-7f46-d46907bdd300@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
        <20230827175449.1766701-18-dmitry.osipenko@collabora.com>
        <20230828121239.78a180e6@collabora.com>
        <01930e66-cba2-5d81-7f46-d46907bdd300@collabora.com>
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

On Tue, 29 Aug 2023 05:34:23 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 8/28/23 13:12, Boris Brezillon wrote:
> > On Sun, 27 Aug 2023 20:54:43 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> In a preparation of adding drm-shmem memory shrinker, move all reservation
> >> locking lockdep checks to use new drm_gem_shmem_resv_assert_held() that
> >> will resolve spurious lockdep warning about wrong locking order vs
> >> fs_reclam code paths during freeing of shmem GEM, where lockdep isn't
> >> aware that it's impossible to have locking contention with the fs_reclam
> >> at this special time.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c | 37 +++++++++++++++++---------
> >>  1 file changed, 25 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> index d96fee3d6166..ca5da976aafa 100644
> >> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> @@ -128,6 +128,23 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
> >>  }
> >>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
> >>  
> >> +static void drm_gem_shmem_resv_assert_held(struct drm_gem_shmem_object *shmem)
> >> +{
> >> +	/*
> >> +	 * Destroying the object is a special case.. drm_gem_shmem_free()
> >> +	 * calls many things that WARN_ON if the obj lock is not held.  But
> >> +	 * acquiring the obj lock in drm_gem_shmem_free() can cause a locking
> >> +	 * order inversion between reservation_ww_class_mutex and fs_reclaim.
> >> +	 *
> >> +	 * This deadlock is not actually possible, because no one should
> >> +	 * be already holding the lock when drm_gem_shmem_free() is called.
> >> +	 * Unfortunately lockdep is not aware of this detail.  So when the
> >> +	 * refcount drops to zero, we pretend it is already locked.
> >> +	 */
> >> +	if (kref_read(&shmem->base.refcount))
> >> +		drm_gem_shmem_resv_assert_held(shmem);
> >> +}
> >> +
> >>  /**
> >>   * drm_gem_shmem_free - Free resources associated with a shmem GEM object
> >>   * @shmem: shmem GEM object to free
> >> @@ -142,8 +159,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> >>  	if (obj->import_attach) {
> >>  		drm_prime_gem_destroy(obj, shmem->sgt);
> >>  	} else if (!shmem->imported_sgt) {
> >> -		dma_resv_lock(shmem->base.resv, NULL);
> >> -
> >>  		drm_WARN_ON(obj->dev, kref_read(&shmem->vmap_use_count));
> >>  
> >>  		if (shmem->sgt) {
> >> @@ -156,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> >>  			drm_gem_shmem_put_pages_locked(shmem);  
> > 
> > AFAICT, drm_gem_shmem_put_pages_locked() is the only function that's
> > called in the free path and would complain about resv-lock not being
> > held. I think I'd feel more comfortable if we were adding a
> > drm_gem_shmem_free_pages() function that did everything
> > drm_gem_shmem_put_pages_locked() does except for the lock_held() check
> > and the refcount dec, and have it called here (and in
> > drm_gem_shmem_put_pages_locked()). This way we can keep using
> > dma_resv_assert_held() instead of having our own variant.  
> 
> It's not only drm_gem_shmem_free_pages(), but any drm-shmem function
> that drivers may use in the GEM's freeing callback.
> 
> For example, panfrost_gem_free_object() may unpin shmem BO and then do
> drm_gem_shmem_free().

Is this really a valid use case? If the GEM refcount dropped to zero,
we should certainly not have pages_pin_count > 0 (thinking of vmap-ed
buffers that might disappear while kernel still has a pointer to the
CPU-mapped area). The only reason we have this
drm_gem_shmem_put_pages_locked() in drm_gem_shmem_free() is because of
this implicit ref hold by the sgt, and IMHO, we should be stricter and
check that pages_use_count == 1 when sgt != NULL and pages_use_count ==
0 otherwise.

I actually think it's a good thing to try and catch any attempt to call
functions trying lock the resv in a path they're not supposed to. At
least we can decide whether these actions are valid or not in this
context, and provide dedicated helpers for the free path if they are.
