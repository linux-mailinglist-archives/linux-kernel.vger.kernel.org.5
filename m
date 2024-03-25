Return-Path: <linux-kernel+bounces-117176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1688B519
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6596DC42BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA36F08B;
	Mon, 25 Mar 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgzynM+i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA23DABFF;
	Mon, 25 Mar 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374703; cv=none; b=gvcdXfL5dJil+ES/NuHWyHr5LjRy0ZNEDoRTu3YNocsfHO+kcWWoQTHUd+SKwEInUrY29JSKoVqcDajYtGEwtVTrV7MaXeHAfxZZwuafXCxjUFIesHU2clx8BMJPNM88X3awwZvnDyQgiiA/PcwNYNLSpQbSlORoYfk30rXrpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374703; c=relaxed/simple;
	bh=sWRUf5NqFmzvlkZmYGxNOda7857P8XXe2bjtpXWE5BU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rw7YSclNZ/88L2+ZZeN1vNENDrx0HC5ggBHpzm9WpRQBkkQeJx/wFYMH3rDMH2aIgwS22zIAolNnR78YZpkDlefFelzW1JaxCEBoM39nGIuS5o6EJkfeypMW9Mvbf0wkOoGH4ZdUmlOtq02rdYqxRf6k7WDTTAI7aloLjd4KF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgzynM+i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711374702; x=1742910702;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sWRUf5NqFmzvlkZmYGxNOda7857P8XXe2bjtpXWE5BU=;
  b=VgzynM+ihXaEiPN0ezpiCRLDsd+C0IWGJDcvwR5n6i9VPXTMnsbo66qA
   sEyD1hltun8m8rDMHXhw1E/uv2MglNuNmNbdbqRiCeCtXxo49HSHq+VsG
   ydhVIX6q5MxGu/2J+qE5Etwuh3MkM+hr/97rBMeAPu1kRpuajyMfqgtSc
   WWp3iBV/V9MEIz+phIrnFIqPtR4DMI57JfhfZ5Zt/LviCSG+vze2gNeK0
   cK8FmDVjrZPK/RX28wX0C5MFp3q2PI6ZhPAvi/HLuh+3IW/m9JycSB5/j
   Z8QsCdXeXKEwQHElt8DeN8/9CXzMm1R/ljoGUSYtsaXGn7ZxRZOzaTVV9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9340313"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="9340313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="38731615"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.19])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:51:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Mar 2024 15:51:32 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] platform/x86: asus-wmi: support toggling POST
 sound
In-Reply-To: <20240325054938.489732-5-luke@ljones.dev>
Message-ID: <4ed73fa3-0dfa-ae42-8f5f-b680dc49f782@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev> <20240325054938.489732-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-257940632-1711374692=:1020"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-257940632-1711374692=:1020
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 25 Mar 2024, Luke D. Jones wrote:

> Add support for toggling the BIOS POST sound on some ASUS laptops.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
>  drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
>  3 files changed, 63 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Document=
ation/ABI/testing/sysfs-platform-asus-wmi
> index 61a745d2476f..5645dbac4ce8 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -194,3 +194,12 @@ Contact:=09"Luke Jones" <luke@ljones.dev>
>  Description:
>  =09=09Set the target temperature limit of the Nvidia dGPU:
>  =09=09=09* min=3D75, max=3D87
> +
> +What:=09=09/sys/devices/platform/<platform>/boot_sound
> +Date:=09=09Jun 2023

2024? :-)

> +KernelVersion:=096.10
> +Contact:=09"Luke Jones" <luke@ljones.dev>
> +Description:
> +=09=09Set if the BIOS POST sound is played on boot.
> +=09=09=09* 0 - False,
> +=09=09=09* 1 - True
> \ No newline at end of file

Please add the new line.

Once those are fixed:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-257940632-1711374692=:1020--

