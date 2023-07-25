Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE77622C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGYT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGYT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:59:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D2122;
        Tue, 25 Jul 2023 12:59:26 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qOOBR-0007K0-M1; Tue, 25 Jul 2023 21:59:01 +0200
Date:   Tue, 25 Jul 2023 21:59:01 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/3] drivers: rng: add check status bit feature
Message-ID: <20230725195901.n2klvgz7outqaatk@viti.kaiser.cx>
References: <20230725141252.98848-1-avromanov@sberdevices.ru>
 <20230725141252.98848-2-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725141252.98848-2-avromanov@sberdevices.ru>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Romanov (avromanov@sberdevices.ru) wrote:

> For some Amlogic SOC's, mechanism to obtain random number
> has been changed. For example, S4 now uses status bit waiting algo.

> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  drivers/char/hw_random/meson-rng.c | 77 ++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)

> diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
> index a4eb8e35f13d..c6d7349630a1 100644
> --- a/drivers/char/hw_random/meson-rng.c
> +++ b/drivers/char/hw_random/meson-rng.c
> @@ -14,19 +14,65 @@
>  #include <linux/of.h>
>  #include <linux/clk.h>

> -#define RNG_DATA 0x00
> +struct meson_rng_priv {
> +	bool check_status_bit;
> +	unsigned int data_offset;
> +	unsigned int cfg_offset;
> +};

>  struct meson_rng_data {
>  	void __iomem *base;
>  	struct hwrng rng;
> +	struct device *dev;
> +	const struct meson_rng_priv *priv;
>  };

> +#define RUN_BIT			0
> +#define SEED_READY_STS_BIT	31
> +#define RETRY_CNT		100
> +
> +static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
> +{
> +	u32 status;
> +	u32 cnt = 0;
> +
> +	do {
> +		status = readl_relaxed(cfg_addr) & BIT(bit);
> +		cpu_relax();
> +	} while (status && (cnt++ < RETRY_CNT));
> +

Could you use readl_relaxed_poll_timeout here instead of open coding the
loop?

> +	if (status)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>  static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>  {
>  	struct meson_rng_data *data =
>  			container_of(rng, struct meson_rng_data, rng);
> +	const struct meson_rng_priv *priv = data->priv;
> +
> +	if (priv->check_status_bit) {
> +		void __iomem *cfg_addr = data->base + priv->cfg_offset;
> +		int err;
> +
> +		writel_relaxed(readl_relaxed(cfg_addr) | BIT(SEED_READY_STS_BIT), cfg_addr);

> -	*(u32 *)buf = readl_relaxed(data->base + RNG_DATA);
> +		err = meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
> +		if (err) {
> +			dev_err(data->dev, "Seed isn't ready, try again\n");
> +			return err;
> +		}
> +
> +		err = meson_rng_wait_status(cfg_addr, RUN_BIT);
> +		if (err) {
> +			dev_err(data->dev, "Can't get random number, try again\n");
> +			return err;
> +		}
> +	}
> +
> +	*(u32 *)buf = readl_relaxed(data->base + priv->data_offset);

>  	return sizeof(u32);
>  }
> @@ -41,6 +87,10 @@ static int meson_rng_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;

> +	data->priv = device_get_match_data(&pdev->dev);
> +	if (!data->priv)
> +		return -ENODEV;
> +
>  	data->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(data->base))
>  		return PTR_ERR(data->base);
> @@ -53,11 +103,32 @@ static int meson_rng_probe(struct platform_device *pdev)
>  	data->rng.name = pdev->name;
>  	data->rng.read = meson_rng_read;

> +	data->dev = &pdev->dev;
> +
>  	return devm_hwrng_register(dev, &data->rng);
>  }

> +static const struct meson_rng_priv meson_rng_priv = {
> +	.check_status_bit = false,
> +	.data_offset = 0x0,
> +	.cfg_offset = 0x0,
> +};
> +
> +static const struct meson_rng_priv meson_rng_priv_s4 = {
> +	.check_status_bit = true,
> +	.data_offset = 0x8,
> +	.cfg_offset = 0x0,
> +};
> +
>  static const struct of_device_id meson_rng_of_match[] = {
> -	{ .compatible = "amlogic,meson-rng", },
> +	{
> +		.compatible = "amlogic,meson-rng",
> +		.data = (void *)&meson_rng_priv,
> +	},
> +	{
> +		.compatible = "amlogic,meson-rng-s4",
> +		.data = (void *)&meson_rng_priv_s4,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_rng_of_match);
> -- 
> 2.38.1

