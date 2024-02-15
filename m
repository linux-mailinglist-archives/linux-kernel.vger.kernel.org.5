Return-Path: <linux-kernel+bounces-66611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13B855EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F8283DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6269D13;
	Thu, 15 Feb 2024 10:12:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD667C44
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991962; cv=none; b=XxMhE6/Q3uAKtcJcgoa+a9V+01Yy2YVvaoq1o3HAAUEsCdgXbfHIRzTdFb2JN81WWogXu1wfF6bx3ybV1J0U3jWEpd3S/TMhkpugBRl2/hRtvcsbqLQngamDMMRcMp81mgDHCac5MmzYMQKu70qzvdcp0TeYy0l5gQ37EN4YJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991962; c=relaxed/simple;
	bh=eIFtCimqDhFJk6HuIKLTMzw5qvsWlj3IyY8h7yW9DwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s979FNUPpjEo3r0UoPAX485Iqjvas94sMKEh1tFMbNnORTHjNS678y7beGDDoUwp7JYNjoRadEsedjwyh7gF1CSnVEFRNj8q0Qsj9ae/89CKXSJWjGOPdrKz0NrPMvUtj0T5Z01YW64Kq3Tp4Np5FVf1YVEENbFEBN2YeeHznsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYjH-0005ke-4v; Thu, 15 Feb 2024 11:12:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYjG-000rdf-8J; Thu, 15 Feb 2024 11:12:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYjG-005I4L-0U;
	Thu, 15 Feb 2024 11:12:30 +0100
Date: Thu, 15 Feb 2024 11:12:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Viorel Suman <viorel.suman@nxp.com>
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>, 
	Florin Leotescu <florin.leotescu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: reset module on probe
Message-ID: <zeieriiouilwf23g4v5wv7oetdee43qcm5lvxiygyxmxm7lgde@m3a2uain6g45>
References: <20240201122242.1597601-1-viorel.suman@oss.nxp.com>
 <vvldfzpthexjb7bir5imrdslgnnqztl2rdclfp6qiesj6hgiea@o53kcxs66mjr>
 <3d866664-d2fd-4d36-9e8f-5242327e41b9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxbuzkk2jq3itvqv"
Content-Disposition: inline
In-Reply-To: <3d866664-d2fd-4d36-9e8f-5242327e41b9@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jxbuzkk2jq3itvqv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 01, 2024 at 06:25:26PM +0200, Viorel Suman wrote:
> On 2/1/24 15:38, Uwe Kleine-K=F6nig wrote:
> > > +	/* Resets all internal logic and registers */
> > > +	writel(PWM_IMX_TPM_GLOBAL_RST, tpm->base + PWM_IMX_TPM_GLOBAL);
> > > +	writel(0, tpm->base + PWM_IMX_TPM_GLOBAL);
> > > +
> > This opposes the use case that the bootloader setup the pwm-backlight to
> > show a splash screen that is simply taken over by Linux without
> > flickering, right?
>=20
> Yes, I was not aware of such use case. Is it acceptable if I'll update
>=20
> the patch in a such way so that the software reset happens as function
>=20
> of a property in the related DTS node ?

That sounds wrong. Why do you reset at all? If at all, only reset if all
channels are disabled (if at all).

> > Otherwise the commit log should motivate why "the module takes the
> > default state" is better than the status quo and what this default state
> > is.
>=20
> The default state above means IP internal logic being reset to the initial
> state and
>=20
> registers values being set to their reset values. We're facing a situation
> on iMX95 when
>=20
> A core may be reset independently from the rest of the SoC, this triggers=
 a
> new
>=20
> SPL->U-Boot->Linux boot, and in Linux probe phase PWM will inherit its st=
ate
> from
>=20
> previous Linux runtime - this leads to some issues in suspend/resume
> functionality.

What kind of issues?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jxbuzkk2jq3itvqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXN44gACgkQj4D7WH0S
/k5Ciwf7BecLTtanPQd8D4/UIOl88dzpimfzOqdiUzZeHyMfb66uhQlG/1U+6JUE
aWOR9SWebqo2GRGhzXevHWX0cMNtVIk04tBKyeEMvn+QiCBLuoPEi4JNP9pfTFCl
Wdhbn+YDz0/oUOEo1PkAdJiKMyIBf/kKkHMh6qepajH0K1ul5aIRPIa6UA5SfgR8
CTFqTEnD3slilQ67anWF6oASkFZGukHluLtg1neiY6JbR6C4FwG2QjE30fsFjRll
Yf6V171w4lQj76xAgxLMku/Z2j+l7bueEz7lJC04QBP9ZIwY/r+KnvPgzAtsoBLv
4XehTo0rOdEfwluvr6xyP/6brmlD0A==
=d7Gu
-----END PGP SIGNATURE-----

--jxbuzkk2jq3itvqv--

