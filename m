Return-Path: <linux-kernel+bounces-119284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AC288C698
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA613B214CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493E13C81B;
	Tue, 26 Mar 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0J9bRP4w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3713C823;
	Tue, 26 Mar 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466107; cv=none; b=NwbqoLVFlqd5p5UIlV2Uou+yaVvvfvAW/2qp/SjL6cgudrFUN5h1Q/+4mEDFmH4W9uVirMHNIRXfj2fj2jaA3ukGfXmiVX1HNpxzePZafEPcvxfKjlbOMVrbeIZTFg+nwRc3fap0aCZ+2Q/KuX6gw+pqr9rLjc1niQiceYp3YoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466107; c=relaxed/simple;
	bh=IKdZp4IRgc8xeC8YY5nKHVRglqMiofMfH8oO97uViWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPOTx6ZE5A5+kPSzw53pRJl0V5iPVzpNpRlgGgLoVcmIstYum1jKlr9AhrnQKLFXNvI645DZCTZMQIooV77XlaPGCXJC9Zu23jeDEeBeOc7UvqzUV/0DyA9wWT5KT4/mpp5MDCEuRCy+MIDgDLQulSimHtAnI4SZB8uUO07xCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0J9bRP4w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711466103;
	bh=IKdZp4IRgc8xeC8YY5nKHVRglqMiofMfH8oO97uViWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0J9bRP4w2qpngdNMeAoGw7+5onmDYQkWC6nOQFOsDkfnCisUZzYedXIo7+OC3xsW/
	 JfaqM/VxqvSgUY200i60KPKJdH4XznhadjungfhracXtNvSC6u8wODaLWCOClhkRyW
	 x99zM4bcl+6CjrluTTg66ciwbwdWnEoG/1WWgCCHfwAWOXLAUQxGKqBqGQIP3KqvKj
	 rjo2LE6MBBxRf1CbmLTVKSyUm8DPb28o530ILyTwUfEVa4lUTJw+Lgsyx+a+V399B+
	 zeFBfiT03UMN/PPZJKWi8TlMjShqZOECiPltipwuKkp0XmBxnJe6v92mHofdDVCUAR
	 0ZWxCwz6FIoJQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6C870378020D;
	Tue, 26 Mar 2024 15:15:03 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 103F51060700; Tue, 26 Mar 2024 16:15:03 +0100 (CET)
Date: Tue, 26 Mar 2024 16:15:03 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: hsi: hsi-client: convert to YAML
Message-ID: <5z2b74h2zvo7fwc4624hy5vegvlkyfdflijr35byqeemoiwd6l@vfebii4m2mim>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
 <2905247d-03b0-45c1-add5-d3c2a986d87c@linaro.org>
 <hz4fbdix5yaz2wtdkjkf23pc3m4kbeavynvjagundqvv3bisor@lc7dev4667i5>
 <1c6d995a-b1f1-48ca-b85c-f69071e7e3bb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yeqb2gbu3cd3r5gn"
Content-Disposition: inline
In-Reply-To: <1c6d995a-b1f1-48ca-b85c-f69071e7e3bb@linaro.org>


--yeqb2gbu3cd3r5gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 01:56:22PM +0100, Krzysztof Kozlowski wrote:
> >>> +allOf:
> >>> +  - if:
> >>> +      required:
> >>> +        - hsi-mode
> >>> +    then:
> >>> +      properties:
> >>> +        hsi-rx-mode: false
> >>> +        hsi-tx-mode: false
> >>
> >> I don't understand what you are trying to achieve here and with anyOf.
> >> It looks like just oneOf. OTOH, old binding did not exclude these
> >> properties.
> >=20
> > So the anyOf ensures, that either hsi-mode or hsi-rx-mode +
> > hsi-tx-mode are specified. Those properties were previously
>=20
> Not entirely. anyOf should succeed also when none of them are present,
> which is not what you want in such case.

Right, this should be oneOf instead of anyOf. I fixed that for v2.

> > listed as required and they are indeed mandatory by the Linux
> > kernel implementation.
> >=20
> > The old binding also has this:
> >=20
> > hsi-mode:		May be used ***instead*** hsi-rx-mode and hsi-tx-mode
> >=20
> > So it's either hsi-rx-mode + hsi-tx-mode OR hsi-mode, but not
> > all properties at the same time. That's what the allOf ensures:
> > if hsi-mode is specified, then hsi-rx-mode and hsi-tx-mode may
> > not be specified.
>=20
> Then wouldn't this work for you:
> https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetre=
e/bindings/reserved-memory/reserved-memory.yaml#L91

I suppose you mean using "then: not: required: PROPERTY" instead of
"then: PROPERTY: false"? The variant using "PROPERTY: false" is what
is being used in example-schema.yaml:

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindi=
ngs/example-schema.yaml#L225

IMHO the "not: required: property" is harder to understand. I would
expect that to mean "the property is not required (i.e. optional)"
instead of "the property is not allowed".

-- Sebastian

--yeqb2gbu3cd3r5gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYC5mkACgkQ2O7X88g7
+pookw/+Pk8sDVd/2OVqArL9SX+OsfGAfU13EfiTc7IofAwKSmoJWYpOAllEZZSO
AYjajSdUP2dCNA6p///aeYQWWBprdqEquthQqJo5XD7kOPoU1N9uOLiaRSNbizC6
TGzmcsrMWv/gHb72YgVrIcEdnmQ+md1ssnIwW70ZUW+piAlcAcvHoygZXrPk2nGa
lgBdraeg+jCIc3s+1g+rQR2Lr1EEvgAUGTnLHceEORpwsIkfq3UhOZfgtyVwWHiv
iF42GYBz6Jes+SO+YdB2hch8IrpoHjqjMUbmiZn9s/0QIHcHPl/EOQz8E6Blz557
4/L0X6cOMVffdhJ7lK3kaGVns1Bacgtw0pQs1RrZppG+ri+0s0nfPQA2WYzgcojy
t2/S5eopdtzbAWPYHcl26xvMUHxxY7RwhaSyWBNOFSr6O3V72juCT7uWDDisyXqu
tD8anKrqGiGa38JA6AXboqV8f+V7ijrs6cbZCTCtfBU+m5k/lR7GKz8Aaf9fuOad
QDniPipbNyfh3dbxirx7fOsRaMB42ncqpsxXkupzD1fEetPcq2qEWFgxo0eZr3Hk
V7kkqUvqorVGuk9n2F4ZW8S/Cw9VrSrNwWnpuRTslZUph4g23BGSHavHS/xcsgPn
oU+WIqjq7ylcMka7Er94D041Er7Mr2bqhAbuPdVStry8j265S7U=
=hn9F
-----END PGP SIGNATURE-----

--yeqb2gbu3cd3r5gn--

