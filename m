Return-Path: <linux-kernel+bounces-37250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE68183AD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2020D1C22550
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421ED7A732;
	Wed, 24 Jan 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/GI0v9C"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BE2BAE5;
	Wed, 24 Jan 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110029; cv=none; b=UWHl8DJIMqCXGWVWDD+3mtk0tLuDCIVDTdqTRZVutj2YIVs1gHg0rqJlsVm7VUzd1CbiDNmag1qAKiZVv7gSq187Asu+yPSbljRs6R50cHJCMZPIiutwOS2SmxPNBu1n29WyPwY02Jq+gE9jTIuwwtSDxBemz+TRqz448oPAzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110029; c=relaxed/simple;
	bh=eWgI5cQzGgxjU8IqhiNLaIrbAIei/iVfjxJTyMVtWCw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nEMzSRpFhbuYi58QsJHmPIsx9gv1dtZb6ndqVoReQuN7AhhQHXp+eCauw9WGu6PhfCsIAvpL1yKLmTsDPCWk89nP29wX6wBAYQ1hLkyUL/Fvi4zTPLY4Ie13RksnL8ZjmDSn0nvKg62BDgKV1w8yJwcCtipHyNPBRpv86+x7zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/GI0v9C; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706110026; x=1737646026;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eWgI5cQzGgxjU8IqhiNLaIrbAIei/iVfjxJTyMVtWCw=;
  b=a/GI0v9CdeJzNMJE9SdbZs++m0rOwtAev/4Y1kW9iFOrclVpjKIz153E
   dUO8KnZO49m5Vvx3h86P017S/uSbyBkLELZUwOv6lK4srKJoYLHMp4MOe
   jObWMrf4Bi/t6jyiL0219zzL3oxUOZ1rNfczbut4K25WTquP2T8Q+c23m
   8o/F0KGIxXewPuuKqgZnhNv8CVv7f09IQVMp3awrFtTE2zue+fCGwOSm1
   ee12UGCHItnxEjlAA1pB9OZuINyf7YvX37NqAs8IwKAIAXRXN8OFdruX7
   k6MAFRE3PHjT3eJRxqOnrpz2MiYCHBFAQKiY4WIqFL2Wuf6nMwyFUP18Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400730354"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400730354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2073769"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:27:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 17:26:55 +0200 (EET)
To: Frank Li <Frank.Li@nxp.com>
cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com, 
    devicetree@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, imx@lists.linux.dev, 
    Jiri Slaby <jirislaby@kernel.org>, joe@perches.com, 
    krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
    linux-i3c@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, miquel.raynal@bootlin.com, 
    robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 8/8] tty: i3c: add TTY over I3C master support
In-Reply-To: <20240123231043.3891847-9-Frank.Li@nxp.com>
Message-ID: <a2716dab-8681-3bce-d0fb-b83789c51362@linux.intel.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com> <20240123231043.3891847-9-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jan 2024, Frank Li wrote:

