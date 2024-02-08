Return-Path: <linux-kernel+bounces-57840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEB84DE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A389A1F21536
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCE6F51F;
	Thu,  8 Feb 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vcivM4Du"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24506DD0A;
	Thu,  8 Feb 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387570; cv=none; b=kZh8lg5jdBfG3bhIu2hnPBWhWIVQhMMefO3Dcteosxz1s+ZrB/4+wVFwe2pmbeSNRRto7Aq0gw/9RP9qE0j28CALC4Ly5WwdUEx+RNE0/6Rz6oTVOT8/oiI/+eL/McnW/HJ01fhijLFieia2PZt7VEqE4Ll969HadqsRMzilvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387570; c=relaxed/simple;
	bh=5EGlM5YOwcALeaeTgkO6F2JNxSXsi9yJNzTTepwwbZo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJnxJ2By9tvPuwCd+U+Hho8UmmSKwQceLxJ4bSx8hgjphpjnn2i0ciXBPk+x+ziLrMdA28ubpAxRf1z1JgCLX2yw87tPtYvoJAVCLQy5I0LvP305fv75srHD5xNPHOGJd6WpQYbwCDONOiMJ3yJp+J5/AaeKEbQeItXoYN2PaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vcivM4Du; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418AJI7m072928;
	Thu, 8 Feb 2024 04:19:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707387558;
	bh=Qo9xGSXl0Iz1vR/853cZxwu1Yhg0aA5HmZETv1GxNTo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vcivM4Duf0Y1w769TsC34zgscxgnvJDTnEK9hVstYiBb1eHLaB1c8/Gp2iuc+FBlB
	 OIBH0QNDp1JhtmOvB9p2lvNJXXkKfASJhwVKb2fTCyJAGLNC7VuinpGWbobCfyunfT
	 9sgqp4xeW76qWqS2KbpJsIE+aaPCP11ODjCwl8WY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418AJIWi009416
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:19:18 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:19:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:19:17 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418AJHmn035097;
	Thu, 8 Feb 2024 04:19:17 -0600
Date: Thu, 8 Feb 2024 15:49:16 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: ti: k3-j721e-sk: Add overlay for
 IMX219
Message-ID: <ldviqflcfc55gas3fwkldgdjrlcuiudr7iw5yutjqwsyhlr7fs@h3hbcypsukiw>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-10-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="46y5wbch5bdijdl4"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-10-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--46y5wbch5bdijdl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the patch.

On Feb 08, 2024 at 14:12:54 +0530, Vaishnav Achath wrote:
> RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69,
> J721E SK, and AM68 SK through the 22-pin CSI-RX connector.
>=20
> Add a reference overlay for dual IMX219 RPI camera v2 modules
> which can be used across AM68 SK, AM69 SK, TDA4VM SK boards
> that have a 15/22-pin FFC connector. Also enable build testing
> and symbols for all the three platforms.
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2:
>  * Rename overlays to indicate first platform (j721e-sk) supported
>    and dual camera.
>  * Add missed build test, fix missing newline.
>=20
>  arch/arm64/boot/dts/ti/Makefile               |  13 ++
>  .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 125 ++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.d=
tso
>=20
> [...]=20
>

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--46y5wbch5bdijdl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEqp0ACgkQQ96R+SSa
cUW/kRAAzCaqEsmOZOQOWg2lu/QNQEX41n5i5rkl3Ifb3m7ba0OB1S03NXnMQGaq
0UnTNwQjTR04NCONl8TzO/0qleW7nyyPNE6KXp9mM9RMTIuRtri/sZdoX5KeL59B
DDnepwXYywE/Xam8xTbF2TlGDnnBkzJg0YQ998gcPncyyveH53z1/ePN9JFuYEMR
Znigy2NnY6AEl01M7y2OGRsK/9YQ4QLQ10KuH+Ej6KerZoQIkBBfwOJnEWsVCtYF
b9+kKxD9i49R4FzDTp9pBLKgxrNX+cBterXWZoQZVfQ09dh7kfTR/NLE1flElYpx
DCJanMnd3V2CWCpNymCB7Fd0wQ7KMBmIa7gCRzpjf5XegrKqcSEqGN7yKoR2Kcrw
E0oMmAuYcac4By+xWxRjGlN8ec2F+7HDqj4meJE+G4jJttljoGaZy2eBS2QtiZ1h
3Y5MfMMv1heBNalk2NPN64dCnk8Mo4Q8Ea1NgDxZnlugs/Hztwk0QEgkL0tAdnk9
7+Y8ycxVjRm6W45jUjdoYjQAskHsjgNB+FqLi/XYBbxY26Gww09btecHlYG7CCPP
5i53PndF9bnJmLQzrGJ2ErhFjChYe3sJ80WV3HouDAhsbokeRNMUd423EZUygPfx
CEO38EGiWNibXKaM/z01H/MkyA1wjge2lCrTFZvrwlWGzy9zLyg=
=7qxK
-----END PGP SIGNATURE-----

--46y5wbch5bdijdl4--

