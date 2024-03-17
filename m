Return-Path: <linux-kernel+bounces-105427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399AC87DDBC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D04281452
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E31C694;
	Sun, 17 Mar 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvgYHoZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E041C28F;
	Sun, 17 Mar 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687897; cv=none; b=XIMvaMoRAWb9T1meI+es7evCKInwDf870yh/vmQQUMiYRwbgAr5Jyc/Hp95hrNq60iAmHVU7p7EKPPIQ1C5iDsguGK/A8DOafK2YRXz/fA9Q1InkXmvWjTc0N01pFdnxApUygJhN1FL106uNP82U9JyTbu4tKjC58BAOGfDNOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687897; c=relaxed/simple;
	bh=2ACXqSM+oORIh17fNVnxm9lOfm84HdVokhO3Uq3s6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6hQoHjrUie/smmjLfQWpo8Us33VNzNe1KmyCJbbgYBq2KUn763QyCa2A5ec6eYyTzB98J14m6hMneQBt/X+H5hiNXKlAwHBRxIbrP95Ykr35/q6TABHiP1aoz39Qa1TYb9nhzC9+d3YitDhGQXunayHvw4V9Knil1RKBL2wvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvgYHoZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC70C433F1;
	Sun, 17 Mar 2024 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687896;
	bh=2ACXqSM+oORIh17fNVnxm9lOfm84HdVokhO3Uq3s6/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvgYHoZeAUgL7baYLe8VFCYHkij2cmqS3IK210s4biuHcborS1d9cCZ1JDVUg0wA2
	 dMiYrA13I2YJWRANuKZ7yLQnkt4D78yLbQlCjSN/rVPQ9Y3QqpAll+cIaS0omoiuU0
	 w+uX8PBsLJUANfIJ2TImi7K70Z2xQppmqXl2kCXT+P3gOBoHWfcGuRaGiFy/ga/wb2
	 oUXCtdLpXRyWuIWUGiZ83fmqmbioNJ2TCHzXn1l8oIWy2gfD5B9Bs7TFbHvybTXRQu
	 g6phtAsyrA+x997zzrHoVMjyBwYWiFOqKpYDtAiy4BXgBCoYtow8S2DXycW/Gp8neN
	 vMbiSmAO2qPYg==
Date: Sun, 17 Mar 2024 15:04:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Joshua Yeong <joshua.yeong@starfivetech.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com, conor.dooley@microchip.com,
	alexghiti@rivosinc.com, evan@rivosinc.com, ajones@ventanamicro.com,
	heiko@sntech.de, guoren@kernel.org, uwu@icenowy.me,
	jszhang@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	leyfoon.tan@starfivetech.com, jeeheng.sia@starfivetech.com
Subject: Re: [PATCH 2/4] riscv: errata: Add StarFive alternative ports
Message-ID: <20240317-tighten-outskirts-de8c44f36853@spud>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240314061205.26143-3-joshua.yeong@starfivetech.com>
 <b662bb30-d5e2-4bf0-a156-ac38461fcea2@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JsseNBDqmI6dnw3W"
Content-Disposition: inline
In-Reply-To: <b662bb30-d5e2-4bf0-a156-ac38461fcea2@sifive.com>


--JsseNBDqmI6dnw3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 06:13:34PM -0500, Samuel Holland wrote:
> > +	riscv_cbom_block_size =3D STARFIVE_JH8100_L3;
> > +	riscv_noncoherent_supported();
>=20
> This patch doesn't add any alternatives, so you don't need to use the err=
ata
> framework. Please move these two lines to the cache driver -- see
> drivers/cache/sifive_ccache.c -- and then you can drop this patch.

And drop the patch adding the vendor ID too I guess, since that'll no
longer be used.

--JsseNBDqmI6dnw3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcGkgAKCRB4tDGHoIJi
0pDeAQDgdfT+icPw5jmJ78Y/pSrT5mWSE7Hy7N6+WitU8s1GIQEA/+eOnCRCllnP
bQBprzlW1VcvJbKHuRNXPc9l69MaXwg=
=JUfr
-----END PGP SIGNATURE-----

--JsseNBDqmI6dnw3W--

