Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E02784CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjHVWfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjHVWfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F130CF3;
        Tue, 22 Aug 2023 15:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D048640C5;
        Tue, 22 Aug 2023 22:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BDEC433C8;
        Tue, 22 Aug 2023 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743701;
        bh=4SThI4EuvWqgq7E+zQ8jIRtu4s3TqWYlc6rSEHWhW2A=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=jBpfAZt/tgAt+HicTIQMspA3O2cEENT8yfaXkJ+ffJEIJWl+thpOST8iijaIPUZ9c
         Cdoz51qVhWp9xkpvGGvS+sEqccoAygqpo/KeR/sRg3ENglyFBV1+t6mWUIC6CSvcqo
         6mqbBjGA216DZ1UDJwHjiuBtPpNsqeRs20/4TdTTUiTJIFmHHc1Che+sJrhZpOIH3M
         oVQeIPG6a8jsb6wC2GwqxHBeiryZ36ggDHYrs21BnE2u1c8a6cs9kvEh1ph6v+3MH9
         /yU4HWSUfP2ZK4UuT1kxxvJHINQiQc7vcH0G5hNQLUGJoIC+ea6oS1cbYxHZYz2iof
         9Mv5xTVgDt3Vw==
Message-ID: <a65a7d976be4212ef71fe32c4ed2dacb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230819134147.456060-3-andreas@kemnade.info>
References: <20230819134147.456060-1-andreas@kemnade.info> <20230819134147.456060-3-andreas@kemnade.info>
Subject: Re: [PATCH 2/3] clk: twl: add clock driver for TWL6032
From:   Stephen Boyd <sboyd@kernel.org>
To:     andreas@kemnade.info, bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, tony@atomide.com
Date:   Tue, 22 Aug 2023 15:34:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2023-08-19 06:41:46)
> diff --git a/drivers/clk/clk-twl.c b/drivers/clk/clk-twl.c
> new file mode 100644
> index 0000000000000..deb5742393bac
> --- /dev/null
> +++ b/drivers/clk/clk-twl.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock driver for twl device.
> + *
> + * inspired by the driver for the Palmas device
> + */
> +
> +#include <linux/clk.h>

Is this include used? Hopefully not. Please drop.

