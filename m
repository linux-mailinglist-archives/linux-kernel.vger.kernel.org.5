Return-Path: <linux-kernel+bounces-122786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB988FD37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6371C27471
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65457D08F;
	Thu, 28 Mar 2024 10:36:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285E57895;
	Thu, 28 Mar 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622218; cv=none; b=a1huI4paDbTK3mHmgneluQmc9j+PkrxmrNou6wwRCo+yc06kC20Q5dO/t5QmAabpdDK4ncP+4+EafilIO3lKZUU4EuHGlDABHOnjCg+n531+LGeAUFOQmoAtCy4OHnh3Nygd6L+//temyqKSu/xYx34rfdPqG4pKuOMp0xvLW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622218; c=relaxed/simple;
	bh=1tLDjrlhyi2d5C+bucKg0yc9r5BN3QOnrP8/yaJXcjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsrdwAq85NlhqL95+DORUaXY9tW1rhR1UPBJ/A4IhNf5XB4B3mC3xa4b6TQMkfk2gxnnC72Z3CUCDWYOeR5WQPBHfV+MmSVFkfa191yy0WT0XwOfQ/Pf6eFEU1IMOMlfD8Axww+vIs8NMQTJWaTWrrgd3h/neYpTXULtDATOyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7CBB31C0081; Thu, 28 Mar 2024 11:36:54 +0100 (CET)
Date: Thu, 28 Mar 2024 11:36:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 6.1 212/451] iommu: Fix compilation without
 CONFIG_IOMMU_INTEL
Message-ID: <ZgVIRpCkWtJvEWnf@duo.ucw.cz>
References: <20240324231207.1351418-1-sashal@kernel.org>
 <20240324231207.1351418-213-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vZ6/CY6IfejnIZqG"
Content-Disposition: inline
In-Reply-To: <20240324231207.1351418-213-sashal@kernel.org>


--vZ6/CY6IfejnIZqG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 70bad345e622c23bb530016925c936ab04a646ac ]
>=20
> When the kernel is comiled with CONFIG_IRQ_REMAP=3Dy but without
> CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
> undefined reference to device_rbtree_find(). This patch makes sure that
> intel specific code is only compiled with CONFIG_IOMMU_INTEL=3Dy.

We don't have commit def054b01a8678 in -stable, so we should not need
this.

Best regards,
								Pavel

> +++ b/drivers/iommu/Kconfig
> @@ -192,7 +192,7 @@ source "drivers/iommu/intel/Kconfig"
>  config IRQ_REMAP
>  	bool "Support for Interrupt Remapping"
>  	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
> -	select DMAR_TABLE
> +	select DMAR_TABLE if INTEL_IOMMU
>  	help
>  	  Supports Interrupt remapping for IO-APIC and MSI devices.
>  	  To use x2apic mode in the CPU's which support x2APIC enhancements or
> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> index 7af3b8a4f2a00..29d26a4371327 100644
> --- a/drivers/iommu/intel/Makefile
> +++ b/drivers/iommu/intel/Makefile
> @@ -5,5 +5,7 @@ obj-$(CONFIG_DMAR_TABLE) +=3D trace.o cap_audit.o
>  obj-$(CONFIG_DMAR_PERF) +=3D perf.o
>  obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) +=3D debugfs.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) +=3D svm.o
> +ifdef CONFIG_INTEL_IOMMU
>  obj-$(CONFIG_IRQ_REMAP) +=3D irq_remapping.o
> +endif
>  obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) +=3D perfmon.o
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 83314b9d8f38b..ee59647c20501 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -99,7 +99,8 @@ int __init irq_remapping_prepare(void)
>  	if (disable_irq_remap)
>  		return -ENOSYS;
> =20
> -	if (intel_irq_remap_ops.prepare() =3D=3D 0)
> +	if (IS_ENABLED(CONFIG_INTEL_IOMMU) &&
> +	    intel_irq_remap_ops.prepare() =3D=3D 0)
>  		remap_ops =3D &intel_irq_remap_ops;
>  	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>  		 amd_iommu_irq_ops.prepare() =3D=3D 0)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vZ6/CY6IfejnIZqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVIRgAKCRAw5/Bqldv6
8gZYAJ0dAltTpDHidc4ImFcKiK5HNSKFhgCcCqMLqo5lIL5+3AZeO+JDJB4mEjE=
=FF3G
-----END PGP SIGNATURE-----

--vZ6/CY6IfejnIZqG--

