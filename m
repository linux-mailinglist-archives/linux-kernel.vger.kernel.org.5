Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E814759F74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGSURI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGSURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE31FD3;
        Wed, 19 Jul 2023 13:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1596261812;
        Wed, 19 Jul 2023 20:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3BAC433C8;
        Wed, 19 Jul 2023 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689797824;
        bh=tS+UmFUsvHSzVCSb9zAeHafd9w8bzqEMC9uy2zf9JiQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZzYWSuDqIwk6YbW06R/flnSKN+TWm2q9J33OU8w3X7oBDb2QjD+beNMWwXVkfvdMM
         2KJFhet/wrNeiVEDyBJbhNQdgnLO1Au0Btj0PqKf+al9p5pwhIt7j+c97hsr3C4aMq
         i5gSDBXUU7X4efNldT6mrps3m3sgEYH32ExoRlTYkuFma1ZayTNUIgvrYv4HY3q2Qb
         SGupLOg+BYoNUQU+kzWV1AY1besq/AJ2CV2aqLtVnoQZx2oWo80qUVeQ12mtiKdedw
         LFClbchy3H9qBD52eW5diTUa7PTGhS2DD59Le/261VuNZz4OtXS/yl89iSLiJI7ytd
         Cw+u9NnxyY2RQ==
Message-ID: <ad757ed215d8f098472be370e3bbd961.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1689322259-13504-4-git-send-email-shengjiu.wang@nxp.com>
References: <1689322259-13504-1-git-send-email-shengjiu.wang@nxp.com> <1689322259-13504-4-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v5 3/3] clk: imx: imx8: add audio clock mux driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        conor+dt@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        mturquette@baylibre.com, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        shengjiu.wang@gmail.com
Date:   Wed, 19 Jul 2023 13:17:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shengjiu Wang (2023-07-14 01:10:59)
> diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-ac=
m.c
> new file mode 100644
> index 000000000000..445a0b38281c
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8-acm.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2023 NXP
> +//
> +
> +#include <dt-bindings/clock/imx8-clock.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +/**
> + * struct clk_imx_acm_pm_domains: structure for multi power domain
> + * @pd_dev: power domain device
> + * @pd_dev_link: power domain device link
> + * @num_domains: power domain nummber
> + */
> +struct clk_imx_acm_pm_domains {
> +       struct device **pd_dev;
> +       struct device_link **pd_dev_link;
> +       int    num_domains;
> +};
> +
> +/**
> + * struct clk_imx8_acm_sel: for clock mux
> + * @name: clock name
> + * @clkid: clock id
> + * @parents: clock parents
> + * @num_parents: clock parents number
> + * @reg: register offset
> + * @shift: bit shift in register
> + * @width: bits width
> + */
> +struct clk_imx8_acm_sel {
> +       const char                      *name;
> +       int                             clkid;
> +       const struct clk_parent_data    *parents;       /* For mux */
> +       int                             num_parents;
> +       u32                             reg;
> +       u8                              shift;
> +       u8                              width;
> +};
> +
> +/**
> + * struct imx8_acm_soc_data: soc specific data
> + * @sels: pointer to struct clk_imx8_acm_sel
> + * @num_sels: numbers of items
> + */
> +struct imx8_acm_soc_data {
> +       struct clk_imx8_acm_sel *sels;
> +       unsigned int num_sels;
> +};
> +
> +/**
> + * struct imx8_acm_priv: private structure

Compile with W=3D1 and see that this isn't kerneldoc. Please fix.

> + * @dev_pm: multi power domain
> + * @soc_data: pointer to soc data
> + * @reg: base address of registers
> + * @regs: save registers for suspend
> + */
> +struct imx8_acm_priv {
> +       struct clk_imx_acm_pm_domains dev_pm;
> +       const struct imx8_acm_soc_data *soc_data;
> +       void __iomem *reg;
> +       u32 regs[IMX_ADMA_ACM_CLK_END];
> +};
> +
> +static const struct clk_parent_data imx8qm_aud_clk_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },

There should only be fw_name here, or use an index. Presumably this
isn't migrating old code or bindings. Also, please add space after { and
before }.

> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.fw_name =3D "mlb_clk", .name =3D "mlb_clk" },
> +       {.fw_name =3D "hdmi_rx_mclk", .name =3D "hdmi_rx_mclk" },
> +       {.fw_name =3D "ext_aud_mclk0", .name =3D "ext_aud_mclk0" },
> +       {.fw_name =3D "ext_aud_mclk1", .name =3D "ext_aud_mclk1" },
> +       {.fw_name =3D "esai0_rx_clk", .name =3D "esai0_rx_clk" },
> +       {.fw_name =3D "esai0_rx_hf_clk", .name =3D "esai0_rx_hf_clk" },
> +       {.fw_name =3D "esai0_tx_clk", .name =3D "esai0_tx_clk" },
> +       {.fw_name =3D "esai0_tx_hf_clk", .name =3D "esai0_tx_hf_clk" },
> +       {.fw_name =3D "esai1_rx_clk", .name =3D "esai1_rx_clk" },
> +       {.fw_name =3D "esai1_rx_hf_clk", .name =3D "esai1_rx_hf_clk" },
> +       {.fw_name =3D "esai1_tx_clk", .name =3D "esai1_tx_clk" },
> +       {.fw_name =3D "esai1_tx_hf_clk", .name =3D "esai1_tx_hf_clk" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.fw_name =3D "spdif1_rx", .name =3D "spdif1_rx" },
> +       {.fw_name =3D "sai0_rx_bclk", .name =3D "sai0_rx_bclk" },
> +       {.fw_name =3D "sai0_tx_bclk", .name =3D "sai0_tx_bclk" },
> +       {.fw_name =3D "sai1_rx_bclk", .name =3D "sai1_rx_bclk" },
> +       {.fw_name =3D "sai1_tx_bclk", .name =3D "sai1_tx_bclk" },
> +       {.fw_name =3D "sai2_rx_bclk", .name =3D "sai2_rx_bclk" },
> +       {.fw_name =3D "sai3_rx_bclk", .name =3D "sai3_rx_bclk" },
> +       {.fw_name =3D "sai4_rx_bclk", .name =3D "sai4_rx_bclk" },
> +};
[...]
> +
> +static const struct clk_parent_data imx8dxl_mclk_out_sels[] =3D {
> +       {.fw_name =3D "aud_rec_clk0_lpcg_clk", .name =3D "aud_rec_clk0_lp=
cg_clk" },
> +       {.fw_name =3D "aud_rec_clk1_lpcg_clk", .name =3D "aud_rec_clk1_lp=
cg_clk" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.fw_name =3D "spdif0_rx", .name =3D "spdif0_rx" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },
> +       {.name =3D "dummy" },

Instead of dummy can you use -1 as the index?
