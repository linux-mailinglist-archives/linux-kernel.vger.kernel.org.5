Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D877D0325
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbjJSU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbjJSU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:27:09 -0400
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.18.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4012A;
        Thu, 19 Oct 2023 13:27:05 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qtZbc-0001VV-0l;
        Thu, 19 Oct 2023 22:26:56 +0200
Message-ID: <c3ae7d79ab81621c66e939d804ca41e97eab79fb.camel@apitzsch.eu>
Subject: Re: [RESEND PATCH v7 2/5] leds: sun50i-a100: New driver for the
 A100 LED controller
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Samuel Holland <samuel@sholland.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Thu, 19 Oct 2023 22:26:53 +0200
In-Reply-To: <20221231235541.13568-3-samuel@sholland.org>
References: <20221231235541.13568-1-samuel@sholland.org>
         <20221231235541.13568-3-samuel@sholland.org>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-E1r6sizMenI0W/IRLtKu"
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E1r6sizMenI0W/IRLtKu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

there are two more things to change, which came up recently. See below.

Regards,
Andr=C3=A9

Am Samstag, dem 31.12.2022 um 17:55 -0600 schrieb Samuel Holland:
> Some Allwinner sunxi SoCs, starting with the A100, contain an LED
> controller designed to drive RGB LED pixels. Add a driver for it
> using
> the multicolor LED framework, and with LEDs defined in the device
> tree.
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> [...]
> diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-
> sun50i-a100.c
> new file mode 100644
> index 000000000000..30fa9be2cf2d
> --- /dev/null
> +++ b/drivers/leds/leds-sun50i-a100.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
> +//
> +// Partly based on drivers/leds/leds-turris-omnia.c, which is:
> +//=C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2020 by Marek Beh=C3=BAn <kabel=
@kernel.org>
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#define LEDC_CTRL_REG			0x0000
> +#define LEDC_CTRL_REG_DATA_LENGTH		(0x1fff << 16)
> +#define LEDC_CTRL_REG_RGB_MODE			(0x7 << 6)
> +#define LEDC_CTRL_REG_LEDC_EN			BIT(0)
> +#define LEDC_T01_TIMING_CTRL_REG	0x0004
> +#define LEDC_T01_TIMING_CTRL_REG_T1H		(0x3f << 21)
> +#define LEDC_T01_TIMING_CTRL_REG_T1L		(0x1f << 16)
> +#define LEDC_T01_TIMING_CTRL_REG_T0H		(0x1f << 6)
> +#define LEDC_T01_TIMING_CTRL_REG_T0L		(0x3f << 0)
> +#define LEDC_RESET_TIMING_CTRL_REG	0x000c
> +#define LEDC_RESET_TIMING_CTRL_REG_LED_NUM	(0x3ff << 0)
> +#define LEDC_DATA_REG			0x0014
> +#define LEDC_DMA_CTRL_REG		0x0018
> +#define LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL	(0x1f << 0)
> +#define LEDC_INT_CTRL_REG		0x001c
> +#define LEDC_INT_CTRL_REG_GLOBAL_INT_EN		BIT(5)
> +#define LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN	BIT(1)
> +#define LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN	BIT(0)
> +#define LEDC_INT_STS_REG		0x0020
> +#define LEDC_INT_STS_REG_FIFO_CPUREQ_INT	BIT(1)
> +#define LEDC_INT_STS_REG_TRANS_FINISH_INT	BIT(0)
> +
> +#define LEDC_FIFO_DEPTH			32
> +#define LEDC_MAX_LEDS			1024
> +
> +#define LEDS_TO_BYTES(n)		((n) * sizeof(u32))
> +
> +struct sun50i_a100_ledc_led {
> +	struct led_classdev_mc mc_cdev;
> +	struct mc_subled subled_info[3];
> +};
> +
> +#define to_ledc_led(mc) container_of(mc, struct
> sun50i_a100_ledc_led, mc_cdev)
> +
> +struct sun50i_a100_ledc_timing {
> +	u32 t0h_ns;
> +	u32 t0l_ns;
> +	u32 t1h_ns;
> +	u32 t1l_ns;
> +	u32 treset_ns;
> +};
> +
> +struct sun50i_a100_ledc {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *bus_clk;
> +	struct clk *mod_clk;
> +	struct reset_control *reset;
> +
> +	u32 *buffer;
> +	struct dma_chan *dma_chan;
> +	dma_addr_t dma_handle;
> +	int pio_length;
> +	int pio_offset;
> +
> +	spinlock_t lock;
> +	int next_length;
> +	bool xfer_active;
> +
> +	u32 format;
> +	struct sun50i_a100_ledc_timing timing;
> +
> +	int num_leds;
> +	struct sun50i_a100_ledc_led leds[];

Annotate struct with  __counted_by(num_leds).

> +};
> +
> +static int sun50i_a100_ledc_dma_xfer(struct sun50i_a100_ledc *priv,
> int length)
> +{
> +	struct dma_async_tx_descriptor *desc;
> +	dma_cookie_t cookie;
> +
> +	desc =3D dmaengine_prep_slave_single(priv->dma_chan, priv-
> >dma_handle,
> +					=C2=A0=C2=A0 LEDS_TO_BYTES(length),
> +					=C2=A0=C2=A0 DMA_MEM_TO_DEV, 0);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	cookie =3D dmaengine_submit(desc);
> +	if (dma_submit_error(cookie))
> +		return -EIO;
> +
> +	dma_async_issue_pending(priv->dma_chan);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_pio_xfer(struct sun50i_a100_ledc *priv,
> int length)
> +{
> +	u32 burst, offset, val;
> +
> +	if (length) {
> +		/* New transfer (FIFO is empty). */
> +		offset =3D 0;
> +		burst=C2=A0 =3D min(length, LEDC_FIFO_DEPTH);
> +	} else {
> +		/* Existing transfer (FIFO is half-full). */
> +		length =3D priv->pio_length;
> +		offset =3D priv->pio_offset;
> +		burst=C2=A0 =3D min(length, LEDC_FIFO_DEPTH / 2);
> +	}
> +
> +	iowrite32_rep(priv->base + LEDC_DATA_REG, priv->buffer +
> offset, burst);
> +
> +	if (burst < length) {
> +		priv->pio_length =3D length - burst;
> +		priv->pio_offset =3D offset + burst;
> +
> +		if (!offset) {
> +			val =3D readl(priv->base + LEDC_INT_CTRL_REG);
> +			val |=3D LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
> +			writel(val, priv->base + LEDC_INT_CTRL_REG);
> +		}
> +	} else {
> +		/* Disable the request IRQ once all data is written.
> */
> +		val =3D readl(priv->base + LEDC_INT_CTRL_REG);
> +		val &=3D ~LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
> +		writel(val, priv->base + LEDC_INT_CTRL_REG);
> +	}
> +}
> +
> +static void sun50i_a100_ledc_start_xfer(struct sun50i_a100_ledc
> *priv,
> +					int length)
> +{
> +	u32 val;
> +
> +	dev_dbg(priv->dev, "Updating %d LEDs\n", length);
> +
> +	val =3D readl(priv->base + LEDC_CTRL_REG);
> +	val &=3D ~LEDC_CTRL_REG_DATA_LENGTH;
> +	val |=3D length << 16 | LEDC_CTRL_REG_LEDC_EN;
> +	writel(val, priv->base + LEDC_CTRL_REG);
> +
> +	if (length > LEDC_FIFO_DEPTH) {
> +		int ret =3D sun50i_a100_ledc_dma_xfer(priv, length);
> +
> +		if (!ret)
> +			return;
> +
> +		dev_warn(priv->dev, "Failed to set up DMA: %d\n",
> ret);
> +	}
> +
> +	sun50i_a100_ledc_pio_xfer(priv, length);
> +}
> +
> +static irqreturn_t sun50i_a100_ledc_irq(int irq, void *dev_id)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_id;
> +	u32 val;
> +
> +	val =3D readl(priv->base + LEDC_INT_STS_REG);
> +
> +	if (val & LEDC_INT_STS_REG_TRANS_FINISH_INT) {
> +		int next_length;
> +
> +		/* Start the next transfer if needed. */
> +		spin_lock(&priv->lock);
> +		next_length =3D priv->next_length;
> +		if (next_length)
> +			priv->next_length =3D 0;
> +		else
> +			priv->xfer_active =3D false;
> +		spin_unlock(&priv->lock);
> +
> +		if (next_length)
> +			sun50i_a100_ledc_start_xfer(priv,
> next_length);
> +	} else if (val & LEDC_INT_STS_REG_FIFO_CPUREQ_INT) {
> +		/* Continue the current transfer. */
> +		sun50i_a100_ledc_pio_xfer(priv, 0);
> +	}
> +
> +	writel(val, priv->base + LEDC_INT_STS_REG);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sun50i_a100_ledc_brightness_set(struct led_classdev
> *cdev,
> +					=C2=A0=C2=A0=C2=A0 enum led_brightness
> brightness)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(cdev->dev-
> >parent);
> +	struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(cdev);
> +	struct sun50i_a100_ledc_led *led =3D to_ledc_led(mc_cdev);
> +	int addr =3D led - priv->leds;
> +	unsigned long flags;
> +	bool xfer_active;
> +	int next_length;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	priv->buffer[addr] =3D led->subled_info[0].brightness << 16 |
> +			=C2=A0=C2=A0=C2=A0=C2=A0 led->subled_info[1].brightness <<=C2=A0 8 |
> +			=C2=A0=C2=A0=C2=A0=C2=A0 led->subled_info[2].brightness;
> +
> +	dev_dbg(priv->dev, "LED %d -> #%06x\n", addr, priv-
> >buffer[addr]);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	next_length =3D max(priv->next_length, addr + 1);
> +	xfer_active =3D priv->xfer_active;
> +	if (xfer_active)
> +		priv->next_length =3D next_length;
> +	else
> +		priv->xfer_active =3D true;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	if (!xfer_active)
> +		sun50i_a100_ledc_start_xfer(priv, next_length);
> +}
> +
> +static const char *const sun50i_a100_ledc_formats[] =3D {
> +	"rgb",
> +	"rbg",
> +	"grb",
> +	"gbr",
> +	"brg",
> +	"bgr",
> +};
> +
> +static int sun50i_a100_ledc_parse_format(const struct device_node
> *np,
> +					 struct sun50i_a100_ledc
> *priv)
> +{
> +	const char *format =3D "grb";
> +	u32 i;
> +
> +	of_property_read_string(np, "allwinner,pixel-format",
> &format);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); ++i) {
> +		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
> +			priv->format =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(priv->dev, "Bad pixel format '%s'\n", format);
> +
> +	return -EINVAL;
> +}
> +
> +static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc
> *priv)
> +{
> +	u32 val;
> +
> +	val =3D readl(priv->base + LEDC_CTRL_REG);
> +	val &=3D ~LEDC_CTRL_REG_RGB_MODE;
> +	val |=3D priv->format << 6;
> +	writel(val, priv->base + LEDC_CTRL_REG);
> +}
> +
> +static const struct sun50i_a100_ledc_timing
> sun50i_a100_ledc_default_timing =3D {
> +	.t0h_ns =3D 336,
> +	.t0l_ns =3D 840,
> +	.t1h_ns =3D 882,
> +	.t1l_ns =3D 294,
> +	.treset_ns =3D 300000,
> +};
> +
> +static int sun50i_a100_ledc_parse_timing(const struct device_node
> *np,
> +					 struct sun50i_a100_ledc
> *priv)
> +{
> +	struct sun50i_a100_ledc_timing *timing =3D &priv->timing;
> +
> +	*timing =3D sun50i_a100_ledc_default_timing;
> +
> +	of_property_read_u32(np, "allwinner,t0h-ns", &timing-
> >t0h_ns);
> +	of_property_read_u32(np, "allwinner,t0l-ns", &timing-
> >t0l_ns);
> +	of_property_read_u32(np, "allwinner,t1h-ns", &timing-
> >t1h_ns);
> +	of_property_read_u32(np, "allwinner,t1l-ns", &timing-
> >t1l_ns);
> +	of_property_read_u32(np, "allwinner,treset-ns", &timing-
> >treset_ns);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc
> *priv)
> +{
> +	const struct sun50i_a100_ledc_timing *timing =3D &priv-
> >timing;
> +	unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
> +	u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
> +	u32 val;
> +
> +	val =3D (timing->t1h_ns / cycle_ns) << 21 |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (timing->t1l_ns / cycle_ns) << 16 |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (timing->t0h_ns / cycle_ns) <<=C2=A0 6 |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (timing->t0l_ns / cycle_ns);
> +	writel(val, priv->base + LEDC_T01_TIMING_CTRL_REG);
> +
> +	val =3D (timing->treset_ns / cycle_ns) << 16 |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (priv->num_leds - 1);
> +	writel(val, priv->base + LEDC_RESET_TIMING_CTRL_REG);
> +}
> +
> +static int sun50i_a100_ledc_resume(struct device *dev)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(dev);
> +	u32 val;
> +	int ret;
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(priv->bus_clk);
> +	if (ret)
> +		goto err_assert_reset;
> +
> +	ret =3D clk_prepare_enable(priv->mod_clk);
> +	if (ret)
> +		goto err_disable_bus_clk;
> +
> +	sun50i_a100_ledc_set_format(priv);
> +	sun50i_a100_ledc_set_timing(priv);
> +
> +	/* The trigger level must be at least the burst length. */
> +	val =3D readl(priv->base + LEDC_DMA_CTRL_REG);
> +	val &=3D ~LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL;
> +	val |=3D LEDC_FIFO_DEPTH / 2;
> +	writel(val, priv->base + LEDC_DMA_CTRL_REG);
> +
> +	val =3D LEDC_INT_CTRL_REG_GLOBAL_INT_EN |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN;
> +	writel(val, priv->base + LEDC_INT_CTRL_REG);
> +
> +	return 0;
> +
> +err_disable_bus_clk:
> +	clk_disable_unprepare(priv->bus_clk);
> +err_assert_reset:
> +	reset_control_assert(priv->reset);
> +
> +	return ret;
> +}
> +
> +static int sun50i_a100_ledc_suspend(struct device *dev)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->mod_clk);
> +	clk_disable_unprepare(priv->bus_clk);
> +	reset_control_assert(priv->reset);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_dma_cleanup(void *data)
> +{
> +	struct sun50i_a100_ledc *priv =3D data;
> +	struct device *dma_dev =3D dmaengine_get_dma_device(priv-
> >dma_chan);
> +
> +	if (priv->buffer)
> +		dma_free_wc(dma_dev, LEDS_TO_BYTES(priv->num_leds),
> +			=C2=A0=C2=A0=C2=A0 priv->buffer, priv->dma_handle);
> +	dma_release_channel(priv->dma_chan);
> +}
> +
> +static int sun50i_a100_ledc_probe(struct platform_device *pdev)
> +{
> +	const struct device_node *np =3D pdev->dev.of_node;
> +	struct dma_slave_config dma_cfg =3D {};
> +	struct led_init_data init_data =3D {};
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *child;
> +	struct sun50i_a100_ledc *priv;
> +	struct resource *mem;
> +	int count, irq, ret;
> +
> +	count =3D of_get_available_child_count(np);
> +	if (!count)
> +		return -ENODEV;
> +	if (count > LEDC_MAX_LEDS) {
> +		dev_err(dev, "Too many LEDs! (max is %d)\n",
> LEDC_MAX_LEDS);
> +		return -EINVAL;
> +	}
> +
> +	priv =3D devm_kzalloc(dev, struct_size(priv, leds, count),
> GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D dev;
> +	priv->num_leds =3D count;
> +	spin_lock_init(&priv->lock);
> +	dev_set_drvdata(dev, priv);
> +
> +	ret =3D sun50i_a100_ledc_parse_format(np, priv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sun50i_a100_ledc_parse_timing(np, priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0,
> &mem);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->bus_clk =3D devm_clk_get(dev, "bus");
> +	if (IS_ERR(priv->bus_clk))
> +		return PTR_ERR(priv->bus_clk);
> +
> +	priv->mod_clk =3D devm_clk_get(dev, "mod");
> +	if (IS_ERR(priv->mod_clk))
> +		return PTR_ERR(priv->mod_clk);
> +
> +	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->dma_chan =3D dma_request_chan(dev, "tx");
> +	if (IS_ERR(priv->dma_chan))
> +		return PTR_ERR(priv->dma_chan);
> +
> +	ret =3D devm_add_action_or_reset(dev,
> sun50i_a100_ledc_dma_cleanup, priv);
> +	if (ret)
> +		return ret;
> +
> +	dma_cfg.dst_addr	=3D mem->start + LEDC_DATA_REG;
> +	dma_cfg.dst_addr_width	=3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	dma_cfg.dst_maxburst	=3D LEDC_FIFO_DEPTH / 2;
> +	ret =3D dmaengine_slave_config(priv->dma_chan, &dma_cfg);
> +	if (ret)
> +		return ret;
> +
> +	priv->buffer =3D dma_alloc_wc(dmaengine_get_dma_device(priv-
> >dma_chan),
> +				=C2=A0=C2=A0=C2=A0 LEDS_TO_BYTES(priv->num_leds),
> +				=C2=A0=C2=A0=C2=A0 &priv->dma_handle, GFP_KERNEL);
> +	if (!priv->buffer)
> +		return -ENOMEM;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, sun50i_a100_ledc_irq,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, dev_name(dev), priv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sun50i_a100_ledc_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct sun50i_a100_ledc_led *led;
> +		struct led_classdev *cdev;
> +		u32 addr, color;
> +
> +		ret =3D of_property_read_u32(child, "reg", &addr);
> +		if (ret || addr >=3D count) {
> +			dev_err(dev, "LED 'reg' values must be from
> 0 to %d\n",
> +				priv->num_leds - 1);
> +			ret =3D -EINVAL;
> +			goto err_put_child;
> +		}
> +
> +		ret =3D of_property_read_u32(child, "color", &color);
> +		if (ret || color !=3D LED_COLOR_ID_RGB) {
> +			dev_err(dev, "LED 'color' must be
> LED_COLOR_ID_RGB\n");
> +			ret =3D -EINVAL;
> +			goto err_put_child;
> +		}
> +
> +		led =3D &priv->leds[addr];
> +
> +		led->subled_info[0].color_index =3D LED_COLOR_ID_RED;
> +		led->subled_info[0].channel =3D 0;
> +		led->subled_info[1].color_index =3D
> LED_COLOR_ID_GREEN;
> +		led->subled_info[1].channel =3D 1;
> +		led->subled_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +		led->subled_info[2].channel =3D 2;
> +
> +		led->mc_cdev.num_colors =3D ARRAY_SIZE(led-
> >subled_info);
> +		led->mc_cdev.subled_info =3D led->subled_info;
> +
> +		cdev =3D &led->mc_cdev.led_cdev;
> +		cdev->max_brightness =3D U8_MAX;
> +		cdev->brightness_set =3D
> sun50i_a100_ledc_brightness_set;
> +
> +		init_data.fwnode =3D of_fwnode_handle(child);
> +
> +		ret =3D devm_led_classdev_multicolor_register_ext(dev,
> +								&led
> ->mc_cdev,
> +								&ini
> t_data);
> +		if (ret) {
> +			dev_err(dev, "Failed to register LED %u:
> %d\n",
> +				addr, ret);
> +			goto err_put_child;
> +		}
> +	}
> +
> +	dev_info(dev, "Registered %d LEDs\n", priv->num_leds);
> +
> +	return 0;
> +
> +err_put_child:
> +	of_node_put(child);
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int sun50i_a100_ledc_remove(struct platform_device *pdev)
> +{
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +
> +	return 0;
> +}

The remove function should be void now.

> +
> +static void sun50i_a100_ledc_shutdown(struct platform_device *pdev)
> +{
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +}
> +
> +static const struct of_device_id sun50i_a100_ledc_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun50i-a100-ledc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_a100_ledc_of_match);
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(sun50i_a100_ledc_pm,
> +				sun50i_a100_ledc_suspend,
> +				sun50i_a100_ledc_resume);
> +
> +static struct platform_driver sun50i_a100_ledc_driver =3D {
> +	.probe		=3D sun50i_a100_ledc_probe,
> +	.remove		=3D sun50i_a100_ledc_remove,
> +	.shutdown	=3D sun50i_a100_ledc_shutdown,
> +	.driver		=3D {
> +		.name		=3D "sun50i-a100-ledc",
> +		.of_match_table	=3D sun50i_a100_ledc_of_match,
> +		.pm		=3D pm_ptr(&sun50i_a100_ledc_pm),
> +	},
> +};
> +module_platform_driver(sun50i_a100_ledc_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Allwinner A100 LED controller driver");
> +MODULE_LICENSE("GPL");


--=-E1r6sizMenI0W/IRLtKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEazlg6L1sjNt+krNCgnfiFzZ+STsFAmUxkQ0ACgkQgnfiFzZ+
STswFRAAnX6BZMXboca0Ng4dhNcU+OUKNnvT+MLSEP2xBZoy132PuBzqLQQU3eCz
4wWwQGAZTHI4VDrqubNtwfBnI7fmSmAq3ZMmxHoCo6qLa7RftmyXAnU/e8C2czpI
H51srxD2ywdSJD6Vk2XgF3s3pO0eCTtPkI3pnFs1CJ54FEsZQoxrPYF7NVtzCIAC
Ya2dYAI9N1wI47JSjuEoNM0wOpHp76Z5WA+dwHdgiP4xgAKT4J3+jSbS+WtHTyTH
pb7uQ3D12QxpaNQlikEnDAN8la14wPf4Vn8vJ/PzL2IGOA4zOnbZs66Cff/4J33Z
Vten0c3Zko5k2QBOZ8sr/XWpGHPF7tO0XwvQJbDk0MA9rez/YnU3uCbfMJJNM49k
SYrA3Cxajhxh8f9NKpt3elPjEHrTxKaHEscAeO3GJV2yFmuAos4OQ+Tb3mqiM+hu
PoRDPYZoZFDYjWMukivoJqat1GpRwYzPiI+9RIikMrJyPkLUgE1ND1BHw8r2BYjc
fCtxx/KZREZiBiEcRhLbRnWIeeXo7ICWdkV035eDu0kyxgVFfy4QwKErlwzZ2ab4
EO6cQ0lZ9c6JZRbCV5gUdqZyyMak1cnfk0R338vbX/hf7BzdFeH816kExq6YHiIG
TZCs40HBWkVV0r0E/TgDYNBEAp/y2cLyo2zHqQjkyz9nVmwWZyc=
=TfZl
-----END PGP SIGNATURE-----

--=-E1r6sizMenI0W/IRLtKu--
