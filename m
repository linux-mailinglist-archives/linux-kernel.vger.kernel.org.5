Return-Path: <linux-kernel+bounces-38611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224783C324
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259EB1C236A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFEA5732D;
	Thu, 25 Jan 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddX/Kt1/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881C5101D;
	Thu, 25 Jan 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187852; cv=none; b=G9i095HafeXjIqIdMYpUWGtvjjKl8A4ctkJBUeAkicZr3Oh2HEv8KFN/+0qsfoQTadNDwlOR2/Nwq+RZizOW8Xof3LNHHLOr4mvcNialEo6Epfp5an/Y6ZgTXWl8SEvv+NEv7+I28t0vB0eNI6YLXA7nIfM0Fdc54HnPwvJQ2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187852; c=relaxed/simple;
	bh=ePyxDj8Fgb0LhEvz2Xaiwmjx/NG6Xh1p1RcMQYkEFyA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZUFoDMSwIpxY18uxcwYLD8bN/drG2GqZHCUp0Z/XjoVc6ntbMavsbKyP5Ft+gETo8FQZI+AqgxF0VRGB9jP3VRuDs4PNVVgwkwnTYX3nXMpVkBRza79Oxo5n2FwXIeYPwg824NqnW7mykpsjG4+0qBtzchz9HU1FxXsFLcE8Azg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddX/Kt1/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706187850; x=1737723850;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ePyxDj8Fgb0LhEvz2Xaiwmjx/NG6Xh1p1RcMQYkEFyA=;
  b=ddX/Kt1/KoOuRvJG+YUmAGN3sOzCecdmgpgfeAdnDxYTKahb+AKHgaPK
   m0EpJPdXkgn9/PiV6cTwXO59rn/cW0tX6vk10/srAkqaxGvtFDNoOwZ86
   392CaQ3wgTRPCCEt8Y61KeFfFWhlbzIzHYocwELrfkueTtruKLH8YGtIJ
   upZ2thtYXOUoojcTX5DbfN57lAKujYSzmVd7HYekOH7CCf5VkyXoxKM9D
   SvJetRrN9pyNIx8CnwygHIy5V2X8dH4YLGci0Z1SwACHHibxfzP7+ifva
   2aoTT3FPESP2HMmH96CsvAqcwfj7uVKHjEUv3pHGxFsAyWQQTdrRU4PEW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23615999"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23615999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905958179"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905958179"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:04:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jan 2024 15:04:01 +0200 (EET)
To: Ashok Raj <ashok.raj@intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org, 
    Jithu Joseph <jithu.joseph@intel.com>, rostedt@goodmis.org, 
    tony.luck@intel.com, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, patches@lists.linux.dev, 
    pengfei.xu@intel.com
Subject: Re: [PATCH 1/5] platform/x86/intel/ifs: Call release_firmware() when
 handling errors.
In-Reply-To: <20240125082254.424859-2-ashok.raj@intel.com>
Message-ID: <497dbb51-e583-374f-b31a-e14f1253c93f@linux.intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com> <20240125082254.424859-2-ashok.raj@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1915214704-1706187841=:1444"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1915214704-1706187841=:1444
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 25 Jan 2024, Ashok Raj wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
>=20
> Missing release_firmware() due to error handling blocked any future image
> loading.
>=20
> Fix the return code and release_fiwmare() to release the bad image.
>=20
> Fixes: 25a76dbb36dd ("platform/x86/intel/ifs: Validate image size")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86=
/intel/ifs/load.c
> index a1ee1a74fc3c..2cf3b4a8813f 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -399,7 +399,8 @@ int ifs_load_firmware(struct device *dev)
>  =09if (fw->size !=3D expected_size) {
>  =09=09dev_err(dev, "File size mismatch (expected %u, actual %zu). Corrup=
ted IFS image.\n",
>  =09=09=09expected_size, fw->size);
> -=09=09return -EINVAL;
> +=09=09ret =3D -EINVAL;
> +=09=09goto release;
>  =09}
> =20
>  =09ret =3D image_sanity_check(dev, (struct microcode_header_intel *)fw->=
data);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1915214704-1706187841=:1444--

