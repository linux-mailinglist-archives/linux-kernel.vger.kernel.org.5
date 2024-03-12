Return-Path: <linux-kernel+bounces-100185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6387933A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC711F22BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7679B9A;
	Tue, 12 Mar 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdbloRaS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972C7828D;
	Tue, 12 Mar 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243644; cv=none; b=nK4nlREsp9idDcsQvC+VWXGYVVtZy+bupAN/6A7KcLT00Q0Jq5zwQd5gAGFfHniiNOjgYFebWtpkOpR2wvb4kNKfCFfhsOgANMbYIsRfSjzcZ74uOguixT+U/Mf9CcMsC3aqbm4D0FmY5jz4FPvrHxxbRnjKDUpifqubI9y7wS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243644; c=relaxed/simple;
	bh=9UdW4s8We8sIcHTuEmqxyB7gR9SJ6vZOdVWgGwK79NE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WwJsaC0mwfuqAEQM9yJPc3CyeNFElHZD0n+1b6rmNx8yGlgUIzCTe/9qyyQz21Ut23qpbirIss6/wDycTqZ8Ir7qoUsm6vOvPuIVT9zgDcfYhs7Q4P/58RSLknTKoi6Q64sZKR5NXWF/xGo59VQgSNV9INVVCGy1V4YA3P6+u6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdbloRaS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710243643; x=1741779643;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9UdW4s8We8sIcHTuEmqxyB7gR9SJ6vZOdVWgGwK79NE=;
  b=mdbloRaSPRv3bTD4r9kC6YdEqeFDjmsyIhC9QT7/GV/OhyfoOsMr9DZ3
   86aq+cOVCUFJfmraSwyDWXhRQXeny/HxK3X27KaqUSGXMk3NJitCm2bU0
   SAkgNvgkcTgO4fAxCKftiaLvsa/582x2nvQsWgFPxAeXI1AVZpx6jjxxT
   XcGaw3SftS3QNpUp/jFJeZ1H63DHgEmdMK0KFNPtOqW7QADQhIMvGMOcM
   MlM5/SYnnaOQZaPDTbsC1U8bYfFKhoKoMjJL2c9ZofCcyKv5lc6Rc78S+
   CEwZbyDZoRNui+CpLORdW11Ia13R+6tsUbH0dedCPnTDPGNI5W4s+3Pd8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8710963"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8710963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="34690950"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:40:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 13:40:33 +0200 (EET)
To: Nikita Travkin <nikita@trvn.ru>
cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
    Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] platform: Add ARM64 platform directory
In-Reply-To: <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru>
Message-ID: <4b65793d-0196-0118-6304-b078eaacd482@linux.intel.com>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru> <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1144789663-1710242525=:1770"
Content-ID: <b7f13e73-3ca3-ec79-a583-7abde67e6d5e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1144789663-1710242525=:1770
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <681a33ea-5fa2-89db-0a66-473a5eec5c16@linux.intel.com>

On Tue, 12 Mar 2024, Nikita Travkin wrote:

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
> Hans de Goede and Mark Gross).

Mark -> me.

> +ARM64 PLATFORM DRIVERS
> +M:=09Hans de Goede <hdegoede@redhat.com>
> +M:=09Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +Q:=09https://patchwork.kernel.org/project/platform-driver-x86/list/
> +T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-dr=
ivers-x86.git
> +F:=09drivers/platform/arm64/

Is some ARM64 person going to pay attention to these patches (you or=20
perhaps somebody else)?

It's perfectly fine to have some ARM64 person(s) listed as an additional=20
maintainer there even if the patches themselves are routed through Hans=20
and me (and pdx86 tree). With Mellanox and Surface platform drivers which=
=20
are also routed through pdx86 tree, we have Hans + me + 3rd person listed=
=20
as maintainers.

(This is not to force anything on anyone but it could be beneficial if=20
somebody more familiar with ARM64 is in the loop.)

--=20
 i.
--8323328-1144789663-1710242525=:1770--

