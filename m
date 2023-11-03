Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEE7E009D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjKCIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKCIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:46:37 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3ECD43;
        Fri,  3 Nov 2023 01:46:31 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so1095030fac.3;
        Fri, 03 Nov 2023 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699001190; x=1699605990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVywe0D/U3C5N1dPQibx8KoiHM6ZJRIDGPFvHnYX9lg=;
        b=DhBAWwfm5Gb3ffnfJ5j6UTwPKxkNHf+VtKuBnpauiMtP5/azQDmeov53Fc5n7OcKu3
         0xCmTPmp3725qCFF/baDH/xKxoTYiCJi3tdz+z3ua+s8eZlHaaUtSpubGqKWWCsTx5S9
         g6tHIMi2WlqXcQER91dl6A4eydYDtmj5/4xU3fS7/4hGeoofUSFXgW0GpCSxamhbSa1T
         WDPmMKIbPBpvw7X/mnGok4GDjiUX1UQGNdjWsF3E09GFlflxb2Xl352f+nqbym9m681f
         sDiYCBg0Z+Ven2pbiMYgdR1SXuT4KMSZBqr1LozhiOpN4bT+rxZfmhz0p+ILriQ1bxdZ
         9etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001190; x=1699605990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVywe0D/U3C5N1dPQibx8KoiHM6ZJRIDGPFvHnYX9lg=;
        b=wcdMix5oOTcsb5nvw2TxA5AtyygcKb0tR6SAZXYlKfrqwPCnAnm2l14DP4X4wmPaYa
         HV8xeXhTa3c1L97SGEA9HwZJxRr1Y+LJXP8aN2v1TBsHh+kA2pjnaUO7Jz0UcGXuNFvf
         dNsNDSwD7Q68XI3xZGbnHf78H4IT5bvh/S+2BYP2sqaFBeXpHpN0Uuw+VFZ7wfWzU0Qq
         UkQq+5EU4qQlt+YK3tbiL655OEdyEu3bJWF9lG7/8NodpGoSVKkP7D8MX2Z4j1S2bGik
         sBetbbLGlauODKjcn8mGDTndm8doDua5BBiIUyLlZs7dV9fThIjiONER1f0mf0RQOFmg
         duVg==
X-Gm-Message-State: AOJu0YzQYrAV2pF+A3yNvJNBLZQ3AbR9tWvH/3FjxrKWl0DwzwOUViiT
        YpIQdtpZtPhqUCeQ72GYQ20=
X-Google-Smtp-Source: AGHT+IERRA7t6kiipduzM4sDbD9g3jrgnHi7jIHWJSoE6sMHhxpxJGtMy+DHjS/QrwyNgkq8Mg0TSw==
X-Received: by 2002:a05:6870:b013:b0:1e9:9742:7dfd with SMTP id y19-20020a056870b01300b001e997427dfdmr23542991oae.31.1699001190331;
        Fri, 03 Nov 2023 01:46:30 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u4-20020a654c04000000b005a9b20408a7sm784642pgq.23.2023.11.03.01.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:46:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DA73191D73C3; Fri,  3 Nov 2023 15:46:26 +0700 (WIB)
Date:   Fri, 3 Nov 2023 15:46:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ken Moffat <zarniwhoop@ntlworld.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH RFC RESEND 0/4] Documentation: Web fonts for kernel
 documentation
Message-ID: <ZUSzYtBpvAmM3ZRs@debian.me>
References: <20231102123225.32768-1-bagasdotme@gmail.com>
 <874ji48658.fsf@meer.lwn.net>
 <ZUQ-K7MXzHZ_oyVK@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kmgiKCzrjAfMsus"
