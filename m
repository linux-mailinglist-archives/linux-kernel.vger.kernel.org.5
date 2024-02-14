Return-Path: <linux-kernel+bounces-65040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D785470B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CF0B27C32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60F17571;
	Wed, 14 Feb 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhsLx1tf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D663C2C6;
	Wed, 14 Feb 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906196; cv=none; b=AvJ9EoC9ykW6LEQhG5HnFoW/QQXzpvEP5aTdc95fLvSZZ2tQcQZnyUhDGkyh6yPCd2rgnHH4Vx5k3hazf/221LzInUx52YfVUHBBVcezwxVzx4kSuDiYaWHzQsaEGD7diz5ZsdISJpwCiaOsQPrDbm8dVpR+xz9dgKxL0xzBAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906196; c=relaxed/simple;
	bh=QMaqZlJchyH8KIu//1PefAMMgtRPF4A6MlkANLCH/AI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gnNFukRQWBwjwzxkACkh79/6qjwoo6WELFfXNHpMpUpOqAF6R6E/RVXYRmYmKV3O2BF1CFdshYVBjY7C7GC4hZwi43DBnTlzvWWCLmQR6rr1Ubg8syG3q4CFkQnC8Ux4PsQYQSa2R61Gr+Af5qGfwfK8tJ0s/DPPHeESxJC2nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhsLx1tf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707906195; x=1739442195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=QMaqZlJchyH8KIu//1PefAMMgtRPF4A6MlkANLCH/AI=;
  b=BhsLx1tf+XhdsHOHKeKwy2f65zl9QGXeg8HBWDK34WSXTSG/KiJgtu6m
   KKWddMIP7QQQ3Kg1Eo6ZjQ3sHw7HV8OSkiDqQ9Qccgd7yt9+5LujGDy/c
   Ui/DTdpVirEuRHbqhnpYg0bTeV1CfVzBDB/y1cbP42OexxIofqDe2OcvM
   gblQKhpoXyk58xnOCyrwS0jUJQt6D5an2zjkrVkm32XWGSPqwz1DBPVEt
   h2KsteijzX37omO+OSoMLjDvDoBLYfH56+4lwfERgoVA/vtUUtQXpydUT
   iwxK2+zdsQoKfb+7S9nD/J1T1wxHkPRYPNxWe5SEltEs+w50Dn76ldKG6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1794801"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1794801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3055604"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:23:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Feb 2024 12:22:57 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, vsankar@lenovo.com
Subject: Re: [PATCH 2/2] platform/x86: thinkpad_acpi: Fix to correct wrong
 temp reporting on some ThinkPads
In-Reply-To: <20240214052959.8550-2-vishnuocv@gmail.com>
Message-ID: <97fb005c-92bc-790b-80b0-75149a799b4b@linux.intel.com>
References: <20240214052959.8550-1-vishnuocv@gmail.com> <20240214052959.8550-2-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2051631955-1707905357=:7959"
Content-ID: <f7c0f68c-a877-b78a-78fb-25cb2650f791@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2051631955-1707905357=:7959
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7a7d916c-733b-6bf9-216b-a3ebf981ddf0@linux.intel.com>

On Wed, 14 Feb 2024, Vishnu Sankar wrote:

> Added non-standard thermal register support for some ThinkPads.
>=20
> Some of the Thinkpads use a non-standard ECFW which use different
> thermal register addresses.
> This is a fix to correct the wrong temperature reporting on
> those systems.
>=20
> Tested on Lenovo ThinkPad L13 Yoga Gen2
>=20
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
> -Improvements as requested.
> -Improved the readability in case TPACPI_THERMAL_TPEC_12.
> -idx < 8 from idx idx <=3D7 to match idx =3D 8
> -KILO used from linux/units.h instead of 1000.

>  static enum thermal_access_mode thermal_read_mode;
>  static bool thermal_use_labels;
> +static bool thermal_with_ns_address;=09/*Non-standard thermal reg addres=
s*/

Comment is missing spaces.

> @@ -6239,6 +6267,20 @@ static int thermal_get_sensor(int idx, s32 *value)
>  =09=09}
>  =09=09break;
> =20
> +=09/* The Non-standard EC uses 12 Thermal areas */
> +=09case TPACPI_THERMAL_TPEC_12:
> +=09=09if (idx >=3D 12)
> +=09=09=09return -EINVAL;
> +
> +=09=09t =3D idx < 8 ? TP_EC_THERMAL_TMP0_NS + idx :
> +=09=09=09=09TP_EC_THERMAL_TMP8_NS + (idx - 8);
> +
> +=09=09if (!acpi_ec_read(t, &tmp))
> +=09=09=09return -EIO;
> +
> +=09=09*value =3D tmp * KILO;

Hmm, MILLI would be much more approriate here? But if this relates to=20
degrees, there is MILLIDEGREE_PER_DEGREE?

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-2051631955-1707905357=:7959--

