Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E922B797EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjIGWpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIGWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105BD1BC8;
        Thu,  7 Sep 2023 15:45:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84770C433C9;
        Thu,  7 Sep 2023 22:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694126725;
        bh=7qyhLYr4pO5sm3ZD/DMx8wk96vJyeNH7OhlrfuB93Kw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TT3OHA8mbFVm6Xr+gpkeeWcGsyx+3GQQcF9ozKW8SRKSDNWgJG9Yembgzyar14fzk
         1KTBGFNL1miz4j0XyQ4RDyVkeBElYIQPi2b4K7owh4oxnxQj7Jkeqoa1pSHtNeitIL
         JEt/iFFzQQDai3JP9eSLYxPP3g7kH1quDcH0XOugpPqry7joRSBXa0PhXPxDtrgk1q
         TVwJJLhPfoYvjJ4CernbRSMsRRObfD6tofoECaXpkCa9b15aWchz0Ko8+JHJOEX0gG
         2+ZWkW/YNaV8MdgfSGQ/oY4WQFyvd2/0kb+iUl4PnWE8KhQo5zzT+HH/7A+1/+czwt
         5BUju2Mkb++FA==
Message-ID: <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-5-quic_luoj@quicinc.com> <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org> <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for qca8386/qca8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Thu, 07 Sep 2023 15:45:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jie Luo (2023-09-07 01:36:50)
>=20
> On 9/6/2023 5:36 AM, Stephen Boyd wrote:
> > Quoting Luo Jie (2023-09-01 02:18:23)
> >> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-q=
ca8k.c
> >> new file mode 100644
> >> index 000000000000..f9312735daf3
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/nsscc-qca8k.c
> >> @@ -0,0 +1,2179 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights re=
served.
> >> + */
> >> +
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >=20
> > Is platform_device include used?
> >=20
> will remove this.
>=20
> >> +#include <linux/regmap.h>
> >> +#include <linux/phy.h>
> >=20
> > Is the phy include used? Where is the mdio.h include?
>=20
> there is no PHY include, just the mdio_device is included, however the=20
> mii_bus->mdio_lock is needed by this clock controller.
>=20
> so "struct mii_bus" is needed and included by the header file phy.h,
> the mdio.h is included by phy.h.

Don't rely on implicit includes. It leads to compile errors if headers
are ever split/moved around. Just include mdio.h as you use it.

