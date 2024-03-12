Return-Path: <linux-kernel+bounces-100186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348F879345
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA959283536
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0279DA6;
	Tue, 12 Mar 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi5T1MoQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEF7828D;
	Tue, 12 Mar 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243935; cv=none; b=MCpnWhH7z2tM/Ij974dUBCUG3AIc0mS8Zi422f9I3evGzxrTOCRG/9qmAOnSKEEfTpG0Yy359vmk5DKibnrE16RzYvIlUz8om7JbxAq5/2gxHB96tl65qUroHYslkLh0H8gDN/cg32mLVOQWeCIsGvxo5nx1BlbpJVegUOqk5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243935; c=relaxed/simple;
	bh=F/hi5nNET23hU/nf7PqKIwSnpCC0q5TtzdghNZoSCv0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RLt48r1e/dcDo5cKpjCkpebMqK/z4nr/DJtE0L4forATx38ndqiwT+kRujUUA/4K0142wfUziz/tiq2HldmA0PFm7Qo15sq+gzAMYEuDzaCxAmXQixtLPC3MbVJFWNdppnzYQ529RWnCS7l5hpvnGuEi4bw/Q0+3t0kA3QrtEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi5T1MoQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710243934; x=1741779934;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F/hi5nNET23hU/nf7PqKIwSnpCC0q5TtzdghNZoSCv0=;
  b=Xi5T1MoQPNhhtRCjVWxpSmLweS233wzz6N7N1efnN9hfDMKGf3tp/N+9
   EE0hjATJTPOPqR0yScwZhx4Beb3YF4X+XTFyRB1sgQyqPeOvINo428lID
   ZTCTCOfd31QlOCdzHAKXQNUk+Tx6mjyWKyaP2VXfgkJkRpwAqTzJ+oFbH
   stejj0JaxJp2NAOPdI7fXWglxweVBPoK2PewmTvO7AQvgk0nhpQf5Cmk1
   yWh+cblSo0HSCIVm59k30tCJqa+KDVaSgatzm++XG+l8LEnnh7xyrIv1T
   MCiD/EhCjZiWWMQi8it11YFkyxp1hzKDcZevxTzHbHAx5qcYSn7bGTBIK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15585025"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15585025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:45:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11591435"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:45:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 13:45:25 +0200 (EET)
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
cc: Nikita Travkin <nikita@trvn.ru>, Hans de Goede <hdegoede@redhat.com>, 
    Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
    Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] platform: Add ARM64 platform directory
In-Reply-To: <5d4434fc-862e-4430-a2a0-758887d7596d@linaro.org>
Message-ID: <cc8c8b42-1f6e-3b2c-0e1a-b71b57ab43c8@linux.intel.com>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru> <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru> <5d4434fc-862e-4430-a2a0-758887d7596d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-652033754-1710243925=:1770"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-652033754-1710243925=:1770
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Mar 2024, Bryan O'Donoghue wrote:

> On 12/03/2024 08:42, Nikita Travkin wrote:
> > Some ARM64 based laptops and computers require vendor/board specific
> > drivers for their embedded controllers. Even though usually the most
> > important functionality of those devices is implemented inside ACPI,
> > unfortunately Linux doesn't currently have great support for ACPI on
> > platforms like Qualcomm Snapdragon that are used in most ARM64 laptops
> > today. Instead Linux relies on Device Tree for Qualcomm based devices
> > and it's significantly easier to reimplement the EC functionality in
> > a dedicated driver than to make use of ACPI code.
> >=20
> > This commit introduces a new platform/arm64 subdirectory to give a
> > place to such drivers for EC-like devices.
> >=20
> > A new MAINTAINERS entry is added for this directory. Patches to files i=
n
> > this directory will be taken up by the platform-drivers-x86 team (i.e.
> > Hans de Goede and Mark Gross).
> >=20
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >   MAINTAINERS                     |  9 +++++++++
> >   drivers/platform/Kconfig        |  2 ++
> >   drivers/platform/Makefile       |  1 +
> >   drivers/platform/arm64/Kconfig  | 19 +++++++++++++++++++
> >   drivers/platform/arm64/Makefile |  6 ++++++
> >   5 files changed, 37 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b43102ca365d..ec8d706a99aa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3050,6 +3050,15 @@ F:=09drivers/mmc/host/sdhci-of-arasan.c
> >   N:=09zynq
> >   N:=09xilinx
> >   +ARM64 PLATFORM DRIVERS
> > +M:=09Hans de Goede <hdegoede@redhat.com>
> > +M:=09Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > +L:=09platform-driver-x86@vger.kernel.org
> > +S:=09Maintained
> > +Q:=09https://patchwork.kernel.org/project/platform-driver-x86/list/
> > +T:=09git
> > git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git
>=20
> Surely some sort of Arm specific mailing list should be added here ?
> platform-drivers-x86 for arm64 platform drivers standalone, makes little
> sense.
>=20
> Perhaps for each new SoC class added - you could add the appropriate mail=
ing
> list linux-arm-msm is suspiciously missing from the list even though the =
only
> driver that will live in this directory after this series is a qcom based
> device.
>=20
> And if tomorrow someone added a Rockchip based EC controller then you'd a=
ssume
> the rockchip mailing list should get a ping.

While generic arm mailing list is perhaps lacking too, for specific=20
driver related lists it is better to add separate MAINTAINERS entries for=
=20
the particular driver and put L: there.

--=20
 i.

--8323328-652033754-1710243925=:1770--

