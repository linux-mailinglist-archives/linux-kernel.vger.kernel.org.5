Return-Path: <linux-kernel+bounces-92561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690E987222C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6348C1C21553
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A83126F19;
	Tue,  5 Mar 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrc1E3ar"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069585954;
	Tue,  5 Mar 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650709; cv=none; b=noY2jQtL0098/zfu5pr1o8UU6RFe2sqF4upmwzmADASrEwLtdM0GAdLAIosX/tSBnvOVzVFR26u2b0GSR2lbOdGasFDHWIOMT/fLtkrYzfVlARxYLJVSO5ToH/niPoeKNL82KVancK+qK4EUYaS+yiRCFIeRkV9jeaHjHyxWAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650709; c=relaxed/simple;
	bh=eDrl3N91i6VSsVPwRQLCSDjE2WRbc/dlF+GNZC+fUHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SMrNIIeu77zV0elfYq/yEKG5QVnEyfAjx/8R268UdKAlpmfz5niEebmANb39tiKGTJA3LmyM55KHE9v1lsfT+uqv7bnPnL+L8ZU26+yne30RXSH69eb2rkzaUacInPn+XHEg2U9VlkEJ1MSuH64QehA5VLAesBQwQwryHoirDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrc1E3ar; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650708; x=1741186708;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eDrl3N91i6VSsVPwRQLCSDjE2WRbc/dlF+GNZC+fUHM=;
  b=Wrc1E3arKi3kKCDADDOpIyO8b1GFvTiw+cRzYvt7L10BAQ4D+dIVULYH
   UXXIlFSo5031AQsk03LShjU+4UwoB07mHbaeyrl8Qb2j+DtYDfapDR7cw
   htikCss9vPqrCrCWhfI8HCgRJ3es+72TqH16NsQjMBIWM6rYkTpOGgunE
   +tFNSsq9Hj5aitTHYhzeouwTOxFoufYi1CYUEPdvthV3k1Nimq6jBjFHb
   meF5V4bJ4jpNcBPXgK769Jdiki9Y1ptRB2eJLBY/+cBmdDwvXJGgKQCgG
   /zbXpKwAY3OvytJDWpYqmKsujZ4I1GIiO7696YBHuaXsE5GZkLvnqkL08
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7149805"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7149805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9345361"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:58:27 -0800
Message-ID: <ea2f6883e29453e9bdb134a183a0747ec06971f1.camel@linux.intel.com>
Subject: Re: [PATCH v1] thermal: intel: int340x_thermal: Use thermal zone
 accessor functions
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Stanislaw
 Gruszka <stanislaw.gruszka@linux.intel.com>
Date: Tue, 05 Mar 2024 06:58:26 -0800
In-Reply-To: <2724753.mvXUDI8C0e@kreacher>
References: <2724753.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 12:32 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Make int340x_thermal use the dedicated accessor functions for the
> thermal zone device object address and the thermal zone type string.
>=20
> This is requisite for future thermal core improvements.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |=C2=
=A0=C2=A0=C2=A0 3
> ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: linux-
> pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-
> pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ linux-
> pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -58,7 +58,8 @@ static int int340x_thermal_set_trip_temp
> =C2=A0
> =C2=A0static void int340x_thermal_critical(struct thermal_zone_device
> *zone)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&zone->device, "%s: cr=
itical temperature reached\n",
> zone->type);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(thermal_zone_device(zo=
ne), "%s: critical temperature
> reached\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0thermal_zone_device_type(zone));
> =C2=A0}
> =C2=A0
> =C2=A0static inline void *int_to_trip_priv(int i)
>=20
>=20
>=20


