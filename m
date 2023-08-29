Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82678C1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjH2Jov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjH2JoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:44:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E36E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:44:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6DF786607214;
        Tue, 29 Aug 2023 10:44:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693302257;
        bh=Z94pAeCLfwRuWm2Tvr2fBDlolGZR8Vfz+wCcKDz3J48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=knmEgmJMXHvOrSkcpBXuxz19tU/R8ZtRLNvLeXGDO5ZgXFoBCTUPMJAhWSuii4t5/
         gJpxlzO/uIZeM1+Kl0RynstVZP2jLdzJzLxWrEV9Pz6kkP2lyW6bm/YqeilrLyUleR
         JUy4cY9g0wsEmvnwG66qcR+edlWwoYYjwi1BZr+5pDoX/Bhu9ogns+pfc6wn6w7Ei/
         a4BA4aszsN+yNpLUWdHgce32o3vc8HrPrzPNxkWBmywfF1UR3HAlknYP5TS6/jf77H
         sBjBPgM8XEPYPKo8pmvU0BvsezmC23LBv6KRVIf18Hd4rrU/lM4xLnT0Ganem0odFW
         vusr7l4Skn/GQ==
Date:   Tue, 29 Aug 2023 11:44:13 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
Message-ID: <20230829114413.7adc9709@collabora.com>
In-Reply-To: <0ff9b35a-3a44-6221-3017-e9efab2d33f2@amd.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
        <20230827175449.1766701-18-dmitry.osipenko@collabora.com>
        <20230828121239.78a180e6@collabora.com>
        <01930e66-cba2-5d81-7f46-d46907bdd300@collabora.com>
        <20230829092950.3a9c40c1@collabora.com>
        <0ff9b35a-3a44-6221-3017-e9efab2d33f2@amd.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 10:52:03 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 29.08.23 um 09:29 schrieb Boris Brezillon:
> > On Tue, 29 Aug 2023 05:34:23 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> > =20
> >> On 8/28/23 13:12, Boris Brezillon wrote: =20
> >>> On Sun, 27 Aug 2023 20:54:43 +0300
> >>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >>>     =20
> >>>> In a preparation of adding drm-shmem memory shrinker, move all reser=
vation
> >>>> locking lockdep checks to use new drm_gem_shmem_resv_assert_held() t=
hat
> >>>> will resolve spurious lockdep warning about wrong locking order vs
> >>>> fs_reclam code paths during freeing of shmem GEM, where lockdep isn't
> >>>> aware that it's impossible to have locking contention with the fs_re=
clam
> >>>> at this special time.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>> ---
> >>>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 37 +++++++++++++++++-----=
----
> >>>>   1 file changed, 25 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/dr=
m/drm_gem_shmem_helper.c
> >>>> index d96fee3d6166..ca5da976aafa 100644
> >>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>>> @@ -128,6 +128,23 @@ struct drm_gem_shmem_object *drm_gem_shmem_crea=
te(struct drm_device *dev, size_t
> >>>>   }
> >>>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
> >>>>  =20
> >>>> +static void drm_gem_shmem_resv_assert_held(struct drm_gem_shmem_obj=
ect *shmem)
> >>>> +{
> >>>> +	/*
> >>>> +	 * Destroying the object is a special case.. drm_gem_shmem_free()
> >>>> +	 * calls many things that WARN_ON if the obj lock is not held.  But
> >>>> +	 * acquiring the obj lock in drm_gem_shmem_free() can cause a lock=
ing
> >>>> +	 * order inversion between reservation_ww_class_mutex and fs_recla=
im.
> >>>> +	 *
> >>>> +	 * This deadlock is not actually possible, because no one should
> >>>> +	 * be already holding the lock when drm_gem_shmem_free() is called.
> >>>> +	 * Unfortunately lockdep is not aware of this detail.  So when the
> >>>> +	 * refcount drops to zero, we pretend it is already locked.
> >>>> +	 */
> >>>> +	if (kref_read(&shmem->base.refcount))
> >>>> +		drm_gem_shmem_resv_assert_held(shmem);
> >>>> +}
> >>>> +
> >>>>   /**
> >>>>    * drm_gem_shmem_free - Free resources associated with a shmem GEM=
 object
> >>>>    * @shmem: shmem GEM object to free
> >>>> @@ -142,8 +159,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_obj=
ect *shmem)
> >>>>   	if (obj->import_attach) {
> >>>>   		drm_prime_gem_destroy(obj, shmem->sgt);
> >>>>   	} else if (!shmem->imported_sgt) {
> >>>> -		dma_resv_lock(shmem->base.resv, NULL);
> >>>> -
> >>>>   		drm_WARN_ON(obj->dev, kref_read(&shmem->vmap_use_count));
> >>>>  =20
> >>>>   		if (shmem->sgt) {
> >>>> @@ -156,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_obj=
ect *shmem)
> >>>>   			drm_gem_shmem_put_pages_locked(shmem); =20
> >>> AFAICT, drm_gem_shmem_put_pages_locked() is the only function that's
> >>> called in the free path and would complain about resv-lock not being
> >>> held. I think I'd feel more comfortable if we were adding a
> >>> drm_gem_shmem_free_pages() function that did everything
> >>> drm_gem_shmem_put_pages_locked() does except for the lock_held() check
> >>> and the refcount dec, and have it called here (and in
> >>> drm_gem_shmem_put_pages_locked()). This way we can keep using
> >>> dma_resv_assert_held() instead of having our own variant. =20
> >> It's not only drm_gem_shmem_free_pages(), but any drm-shmem function
> >> that drivers may use in the GEM's freeing callback.
> >>
> >> For example, panfrost_gem_free_object() may unpin shmem BO and then do
> >> drm_gem_shmem_free(). =20
> > Is this really a valid use case? =20
>=20
> I haven't followed the whole discussion, but I think it isn't a valid=20
> use case.
>=20
> That page_use_count is none zero while the GEM object is about to be=20
> destroyed can only happen is someone managed to grab a reference to the=20
> page without referencing the GEM object.

Actually, drm_gem_shmem_object is a bit special (weird?) in this regard.
drm_gem_shmem_get_pages_sgt_locked() creates the sgt and takes a
pages ref (pages_use_count++). The sgt itself is cached (next call to
drm_gem_shmem_get_pages_sgt_locked() will return the existing sgt) but
not refcounted, which means it will stay around until the GEM object is
destroyed or its pages are purged (GEM eviction). Because of that,
shmem->pages_use_count =3D=3D 1 in drm_gem_shmem_free_pages() is valid iff
shmem->sgt !=3D NULL. pages_use_count > 1 is invalid though, as should be
pages_pin_count after Dmitry's patches.

If we want to 'fix' that (not convinced this is a bug, more a design
choice), we need to refcount the sgt users and add
drm_gem_shmem_put_pages_sgt[_locked](), so drivers can reflect when
they're done using the sgt.
