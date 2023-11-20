Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D47F1E33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjKTUww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:52:50 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB47CC;
        Mon, 20 Nov 2023 12:52:46 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3238D1C0050; Mon, 20 Nov 2023 21:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1700513564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmYv3UZocdypqxuydUEGfEMndPZRJHoMutba992HhG4=;
        b=LC/ryqAwHZMovN00YnWHQnp6TzEJCoa/1N8SH+6PrNzOIChJA8sbYrJ4hLlp/BDrG0q7Mm
        lHy/fJ4jdc0pQ0VhuxmAKsc1YGGbCUUrNuo6Atj1H1D/qKz1xkum6UnNDsLzYQs019SBjY
        iSDcC+FWipuxZ7+GT08fRqJ0tKEB4AY=
Date:   Mon, 20 Nov 2023 21:52:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>, hdegoede@redhat.com,
        jikos@kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Werner Sembach <wse@tuxedocomputers.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-input@vger.kernel.org, ojeda@kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Message-ID: <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
 <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iuztSBtSd0N/7Hw5"
Content-Disposition: inline
In-Reply-To: <87sf61bm8t.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iuztSBtSd0N/7Hw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> So... a bit of rationale. The keyboard does not really fit into the
> >> LED subsystem; LEDs are expected to be independent ("hdd led") and not
> >> a matrix of them.
> >
> > Makes sense.
> >
> >> We do see various strange displays these days -- they commonly have
> >> rounded corners and holes in them. I'm not sure how that's currently
> >> supported, but I believe it is reasonable to view keyboard as a
> >> display with slightly weird placing of pixels.
> >>
> >> Plus, I'd really like to play tetris on one of those :-).
> >>
> >> So, would presenting them as auxdisplay be acceptable? Or are there
> >> better options?
> >
> > It sounds like a fair use case -- auxdisplay are typically simple
> > character-based or small graphical displays, e.g. 128x64, that may not
> > be a "main" / usual screen as typically understood, but the concept is
> > a bit fuzzy and we are a bit of a catch-all.
> >
> > And "keyboard backlight display with a pixel/color per-key" does not
> > sound like a "main" screen, and having some cute effects displayed
> > there are the kind of thing that one could do in the usual small
> > graphical ones too. :)
> >
> > But if somebody prefers to create new categories (or subcategories
> > within auxdisplay) to hold these, that could be nice too (in the
> > latter case, I would perhaps suggest reorganizing all of the existing
> > ones while at it).
>=20
> One could also reasonably make the argument that controlling the
> individual keyboard key backlights should be part of the input
> subsystem. It's not a display per se. (Unless you actually have small
> displays on the keycaps, and I think that's a thing too.)

While it would not be completely crazy to do that... I believe the
backlight is more of a display and less of a keyboard. Plus input
subystem is very far away from supporting this, and we had no input
=66rom input people here.

I don't think LED subsystem is right place for this, and I believe
auxdisplay makes slightly more sense than input.

Unless someone steps up, I'd suggest Werner tries to implement this as
an auxdisplay. [And yes, this will not be simple task. RGB on LED is
different from RGB on display. But there are other LED displays, so
auxdisplay should handle this. Plus pixels are really funnily
shaped. But displays with missing pixels -- aka holes for camera --
are common in phones, and I believe we'll get variable pixel densities
-- less dense over camera -- too. So displays will have to deal with
these in the end.]

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iuztSBtSd0N/7Hw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVvHGwAKCRAw5/Bqldv6
8nzcAKCH+YE+d5eAe0VW6rfZmAJwikFR7gCfVhTufr+Do9q4oVaeBHZ3Xm/o9xY=
=kzI/
-----END PGP SIGNATURE-----

--iuztSBtSd0N/7Hw5--
