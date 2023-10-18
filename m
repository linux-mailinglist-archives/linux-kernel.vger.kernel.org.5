Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF87CE08B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbjJRO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbjJRO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:58:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30AA109;
        Wed, 18 Oct 2023 07:58:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C479C433C8;
        Wed, 18 Oct 2023 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641114;
        bh=mnkWVLZ9Y8i+zHIjgcDkOug6dQ2uTfJgT66hAd4Xvtc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QgD7Pp0V88krqY1oBxYwCS92ixQo//Vwtp9jh845KAT3jF0gjvx/sdf/eWVTjqp83
         +4VnOiVvJXRFRw43u0361PDY+WRPV5hWUmzJHadC8QHcBqN05SaiTyeGOXCaHKYXgP
         m3VI06pLpPTyEEZZG9uygZPgN3NCDU6kDPWwL3Q90Ex2MK4jUKcJopZoUo6D9BgNr5
         ylCytT9ugsX064yE+6RY6RRHqD5KHEOVIOHG0ehig1GR+hVtfemlIJxvJZzSkcrXnM
         NCGgYsYIEloCPy0TreK0hNLprCrp/8mRbWXvmfMmFmqTRxstrHxWRTSwPKvIHKHqKL
         NnTAybN5AQDwA==
Message-ID: <115e3643-d290-492c-926a-e11e9964ed3a@kernel.org>
Date:   Wed, 18 Oct 2023 23:58:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/26] PM / devfreq: rockchip-dfi: Add SoC specific
 init function
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
 <20231018061714.3553817-5-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231018061714.3553817-5-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 18. 15:16, Sascha Hauer wrote:
> Move the RK3399 specifics to a SoC specific init function to make
> the way free for supporting other SoCs later.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>      - use of_device_get_match_data()
>      - use a callback rather than a struct type as driver data
> 
>  drivers/devfreq/event/rockchip-dfi.c | 48 +++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index e19e5acaa362c..6b1ef29df7048 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <soc/rockchip/rk3399_grf.h>
>  
> @@ -55,27 +56,21 @@ struct rockchip_dfi {
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
>  	struct clk *clk;
> +	u32 ddr_type;
>  };
>  
>  static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs = dfi->regs;
> -	u32 val;
> -	u32 ddr_type;
> -
> -	/* get ddr type */
> -	regmap_read(dfi->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -		    RK3399_PMUGRF_DDRTYPE_MASK;
>  
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> @@ -167,8 +162,26 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
>  	.set_event = rockchip_dfi_set_event,
>  };
>  
> +static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> +{
> +	struct regmap *regmap_pmu = dfi->regmap_pmu;
> +	u32 val;
> +
> +	dfi->clk = devm_clk_get(dfi->dev, "pclk_ddr_mon");
> +	if (IS_ERR(dfi->clk))
> +		return dev_err_probe(dfi->dev, PTR_ERR(dfi->clk),
> +				     "Cannot get the clk pclk_ddr_mon\n");
> +
> +	/* get ddr type */
> +	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +			RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	return 0;
> +};
> +
>  static const struct of_device_id rockchip_dfi_id_match[] = {
> -	{ .compatible = "rockchip,rk3399-dfi" },
> +	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
> @@ -179,6 +192,12 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  	struct rockchip_dfi *dfi;
>  	struct devfreq_event_desc *desc;
>  	struct device_node *np = pdev->dev.of_node, *node;
> +	int (*soc_init)(struct rockchip_dfi *dfi);
> +	int ret;
> +
> +	soc_init = of_device_get_match_data(&pdev->dev);
> +	if (!soc_init)
> +		return -EINVAL;
>  
>  	dfi = devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
>  	if (!dfi)
> @@ -188,11 +207,6 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  	if (IS_ERR(dfi->regs))
>  		return PTR_ERR(dfi->regs);
>  
> -	dfi->clk = devm_clk_get(dev, "pclk_ddr_mon");
> -	if (IS_ERR(dfi->clk))
> -		return dev_err_probe(dev, PTR_ERR(dfi->clk),
> -				     "Cannot get the clk pclk_ddr_mon\n");
> -
>  	node = of_parse_phandle(np, "rockchip,pmu", 0);
>  	if (!node)
>  		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
> @@ -209,6 +223,10 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  	desc->driver_data = dfi;
>  	desc->name = np->name;
>  
> +	ret = soc_init(dfi);
> +	if (ret)
> +		return ret;
> +
>  	dfi->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
>  	if (IS_ERR(dfi->edev)) {
>  		dev_err(&pdev->dev,

Already applied it on v7.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

