Return-Path: <linux-kernel+bounces-48013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F5845640
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACBFB25331
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1115D5AD;
	Thu,  1 Feb 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXZDC2m2"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055BF51A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786991; cv=none; b=Ab8KbTd5xErHs9ke8qwJQAxT+01YxJPKxmvvs8ePW8vxRZQkzFjiItAC4afrRcX2axo6MPLAXJ1Yu+OesA1kq0g8xOy5uLqOOuiS+2ZTs9n+387BI5slRlVP2+OJNBO1jE33xllHTiGMkt7BKoH9kJjW5CG8iCMsGGUbKJ2PzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786991; c=relaxed/simple;
	bh=+5MbqahCu667LRJdRrJ6n/sxiddqRpzxbwvLjQWoUP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4lCUhNy0GMcdq53Y5fcc+06/Gm+eAfCMmOgSNBJKVKiESa8cEMEdkn6fL7Id59eTxb7/nKpTj9v/5vXWE0gciuiB6ytBN7oTnegKqSfUnmQSnVd49z9mhfuGO4exM3ZauAvNLXdhIcnMvzUFEzVRh+OaUzgL9G78dSfzWROLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXZDC2m2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so697801276.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706786988; x=1707391788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNqMuAPZ807Iz28XvHNFca1pi/a5+NSOYYM8zrWizxw=;
        b=uXZDC2m2dgeN6Ug1K4u+Cz3Q3Y+06BJiKrAvUGkd381zFNMy9ZK2uDDvB6ttT4clB+
         WJYEiDAbabrEegVYoxO0CZP9cXdZN0KEM5k19p+GH69hGUiT3LPkNs85SQ+BCkegwY/h
         fXR1VhGIpQFWkV2kbF4t1nErKmU66puK/q4Jacqm6nSHBwba8OXVsrZXTyixKNr7xPxf
         Ls++4QWBZh4X1Y8+wUBWG1USuNcrMuthVwr6Drm2mCWyUqwGggxnr5WWR1Usxwrly+QA
         9eyN8oj3/TmR9VxaZF4cJ6XU7QaKe6O23NhcMDY0pPMvadx91gKhrSDu7KNFnKffIIMa
         I6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786988; x=1707391788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNqMuAPZ807Iz28XvHNFca1pi/a5+NSOYYM8zrWizxw=;
        b=EoUYGxcwvDO8TmZm65ZSRMYspt2MnS+z7NK2NiIw+pIRcLAu6BTdozlaGNl/2Ligxt
         oigx4xz1DBcRgbuaaM6hRo+ElqSjucmqDINY1RKV+KxsRGZQcVO8vPZ9Zot6S5Oez2JN
         eoTUMuBZaFchYI0bs302VGM5wIIdCJncTHHxXWkbRX5jP2jN2kGnMfCxrXwkTr/i/fm3
         o0IabxlzhC4u2RpvlbanpF7PZ/YNaXLx97CtChgZvBLanb1MapRbDfEBlvdlZdd4FnaY
         hJdeR/rHq3RnRA71UTryyEAqFA0Exz6e8qg4q7b/G4HNSDQXbJlti1/Gh0/JfwE5ucGi
         /lGw==
X-Gm-Message-State: AOJu0Yz6/PE0LSrv7wz4nnSDlOJFTLczhNWK0KgTUBiPM3V+aSqpOTII
	JDZifMwDioeTlbSSAwiY7nSNcIQb1hKep/Q+A9oL9Te0e7k240KJadafKbsi/k0soHd0Gp85IEb
	oiMUKv2BBumCqLTuW89v/KVXRedNsjBTdcQNSww==
X-Google-Smtp-Source: AGHT+IG5pl4ZawExtEwH0QOLwHfMbMcs9n8bRwsA0qKr4BEyu5jjqdySFzvOo1FFyg2yYW0O+JJd96X2XM3SgOa/D4A=
X-Received: by 2002:a25:add0:0:b0:dc6:bb86:ea1e with SMTP id
 d16-20020a25add0000000b00dc6bb86ea1emr1855392ybe.30.1706786987634; Thu, 01
 Feb 2024 03:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org> <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
In-Reply-To: <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 1 Feb 2024 11:29:36 +0000
Message-ID: <CADrjBPrNryfccFkrZWY9_4EfDF1h3VyqKcxh8vim9Hp8D_AhkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org, 
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review feedback.

