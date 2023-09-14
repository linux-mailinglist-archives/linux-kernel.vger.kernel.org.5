Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F679FDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjINIOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjINIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF261BF9;
        Thu, 14 Sep 2023 01:14:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AFCC433C8;
        Thu, 14 Sep 2023 08:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679264;
        bh=4jPpt1pf/9ex67WszErnzRElXHLpBUsazSupaDspZOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpgzMtpbFr0/Gg+9573PEBLdPbNlgCXV7v0ucfGGPipa6mb3ZBv4vImUF2cXJrDFt
         AckYY5AGo41B4Tm2MtOFWHqpAj10ZhDqmll9RJ9BSGE3Xu4CczjH1VP2Np11nNirSG
         7zDtlZHnkXO9mNJCRUMnB31g8IwCu3iDLdn2UT/mdGLHOPn36YYzgpHq0ctMvtOzxs
         SEdxFSoS90bht9DkFaM+Yb6N69Kur03PjasWzwpU1cxnYWli3FJ3gyY+dLDoozbArl
         LpK9bUqyg38t6mOj1rvnGLazdXr+mb4eAC+3B0R/EiYJF0rseVKyXncCxSwe/+EV4v
         GhpYk51YzmJlw==
Date:   Thu, 14 Sep 2023 10:14:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [RFT PATCH 03/15] drm/ingenic: Call drm_atomic_helper_shutdown()
 at shutdown time
Message-ID: <vkdjbjda23fwofsbt23wtjgiya3uhelby7evwtvteqkpwb4dr4@ybla63hqndic>
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
 <288af70dafc5e73d0fdfac71a33449385d4d6bd3.camel@crapouillou.net>
 <CAD=FV=VuJe7ACFw3pt1z=EAh14_Z4iTOc5VKJt24CGwZYjRpeQ@mail.gmail.com>
 <3prgpsxxnf3hzeqcpjs5r37nfojbkuwk4ezizrwfrcthm666k6@t2q2qcpnfkiu>
 <CAD=FV=VSTP2g1RttMu_9+AGQbMK87MzQO+tw1cZBEJ3g-jAmYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2du6jspwxvnyl5mc"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VSTP2g1RttMu_9+AGQbMK87MzQO+tw1cZBEJ3g-jAmYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2du6jspwxvnyl5mc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 13, 2023 at 09:23:29AM -0700, Doug Anderson wrote:
> On Wed, Sep 6, 2023 at 1:39=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> > On Tue, Sep 05, 2023 at 01:16:08PM -0700, Doug Anderson wrote:
> > > > > This commit is only compile-time tested.
> > > > >
> > > > > NOTE: this patch touches a lot more than other similar patches si=
nce
> > > > > the bind() function is long and we want to make sure that we unset
> > > > > the
> > > > > drvdata if bind() fails.
> > > > >
> > > > > While making this patch, I noticed that the bind() function of th=
is
> > > > > driver is using "devm" and thus assumes it doesn't need to do much
> > > > > explicit error handling. That's actually a bug. As per kernel docs
> > > > > [1]
> > > > > "the lifetime of the aggregate driver does not align with any of =
the
> > > > > underlying struct device instances. Therefore devm cannot be used=
 and
> > > > > all resources acquired or allocated in this callback must be
> > > > > explicitly released in the unbind callback". Fixing that is outsi=
de
> > > > > the scope of this commit.
> > > > >
> > > > > [1] https://docs.kernel.org/driver-api/component.html
> > > > >
> > > >
> > > > Noted, thanks.
> > >
> > > FWIW, I think that at least a few other DRM drivers handle this by
> > > doing some of their resource allocation / acquiring in the probe()
> > > function and then only doing things in the bind() that absolutely need
> > > to be in the bind. ;-)
> >
> > That doesn't change much. The fundamental issue is that the DRM device
> > sticks around until the last application that has an open fd to it
> > closes it.
> >
> > So it doesn't have any relationship with the unbind/remove timing, and
> > for all we know it can be there indefinitely, while the application
> > continues to interact with the driver.
>=20
> I spent some time thinking about similar issues recently and, assuming
> my understanding is correct, I'd at least partially disagree.
>=20
> Specifically, I _think_ the only thing that's truly required to remain
> valid until userspace closes the last open "fd" is the memory for the
> "struct drm_device" itself, right? My understanding is that this is
> similar to how "struct device" works. The memory backing a "struct
> device" has to live until the last client releases a reference to it
> even if everything else about a device has gone away. So if it was all
> working perfectly then if the Linux driver backing the "struct
> drm_device" goes away then we'd release resources and NULL out a bunch
> of stuff in the "struct drm_device" but still keep the actual "struct
> drm_device" around since userspace still has a reference. Pretty much
> all userspace calls would fail, but at least they wouldn't crash. Is
> that roughly the gist?

