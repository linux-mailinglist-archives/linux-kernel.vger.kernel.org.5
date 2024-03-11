Return-Path: <linux-kernel+bounces-98935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481F87813A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CA41C22F30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FC3FB3E;
	Mon, 11 Mar 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKqI55Gs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A463FB84;
	Mon, 11 Mar 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165817; cv=none; b=AHLzTmqLNjsPFINDM/zrI/MoZigFU1STqrPqnNr+IB2jbVThwz2cMXqo8qPSVy1UzmNv6HIGbk2JSsszkrT4AEl1Eil+17j2bxSqoTigU75DC5Iva7TYfPwr1/69cm23TlarUZ80jz6qNXdlndRRA5Y8j+J8OzkbYLKEmk9M9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165817; c=relaxed/simple;
	bh=+faj2acv6Tj9q/RzQhyGQXkzPMchgaGd3MF2eJayovg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U9fvt6fGTInuaO3rqoUcF87rLsuujzDsBtpGHDrFmm2D0IiVJjSsuj92MkEnO6troRWC4ONLhNNPFflLwZdg3GVbnQzyqttTATxyKEz/VBXpUY4Z+IwqD4aMTPqBlSf8xhakV3mfjSXULK6GuwNNIHYsKDfSol62U/OX0bCOuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKqI55Gs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165816; x=1741701816;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+faj2acv6Tj9q/RzQhyGQXkzPMchgaGd3MF2eJayovg=;
  b=AKqI55GsbUvecPZPKObg2b3/Qbxra0XIPLWqbdhQzEn8AM6gjVvJ/Rv2
   VcVs0i8oWSAL+wHPjXuXSt5LalUVJWPN0U7Wg2IQHOwCUVGRhUnNNP8iX
   a0129XqAxfRc+AQg206CCSMhcjgIylppvh+riyzng3ph/R1hujdFlyv28
   ads0sGe8yknhb/sdRjuzW6vbVOd2GQlTganTED2PDU55X8eSASTcVyHfO
   mgH/q1jDgZLT8T33ywQOh1vxNao2ov/q3AAytzw4PIQmFx5k6fnS7IOFg
   PKpshMkkxjkBxJ12yP7zEwEHR9G39CkUs1MX84TLJCcUXFgJwxsHJKe9w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15558722"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15558722"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15881729"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:03:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 16:03:26 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    mario.limonciello@amd.com, linux-acpi@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16
 bit EC values
In-Reply-To: <20240308210519.2986-1-W_Armin@gmx.de>
Message-ID: <891f6a46-fb6c-b366-d17e-64d26cb6f4a2@linux.intel.com>
References: <20240308210519.2986-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1630043217-1710165727=:1071"
Content-ID: <33cd499f-81af-71ff-1443-6bca370db796@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1630043217-1710165727=:1071
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <10258b74-3c1e-59a9-6f5f-a79e282eec5b@linux.intel.com>

On Fri, 8 Mar 2024, Armin Wolf wrote:

> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is prefectly legal
> according to the ACPI spec.
>=20
> Add support for reading/writing such values.
>=20
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v3:
> - change type of variable i to size_t
>=20
> Changes since v2:
> - fix address overflow check
>=20
> Changes since v1:
> - use BITS_PER_BYTE
> - validate that number of bytes to read/write does not overflow the
>   address
> ---
>  drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..d9bf6d452b3a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, s=
truct platform_device *pdev)
>  =09return 0;
>  }
>=20
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +=09size_t i;
> +=09int ret;
> +
> +=09for (i =3D 0; i < bytes; i++) {
> +=09=09ret =3D ec_read(address + i, &buffer[i]);
> +=09=09if (ret < 0)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +=09size_t i;
> +=09int ret;
> +
> +=09for (i =3D 0; i < bytes; i++) {
> +=09=09ret =3D ec_write(address + i, buffer[i]);
> +=09=09if (ret < 0)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
>  /*
>   * WMI can have EmbeddedControl access regions. In which case, we just w=
ant to
>   * hand these off to the EC driver.
> @@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_phys=
ical_address address,
>  =09=09=09  u32 bits, u64 *value,
>  =09=09=09  void *handler_context, void *region_context)
>  {
> -=09int result =3D 0;
> -=09u8 temp =3D 0;
> +=09int bytes =3D bits / BITS_PER_BYTE;
> +=09int ret;
> +
> +=09if (!value)
> +=09=09return AE_NULL_ENTRY;
>=20
> -=09if ((address > 0xFF) || !value)
> +=09if (!bytes || bytes > sizeof(*value))
>  =09=09return AE_BAD_PARAMETER;
>=20
> -=09if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
> +=09if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>  =09=09return AE_BAD_PARAMETER;
>=20
> -=09if (bits !=3D 8)
> +=09if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
>  =09=09return AE_BAD_PARAMETER;
>=20
>  =09if (function =3D=3D ACPI_READ) {
> -=09=09result =3D ec_read(address, &temp);
> -=09=09*value =3D temp;
> +=09=09ret =3D ec_read_multiple(address, (u8 *)value, bytes);
>  =09} else {
> -=09=09temp =3D 0xff & *value;
> -=09=09result =3D ec_write(address, temp);
> +=09=09ret =3D ec_write_multiple(address, (u8 *)value, bytes);
>  =09}
>=20
> -=09switch (result) {
> +=09switch (ret) {
>  =09case -EINVAL:
>  =09=09return AE_BAD_PARAMETER;
>  =09case -ENODEV:

Seems okay now, thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1630043217-1710165727=:1071--

