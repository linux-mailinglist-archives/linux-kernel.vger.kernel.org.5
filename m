Return-Path: <linux-kernel+bounces-57852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33684DE37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494771F25D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4B73162;
	Thu,  8 Feb 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oTJZT3wJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA771B55;
	Thu,  8 Feb 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387806; cv=none; b=DOjXTg3btDAFERr4co2xN8w2MabKVNq3BWUQsyoi/wDEVrai8c6oHVlqVWC1vwCSe3PCTCft2To+708Jf6dbLAdYw/KsYcEqGbbU7wGjfoLVMIy6Tr603Pl3/X8wxS6BmomVlu9QmHCak+r+FnANfdBSKlPV7jlSelDeq5XBrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387806; c=relaxed/simple;
	bh=HHxOZSqLhFEFjU32vRAU1aaThOngPEB4N9dPQw3y02g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsOVmTZVpJtTjuQofTkLdcmuoVT/zbRfmbMv5sO20/b/CoGTmQEnZriNyG8FJTw3Z7bw60V+YlhWIF9BHhR6X/a6qDg8q3YhzKJxD+VQJuDxMJZvo8zNCRpUf8q7T9P1z+BVKryxUapZmvKB1LSooeFnXuUqAjbEIJkUeJeDSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oTJZT3wJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418ANApG041012;
	Thu, 8 Feb 2024 04:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707387790;
	bh=6KrYVo5sviQLVXLRbneRGOJWjnpQPqAAJLGAYoF/zoI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oTJZT3wJoY+LSi0V2weTuphOK5+GiRRK+tHrN0j8KFhAbgy7moafx49QmZt/rBeWe
	 WFclKxAC3fyjwXOqgGP6/covmxYfOKBQ2n0oOGH/H9YaGYKeshDsbcUXnK+m69KxGB
	 RD7bcIaieccBmXjaINGmcWRWkcF0yyKAwfKS/NDE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418ANAwv007580
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:23:10 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:23:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:23:10 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418AN9JT039825;
	Thu, 8 Feb 2024 04:23:10 -0600
Date: Thu, 8 Feb 2024 15:53:09 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 1/9] arm64: dts: ti: k3-j721s2-common-proc-board:
 Enable camera peripherals
Message-ID: <sdzlljxyxhfffddg6iyviwv7idivknwsauqzs73fmcpmi3zvvi@ymeshye735pz>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-2-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fqql4kl7kt4b6uhi"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-2-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--fqql4kl7kt4b6uhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 14:12:46 +0530, Vaishnav Achath wrote:
> CSI cameras are controlled using I2C. On J721S2 Common Processor Board,
> this is routed to I2C-5, so enable the instance and the TCA6408
> GPIO expander on the bus.
>=20
> Common Processor Board schematics: https://www.ti.com/lit/zip/sprr411
> J721S2 SoM schematics: https://www.ti.com/lit/zip/sprr439
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2: Update commit message with schematics.
>=20
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--fqql4kl7kt4b6uhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEq4wACgkQQ96R+SSa
cUVukA/8CEHRoXzodltihBSfC31UcIsBT8N3lxXO4j5Bv5prGLqYMFskSIGAvNaE
pZ1GRdBUYMeDj0pcex8W6xRwM/VUXdwWWxdN6GKQE7cBPvibrl+MwRFBFTzQ1+7X
otMkdodXrJ9ybqH2Db3PZBmJz9+53McukfAJ3a1LFk24lliKuUgZjF/fdraLOuKZ
oCzdbveI2zkV8+aFecTaRmcDgCbYF2mYxN+3s4GRx67H552U0cECD4Azo4Wtlu/t
risOxIjbAwQoMrzIRdITEpHBu79b2XQjUIGORozxUW+EctaPkC2BN00aRA5knDiV
y4Vl8paTxUODGIQmswWHoHFwCL/gGkrs40dU/a7eHleBYAq+lNP1/wgPzLLblTKe
qOEfIyhvmWgEZPwDAGdoFdXlceKLvYy+xYx59vHhx9tjfqJYQs9SvsOxz3hfgvWT
BS8ndHxVfSXT5W+d6SkJyLyY0K429HetZjDUIC38uzBdl6/gscu5FgDBCrQGTpem
xphDby90R7sApqSy+V/rJWQkL9NzsgTAOo/HRQHWF7sSIEpU8YLy3/y3br0+Lq2q
uZRLAJvd+vz56ZXvV274EayiSQ8A5tbZM3ccamFHsuKFdM509pKrilzyoS4uxank
nJ/KAICnD94ClvWevg2x3Ui4pLXMLMLDh7D4q9J9elJX7vBtt1w=
=J6/L
-----END PGP SIGNATURE-----

--fqql4kl7kt4b6uhi--

