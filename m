Return-Path: <linux-kernel+bounces-108867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D4881118
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AB0282C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B293EA64;
	Wed, 20 Mar 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Au6Ln1WC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63C381D3;
	Wed, 20 Mar 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934627; cv=none; b=RaT/OkD3Fh8mUWwcdLjw1rWQ2aTQm5lCI9uYZisGL5heyrP9TLue3o4UrPYAUXJgHNrDKYQFP2zB3uU889ZxYgcZ9/5lBjHcpFfX2vr6zgixerDkjqB3G1sx7Ey2Hl42yc132JUXG5EH1+DrXOkOGDn4g+AJcQuGqUQ6BuaZDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934627; c=relaxed/simple;
	bh=zTNjM8Y+eEgduYplmMXU470dypJv2FhrWwqUBO0aOjE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u8B/Izkz6a4WxIYlGqW98EbPO58b6OjZPoAyxeyickmIBhVe20hAHsfy/mzq0hjtb0j8SgIqKUS6ayG5bLLvGWtUDY6BrDr33FitstgUGGhd6jiwcZc2FNnkp9YVuXssHsdbU8HFF46x9nGGKA6UyFJvBbT61CxQKUlw+59T0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Au6Ln1WC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710934626; x=1742470626;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=zTNjM8Y+eEgduYplmMXU470dypJv2FhrWwqUBO0aOjE=;
  b=Au6Ln1WC+VQw8WfeFlmw6HSk7dB/3dQsFsPlCpSwSSluJtMVpuasDKHw
   VetAShQrAnVVLo8iqca5WNxBO/WywvHb9SQ94fxZfJ7YpPZyot+BhRO+u
   MdgWMGR9GA3jRJnJ84kyzV6kQYyVxlwTsoPZB9+x8/FV+ALFKW6h7IluM
   YxjQjX6RPGCeDjW87B4Nh75Z7gzJsokbBhYcN4OPj7qbQWvrHyH+XyUQh
   MZ98pZ477olA17nf2CnhQQZSpvrDsMQ8mfEAkHKbZim+kDczQpANZ5SQ/
   98sEYFuLv+slbWAWgbfN2ePsF8deCVXQ1G02apGi86NXb0EdR9p3QBtjw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23353615"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23353615"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14203899"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.16])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:37:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Mar 2024 13:36:58 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support variant of
 TUF RGB
In-Reply-To: <20240320011442.11608-2-luke@ljones.dev>
Message-ID: <5d5e8895-8843-a0bf-de97-b293528a0643@linux.intel.com>
References: <20240320011442.11608-1-luke@ljones.dev> <20240320011442.11608-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-523568904-1710934361=:1037"
Content-ID: <9d3e5125-d4d9-6974-9847-0c4bdb5ed5e1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-523568904-1710934361=:1037
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a1a754a9-a482-e651-1732-b988a89a7b45@linux.intel.com>

On Wed, 20 Mar 2024, Luke D. Jones wrote:

> Adds support for a second TUF RGB wmi call that some versions of the TUF
> laptop come with. Also adjusts existing support to select whichever is
> available.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 13 +++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index b9a2fb8007c0..0d8a2b82cc06 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c

> @@ -4544,6 +4545,14 @@ static int asus_wmi_add(struct platform_device *pd=
ev)
>  =09=09asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
>  =09}
> =20
> +=09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {

The patch itself is fine,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

However,

There's a major problem in the way you're submitting these. This patch is=
=20
built on top of the GPU_MUX_VIVO patch as can be seen from the context
above. Yet, you're sending these independently instead of series. I=20
suspect there are other similar problems among these patches that there's=
=20
hidden dependency order in which these should be applied. This will cause=
=20
problems if maintainer applies the patches in wrong order (they may even=20
misapply with fuzz).

Only if the patches are truly independent, that is, focus on solving=20
entirely differently thing (functional independency) and do not have any=20
linewise conflicts (code locality independecy) either, it's fine to send=20
patches as independent ones without making a series out of them. But=20
clearly it's not the case here.

--=20
 i.
--8323328-523568904-1710934361=:1037--

