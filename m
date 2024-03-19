Return-Path: <linux-kernel+bounces-108036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48F880517
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9210D1F232CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946CC39FC5;
	Tue, 19 Mar 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4UXRN68"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BA39ACD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874037; cv=none; b=GuauM4koJHFmqA0OfquQB+iwu3XFx7uBeVTceJBlg6Y2MnzFUkVdI9gsfRXmMeLKe3UQ/5dVPSDIfxVZzzc3WCXv+awTYsc6Z+FWJb8UyjPqrcLMRKsAVEGxiUThswarIqTUAWs+gZrOGIlPZ4H3ojbtaIC+tseWkQoIAjlLlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874037; c=relaxed/simple;
	bh=+6T83vgzF4M+f76SSlS8X08c5+c85AAPe3UsRbosQTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgV8f77xc1FiwbAh55VdzYDCaTmLlcKri1IEIuxxpOCSNfZ+1U09fxarUKGepzy4TtWE4z39fHo2TCbGJe8wsgKkaGCMcbioDPkyf3el75cG9fJm2wH6MToV2kzSeZ7agQusSkOgQFUOdAAaIaFha1sPCPgeiVrQkk2NWUpTkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4UXRN68; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso6191471276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710874035; x=1711478835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yETJkuJsleidnoVU1VURiPPCKkhUdvuJViHj8ytoVo=;
        b=O4UXRN68YDZAQWOm1hrO4UGaHQImGrrkTLdonWKGDWZ1OKA4cDd5ItiY1B0eZ9TI5X
         84u8+wFgPMKXpDqjY/MEBNjWfrVuN32HDkHBhJq0DA8sMqMbq3MLHMcHNX7dFOSmXjKO
         hQDdmm4Stz1IPSufF5+41AH5wBcb0kLWkFzpBi6tb1KfyezkGKR3ssdHiJISl1QpOWLg
         DOVz0aBkkDWP7zp+cAHZK5TmR08TmFfPjB4boUlWMPu0scDLvSIRdGXqUjJ1sZ6EyoIr
         ffGkyYGAnQ7IZ9G4PXJD9OD11zyJi7mEgZHTOL9ceE4IwAV7tFql2uwvKSzjy27rz2fO
         0Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874035; x=1711478835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yETJkuJsleidnoVU1VURiPPCKkhUdvuJViHj8ytoVo=;
        b=WYNkdXd/SI20YqtQfZCVpRmIZkEsdmhEI1ddQKvTBK+pHW7rM8X5Ex6bcH2VrHzv94
         EZbjPOAzAcXyLc3zOkoEJlDGC71JEej8CC3iLu/DqibseXULXJv6hp/gWypT7MWS57bO
         TFTWVr2QXTZqH62KLAVxxV7znjLEt5Cfvwvn2T1HIpM9HnqsNcXCNjYaNjUMUPUaG3iL
         G3i1YsB+O5r43JUGMYnaI6hBcJz2bsIiTVR/m+Aow3l35a/HXgp7TMsbIcwBgzcp9uHW
         QZv6A9XJJiApm1vpRHqr/7Z9m6etOFy2AHP7aL9IfykICd2kTq4KerDIhzuAY98q9JKV
         OQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1DPmFWDmzq2KqCqZpQPIv2H7W/0HRJJdMfeOBbUkIAoKxw0J8i2Qm5PgWS1W55UZf6qzKYWa941qZdf4MAnZTkaCHLxQNcGE8nmio
X-Gm-Message-State: AOJu0Yz+vFYTGrq0YHXPxYVQoCUVuRUiIY0P3Wp21VBp1NWNEryf8uMk
	U6QLmd3BElW9ieXIxZ6N3cr4zdGxRereEVMJs4PkDW1GZ2qLCkXIexyUQcQfqYgjpgxOgCzKf8O
	WimhBWcSexPWR6f4gY5K6S9Dil5yBeB3ttIddtQ==
