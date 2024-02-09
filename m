Return-Path: <linux-kernel+bounces-59028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171B84F010
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324AE1C21180
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B15730A;
	Fri,  9 Feb 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kydLbQda"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEA56B9C;
	Fri,  9 Feb 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458563; cv=none; b=bArhUpLOVLjA1QJEOJ/8HiX21v4kIRGJWZmdr8ogxqNy69DVJAhDNrWmT/e3ySwHovH22odnoxId07w/tjUuRJcI8jC3mQz27h3tr86WQjRTi0W13qyMB0+UUOeRzngwF+hvQXtp8a2Jan+TPSqvPYlyS9C7gQIamTpOqYVwiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458563; c=relaxed/simple;
	bh=szX8eFJAacIfaBOgqdKvm7cxElN3CLEnmLKKfivmq2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksAlPlfKWyy8yMHriKvKWcPrJFUKzFVV/v/DF6nnWBg0bd+dNDOxc7Il7hK8zks9PP3ZBAwLY6dUHkcXhe1D0g3QcW0mPleD0qpgJVAYBofwBNa9ceyDhMScg0WwtKPkfY7s/Zp+XMKYjYZ8kO+oBgDNWPL4L59SGoAM9876x8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kydLbQda; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41962QTd091223;
	Fri, 9 Feb 2024 00:02:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707458546;
	bh=DnAyyWcmIIDan51Z+JSMzQK6srTSZ0Y/OtGsY8wjLnk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kydLbQdaMj0qOPsmf/1FvQkLyMISJgE16x65CZ68KGHiANF/s1pHILFRMyuab4e4z
	 aWFCWopjl/0YHNZ7ZvlqRvXHoWSgbzSKt8L3hWnyzt1ZCTaaDnq2cXFc5ahTes+aoa
	 oZje9VuMW4z/TETF/XrLwGgnG2a7QX7b2+ujJfLY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41962Qvk079242
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 00:02:26 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 00:02:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 00:02:25 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41962ObR085567;
	Fri, 9 Feb 2024 00:02:25 -0600
Date: Fri, 9 Feb 2024 11:32:24 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v3 6/9] arm64: dts: ti: k3-j721e-main: Add CSI2RX capture
 nodes
Message-ID: <5ajmkzqje7vdpmzduyjnjdcqoux2fcs3aonfkf5424h3ickzkr@gdvs64lsqtxm>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
 <20240208123233.391115-7-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zqmqrxodl4hoilzg"
Content-Disposition: inline
In-Reply-To: <20240208123233.391115-7-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--zqmqrxodl4hoilzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 18:02:30 +0530, Vaishnav Achath wrote:
> J721E has two CSI2RX capture subsystem featuring Cadence CSI2RX,
> DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
> keep them disabled by default.
>=20
> J721E TRM (Section 12.7 Camera Subsystem):
> 	https://www.ti.com/lit/zip/spruil1
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-By: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V2->V3: Fix order of properties as per dts coding style.
> V1->V2: Update commit message with TRM.
>=20
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 122 ++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>=20
> [...]

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--zqmqrxodl4hoilzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXFv+sACgkQQ96R+SSa
cUXI3w//SrC0kOxrTV2kQUhOVKGhjPgqbnf6/pvn8mK3162oszfS8eMy6fxttiGd
MTHqhh5xbp08HmqqTueAE3MGjeJHzCuWfmImxq4yszVtdVtb7uEseVOjVdeHk7Bk
lgHFVbOn3kkfvTKJQHxix8L9BFuOUPyooAtOGAFoaAAxJ9F0AD2nSGVskq76H0ng
O3X4aIZov+PufuUtITr4vQ6LNPgHggjgD2UbnxHrayFdF/LThi+IFbwBKV1V+SHl
dB1hgg49A22CEF8Uylc3V+2QyH5Qw2QnFSRd3+U2mG88ndAWt0swJdnciIrPtAVQ
sDHEhmANFLrSKWtB6FW4dQ6HEVI0KAuDHtG7Z1cm60qYwU62BDWYIVG0ktnnk3AA
SB0w2K0coe0x2cNoTfWMZb00wBXpzzHVKqUc38B3DSz/dXFTKcgByLaPfdoONprH
rLpGyQRglMrGgvB+0p22OkW/rPVr1ZKu9eSTvAUYU3RUAeD45owGroo1TJ5s/a2F
37FjE23a/H9eKP8+TCJ9HEH5qVQHn/pft8vSe3/Jxu0DkM5LjZd2Rrthpwc2Z0yI
rOkoX3jjnZTmwwNFmz2CowaBcaUC2eG2efUxMfRUZhSnaRlH/vL8FR2ju9sS1yDA
WsnxhxHcc4bqheL2kHd2IpZCUjiKQ/2smh8ZtMYXav0b5QrTMR4=
=X44F
-----END PGP SIGNATURE-----

--zqmqrxodl4hoilzg--

