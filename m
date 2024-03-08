Return-Path: <linux-kernel+bounces-97149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC9876620
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E0E1F266A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8F43AAF;
	Fri,  8 Mar 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdeeycQr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF602381C1;
	Fri,  8 Mar 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907318; cv=none; b=P6wsLRkj4tk8NGeJPcBl0OHuYRbU69aOLW4lvSNReec9Ar4UCBUR/NcHc81ZQ2g27xIcK1vkGaJ0T1cltg0VTZ9V3fHpEqSpWdi53cUxk56mskfAMJFqW8h86CF4HBd4JQz4xCyKunfrO3v25gXMaU19yu7hrW9y5SByITx3aHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907318; c=relaxed/simple;
	bh=nnJa2eJuW3gIneCAKpj1Ao6WHMfBOJS01uvb6VF/qzs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OCw7emKKprpaz+TuzVpFV15v+iw+zkWqKJPeFBFnh7RVJWRTOmxzzK99nMBXtAdLHKJHwTHWonYSNYLNKSnskGDSGHjjBVyuSgVSZ5GszkCEjCDYQCToACS89MY9OM8URMUmkJQEMuqRMiIx6b3KLKqBS3wcElVhNATvVTyMV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdeeycQr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709907317; x=1741443317;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nnJa2eJuW3gIneCAKpj1Ao6WHMfBOJS01uvb6VF/qzs=;
  b=gdeeycQrQO5MrNoDxjXzqqJZi1e80RmiTZq8CTVgkqBHnaEp4pD7o6/c
   o80RXF0ZKEhbAsJHH4dqckSGhZUjxqQ5ATxH5kNffTmcgQANTdvDYfEIL
   GnBR87Rz1sp19loxURRo5XTDSLfUWsyWjpzYekyQvViaC6EGLrMqpCUhh
   YAO0PGx7u5SDWn6tumPgECL3CzfP2Vbv66Bkv18GtWoaqHMBOhZFJNsbw
   H/7BaEfj+NA0UpmxPWjQUStWHdu51nEPMbNA1TLtraSoYceIHFLej4wZh
   E9/jiWJVHptUjKSXnDPtN5AVSRx639GIBjAenV9RupVPBXPFhz+6olK0p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15765639"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15765639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41450832"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:15:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 16:15:08 +0200 (EET)
To: Richard Fitzgerald <rf@opensource.cirrus.com>
cc: broonie@kernel.org, tiwai@suse.com, Hans de Goede <hdegoede@redhat.com>, 
    lenb@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
    linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
    LKML <linux-kernel@vger.kernel.org>, patches@opensource.cirrus.com, 
    platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
    Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] platform/x86: serial-multi-instantiate: Add support
 for CS35L54 and CS35L57
In-Reply-To: <20240308135900.603192-4-rf@opensource.cirrus.com>
Message-ID: <ea3c3230-cdf1-c41f-47fd-8b47667f7c5c@linux.intel.com>
References: <20240308135900.603192-1-rf@opensource.cirrus.com> <20240308135900.603192-4-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2054902426-1709907308=:9765"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2054902426-1709907308=:9765
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Mar 2024, Richard Fitzgerald wrote:

> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> Add the ACPI HIDs and smi_node descriptions for the CS35L54 and CS35L57
> Boosted Smart Amplifiers.
>=20
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> This patch doesn't have any build dependencies on the ASOC/HDA code so
> can be take separately.

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/acpi/scan.c                           |  2 ++
>  .../platform/x86/serial-multi-instantiate.c   | 28 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e6ed1ba91e5c..091c501bed1f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1725,7 +1725,9 @@ static bool acpi_device_enumeration_by_parent(struc=
t acpi_device *device)
>  =09=09{"BSG1160", },
>  =09=09{"BSG2150", },
>  =09=09{"CSC3551", },
> +=09=09{"CSC3554", },
>  =09=09{"CSC3556", },
> +=09=09{"CSC3557", },
>  =09=09{"INT33FE", },
>  =09=09{"INT3515", },
>  =09=09/* Non-conforming _HID for Cirrus Logic already released */
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/pl=
atform/x86/serial-multi-instantiate.c
> index 8158e3cf5d6d..97b9c6392230 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda =3D {
>  =09.bus_type =3D SMI_AUTO_DETECT,
>  };
> =20
> +static const struct smi_node cs35l54_hda =3D {
> +=09.instances =3D {
> +=09=09{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09/* a 5th entry is an alias address, not a real device */
> +=09=09{ "cs35l54-hda_dummy_dev" },
> +=09=09{}
> +=09},
> +=09.bus_type =3D SMI_AUTO_DETECT,
> +};
> +
>  static const struct smi_node cs35l56_hda =3D {
>  =09.instances =3D {
>  =09=09{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> @@ -342,6 +355,19 @@ static const struct smi_node cs35l56_hda =3D {
>  =09.bus_type =3D SMI_AUTO_DETECT,
>  };
> =20
> +static const struct smi_node cs35l57_hda =3D {
> +=09.instances =3D {
> +=09=09{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
> +=09=09/* a 5th entry is an alias address, not a real device */
> +=09=09{ "cs35l57-hda_dummy_dev" },
> +=09=09{}
> +=09},
> +=09.bus_type =3D SMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to ignore_serial_bus_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -350,7 +376,9 @@ static const struct acpi_device_id smi_acpi_ids[] =3D=
 {
>  =09{ "BSG1160", (unsigned long)&bsg1160_data },
>  =09{ "BSG2150", (unsigned long)&bsg2150_data },
>  =09{ "CSC3551", (unsigned long)&cs35l41_hda },
> +=09{ "CSC3554", (unsigned long)&cs35l54_hda },
>  =09{ "CSC3556", (unsigned long)&cs35l56_hda },
> +=09{ "CSC3557", (unsigned long)&cs35l57_hda },
>  =09{ "INT3515", (unsigned long)&int3515_data },
>  =09/* Non-conforming _HID for Cirrus Logic already released */
>  =09{ "CLSA0100", (unsigned long)&cs35l41_hda },
>=20
--8323328-2054902426-1709907308=:9765--