> +#include <linux/clk-provider.h>
> +#include <linux/mfd/twl.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define VREG_STATE              2
> +#define TWL6030_CFG_STATE_OFF   0x00
> +#define TWL6030_CFG_STATE_ON    0x01
> +#define TWL6030_CFG_STATE_MASK  0x03
> +
> +struct twl_clk32k_desc {
> +       const char *clk_name;
> +       u8 base;
> +};
> +
> +struct twl_clock_info {
> +       struct device *dev;
> +       struct clk_hw hw;
> +       const struct twl_clk32k_desc *clk_desc;
> +};
> +
> +static inline int
> +twlclk_read(struct twl_clock_info *info, unsigned int slave_subgp,
> +           unsigned int offset)
> +{
> +       u8 value;
> +       int status;
> +
> +       status =3D twl_i2c_read_u8(slave_subgp, &value,
> +                                info->clk_desc->base + offset);
> +       return (status < 0) ? status : value;
> +}
> +
> +static inline int
> +twlclk_write(struct twl_clock_info *info, unsigned int slave_subgp,
> +            unsigned int offset, u8 value)
> +{
> +       return twl_i2c_write_u8(slave_subgp, value,
> +                               info->clk_desc->base + offset);
> +}
> +
> +static inline struct twl_clock_info *to_twl_clks_info(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct twl_clock_info, hw);
> +}
> +
> +static unsigned long twl_clks_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       return 32768;
> +}
> +
> +static int twl6032_clks_prepare(struct clk_hw *hw)
> +{
> +       struct twl_clock_info *cinfo =3D to_twl_clks_info(hw);
> +       int ret;
> +
> +       ret =3D twlclk_write(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE,
> +                          TWL6030_CFG_STATE_ON);
> +       if (ret < 0)
> +               dev_err(cinfo->dev, "clk prepare failed\n");
> +
> +       return ret;
> +}
> +
> +static void twl6032_clks_unprepare(struct clk_hw *hw)
> +{
> +       struct twl_clock_info *cinfo =3D to_twl_clks_info(hw);
> +       int ret;
> +
> +       ret =3D twlclk_write(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE,
> +                          TWL6030_CFG_STATE_OFF);
> +       if (ret < 0)
> +               dev_err(cinfo->dev, "clk unprepare failed\n");
> +}
> +
> +static int twl6032_clks_is_prepared(struct clk_hw *hw)
> +{
> +       struct twl_clock_info *cinfo =3D to_twl_clks_info(hw);
> +       int val;
> +
> +       val =3D twlclk_read(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE);
> +       if (val < 0) {
> +               dev_err(cinfo->dev, "clk read failed\n");
> +               return val;
> +       }
> +
> +       val &=3D TWL6030_CFG_STATE_MASK;
> +
> +       return val =3D=3D TWL6030_CFG_STATE_ON;
> +}
> +
> +static const struct clk_ops twl6032_clks_ops =3D {
> +       .prepare        =3D twl6032_clks_prepare,
> +       .unprepare      =3D twl6032_clks_unprepare,
> +       .is_prepared    =3D twl6032_clks_is_prepared,
> +       .recalc_rate    =3D twl_clks_recalc_rate,
> +};
> +
> +struct twl_clks_of_match_data {
> +       struct clk_init_data init;
> +       const struct twl_clk32k_desc desc;
> +};
> +
> +static const struct twl_clks_of_match_data twl6032_of_clk32kg =3D {
> +       .init =3D {
> +               .name =3D "clk32kg",
> +               .ops =3D &twl6032_clks_ops,
> +               .flags =3D CLK_IGNORE_UNUSED,
> +       },
> +       .desc =3D {
> +               .clk_name =3D "clk32kg",
> +               .base =3D 0x8C,
> +       },
> +};
> +
> +static const struct twl_clks_of_match_data twl6032_of_clk32kaudio =3D {
> +       .init =3D {
> +               .name =3D "clk32kaudio",
> +               .ops =3D &twl6032_clks_ops,
> +               .flags =3D CLK_IGNORE_UNUSED,
> +       },
> +       .desc =3D {
> +               .clk_name =3D "clk32kaudio",
> +               .base =3D 0x8F,
> +       },
> +};
> +
> +static const struct of_device_id twl_clks_of_match[] =3D {
> +       {
> +               .compatible =3D "ti,twl6032-clk32kg",
> +               .data =3D &twl6032_of_clk32kg,
> +       },
> +       {
> +               .compatible =3D "ti,twl6032-clk32kaudio",
> +               .data =3D &twl6032_of_clk32kaudio,
> +       },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, twl_clks_of_match);

This array can be moved next to the driver so that it isn't tempting to
access the variable directly.

> +
> +static int twl_clks_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       const struct twl_clks_of_match_data *match_data;
> +       struct twl_clock_info *cinfo;
> +       int ret;
> +
> +       match_data =3D of_device_get_match_data(&pdev->dev);

Use device_get_match_data() instead.

> +       if (!match_data)
> +               return 1;
> +
> +       cinfo =3D devm_kzalloc(&pdev->dev, sizeof(*cinfo), GFP_KERNEL);
> +       if (!cinfo)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, cinfo);
> +
> +       cinfo->dev =3D &pdev->dev;
> +
> +       cinfo->clk_desc =3D &match_data->desc;
> +       cinfo->hw.init =3D &match_data->init;
> +       ret =3D devm_clk_hw_register(&pdev->dev, &cinfo->hw);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Fail to register clock %s, %d\n",
> +                       match_data->desc.clk_name, ret);
> +               return ret;
> +       }
> +
> +       ret =3D of_clk_add_hw_provider(node, of_clk_hw_simple_get, &cinfo=
->hw);

Use devm?

> +       if (ret < 0)
> +               dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret=
);
> +       return ret;
> +}
> +
> +static void twl_clks_remove(struct platform_device *pdev)
> +{
> +       of_clk_del_provider(pdev->dev.of_node);
> +}

And get rid of this entirely?

> +
> +static struct platform_driver twl_clks_driver =3D {
> +       .driver =3D {
> +               .name =3D "twl-clk",
> +               .of_match_table =3D twl_clks_of_match,
> +       },
> +       .probe =3D twl_clks_probe,
> +       .remove_new =3D twl_clks_remove,
> +};
> +
> +module_platform_driver(twl_clks_driver);
> +
> +MODULE_DESCRIPTION("Clock driver for TWL Series Devices");
> +MODULE_ALIAS("platform:twl-clk");

This alias is unnecessary?

> +MODULE_LICENSE("GPL");
