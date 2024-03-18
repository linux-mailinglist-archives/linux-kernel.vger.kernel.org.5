Return-Path: <linux-kernel+bounces-106078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0D87E8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D39EB23D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E137147;
	Mon, 18 Mar 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx+K0CQI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C22EB05;
	Mon, 18 Mar 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761514; cv=none; b=ZWSrNUzC+Ld2BptUwYAx8UI9Kf0SyXT9MJFj4txjL6A6Vh1QtodCTyNWNba3ZwEf05nolE8sxiSACNO50TPQWF0QFeEtGj6RDK8emgwUGgXGomFcjb4OPqKdb0jwuf8cfsNZ5gWF5DC8R+KMDEuLZMsxqWbaWQU9/buIDyUQx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761514; c=relaxed/simple;
	bh=1BYULFfpmrtdt5zSdHz7afbD+gWoM76bjV/mS7ORSuc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UWhXiawW7tR5vtUaeaaKsn4NEuiqbc1ghrPZ3TqkdE51yAnoCv0wfzzR/RvM9Du3cf4RSpx6+l9akyt4a82wDIhk70VeY5T6hY/dYJAerVOBF3VMy59Auzswq0XpLMHAyCXyIrN6k7JT5tp2sAcVBjYEAouo4XoZzp3/bB8NA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx+K0CQI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710761513; x=1742297513;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1BYULFfpmrtdt5zSdHz7afbD+gWoM76bjV/mS7ORSuc=;
  b=jx+K0CQI1i7bGcE3cxe3wLTs1Gj631A+v5ppVJMVs6f16A39Ufgn5Q8d
   jf6R5IMvi9xTrq/RzEF3Z1nLkbY1pUnpYuLtpeKovAVU3sv0C9RgoWtXM
   O4xVtX3ceQpJsNAPV4sWYPxi+mkKwVlQ6n8K0GdCrngV6IKmzVi2yJMy3
   +l+J/RmVceWFB4TWbIRqEYUfVXdPJ9FVPzkjE508SVED/cb9jjH4ZGI/G
   c30y6AKzCEFlrt/avTfXjhnQNzAx7pb+FPfglWWzHTSB99xVxTEwJd1p+
   eKmOi46svwgd6ABm8JT23gRg+5LsDl1wrduDPp6h7v7h1RA37MONSLwtL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5401772"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5401772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 04:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18117243"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.11])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 04:31:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Mar 2024 13:31:40 +0200 (EET)
To: Nikita Travkin <nikita@trvn.ru>
cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
    Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/4] platform: Add ARM64 platform directory
In-Reply-To: <20240315-aspire1-ec-v5-2-f93381deff39@trvn.ru>
Message-ID: <0634bc80-f149-e75a-40fa-03841d8e9161@linux.intel.com>
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru> <20240315-aspire1-ec-v5-2-f93381deff39@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1606358534-1710761500=:1041"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1606358534-1710761500=:1041
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Mar 2024, Nikita Travkin wrote:

> Some ARM64 based laptops and computers require vendor/board specific
> drivers for their embedded controllers. Even though usually the most
> important functionality of those devices is implemented inside ACPI,
> unfortunately Linux doesn't currently have great support for ACPI on
> platforms like Qualcomm Snapdragon that are used in most ARM64 laptops
> today. Instead Linux relies on Device Tree for Qualcomm based devices
> and it's significantly easier to reimplement the EC functionality in
> a dedicated driver than to make use of ACPI code.
>=20
> This commit introduces a new platform/arm64 subdirectory to give a
> place to such drivers for EC-like devices.
>=20
> A new MAINTAINERS entry is added for this directory. Patches to files in
> this directory will be taken up by the platform-drivers-x86 team (i.e.
> Hans de Goede and Ilpo J=C3=A4rvinen) with additional review from Bryan
> O'Donoghue to represent ARM64 maintainers.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

And big thanks for Bryan for volunteering!

--=20
 i.

> ---
>  MAINTAINERS                     | 10 ++++++++++
>  drivers/platform/Kconfig        |  2 ++
>  drivers/platform/Makefile       |  1 +
>  drivers/platform/arm64/Kconfig  | 19 +++++++++++++++++++
>  drivers/platform/arm64/Makefile |  6 ++++++
>  5 files changed, 38 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b3714710c2..186338451099 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3050,6 +3050,16 @@ F:=09drivers/mmc/host/sdhci-of-arasan.c
>  N:=09zynq
>  N:=09xilinx
> =20
> +ARM64 PLATFORM DRIVERS
> +M:=09Hans de Goede <hdegoede@redhat.com>
> +M:=09Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> +R:=09Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +Q:=09https://patchwork.kernel.org/project/platform-driver-x86/list/
> +T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-dr=
ivers-x86.git
> +F:=09drivers/platform/arm64/
> +
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:=09Catalin Marinas <catalin.marinas@arm.com>
>  M:=09Will Deacon <will@kernel.org>
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index 868b20361769..81a298517df2 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -14,3 +14,5 @@ source "drivers/platform/olpc/Kconfig"
>  source "drivers/platform/surface/Kconfig"
> =20
>  source "drivers/platform/x86/Kconfig"
> +
> +source "drivers/platform/arm64/Kconfig"
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 41640172975a..fbbe4f77aa5d 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_OLPC_EC)=09=09+=3D olpc/
>  obj-$(CONFIG_GOLDFISH)=09=09+=3D goldfish/
>  obj-$(CONFIG_CHROME_PLATFORMS)=09+=3D chrome/
>  obj-$(CONFIG_SURFACE_PLATFORMS)=09+=3D surface/
> +obj-$(CONFIG_ARM64)=09=09+=3D arm64/
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kcon=
fig
> new file mode 100644
> index 000000000000..644b83ede093
> --- /dev/null
> +++ b/drivers/platform/arm64/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# EC-like Drivers for aarch64 based devices.
> +#
> +
> +menuconfig ARM64_PLATFORM_DEVICES
> +=09bool "ARM64 Platform-Specific Device Drivers"
> +=09depends on ARM64 || COMPILE_TEST
> +=09default y
> +=09help
> +=09  Say Y here to get to see options for platform-specific device drive=
rs
> +=09  for arm64 based devices, primarily EC-like device drivers.
> +=09  This option alone does not add any kernel code.
> +
> +=09  If you say N, all options in this submenu will be skipped and disab=
led.
> +
> +if ARM64_PLATFORM_DEVICES
> +
> +endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Mak=
efile
> new file mode 100644
> index 000000000000..f91cdc7155e2
> --- /dev/null
> +++ b/drivers/platform/arm64/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for linux/drivers/platform/arm64
> +#
> +# This dir should only include drivers for EC-like devices.
> +#
>=20
>=20
--8323328-1606358534-1710761500=:1041--