X-Google-Smtp-Source: AGHT+IGMULIlFhDFq57eyKDjNgk7qs9vLLxO6TKj43NJhJ7I/TS+DqIXKpFQOhwcgta7HS9GgDe5owb16IxuTP5lU/w=
X-Received: by 2002:a25:830b:0:b0:dc6:ff32:aaea with SMTP id
 s11-20020a25830b000000b00dc6ff32aaeamr13507330ybk.24.1710874034601; Tue, 19
 Mar 2024 11:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301015118.30072-1-semen.protsenko@linaro.org>
In-Reply-To: <20240301015118.30072-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 19 Mar 2024 13:47:03 -0500
Message-ID: <CAPLW+4=_yD3ShU5DvLWFyEzVrVHNVCsB+4bVkP+x_boRmC-vEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] clk: samsung: Implement manual PLL control for
 ARM64 SoCs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:51=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Some ARM64 Exynos chips are capable to control PLL clocks automatically.
> For those chips, whether the PLL is controlled automatically or manually
> is chosen in PLL_CON1 register with next bits:
>
>     [28]  ENABLE_AUTOMATIC_CLKGATING
>     [1]   MANUAL_PLL_CTRL
>     [0]   AUTO_PLL_CTRL
>
> The bl2 bootloader sets 0x10000001 value for some PLL_CON1 registers,
> which means any attempt to control those PLLs manually (e.g.
> disabling/enabling those PLLs or changing MUX parent clocks) would lead
> to PLL lock timeout with error message like this:
>
>     Could not lock PLL ...
>
> At the moment, all Samsung clock drivers implement manual clock control.
> So in order to make it possible to control PLLs, corresponding PLL_CON1
> registers should be set to 0x2 first.
>
> Some older ARM64 chips don't implement the automatic clock control
> though. It also might be desirable to configure some PLLs for manual
> control, while keeping the default configuration for the rest. So it'd
> convenient to choose this PLL mode for each CMU separately. Introduce
> .manual_plls field to CMU structure to choose the PLL control mode.
> Because it'll be initialized with "false" in all existing CMU
> structures by default, it won't affect any existing clock drivers,
> allowing for this feature to be enabled gradually when it's needed with
> no change for the rest of users. In case .manual_plls is set, set
> PLL_CON1 registers to manual control, akin to what's already done for
> gate clocks in exynos_arm64_init_clocks(). Of course, PLL_CON1 registers
> should be added to corresponding struct samsung_cmu_info::clk_regs array
> to make sure they get initialized.
>
> No functional change. This patch adds a feature, but doesn't enable it
> for any users.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Hi Krzysztof,

If it looks ok to you, can you please apply this series?

    [PATCH 1/3] clk: samsung: Implement manual PLL control for ARM64 SoCs
    [PATCH 2/3] clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1
    [PATCH 3/3] arm64: dts: exynos: Add CPU clocks for Exynos850

That concludes my efforts on CPU clock enablement in Exynos850.

Thanks!

> Changes in v4:
>   - Turned register checking macros into static functions
>
> Changes in v3:
>   - none
>
> Changes in v2:
>   - none
>
>  drivers/clk/samsung/clk-exynos-arm64.c | 56 +++++++++++++++++++-------
>  drivers/clk/samsung/clk.h              |  4 ++
>  2 files changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung=
/clk-exynos-arm64.c
> index 6fb7194df7ab..bf7de21f329e 100644
> --- a/drivers/clk/samsung/clk-exynos-arm64.c
> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> @@ -17,10 +17,17 @@
>
>  #include "clk-exynos-arm64.h"
>
> +/* PLL register bits */
> +#define PLL_CON1_MANUAL                BIT(1)
> +
>  /* Gate register bits */
>  #define GATE_MANUAL            BIT(20)
>  #define GATE_ENABLE_HWACG      BIT(28)
>
> +/* PLL_CONx_PLL register offsets range */
> +#define PLL_CON_OFF_START      0x100
> +#define PLL_CON_OFF_END                0x600
> +
>  /* Gate register offsets range */
>  #define GATE_OFF_START         0x2000
>  #define GATE_OFF_END           0x2fff
> @@ -38,17 +45,36 @@ struct exynos_arm64_cmu_data {
>         struct samsung_clk_provider *ctx;
>  };
>
> +/* Check if the register offset is a GATE register */
> +static bool is_gate_reg(unsigned long off)
> +{
> +       return off >=3D GATE_OFF_START && off <=3D GATE_OFF_END;
> +}
> +
> +/* Check if the register offset is a PLL_CONx register */
> +static bool is_pll_conx_reg(unsigned long off)
> +{
> +       return off >=3D PLL_CON_OFF_START && off <=3D PLL_CON_OFF_END;
> +}
> +
> +/* Check if the register offset is a PLL_CON1 register */
> +static bool is_pll_con1_reg(unsigned long off)
> +{
> +       return is_pll_conx_reg(off) && (off & 0xf) =3D=3D 0x4 && !(off & =
0x10);
> +}
> +
>  /**
>   * exynos_arm64_init_clocks - Set clocks initial configuration
> - * @np:                        CMU device tree node with "reg" property =
(CMU addr)
> - * @reg_offs:          Register offsets array for clocks to init
> - * @reg_offs_len:      Number of register offsets in reg_offs array
> + * @np:                CMU device tree node with "reg" property (CMU add=
r)
> + * @cmu:       CMU data
>   *
> - * Set manual control mode for all gate clocks.
> + * Set manual control mode for all gate and PLL clocks.
>   */
>  static void __init exynos_arm64_init_clocks(struct device_node *np,
> -               const unsigned long *reg_offs, size_t reg_offs_len)
> +                                           const struct samsung_cmu_info=
 *cmu)
