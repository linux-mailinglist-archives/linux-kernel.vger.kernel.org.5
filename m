Return-Path: <linux-kernel+bounces-61819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFEE8516EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7922816E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAF3B191;
	Mon, 12 Feb 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ucn0XUTn"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B63A28E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747659; cv=none; b=kbFkQBDw8BktUn/n019tO3YB7Y9kC1BGBvY6jp8AdZCdjqucbHXPjJm1GueBuZOhWtlqNpjeoUfnljDVWlRviGhgY8GdD7LM+I9TZ6pq8kSKEPztO0pWJIH8ySmadNds/xr5erW3Mj9t1u7bbAlRg0r/PiWlpzZgZU2ULqD0DMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747659; c=relaxed/simple;
	bh=2gSaRSQQYmex30vqmlwUAe1V7Qbpl9CVZLP1DZNzHYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpnJ55yh2iHr3tFw5vHf25N8pMXxt1jbFEPEb1vPWGf5c2wD0zB90bhARFUVYRhfpoPtnQVb+4JfSIm9djBw4DoDi4CqUvjHk2I9a2evXKj3yIFjtpWTUF9X09DS1eVSYhqcofGZDyoAQxYvI5RmDS6xfCXDmSPSvsoc8iMWeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ucn0XUTn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=2gSa
	RSQQYmex30vqmlwUAe1V7Qbpl9CVZLP1DZNzHYk=; b=Ucn0XUTnyND9BsB3hXSE
	2HMMm0dhlUt7UKmunFBjwzr0yY5/VYzusF+DNS5jCxV7X+nSgSbNvzXyr2C04v+8
	sX5KyEFDqCXoP2j6SKW/GT2cV/VdMN7Jy6RM9gV884hfej7ULTWQkm5Ztb8KKd1o
	qccADXKTcRuiomOAz4dEWYUJjWkzBK9v7kS7vFUAQXg+ZeqJAVN0HcZw1fiJzjj7
	PbvtQSLj1po7lpyj/eFT9hXYkBTnNcedmAmkiPqYSSp46+cHbIBVnCiDOqimLaPC
	/lLwb4cGJIIcVRJt6D86C/Y5B0bnDsy4EXgn9N0vEpAEvyBpev0Z5mawZnreAROq
	ZA==
Received: (qmail 530348 invoked from network); 12 Feb 2024 15:20:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Feb 2024 15:20:55 +0100
X-UD-Smtp-Session: l3s3148p1@lS5d/C8RhOEujnsZ
Date: Mon, 12 Feb 2024 15:20:55 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] arm64: dts: renesas: ulcb-kf: adapt 1.8V HDMI
 regulator to schematics
Message-ID: <ZcopRx-o_stPEo6c@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com>
 <20240129212350.33370-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>
 <ZcogWgtQ7hZ-5aj0@shikoro>
 <CAMuHMdXAPN=DML7BOwRgLX1Z9NZmtCZY9ARZupKV9JELmb0rdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hS3qw5PoogRAwnTl"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXAPN=DML7BOwRgLX1Z9NZmtCZY9ARZupKV9JELmb0rdg@mail.gmail.com>


--hS3qw5PoogRAwnTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > "t1p8v"?
> > > Or "reg_t1p8v", as the former is a rather short name, causing conflic=
ts?
> >
> > Agreed, I'll take the latter and resend.
>=20
> No need for that, I can fix it while applying...

Cool, thank you!


--hS3qw5PoogRAwnTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXKKUMACgkQFA3kzBSg
KbYeXQ/+IwaXXBkkjvds8nTArYHBtGkui+0QObhM2NCAk+eQAuogiL5K9x/xbhjU
xPv1tlEcMdBo8RZVr92N+Y07BXsoOKWRDGpexPs0z7PyLxYEnhqgndXLRsQN5+qs
KJZyPB3wMHT1bGK1XiWH9f+58ME3GA3RibB1H5XdFvmWKjj0C5BY/pslTU+cAJXO
3dPveXU9N8knEurymwBvn0CyJMGti5iJ9vXDpYQedU4cFTvMNDfoKSn+/X9tEEOm
l6dJmpnyuMo9D6Bxy7TXxW6TxoU3Gxm45Qb+TIy0VgKXibWPUtiKs/iSeIrYrDLg
+0sU5FgXao4xNt35Pq6HLdypGbWu8I22pSX45ONSB5LbXgUWhzt3ejflvO/snfSa
DRonrg2kOMfUiNZVwbI94OL/j13/cdp3uIKn9XaRm6PLqBscwZqC+mUplqmCKeLe
YLGEg2oud79WnPaDnnsA+jelRhMdBjQiq9K0Zy+pmixR0Xoy5ww3luTR5v0Qr02b
wGukSED4wAeG+OufUMyWT4MAiFEz88c7tjqpkIb69AaDggg1d73qwT/RaoVgOs5p
veLMi+qqTl7RJCf1aCKqKjZlASLa0P68CcI8sUSvGE2I9E9hKEgNIDcEmvtvtyVC
B12nP4nlXpxJKFYZnvm/f4OvpDWuRlnY3x0MfnthzrpR5QNt4mA=
=Soql
-----END PGP SIGNATURE-----

--hS3qw5PoogRAwnTl--

