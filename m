Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADB7FB929
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjK1LOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjK1LOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D7D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:14:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CABC433C7;
        Tue, 28 Nov 2023 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170084;
        bh=ghXHN0aqKTTETA6By+7Mc0o8Xy5WxEMUZIlYt+T2S2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMsIKIwU5rCX0ZEd0AknFuQtsCuGZOd+UAdrNrElQLX+FzsvWwmnGzu/13zFTjv8S
         1sEGdUq+2Bh4u+xNBIkrOOA8OSDB/8dEVr+Q56+9wc6pXUozr4s9v+fIFf75ETOlF8
         XzZ2CFbTXGZyPhcJTLNeLIW2fjYac22oBY/+Br5aBCc6IHjl+TkO83cOKk+1da8jxN
         kcv0PqsiaEZGa6Py7G5TSKYyFsk91CQK+QFXFSva2vpwwhI8R7/GtaB6DiMrQG0oCq
         vpfDbnOoEWH7qtaUuEpPX6SypVnAweYMwsC1Zn+ukA5U3TbtvvX/W9MFchbO8JwdGt
         XHotEI5pg4ayg==
Date:   Tue, 28 Nov 2023 12:14:42 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-5-dmitry.osipenko@collabora.com>
 <wboljiwogeus7pwgaqzxaltt3xdavy2dzisygn6pdpoiwlnwgc@mwaiukjguzat>
 <20231124115911.79ab24af@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4o4oj77z6epqtcan"
Content-Disposition: inline
In-Reply-To: <20231124115911.79ab24af@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4o4oj77z6epqtcan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 24, 2023 at 11:59:11AM +0100, Boris Brezillon wrote:
> On Fri, 24 Nov 2023 11:40:06 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Mon, Oct 30, 2023 at 02:01:43AM +0300, Dmitry Osipenko wrote:
> > > Add locked and remove unlocked postfixes from drm-shmem function name=
s,
> > > making names consistent with the drm/gem core code.
> > >=20
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> =20
> >=20
> > This contradicts my earlier ack on a patch but...
> >=20
> > > ---
> > >  drivers/gpu/drm/drm_gem_shmem_helper.c        | 64 +++++++++--------=
--
> > >  drivers/gpu/drm/lima/lima_gem.c               |  8 +--
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c       |  2 +-
> > >  drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
> > >  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
> > >  drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
> > >  drivers/gpu/drm/v3d/v3d_bo.c                  |  4 +-
> > >  drivers/gpu/drm/virtio/virtgpu_object.c       |  4 +-
> > >  include/drm/drm_gem_shmem_helper.h            | 36 +++++------
> > >  9 files changed, 64 insertions(+), 64 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm=
/drm_gem_shmem_helper.c
> > > index 0d61f2b3e213..154585ddae08 100644
> > > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > @@ -43,8 +43,8 @@ static const struct drm_gem_object_funcs drm_gem_sh=
mem_funcs =3D {
> > >  	.pin =3D drm_gem_shmem_object_pin,
> > >  	.unpin =3D drm_gem_shmem_object_unpin,
> > >  	.get_sg_table =3D drm_gem_shmem_object_get_sg_table,
> > > -	.vmap =3D drm_gem_shmem_object_vmap,
> > > -	.vunmap =3D drm_gem_shmem_object_vunmap,
> > > +	.vmap =3D drm_gem_shmem_object_vmap_locked,
> > > +	.vunmap =3D drm_gem_shmem_object_vunmap_locked, =20
> >=20
> > While I think we should indeed be consistent with the names, I would
> > also expect helpers to get the locking right by default.
>=20
> Wait, actually I think this patch does what you suggest already. The
> _locked() prefix tells the caller: "you should take care of the locking,
> I expect the lock to be held when this is hook/function is called". So
> helpers without the _locked() prefix take care of the locking (which I
> guess matches your 'helpers get the locking right' expectation), and
> those with the _locked() prefix don't.

What I meant by "getting the locking right" is indeed a bit ambiguous,
sorry. What I'm trying to say I guess is that, in this particular case,
I don't think you can expect the vmap implementation to be called with
or without the locks held. The doc for that function will say that it's
either one or the other, but not both.

So helpers should follow what is needed to provide a default vmap/vunmap
implementation, including what locking is expected from a vmap/vunmap
implementation.

If that means that vmap is always called with the locks taken, then
drm_gem_shmem_object_vmap can just assume that it will be called with
the locks taken and there's no need to mention it in the name (and you
can probably sprinkle a couple of lockdep assertion to make sure the
locking is indeed consistent).

> > I'm not sure how reasonable it is, but I think I'd prefer to turn this
> > around and keep the drm_gem_shmem_object_vmap/unmap helpers name, and
> > convert whatever function needs to be converted to the unlock suffix so
> > we get a consistent naming.
>=20
> That would be an _unlocked() prefix if we do it the other way around. I
> think the main confusion comes from the names of the hooks in
> drm_gem_shmem_funcs. Some of them, like drm_gem_shmem_funcs::v[un]map()
> are called with the GEM resv lock held, and locking is handled by the
> core, others, like drm_gem_shmem_funcs::[un]pin() are called
> without the GEM resv lock held, and locking is deferred to the
> implementation. As I said, I don't mind prefixing hooks/helpers with
> _unlocked() for those that take care of the locking, and no prefix for
> those that expects locks to be held, as long as it's consistent, but I
> just wanted to make sure we're on the same page :-).

What about _nolock then? It's the same number of characters than
_locked, plus it expresses what the function is (not) doing, not what
context it's supposed to be called in?

Maxime

--4o4oj77z6epqtcan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWXLogAKCRDj7w1vZxhR
xdPLAP0bk4jcd19Kcw1HVEeKM+/ZsKBusXZ3qgtT2fHoMh5QUQEAsOV0Jvb2c6uk
6hLo3uAZKWG2e93N+kwfw1XjMKiwpQA=
=DFKK
-----END PGP SIGNATURE-----

--4o4oj77z6epqtcan--
