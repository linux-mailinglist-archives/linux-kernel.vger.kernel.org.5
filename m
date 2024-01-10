Return-Path: <linux-kernel+bounces-22208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB822829AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F911F25C05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72548799;
	Wed, 10 Jan 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4y+FwLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E6482F6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99182C43390;
	Wed, 10 Jan 2024 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704891883;
	bh=+SjzS/Drd8ufsTQioscucOOdIE6ClI3c5SSNDiQg2Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4y+FwLaySYAvGCv2cfZ0QV7RNEc6s74AAqupFSX+tdKcv5nAN7BofaBND7FRcDKL
	 Z0q3TIHyhrFPZZ/hbZxD/7fL3PUlVJohrb6oHtJzK3zhum4+RBe5UySPkn/7z32NCL
	 FjUYxspEEl5QWtQIl1JqH6Yu13eVtvEQBN1vjnMX3C39WSnx/H0k7YfWpsEYYe2A2C
	 LIPofFqH1ZQQ+ZTw40VdO7RuOoO71B/eMixT92wW0hbFelwd7U6jLrUlk4vldkqmK4
	 PNzl7aYphuYvW3ug+FT/23oKori/mVypaaDIvUMOh1ANeY8AMUQr28UU0JXdFT1LnR
	 3hf/mbQXBig3Q==
Date: Wed, 10 Jan 2024 13:04:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: debugfs: runtime resume a device when
 reading registers
Message-ID: <6c4d37c1-9376-46b7-bd75-e68b84adbbd5@sirena.org.uk>
References: <20240110095358.473663-1-alexander.stein@ew.tq-group.com>
 <3bc9c762-3573-4d8b-bfcf-6c8e91938dcd@sirena.org.uk>
 <7625183.EvYhyI6sBW@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CzwprgKoqbZ35KaK"
Content-Disposition: inline
In-Reply-To: <7625183.EvYhyI6sBW@steina-w>
X-Cookie: Do you have lysdexia?


--CzwprgKoqbZ35KaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 01:46:31PM +0100, Alexander Stein wrote:
> Am Mittwoch, 10. Januar 2024, 13:23:17 CET schrieb Mark Brown:

> > The idea is that the debugfs interface isn't supposed to be disruptive
> > to the thing being debugged.  It would be better to detect if there will
> > be problems and report the status as busy.

> In my case the device is actually unused, runtime suspended, thus disable=
d=20
> power domain. That's totally different to busy. In this case dumping the=
=20
> registers is non-disruptive, unless you account enabling/disabling the po=
wer=20
> domain as well. Any attached clock is already enabled/disabled, but power=
=20
> domains are not.

At a regmap level we map that onto -EBUSY for devices with a cache
(using a cache for your specific device ought to DTRT, it's not a
general solution though).

--CzwprgKoqbZ35KaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWeleYACgkQJNaLcl1U
h9BDbAf8CTNBr7P+ghxeJa+lDyvoyKaksrfMZlia3RIFv+ssY9mQrDc158pE28fK
uqYnXdUqzMLKhz8s7v1McdNPus70sagD4foI73hKEMgvdld6cAF6mVr+hvRzd5f/
5ZL455C8t1TUXf1NCHtMLBRiswiLgx+8Lhd1opyUsFmCIPhgX79K5JK11n5bviOx
XFKs+vXSuj/f6yCj5CrI/wT0Wb4k611at9/PthCjiYXBhPmHq0/3/YtuYEnwNzwx
XyKh1KXefBCWPC+UI2YL0T4/4WWpul4B/o/7pZS8HzzKfhhY+yFXTPERRM0CWAGW
FpDumuQ3YEMA1NHJEEmeG9a2H8URyw==
=yNCF
-----END PGP SIGNATURE-----

--CzwprgKoqbZ35KaK--

