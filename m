Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72E7776AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHIV0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3F138;
        Wed,  9 Aug 2023 14:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6F4164A41;
        Wed,  9 Aug 2023 21:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4A7C433C8;
        Wed,  9 Aug 2023 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691616404;
        bh=kBkC1V58t97IVsvmclGQ+bR6aEcDgZ9KrlmIvRsAWJU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HGGMvH4PWzKW/naNhfxTPFitbiQbW6O/lMToJ4chpLxUYk1gFpxViSb8RfDz+X/l4
         15t1rxLYALYjnWlkIlOM52BBWb9sLGRnig34wqmlqZehe++HXlinoxuBoakZgtXalb
         vgV3JICJBD/H2VIf17MHpPUTReD2eqPLKvmLMRNDHITV+0+Ks8KI7TPTU1xlKH4/+x
         VgJGv7xkfBCvEchc1Q7HI9w+W1nnQb20CPf9+T7YRwZb7IhITNNu02JO+cAyXPW4um
         nEtEnIVbo6f32J/aDWgSJ4IrmBVOpZSoe2m8IkQXhWc5pYf6cw8NWxJqyX3e/CPGsH
         zwH5MMSyTBnrg==
Message-ID: <d58e289b54f66c239ae09e94728716b7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com> <20230801010234.792557-1-niravkumar.l.rabara@intel.com> <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the Agilex5
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org,
        wen.ping.teh@intel.com
To:     niravkumar.l.rabara@intel.com
Date:   Wed, 09 Aug 2023 14:26:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting niravkumar.l.rabara@intel.com (2023-07-31 18:02:33)
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> index 74d21bd82710..3dcd0f233c17 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2023, Intel Corporation
>   */
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> @@ -9,6 +9,7 @@
>  #include <linux/platform_device.h>
> =20
>  #include <dt-bindings/clock/agilex-clock.h>
> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
> =20
>  #include "stratix10-clk.h"
> =20
> @@ -41,6 +42,67 @@ static const struct clk_parent_data mpu_free_mux[] =3D=
 {
>           .name =3D "f2s-free-clk", },
>  };
> =20
> +static const struct clk_parent_data core0_free_mux[] =3D {
> +       { .fw_name =3D "main_pll_c1",
> +         .name =3D "main_pll_c1", },

We're adding support for something new? Only set .fw_name in that case,
as .name will never be used. To do even better, set only .index so that
we don't do any string comparisons.

> +       { .fw_name =3D "peri_pll_c0",
> +         .name =3D "peri_pll_c0", },
> +       { .fw_name =3D "osc1",
> +         .name =3D "osc1", },
> +       { .fw_name =3D "cb-intosc-hs-div2-clk",
> +         .name =3D "cb-intosc-hs-div2-clk", },
> +       { .fw_name =3D "f2s-free-clk",
> +         .name =3D "f2s-free-clk", },
> +};
> +
[...]
> +
>  static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
>                                        int nums, struct stratix10_clock_d=
ata *data)
>  {
> @@ -535,6 +917,51 @@ static int n5x_clkmgr_init(struct platform_device *p=
dev)
>         return 0;
>  }
> =20
> +static int agilex5_clkmgr_init(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
> +       struct stratix10_clock_data *clk_data;

Maybe call this stratix_data so that clk_data.clk_data is
stratix_data.clk_data.

> +       struct resource *res;
> +       void __iomem *base;
> +       int i, num_clks;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);

This is a single function call, devm_platform_ioremap_resource().

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       num_clks =3D AGILEX5_NUM_CLKS;
> +
> +       clk_data =3D devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> +                                                num_clks), GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < num_clks; i++)
> +               clk_data->clk_data.hws[i] =3D ERR_PTR(-ENOENT);
> +
> +       clk_data->base =3D base;
> +       clk_data->clk_data.num =3D num_clks;
> +
> +       agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_cl=
ks),
> +                               clk_data);
> +
> +       agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
> +                                   ARRAY_SIZE(agilex5_main_perip_c_clks),
> +                                   clk_data);
> +
> +       agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
> +                                     ARRAY_SIZE(agilex5_main_perip_cnt_c=
lks),
> +                                     clk_data);
> +
> +       agilex_clk_register_gate(agilex5_gate_clks,
> +                                ARRAY_SIZE(agilex5_gate_clks), clk_data);
> +
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_=
data);

devm? Or when is this provider removed?

> +       return 0;
> +}
> +
>  static int agilex_clkmgr_probe(struct platform_device *pdev)
>  {
>         int (*probe_func)(struct platform_device *init_func);
