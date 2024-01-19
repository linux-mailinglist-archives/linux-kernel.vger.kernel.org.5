Return-Path: <linux-kernel+bounces-30915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC48325DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF111C225E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788641E895;
	Fri, 19 Jan 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1UyX3rq"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F991E534
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653744; cv=none; b=VXUi4PEmeZAJEqkoz608CgCc+tqOyISsukfjRlggG3dp0wc4gKZWWsZ5heWllVu8vqfrt49Bsmc2KYpEklZB4y6PMNZDyqxK3A61tyf2PViBBNt/3h4EWsKvxAURl/lOERqbzaUlHXLBhzoPlNczzFK8dNAkcA4ql9agof6ZrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653744; c=relaxed/simple;
	bh=4Vu4gPndTDFA3XOfqqnlXD53u7HdkmL9yA2BpBVh974=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvbycQyxyNxECNYs6Gp4udO7iXwkGj8Jtt6B47tFJmK07dT7lxDQH/F0pkDbtnRAKjp3mKyuNk8AI4YyAoIZ18CPCXxhvv+mmMhH+M0L9tGe+wdNJD0Z3vJEtfUinMY8Dn3+k+nlBLpEGZepnaJgLVrxXoGqevGw/PzEfPC1x8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1UyX3rq; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so527557e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705653741; x=1706258541; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdyARQyfSA+ob44wLkAXE/HyCuSai2Kd85wQsKHR8qk=;
        b=P1UyX3rqLUCxMeuemuAzL+z5NRcvUFN3CwVFsCM7mwGveL1hKCieaJLgWBzymwGuJe
         F3rkodGLMndLcrSpZ4hPBbUjSqe1wWmRtVnNsvZgkoYhQxgWQt/UgEeY5i/s7Isi1GLp
         FpqyIjoZjB/bV5qFwnNorUGf0fmEDVzrWDOa+QfQ8hpu3BBTnZCaWzjKFhg1sfcbuxEL
         wLCW6JYKY8dJeP0FP4uiDxcLv2dNkVwyPGX13zq/U0P93u2NgO+LwdSy1cR1qTnvY/R6
         c15K5gmJ4+vCzmYnqQho+do+7egybvsLsBVP6evYULQlC1pvqBnt7ugQkAFZy7CZpi9O
         OzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653741; x=1706258541;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdyARQyfSA+ob44wLkAXE/HyCuSai2Kd85wQsKHR8qk=;
        b=owhQIE0F+mtYDAtieRujUb1h4WQ8TiAgM6Uz64BSuSJIYVtHp0A4tA1K5eg9jUeM2f
         p/0PuE9Rt8OUyLkL6BEQe3WaeJQPtlxc6Rw3tVRAgmqR34DwW0F1s5VAXORf4o13dc9P
         y3EgHlAIMEQcXc0LaswzllEnHVfEblv6UQNBZqb5AxBvI8ISGMCcskYHodgsxLzlJgok
         Mn8oRYFrH/sOzjsDkvHjBg9oC1nJadWjA58deOxcvChLrld08Z7dZOuBoz4Fgv0vT65Q
         hUzymn/vMdCPfiQAm8FjVnES6vIlzROdn34OG8eILSViNH5PR+kn/yTunNg1XKK+/5Du
         ZCnw==
X-Gm-Message-State: AOJu0Ywg5Dujj3oJo6XkHLn99PwBus3FdwqTgKPEFugOHLCqcW7Rt3oo
	26Pj3UibgNvk2rslDwovUnbgLLrjL1DXVQHPO6hJampTOZfd2Qc9
X-Google-Smtp-Source: AGHT+IFRB1QDRjaGLSo/qI6q8q3krKm76ZOd9NEu2AZfM1fxFho+Ehu7nOfA7or/Kz8LaiVdo68yPw==
X-Received: by 2002:a05:6512:2813:b0:50f:775:eb49 with SMTP id cf19-20020a056512281300b0050f0775eb49mr479306lfb.81.1705653740727;
        Fri, 19 Jan 2024 00:42:20 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id 28-20020ac25f5c000000b0050e902ce211sm902594lfz.276.2024.01.19.00.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:42:19 -0800 (PST)
Date: Fri, 19 Jan 2024 10:42:05 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Andri Yngvason <andri@yngvason.is>
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 dri-devel@lists.freedesktop.org, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Werner Sembach <wse@tuxedocomputers.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, intel-gfx@lists.freedesktop.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Daniel
 Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex
 Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/4] drm/uAPI: Add "force color format" drm property
 as setting for userspace