> In typical embedded Linux systems, UART consoles require at least two pins,
> TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> present, we can save these two pins by using this driver. Pins is crucial
> resources, especially in small chip packages.
> 
> This introduces support for using the I3C bus to transfer console tty data,
> effectively replacing the need for dedicated UART pins. This not only
> conserves valuable pin resources but also facilitates testing of I3C's
> advanced features, including early termination, in-band interrupt (IBI)
> support, and the creation of more complex data patterns. Additionally,
> it aids in identifying and addressing issues within the I3C controller
> driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Notes:
>         Version number use i3c target patches.
>         Change from v3 to v4
>         - add static at i3c_remove()
>         Change v2
>         - using system_unbound_wq working queue
>         - fixed accoring to Jiri Slaby's comments
>     
>         Change before send with i3c target support
>     
>         Change from v4 to v5
>         - send in i3c improvememtn patches.
>     
>         Change from v2 to v4
>         - none
>     
>         Change from v1 to v2
>         - update commit message.
>         - using goto for err handle
>         - using one working queue for all tty-i3c device
>         - fixed typo found by js
>         - update kconfig help
>         - using kfifo
>     
>         Still below items not be fixed (according to Jiri Slaby's comments)
>         - rxwork thread: need trigger from two position.
>         - common thread queue: need some suggestion
> 
>  drivers/tty/Kconfig   |  13 ++
>  drivers/tty/Makefile  |   1 +
>  drivers/tty/i3c_tty.c | 426 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 440 insertions(+)
>  create mode 100644 drivers/tty/i3c_tty.c
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 5646dc6242cd9..9ab4cd480e9f8 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -412,6 +412,19 @@ config RPMSG_TTY
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called rpmsg_tty.
>  
> +config I3C_TTY
> +	tristate "TTY over I3C"
> +	depends on I3C
> +	help
> +	  Select this option to use TTY over I3C master controller.
> +
> +	  This makes it possible for user-space programs to send and receive
> +	  data as a standard tty protocol. I3C provide relatively higher data
> +	  transfer rate and less pin numbers, SDA/SCL are shared with other
> +	  devices.
> +
> +	  If unsure, say N
> +
>  endif # TTY
>  
>  source "drivers/tty/serdev/Kconfig"
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 07aca5184a55d..f329f9c7d308a 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>  obj-$(CONFIG_VCC)		+= vcc.o
>  obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
> +obj-$(CONFIG_I3C_TTY)		+= i3c_tty.o
>  
>  obj-y += ipwireless/
> diff --git a/drivers/tty/i3c_tty.c b/drivers/tty/i3c_tty.c
> new file mode 100644
> index 0000000000000..8f4e87dfa01cd
> --- /dev/null
> +++ b/drivers/tty/i3c_tty.c
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 NXP.
> + *
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/console.h>
> +#include <linux/serial_core.h>
> +#include <linux/interrupt.h>

Do you need this header.

> +#include <linux/workqueue.h>
> +#include <linux/tty_flip.h>
> +
> +static DEFINE_IDR(i3c_tty_minors);
> +static DEFINE_MUTEX(i3c_tty_minors_lock);
> +
> +static struct tty_driver *i3c_tty_driver;
> +
> +#define I3C_TTY_MINORS		8
> +#define I3C_TTY_TRANS_SIZE	16
> +#define I3C_TTY_RX_STOP		0
> +#define I3C_TTY_RETRY		20
> +#define I3C_TTY_YIELD_US	100
> +
> +struct ttyi3c_port {
> +	struct tty_port port;

Missing #include

> +	int minor;
> +	spinlock_t xlock; /* protect xmit */

Missing #include

> +	u8 tx_buff[I3C_TTY_TRANS_SIZE];
> +	u8 rx_buff[I3C_TTY_TRANS_SIZE];
> +	struct i3c_device *i3cdev;
> +	struct work_struct txwork;
> +	struct work_struct rxwork;
> +	struct completion txcomplete;

Missing #include

> +	unsigned long status;
> +	u32 buf_overrun;
> +};

> +static void i3c_port_shutdown(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);

On one line.

> +
> +	i3c_device_disable_ibi(sport->i3cdev);
> +	tty_port_free_xmit_buf(port);
> +}
> +
> +static void i3c_port_destruct(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);

Ditto.

> +static void tty_i3c_rxwork(struct work_struct *work)
> +{
> +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
> +	struct i3c_priv_xfer xfers;
> +	u32 retry = I3C_TTY_RETRY;
> +	u16 status = BIT(0);

Unnecessary initialization.

> +	int ret;
> +
> +	memset(&xfers, 0, sizeof(xfers));
> +	xfers.data.in = sport->rx_buff;
> +	xfers.len = I3C_TTY_TRANS_SIZE;
> +	xfers.rnw = 1;
> +
> +	do {
> +		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
> +			break;
> +
> +		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> +
> +		if (xfers.actual_len) {
> +			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
> +						     xfers.actual_len);
> +			if (ret < xfers.actual_len)
> +				sport->buf_overrun++;
> +
> +			retry = I3C_TTY_RETRY;
> +			continue;
> +		}
> +
> +		status = BIT(0);

Can this BIT(0) be named with a #define?

> +		i3c_device_getstatus_format1(sport->i3cdev, &status);
> +		/*
> +		 * Target side needs some time to fill data into fifo. Target side may not
> +		 * have hardware update status in real time. Software update status always
> +		 * needs some delays.
> +		 *
> +		 * Generally, target side have circular buffer in memory, it will be moved
> +		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
> +		 * there are gap, especially CPU have not response irq to fill FIFO in time.
> +		 * So xfers.actual will be zero, wait for little time to avoid flood
> +		 * transfer in i3c bus.
> +		 */
> +		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> +		retry--;
> +
> +	} while (retry && (status & BIT(0)));

Name with define?


-- 
 i.