On Tue, 30 Jan 2024 at 16:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/01/2024 22:19, Peter Griffin wrote:
> > Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> > security hardening reasons so that they are only accessible in el3 via an
> > SMC call.
> >
> > As most Exynos drivers that need to write PMU registers currently obtain a
> > regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> > is implemented in this driver using a custom regmap similar to syscon to
> > handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> > regmap like before. As regmaps abstract out the underlying register access
> > changes to the leaf drivers are minimal.
> >
> > A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> > that currently use syscon_regmap_lookup_by_phandle(). This also handles
> > deferred probing.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
> >  include/linux/soc/samsung/exynos-pmu.h |  10 ++
> >  2 files changed, 236 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> > index 250537d7cfd6..7bcc144e53a2 100644
> > --- a/drivers/soc/samsung/exynos-pmu.c
> > +++ b/drivers/soc/samsung/exynos-pmu.c
> > @@ -5,6 +5,7 @@
> >  //
> >  // Exynos - CPU PMU(Power Management Unit) support
> >
> > +#include <linux/arm-smccc.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/mfd/core.h>
> > @@ -12,20 +13,159 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> > +#include <linux/regmap.h>
> >
> >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> >  #include <linux/soc/samsung/exynos-pmu.h>
> >
> >  #include "exynos-pmu.h"
> >
> > +static struct platform_driver exynos_pmu_driver;
>
> I don't understand why do you need it. You can have only one
> pmu_context. The moment you probe second one, previous becomes invalid.
>
> I guess you want to parse phandle and check if just in case if it points
> to the right device, but still the original code is not ready for two
> PMU devices. I say either this problem should be solved entirely,
> allowing two devices, or just compare device node from phandle with
> device node of exynos_pmu_context->dev and return -EINVAL on mismatches.

I'll update like you suggest in v3.

>
> Anyway, keep all file scope declarations together.

