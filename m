Return-Path: <linux-kernel+bounces-59740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DE84FB1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B438282C46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58A7E78F;
	Fri,  9 Feb 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA4AD/8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78253398;
	Fri,  9 Feb 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500048; cv=none; b=oTWqU8nGJAXXEDHoSbYGFQuUP9gOnHlzuF8G2hyCNrwgLdRuBw9iqPGwgCggd1pC/zjlPHUAegVJHRZ42kTfy/R/hh/85sWfA6Jsg4DrOIE/rIsjaAVv48xi9Jn0ptNFiVgmzC7OVxlgEMhmPnkfL1hntc27tMbXHqZ6C5o31OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500048; c=relaxed/simple;
	bh=Yza2DHejlc9nZ8HXyQC6kyRUdGbbM+hTIoBQEh4Dp3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQLxD9w1TcAcnYyy0TboTMS1jPOiOLNFPmo50E5ZmrIoRqErF4MEsZ/tcmHa8zHmk5y+DnXcwXsrHEPQwmPnJBfobUrwgdVxLRJFNnSeWGsHco3WJx3pK1+Aon1XNg+qaoTCF58EDtx3Lb+uNSzs/WUh7KDR7yHpgJSvhaSb1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA4AD/8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98A1C433F1;
	Fri,  9 Feb 2024 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500048;
	bh=Yza2DHejlc9nZ8HXyQC6kyRUdGbbM+hTIoBQEh4Dp3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VA4AD/8ANvBLOkTh/VkHswws5LCvcuLPTAr6cpvxOjIGUZM53ioCsrMvGzJLRB+Pj
	 LFaWxO/w+ktj7FU4hxnlLJl143wWReDSRcWAMTLxQsDeZ3qfg5O0zTF1TnvD6bb7fx
	 5XFUw3E6xQiWGW4MdahgUwGtcsId5af5CV1+NNGi0DZfAFX82alRtZzo4FDhATm+ug
	 wXulFQIEnfd0wuvhO2GlTeM42Ks1NSyVp0DCrZMKwapOP0aDSlRZkhPtL7ZZZevH0k
	 AH2iPH5C1aF+dEBwNh6+i5hPTwGRRO4ZfEEcCcHQRBFHXLZjsErkEvUiHUeYdvivpf
	 eFmzQqKbhqUyw==
Date: Fri, 9 Feb 2024 17:34:01 +0000
From: Conor Dooley <conor@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	f.fainelli@gmail.com, kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
	kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 02/12] dt-bindings: mtd: brcmnand: Add WP pin
 connection property
Message-ID: <20240209-buffoon-cleat-e0dd67e0c5f7@spud>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-3-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4M4QCWMdx5AohHxN"
Content-Disposition: inline
In-Reply-To: <20240207202257.271784-3-william.zhang@broadcom.com>


--4M4QCWMdx5AohHxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 12:22:47PM -0800, William Zhang wrote:
> Add brcm,wp-not-connected property to have an option for disabling this
> feature on broadband board design that does not connect WP pin.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--4M4QCWMdx5AohHxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZiCQAKCRB4tDGHoIJi
0nJLAQDMWXmT4mt+4PLyrzHlfXj+/DY/gC5lCn/y4fANaTSyxQD7B96+TYnoxiye
7DIvvIa22KEP8wBY9LkJm8lH+0jRAQM=
=K+5h
-----END PGP SIGNATURE-----

--4M4QCWMdx5AohHxN--

