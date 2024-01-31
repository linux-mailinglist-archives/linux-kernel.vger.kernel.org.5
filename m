Return-Path: <linux-kernel+bounces-46598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F798441CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1292F1C2192F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4B8287C;
	Wed, 31 Jan 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVldbBTZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FF80C0F;
	Wed, 31 Jan 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711086; cv=none; b=j0DPZaZlUHoGKgXx6ClB32/FlA3+FMubp8WG5J23PPGrPtqbN01SFq3aofi+/ATJRhwQmGwwVCbuc7VlmFAXSTSrwvS/ijKoNe39OpgL9goVRbFznyMcnEnaPmjygPI10jj9xgl71HwGB6+hG5XUJwHhl0kYMMjhDyNbY4hywec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711086; c=relaxed/simple;
	bh=ImjcccdS9tzQDlBcPPZYNIqrAUIp41sDSNbxA2bXGAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia0J7owBWfqxnnZz1AbXuqGgoMPvjuzNeLQIRqe81dy7WxbaVTCsqrerfVEwY2tkSpgUfI19o6qCu6wGLbhyxQOzx5m1jm/CrZf/1YfcXZ5WNYsZH8cYS3NkiClxakANT5dSWap9Xmjm1XKPTSNErNJG7QNDsWr+bWIfxqge+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVldbBTZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so56992645e9.1;
        Wed, 31 Jan 2024 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706711082; x=1707315882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxo8fTvdcFHWgQYYiIZBuW8ecUZKT73op0PCx+g/6Cg=;
        b=EVldbBTZqZ470R6W3bOQl7544kHAZ9j+qfII2R+f2SprFbtjP2vXkNA1s9D9PT9YK4
         nsejry0+IMeVpeIBDIOk6upBtJcTBVnpM9n2Gc/nf73MG0kQWt7+5iHYnaCu0wipQhCk
         LPLLSlbP56KfPFJIeZm4QHxZKBnR2aI9FvHhv4h6E6d2EL2vZ3M7FQcxZhkYlkf36FH/
         V/jw47ieSf5aVX05JUxCjpnZXvhSLlDj54mAcpr4qyiPFFfBmfNlMloi2+JaeLLLwA3T
         QAZPSu+cDuPNFQl4o9/lGK6pngoWyXeWLuARgK/wPxe0kQ40lka/7xTtzHfX64Er8Iwr
         aBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711082; x=1707315882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxo8fTvdcFHWgQYYiIZBuW8ecUZKT73op0PCx+g/6Cg=;
        b=wpH6nTIMJWx9pthx1EgjPGAaoUQDhaG2GWp5lqrjnbNkWtZgFzhtNbR0kilqaRX69d
         7TSJ47sLX6SfOufyX65iwD3jvqeOPRf8Xfkc9ESE29s78yGTh1NAdSX7cpl9z9EFuovH
         Bg2jXgdazO49zuw137cnOClpShXEUN0FXhoVaORboBwUjm6SbZw/HsLTTEvEv3kNxnVi
         hvidypPUlz7Nn/9nkPhdaRAVxct8XyZZ6SUXoXH7LLsrvHtgECGNOr0KXlfi8VJkV+1C
         e5EBMg6l0MQ0mtxYX4p+BJiQnCTIzxJp7STkQnh+1HBS1M9pIoueK71zdNT6Xcb68whu
         ZoCw==
X-Gm-Message-State: AOJu0Yzs7KkTbMW9FFLoga/ofVctsrVQXob+MyddfY+ODiYmb6MbD4mx
	SrsAgv/llV0GA1S7GtALXUfDDMJaXCctesPdKcnzhACR2pCCoN1N
X-Google-Smtp-Source: AGHT+IGwVQ7WMT1lCeXjNiGwbNOVelk5xg/9wEgEX4sHUKF1qzwKKqtGAoedIhMpvddzEHfM0W2++w==
X-Received: by 2002:a05:600c:1986:b0:40e:e25c:41cf with SMTP id t6-20020a05600c198600b0040ee25c41cfmr1328417wmq.12.1706711082135;
        Wed, 31 Jan 2024 06:24:42 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b0040eee852a3dsm1793922wms.10.2024.01.31.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:24:41 -0800 (PST)
