Return-Path: <linux-kernel+bounces-58490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12184E711
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CA128B15B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED286AD7;
	Thu,  8 Feb 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m084aO6Z"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B586138
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414441; cv=none; b=VVmVrzScMnORCvMcPtt6Ck3yg+J6iXlH/GZReYOQ/1RJY0a6W2viv6aFPDsJL/BaDZfNldnfQovItnp7ORjJXD/U3tapHNBhZ3EAfP/vLV1DKQoR+g1VCW2wEpSwmu3w2VXrVqFTyVWdHf3FSN0QRMGebOP10Ta6ZtLJEBqZLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414441; c=relaxed/simple;
	bh=sjmOce+8LIDFL3OBSoYD7R+2TQ/eC+CysjHIg240vKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sxu2y2h9cruptI75Mus2pizuydeTzeRVzbUvfI0NQzu+qjJ32NQKQ7eRavDO/OQjScNsfz6Fy0cvTh2FgPE+ReeqgKF8irK1MKUzIcdcZqmfPHozP1IjcMPDzr5Q7szwb/kNSga4oSmGHGVsSQMGWBE+y8twwldRKqJFvpffMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m084aO6Z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso6908a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707414438; x=1708019238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXTG2vqxJLbknQ7KTtKGVDCz66Q913TxBKExoXpQoeA=;
        b=m084aO6ZR10HHoSdF1kJ02kLTR0yk+hcPAoLpKATCSKhpcSjwCRTqtrt7kN14rzeZd
         rNHC2MI4A1kjeITFHAmjn/s9wUmtXGH3qyNIYCkIGwyIW3jDqtka6+DHLw0NEmE9rkSB
         2pgn9OL2ow/SBP6QYTiKSyyw+0dNYJOzK4STs/NKZPPKROWuk3j/ZKroP8mzVg12XNN5
         aUxkkfdojopry5s48HWLrDuDamOD2mzID1d6sxaGN7ML72OBIqpNmGY3L243SNgPvRYi
         NrcyP86oljS/y7m2fKXpbnZFlsPyyxTlvZAe0LvNNGNjqeouKKeDkEKgXBSWMg0n8ZLR
         IqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414438; x=1708019238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXTG2vqxJLbknQ7KTtKGVDCz66Q913TxBKExoXpQoeA=;
        b=R4d8s+nVse/dNvktDgGu3WESDDOp2bAU7HiEWUVwTkdzcMJvz5nnlA+RthaXYQPnkc
         l5CtR9Sl2l7GGoQVAL7aASRac8VtRFL51hDw3MzcN5wxLA1di5UbObTqF9bN/87y7mmy
         hIGLhMRNycCSnBp1hECD/E/JJ4K9mdv620hPhPqtwKkatBUktO0k1hv+zMBLkqkcgEbA
         RVatsDufmeY0TARnvfMMbLYkxhzX+tjOPIUrTLl2YrF4Z6uTBPz8Ppwv/bPkPv36LqmH
         62wwRJiOKHrC+ofBhdgprE5dyfYpGs7W/uUkc+8vBxpT8LajM7kGQQamZPSGDVQNyF+a
         Sp4Q==
X-Gm-Message-State: AOJu0Yx7/rpDWfJZNSBZh/2hAng6OuiBeMXlchQeEjqSdCq5VyvEj2il
	eikiiDduZVvs/csgmxOVqB3r+Fg8asISLIGVwQKnFOZTmbiTXsK49/SNtkl9JQtn4u4bxX0s/4l
	F8fbdDIp5Jh9/f9M2ccsLmi5+CKHoFNgb5dwXeQ==
X-Google-Smtp-Source: AGHT+IEhZkt486JKOv2guyl7r8i0S+LUV/0IDvDkeQIfJAUTukSS1fP9MhM2ATVSzKUPLOBDvFQpW6SBWdzRWebpdh4=
X-Received: by 2002:a05:6a20:a296:b0:19e:4ed7:127a with SMTP id
 a22-20020a056a20a29600b0019e4ed7127amr237683pzl.46.1707414438118; Thu, 08 Feb
 2024 09:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208161700.268570-1-peter.griffin@linaro.org> <20240208161700.268570-2-peter.griffin@linaro.org>
In-Reply-To: <20240208161700.268570-2-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 8 Feb 2024 11:47:07 -0600
Message-ID: <CAPLW+4myUZoGf3hpbp=sFjcKxS_iGQPyv=e84HRrPjEYRMvv=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] soc: samsung: exynos-pmu: Add regmap support for
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

On Thu, Feb 8, 2024 at 10:21=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
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
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

I'll test it on E850-96 shortly.

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
>  4 files changed, 243 insertions(+), 5 deletions(-)
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
> index 250537d7cfd6..b846e343fcdd 100644
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
> @@ -12,19 +13,132 @@
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
> +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned i=
nt val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)base;
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
> +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> +                             unsigned int mask, unsigned int val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)base;
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
> +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned in=
t *val)
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
> +static inline int tensor_set_bits_atomic(void *ctx, unsigned int offset,
> +                                        u32 val, u32 mask)
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
> @@ -75,11 +189,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mo=
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
> @@ -113,19 +257,73 @@ static const struct mfd_cell exynos_pmu_devs[] =3D =
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
> + * @np: Pointer to device's Device Tree node
> + * @property: Device Tree property name which references the pmu
> + *
> + * Find the pmureg regmap previously configured in probe() and return re=
gmap
> + * pointer.
> + *
> + * Return: A pointer to regmap if found or ERR_PTR error value.
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +                                               const char *property)
> +{
> +       struct device *dev;
> +       struct exynos_pmu_context *ctx;
> +       struct device_node *pmu_np;
> +
> +       if (property)
> +               pmu_np =3D of_parse_phandle(np, property, 0);
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
> +       of_node_put(pmu_np);
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
> @@ -133,13 +331,42 @@ static int exynos_pmu_probe(struct platform_device =
*pdev)
>                 return PTR_ERR(pmu_base_addr);
>
>         pmu_context =3D devm_kzalloc(&pdev->dev,
> -                       sizeof(struct exynos_pmu_context),
> -                       GFP_KERNEL);
> +                                  sizeof(struct exynos_pmu_context),
> +                                  GFP_KERNEL);
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
> index a4f5516cc956..e1c86640f6f7 100644
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
> +                                               const char *property);
>  #else
>  static inline struct regmap *exynos_get_pmu_regmap(void)
>  {
>         return ERR_PTR(-ENODEV);
>  }
> +
> +static inline struct regmap *exynos_get_pmu_regmap_by_phandle(struct dev=
ice_node *np,
> +                                                             const char =
*property)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
>  #endif
>
>  #endif /* __LINUX_SOC_EXYNOS_PMU_H */
> --
> 2.43.0.594.gd9cf4e227d-goog
>

