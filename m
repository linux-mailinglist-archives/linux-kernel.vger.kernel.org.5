Return-Path: <linux-kernel+bounces-54841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713584B44E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99371C23D92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759C1369A3;
	Tue,  6 Feb 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqU8FHfx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB181353F0;
	Tue,  6 Feb 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220494; cv=none; b=VK04QASCfw0+mhMBbID/2sMlAUB1l8kjXPKbSRaou0J0jEpClI3JU02gmd6Dom4TyQ6Vo4WZ/ABEvQ44bTSabm8zmsVctpkY5+Zk1SeIjldsEFZvQGCDV/X/TgmzyCaPE125wiEPiZBvsD5ZuOOddbTWT++dRWP0IRnYcCAQcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220494; c=relaxed/simple;
	bh=huQERr2I8KInHIO2lB1YDA3403COnVXjH7Omud6kihM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tKwWJ0c+GUxThh2zzt4aWx1S2/v2In6s1ukK1Zl6hzZqic912ySJJ9+0KTBsMnn6xHmZAbm/XnL0JXDX8+6QM5TEaWTUl61syuxCXb8aw19mx+83HWOHvHz19p1Pe5n+qJ3pnMOeJz50IT18vtIjXTaMQ4zYmct8thZJ6ncwTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqU8FHfx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707220493; x=1738756493;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=huQERr2I8KInHIO2lB1YDA3403COnVXjH7Omud6kihM=;
  b=FqU8FHfxbcXyV/7ox7zjUz/nX1jIRPL9LCxaCiz+PLYLZ95YOhPXMBPg
   h58xbu8KNzJYMo1DQfPzkzBD8+LIeni5ZaJzzs/WAaAidU/4UfeEKAAR+
   7LYQmrWTiic715HJt2ShjALc4O5xKWoaXvEYJQt+lnny8rRdq4poXZY3O
   wZ7/2l/zzQLgnGHGjRxg1J0lmvZpK/ZxIjFWClHmJ281ywdbSf2ZbLRdD
   MtelgbJJVX4YueCE0iD9qp5Jr4HbEinAWoW2gj1TCWKKE1qsUp6krOIjE
   ANtlDe51As1UtOwkDJnbCQjR0NrfWPUmLQa6RNEUUK/tQBjNJUWmvf1j0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4540214"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4540214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5599711"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:54:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 13:54:42 +0200 (EET)
To: Frank Li <Frank.Li@nxp.com>
cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com, 
    devicetree@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, imx@lists.linux.dev, 
    Jiri Slaby <jirislaby@kernel.org>, joe@perches.com, 
    krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
    linux-i3c@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, miquel.raynal@bootlin.com, 
    robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v7 6/8] i3c: target: func: add tty driver
In-Reply-To: <20240205233326.552576-7-Frank.Li@nxp.com>
Message-ID: <9b5bb389-4238-0a32-5e16-3c62ea6c00e7@linux.intel.com>
References: <20240205233326.552576-1-Frank.Li@nxp.com> <20240205233326.552576-7-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Frank Li wrote:

> Add tty over I3C target function driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v4 to v5
>     - remove void*
>     - include bitfield.h
>     - remove extra ()
>     - oneline for struct ttyi3c_port *sport
> 
>  drivers/i3c/Kconfig       |   3 +
>  drivers/i3c/Makefile      |   1 +
>  drivers/i3c/func/Kconfig  |   9 +
>  drivers/i3c/func/Makefile |   3 +
>  drivers/i3c/func/tty.c    | 474 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 490 insertions(+)
>  create mode 100644 drivers/i3c/func/Kconfig
>  create mode 100644 drivers/i3c/func/Makefile
>  create mode 100644 drivers/i3c/func/tty.c
> 
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index d59a7eb83d13a..fca808cda87b3 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -48,3 +48,6 @@ config I3C_TARGET_CONFIGFS
>  	  the target function and used to bind the function with a target
>  	  controller.
>  
> +if I3C_TARGET
> +source "drivers/i3c/func/Kconfig"
> +endif # I3C_TARGET
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> index c275aeae8970c..11f026d6876fe 100644
> --- a/drivers/i3c/Makefile
> +++ b/drivers/i3c/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_I3C)		+= i3c.o
>  obj-$(CONFIG_I3C_TARGET)                += target.o
>  obj-$(CONFIG_I3C_TARGET_CONFIGFS)       += i3c-cfs.o
>  obj-$(CONFIG_I3C)		+= master/
> +obj-$(CONFIG_I3C_TARGET)	+= func/
> diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
> new file mode 100644
> index 0000000000000..7115129eb7d5a
> --- /dev/null
> +++ b/drivers/i3c/func/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config I3C_TARGET_FUNC_TTY
> +	tristate "I3C target tty driver"
> +	depends on I3C_TARGET
> +	help
> +	  I3C Target TTY Function Driver.
> +
> +	  General TTY over I3C target controller function drivers.
> diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
> new file mode 100644
> index 0000000000000..16b3b9301496b
> --- /dev/null
> +++ b/drivers/i3c/func/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_I3C_TARGET_FUNC_TTY)              += tty.o
> diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
> new file mode 100644
> index 0000000000000..50673bfb6a003
> --- /dev/null
> +++ b/drivers/i3c/func/tty.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <linux/i3c/target.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty_flip.h>
> +
> +static DEFINE_IDR(i3c_tty_minors);
> +
> +static struct tty_driver *i3c_tty_driver;
> +
> +#define I3C_TTY_MINORS		8
> +
> +#define I3C_TX_NOEMPTY		BIT(0)
> +#define I3C_TTY_TRANS_SIZE	16
> +#define I3C_TTY_IBI_TX		BIT(0)

This is #include <linux/bits.h>

..which will include <vdso/bits.h> that contains the actual definition.

#include <bitfield.h> is for FIELD_GET/PREP(), etc.

> +struct ttyi3c_port {
> +	struct tty_port port;
> +	int minor;
> +	struct i3c_target_func *i3cdev;
> +	struct completion txcomplete;
> +	spinlock_t xlock;
> +	void *buffer;
> +	struct work_struct work;

This file seems to also lack some includes. Please go through your 
#include in the series and add those you use.

-- 
 i.


