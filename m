Return-Path: <linux-kernel+bounces-46004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8D843920
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AA1C28FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7760ECB;
	Wed, 31 Jan 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e7I8vR8t"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD131605BC;
	Wed, 31 Jan 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689936; cv=none; b=VBxs4obNH1V4NTLywM2H/E5jNXxfM4KAWQZUeoFI38XLPebDyQzgEL6AsrkgK8r/OxTWdcTCAUWy8UcXsbjgN7agQuvwRxjX2w+TZh8Xckong1t1SWaQGjzWZPzNINN2NWWT1XA2QBb4M9S5QqljNqxkk1x+D73791jBjpE7m1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689936; c=relaxed/simple;
	bh=e7dvQjwqFRwb3yH8ZkmC8GnrowrIE8yR8j2TvVp4rFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR8OWMT4qF3VD7ZGPo2GgcWqCIJ9splr5X5SK1t6yqunCEAdbJr8FFBMuLWp4tp/e87MN1Kr+JvEXP5EIEN0K63IodF2251lAlULBXuzM5gIpivhnoTpgDn+fP0ZudNR5dTPTxpVoNq+T7FGO+DMH5z0dQovW0uXY/13oQbxZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e7I8vR8t; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V8W2jK036364;
	Wed, 31 Jan 2024 02:32:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706689922;
	bh=e7dvQjwqFRwb3yH8ZkmC8GnrowrIE8yR8j2TvVp4rFM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=e7I8vR8tNMj2NlPyfWEmx5YjCKhsswF1rWeZp6MyXAba4LyPRFjYoYmCieRKXPDQD
	 VY4C3ak8xkhVTLuTX4Qy2nE/Mdcp3QI9X80Lztv1ye0W3um0+gLG6s0qyIHQZS67el
	 LL74yOaxiwlTeR/eziyXHMklyJH7FwZQFkbeSO9E=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V8W2Ke000454
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 02:32:02 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 02:32:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 02:32:02 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V8W1xM096019;
	Wed, 31 Jan 2024 02:32:02 -0600
Date: Wed, 31 Jan 2024 14:02:01 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH 3/9] arm64: dts: ti: k3-am68-sk-base-board: Enable camera
 peripherals
Message-ID: <k57wzv77bhxuzowbmksxndjjle34almtdcub73dldgro3oowwh@veomcdtt4dkw>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
 <20240129132742.1189783-4-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6jcnme2yix7qaffo"
Content-Disposition: inline
In-Reply-To: <20240129132742.1189783-4-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--6jcnme2yix7qaffo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the patch.

On Jan 29, 2024 at 18:57:36 +0530, Vaishnav Achath wrote:
> CSI cameras are controlled using I2C. On AM68 Starter Kit, this is routed
> to I2C-1, so enable the instance and the TCA9543 I2C switch on the bus.
>=20

Can you Link: to the public schematics of the board here? (And on other=20
patches as well)

> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> [...]
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--6jcnme2yix7qaffo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmW6BYAACgkQQ96R+SSa
cUViUBAAy4nPtECzBOXadDK9PDCN02T/vdGHWloQreIB5H3eKBWQED2XtZmQEDEZ
bj2RhR15w1ss9NmLZOGF0/qA0GsqtRzf4awH9yAGwvDIgTEwSxD0Ykk/bqo86sH0
qszEJDJ2vQisQ2rCMMdp9U/sVXMCYYRYzmxt6FxX7sacy85pwHmEiTfcc6FMF8U0
alUubQ2+clKnvZXOdgbZKZsdAQg2fwatFe5xH+1ePg5NKagVBcRdy6pKdNt/3uio
W0TbXm4SZD3QagBNNNhktet/sfNChgPHasbQCmkobG6NmVMsayB78LK0RbOqKTlT
pEgb2MNKQ/LKP0IRyQR/aA1ipGDfRNeD4CeT3IJmVvJc8jdBVDuS5TxO50e+e0Fh
95M155nauH6NBV8dIz6y3T0n/IdL+y2+VGHbxe5kYfU3qUysvKANw+ymGHvNr1J0
xQYX/Ru4LnpsUKxJ9XatL5Ofag2lE3yVaGxSus70n4kIld0bPJ3gPv410OXJq5uV
P67eJb5pWBkd+RAZtTZ9T9EEyzqiUsa/ygDIC73CH2SRYLELe/zFzblmW/H2PefX
/y1C/h8NN4npwyWWRjKKDXgBLSg47ZrWq6mPbTBSYfc/01xfbqUXvnl+LfUiR800
tlnGcVNybEwUiCP/aa8ekOW5b8Bl8hQyoTYb5TS5q0TM4OuVRi0=
=vwtF
-----END PGP SIGNATURE-----

--6jcnme2yix7qaffo--

