Return-Path: <linux-kernel+bounces-24426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDC582BC65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D132D2874A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5D5DF05;
	Fri, 12 Jan 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIZbtwrH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74A5D8F6;
	Fri, 12 Jan 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705048191; x=1736584191;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GtyZZyZf58oRN+ctD+6ZI18xy1j8TFB3G36HFFq94ew=;
  b=eIZbtwrHc8kxm9oTVg/E1UcT++UqalQBO34FqrSank6F/AXA8eV6p9Py
   HOYo4yAoiwPxD2gJKxEPjQG112YE3EJePx2ece04ReDkrc4cEfghdCh9E
   LB73IFM/azo5XGCpr4H6JBe5EAsxJkJg6LMEyek2mAYo0Qocx7/xc3HwI
   6S7M7rC2M4Vj2gRWKdjclkxBpyKv1iH9XWeWjepARR6h3+hCrrRQ8eyVe
   Zt3dBn1ob+akiH5IKgLoH4YzBsaZx7nOf9ZD9y08KiEJB7Hf/NZ+lqzgc
   bvNW/J3MLZdp4blE/jpDPNpoi1DS7bQEkGLEswcBFd0Eg89yo1vrNf8o5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="398801393"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="398801393"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 00:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="901910176"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="901910176"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 00:29:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jan 2024 10:29:43 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Hans de Goede <hdegoede@redhat.com>, Henry Shi <henryshi2018@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: silicom-platform: clean up a check
In-Reply-To: <a58bffb7-0a8b-4195-b273-f65a188ace7b@moroto.mountain>
Message-ID: <f066439f-57d1-7ccf-3d3c-546aa90a17bb@linux.intel.com>
References: <a58bffb7-0a8b-4195-b273-f65a188ace7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-303773933-1705048183=:1030"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-303773933-1705048183=:1030
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Jan 2024, Dan Carpenter wrote:

> The error message in this code can't be reached because value is either
> zero or non-zero.  There isn't a third option.  Really, it's nicer to
> write this as a one liner.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/platform/x86/silicom-platform.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x=
86/silicom-platform.c
> index 6ce43ccb3112..c0910af16a3a 100644
> --- a/drivers/platform/x86/silicom-platform.c
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -256,12 +256,7 @@ static void silicom_gpio_set(struct gpio_chip *gc,
>  =09if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
>  =09=09return;
> =20
> -=09if (value)
> -=09=09silicom_mec_port_set(channel, 0);
> -=09else if (value =3D=3D 0)
> -=09=09silicom_mec_port_set(channel, 1);
> -=09else
> -=09=09pr_err("Wrong argument value: %d\n", value);
> +=09silicom_mec_port_set(channel, !value);
>  }
> =20
>  static int silicom_gpio_direction_output(struct gpio_chip *gc,
>=20

Thanks for the update,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-303773933-1705048183=:1030--

