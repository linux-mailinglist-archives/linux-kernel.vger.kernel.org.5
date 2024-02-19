Return-Path: <linux-kernel+bounces-72119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E1F85AF96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8813B214B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FB5674D;
	Mon, 19 Feb 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIT44/DT"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FA535DB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383965; cv=none; b=f+/lO4kIt0C/K5esM9SmcIZ4yhpheffHexWKkmlULYlQ4IkP0aK8V8KDlSdGLRcKEaV/qfsIPc01PZ9MTbzuGLKMoY+RNuoIPzlTKrrFrJtIXzpwxH4auBNPpoN7OzyR1/s8XH0KbfvENPIztvEhR0Ii5tVxJ340d97DLf/APZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383965; c=relaxed/simple;
	bh=p86UMxwvMHWplV7hAuPocjvT4OFzoMgJO/dd6G2KmZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0HBg9ayNcA7ZxwxoVaMPwGSP53KtvTGD+YegHOGzeuxVTje638BYtgns4sIFAx/ak8TtqP4yvnP20TI4SRM2CfN0n3aDoEIEG1+Lso65K8ikRApzSSvICddbZuGgUB2gpJXA1Yl4lMD+ORJptSCwGxq2EtQe9HzIT45L1td+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIT44/DT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4485314a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708383962; x=1708988762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCYUHWgj4tBlKPHDy7d0RJI2GMM1SdpVrxzwn2/Ye0w=;
        b=IIT44/DTbMIB/dP7fejQNV57CtdCCwTQLAHvBtbWDQnUxJy65tx+33gMVFFyJmJ7KC
         ctE/JfkdwhMTCVDfien/MoD1Q6WkAxOKq6KJXfzYqcEQ/cVblyMi9/wwq2VSBo9fchw7
         p9TfwQkBUro7B4SNFOs7BVCZh50RuT2GEoR4ikB/9w4mkFXm6zgiuIxnMJRUS2IgHF4r
         a3yF9WpOsGLlS/3DaCF1TywToWZf3UvARwqDWat6udbuCxz+dUCznQupmG4vQQGjlx9z
         KpnQNSKL1hph0EvDCP5llDfMHmZeTbVezSsV8JLA6O2XKDv/LKr3vUFzzBVj2KZcJcyA
         cGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708383962; x=1708988762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCYUHWgj4tBlKPHDy7d0RJI2GMM1SdpVrxzwn2/Ye0w=;
        b=MyFezIuhpfXrRbJ/tho0SlF3a1OASdw2sOAkvvo3VWp+tyjWKGb116/AZXraUS8djD
         Ipbi/XYgABUg4QRdOet1uijk+TvwQzgLixIP6YJhzIYQDPeubDsh/ReNFB26/phFNbu/
         QO+LmSfFk1EhjfOngQow0niXVHzpacU5/r5F0Qt74AiBaFJmQZt3lY3nSO9Yfu4LnyV8
         s6hPwVL19Ze+anitVWQBcq3ttkgLyoyGq/Q35Kt9RyehE1rNDEdK72SkwYf4qGNfkyVz
         hYjxseBlLWIjAFRYAhIsv4F9Y9kN/kvybzKmKw81uMh1Y2AnRKhajZlB/72Yd2SgIuq9
         nhZA==
X-Forwarded-Encrypted: i=1; AJvYcCVUSPV6EXRJ3vVvdNEl4Fj9i9JBuHxp1btXN9WexeUuRnzcNqp6T2lStdcsglw789p6e341aKtjdM15cMBfWqmK6B6tfHYawf0b+H5m
X-Gm-Message-State: AOJu0Ywn11DMdXrWkOLXYfsm6zq59I5gQEt6evFVx6UuyOFYiXVkDBg3
	mYQ0gjmshPdFYHum1O0OWm0cemlKTKOObWC7bFExsfgmTWWNayLZB6JTrFH9atrk1M7+wxdA2q1
	J3fmD+75yH5UK+R7XE76X7f/s3S3oDK0+io517Q==
X-Google-Smtp-Source: AGHT+IFqb+8be/+0ICnzL42ojWojSNSJ0vyWc/vop+iOw0f72aE1TTGE+s53VnsJEff9vnuyiTecUimJC2SPA8Zkgyg=
X-Received: by 2002:a17:902:ba94:b0:1d9:a890:e72f with SMTP id
 k20-20020a170902ba9400b001d9a890e72fmr10642789pls.50.1708383962189; Mon, 19
 Feb 2024 15:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219204238.356942-1-peter.griffin@linaro.org> <20240219204238.356942-2-peter.griffin@linaro.org>
