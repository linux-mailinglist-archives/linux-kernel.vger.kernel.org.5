Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A26F79D84D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjILSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjILSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:04:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A4E59;
        Tue, 12 Sep 2023 11:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB86C433C8;
        Tue, 12 Sep 2023 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541844;
        bh=C413WTTl+XcEFmSRmh21k8Ec3xNKfPk06vrSk2SqD9k=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=MzlPWkKkjcVGHwy1XBAtpP7d58dXjyJJW1mVltmpZmndjsuiKQ0533gUJwbpBesiS
         Z5BkDrEk/2i4RrWuaAFtZQ9YGxRlkK0rPIoBaLjo6M/ZXbSE7cZWAHokkkJe29iiL0
         a+3xSTpIe0i/Pfq/lSVK3dN3KbGdgE09bO9phIrQ28F+CO3nHg3JdVxqgYPAfXNP5Q
         3vzWh0z6zaqOpgcT86Jy8myvBQXIUzc/JzMz4MfvvMylkDpuE/vDUfV63cPer1248D
         l58hxDlB08f8zhLaWLQ3xdtcW+jKTO6kUO0N4VIWd+VdWq5XvU6QFJDEPIb56e/tZq
         UoA8j/ft69Zyw==
Message-ID: <9a8476b92ab656387fa7dcf54a0713a3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230911221346.1484543-5-andreas@kemnade.info>
References: <20230911221346.1484543-1-andreas@kemnade.info> <20230911221346.1484543-5-andreas@kemnade.info>
Subject: Re: [PATCH v3 4/5] clk: twl: add clock driver for TWL6032
From:   Stephen Boyd <sboyd@kernel.org>
To:     andreas@kemnade.info, bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tony@atomide.com
Date:   Tue, 12 Sep 2023 11:04:02 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2023-09-11 15:13:45)
> diff --git a/drivers/clk/clk-twl.c b/drivers/clk/clk-twl.c
> new file mode 100644
> index 0000000000000..09006e53a32ec
> --- /dev/null
> +++ b/drivers/clk/clk-twl.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock driver for twl device.
> + *
> + * inspired by the driver for the Palmas device
> + */
> +
> +#include <linux/clk.h>

Please drop this include unless it is used.

> +#include <linux/clk-provider.h>
> +#include <linux/mfd/twl.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define VREG_STATE              2
> +#define TWL6030_CFG_STATE_OFF   0x00
> +#define TWL6030_CFG_STATE_ON    0x01
> +#define TWL6030_CFG_STATE_MASK  0x03
> +
> +struct twl_clock_info {
> +       struct device *dev;
> +       u8 base;
> +       struct clk_hw hw;
> +};
[...]
> +
> +static int twl_clks_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *clk_data;
> +       const struct twl_clks_data *hw_data;
> +
> +       struct twl_clock_info *cinfo;
> +       int ret;
> +       int i;
> +       int count;
> +
> +       hw_data =3D twl6032_clks;
> +       for (count =3D 0; hw_data[count].init.name; count++)
> +               ;
> +
> +       clk_data =3D devm_kzalloc(&pdev->dev,
> +                               struct_size(clk_data, hws, count),
> +                               GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->num =3D count;
> +       cinfo =3D devm_kcalloc(&pdev->dev, count, sizeof(*cinfo), GFP_KER=
NEL);
> +       if (!cinfo)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < count; i++) {
> +               cinfo[i].base =3D hw_data[i].base;
> +               cinfo[i].dev =3D &pdev->dev;
> +               cinfo[i].hw.init =3D &hw_data[i].init;
> +               ret =3D devm_clk_hw_register(&pdev->dev, &cinfo[i].hw);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Fail to register clock %s, %=
d\n",

Use dev_err_probe()

> +                               hw_data[i].init.name, ret);
> +                       return ret;
> +               }
> +               clk_data->hws[i] =3D &cinfo[i].hw;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev,
> +                                         of_clk_hw_onecell_get, clk_data=
);
> +       if (ret < 0)
> +               dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret=
);

Use dev_err_probe()

> +
> +       return ret;