>  {
> +       const unsigned long *reg_offs =3D cmu->clk_regs;
> +       size_t reg_offs_len =3D cmu->nr_clk_regs;
>         void __iomem *reg_base;
>         size_t i;
>
> @@ -60,14 +86,14 @@ static void __init exynos_arm64_init_clocks(struct de=
vice_node *np,
>                 void __iomem *reg =3D reg_base + reg_offs[i];
>                 u32 val;
>
> -               /* Modify only gate clock registers */
> -               if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OF=
F_END)
> -                       continue;
> -
> -               val =3D readl(reg);
> -               val |=3D GATE_MANUAL;
> -               val &=3D ~GATE_ENABLE_HWACG;
> -               writel(val, reg);
> +               if (cmu->manual_plls && is_pll_con1_reg(reg_offs[i])) {
> +                       writel(PLL_CON1_MANUAL, reg);
> +               } else if (is_gate_reg(reg_offs[i])) {
> +                       val =3D readl(reg);
> +                       val |=3D GATE_MANUAL;
> +                       val &=3D ~GATE_ENABLE_HWACG;
> +                       writel(val, reg);
> +               }
>         }
>
>         iounmap(reg_base);
> @@ -177,7 +203,7 @@ void __init exynos_arm64_register_cmu(struct device *=
dev,
>                 pr_err("%s: could not enable bus clock %s; err =3D %d\n",
>                        __func__, cmu->clk_name, err);
>
> -       exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
> +       exynos_arm64_init_clocks(np, cmu);
>         samsung_cmu_register_one(np, cmu);
>  }
>
> @@ -224,7 +250,7 @@ int __init exynos_arm64_register_cmu_pm(struct platfo=
rm_device *pdev,
>                        __func__, cmu->clk_name, ret);
>
>         if (set_manual)
> -               exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_r=
egs);
> +               exynos_arm64_init_clocks(np, cmu);
>
>         reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(reg_base))
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index a763309e6f12..a70bd7cce39f 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -330,6 +330,7 @@ struct samsung_clock_reg_cache {
>   * @suspend_regs: list of clock registers to set before suspend
>   * @nr_suspend_regs: count of clock registers in @suspend_regs
>   * @clk_name: name of the parent clock needed for CMU register access
> + * @manual_plls: Enable manual control for PLL clocks
>   */
>  struct samsung_cmu_info {
>         const struct samsung_pll_clock *pll_clks;
> @@ -354,6 +355,9 @@ struct samsung_cmu_info {
>         const struct samsung_clk_reg_dump *suspend_regs;
>         unsigned int nr_suspend_regs;
>         const char *clk_name;
> +
> +       /* ARM64 Exynos CMUs */
> +       bool manual_plls;
>  };
>
>  struct samsung_clk_provider *samsung_clk_init(struct device *dev,
> --
> 2.39.2
>

