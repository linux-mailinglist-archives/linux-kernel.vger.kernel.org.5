Return-Path: <linux-kernel+bounces-93736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED868733EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3DA28EBDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F305FB84;
	Wed,  6 Mar 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBgQKZbO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7D5E206;
	Wed,  6 Mar 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720430; cv=none; b=cQdqfWdXiw5CK9ttJTQF46oshiOG1WONO7b8/KHYgAueNxuiGp/I7M48Nz8f+Ube9FNnGgi2WkF6tgR8GYppUXOhDE2os5dPLKEouCG1tE9ZbutCjknjGzUP2IE6337JpBof5iG1paUCDx5dFwHexPAk2740IhsjFaR4llmOqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720430; c=relaxed/simple;
	bh=oDGIPms3Q4wOtkg526l29AXgEjIgK+AvFw0Cwv2JEwo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s+83wXod4zI725vnZFn/bhwxzYUEX2xp+wSR3wTAXHCXiAdmgJ4ZxT1e0LS5ouKm3XjcCua2k/RlYpqtRjrMUhDWLg85Er8xuYQPih0lnnK3OYMiY67Z0xR2YDwY3cFkxAYNHtdpTmyPKaY41a/1AxcbsCYOhmNSqy+vXlpTJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBgQKZbO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709720428; x=1741256428;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oDGIPms3Q4wOtkg526l29AXgEjIgK+AvFw0Cwv2JEwo=;
  b=bBgQKZbO+vvMt3PFd1nfHwvofWQnpw1PCQPLExD9ZpFvE428pZRIeVpI
   WvrqlLOVqLmuXTJ6X8PO4ooIAjCuK2oVw76Vv1QKivleYjAXPxwr2u/nP
   xG07rhfbqlfch6Ix3CQXOORoY7L0+XMQuP31GgdNFx3bzBrnB7Wt6CYh9
   Uqqkxj+XpZChIPEo71cAsXu/ooEwKtanp+u2P65/SEsUcjceu6FJ7Z64b
   QO9q0CyhzNDA6Op7DP6VRFqaTqvXx/8Nl39e3rVjQYKcLbZACrbivqgL/
   M7N7mVsCmVHp9rAoknLtwMHRTo9t/PjLMfx4Dh4IUWk2Ap4KTNhcahe/+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8087584"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="8087584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="32862683"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:20:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 12:20:21 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown
 error
In-Reply-To: <20240304221732.39272-2-W_Armin@gmx.de>
Message-ID: <a81d0ad2-d9d9-b85d-decc-3de314078f9a@linux.intel.com>
References: <20240304221732.39272-1-W_Armin@gmx.de> <20240304221732.39272-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1731533219-1709720421=:1022"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1731533219-1709720421=:1022
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 4 Mar 2024, Armin Wolf wrote:

> If an error code other than EINVAL, ENODEV or ETIME is returned
> by ec_read()/ec_write(), then AE_OK is wrongly returned.
>=20
> Fix this by only returning AE_OK if the return code is 0, and
> return AE_ERROR otherwise.
>=20
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 900e0e52a5fa..be0e772a87c8 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1213,8 +1213,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
>  =09=09return AE_NOT_FOUND;
>  =09case -ETIME:
>  =09=09return AE_TIME;
> -=09default:
> +=09case 0:
>  =09=09return AE_OK;
> +=09default:
> +=09=09return AE_ERROR;
>  =09}
>  }

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1731533219-1709720421=:1022--