>=20
> >=20
> >> +
> >> +#include <dt-bindings/clock/qcom,qca8k-nsscc.h>
> >> +#include <dt-bindings/reset/qcom,qca8k-nsscc.h>
> >> +
> >> +#include "clk-branch.h"
> >> +#include "clk-rcg.h"
> >> +#include "clk-regmap.h"
> >> +#include "clk-regmap-divider.h"
> >> +#include "clk-regmap-mux.h"
> > [...]
> >> +
> >> +static const struct freq_tbl ftbl_nss_cc_mac5_rx_clk_src[] =3D {
> >> +       F(50000000, P_XO, 1, 0, 0),
> >> +       F(125000000, P_UNIPHY0_RX, 1, 0, 0),
> >> +       F(125000000, P_UNIPHY0_TX, 1, 0, 0),
> >> +       F(312500000, P_UNIPHY0_RX, 1, 0, 0),
> >> +       F(312500000, P_UNIPHY0_TX, 1, 0, 0),
> >=20
> > This frequency table looks like the parent should change rate...
>=20
> Yes, the parent need to change the rate for the different interface=20
> mode, PHY_INTERFACE_MODE_2500BASEX use 312.5M, PHY_INTERFACE_MODE_SGMII=20
> use 125M.
>=20
> >=20
> >> +       { }
> >> +};
> >> +
> >> +static struct clk_rcg2 nss_cc_mac5_rx_clk_src =3D {
> >> +       .cmd_rcgr =3D 0x154,
> >> +       .freq_tbl =3D ftbl_nss_cc_mac5_rx_clk_src,
> >> +       .hid_width =3D 5,
> >> +       .parent_map =3D nss_cc_uniphy0_rx_tx_map,
> >> +       .clkr.hw.init =3D &(const struct clk_init_data) {
> >> +               .name =3D "nss_cc_mac5_rx_clk_src",
> >> +               .parent_data =3D nss_cc_uniphy0_rx_tx_data,
> >> +               .num_parents =3D ARRAY_SIZE(nss_cc_uniphy0_rx_tx_data),
> >> +               .ops =3D &clk_rcg2_ops,
> >=20
> > ... but this doesn't have any CLK_SET_RATE_PARENT flag set. How does it
> > work?
>=20
> since it has the different parent clock rate 312.5M and 125M for the=20
> deffernet interface mode used. If the flag CLK_SET_RATE_PARENT is set,=20
> when we require to configure 25M clock rate for example, it may lead to=20
> the parent rate changed(312.5M/12.5 or 125M/5), which is not expected,=20
> the parent rate(312.5M or 125M) can't be changed, since the parent rate=20
> is decided by interface mode(PHY_INTERFACE_MODE_2500BASEX or=20
> PHY_INTERFACE_MODE_SGMII).
>=20
> the work flow:
> the parent of nss_cc_mac5_rx_clk_src is selected as 312.5M or 125M=20
> firstly, then configure the required clock rate of clk_branch.
>=20
> uniphy(312.5M or 125M) ---> RCG(nss_cc_mac5_rx_clk_src) ---> clk_branch.

Ok. So you're saying that the uniphy rate changes outside of the clk
framework? That is potentially troublesome because the clk framework
aggressively caches things to the point that if the parent of the RCG
changes rates the branch rate won't reflect the new rate. It looks like
none of that really matters in practice because the divider is always 1
here, but this will be confusing if a driver calls clk_get_rate() when
the uniphy rate has changed.

Why can't that be driven from the clk framework? Or why can't the uniphy
implement a clk provider that supports changing rates? If that was done,
then a driver could change the uniphy rate and the clk framework would
propagate the frequency down to all the children, recalculating the
rates along the way. It may even mean that there's nothing to do when
changing these clks, besides perhaps changing the parent?

>=20
> >=20
> >> +       },
> >> +};
> >> +
> >> +static struct clk_regmap_div nss_cc_mac5_rx_div_clk_src =3D {
> >> +       .reg =3D 0x15c,
> >> +       .shift =3D 0,
> >> +       .width =3D 4,
> >> +       .clkr =3D {
> >> +               .hw.init =3D &(const struct clk_init_data) {
> >> +                       .name =3D "nss_cc_mac5_rx_div_clk_src",
> > [...]
> >> +
> >> +static struct clk_branch nss_cc_mdio_master_ahb_clk =3D {
> >> +       .halt_reg =3D 0x19c,
> >> +       .halt_check =3D BRANCH_HALT,
> >> +       .clkr =3D {
> >> +               .enable_reg =3D 0x19c,
> >> +               .enable_mask =3D BIT(0),
> >> +               .hw.init =3D &(const struct clk_init_data) {
> >> +                       .name =3D "nss_cc_mdio_master_ahb_clk",
> >> +                       .parent_hws =3D (const struct clk_hw *[]) {
> >> +                               &nss_cc_ahb_clk_src.clkr.hw,
> >> +                       },
> >> +                       .num_parents =3D 1,
> >> +                       .flags =3D CLK_SET_RATE_PARENT | CLK_IS_CRITIC=
AL,
> >=20
> > Why can't we simply enable clks in probe that are critical? The regmap
> > operations are complicated?
>=20
> since these clocks with the flag CLK_IS_CRITICAL are the common clocks=20
> needed to be enabled for all devices no matter what work mode(qca8084 or =

> qca8386) used, which is base clock to enable to use the clock driver, to =

> enable these clocks by using flag CLK_IS_CRITICAL is simplier way and=20
> can simply the device probe driver and device tree definations.

Sure, but it also means you use the despised CLK_IS_CRITICAL flag when
it could simply be some code in probe that sets some bits for "boot
configuration". The benefit is that we don't register clks that do
practically nothing besides use resources in the kernel for a one time
operation at probe.

>=20
> >=20
> >> +};
> >> +
> >> +/* For each read/write operation of clock register, there are three M=
DIO frames
> >> + * sent to the device.
> >> + *
> >> + * 1. The high address part[31:8] of register is packaged into the fi=
rst MDIO frame.
> >> + * 2. The low address part[7:0] of register is packaged into the seco=
nd MDIO frame
> >> + *    with the low 16bit data to read/write.
> >> + * 3. The low address part[7:0] of register is packaged into the last=
 MDIO frame
> >> + *    with the high 16bit data to read/write.
> >> + *
> >> + * The clause22 MDIO frame format used by device is as below.
> >> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >> + * | ST| OP|   ADDR  |   REG   | TA|             DATA              |
> >> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >> + */
> >> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *pag=
e)
> >=20
> > split_addr() is too generic of a name. Please namespace this function to
> > something else.
>=20
> okay, maybe convert_reg_to_mii_addr?

Sure!

> >=20
> >> +               *val |=3D ret << 16;
> >> +       }
> >> +
> >> +       if (ret < 0)
> >> +               dev_err_ratelimited(&bus->dev, "fail to read qca8k mii=
 register\n");
> >> +
> >> +       return ret < 0 ? ret : 0;
> >> +}
> >> +
> >> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg,=
 u32 val)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D bus->write(bus, switch_phy_id, reg, lower_16_bits(val)=
);
> >> +       if (ret >=3D 0)
> >> +               ret =3D bus->write(bus, switch_phy_id, (reg | BIT(1)),=
 upper_16_bits(val));
> >> +
> >> +       if (ret < 0)
> >> +               dev_err_ratelimited(&bus->dev, "fail to write qca8k mi=
i register\n");
> >> +}
> >> +
> >> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 re=
g, u16 page)
> >=20
> > Regmap core has support for picking pages. Can that be used here?
>=20
> Hi Stephen,
> No, we can't depend on regmap to pick the page, since the MDIO bus is=20
> shared by qca8k device and PHY device, if there is a PHY device access,=20
> even if the page is not changed, we still need to configure the page=20
> again, so the page is alwasy configured for each register access, the=20
> sequence can't be interrupted.

Ok.

> >=20
> >> +};
> >> +
> >> +static const struct qcom_cc_desc nss_cc_qca8k_desc =3D {
> >> +       .config =3D &nss_cc_qca8k_regmap_config,
> >> +       .clks =3D nss_cc_qca8k_clocks,
> >> +       .num_clks =3D ARRAY_SIZE(nss_cc_qca8k_clocks),
> >> +       .resets =3D nss_cc_qca8k_resets,
> >> +       .num_resets =3D ARRAY_SIZE(nss_cc_qca8k_resets),
> >> +};
> >> +
> >> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
> >> +{
> >> +       struct regmap *regmap;
> >> +
> >> +       regmap =3D devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus,=
 nss_cc_qca8k_desc.config);
> >=20
> > Why can't we use devm_regmap_init_mdio() here? Is it because the device
> > needs special data marshaling per split_addr()?
>=20
> Hi Stephen,
> No, we can't use devm_regmap_init_mdio, which is for the standard PHY=20
> device access(clause22 and clause 45), but the clock device needs the=20
> special MDIO sequences for the register access.

Ok.
