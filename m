Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355E80338E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjLDMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbjLDMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815D9C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:55:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD241C433C7;
        Mon,  4 Dec 2023 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701694555;
        bh=E172xqSuTiecKXdEivVTYrMjFWt5dLDiAGow27LdD2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IustftvYpmdSaMBywQAMFbz6l+FlSC42cBEOG+KQ0FPX4xT7N9tLlBna6+YLi7pN9
         FyDYk2E1X8alLz5fFpWek0gddb6neJx2mzYqE98+UQev+s5GFGk5QQ/NyTYDIX0EWr
         U+JP+Vuc5H8R/V56DD75WZQI+twLtcnrLtXk7hTKXmUo24uNOhYqtjRktw4Lh3ZqfK
         z884fiRR+snDvBHnXHF20qAPXOpyD7b/3PBQ9fwJkcIpvb1bx1mBbZcAdVoErkihq3
         v8oEI7GpbMctgtegAxA4ybA1bR5D5hREW7dvkmxZsGYuQgm0yhVPcgIAxXIO3gLVuR
         jG8rjr8PCg/TA==
Date:   Mon, 4 Dec 2023 13:55:52 +0100
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
Message-ID: <jvhedgegvavn5mvvx2men2rxitvnq7u3dsxwfx3wokxldmysjz@y5av3l2w4gk6>
References: <wboljiwogeus7pwgaqzxaltt3xdavy2dzisygn6pdpoiwlnwgc@mwaiukjguzat>
 <20231124115911.79ab24af@collabora.com>
 <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
 <20231128133712.53a6f6cb@collabora.com>
 <37208c72-7908-0a78-fc89-2fa9b8d756a5@collabora.com>
 <20231129085330.7ccb35d3@collabora.com>
 <ioqghyaeftyo7tuyfecn252ykxwgltrkhh2pwktjejqhewntbb@bym3rsjxnxfp>
 <20231129144609.7544e773@collabora.com>
 <6da6mzwfzwbn5rhiebypo5e2v6rhtpn2fovwvfnoo333zjgobf@bgtuwhum3trp>
 <20231129164705.7461a294@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iip2djagguw3jrrj"
Content-Disposition: inline
In-Reply-To: <20231129164705.7461a294@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iip2djagguw3jrrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:47:05PM +0100, Boris Brezillon wrote:
> On Wed, 29 Nov 2023 16:15:27 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > > Now, let's assume we drop the _locked() suffix on
> > > drm_gem_shmem_v[un]map(), but keep it on other helpers that need both
> > > variants. This results in an inconsistent naming scheme inside the
> > > same source file, which I find utterly confusing.
> > >
> > > Note that the initial reason I asked Dmitry if he could add the
> > > _locked suffix to drm_gem_shmem_vmap() is because I started using
> > > drm_gem_shmem_vmap() in powervr, before realizing this version wasn't
> > > taking the lock, and I should have used drm_gem_vmap_unlocked()
> > > instead, so this is not something I'm making up. =20
> >=20
> > Sorry if I gave you the impression I thought that you're making that up,
> > I'm not.
> >=20
> > Thanks for the explanation btw, I think I get what you're saying now:
> >=20
> >  - drm_gem_shmem_vmap() is never taking the locks because the core
> >    expects to take them before calling them.
> >=20
> >  - drm_gem_shmem_vunmap() is never taking the locks because the core
> >    expects to take them before calling them.
>=20
> Correct.
>=20
> >=20
> >  - Some other code path can still call those helpers in drivers, and the
> >    locking isn't handled by the core anymore.
>=20
> They can, if they want to v[un]map a BO and they already acquired the
> GEM resv lock. But I'm not sure anyone needs to do that yet. The main
> reason for exposing these helpers is if one driver needs to overload the
> default gem_shmem_funcs.
>=20
> >=20
> >  - We now have _vmap/vunmap_unlocked functions to take those locks for
> >    those code paths
>=20
> We don't have drm_gem_shmem_vmap/vunmap_unlocked(), we have
> drm_gem_shmem_vmap/vunmap_locked(), which can be called directly, but
> are mainly used to populate the drm_gem_object_funcs vtable. If drivers
> want to v[un]map in a path where the resv lock is not held, they should
> call drm_gem_vmap/vunmap_unlocked() (which are renamed
> drm_gem_vmap/vunmap() in patch 1 of this series). Mind the **drm_gem_**
> vs **drm_gem_shmem_** difference in the helper names. drm_gem_ helpers
> are provided by drm_gem.c and call drm_gem_object_funcs callback, which
> are supposed to be populated with drm_gem_shmem helpers.
>=20
> >=20
> >  - And the variant names are now confusing, making people use the
> >    lockless version in situations where they should have use the locked
> >    one.
>=20
> That's what happened to me, at least.
>=20
> >=20
> > Is that a correct summary?
>=20
> Almost ;-).
>=20
> >=20
> > If so, then I agree that we need to change the name.
>=20
> Cool.
>=20
> >=20
> > We discussed it some more on IRC, and we agree that the "default"
> > function should handle the locking properly and that's what the most
> > common case should use.
>=20
> Agree if by 'default' you mean the lock is always acquired by the
> helper, not 'let's decide based on what users do most of the time with
> this specific helper', because otherwise we'd be back to a situation
> where the name doesn't clearly encode the function behavior.
>=20
> >=20
> > So that means than drm_gem_shmem_vmap/vunmap() should take the lock
> > itself, and drm_gem_shmem_vmap/vunmap_nolock/unlocked never does.
>=20
> Not sure we have a need for drm_gem_shmem_vmap/vunmap(), but if we ever
> add such helpers, they would acquire the resv lock, indeed.
>=20
> Just to be clear, _nolock =3D=3D _locked in the current semantics :-).
> _nolock means 'don't take the lock', and _locked means 'lock is already
> held'.
>=20
> >=20
> > I think I'd prefer the nolock variant over unlocked still.
>=20
> Okay, that means s/_locked/_nolock/ in drm_gem_shmem_helpers.{c,h}, I
> guess.
>=20
> >=20
> > And I also think we can improve the documentation and add lockdep calls
>=20
> Lockdep asserts are already there, I think.
>=20
> > to make sure that the difference between variants is clear in the doc,
> > and if someone still get confused we can catch it.
> >=20
> > Does that sound like a plan?
>=20
> Assuming I understood it correctly, yes. Can you just confirm my
> understanding is correct though?

We are. Sorry for delaying this :)

Maxime

--iip2djagguw3jrrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW3MWAAKCRDj7w1vZxhR
xcDnAQDM/xef1l45sJfBEv38lDY/B8E+Cy/VtAD965YR2cJQzgD+NVB9BN2k4sks
4vrIzaUEwbhBb2UovWAde9a/Qmn6ggo=
=n1Mw
-----END PGP SIGNATURE-----

--iip2djagguw3jrrj--