In-Reply-To: <20240219204238.356942-2-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 19 Feb 2024 17:05:50 -0600
Message-ID: <CAPLW+4nOq_62rBhwRUf0RW0zTiGa+-Zpt+FLcTa87biX8Nq-BA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, linux@roeck-us.net, 
	wim@linux-watchdog.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	alexey.klimov@linaro.org, kernel-team@android.com, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:42=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
org> wrote:
>
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only write accessible in el3
> via an SMC call.
>
> As most Exynos drivers that need to write PMU registers currently obtain =
a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecas=
e
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmi=
o
> regmap like before. As regmaps abstract out the underlying register acces=
s
> changes to the leaf drivers are minimal.
>
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.
>
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
> Tested-by: Alexey Klimov <alexey.klimov@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> Changes since v4:
>  - Use same argument names as in struct regmap_config
>  - Remove inline keyword and rely on compiler
>  - Update kerneldoc wording
>  - property -> propname argument rename
>  - reverse Xmas tree
>  - Only call of_node_put() when of_parse_phandle is called
>  - Collect tags
>
> Changes since v3:
>  - Fix PMUALIVE_MASK
>  - Add TENSOR_ prefix
>  - clear SET_BITS bits on each loop iteration
>  - change set_bit to set_bits in func name
>  - Fix some alignment
>  - Add missing return on dev_err_probe
>  - Reduce indentation in loop
>
> Changes since v2
>  - Add select REGMAP to Kconfig
>  - Add constant for SET/CLEAR bits
>  - Replace kerneldoc with one line comment
>  - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
>  - remove superfluous extern keyword
>  - dev_err_probe() on probe error
>  - shorten regmcfg name
>  - no compatibles inside probe, use match data
>  - don't mix declarations with/without initializations
>  - tensor_sec_reg_read() use mmio to avoid access restrictions
>  - Collect up Reviewed-by
>  - const for regmap_config structs
> ---
>  drivers/soc/samsung/Kconfig            |   1 +
>  drivers/soc/samsung/exynos-pmu.c       | 235 ++++++++++++++++++++++++-
>  drivers/soc/samsung/exynos-pmu.h       |   1 +
>  include/linux/soc/samsung/exynos-pmu.h |  11 +-
>  4 files changed, 245 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 27ec99af77e3..1a5dfdc978dc 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -42,6 +42,7 @@ config EXYNOS_PMU
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
>         select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
>         select MFD_CORE
> +       select REGMAP_MMIO
>
>  # There is no need to enable these drivers for ARMv8
>  config EXYNOS_PMU_ARM_DRIVERS
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exyno=
s-pmu.c
> index 250537d7cfd6..d6ae8025fdb4 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -5,6 +5,7 @@
>  //
>  // Exynos - CPU PMU(Power Management Unit) support
>
> +#include <linux/arm-smccc.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/mfd/core.h>
> @@ -12,19 +13,134 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>  #include <linux/soc/samsung/exynos-pmu.h>
>
>  #include "exynos-pmu.h"
>
> +#define PMUALIVE_MASK                  GENMASK(13, 0)
> +#define TENSOR_SET_BITS                        (BIT(15) | BIT(14))
> +#define TENSOR_CLR_BITS                        BIT(15)
> +#define TENSOR_SMC_PMU_SEC_REG         0x82000504
> +#define TENSOR_PMUREG_READ             0
> +#define TENSOR_PMUREG_WRITE            1
> +#define TENSOR_PMUREG_RMW              2
> +
>  struct exynos_pmu_context {
>         struct device *dev;
>         const struct exynos_pmu_data *pmu_data;
> +       struct regmap *pmureg;
>  };
>
>  void __iomem *pmu_base_addr;
>  static struct exynos_pmu_context *pmu_context;
> +/* forward declaration */
> +static struct platform_driver exynos_pmu_driver;
> +
> +/*
> + * Tensor SoCs are configured so that PMU_ALIVE registers can only be wr=
itten
> + * from EL3, but are still read accessible. As Linux needs to write some=
 of
> + * these registers, the following functions are provided and exposed via
> + * regmap.
> + *
> + * Note: This SMC interface is known to be implemented on gs101 and deri=
vative
> + * SoCs.
> + */
> +
> +/* Write to a protected PMU register. */
> +static int tensor_sec_reg_write(void *context, unsigned int reg,
> +                               unsigned int val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)context;
> +
> +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> +                     TENSOR_PMUREG_WRITE, val, 0, 0, 0, 0, &res);
> +
> +       /* returns -EINVAL if access isn't allowed or 0 */
> +       if (res.a0)
> +               pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> +
> +       return (int)res.a0;
> +}
> +
> +/* Read/Modify/Write a protected PMU register. */
> +static int tensor_sec_reg_rmw(void *context, unsigned int reg,
> +                             unsigned int mask, unsigned int val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)context;
> +
> +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> +                     TENSOR_PMUREG_RMW, mask, val, 0, 0, 0, &res);
> +
> +       /* returns -EINVAL if access isn't allowed or 0 */
> +       if (res.a0)
> +               pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> +
> +       return (int)res.a0;
> +}
> +
> +/*
> + * Read a protected PMU register. All PMU registers can be read by Linux=
.
> + * Note: The SMC read register is not used, as only registers that can b=
e
> + * written are readable via SMC.
> + */
> +static int tensor_sec_reg_read(void *context, unsigned int reg,
> +                              unsigned int *val)
> +{
> +       *val =3D pmu_raw_readl(reg);
> +       return 0;
> +}
> +
> +/*
> + * For SoCs that have set/clear bit hardware this function can be used w=
hen
> + * the PMU register will be accessed by multiple masters.
> + *
> + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> + * tensor_set_bits_atomic(ctx, 0x3e80, 0x3f00, 0x3f00);
> + *
> + * Set bit 8, and clear bits 13:9 PMU reg offset 0x3e80
> + * tensor_set_bits_atomic(0x3e80, 0x100, 0x3f00);
> + */
> +static int tensor_set_bits_atomic(void *ctx, unsigned int offset, u32 va=
l,
> +                                 u32 mask)
> +{
> +       int ret;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < 32; i++) {
> +               if (!(mask & BIT(i)))
> +                       continue;
> +
> +               offset &=3D ~TENSOR_SET_BITS;
> +
> +               if (val & BIT(i))
> +                       offset |=3D TENSOR_SET_BITS;
> +               else
> +                       offset |=3D TENSOR_CLR_BITS;
> +
> +               ret =3D tensor_sec_reg_write(ctx, offset, i);
> +               if (ret)
> +                       return ret;
> +       }
> +       return ret;
> +}
> +
> +static int tensor_sec_update_bits(void *ctx, unsigned int reg,
> +                                 unsigned int mask, unsigned int val)
> +{
> +       /*
> +        * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF=
)
> +        * as the target registers can be accessed by multiple masters.
> +        */
> +       if (reg > PMUALIVE_MASK)
> +               return tensor_sec_reg_rmw(ctx, reg, mask, val);
> +
> +       return tensor_set_bits_atomic(ctx, reg, val, mask);
> +}
>
>  void pmu_raw_writel(u32 val, u32 offset)
>  {
> @@ -75,11 +191,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mo=
de)
>  #define exynos_pmu_data_arm_ptr(data)  NULL
>  #endif
>
> +static const struct regmap_config regmap_smccfg =3D {
> +       .name =3D "pmu_regs",
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .fast_io =3D true,
> +       .use_single_read =3D true,
> +       .use_single_write =3D true,
> +       .reg_read =3D tensor_sec_reg_read,
> +       .reg_write =3D tensor_sec_reg_write,
> +       .reg_update_bits =3D tensor_sec_update_bits,
> +};
> +
> +static const struct regmap_config regmap_mmiocfg =3D {
> +       .name =3D "pmu_regs",
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .fast_io =3D true,
> +       .use_single_read =3D true,
> +       .use_single_write =3D true,
> +};
> +
> +static const struct exynos_pmu_data gs101_pmu_data =3D {
> +       .pmu_secure =3D true
> +};
> +
>  /*
>   * PMU platform driver and devicetree bindings.
>   */
>  static const struct of_device_id exynos_pmu_of_device_ids[] =3D {
>         {
> +               .compatible =3D "google,gs101-pmu",
> +               .data =3D &gs101_pmu_data,
> +       }, {
>                 .compatible =3D "samsung,exynos3250-pmu",
>                 .data =3D exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
>         }, {
> @@ -113,19 +259,75 @@ static const struct mfd_cell exynos_pmu_devs[] =3D =
{
>         { .name =3D "exynos-clkout", },
>  };
>
> +/**
> + * exynos_get_pmu_regmap() - Obtain pmureg regmap
> + *
> + * Find the pmureg regmap previously configured in probe() and return re=
gmap
> + * pointer.
> + *
> + * Return: A pointer to regmap if found or ERR_PTR error value.
> + */
>  struct regmap *exynos_get_pmu_regmap(void)
>  {
>         struct device_node *np =3D of_find_matching_node(NULL,
>                                                       exynos_pmu_of_devic=
e_ids);
>         if (np)
> -               return syscon_node_to_regmap(np);
> +               return exynos_get_pmu_regmap_by_phandle(np, NULL);
>         return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
>
> +/**
> + * exynos_get_pmu_regmap_by_phandle() - Obtain pmureg regmap via phandle
> + * @np: Device node holding PMU phandle property
> + * @property: Name of property holding phandle value

This doesn't match the actual param name.

> + *
> + * Find the pmureg regmap previously configured in probe() and return re=
gmap
> + * pointer.
> + *
> + * Return: A pointer to regmap if found or ERR_PTR error value.
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +                                               const char *propname)
> +{
> +       struct exynos_pmu_context *ctx;
> +       struct device_node *pmu_np;
> +       struct device *dev;
> +
> +       if (propname)
> +               pmu_np =3D of_parse_phandle(np, propname, 0);
> +       else
> +               pmu_np =3D np;
> +
> +       if (!pmu_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       /*
> +        * Determine if exynos-pmu device has probed and therefore regmap
> +        * has been created and can be returned to the caller. Otherwise =
we
> +        * return -EPROBE_DEFER.
> +        */
> +       dev =3D driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> +                                           (void *)pmu_np);
> +
> +       if (propname)
> +               of_node_put(pmu_np);
> +
> +       if (!dev)
> +               return ERR_PTR(-EPROBE_DEFER);
> +
> +       ctx =3D dev_get_drvdata(dev);
> +
> +       return ctx->pmureg;
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> +
>  static int exynos_pmu_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> +       struct regmap_config pmu_regmcfg;
> +       struct regmap *regmap;
> +       struct resource *res;
>         int ret;
>
>         pmu_base_addr =3D devm_platform_ioremap_resource(pdev, 0);
> @@ -137,9 +339,38 @@ static int exynos_pmu_probe(struct platform_device *=
pdev)
>                         GFP_KERNEL);
>         if (!pmu_context)
>                 return -ENOMEM;
> -       pmu_context->dev =3D dev;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
> +
>         pmu_context->pmu_data =3D of_device_get_match_data(dev);
>
> +       /* For SoCs that secure PMU register writes use custom regmap */
> +       if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_secure) {
> +               pmu_regmcfg =3D regmap_smccfg;
> +               pmu_regmcfg.max_register =3D resource_size(res) -
> +                                          pmu_regmcfg.reg_stride;
> +               /* Need physical address for SMC call */
> +               regmap =3D devm_regmap_init(dev, NULL,
> +                                         (void *)(uintptr_t)res->start,
> +                                         &pmu_regmcfg);
> +       } else {
> +               /* All other SoCs use a MMIO regmap */
> +               pmu_regmcfg =3D regmap_mmiocfg;
> +               pmu_regmcfg.max_register =3D resource_size(res) -
> +                                          pmu_regmcfg.reg_stride;
> +               regmap =3D devm_regmap_init_mmio(dev, pmu_base_addr,
> +                                              &pmu_regmcfg);
> +       }
> +
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> +                                    "regmap init failed\n");
> +
> +       pmu_context->pmureg =3D regmap;
> +       pmu_context->dev =3D dev;
> +
>         if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_init)
>                 pmu_context->pmu_data->pmu_init();
>
> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exyno=
s-pmu.h
> index 1c652ffd79b4..0a49a2c9a08e 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -21,6 +21,7 @@ struct exynos_pmu_conf {
>  struct exynos_pmu_data {
>         const struct exynos_pmu_conf *pmu_config;
>         const struct exynos_pmu_conf *pmu_config_extra;
> +       bool pmu_secure;
>
>         void (*pmu_init)(void);
>         void (*powerdown_conf)(enum sys_powerdown);
> diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/s=
amsung/exynos-pmu.h
> index a4f5516cc956..2bd9d12d9a52 100644
> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -10,6 +10,7 @@
>  #define __LINUX_SOC_EXYNOS_PMU_H
>
>  struct regmap;
> +struct device_node;
>
>  enum sys_powerdown {
>         SYS_AFTR,
> @@ -20,12 +21,20 @@ enum sys_powerdown {
>
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>  #ifdef CONFIG_EXYNOS_PMU
> -extern struct regmap *exynos_get_pmu_regmap(void);
> +struct regmap *exynos_get_pmu_regmap(void);
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +                                               const char *propname);
>  #else
>  static inline struct regmap *exynos_get_pmu_regmap(void)
>  {
>         return ERR_PTR(-ENODEV);
>  }
> +
> +static inline struct regmap *exynos_get_pmu_regmap_by_phandle(struct dev=
ice_node *np,
> +                                                             const char =
*propname)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
>  #endif
>
>  #endif /* __LINUX_SOC_EXYNOS_PMU_H */
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

