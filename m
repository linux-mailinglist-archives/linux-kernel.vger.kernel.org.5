Return-Path: <linux-kernel+bounces-139905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B68A0901
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B011F24BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2213DBA8;
	Thu, 11 Apr 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH7UdWXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D813DDC7;
	Thu, 11 Apr 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818789; cv=none; b=gnGuw17qETSkl+FzUYGe79Pa17i4eTiCl7gwKivSFUiYHxPpVWJ2wtTKQkP2jwwmSBcUpD22t5EeK4PRzgZlFqqjnYZm8ggEPBJUBw1TXaxUauYnfoK43CUjHmDLwAxlDEGk/e2AEGyP9M1JfGAhyurG/9hyedDo0kx0SMFvdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818789; c=relaxed/simple;
	bh=xaLI0fp3VmDqufOJwM02NUZ9FWzb5WV1yeANJFtuFPM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IqdwrM8Nt8u5dkSDXVpWhsJKx/hCWeXFGoAxg8K6kFuddDACZ6XGYTdOWGLyMK8vbIkR+NEraeC7Tz5INq+iea1lthC4wbZ/TemfwFwgYpBxDG+qVAyT8CeT6kQhnNxCVSJ8SxGB0r/kN+hMJ7YUEYC19W8DHzdxBhwGjB317dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH7UdWXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDEEC433C7;
	Thu, 11 Apr 2024 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818788;
	bh=xaLI0fp3VmDqufOJwM02NUZ9FWzb5WV1yeANJFtuFPM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pH7UdWXoMbnCD9/Q4rAdREsY2vQA702z/76ojJTCcK+qdr/ZfoWY4ys0ZwK9wwz6m
	 A1gGF7N7Ctpa64M21riuaFOrza3o3cZyYnQHXoPyDSXBkuNrO2wlohxqZ5c5+1oD+Y
	 Zz7mBW8KHGoLI0dEtIeczoHFZ6+R8s0lE3krarsIEacAyGPVuS+abnfxZXZpFv+DzM
	 6mRkYuxMOzUQf7iZEd7UZRwu+A5E1EHrbA/fzQ3JaChigDuRvTi22OPorijNavO5MG
	 g4LJ9Zjd/rxNPW8D/gH25NlJnuGE/3pc2QGs436jXm1xNmy5Nmw42Apjd0/K+xmhPq
	 bQkSxk88Uo25A==
Message-ID: <8b517c5b165d2be77eaf02af1e031325.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240225-pll-v1-2-fad6511479c6@outlook.com>
References: <20240225-pll-v1-0-fad6511479c6@outlook.com> <20240225-pll-v1-2-fad6511479c6@outlook.com>
Subject: Re: [PATCH RFC 2/2] clk: hisilicon: add support for PLL
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>, forbidden405@outlook.com
Date: Wed, 10 Apr 2024 23:59:46 -0700
User-Agent: alot/0.10

Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:10)
> diff --git a/drivers/clk/hisilicon/clk-pll.c b/drivers/clk/hisilicon/clk-=
pll.c
> new file mode 100644
> index 000000000000..c5c07a65fcf4
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-pll.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PLL driver for HiSilicon SoCs
> + *
> + * Copyright 2024 (c) Yang Xiwen <forbidden405@outlook.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +
> +#include "clk.h"
> +
> +/* PLL has two conf regs in total */
> +#define HISI_PLL_CFG(n)                ((n) * 4)

Isn't HISI_PLL_CFG1 or HISI_PLL_CFG0 shorter then?