Yes, but also, no.

In the spirit, you're right. However, there's three things interfering
here:

  - You don't always have a match between device and KMS entity. Display
    pipelines are usually multiple devices working together, and while
    you probably have a 1:1 relationship with bridges and panels (and to
    some extent encoders/connectors), the planes and framebuffers for
    example are a mess :) So, if the device backing the planes is to be
    removed, what are you removing exactly? All of the planes and
    framebuffers? Do you free the buffers allocated by the userspace
    (that it might still use?)?

  - In addition to that, KMS doesn't deal with individual entities being
    hotplugged so neither the subsystem nor the application expect to
    have a connector being removed.

  - ioctl's aren't filtered once the device is starting to get removed
    on most drivers.

So due to 1 and 2, we can't really partially remove components unless
the application is aware of it, and it doesn't expect to. And most
drivers still allow (probably unwillingly though) the application to
call ioctls once the DRM device has lost at least one of its backing
devices.

> Assuming that's correct, then _most_ of the resource acquiring /
> memory allocation can still happen in the device probe() routine and
> can still use devm as long as we do something to ensure that any
> resources released are no longer pointed to by anything in the "struct
> drm_device".
>=20
> To make it concrete, I think we want this (feel free to correct). For
> simplicity, I'm assuming a driver that _doesn't_ use the component
> framework:
>=20
> a) Linux driver probe() happens. The "struct drm_device" is allocated
> in probe() by devm_drm_dev_alloc(). This takes a reference to the
> "struct drm_device". The device also acquires resources / allocates
> memory.

You need to differentiate resources and allocations there. Resources can
be expected to go away at the same time than the device, so using devm
is fine. Allocations are largely disconnected from the device lifetime,
and using devm leads to UAF.

> b) Userspace acquires a reference to the "struct drm_device". Refcount
> is now 2 (one from userspace, one from the Linux driver).
>=20
> c) The Linux driver unbinds, presumably because userspace requested
> it. From earlier I think we decided that we can't (by design) block
> unbind. Once unbind happens then we shouldn't try to keep operating
> the device

That part is correct, because the resources aren't there anymore.

> the driver should stop running.

But for the reasons above, the driver needs to still operate (in a
degraded mode).

> As part of the unbind, the remove() is called and also "devm"
> resources are deallocated. If any of the things freed are pointed to
> by the "struct drm_device" then the code needs to NULL them out at
> this time.

Right, we also need to make sure we don't access any of the resources
that got freed. This is typically done by protecting all the accesses
with drm_dev_enter/drm_dev_exit.

> Also we should make sure that any callback functions that userspace
> could cause to be invoked return errors.

That would prevent any new ioctl from occuring after the device has been
removed, but that doesn't fix the race condition if it's removed while
there's a commit happening. This is further complicated by the fact that
commits can be queued (so you would have multiple submitted already) or
made asynchronous.

> Our code could go away at any point here since userspace could "rmmod"
> our module.

Yeah, we probably have a bug there. Boris also reported something like
that recently where if you add an action with drmm_add_action, and then
remove the module, the function would have been free'd by the time it
executes.

> d) Eventually userspace releases the reference and the "struct
> drm_device" memory gets automatically freed because it was allocated
> by devm_drm_dev_alloc()

It was allocated by devm_drm_dev_alloc() but wasn't by devm_kzalloc().
devm_drm_dev_alloc() will "only" register an action to put back its
reference, but any application that opens the DRM device file will take
a reference as well (through drm_minor_acquire()).

So it's not freed at device_release_all() time, but when the last
reference is given back which could happen much later.

> NOTE: potentially some things could be allocated / managed by
> drmm_xyz() function, like drmm_kmalloc() and that could simplify some
> things.

The general rule is that any allocation needed for the framework
interactions need to be allocated by drmm, any allocation/resource
needed to operate the device need to be allocated by devm.

> However, it's not a panacea for everything. Specifically once
> the Linux driver unbind finishes then the device isn't functional
> anymore.

What's wrong with it then?

Maxime

--2du6jspwxvnyl5mc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQLA3gAKCRDj7w1vZxhR
xa+5AP9o4+vOzSZHs7vOSuXvf5IEzBcS2oaleKG3SymcHI67HAEAzjF3V+vvKqhN
XUuFtiWgTabwwQ7Scd8H60DV4lgQjwQ=
=FHBU
-----END PGP SIGNATURE-----

--2du6jspwxvnyl5mc--
