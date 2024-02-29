Return-Path: <linux-kernel+bounces-86239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B964C86C2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAECC1C22CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244E45BE9;
	Thu, 29 Feb 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h+v8C5k6"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC344594B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192007; cv=none; b=Nr9DewiEDp5B4ms6Ey3BS/+NOlCaH7ttDN7NUJzCfVgUgZyTyCUdAGgsKHdrhvty6TA5MDk4yQSHofo4MOgbuV8sUb7a2Ck9p3Rqs3M0cDyNulwiTh92z/RRMj359nb3lhfffNS7HxZfSv/mGaug4T3a52GkJkIAL2UQGPzVGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192007; c=relaxed/simple;
	bh=MXMlJN6n572oFcdDsuVeCkTGLCDCZh4tRdRct4X1LNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN14yMJTczzdU0FXloAXw127mKGdli7QAlXKjMjn+qYTwUnVrnYHgMptkmfp4t8q4zTpS3f8ecuZfTU8GRfFaDHcsxNJEzW5l0Q791+BE8sZ3kKIbhtxivtxGYDARbDloOEH86oujuf/kkD+5RSHP2qRZCisIiFL5+XIy2dfLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h+v8C5k6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n9Fl
	5xfpB997/ASvKk+rVPrNQztesazR12o5BkzzxIU=; b=h+v8C5k6ZI0JN2q2gIVe
	w4bZmwOiluKFcplFOVoqhaw7xAdtYEPJIZ8aAIRAnRdZWY11AgTkEQkJCtAWWoxN
	AdEURR6iuxWkBGaCgEp9bydl0zhrdx4PbN0g5n/PrUbykLTlSn8LmA0/dEN0gxiZ
	hMcb7g5TKrBlClTztwNIA4Aed/Ko2zGLBh32uEmL8DKUepaSME0FRJ32gTWCwp2U
	jC5UepkWQpEcc3NCWOkh32qux2AGFnSGIdST/QMDndRxVz829No12PN4njp/NX62
	5f5ypq2U4kD42A+JkLUdfbCxgQgQ9BeLK8Tz28zd1W/IfrFjZoiO6U1FExklq8Cj
	nQ==
Received: (qmail 2212258 invoked from network); 29 Feb 2024 08:33:13 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Feb 2024 08:33:13 +0100
X-UD-Smtp-Session: l3s3148p1@0KWgRYAS0JcujnuA
Date: Thu, 29 Feb 2024 08:33:13 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] mmc: tmio: avoid concurrent runs of
 mmc_request_done()
Message-ID: <ZeAzOUN-8QEl4U2n@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	linux-renesas-soc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240228100354.3285-2-wsa+renesas@sang-engineering.com>
 <331084d4-2802-4d1d-b978-6660f546ea2d@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yXWwMvQMGXoOVewE"
Content-Disposition: inline
In-Reply-To: <331084d4-2802-4d1d-b978-6660f546ea2d@de.bosch.com>


--yXWwMvQMGXoOVewE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

> > With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> > outside of the spinlock protected critical section. That leaves a small
> > race window during execution of 'tmio_mmc_reset()' where the done_work
> > handler could grab a pointer to the now invalid 'host->mrq'. Both would
> > use it to call mmc_request_done() causing problems (see Link).
> >=20
> > However, 'host->mrq' cannot simply be cleared earlier inside the
> > critical section. That would allow new mrqs to come in asynchronously
> > while the actual reset of the controller still needs to be done. So,
> > like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> > coming in but still avoiding concurrency between work handlers.
> >=20
> > Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> > Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme=
@de.bosch.com/
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theore=
tical race")
>=20
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Awesome! Thanks for the super-fast tags!

> At least the issues we observed before are not seen any more. As we are n=
ot
> exactly sure on the root cause, of course this is not a 100% proof. But as
> the change looks good, looks like it won't break something and the system
> behaves good with it I would say we are good to go.

I agree. We don't know if it is all you need. But there definitely was a
race window and closing it removes some observed anomalies. Let's hope
all of them :) I looked many times at the code and, to the best of my
knowledge, don't see side effects. 'host->mrq' stays non-NULL, so new
mrqs won't be added like before. Changing it to an ERR_PTR will only
affect the check in the done_work handler which is what we want. But, of
course, more eyes are always welcome.

> I think we could add anything like
>=20
> Cc: stable@vger.kernel.org # 3.0+

Yes, we should definitely have that. I would have added it once your
testing got good results. This affects every Renesas SDHI or Uniphier SD
instance since 3.0 (12 years). Wow! So, thanks a ton for your report and
assistance in debugging it. Very much appreciated! And, phew, I am happy
that this solution does not make the locking more complex \o/

All the best,

   Wolfram


--yXWwMvQMGXoOVewE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXgMzUACgkQFA3kzBSg
KbbIwA/8C0nJicwAl4j00mETzzdiC36BY6uQzoqil257N2l/QOBBGo3PdjzdLW41
KOggdi2aX+xRmGPuIIevXbKDYfu0GJUcTMwY3cqJ5Y+oQLC2s2e/ZSVUqc34vxv/
sNbJYcLwJE+cTN2H0GMzYnUoZS96Nq0JSr1qhMCWUOWWQ9jAlBTw/7bK07i3YWO5
6eP/6GaoxE2TJwnsrjgGflCIAtL0/VQV6VWjgGfWXMUSO3+LSBrbNITWUgUcCncj
YwLgPKZEoweyIWJ13TrpODyxxXyTu7NZlj5zkIfDSrKnobO6oN2970NVeM0fTkS7
eInBGie7rXRuADOxureLRkn+ElEZ6rlPyq4jDU5ycYbwEXNYW9+enAK7ns9ce9M6
EqjuPS0okYZpoOpvDvwjxJ5Pc0CBFPP6iVq2yYtbZPbSZElKDKeh12lwmtdGaar/
fTbt47paI8LMsKtroDeY/q5eBzh7l2Gu0SeOLHERBKN9wLfROglQ5X56qr73iaaC
QuQ4DGr8bphvbiJpBbQ65e9uy0Ti8AqClb6JgkIiAbyYcFfmRL5T7d81yZtS1PHE
27jtIjqJ2mCZavq2aAxNfTHNEpr8hSlJtLrLNoOgalww9gPbZMCNsJU+RGNgLo+y
esVZRoTz70+es1cBmUAuvXc8yInLWope+JNK3GhIOSGK6rRmOy4=
=4Qja
-----END PGP SIGNATURE-----

--yXWwMvQMGXoOVewE--

