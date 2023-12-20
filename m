Return-Path: <linux-kernel+bounces-6811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FB819DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD7D287C04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7121370;
	Wed, 20 Dec 2023 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrTHVQ6x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3D21340;
	Wed, 20 Dec 2023 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e05abcaeso9333755ad.1;
        Wed, 20 Dec 2023 03:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703071358; x=1703676158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLv841g2aqTtUASe3tU8xGXA52jFUerqlxRz8E8fkBI=;
        b=XrTHVQ6xKuOf+g9/1CKxHS6FD2q1cQT/Q21pqfo+E4A9kGjYqML+Naf/wmwvTNJJBd
         viocbV2AQ1f5H3ibWUzxgKB7Z7vyDB6HGnkTGgv1w4ufNucBh25D/Fa9jgx98oE0Vi1G
         es8BRQRp2NCy7fEpQ4d7nmTlWAvjvgeMmifmTTI/uCbr5lyJcQjXJY6pvJ1Gs+djAodd
         PIcqGjFF8ABfCpO5pYe1XC4xdBxAwCLDVtNlNddMrxenHi9gr04dN6Oj9aF5+vLyP0bj
         l7EmEAZcaLlGax8A0htspLL3NNpZHtmzyeLqcYJNUOhaLOZV1ZIV1CSjpz+cdJq+v83S
         vvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071358; x=1703676158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLv841g2aqTtUASe3tU8xGXA52jFUerqlxRz8E8fkBI=;
        b=FKiceH4m43e8m6GhHWS4YUsY9eAB4Qp2RfLS0qKDtK0z4jtz6gbqrkOviJhNP1yJJj
         eyT/iUSt3mStB4aA+/sO0yjmENg41ZAM7S7UxLccSyJp+Ig3dkC5q9AHIxzSC7Zt6osA
         Bmt+xbDmsNA6YxSOxrIZJ3fK5agzA1mtVv4Hs5WdScp4cPcTvgv3Xvcd8wMW6I6ZPbZu
         EcfUiK5zgHWwY0QSDMyP6S5MbHrxpCPhPhJ+XWy+G1gdm4GxDOsDuEZ4Nk2A3MIxdX82
         8fOLL15C938s+h2//W/6DqN+U7kkv8J5+HhmLYsgqDcPE2zIWw3btjSuwOYjAJjkoCgL
         oweg==
X-Gm-Message-State: AOJu0YykYDmk+yeu1Yxjs7uNUyFNwbSF2/yucBJNdApGyk932XniHxeL
	xKqb+yKtzjZqCUXBm9SHa8g=
X-Google-Smtp-Source: AGHT+IHfKNyn3tRwqYqENrZS+iVr48qtnl+3lNEWbte23UJlNo9Glq8cb8PkGO5ih115XQXmTesABQ==
X-Received: by 2002:a17:902:e849:b0:1d3:ee70:87c5 with SMTP id t9-20020a170902e84900b001d3ee7087c5mr508306plg.70.1703071358341;
        Wed, 20 Dec 2023 03:22:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001cfb4d36eb1sm196077plb.215.2023.12.20.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:22:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 00AA01028B298; Wed, 20 Dec 2023 18:22:33 +0700 (WIB)
Date: Wed, 20 Dec 2023 18:22:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: wifi: brcm80211: remove non-existing
 SHA-cyfmac-dev-list@infineon.com
Message-ID: <ZYLOef1s5Ul7uz3_@archie.me>
References: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
 <170295913267.640718.8284035097366475252.kvalo@kernel.org>
 <18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <29c3122ca8e4d72c07942d09dca7a0fbd0138024.camel@sipsolutions.net>
 <8734vysbtt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x85mmRQAZSrLT8xn"
Content-Disposition: inline
In-Reply-To: <8734vysbtt.fsf@kernel.org>


--x85mmRQAZSrLT8xn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:53:18PM +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > On Tue, 2023-12-19 at 10:01 +0100, Arend Van Spriel wrote:
> >> >=20
> >> > > When sending an email to SHA-cyfmac-dev-list@infineon.com, the ser=
ver
> >> > > responds '550 #5.1.0 Address rejected.'
> >>=20
> >> Is the claim here true? In another thread I replied all including this=
 list=20
> >> and I am not getting a bounce message.
> >
> > I also got the bounce, FWIW. And Lukas is using gmail ... if you're not
> > accepting mail from gmail I'm not sure you get to call it "email" in the
> > 21st century, for (better or) worse...
>=20
> And is Infineon even contributing anything to upstream? At least I don't
> have recollection any recent activity, though happy to be proven wrong.
> We shouldn't have dormant information in MAINTAINERS file.
>=20

I'm also using gmail (and GMX as backup). When I sent my reply about rPI
testing [1] with SHA-cyfmac-dev-list@infineon.com Cc'ed, I got `Address
not found` error instead (but the DSN message was in spam folder instead
as I treated it as junk).

For Infineon, they're now focusing on TPM subsystem, with the latest message
is 6 months (or a semester in academic speak) ago [2].

Thanks.

[1]: https://lore.kernel.org/lkml/ZYLKftqKFJ_PMmF3@archie.me/
[2]: https://lore.kernel.org/lkml/20230613180259.3525-4-Alexander.Steffen@i=
nfineon.com/

--=20
An old man doll... just what I always wanted! - Clara

--x85mmRQAZSrLT8xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYLOdgAKCRD2uYlJVVFO
o98gAP4yOBKMBVs5YC/xxJc9ZWWlDpUX3Hm41puwaNZW55ftNAD/VVzZ/QTjzPv6
9WYs5N9WaXzO/OmTYYMhbWRfDRWpJgQ=
=btd9
-----END PGP SIGNATURE-----

--x85mmRQAZSrLT8xn--