OK
>
>
> > +
> > +#define PMUALIVE_MASK GENMASK(14, 0)
> > +
> >  struct exynos_pmu_context {
> >       struct device *dev;
> >       const struct exynos_pmu_data *pmu_data;
> > +     struct regmap *pmureg;
> >  };
> >
> >  void __iomem *pmu_base_addr;
> >  static struct exynos_pmu_context *pmu_context;
> >
> > +/*
> > + * Tensor SoCs are configured so that PMU_ALIVE registers can only be written
> > + * from el3. As Linux needs to write some of these registers, the following
> > + * SMC register read/write/read,write,modify interface is used.
> > + *
> > + * Note: This SMC interface is known to be implemented on gs101 and derivative
> > + * SoCs.
> > + */
> > +#define TENSOR_SMC_PMU_SEC_REG                       (0x82000504)
> > +#define TENSOR_PMUREG_READ                   0
> > +#define TENSOR_PMUREG_WRITE                  1
> > +#define TENSOR_PMUREG_RMW                    2
> > +
> > +/**
> > + * tensor_sec_reg_write
> > + * Write to a protected SMC register.
> > + * @base: Base address of PMU
> > + * @reg:  Address offset of register
> > + * @val:  Value to write
> > + * Return: (0) on success
> > + *
>
> This does not really look like kerneldoc...

Sam suggested that I remove the kerneldoc and replace with a one line
comment in v3
>
> > + */
> > +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned int val)
> > +{
> > +     struct arm_smccc_res res;
> > +     unsigned long pmu_base = (unsigned long)base;
> > +
> > +     arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> > +                   pmu_base + reg,
> > +                   TENSOR_PMUREG_WRITE,
> > +                   val, 0, 0, 0, 0, &res);
> > +
> > +     if (res.a0)
> > +             pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> > +
> > +     return (int)res.a0;
> > +}
> > +
> > +/**
> > + * tensor_sec_reg_rmw
> > + * Read/Modify/Write to a protected SMC register.
> > + * @base: Base address of PMU
> > + * @reg:  Address offset of register
> > + * @val:  Value to write
> > + * Return: (0) on success
> > + *
> > + */
> > +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> > +                           unsigned int mask, unsigned int val)
> > +{
> > +     struct arm_smccc_res res;
> > +     unsigned long pmu_base = (unsigned long)base;
> > +
> > +     arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> > +                   pmu_base + reg,
> > +                   TENSOR_PMUREG_RMW,
> > +                   mask, val, 0, 0, 0, &res);
> > +
> > +     if (res.a0)
> > +             pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> > +
> > +     return (int)res.a0;
> > +}
> > +
> > +/**
> > + * tensor_sec_reg_read
> > + * Read a protected SMC register.
> > + * @base: Base address of PMU
> > + * @reg:  Address offset of register
> > + * @val:  Value read
> > + * Return: (0) on success
> > + */
> > +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned int *val)
> > +{
> > +     struct arm_smccc_res res;
> > +     unsigned long pmu_base = (unsigned long)base;
> > +
> > +     arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> > +                   pmu_base + reg,
> > +                   TENSOR_PMUREG_READ,
> > +                   0, 0, 0, 0, 0, &res);
> > +
> > +     *val = (unsigned int)res.a0;
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +/*
> > + * For SoCs that have set/clear bit hardware this function
> > + * can be used when the PMU register will be accessed by
> > + * multiple masters.
> > + *
> > + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> > + * tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
> > + *
> > + * To clear bits 13:8 in PMU offset 0x3e80
> > + * tensor_set_bit_atomic(0x3e80, 0x0, 0x3f00);
> > + */
> > +static inline void tensor_set_bit_atomic(void *ctx, unsigned int offset,
> > +                                      u32 val, u32 mask)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < 32; i++) {
> > +             if (mask & BIT(i)) {
> > +                     if (val & BIT(i)) {
> > +                             offset |= 0xc000;
> > +                             tensor_sec_reg_write(ctx, offset, i);
> > +                     } else {
> > +                             offset |= 0x8000;
> > +                             tensor_sec_reg_write(ctx, offset, i);
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +int tensor_sec_update_bits(void *ctx, unsigned int reg, unsigned int mask, unsigned int val)
> > +{
> > +     int ret = 0;
> > +
> > +     /*
> > +      * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
> > +      * as the target registers can be accessed by multiple masters.
> > +      */
> > +     if (reg > PMUALIVE_MASK)
> > +             return tensor_sec_reg_rmw(ctx, reg, mask, val);
> > +
> > +     tensor_set_bit_atomic(ctx, reg, val, mask);
> > +
> > +     return ret;
> > +}
> > +
> >  void pmu_raw_writel(u32 val, u32 offset)
> >  {
> >       writel_relaxed(val, pmu_base_addr + offset);
> > @@ -80,6 +220,8 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
> >   */
> >  static const struct of_device_id exynos_pmu_of_device_ids[] = {
> >       {
> > +             .compatible = "google,gs101-pmu",
> > +     }, {
> >               .compatible = "samsung,exynos3250-pmu",
> >               .data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
> >       }, {
> > @@ -113,19 +255,73 @@ static const struct mfd_cell exynos_pmu_devs[] = {
> >       { .name = "exynos-clkout", },
> >  };
> >
> > +/**
> > + * exynos_get_pmu_regmap
> > + * Find the pmureg previously configured in probe() and return regmap property.
> > + * Return: regmap if found or error if not found.
> > + */
> >  struct regmap *exynos_get_pmu_regmap(void)
> >  {
> >       struct device_node *np = of_find_matching_node(NULL,
> >                                                     exynos_pmu_of_device_ids);
> >       if (np)
> > -             return syscon_node_to_regmap(np);
> > +             return exynos_get_pmu_regmap_by_phandle(np, NULL);
> >       return ERR_PTR(-ENODEV);
> >  }
> >  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
> >
> > +/**
> > + * exynos_get_pmu_regmap_by_phandle
> > + * Find the pmureg previously configured in probe() and return regmap property.
> > + * Return: regmap if found or error if not found.
>
> Return is the last. This does not look tested - make htmldocs, make W=1

Thanks, will fix and test in v3.

>
> > + *
> > + * @np: Pointer to device's Device Tree node
> > + * @property: Device Tree property name which references the pmu
> > + */
> > +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> > +                                             const char *property)
> > +{
> > +     struct device *dev;
> > +     struct exynos_pmu_context *ctx;
> > +     struct device_node *pmu_np;
> > +
> > +     if (property)
> > +             pmu_np = of_parse_phandle(np, property, 0);
> > +     else
> > +             pmu_np = np;
> > +
> > +     if (!pmu_np)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> > +                                         (void *)pmu_np);
> > +     of_node_put(pmu_np);
> > +     if (!dev)
> > +             return ERR_PTR(-EPROBE_DEFER);
> > +
> > +     ctx = dev_get_drvdata(dev);
> > +
> > +     return ctx->pmureg;
> > +}
> > +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> > +
> > +static struct regmap_config pmu_regs_regmap_cfg = {
> > +     .name = "pmu_regs",
> > +     .reg_bits = 32,
> > +     .reg_stride = 4,
> > +     .val_bits = 32,
> > +     .fast_io = true,
> > +     .use_single_read = true,
> > +     .use_single_write = true,
> > +};
> > +
> >  static int exynos_pmu_probe(struct platform_device *pdev)
> >  {
> > +     struct resource *res;
> > +     struct regmap *regmap;
> > +     struct regmap_config pmuregmap_config = pmu_regs_regmap_cfg;
> >       struct device *dev = &pdev->dev;
> > +     struct device_node *np = dev->of_node;
>
> Please do not mix order declarations with and without initializations. I
> propose first ones with initializations, followed by ones without.

Will fix.

>
> >       int ret;
> >
> >       pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
> > @@ -137,6 +333,35 @@ static int exynos_pmu_probe(struct platform_device *pdev)
> >                       GFP_KERNEL);
> >       if (!pmu_context)
> >               return -ENOMEM;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENODEV;
> > +
> > +     pmuregmap_config.max_register = resource_size(res) -
> > +                                  pmuregmap_config.reg_stride;
> > +
> > +     if (of_device_is_compatible(np, "google,gs101-pmu")) {
>
> No compatibles inside the probe. Use driver match data. This applies to
> all drivers in all subsystems.

Noted, will fix in v3.

>
> > +             pmuregmap_config.reg_read = tensor_sec_reg_read;
> > +             pmuregmap_config.reg_write = tensor_sec_reg_write;
> > +             pmuregmap_config.reg_update_bits = tensor_sec_update_bits;
>
> No, regmap_config should be const and please use match data.

Are you sure you want the regmap_config struct const?

In my draft v3 I have implemented it so far having a regmap_smccfg
struct which sets all the configuration apart from max_register field
(used by gs101) and a regmap_mmiocfg struct (used by all other
exynos-pmu SoCs). The choice over which regmap_config to register is
made via match data exynos_pmu_data flag 'pmu_secure' which is set
only for gs101. That avoids having to define exynos_pmu_data structs
for the other exynos SoCs that currently don't really need them
(exynos7, exynos850, exynos5443, exyno5410 etc).

But I still wish to set at runtime the regmap_config.max_register
field based on the resource size coming from DT. Having the structs
const would prohibit that and mean we need to specify many more
regmap_config structs where the only difference is the max_register
field.

Is the above approach acceptable for you?

>
> > +
> > +             /* Need physical address for SMC call */
> > +             regmap = devm_regmap_init(dev, NULL,
> > +                                       (void *)(uintptr_t)res->start,
> > +                                       &pmuregmap_config);
> > +     } else {
> > +             pmuregmap_config.max_register = resource_size(res) - 4;
> > +             regmap = devm_regmap_init_mmio(dev, pmu_base_addr,
> > +                                            &pmuregmap_config);
> > +     }
> > +
> > +     if (IS_ERR(regmap)) {
> > +             pr_err("regmap init failed\n");
>
> dev_err

Will fix

>
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     pmu_context->pmureg = regmap;
> >       pmu_context->dev = dev;
> >       pmu_context->pmu_data = of_device_get_match_data(dev);
> >
> > diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
> > index a4f5516cc956..68fb01ba6bef 100644
> > --- a/include/linux/soc/samsung/exynos-pmu.h
> > +++ b/include/linux/soc/samsung/exynos-pmu.h
> > @@ -21,11 +21,21 @@ enum sys_powerdown {
> >  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
> >  #ifdef CONFIG_EXYNOS_PMU
> >  extern struct regmap *exynos_get_pmu_regmap(void);
> > +
> > +extern struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> > +                                                    const char *property);
>
> Drop extern from new code. I understand it makes it inconsistent but it
> extern does not matter, so at some point we will clean all existing code...

Will fix

Thanks,

Peter

