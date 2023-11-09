Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594A7E69B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjKILby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjKILbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:31:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F030D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:31:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACB9C433C7;
        Thu,  9 Nov 2023 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699529480;
        bh=blKVtPHhl71Ai5r3uhi0OqDF5/eM11yZfDX1m/EaHTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P60+Bp/9DMnA1KCELXWMhYLJaeGmWP/96gWvnKXjzdLatjfYHYRO0tnJa6wVxN+6C
         XHqMWvcK/WPPzcEG4IYrR1h0XmDKWw22Wyxjd0bRtIOQKcsqzHsjj1732ITsAUGut/
         kPJVf/GQAaCIbwitF6Hr9L7WLf84MllnmpYX4G2eQpCYGsymxE/qzGsv+MEAsZiaWZ
         HqwvAImawWuatTlyYkjga2vzARcfhAx3qFpYq64FK2lmJqGaXsp3n8U3IeykB9Z1Tc
         qNakhovxCz0mHiQOxJmGxWtmt8gLPu0S1/T9if9WoTjnkcgLbkNPR5qTCcwRu3Ih5H
         G9sbeziEdGepg==
Date:   Thu, 9 Nov 2023 11:31:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <ZUzDBCaqR9Ui4j71@finisterre.sirena.org.uk>
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
 <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
 <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
 <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
 <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk>
 <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zxzU1hZM/2dii12"
Content-Disposition: inline
In-Reply-To: <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zxzU1hZM/2dii12
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 04:08:06PM +0530, Naresh Solanki wrote:
> On Thu, 2 Nov 2023 at 22:20, Mark Brown <broonie@kernel.org> wrote:

> > Ah, right.  Everything except for the enable and disable there looks
> > like it should be OK since they should normally just not happen but the
> > enables and disables might get a bit frequent with runtime PM - not
> > *super* frequent like voltage scaling but enough that people could have
> > an issue with it.

> I aim for a straightforward implementation.
> Using attributes such as status or state seems ideal for receiving
> notifications.
> In my case, the application focuses on status changes=E2=80=94whether it'=
s on, off,
> or encountering an error.
> These changes are driven by events originating from the regulator.
> So below change is what I see fit well.
>=20
>         status_events =3D REGULATOR_EVENT_DISABLE;
>         status_events |=3D REGULATOR_EVENT_ENABLE;
>         status_events |=3D REGULATOR_EVENT_FAIL;
>         status_events |=3D REGULATOR_EVENT_FORCE_DISABLE;
>         status_events |=3D REGULATOR_EVENT_ABORT_DISABLE;

In terms of the implementation for delivering uevents this looks fine,
my concern here is that for some systems the enable and disable events
might happen more often than is really a good fir for delivering via
uevents, if a device like say a SD card is getting powered up and down
via runtime PM that might happen relatively often and then the system
would get a lot of uevents which it would most likely end up ignoring.
That could have a noticable impact on power or performance.

--2zxzU1hZM/2dii12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVMwwMACgkQJNaLcl1U
h9AE2Qf/cPat5XO7XYmw+GLe2j1BU3zQaukbslHjpVHoaW59Ov+qBNcCh0EqBVRQ
wyCFAnv2XnMyeesLa1GvjJoPPp0WLgORnAz5FAUxq0Zi3h610ojvochQ78y2h78I
OgPPwtCX0aZp7/CyUgXTBaByZhfEoP9XTXxCPk/6bPPkFqqIUc5SZTRxVFu6TSq6
cMrq9ny2TKP9V4vhai651X4R/ieLhcs026LPLpiR+LRwVKd1DM1rXGKSuMkD1q+F
5gESCORPLkehbp+00H9ML7F0hfA1jh7W2rC2DkBqCXd8i1zhLzDBM+fx9abLYcs4
bkviUQTRhv2K+j/tz8DsjJCO1sI6DA==
=fkOC
-----END PGP SIGNATURE-----

--2zxzU1hZM/2dii12--
