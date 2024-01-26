Return-Path: <linux-kernel+bounces-40027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22883D8F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93A51F240A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6397317BC9;
	Fri, 26 Jan 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tUZOnj4o"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCC17BBB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267077; cv=none; b=SPs8sNVjD1qk81Wsz3OE00Z2ofNRSCF6k10kb9xVFoWzH0ZOx2wnZWGz0DH7ZbmiqMtlgcPauau5PopjhJ9DbCqTumYS1JtSoN8Bm6VcjC6JToVOE9ySqEYkQ3FDdAJvXw/cVGFBPfutHbzV8rLHxxDiUlTsYnWwvkqljgiQkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267077; c=relaxed/simple;
	bh=jx7CiBYDVCqrDkciTRY0aAvyzz7PnM5XKaphvWRKpig=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2vum/1pGKzZK5yEctOUHfF+Kq0RD3C+VzQALlj7qcBhhyn6S/zr9frP7r24QPDR9FmWSiYmBGaz9cqLtjbRJo/mytZUaLxkVnF4EyFjouLqSyh89GZeHcdNVyxFvQ1GXdvgVcKMlGS8W292GSpkcIXpocFgqQkuXXNu8N08f4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tUZOnj4o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706267075; x=1737803075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jx7CiBYDVCqrDkciTRY0aAvyzz7PnM5XKaphvWRKpig=;
  b=tUZOnj4oT4qLbgnN3oVovdfz7LPkQbSNLVcdAXXS6hnCyiNFsZiRnVql
   YK3t19qAR87XBkR+FqZxWVE+xRTyWCibwmHxm9cty9nh5P00hoWxZRAFB
   64O4nvCVKS4RqoijrztxaPORk7LQT2OqaKk3lJjoRSR9LUw2y9TPARLka
   xhuZPTTEubRTtSGloAEOMUIzA1xpB5FQpEAiyPF/NocRiWLW7rt3ZixuK
   f05hxzRachgxgX5LZmplqezNrMqrfYMN74UqrrdhaEaho1Vgah2hnvOkh
   3NwszYwfo8xfWJkLlLq586EbKrzXfSu1bscfgzvn9hvEbGBUqV3V3++w2
   A==;
X-CSE-ConnectionGUID: 6eBUXNTyR7KfhA1fl2aXag==
X-CSE-MsgGUID: Ee6Wkf+rQaGF9yMlSWl0fw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="182583881"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2024 04:04:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 04:04:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Jan 2024 04:03:59 -0700
Date: Fri, 26 Jan 2024 11:03:22 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
	<conor@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Setup proper info for SOPHGO vendor support
Message-ID: <20240126-squabble-vitally-7dea14d09e18@wendy>
References: <IA1PR20MB49534A5DE79A6CEE57301737BB792@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DY8XnBB7u1R3xie9"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534A5DE79A6CEE57301737BB792@IA1PR20MB4953.namprd20.prod.outlook.com>

--DY8XnBB7u1R3xie9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 02:04:50PM +0800, Inochi Amaoto wrote:
> Add git tree that maintaines sophgo vendor code.
> Also replace Chao Wei with myself, since he does not have enough time.

Ideally Chao Wei can spare some time to ack the patch though?

>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  MAINTAINERS | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39219b144c23..0dbf2882afbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20446,12 +20446,13 @@ F:	drivers/char/sonypi.c
>  F:	drivers/platform/x86/sony-laptop.c
>  F:	include/linux/sony-laptop.h
>=20
> -SOPHGO DEVICETREES
> -M:	Chao Wei <chao.wei@sophgo.com>
> +SOPHGO DEVICETREES and DRIVERS
>  M:	Chen Wang <unicorn_wang@outlook.com>
> +M:	Inochi Amaoto <inochiama@outlook.com>
> +T:	git https://github.com/sophgo/linux.git
>  S:	Maintained
> -F:	arch/riscv/boot/dts/sophgo/
> -F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
> +N:	sophgo
> +K:	[^@]sophgo

There's a single instance of this "[^@] business in the whole file,
is it really needed?

Also, you can fold in

diff --git a/MAINTAINERS b/MAINTAINERS
index bf107c5343d3..cc8e240ba3e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18859,6 +18859,7 @@ F:	Documentation/devicetree/bindings/riscv/
 F:	arch/riscv/boot/dts/
 X:	arch/riscv/boot/dts/allwinner/
 X:	arch/riscv/boot/dts/renesas/
+X:	arch/riscv/boot/dts/sophgo/
=20
 RISC-V PMU DRIVERS
 M:	Atish Patra <atishp@atishpatra.org>


if you want. I get CC'ed on everything under the sun anyway from the DT
MAINTAINERS entry, so this at least might reduce some confusion about
who is applying what.

Cheers,
Conor.


--DY8XnBB7u1R3xie9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbORegAKCRB4tDGHoIJi
0o7lAQCfWgxp84MYKF22AxVE/ZMMz+9HojI/9GCvPUisSPxQAgEAr+M7AeqQ2hGX
zozyhua2Z0siLUnr9X9T5ExJ5cab+AA=
=8eIM
-----END PGP SIGNATURE-----

--DY8XnBB7u1R3xie9--