Message-ID: <e3b22194bbe8ab5827066bf473631ce85c5c65e3.camel@gmail.com>
Subject: Re: [PATCH 2/2 v2] pwm: Add driver for AXI PWM generator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org,  robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,  Drew Fustini
 <dfustini@baylibre.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 David Lechner <dlechner@baylibre.com>
Date: Wed, 31 Jan 2024 15:27:58 +0100
In-Reply-To: <20240123220515.279439-3-tgamblin@baylibre.com>
References: <20240123220515.279439-1-tgamblin@baylibre.com>
	 <20240123220515.279439-3-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 17:05 -0500, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>=20
> Add support for the Analog Devices AXI PWM Generator. This device is an
> FPGA-implemented peripheral used as PWM signal generator and can be
> interfaced with AXI4. The register map of this peripheral makes it
> possible to configure the period and duty cycle of the output signal.
>=20
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>=20
> ---
> v2 changes:
> * Address feedback for driver and device tree in v1:
> =C2=A0 * Use more reasonable Kconfig approach
> =C2=A0 * Use common prefixes for all functions
> =C2=A0 * Rename axi_pwmgen struct to axi_pwmgen_ddata
> =C2=A0 * Change use of "pwm" to "ddata"
> =C2=A0 * Set and check state->polarity
> =C2=A0 * Multiply safely with mul_u64_u64_div_u64()
> =C2=A0 * Improve handling of max and zero periods
> =C2=A0 * Error if clk_rate_hz > NSEC_PER_SEC
> =C2=A0 * Add "Limitations" section at top of pwm-axi-pwmgen.c
> =C2=A0 * Don't disable outputs by default
> =C2=A0 * Remove unnecessary macros for period, duty, offset
> =C2=A0 * Fix axi_pwmgen_ddata alignment
> =C2=A0 * Don't artificially limit npwm to four
> =C2=A0 * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_pu=
t()
> =C2=A0 * Cache clk rate in axi_pwmgen_ddata
> =C2=A0 * Don't assign pwm->chip.base, do assign pwm->chip.atomic
> * Remove redundant calls to clk_get_rate
> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
> =C2=A0 arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
> * Remove redundant clk struct from axi_pwmgen_ddata
> * Add self as module author
> * Add major version check for IP core
>=20
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pwm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 13 ++
> =C2=A0drivers/pwm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 246 ++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 261 insertions(+)
> =C2=A0create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a4ed5545680..2baa7a0a1c8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +F:	drivers/pwm/pwm-axi-pwmgen.c
> =C2=A0
> =C2=A0AXXIA I2C CONTROLLER
> =C2=A0M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d44b0e86adee 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le
> =C2=A0	=C2=A0 will be called pwm-atmel-tcb.
> =C2=A0
> +config PWM_AXI_PWMGEN
> +	tristate "Analog Devices AXI PWM generator"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP ||
> ARCH_INTEL_SOCFPGA || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	=C2=A0 This enables support for the Analog Devices AXI PWM generator.
> +
> +	=C2=A0 This is a configurable PWM generator with variable pulse width a=
nd
> +	=C2=A0 period.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called pwm-axi-pwmgen.
> +
> =C2=A0config PWM_BCM_IPROC
> =C2=A0	tristate "iProc PWM support"
> =C2=A0	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..8322089954e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
> =C2=A0obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
> =C2=A0obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
> =C2=A0obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..39d2c7be0cb4
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS
> + *
> + * Limitations:
> + * - The writes to registers for period and duty are shadowed until
> + *=C2=A0=C2=A0 LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the en=
d of the
> + *=C2=A0=C2=A0 current period.
> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
> + *=C2=A0=C2=A0 enabled channels, which could cause glitching on other ch=
annels. It
> + *=C2=A0=C2=A0 is therefore expected that channels are assigned harmonic=
 periods
> + *=C2=A0=C2=A0 and all have a single user coordinating this.
> + * - Supports normal polarity. Does not support changing polarity.
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define AXI_PWMGEN_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
> +#define AXI_PWMGEN_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
> +#define AXI_PWMGEN_VERSION_PATCH(x)	((x) & 0xff)
> +
> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00

Hi Trevor,

Just realized now that you should be using the macros already defined in

<linux/fpga/adi-axi-common.h>

- Nuno S=C3=A1