Content-Disposition: inline
In-Reply-To: <ZUQ-K7MXzHZ_oyVK@llamedos.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kmgiKCzrjAfMsus
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 12:26:19AM +0000, Ken Moffat wrote:
> On Thu, Nov 02, 2023 at 10:35:47AM -0600, Jonathan Corbet wrote:
>=20
> Jon, some slight nit-picking below, after comments on the stated
> problem.
>=20
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >=20
> [...]
> > >
> > > The solution
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Uniform the font choices by leveraging web fonts. Most of people read=
ing
> > > the kernel docs should already have modern browser that supports this
> > > feature (e.g. Chrome/Chromium and Firefox). The fonts are downloaded
> > > automatically when loading the page, but only if the reader don't
> > > already have ones installed locally. Subsequent docs page loading will
> > > use the browser cache to retrieve the fonts. If for some reasons the
> > > fonts fail to load, the browser will fall back to fallback fonts
> > > commonly seen on other sites.
> >=20
> Bagas,
>=20
> If loading the web font fails, you will get whichever fallback
> fonts are enabled by fontconfig and whichever fonts you, or your
> distro, have installed.  If those fonts are not generally adequate
> you should complain to your distro, or install different fonts in
> ~/.local/share/fotns and perhaps change your fonts.conf entries.

I beg to differ.

That's depending on font-family rule. For example, if I write it as:

```
body {
	font-family: "Liberation Sans", Helvetica, Arial, sans-serif;
}
```

browsers will try loading the first three fonts, in order. If a font
isn't available, they will try the next one until they can. Only then
when all other options are exhausted, generic fallback font will kick
in.

And yes, I do copying all fonts from my Windows installation (since
I dual-boot both it and Debian), then configure GNOME to use Segoe UI
as UI font (as it looks nicer to me). I also drop in font substitution
rules in `~/.config/fontconfig/conf.d` since I'm not the fan of
(obviously non-free) S=C3=B6hne and substitute it with Inter and Source
Code Pro.

>=20
> > So my immediate response to this is pretty uniformly negative.
> >=20
> > - If you don't like serif, tweaking conf.py is easy enough without
> >   pushing it on everybody else.
> >=20
> > - I'm not thrilled about adding a bunch of binary font data to the
> >   kernel, and suspect a lot of people would not feel that the bloat is
> >   worth it.
> >=20
>=20
> Jon,
>=20
> As I understand it the (woff) fonts would be downloaded on request
> by the browser if this went in.  So not a bunch of binary font data
> in the kernel, but a download from google (adding to the popularity
> of the font) and yet more font data in the browser cache.  I don't
> have any desire to see woff fonts referenced in the docs, just
> nit-picking about the details.

But I wasn't considering people using terminal-only browsers (like
Lynx).

>=20
> However -
>=20
> > - The licensing of the fonts is not fully free.
> >=20
>=20
> AFAICS, the SIL OFL allows everything except changing the font name.
> If you have the right tools you can apparently fix things like "that
> specific glyph looks ugly" or "you put a latin breve on a cyrillic
> letter" (apparently they should differ) or "You mismapped this
> codepoint to the wrong glyph". What you cannot do, if those changes
> are not accepted by the font designer/maintainer, or if the font is
> no-longer maintained, is fork it and provide it under the same name.
>=20
> You can fork, but the font name has to be changed (e.g. LinLibertine
> -> Libertinus and then the serif forked to CommonSerif).
>=20
> Oh, and you cannot sell the fonts by themselves, but you can bundle
> them with a distro or embed them.
> https://www.tldrlegal.com/license/open-font-license-ofl-explained
>=20
> Question: is that not free enough, or is that site wrong ?  If not
> free enough, is there a better licence for fonts ?

Yet Debian distributes OFL fonts in its main archive...

For me, for the fonts, I'd like CC-BY-SA instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6kmgiKCzrjAfMsus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUSzXwAKCRD2uYlJVVFO
o2kSAP9OiWMN4avk4kAZdm2oGRch0M+/NeExTW/cph9LdbqHhwEA7qIWmTFHufcs
9Mlih2xOkjGFDJfmqDPv5jeAgI6CYAw=
=qrkE
-----END PGP SIGNATURE-----

--6kmgiKCzrjAfMsus--
