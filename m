Return-Path: <linux-kernel+bounces-8878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623581BD96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89271F26B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BE634E4;
	Thu, 21 Dec 2023 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="CmB6F+Fg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E0BA2F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1703180932; bh=C/ChlUmQCKhGe7wGz3t23vSOKzvHdGPImPjw/3MzxyE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CmB6F+Fgv3X1lNpF47sxSHcGT9nfMCT+OJh7refMhpJpmMH4qdP6qr6FOeRq+JEwk
	 ShkOwufY0NwqJ90aOtpUDUGSQ1DcS69HtLdjzLXx0wmVvUtuVmPHDOQHJ0MdazuCli
	 CZV5+7SLgqurbR4j4cRBOqfQ95XkgX//x7LDg33c=
Date: Thu, 21 Dec 2023 18:48:49 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>
In-Reply-To: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
References: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pvpanic: Don't use "proxy" headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>

Dec 21, 2023 15:44:55 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Note:
This also drops the unused include of the UAPI header
which could be mentioned in the changelog.

> ---
> drivers/misc/pvpanic/pvpanic-mmio.c |=C2=A0 7 +++----
> drivers/misc/pvpanic/pvpanic-pci.c=C2=A0 |=C2=A0 5 +----
> drivers/misc/pvpanic/pvpanic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++=
+----
> drivers/misc/pvpanic/pvpanic.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++=
+++
> 4 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/p=
vpanic-mmio.c
> index 9715798acce3..f3f2113a54a7 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -7,16 +7,15 @@
> =C2=A0 *=C2=A0 Copyright (C) 2021 Oracle.
> =C2=A0 */
>
> +#include <linux/device.h>
> +#include <linux/err.h>
> #include <linux/io.h>
> -#include <linux/kernel.h>
> +#include <linux/ioport.h>
> #include <linux/kexec.h>
> #include <linux/mod_devicetable.h>
> #include <linux/module.h>
> #include <linux/platform_device.h>
> #include <linux/types.h>
> -#include <linux/slab.h>
> -
> -#include <uapi/misc/pvpanic.h>
>
> #include "pvpanic.h"
>
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pv=
panic-pci.c
> index c5fb6298cb8d..9ad20e82785b 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -5,13 +5,10 @@
> =C2=A0 *=C2=A0 Copyright (C) 2021 Oracle.
> =C2=A0 */
>
> -#include <linux/kernel.h>
> +#include <linux/errno.h>
> #include <linux/module.h>
> #include <linux/pci.h>
> #include <linux/types.h>
> -#include <linux/slab.h>
> -
> -#include <uapi/misc/pvpanic.h>
>
> #include "pvpanic.h"
>
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpani=
c.c
> index 305b367e0ce3..df3457ce1cb1 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -8,16 +8,20 @@
> =C2=A0 */
>
> #include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp_types.h>
> #include <linux/io.h>
> -#include <linux/kernel.h>
> #include <linux/kexec.h>
> +#include <linux/kstrtox.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> #include <linux/mod_devicetable.h>
> #include <linux/module.h>
> -#include <linux/platform_device.h>
> #include <linux/panic_notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> #include <linux/types.h>
> -#include <linux/cdev.h>
> -#include <linux/list.h>
>
> #include <uapi/misc/pvpanic.h>
>
> diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpani=
c.h
> index 46ffb10438ad..a42fa760eed5 100644
> --- a/drivers/misc/pvpanic/pvpanic.h
> +++ b/drivers/misc/pvpanic/pvpanic.h
> @@ -8,6 +8,11 @@
> #ifndef PVPANIC_H_
> #define PVPANIC_H_
>
> +#include <linux/compiler_types.h>
> +
> +struct attribute_group;
> +struct device;
> +
> int devm_pvpanic_probe(struct device *dev, void __iomem *base);
> extern const struct attribute_group *pvpanic_dev_groups[];
>
> --
> 2.43.0.rc1.1.gbec44491f096