> +
> +/* reg 0 definitions */
> +#define HISI_PLL_FRAC          GENMASK(23, 0)
> +#define HISI_PLL_POSTDIV1      GENMASK(26, 24)
> +#define HISI_PLL_POSTDIV2      GENMASK(30, 28)
> +
> +/* reg 1 definitions */
> +#define HISI_PLL_FBDIV         GENMASK(11, 0)
> +#define HISI_PLL_REFDIV                GENMASK(17, 12)
> +#define HISI_PLL_PD            BIT(20)
> +#define HISI_PLL_FOUTVCOPD     BIT(21)
> +#define HISI_PLL_FOUT4PHASEPD  BIT(22)
> +#define HISI_PLL_FOUTPOSTDIVPD BIT(23)
> +#define HISI_PLL_DACPD         BIT(24)
> +#define HISI_PLL_DSMPD         BIT(25)
> +#define HISI_PLL_BYPASS                BIT(26)
> +
> +/*
> + * Datasheet said the maximum is 3.2GHz,
> + * but tests show it can be very high

Sounds like you're over-clocking. Just follow the datasheet please.

> + *
> + * Leave some margin here (8 GHz should be fine)
> + */
> +#define HISI_PLL_FOUTVCO_MAX_RATE      8000000000
> +/* 800 MHz */
> +#define HISI_PLL_FOUTVCO_MIN_RATE      800000000
> +
> +struct hisi_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +       u8              postdiv1, postdiv2, refdiv;
> +       u32             divisor;
> +};
> +
> +#define to_hisi_pll(_hw) container_of(_hw, struct hisi_pll, hw)
> +
> +static int hisi_pll_prepare(struct clk_hw *hw)
> +{
> +       struct hisi_pll *pll =3D to_hisi_pll(hw);
> +       u32 reg;
> +
> +       reg =3D readl(pll->base + HISI_PLL_CFG(0));
> +       pll->postdiv1 =3D FIELD_GET(HISI_PLL_POSTDIV1, reg);
> +       pll->postdiv2 =3D FIELD_GET(HISI_PLL_POSTDIV2, reg);
> +       // We don't use frac, clear it

Kernel comments are /* like this */

> +       reg &=3D ~HISI_PLL_FRAC;
> +       writel(reg, pll->base + HISI_PLL_CFG(0));
> +
> +       reg =3D readl(pll->base + HISI_PLL_CFG(1));
> +       pll->refdiv =3D FIELD_GET(HISI_PLL_REFDIV, reg);
> +
> +       pll->divisor =3D pll->refdiv * pll->postdiv1 * pll->postdiv2;
> +
> +       // return -EINVAL if boot loader does not init PLL correctly

Yeah we got that by reading the code, no comment needed.

> +       if (pll->divisor =3D=3D 0) {
> +               pr_err("%s: PLLs are not initialized by boot loader corre=
ctly!\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hisi_pll_set_rate(struct clk_hw *hw, ulong rate, ulong parent=
_rate)
> +{
> +       struct hisi_pll *pll =3D to_hisi_pll(hw);
> +       u64 fbdiv =3D rate * pll->divisor;
> +       u32 reg;
> +
> +       do_div(fbdiv, parent_rate);
> +
> +       reg =3D readl(pll->base + HISI_PLL_CFG(1));
> +       reg &=3D ~HISI_PLL_FBDIV;
> +       reg |=3D FIELD_PREP(HISI_PLL_FBDIV, fbdiv);
> +       writel(reg, pll->base + HISI_PLL_CFG(1));
> +
> +       /* TODO: wait for PLL lock? */

Yes?

> +
> +       return 0;
> +}
> +
> +static int hisi_pll_determine_rate(struct clk_hw *hw, struct clk_rate_re=
quest *req)
> +{
> +       struct hisi_pll *pll =3D to_hisi_pll(hw);
> +       u64 vco, ref_rate =3D req->best_parent_rate;
> +
> +       if (ref_rate =3D=3D 0)
> +               return -EINVAL;
> +
> +       do_div(ref_rate, pll->refdiv);
> +       vco =3D clamp(req->rate * (pll->postdiv1 * pll->postdiv2),
> +                   HISI_PLL_FOUTVCO_MIN_RATE, HISI_PLL_FOUTVCO_MAX_RATE);
> +       vco =3D rounddown(vco, ref_rate);
> +       if (vco < HISI_PLL_FOUTVCO_MIN_RATE)
> +               vco +=3D ref_rate;
> +
> +       do_div(vco, pll->postdiv1 * pll->postdiv2);
> +       req->rate =3D vco;
> +
> +       return 0;
> +}
> +
> +static ulong hisi_pll_recalc_rate(struct clk_hw *hw, ulong parent_rate)
> +{
> +       struct hisi_pll *pll =3D to_hisi_pll(hw);
> +       u32 reg, fbdiv;
> +
> +       reg =3D readl(pll->base + HISI_PLL_CFG(1));
> +       fbdiv =3D FIELD_GET(HISI_PLL_FBDIV, reg);
> +       parent_rate *=3D fbdiv;
> +       do_div(parent_rate, pll->divisor);
> +
> +       return parent_rate;
> +}
> +
> +static const struct clk_ops hisi_pll_ops =3D {
> +       .prepare        =3D hisi_pll_prepare,
> +       .set_rate       =3D hisi_pll_set_rate,
> +       .determine_rate =3D hisi_pll_determine_rate,
> +       .recalc_rate    =3D hisi_pll_recalc_rate,
> +};
> +
> +/*
> + * devm_hisi_pll_register - register a HiSilicon PLL

Use kernel-doc please https://docs.kernel.org/doc-guide/kernel-doc.html

> + *
> + * @dev: clk provider
> + * @name: clock name
> + * @parent_name: parent clock, usually 24MHz OSC
> + * #flags: CCF common flags
> + * @reg: register address

Missing Return:

> + */
> +struct clk *devm_clk_register_hisi_pll(struct device *dev, const char *n=
ame, const char *parent,
> +                                      unsigned int flags, void __iomem *=
reg)
> +{
> +       struct hisi_pll *pll;
> +       struct clk_init_data init;
> +
> +       pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (!parent)
> +               return ERR_PTR(-EINVAL);
> +
> +       init.name =3D name;
> +       init.ops =3D &hisi_pll_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D &parent;
> +       init.num_parents =3D 1;
> +
> +       pll->base =3D reg;
> +       pll->hw.init =3D &init;
> +
> +       return devm_clk_register(dev, &pll->hw);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_register_hisi_pll);
> diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
> index 7a9b42e1b027..8c59f3927152 100644
> --- a/drivers/clk/hisilicon/clk.h
> +++ b/drivers/clk/hisilicon/clk.h
> @@ -103,6 +103,14 @@ struct hisi_gate_clock {
>         const char              *alias;
>  };
> =20
> +struct hisi_pll_clock {
> +       unsigned int            id;
> +       const char              *name;
> +       const char              *parent_name;

No string parent names for new code. Use struct clk_parent_data or
clk_hw directly.

