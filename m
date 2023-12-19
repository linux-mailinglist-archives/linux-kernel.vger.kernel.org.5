Return-Path: <linux-kernel+bounces-6086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABA819473
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24731C242DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD33D0BC;
	Tue, 19 Dec 2023 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQWTkX72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6D3D0BD;
	Tue, 19 Dec 2023 23:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889BCC433C8;
	Tue, 19 Dec 2023 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703027774;
	bh=4LTuUnlzAhnPPUW3BQv1N8PC27cgGsXXiht0pyrfmx4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FQWTkX72neD17DeH1TSu+fwsCICJIw/fB5ZNuNXjA/PdlrFj7AKxnWkyJbi9cvHvk
	 IvF1LgZxgum4+Zdvfa0csutiDmgDByySRyOp11gyW8g0b9Gtt9o2wj7hUoeMDJWBhS
	 IhYXqgyWfBPB0mKIPn8kGxGLmKGchotRltUOhKSPnzCOdEMgbO8LNy5dm96q9PKxpR
	 LMZKAPdKktlwkmkM6BQ24Iaj2xrOM8r1jb6EzQk52A6jZLGLeYYxqcsctaC9v86NiL
	 GEmzxf4878qQMA2R9/xuja/rh/L/vNzvHPkv4q4Bn+GO0rajaGw5v/GTno7WasuBMo
	 N/m4y6xl8n8Bg==
Message-ID: <897fe92cfe40a086832e0c85ef5358bc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231218-mbly-clk-v1-4-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com> <20231218-mbly-clk-v1-4-44ce54108f06@bootlin.com>
Subject: Re: [PATCH 4/5] clk: eyeq5: add OSPI table-based divider clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 19 Dec 2023 15:16:12 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:19)
> The driver supports PLLs on the platform. Add the single divider clock
> of the platform.
>=20
> Helpers from include/linux/clk-provider.h could have been used if it was
> not for the use of regmap to access the register.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

This patch should be squashed with the previous one.

> diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
> index 74bcb8cec5c1..3382f4d870d7 100644
> --- a/drivers/clk/clk-eyeq5.c
> +++ b/drivers/clk/clk-eyeq5.c
> @@ -77,6 +78,8 @@ static const struct eq5c_pll {
[...]
> +
> +static int eq5c_ospi_div_set_rate(struct clk_hw *hw,
> +                                 unsigned long rate, unsigned long paren=
t_rate)
> +{
> +       struct eq5c_ospi_div *div =3D clk_hw_to_ospi_priv(hw);
> +       unsigned int val;
> +       int value, ret;
> +
> +       value =3D divider_get_val(rate, parent_rate, eq5c_ospi_div_table,
> +                               OLB_OSPI_DIV_MASK_WIDTH, 0);
> +       if (value < 0)
> +               return value;
> +
> +       ret =3D regmap_read(div->olb, OLB_OSPI_REG, &val);
> +       if (ret) {
> +               pr_err("%s: regmap_read failed: %d\n", __func__, ret);
> +               return -ret;

Why negative ret?

> +       }
> +
> +       val &=3D ~OLB_OSPI_DIV_MASK;
> +       val |=3D FIELD_PREP(OLB_OSPI_DIV_MASK, value);
> +
> +       ret =3D regmap_write(div->olb, OLB_OSPI_REG, val);
> +       if (ret) {
> +               pr_err("%s: regmap_write failed: %d\n", __func__, ret);
> +               return -ret;

Why negative ret?

> +       }
> +
> +       return 0;
> +}
> +
> +const struct clk_ops eq5c_ospi_div_ops =3D {

static?

> +       .recalc_rate =3D eq5c_ospi_div_recalc_rate,
> +       .round_rate =3D eq5c_ospi_div_round_rate,
> +       .determine_rate =3D eq5c_ospi_div_determine_rate,
> +       .set_rate =3D eq5c_ospi_div_set_rate,
> +};
> +
> +static struct clk_hw *eq5c_init_ospi_div(const struct clk_hw *parent,
> +                                        struct regmap *olb)
> +{
> +       struct eq5c_ospi_div *div;
> +       int ret;
> +
> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOENT);
> +
> +       div->olb =3D olb;
> +       div->hw.init =3D CLK_HW_INIT_HW(EQ5C_OSPI_DIV_CLK_NAME, parent,
> +                                     &eq5c_ospi_div_ops, 0);
> +
> +       ret =3D clk_hw_register(NULL, &div->hw);
> +       if (ret) {
> +               pr_err("failed registering div_ospi: %d\n", ret);
> +               kfree(div);
> +               return ERR_PTR(-ENOENT);

return ERR_PTR(ret)

> +       }
> +
> +       return &div->hw;
> +}
> +
>  static void eq5c_init(struct device_node *np)
>  {
>         struct device_node *parent_np =3D of_get_parent(np);

