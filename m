Return-Path: <linux-kernel+bounces-96263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21A875975
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3471C2174D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9813B7A4;
	Thu,  7 Mar 2024 21:39:25 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951724B33;
	Thu,  7 Mar 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847564; cv=none; b=IzIlt6/orh1d5Sbs8q+BVhiGZKVq8Uit3OdlhpMb9rQvW4wS0Yvn69keD9KTFyrEYt2/P34enHIBl0miVFyFxqbQHNgbquY7G2vOW+I2XzuqE6lDRHgdPEfgUm5muXEe8ROaECjOLnWeiJpzuD7b8hbjvxtx1YjmQsrBlesitcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847564; c=relaxed/simple;
	bh=zd3k2erw2uuk3c3BlzYGox7hufIJkQAw3qdZTOa76Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrDPW+hkS321ZsjoD2W88bttqneaZaIjL5SKWUp1We0nucPpFWoNVDdae+j5lm6hdMs6hNwWpC11zyV6IWfOhIdKbkte+d9v1WhLeZ7N8L9vUiDo5n5GxMTiQ06xacU7qfax2hzLIILd+SMj66s51AYFe04tej5V2tIjXjTi7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1riLSN-0011K1-2v;
	Thu, 07 Mar 2024 22:39:15 +0100
Date: Thu, 7 Mar 2024 22:38:49 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru, jonas.gorski@gmail.com, khoroshilov@ispras.ru,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240307223849.13d5b58b@barney>
In-Reply-To: <20240307211928.170877-1-rand.sec96@gmail.com>
References: <20240307192405.34aa9841@barney>
 <20240307211928.170877-1-rand.sec96@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/77_XRhf9eTJBa5tLWZ8j/5.";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/77_XRhf9eTJBa5tLWZ8j/5.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Mar 2024 00:19:28 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:

> Yes, I agree, this is not critical code, but what's the point of leaving=
=20
> redundant conditions even if they won't make a significant performance=20
> difference, regardless of the policy (In other words, as a friendly=20
> discussion) ?

The point is that leaving them in is defensive programming against future c=
hanges
or against possible misunderstandings of the situation.

Removing this check would improve nothing.

> I understand and respect your point of view as software engineer but it's=
 a
> matter of design problems which is not our case here.

No, it very well is.

> Defensive programming is typically applied when there's a potential risk,=
=20

A NULL pointer dereference is Undefined Behavior.
It can't get much worse in C.

> If we adopt this
> approach as a form of defensive programming, we'd find ourselves adding=20
> similar conditions to numerous functions and parameters.

Not at all.
Your suggestion was about REMOVING a null pointer check.
Not about adding one.
I NAK-ed the REMOVAL of a null pointer check. Not the addition.

> Moreover, this=20
> would unnecessarily complicate the codebase, especially during reviews.

Absolutely wrong.
Not having a NULL check complicates reviews.
Reviewers will have to prove that pointers cannot be NULL, if there is no c=
heck.

> so would you recommend fix the commit message as Jeff Johnson recommended=
 ?
> or just keep it as it is ?

I don't care about the commit message.
I comment on the change itself.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/77_XRhf9eTJBa5tLWZ8j/5.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXqM+kACgkQ9TK+HZCN
iw7AkhAAtjwrADdXDv3c1cw4PcRMu8bD0Rn9zHyG1fgd3lFsnX2gsBGVSWgLZC8j
rcNpXm93xPAWZ7scQOjJ26AZ8tD0CIFY7DyAACnTGx99GkEPWV6o5LLxLXXCPkJf
Xoe8/O4l3mfGSgxRxv9zINuv2zSzHIP3IPFVRdnnKILxvX6fw7fSrkZNCbZ+DSRb
4Apm1U3jluhvwMca98apidbXM1de7uWKW6SXN3WVxvRtPApIj/9umyDI1snkq/RQ
GiZicGEmHH2NPLJL49bepMNBHf3YCEDhHp0b1tgkTClN3CtK207ZRdvkuPTTsJsP
zR/2TPR3eahhqd5ZPMwn6HMt2zQaMElRtExnrlmSviv7wO+ju/PYZPNSsCo7MBpx
pmjGcNIsAjPqQWsUt6FXgUK4deOt89hEdCIVx+jV1ciL8BhP3wg2lHIeukvAIzK2
xIFCH2CV5q0V23gf9Ops53qTCRBpHdGmocBs/iSR+e31vhe/rcb6aEEsWDsmtkj1
6NOyQZUceOuPJhvO6VRNQ+YsfsdbtUCGArtbfHTZbX0iSL3fVL2s2jh6plgK+1ag
KduC4r0YB2SotyxbCtrXOsnVQz2scppQJs2vRBOxmdcc90MPJlWLzFTtTkimjvmt
ATb9VgyM1M5E4JLxxXfBANznqYf+ERWRgw+sOqaNd68isFMIWFI=
=MbLe
-----END PGP SIGNATURE-----

--Sig_/77_XRhf9eTJBa5tLWZ8j/5.--

