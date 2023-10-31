Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6D7DCC29
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjJaLxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaLxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:53:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B15F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:53:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF4C433C8;
        Tue, 31 Oct 2023 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698753218;
        bh=fhz4BlNKDs1Y3KPQ7jbsa9UfJMLlXuJSp17uDXC/zVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZYpt5ZvmuRzekL67l2I+szXm8umHGLhqGyT2ib9Gsx3u8kLhac/DOUrppujkUWYm
         aqfn5R97k60wk2YhVPlzHLtVrA0gtgj4r86/vW1oxqD4mwjOXvYGiKpiNNLZ3wqmYQ
         GVzszGfNlL4eRDp8gPq010y1m3DmV8iUj0GBl+qyxtBAiLXtO7wEw1fuG3P321WoXK
         3VM2n9s7OaBmPxMU++NCoLFvhksJ4pjYedkjvQESUkJtJ84hva/8p7z0KNmxu3I9aL
         G3Wa3sQWwTse2pI41ZKTPEaWmFHIb8hnmenX/dMIXKLXK0aF2yH/u1GkCXj8/6uuW3
         /dw57slI5Pl0A==
Date:   Tue, 31 Oct 2023 12:53:35 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
Message-ID: <2eh6i4ttpepnpehw47zucgrs3rvzugxiay7eqy65phktcm2m4r@zwzyn5rn55yl>
References: <20231020225338.1686974-1-javierm@redhat.com>
 <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
 <87lebjksoj.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
 <87il6nkp6e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bozy7lsi3n5xgw2q"
Content-Disposition: inline
In-Reply-To: <87il6nkp6e.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bozy7lsi3n5xgw2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 12:27:05PM +0100, Javier Martinez Canillas wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>=20
> > Hi Javier,
>=20
> [...]
>=20
> >> >> Pushed to drm-misc (drm-misc-next). Thanks!
> >> >
> >> > Looks like you introduced an unintended
> >> >
> >> >     (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92=
948)
> >> >
> >> > ?
> >> >
> >>
> >> No, that's intended. It's added by the `dim cherry-pick` command, sinc=
e I
> >> had to cherry-pick to drm-misc-next-fixes the commit that was already =
in
> >> the drm-misc-next branch.
> >>
> >> You will find that message in many drm commits, i.e:
> >>
> >> $ git log --oneline --grep=3D"(cherry picked from commit" drivers/gpu/=
drm/ | wc -l
> >> 1708
> >
> > Ah, so that's why it's (way too) common to have merge conflicts between
> > the fixes and non-fixes drm branches :-(
> >
>=20
> I guess so. In this particular case it was my fault because I pushed to
> drm-misc-next with the expectation that there would be a last PR before
> the drm-next tree was sent to Torvalds but I missed for a few hours...
>
> So then I had the option for the fixes to miss 6.7 and wait to land in
> 6.8, or cherry-pick them to the drm-misc-next-fixes branch and pollute
> the git history log :(

Yeah, it's the downside of having so many committers, we have to expect
that people are going to make small mistakes every now and then and
that's ok.

That's also not as bad as Geert put it: merging two branches with the
exact same commit applied won't create conflict. If the two commits
aren't exactly the same then we can indeed create conflicts, but that
would have been the case anyway with or without the "double-commits"

Maxime

--bozy7lsi3n5xgw2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUDqvwAKCRDj7w1vZxhR
xauJAQCsvO/W/8LAibcKT5LkcpKg7nJ3xhsFZ3kSIBcwOmy0UAEAtegLrlGF0F1E
1EfNORv+mFilIjFH9e4fKyU4hCLShAY=
=L23E
-----END PGP SIGNATURE-----

--bozy7lsi3n5xgw2q--
