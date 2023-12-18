Return-Path: <linux-kernel+bounces-2893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24158163E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887A0B21AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637B71FAB;
	Mon, 18 Dec 2023 00:57:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10041863;
	Mon, 18 Dec 2023 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55E81FB;
	Sun, 17 Dec 2023 16:58:32 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C59CD3F738;
	Sun, 17 Dec 2023 16:57:44 -0800 (PST)
Date: Mon, 18 Dec 2023 00:57:30 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, John Watts <contact@jookia.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/3] thermal: sun8i: Add D1/T113s THS controller
 support
Message-ID: <20231218005730.59227952@minigeek.lan>
In-Reply-To: <20231217210629.131486-3-bigunclemax@gmail.com>
References: <20231217210629.131486-1-bigunclemax@gmail.com>
	<20231217210629.131486-3-bigunclemax@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 00:06:23 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> This patch adds a thermal sensor controller support for the D1/T113s,
> which is similar to the one on H6, but with only one sensor and
> different scale and offset values.

That looks alright to me, the offset and scale values match the
converted values in the manual, and the rest looks indeed the same as
used on the H6.

> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  drivers/thermal/sun8i_thermal.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index f989b55a8aa8..6a8e386dbc8d 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -606,6 +606,18 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
>  	.calc_temp = sun8i_ths_calc_temp,
>  };
>  
> +static const struct ths_thermal_chip sun20i_d1_ths = {
> +	.sensor_num = 1,
> +	.has_bus_clk_reset = true,
> +	.offset = 188552,
> +	.scale = 673,
> +	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +	.calibrate = sun50i_h6_ths_calibrate,
> +	.init = sun50i_h6_thermal_init,
> +	.irq_ack = sun50i_h6_irq_ack,
> +	.calc_temp = sun8i_ths_calc_temp,
> +};
> +
>  static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
>  	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -614,6 +626,7 @@ static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
>  	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
>  	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> +	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);