Message-ID: <20240119104205.7e4ad65d@eldfell>
In-Reply-To: <CAFNQBQwoGvSF1ryOPUUnedYUG64HqFQNXjMf6R7piufN64Vc=g@mail.gmail.com>
References: <20240115160554.720247-1-andri@yngvason.is>
	<20240115160554.720247-3-andri@yngvason.is>
	<20240116114235.GA311990@toolbox>
	<CAFNQBQz3TNj_7BSmFw4CFMNuR4B+1d+y3f058s+rzTuzdYogqA@mail.gmail.com>
	<20240116132918.GB311990@toolbox>
	<CAFNQBQyfWmfu5T7bgZDZFGfyhsxQi7YXmY_wPc9Y+mm5iSspXQ@mail.gmail.com>
	<20240117112150.4399d0bb@eldfell>
	<CAFNQBQwoGvSF1ryOPUUnedYUG64HqFQNXjMf6R7piufN64Vc=g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z/=HP4_XCgPfwY+his9cDQz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Z/=HP4_XCgPfwY+his9cDQz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jan 2024 12:58:15 +0000
Andri Yngvason <andri@yngvason.is> wrote:

> mi=C3=B0., 17. jan. 2024 kl. 09:21 skrifa=C3=B0i Pekka Paalanen <ppaalane=
n@gmail.com>:

..

> > EDID and DisplayID standards also evolve. The kernel could be behind
> > userspace in chasing them, which was the reason why the kernel does not
> > validate HDR_OUTPUT_METADATA against EDID.
> >
> > The design of today with HDR_OUTPUT_METADATA and whatnot is
> > that userspace is responsible for checking sink capabilities, and
> > atomic check is responsible for driver and display controller
> > capabilities. =20
>=20
> I'm not really sure where you're going with this. Are you for or
> against userspace parsing EDID instead of getting the information from
> the kernel?

In that specific email, neither. I attempted to describe the current
situation without any bias towards whether I think that is a good or
not design. There is an existing behaviour, and if you want to deviate
from that, you need more justification than for following it.

Even the video modes list that I mentioned as the major example of
things that userspace should not parse from EDID itself is not
exhaustive nor exclusive. Userspace can still craft an arbitrary video
mode and set it. If the driver and display controller can do it, it
passes I believe, even if it would literally destroy the sink (in the
CRT era, you could burn the flyback transistor of an unfortunate
monitor).

If you want me to take a stance, I think the kernel not gating settings
based on EDID for these things is a good idea for these reasons:

- EDID can easily be wrong, and it is easier to test sink "unsupported"
  configurations if you do not need to craft a modified EDID and
  (reboot to?) load it in the kernel first.

- EDID spec gets occasionally extended. If the kernel gated settings,
  you would not be able to test new features without getting an updated
  kernel that allows them to pass. This mostly applies to blob
  properties, and not enums, because you cannot set arbitrary values to
  enum properties.

Finally, as to why userspace parsing EDID at all is a good idea:

- The kernel is not interested in most of the stuff contained in EDIDs,
  so it has no inherent reason to parse everything.

- EDID is a fairly wide "API" and gets occasionally extended.
  Replicating all that in a kernel UAPI is a lot of work that won't
  benefit the kernel itself. There does not seem to be benefit in
  reinventing EDID information encoding in fine-grained UAPI
  structures, but there certainly is risk, because UAPI is written in
  stone once published. Userspace can get the equivalent from libraries
  like libdisplay-info which are much easier to develop and replace
  than UAPI.


Thanks,
pq

--Sig_/Z/=HP4_XCgPfwY+his9cDQz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmWqNd0ACgkQI1/ltBGq
qqfnGQ/+OppgwQEB+aMxVc0+MwMmuQ47nz4bvWEPs5Lx7wYFUk9EFcYcIduOtIQm
I+RTnC0SgenSgRIr1uDRkC2v1JF0+o7q7p4w2Hg81CXws7+T/7UwZ9W1EU6XB4Sq
2u2okBIqfBYN8Gs1L2HYxNhsPGjHN9S2V1hGTjebvgGJRiSz+ZqsRWguZV6atTas
D8+n/Wo0FfGzgejMXm0lv7Hbv7wIkFT/sTkkEAm9OJDBoWNQpDuS35dhqRifuszh
Etsjmze5JoreY/WbhIUCOl8UrCkCisE+OpO00xLaWqUDUdUSDczDjqFiPL5yS58c
mR2kpzKjsSDcUr4CfwckOV1CCg0RDx8ADbyNvaqOFunC4P2wB1b7PY1TJkoyZbg1
assUq2mDL31RiYOw8uubszgWqGlE8jHbY/KeP1j4MWkaU0Q8fphyDUpChIi64KeK
rDIM+/MzimLKJ0sWj4mTgls2i9wyQCDIQL/RTK45KX7n1hny27sXeChPleG8gikP
YiVcGl/bWyxvIj5rmS+XPVd1h2eWe34u73P0JZHJHeuMujM+yHF54CsoLW9fHz0X
mEoY5GeYTqzvpajEd10xxTYWGEb5QwTSWgfNjNYZkctU8SOay4WdimDT/H8rkM8G
iP+TASYZkYvo8j3n2i3oy7oZufviaSbDt3ycQZfi6YpGKnFBU5k=
=aTzT
-----END PGP SIGNATURE-----

--Sig_/Z/=HP4_XCgPfwY+his9cDQz--

